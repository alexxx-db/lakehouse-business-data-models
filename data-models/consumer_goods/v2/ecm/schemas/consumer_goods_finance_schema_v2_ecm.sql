-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`finance` COMMENT 'Owns financial planning, accounting, and reporting including general ledger, accounts payable/receivable, cost accounting, COGS allocation, EBITDA reporting, DSO/DIO tracking, budgeting, revenue recognition, and SOX-compliant financial controls and audit trails. Integrates with SAP S/4HANA FI/CO and Oracle Cloud Financials.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key for the cost center master record in SAP S/4HANA CO module.',
    `company_code_id` BIGINT COMMENT 'The company code id of the cost center record',
    `controlling_area_id` BIGINT COMMENT 'The controlling area id of the cost center record',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Budgeting process assigns ESG commitments to responsible cost centers for cost allocation and reporting.',
    `profit_center_id` BIGINT COMMENT 'The profit center id of the cost center record',
    `activity_type_indicator` BOOLEAN COMMENT 'Flag indicating whether this cost center performs activity-based costing. True if the center provides measurable activities (e.g., machine hours, labor hours) that are allocated to cost objects.',
    `allocation_method` STRING COMMENT 'Method used for allocating costs from this cost center to other cost objects (products, profit centers). Critical for COGS calculation and overhead absorption.. Valid values are `direct|assessment|distribution|activity_based`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the cost center record',
    `budget_profile_code` STRING COMMENT 'Budget control profile defining budget planning rules, tolerance limits, and approval workflows for this cost center. Determines budget availability check behavior.. Valid values are `^[A-Z0-9]{4,8}$`',
    `business_area_code` STRING COMMENT 'Business area classification for code reporting. Represents a distinct line of business or product category (e.g., Personal Care, Home Care, Beauty) for consolidated financial analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_category` STRING COMMENT 'Accounting classification indicating whether costs are direct (attributable to products), indirect (supporting operations), overhead (administrative), or capital (asset-related). Critical for COGS calculation and financial reporting.. Valid values are `direct|indirect|overhead|capital`',
    `cost_center_code` STRING COMMENT 'Business identifier for the cost center. Alphanumeric code used across SAP S/4HANA FI/CO modules for financial accountability tracking. Typically follows organizational naming conventions (e.g., plant code + department code).. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_group` STRING COMMENT 'Logical grouping of cost centers for consolidated reporting and analysis. Enables flexible aggregation beyond standard hierarchy (e.g., all brand marketing centers, all R&D centers).',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active centers accept postings; inactive centers are closed; blocked centers are temporarily suspended; planned centers are approved but not yet operational.. Valid values are `active|inactive|blocked|planned`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by functional area. Determines the nature of costs tracked and reporting hierarchy. Used for COGS allocation and EBITDA segmentation. [ENUM-REF-CANDIDATE: production|sales|marketing|distribution|administration|research_development|quality_assurance|procurement|finance|shared_services — 10 candidates stripped; promote to reference product]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the cost center operates. Supports multi-country financial consolidation and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User ID of the person who created the cost center master record. Audit trail for SOX compliance and data governance.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cost center master record was created in the system. Audit trail for SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for cost center transactions. Defines the local currency for budget planning and actual cost recording.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Department or functional unit code within the organization. Provides granular classification for workforce planning and departmental cost analysis.. Valid values are `^[A-Z0-9]{3,6}$`',
    `cost_center_description` STRING COMMENT 'Extended description providing additional context about the cost centers purpose, scope, and responsibilities within the organization.',
    `effective_from` DATE COMMENT 'The effective from of the cost center record',
    `effective_until` DATE COMMENT 'The effective until of the cost center record',
    `functional_area_code` STRING COMMENT 'Functional area classification for cost-of-sales accounting. Distinguishes between manufacturing, sales, marketing, R&D, and administrative functions for COGS and operating expense allocation.. Valid values are `^[A-Z0-9]{4,6}$`',
    `hierarchy_area` STRING COMMENT 'Standard hierarchy assignment for organizational reporting. Defines the cost centers position in the corporate hierarchy tree for roll-up reporting and budget consolidation.. Valid values are `^[A-Z0-9]{4,8}$`',
    `hierarchy_node` STRING COMMENT 'The hierarchy node of the cost center record',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified the cost center master record. Audit trail for change tracking and SOX compliance.. Valid values are `^[A-Z0-9]{6,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cost center master record was last modified. Audit trail for change tracking and SOX compliance.',
    `location_code` STRING COMMENT 'Geographic location or site code for the cost center. Used for regional cost analysis and location-based reporting.. Valid values are `^[A-Z0-9]{4,8}$`',
    `lock_indicator` BOOLEAN COMMENT 'Flag indicating whether the cost center is locked for actual postings. Used during period-end close and organizational changes to prevent unintended transactions.',
    `cost_center_name` STRING COMMENT 'Full descriptive name of the cost center. Human-readable label identifying the organizational unit (e.g., Brand Marketing - North America, Manufacturing Plant 01 - Production Line A).',
    `notes` STRING COMMENT 'The notes of the cost center record',
    `parent_cost_center_code` STRING COMMENT 'Code of the parent cost center in the organizational hierarchy. Enables hierarchical roll-up of costs for management reporting and budget aggregation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center code associated with this cost center. Links production and logistics cost centers to physical facilities for COGS allocation.. Valid values are `^[A-Z0-9]{4}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the cost center record',
    `record_version` STRING COMMENT 'Version number of the cost center master record. Incremented with each modification to support change history tracking and optimistic locking.',
    `region_code` STRING COMMENT 'Geographic region classification (e.g., NOAM, EMEA, APAC, LATAM) for regional financial reporting and performance benchmarking.. Valid values are `^[A-Z0-9]{2,4}$`',
    `source_system_code` STRING COMMENT 'Identifier of the source ERP system from which this cost center record originated. Supports multi-system landscapes and data lineage tracking.. Valid values are `^[A-Z0-9]{3,6}$`',
    `statistical_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a statistical cost center used only for informational reporting without actual cost postings. Used for tracking non-financial metrics.',
    `uom` STRING COMMENT 'The uom of the cost center record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the cost center record',
    `valid_from_date` DATE COMMENT 'Date from which the cost center is valid and can accept cost postings. Supports time-dependent organizational changes and fiscal year transitions.',
    `valid_to_date` DATE COMMENT 'Date until which the cost center is valid. Nullable for open-ended cost centers. Used for organizational restructuring and cost center retirement.',
    `valid_from` DATE COMMENT 'The valid from of the cost center record',
    `valid_to` DATE COMMENT 'The valid to of the cost center record',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master record for organizational cost centers used in SAP S/4HANA CO module. Defines the financial accountability units within the CPG enterprise — brand units, manufacturing plants, regional sales offices, and shared service centers. Each cost center carries a hierarchy path, responsible manager, controlling area, profit center assignment, currency, and active period. Serves as the foundational dimension for all cost accounting, COGS allocation, and EBITDA reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for this entity representing an autonomous business segment within the consumer goods enterprise.',
    `company_code_id` BIGINT COMMENT 'The company code id of the profit center record',
    `controlling_area_id` BIGINT COMMENT 'The controlling area id of the profit center record',
    `parent_profit_center_id` BIGINT COMMENT 'Reference to the parent profit center in a hierarchical profit center structure. Enables roll-up reporting and EBITDA decomposition across organizational levels.',
    `address_line_1` STRING COMMENT 'Primary street address line for the profit centers physical or administrative location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or department information. Organizational contact data classified as confidential.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the profit center record',
    `brand_code` STRING COMMENT 'Brand identifier for brand-based profit centers. Enables brand-level P&L reporting and brand portfolio management.. Valid values are `^[A-Z0-9]{4,10}$`',
    `business_area_code` STRING COMMENT 'Business area code representing a -code organizational unit for segment reporting. Enables consolidated financial statements by business segment.. Valid values are `^[A-Z0-9]{4}$`',
    `channel_code` STRING COMMENT 'Sales channel classification for channel-based profit centers: retail, wholesale, e-commerce, direct-to-consumer (DTC), foodservice, or export.. Valid values are `retail|wholesale|ecommerce|dtc|foodservice|export`',
    `city` STRING COMMENT 'City name for the profit centers location. Organizational contact data classified as confidential.',
    `profit_center_code` STRING COMMENT 'Business identifier code for the profit center used in financial reporting and segment analysis. Externally-known unique code aligned with SAP S/4HANA CO-PCA master data.. Valid values are `^[A-Z0-9]{4,10}$`',
    `consolidation_unit_code` STRING COMMENT 'Code of the consolidation unit for. Links profit center to the financial consolidation hierarchy for IFRS/GAAP reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_group_code` STRING COMMENT 'Code of the cost center group associated with this profit center. Links profit center accounting to cost center accounting for overhead allocation and COGS calculation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the profit centers location. Organizational contact data classified as confidential.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the profit centers local reporting currency. Used for revenue and cost tracking before consolidation.. Valid values are `^[A-Z]{3}$`',
    `profit_center_description` STRING COMMENT 'Detailed textual description of the profit centers business scope, responsibilities, and strategic objectives.',
    `effective_from` DATE COMMENT 'The effective from of the profit center record',
    `effective_until` DATE COMMENT 'The effective until of the profit center record',
    `email_address` STRING COMMENT 'General email address for the profit center for business correspondence. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the profit center if applicable. Organizational contact data classified as confidential.',
    `functional_area_code` STRING COMMENT 'Functional area code representing the business function (e.g., production, sales, administration) for cost-of-sales accounting and functional P&L reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `geographic_region_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or region code representing the primary geographic location of the profit center for regional segment reporting.. Valid values are `^[A-Z]{3}$`',
    `hierarchy_level` STRING COMMENT 'Numeric level of this profit center within the organizational hierarchy. Level 1 represents top-level segments, with increasing numbers for deeper levels.',
    `hierarchy_node` STRING COMMENT 'The hierarchy node of the profit center record',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this profit center record. Audit trail for change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was last updated. Audit trail for record modifications.',
    `lock_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the profit center is locked for transaction postings. Used during period-end close and audit processes.',
    `profit_center_name` STRING COMMENT 'Full business name of the profit center representing the product line, brand, or geographic business unit.',
    `notes` STRING COMMENT 'The notes of the profit center record',
    `phone_number` STRING COMMENT 'Primary contact phone number for the profit center. Organizational contact data classified as confidential.',
    `planning_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this profit center participates in budgeting and financial planning processes.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the profit centers location. Organizational contact data classified as confidential.',
    `product_category_code` STRING COMMENT 'Product category or product line code associated with this profit center. Used for product-based segment reporting and portfolio analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center indicating whether it is operational, temporarily suspended, or permanently closed.. Valid values are `active|inactive|pending|closed|suspended`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by organizational dimension: product line, brand, geographic region, sales channel, or business unit. Determines the segment reporting structure.. Valid values are `product_line|brand|geography|channel|business_unit|cost_center`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the profit center record',
    `responsible_person_email` STRING COMMENT 'Email address of the profit center manager for financial reporting notifications and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_person_name` STRING COMMENT 'Name of the business leader or manager accountable for the profit centers financial performance and operational results.',
    `segment` STRING COMMENT 'The segment of the profit center record',
    `segment_code` STRING COMMENT 'Segment code for external segment reporting per IFRS 8 and US GAAP ASC 280. Represents reportable operating segments for investor disclosures.. Valid values are `^[A-Z0-9]{4,10}$`',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the profit center used in reports and dashboards for space-constrained displays.',
    `source_system_code` STRING COMMENT 'The source system code of the profit center record',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this profit center is subject to SOX financial controls and audit requirements for publicly traded companies.',
    `state_province_code` STRING COMMENT 'State or province code for the profit centers location. Organizational contact data classified as confidential.. Valid values are `^[A-Z]{2,3}$`',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code for the profit centers location. Used for tax reporting and compliance with local tax authorities.. Valid values are `^[A-Z0-9]{4,10}$`',
    `uom` STRING COMMENT 'The uom of the profit center record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the profit center record',
    `valid_from_date` DATE COMMENT 'Effective start date from which this profit center is active and available for transaction postings. Supports time-dependent organizational structures.',
    `valid_to_date` DATE COMMENT 'Effective end date after which this profit center is no longer active. Null value indicates an open-ended validity period.',
    `valuation_view` STRING COMMENT 'Valuation perspective for profit center accounting: legal (statutory), group (IFRS/GAAP consolidation), profit center (internal transfer pricing), or management (operational view).. Valid values are `legal|group|profit_center|management`',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master record for profit centers representing autonomous business segments within the consumer goods enterprise — product lines, brands, or geographic business units. Tracks revenue, cost, and profitability at a granular level below the legal entity. Integrates with SAP S/4HANA CO-PCA (Profit Center Accounting) and Oracle Cloud Financials for segment reporting and EBITDA decomposition.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account. Primary key for the GL account master data.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts framework to which this account belongs. Links to the chart_of_accounts master data.',
    `company_code_id` BIGINT COMMENT 'Reference to the company code (legal entity) to which this GL account belongs. Links to the company_code master data.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area for cost accounting and management reporting. Links to the controlling_area master data.',
    `account_group` STRING COMMENT 'The account group classification that controls field status, number ranges, and posting rules in the ERP system.',
    `account_name` STRING COMMENT 'The full descriptive name of the GL account as it appears in financial reports and statements.',
    `account_number` STRING COMMENT 'The externally-known unique account number in the chart of accounts. This is the business identifier used in financial postings and reporting.. Valid values are `^[0-9]{4,10}$`',
    `account_short_name` STRING COMMENT 'Abbreviated name or label for the GL account used in condensed reports and system displays.',
    `account_status` STRING COMMENT 'The current lifecycle status of the GL account: active (in use), inactive (not currently used but retained), pending approval (awaiting activation), or archived (historical only).. Valid values are `active|inactive|pending_approval|archived`',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the account: asset, liability, equity, revenue, expense, or statistical (non-monetary).. Valid values are `asset|liability|equity|revenue|expense|statistical`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the gl account record',
    `balance_sheet_classification` STRING COMMENT 'For balance sheet accounts, indicates whether the account is a current asset, non-current asset, current liability, non-current liability, or equity. Not applicable for P&L accounts.. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `balance_sheet_flag` BOOLEAN COMMENT 'The balance sheet flag of the gl account record',
    `balance_sheet_indicator` BOOLEAN COMMENT 'The balance sheet indicator of the gl account record',
    `blocked_for_posting` BOOLEAN COMMENT 'The blocked for posting of the gl account record',
    `blocked_for_posting_flag` BOOLEAN COMMENT 'Indicates whether the account is currently blocked for all postings. Used to prevent transactions to accounts that are under review, closed, or being restructured.',
    `budget_control_flag` BOOLEAN COMMENT 'Indicates whether budget availability checking is active for this account. When enabled, postings are validated against approved budgets.',
    `cash_flow_category` STRING COMMENT 'For accounts that impact cash flow, indicates the cash flow statement category: operating activities, investing activities, or financing activities. Not applicable for non-cash accounts.. Valid values are `operating|investing|financing|not_applicable`',
    `gl_account_code` STRING COMMENT 'The gl account code of the gl account record',
    `consolidation_account_number` STRING COMMENT 'The corresponding account number in the group consolidation chart of accounts. Used for mapping local accounts to structures.',
    `cost_center_required_flag` BOOLEAN COMMENT 'Indicates whether a cost center assignment is mandatory when posting to this account. Used for internal cost allocation and management reporting.',
    `cost_element_category` STRING COMMENT 'For accounts that are cost elements, indicates whether it is a primary cost element (direct posting from FI) or secondary cost element (internal allocation only). Not applicable if not a cost element.. Valid values are `primary|secondary|not_applicable`',
    `cost_element_flag` BOOLEAN COMMENT 'Indicates whether this GL account is also defined as a cost element in the Controlling (CO) module for cost center and internal order postings.',
    `created_by_user` STRING COMMENT 'The user ID of the person who created this GL account record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the accounts local currency. For multi-currency accounts, this is the primary reporting currency.. Valid values are `^[A-Z]{3}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the account normally carries a debit balance or credit balance in the general ledger.. Valid values are `debit|credit`',
    `gl_account_description` STRING COMMENT 'The gl account description of the gl account record',
    `effective_from` DATE COMMENT 'The effective from of the gl account record',
    `effective_until` DATE COMMENT 'The effective until of the gl account record',
    `field_status_group` STRING COMMENT 'The field status group that controls which fields are required, optional, or suppressed when posting to this account.',
    `financial_statement_category` STRING COMMENT 'The primary financial statement where this account appears: balance sheet, income statement (P&L), cash flow statement, retained earnings, or statistical.. Valid values are `balance_sheet|income_statement|cash_flow|retained_earnings|statistical`',
    `financial_statement_line_item` STRING COMMENT 'The specific line item or section within the financial statement where this account balance is reported (e.g., Current Assets, Cost of Goods Sold, Operating Expenses).',
    `gl_account_number` STRING COMMENT 'The gl account number of the gl account record',
    `gl_account_status` STRING COMMENT 'The gl account status of the gl account record',
    `intercompany_clearing_flag` BOOLEAN COMMENT 'Indicates whether this account is used for intercompany transactions that require clearing and elimination in consolidated financial statements.',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this GL account record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was last modified.',
    `line_item_display_flag` BOOLEAN COMMENT 'Indicates whether individual line item details are stored and can be displayed for this account. Required for detailed transaction analysis and audit trails.',
    `gl_account_name` STRING COMMENT 'The gl account name of the gl account record',
    `notes` STRING COMMENT 'The notes of the gl account record',
    `open_item_management_flag` BOOLEAN COMMENT 'Indicates whether this account uses open item management for tracking and clearing individual line items (e.g., AR, AP, bank clearing accounts).',
    `pl_category` STRING COMMENT 'For income statement accounts, indicates the P&L category: gross revenue, net revenue, COGS, gross margin, operating expense (SG&A, marketing, trade spend), EBITDA, EBIT, or net income. Not applicable for balance sheet accounts. [ENUM-REF-CANDIDATE: gross_revenue|net_revenue|cogs|gross_margin|operating_expense|ebitda|ebit|net_income|not_applicable — 9 candidates stripped; promote to reference product]',
    `pl_statement_flag` BOOLEAN COMMENT 'The pl statement flag of the gl account record',
    `planning_level` STRING COMMENT 'The organizational level at which budget planning and forecasting is performed for this account (e.g., company code, profit center, cost center).',
    `posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether direct postings are allowed to this account. Some accounts (e.g., summary or control accounts) may only accept postings from automated processes.',
    `profit_center_required_flag` BOOLEAN COMMENT 'Indicates whether a profit center assignment is mandatory when posting to this account. Used for segment reporting and profitability analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the gl account record',
    `reconciliation_account_flag` BOOLEAN COMMENT 'Indicates whether this is a reconciliation account (subledger control account) that summarizes detailed transactions from subsidiary ledgers such as AR, AP, or inventory.',
    `retained_earnings_account_flag` BOOLEAN COMMENT 'Indicates whether this is the retained earnings account where net income/loss is transferred during year-end closing.',
    `sort_key` STRING COMMENT 'The default sort key used for organizing and displaying line items within this account (e.g., posting date, document number, amount).',
    `source_system_code` STRING COMMENT 'The source system code of the gl account record',
    `sox_control_account_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to SOX internal control requirements and enhanced audit procedures.',
    `tax_category` STRING COMMENT 'The tax treatment category for this account (e.g., taxable revenue, non-taxable revenue, input tax, output tax, tax-exempt). Used for VAT, sales tax, and GST reporting.',
    `tax_code_allowed_flag` BOOLEAN COMMENT 'Indicates whether tax codes can be entered when posting to this account. Typically true for revenue and expense accounts, false for balance sheet accounts.',
    `uom` STRING COMMENT 'The uom of the gl account record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the gl account record',
    `valid_from_date` DATE COMMENT 'The date from which this GL account is valid and available for posting. Used for time-dependent account structures.',
    `valid_to_date` DATE COMMENT 'The date until which this GL account is valid. After this date, the account is no longer available for posting. Null indicates no end date.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger chart of accounts master for the consumer goods enterprise. Defines every account in the COA including P&L accounts (revenue, COGS, trade spend, marketing, SG&A), balance sheet accounts (inventory, AR, AP, fixed assets), and statistical accounts. Stores account type, financial statement category, tax category, reconciliation account flag, currency, and controlling relevance. Source of truth for all financial postings in SAP S/4HANA FI and Oracle Cloud Financials.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Unique identifier for the financial ledger record. Primary key for the ledger entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'FK to finance.chart_of_accounts',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ledger stewardship is tracked for consolidation control and audit; responsible employee must be recorded.',
    `accounting_principle` STRING COMMENT 'The accounting standard or principle applied in this ledger, such as International Financial Reporting Standards (IFRS), United States Generally Accepted Accounting Principles (US GAAP), local country-specific GAAP, tax accounting rules, or management accounting conventions.. Valid values are `IFRS|US_GAAP|local_GAAP|tax|management`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the ledger record',
    `audit_trail_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether comprehensive audit trail logging is enabled for all postings and changes to this ledger, supporting regulatory compliance and forensic analysis.',
    `base_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the base currency in which this ledger maintains balances (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `ledger_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the ledger within the enterprise. Used as the business identifier for the ledger in SAP S/4HANA FI and Oracle Cloud Financials.. Valid values are `^[A-Z0-9]{2,10}$`',
    `consolidation_ledger_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this ledger is used for group consolidation purposes, aggregating financial data from multiple legal entities for consolidated financial statements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp recording when this ledger record was first created in the system. Part of the audit trail for ledger lifecycle management.',
    `currency_code` STRING COMMENT 'The currency code of the ledger record',
    `currency_type` STRING COMMENT 'Defines the currency perspective maintained in this ledger. Local currency represents the operating entitys functional currency, group currency is the consolidated reporting currency, hard currency is a stable reference currency (e.g., USD, EUR), and index currency supports inflation-adjusted reporting.. Valid values are `local|group|hard|index`',
    `ledger_description` STRING COMMENT 'Detailed textual description of the ledgers purpose, scope, and usage within the enterprise financial reporting architecture. Provides context for finance users and auditors.',
    `effective_end_date` DATE COMMENT 'The date on which this ledger ceases to be active and no longer accepts financial postings. Null for ledgers with indefinite validity.',
    `effective_from` DATE COMMENT 'The effective from of the ledger record',
    `effective_start_date` DATE COMMENT 'The date from which this ledger becomes active and begins accepting financial postings. Supports temporal validity for ledger lifecycle management.',
    `effective_until` DATE COMMENT 'The effective until of the ledger record',
    `fiscal_year_variant` STRING COMMENT 'Code identifying the fiscal year calendar structure used by this ledger, defining the number of posting periods, special periods, and year-end closing rules. Common in SAP S/4HANA FI to support diverse fiscal calendars across global entities.. Valid values are `^[A-Z0-9]{2,4}$`',
    `is_leading_ledger` BOOLEAN COMMENT 'Boolean flag indicating whether this is the leading ledger (primary book of record) for the company code. Only one ledger per company code can be designated as the leading ledger.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this ledger record. Supports change tracking and audit trail for ledger configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp recording when this ledger record was last modified. Enables change tracking and supports audit trail requirements for financial system configuration.',
    `leading_ledger_flag` BOOLEAN COMMENT 'The leading ledger flag of the ledger record',
    `ledger_status` STRING COMMENT 'Current operational status of the ledger. Active ledgers accept postings, inactive ledgers are configured but not yet in use, closed ledgers are archived and no longer accept postings, and suspended ledgers are temporarily disabled.. Valid values are `active|inactive|closed|suspended`',
    `ledger_type` STRING COMMENT 'Classification of the ledger indicating its role in the financial reporting architecture. Leading ledger is the primary book of record, parallel ledgers support alternative accounting principles (e.g., local GAAP), and extension ledgers provide management reporting views.. Valid values are `leading|parallel|extension`',
    `ledger_name` STRING COMMENT 'Full descriptive name of the ledger for human-readable identification and reporting purposes.',
    `notes` STRING COMMENT 'The notes of the ledger record',
    `posting_period_variant` STRING COMMENT 'Code defining the posting period structure for this ledger, including the number of regular periods (typically 12 monthly periods) and special periods for year-end adjustments and closing entries.. Valid values are `^[A-Z0-9]{2,4}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the ledger record',
    `retention_period_years` STRING COMMENT 'Number of years that financial data in this ledger must be retained to comply with statutory, tax, and regulatory record-keeping requirements. Common retention periods range from 7 to 10 years for financial records.',
    `source_system_code` STRING COMMENT 'The source system code of the ledger record',
    `sox_compliant_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this ledger maintains controls and audit trails compliant with Sarbanes-Oxley Act Section 404 requirements for internal controls over financial reporting.',
    `supports_cost_of_sales_accounting` BOOLEAN COMMENT 'Boolean flag indicating whether this ledger supports cost of sales (COGS) accounting method, which matches costs directly to revenue in the period of sale, as opposed to period-based cost accounting.',
    `supports_profit_center_accounting` BOOLEAN COMMENT 'Boolean flag indicating whether this ledger maintains profit center accounting data for internal management reporting and profitability analysis by organizational unit.',
    `supports_segment_reporting` BOOLEAN COMMENT 'Boolean flag indicating whether this ledger supports segment reporting as required by IFRS 8 Operating Segments. Segment reporting enables financial analysis by business unit, product line, or geographic region.',
    `uom` STRING COMMENT 'The uom of the ledger record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the ledger record',
    `valuation_view` STRING COMMENT 'Defines the valuation perspective applied in this ledger. Legal valuation follows statutory requirements, group valuation applies consolidated group policies, profit center valuation supports internal management reporting, and cost center valuation tracks cost allocation.. Valid values are `legal|group|profit_center|cost_center`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this ledger record in the system. Supports audit trail and accountability for ledger configuration changes.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'Financial ledger master defining the accounting ledgers maintained in the enterprise — leading ledger (IFRS/GAAP), parallel ledgers for local GAAP, and extension ledgers for management reporting. Each ledger record captures ledger type, accounting principle, currency type, fiscal year variant, and posting period variant. Supports multi-GAAP reporting requirements common in global CPG companies operating across multiple regulatory jurisdictions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry header.',
    `company_code_id` BIGINT COMMENT 'The company code id of the journal entry record',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center to which costs or revenues from this journal entry are allocated. Used for management accounting and EBITDA reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entries reference GL accounts by code; adding gl_account_id FK normalizes the relationship and removes the redundant code column.',
    `employee_id` BIGINT COMMENT 'The journal posted by employee id of the journal entry record',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Journal entries belong to a specific ledger; adding ledger_id FK links each entry to its ledger without removing existing ledger_group (kept for reporting).',
    `primary_journal_employee_id` BIGINT COMMENT 'User ID of the person who posted or created this journal entry. Critical for SOX compliance and audit trail. Confidential business information.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center for segment reporting and profitability analysis. Used for EBITDA calculation by business unit.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: R&D expense tracking mandates associating journal entries with the originating RD project for cost accounting and project profitability reporting.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the journal entry record',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the journal entry was approved. Part of the SOX-compliant audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `baseline_payment_date` DATE COMMENT 'The baseline date used for calculating payment terms and due dates for vendor invoices and customer receivables. Format: yyyy-MM-dd.',
    `batch_input_session` STRING COMMENT 'Identifier of the batch input session if this journal entry was created through automated batch processing. Used for tracking mass data uploads and interface postings.',
    `business_area_code` STRING COMMENT 'Code representing the business area or division for code reporting. Used for consolidated financial statements.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'The date on which this open item was cleared. Used for DSO and DIO calculation. Format: yyyy-MM-dd.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing document if this open item has been cleared (paid or offset). Used for accounts payable and receivable reconciliation.',
    `journal_entry_code` STRING COMMENT 'The journal entry code of the journal entry record',
    `controlling_area` STRING COMMENT 'Organizational unit in management accounting that represents a closed system for cost accounting. Used for internal management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry record was first created in the system. Part of the audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the document currency in which the journal entry amounts are denominated. Examples: USD, EUR, GBP, JPY.. Valid values are `^[A-Z]{3}$`',
    `journal_entry_description` STRING COMMENT 'The journal entry description of the journal entry record',
    `document_date` DATE COMMENT 'The date printed on the source document (invoice, receipt, payment voucher). May differ from posting date. Used for document control and audit trail. Format: yyyy-MM-dd.',
    `document_number` STRING COMMENT 'Unique alphanumeric identifier assigned to the accounting document within the company code and fiscal year. This is the externally visible business key for the journal entry.. Valid values are `^[A-Z0-9]{10}$`',
    `document_type` STRING COMMENT 'Classification code indicating the nature and source of the journal entry. Examples: SA (General Ledger Document), AB (Accounting Document), KR (Vendor Invoice), DR (Customer Invoice), DZ (Customer Payment), KA (Vendor Payment), KG (Vendor Credit Memo), KN (Customer Credit Memo), KZ (Payment Request), RE (Invoice Receipt), RV (Invoice Reversal), WA (Goods Issue), WE (Goods Receipt), ZP (Payment Posting). [ENUM-REF-CANDIDATE: SA|AB|KR|DR|DZ|KA|KG|KN|KZ|RE|RV|WA|WE|ZP — 14 candidates stripped; promote to reference product]',
    `effective_from` DATE COMMENT 'The effective from of the journal entry record',
    `effective_until` DATE COMMENT 'The effective until of the journal entry record',
    `entry_date` DATE COMMENT 'The date on which the journal entry was created or entered into the system. Used for audit trail and process monitoring. Format: yyyy-MM-dd.',
    `entry_status` STRING COMMENT 'The entry status of the journal entry record',
    `entry_type` STRING COMMENT 'The entry type of the journal entry record',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert document currency amounts to local currency. Expressed as local currency per one unit of document currency. Null if document currency equals local currency.',
    `exchange_rate_type` STRING COMMENT 'Code indicating the type of exchange rate used for currency translation. Examples: M (Average Rate), B (Bank Buying Rate), G (Bank Selling Rate), P (Posting Date Rate).. Valid values are `M|B|G|P`',
    `fiscal_period` STRING COMMENT 'Numeric period within the fiscal year (typically 1-12 for monthly periods, or 1-13 for year-end adjustments). Determines the reporting period for financial statements.',
    `fiscal_year` STRING COMMENT 'Four-digit year representing the fiscal year to which this journal entry is assigned. Used for period-based financial reporting and year-end closing.',
    `functional_area_code` STRING COMMENT 'Code classifying the journal entry by functional area (e.g., Production, Sales, Administration, R&D). Used for cost of goods sold (COGS) allocation and functional expense reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `header_text` STRING COMMENT 'Free-form text field for additional information or explanation about the journal entry. Used for documentation and audit purposes.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry involves intercompany transactions between different company codes within the enterprise. True if intercompany, False otherwise.',
    `journal_entry_number` STRING COMMENT 'The journal entry number of the journal entry record',
    `journal_entry_status` STRING COMMENT 'The journal entry status of the journal entry record',
    `ledger_group` STRING COMMENT 'Two-character code identifying the ledger or accounting principle under which this entry is recorded. Examples: 0L (Leading Ledger - IFRS), 2L (Local GAAP), 3L (Management Reporting). Supports parallel accounting for multiple reporting standards.. Valid values are `^[A-Z0-9]{2}$`',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the company code local currency. All amounts are translated to this currency for statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry record was last modified. Part of the audit trail for tracking changes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `journal_entry_name` STRING COMMENT 'The journal entry name of the journal entry record',
    `notes` STRING COMMENT 'The notes of the journal entry record',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms applicable to this document (e.g., Net 30, 2/10 Net 30). Used for cash flow forecasting and DSO tracking.. Valid values are `^[A-Z0-9]{4}$`',
    `posted_by` STRING COMMENT 'The posted by of the journal entry record',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger. This is the effective date for financial reporting and determines the fiscal period assignment. Format: yyyy-MM-dd.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry. Values: draft (entry created but not posted), posted (entry successfully posted to GL), parked (entry saved for later posting), cancelled (entry voided before posting), reversed (entry reversed by a subsequent document).. Valid values are `draft|posted|parked|cancelled|reversed`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the journal entry record',
    `reference_document_number` STRING COMMENT 'External reference number from the source document (invoice number, purchase order number, payment reference). Used for cross-referencing and reconciliation.',
    `reversal_flag` BOOLEAN COMMENT 'The reversal flag of the journal entry record',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a previous entry. True if this is a reversal document, False otherwise.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing the original document. Examples: 01 (Reversal in Current Period), 02 (Reversal in Next Period), 03 (Correction), 04 (Accrual Reversal), 05 (Error Correction), 06 (Period-End Adjustment). [ENUM-REF-CANDIDATE: 01|02|03|04|05|06|07|08|09 — promote to reference product]. Valid values are `01|02|03|04|05|06`',
    `reversed_document_number` STRING COMMENT 'Document number of the original journal entry that is being reversed by this entry. Populated only when reversal_indicator is True.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this journal entry originated. Examples: SAP_FI (SAP S/4HANA Financial Accounting), SAP_CO (SAP Controlling), ORACLE_GL (Oracle Cloud General Ledger), ORACLE_AP (Oracle Accounts Payable), ORACLE_AR (Oracle Accounts Receivable), SFDC (Salesforce), WMS (Warehouse Management System), MES (Manufacturing Execution System). [ENUM-REF-CANDIDATE: SAP_FI|SAP_CO|ORACLE_GL|ORACLE_AP|ORACLE_AR|SFDC|WMS|MES — 8 candidates stripped; promote to reference product]',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is subject to SOX internal control testing and audit procedures. True if SOX-controlled, False otherwise.',
    `tax_reporting_date` DATE COMMENT 'The date relevant for tax reporting purposes. May differ from posting date based on tax jurisdiction rules. Format: yyyy-MM-dd.',
    `total_credit` DECIMAL(18,2) COMMENT 'The total credit of the journal entry record',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The total credit amount of the journal entry record',
    `total_debit` DECIMAL(18,2) COMMENT 'The total debit of the journal entry record',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'The total debit amount of the journal entry record',
    `trading_partner_company_code` STRING COMMENT 'Company code of the intercompany trading partner if this is an intercompany transaction. Used for consolidation and elimination entries. Null if not an intercompany transaction.. Valid values are `^[A-Z0-9]{4}$`',
    `transaction_code` STRING COMMENT 'SAP transaction code or Oracle program identifier used to create this journal entry. Examples: FB01 (Post Document), FB50 (G/L Account Posting), MIRO (Enter Invoice), F-28 (Post Incoming Payments). Used for audit trail and process analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `uom` STRING COMMENT 'The uom of the journal entry record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the journal entry record',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core general ledger journal entry header capturing every financial posting in the consumer goods enterprise. Records document type (vendor invoice, customer payment, goods issue, payroll posting, accrual, reversal), posting date, fiscal period, company code, ledger, currency, exchange rate, reference document, and SOX-compliant posting user and approval chain. The authoritative transactional record for all financial activity sourced from SAP S/4HANA FI and Oracle Cloud Financials.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for granular cost allocation, COGS decomposition, and SOX-compliant audit trail tracing at the line level.',
    `cost_center_id` BIGINT COMMENT 'The cost center id of the journal entry line record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry lines store GL account code; FK to gl_account enables proper account lookup and eliminates duplicate code.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header document. Links this line to the overall journal entry batch and posting context.',
    `profit_center_id` BIGINT COMMENT 'The profit center id of the journal entry line record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the journal entry line record',
    `amount_company_code_currency` DECIMAL(18,2) COMMENT 'Monetary amount converted to the local currency of the company code. Used for statutory reporting and local GAAP compliance.',
    `amount_group_currency` DECIMAL(18,2) COMMENT 'Monetary amount converted to the currency. Enables consolidated financial reporting across all subsidiaries.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'Monetary amount of this line item in the original transaction currency. Preserves the original posting amount before currency conversion.',
    `assignment_field` STRING COMMENT 'Free-text assignment field for additional reference information such as invoice number, purchase order, or payment reference. Enhances traceability.',
    `baseline_payment_date` DATE COMMENT 'Baseline date for payment terms calculation. Used to compute due dates and cash discount periods.',
    `business_area_code` STRING COMMENT 'Business area classification for code segment reporting. Enables consolidated financial statements by business segment.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'Date on which this open item was cleared or settled. Null if the item remains open.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing entry that settled this open item. Null if the item remains open.. Valid values are `^[A-Z0-9]{10}$`',
    `journal_entry_line_code` STRING COMMENT 'The journal entry line code of the journal entry line record',
    `company_code` STRING COMMENT 'Legal entity identifier representing the company or subsidiary for which this line is posted. Enables consolidated and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the company code local currency. Typically the statutory reporting currency of the legal entity.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the journal entry line record',
    `currency_code` STRING COMMENT 'The currency code of the journal entry line record',
    `customer_account_number` STRING COMMENT 'Customer account number for revenue and receivables postings. Links financial transactions to customer master data.. Valid values are `^[A-Z0-9]{8,10}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line is a debit (D) or credit (C) posting. Fundamental to double-entry bookkeeping and account balance calculation.. Valid values are `D|C`',
    `journal_entry_line_description` STRING COMMENT 'The journal entry line description of the journal entry line record',
    `document_amount` DECIMAL(18,2) COMMENT 'The document amount of the journal entry line record',
    `due_date` DATE COMMENT 'Date by which payment is due for payables or expected for receivables. Critical for DSO and cash flow management.',
    `effective_from` DATE COMMENT 'The effective from of the journal entry line record',
    `effective_until` DATE COMMENT 'The effective until of the journal entry line record',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert transaction currency to company code or group currency. Critical for currency translation audit trail.',
    `functional_area_code` STRING COMMENT 'Functional area classification (e.g., production, sales, administration, R&D). Supports cost-of-sales accounting and functional expense reporting.. Valid values are `^[A-Z0-9]{4,8}$`',
    `group_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the currency. Typically USD or EUR for consumer goods companies.. Valid values are `^[A-Z]{3}$`',
    `internal_order_number` STRING COMMENT 'Internal order for tracking costs of short-term jobs, events, or overhead activities. Enables job costing and overhead allocation.. Valid values are `^[A-Z0-9]{8,12}$`',
    `journal_entry_line_status` STRING COMMENT 'The journal entry line status of the journal entry line record',
    `line_item_number` STRING COMMENT 'Sequential line number within the journal entry header. Determines the ordering and position of this line in the document.',
    `line_number` STRING COMMENT 'The line number of the journal entry line record',
    `line_text` STRING COMMENT 'The line text of the journal entry line record',
    `local_amount` DECIMAL(18,2) COMMENT 'The local amount of the journal entry line record',
    `material_number` STRING COMMENT 'Material or SKU associated with this line item for inventory and COGS postings. Links financial postings to product master data.. Valid values are `^[A-Z0-9]{8,18}$`',
    `journal_entry_line_name` STRING COMMENT 'The journal entry line name of the journal entry line record',
    `notes` STRING COMMENT 'The notes of the journal entry line record',
    `payment_terms_code` STRING COMMENT 'Payment terms applicable to this line item. Determines due date calculation and cash discount eligibility.. Valid values are `^[A-Z0-9]{4}$`',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center associated with this line item. Supports plant-level cost accounting and inventory management.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_key` STRING COMMENT 'Two-digit posting key controlling account type, debit/credit indicator, and field status. Fundamental to SAP FI posting logic.. Valid values are `^[0-9]{2}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material or units associated with this line item. Enables unit cost calculation and inventory valuation.',
    `reference_document_number` STRING COMMENT 'External or internal document number referenced by this line (e.g., invoice, purchase order, contract). Supports document linkage and reconciliation.. Valid values are `^[A-Z0-9]{8,16}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item is a reversal of a previous posting. True if this is a reversal entry.',
    `reversed_document_number` STRING COMMENT 'Document number of the original entry that this line reverses. Null if this is not a reversal.. Valid values are `^[A-Z0-9]{10}$`',
    `source_system_code` STRING COMMENT 'The source system code of the journal entry line record',
    `special_gl_indicator` STRING COMMENT 'Special GL indicator for down payments, bills of exchange, guarantees, or other special transactions. Enables special ledger processing.. Valid values are `^[A-Z]$`',
    `storage_location_code` STRING COMMENT 'Storage location within the plant for inventory-related postings. Enables warehouse-level inventory tracking and valuation.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for this line item in transaction currency. Supports VAT, sales tax, and other indirect tax reporting.',
    `tax_code` STRING COMMENT 'Tax code determining the tax treatment of this line item. Drives automatic tax calculation and tax reporting compliance.. Valid values are `^[A-Z0-9]{2,4}$`',
    `text_description` STRING COMMENT 'Descriptive text explaining the nature or purpose of this journal entry line. Provides human-readable context for audit and review.',
    `trading_partner_code` STRING COMMENT 'Identifier of the intercompany trading partner for intercompany transactions. Enables intercompany reconciliation and elimination entries.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction amount. Identifies the currency in which the original transaction was denominated.. Valid values are `^[A-Z]{3}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field (e.g., EA, KG, LT). Standardizes quantity representation across transactions.. Valid values are `^[A-Z]{2,3}$`',
    `uom` STRING COMMENT 'The uom of the journal entry line record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the journal entry line record',
    `value_date` DATE COMMENT 'Value date for cash management and bank reconciliation. Represents the effective date for interest calculation and cash position.',
    `vendor_account_number` STRING COMMENT 'Vendor account number for procurement and payables postings. Links financial transactions to vendor master data.. Valid values are `^[A-Z0-9]{8,10}$`',
    `wbs_element_code` STRING COMMENT 'WBS element for project-related postings. Links costs and revenues to specific projects, phases, or deliverables in project accounting.. Valid values are `^[A-Z0-9-]{8,24}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual line items of a general ledger journal entry. Each line captures the GL account, cost center, profit center, WBS element, business area, debit/credit indicator, amount in transaction currency, amount in company code currency, amount in group currency, tax code, and assignment field. Enables granular cost allocation, COGS decomposition, and audit trail tracing at the line level as required by SOX compliance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts receivable invoice record. Primary key for the AR invoice entity.',
    `company_code_id` BIGINT COMMENT 'The company code id of the ar invoice record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR invoices reference GL accounts by code; adding FK normalizes accounting data.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: AR invoice reconciliation process matches each AR invoice to the originating sales invoice for cash application.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account (customer) to whom this invoice was issued. Links to the customer master record.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the ar invoice record',
    `amount_received` DECIMAL(18,2) COMMENT 'Total amount received from the customer against this invoice. May be less than total amount due to partial payments or deductions. Null for unpaid invoices.',
    `ar_invoice_number` STRING COMMENT 'The ar invoice number of the ar invoice record',
    `ar_invoice_status` STRING COMMENT 'The ar invoice status of the ar invoice record',
    `billing_date` DATE COMMENT 'Date when the invoice was created and issued to the customer. Principal business event timestamp for the invoice lifecycle.',
    `billing_document_type` STRING COMMENT 'SAP billing document type code indicating the nature of the invoice (e.g., F2=standard invoice, G2=credit memo, L2=debit memo). Determines accounting treatment and revenue recognition.. Valid values are `^[A-Z0-9]{2,4}$`',
    `clearing_date` DATE COMMENT 'Date when the invoice was cleared in the financial system, either through full payment or write-off. Null for open invoices.',
    `clearing_reference` STRING COMMENT 'Reference number assigned when the invoice is cleared in the financial system. Links to the clearing document for audit trail. Null for open invoices.. Valid values are `^[A-Z0-9]{0,20}$`',
    `ar_invoice_code` STRING COMMENT 'The ar invoice code of the ar invoice record',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the invoice record was first created in the AR system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). Critical for multi-currency reporting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Total amount of deductions taken by the customer against this invoice. Includes short-payments, chargebacks, and unauthorized deductions requiring resolution.',
    `deduction_reason_code` STRING COMMENT 'Code indicating the reason for customer deductions (e.g., pricing dispute, damaged goods, short shipment, promotional allowance). Used for deduction root cause analysis.. Valid values are `^[A-Z0-9]{0,10}$`',
    `ar_invoice_description` STRING COMMENT 'The ar invoice description of the ar invoice record',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the invoice is currently under dispute by the customer. True if disputed, false otherwise. Disputed invoices are excluded from standard collection processes.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason the customer is disputing the invoice. Used for dispute resolution and root cause analysis.',
    `distribution_channel` STRING COMMENT 'Channel through which the goods were sold (e.g., retail, wholesale, DTC, e-commerce). Used for channel profitability analysis.. Valid values are `^[A-Z0-9]{2}$`',
    `dso_aging_bucket` STRING COMMENT 'Aging category based on number of days the invoice has been outstanding past the due date. Used for DSO reporting, collections prioritization, and bad debt provisioning.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days|over_120_days`',
    `due_date` DATE COMMENT 'Date by which payment is expected from the customer based on agreed payment terms. Used for Days Sales Outstanding (DSO) calculation and dunning.',
    `dunning_level` STRING COMMENT 'Current dunning level indicating the escalation stage of collection efforts (0=no dunning, 1=first reminder, 2=second reminder, etc.). Higher levels indicate more aggressive collection actions.',
    `effective_from` DATE COMMENT 'The effective from of the ar invoice record',
    `effective_until` DATE COMMENT 'The effective until of the ar invoice record',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the invoice was posted. Used for monthly financial reporting and trend analysis.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the invoice was posted. Used for year-over-year financial analysis and annual reporting.',
    `gl_posting_date` DATE COMMENT 'Date when the invoice was posted to the general ledger. Used for financial period assignment and month-end close processes.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before any trade discounts, deductions, or adjustments. Represents the full billed value of goods or services.',
    `invoice_date` DATE COMMENT 'The invoice date of the ar invoice record',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice number assigned by the billing system. Used for customer communication and payment reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts receivable process. Tracks progression from open through payment to clearing or write-off. [ENUM-REF-CANDIDATE: open|partially_paid|paid|cleared|written_off|disputed|cancelled — 7 candidates stripped; promote to reference product]',
    `last_dunning_date` DATE COMMENT 'Date when the most recent dunning notice was sent to the customer. Used to track collection activity frequency and determine next dunning action.',
    `modified_by_user` STRING COMMENT 'User ID of the person who last modified the invoice record. Required for SOX compliance and segregation of duties controls.. Valid values are `^[A-Z0-9]{0,12}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the invoice record was last modified. Used for change tracking and SOX compliance audit trails.',
    `ar_invoice_name` STRING COMMENT 'The ar invoice name of the ar invoice record',
    `net_amount` DECIMAL(18,2) COMMENT 'Invoice amount after trade discounts but before tax. This is the base amount subject to taxation and the primary value for revenue recognition.',
    `notes` STRING COMMENT 'The notes of the ar invoice record',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'The outstanding amount of the ar invoice record',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Calculated as total amount minus amount received. Zero when invoice is fully paid or cleared.',
    `payment_date` DATE COMMENT 'Date when payment was received from the customer. Null for unpaid invoices. Used for DSO calculation and cash flow analysis.',
    `payment_method` STRING COMMENT 'Method by which the customer is expected to remit payment. Used for cash application automation and payment reconciliation.. Valid values are `wire_transfer|ach|check|credit_card|edi_payment|direct_debit`',
    `payment_status` STRING COMMENT 'The payment status of the ar invoice record',
    `payment_terms` STRING COMMENT 'The payment terms of the ar invoice record',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the customer (e.g., Net 30, Net 60, 2/10 Net 30). Determines due date calculation and early payment discount eligibility.. Valid values are `^[A-Z0-9]{2,10}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the ar invoice record',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue from this invoice is recognized in the financial statements under ASC 606/IFRS 15. May differ from billing date based on performance obligation fulfillment.',
    `sales_order_number` STRING COMMENT 'Reference to the originating sales order that generated this invoice. Links invoice to order fulfillment and enables order-to-cash traceability.. Valid values are `^[A-Z0-9]{0,20}$`',
    `sales_organization` STRING COMMENT 'SAP sales organization responsible for the sale. Used for sales performance reporting and commission calculation.. Valid values are `^[A-Z0-9]{4}$`',
    `shipment_number` STRING COMMENT 'Reference to the shipment or delivery document associated with this invoice. Links billing to physical goods movement for OTIF tracking.. Valid values are `^[A-Z0-9]{0,20}$`',
    `source_system_code` STRING COMMENT 'The source system code of the ar invoice record',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice, including sales tax, VAT, GST, or other applicable indirect taxes based on jurisdiction.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final invoice amount including all discounts and taxes. This is the total amount due from the customer and the target for cash application.',
    `trade_discount_amount` DECIMAL(18,2) COMMENT 'Total trade discounts applied to the invoice, including volume discounts, promotional allowances, and negotiated rebates. Reduces gross amount to net amount.',
    `uom` STRING COMMENT 'The uom of the ar invoice record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the ar invoice record',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as uncollectible bad debt. Null for invoices not written off. Impacts bad debt expense and allowance for doubtful accounts.',
    `write_off_date` DATE COMMENT 'Date when the invoice or portion thereof was written off as uncollectible. Null for invoices not written off.',
    `write_off_reason_code` STRING COMMENT 'Code indicating the reason for write-off (e.g., customer bankruptcy, uncollectible, small balance write-off). Used for bad debt analysis and credit policy refinement.. Valid values are `^[A-Z0-9]{0,10}$`',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable master record representing the full trade receivable lifecycle for consumer goods sales to retailers, distributors, and wholesalers. Owns invoice creation, payment terms, cash receipt application, partial payments, deductions/short-payments, clearing, and write-offs. Captures invoice number, billing date, due date, payment terms, gross amount, trade discounts, net amount, tax, currency, payment method, payment date, amount received, clearing reference, DSO aging bucket, dunning level, and deduction reason codes. The single source of truth for all receivable balances, cash application, deduction management, DSO tracking, cash flow forecasting, and revenue recognition under ASC 606/IFRS 15. Integrates with SAP S/4HANA SD billing and FI-AR.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` (
    `ar_payment_id` BIGINT COMMENT 'Unique identifier for the accounts receivable payment record. Primary key.',
    `ar_invoice_id` BIGINT COMMENT 'The ar invoice id of the ar payment record',
    `bank_account_id` BIGINT COMMENT 'The bank account id of the ar payment record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR payments store GL account code; FK to gl_account consolidates GL reference.',
    `invoice_id` BIGINT COMMENT 'Reference to the AR invoice being paid. Links payment to the originating billing document.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade customer making the payment. Identifies the payer account.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the ar payment record',
    `applied_amount` DECIMAL(18,2) COMMENT 'Amount of payment applied to the invoice after deductions and adjustments. Net amount reducing accounts receivable balance.',
    `ar_payment_number` STRING COMMENT 'The ar payment number of the ar payment record',
    `ar_payment_status` STRING COMMENT 'The ar payment status of the ar payment record',
    `bank_reference_number` STRING COMMENT 'Bank transaction reference or confirmation number. Used for bank statement reconciliation and audit trail.. Valid values are `^[A-Z0-9]{6,30}$`',
    `business_area_code` STRING COMMENT 'Business area or division code for segment reporting. Used for internal management reporting and EBITDA analysis by business unit.. Valid values are `^[A-Z0-9]{4}$`',
    `check_number` STRING COMMENT 'Check number when payment method is check. Used for check reconciliation and fraud prevention.. Valid values are `^[0-9]{4,12}$`',
    `clearing_document_number` STRING COMMENT 'SAP clearing document number generated when payment is applied to open invoice. Used for financial reconciliation and audit.. Valid values are `^[A-Z0-9]{8,20}$`',
    `ar_payment_code` STRING COMMENT 'The ar payment code of the ar payment record',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity receiving the payment. Used for multi-entity financial consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'Cost center code for payment allocation. Used when payment processing costs need to be tracked by organizational unit.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_by_user` STRING COMMENT 'User ID of the person or system that created the payment record. Used for SOX compliance and audit trail.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The currency code of the ar payment record',
    `days_to_pay` STRING COMMENT 'Number of days between invoice date and payment date. Key metric for Days Sales Outstanding (DSO) calculation and customer payment behavior analysis.',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Total amount of deductions taken by customer from the payment. Includes trade promotions, allowances, damages, and short payments.',
    `deduction_notes` STRING COMMENT 'Free-text notes explaining the deduction or short payment. Captures customer explanation and internal investigation details.',
    `deduction_reason_code` STRING COMMENT 'Reason code for customer deduction. Used for deduction management, dispute resolution, and root cause analysis. [ENUM-REF-CANDIDATE: trade_promotion|pricing_dispute|quantity_shortage|damaged_goods|quality_issue|freight_claim|administrative_error|unauthorized — 8 candidates stripped; promote to reference product]',
    `ar_payment_description` STRING COMMENT 'The ar payment description of the ar payment record',
    `discount_amount` DECIMAL(18,2) COMMENT 'Cash discount or early payment discount amount taken by customer. Typically based on payment terms (e.g., 2/10 net 30).',
    `due_date` DATE COMMENT 'Original invoice due date. Used to determine if payment is on-time, early, or late for DSO and aging analysis.',
    `edi_transaction_set_reference` STRING COMMENT 'EDI 820 transaction set control number when payment received via EDI. Used for EDI reconciliation and compliance.. Valid values are `^[A-Z0-9]{9,20}$`',
    `effective_from` DATE COMMENT 'The effective from of the ar payment record',
    `effective_until` DATE COMMENT 'The effective until of the ar payment record',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert payment currency to local currency. Used when payment currency differs from invoice or local currency.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) when payment was posted. Used for monthly financial close and period-based reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year when payment was posted. Used for period-based financial reporting and year-over-year analysis.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to company local currency using the exchange rate. Used for consolidated financial reporting.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the company local currency. Used for financial reporting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `lockbox_batch_number` STRING COMMENT 'Lockbox batch identifier when payment received through bank lockbox service. Used for lockbox reconciliation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `modified_by_user` STRING COMMENT 'User ID of the person or system that last modified the payment record. Used for SOX compliance and audit trail.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was last modified. Used for audit trail and change tracking.',
    `ar_payment_name` STRING COMMENT 'The ar payment name of the ar payment record',
    `notes` STRING COMMENT 'The notes of the ar payment record',
    `overpayment_flag` BOOLEAN COMMENT 'Indicates whether payment amount exceeds the invoice balance. True if customer paid more than owed.',
    `partial_payment_flag` BOOLEAN COMMENT 'Indicates whether this is a partial payment against the invoice. True if payment amount is less than invoice balance.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total amount received in the payment transaction, in the payment currency. Gross payment before any deductions or adjustments.',
    `payment_channel` STRING COMMENT 'Channel through which payment was received. Distinguishes interface from payment instrument.. Valid values are `online_portal|mobile_app|edi_820|bank_transfer|lockbox|manual_entry`',
    `payment_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the payment amount. Identifies the currency in which payment was received.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'Date when the payment was received or posted. Used for Days Sales Outstanding (DSO) calculation and cash flow analysis.',
    `payment_document_number` STRING COMMENT 'External payment document number or reference provided by the customer or payment processor. Used for reconciliation and audit trail.. Valid values are `^[A-Z0-9]{8,20}$`',
    `payment_method` STRING COMMENT 'Method or instrument used for payment. Includes ACH (Automated Clearing House), wire transfer, check, credit card, debit card, or EFT.. Valid values are `ACH|wire_transfer|check|credit_card|debit_card|electronic_funds_transfer`',
    `payment_processor_code` STRING COMMENT 'Transaction identifier from third-party payment processor (e.g., Stripe, PayPal, Adyen). Used for processor reconciliation.. Valid values are `^[A-Z0-9]{6,30}$`',
    `payment_reference` STRING COMMENT 'The payment reference of the ar payment record',
    `payment_status` STRING COMMENT 'Current status of the payment in the cash application workflow. Tracks payment lifecycle from receipt through clearing. [ENUM-REF-CANDIDATE: received|cleared|applied|partially_applied|unapplied|reversed|rejected — 7 candidates stripped; promote to reference product]',
    `payment_terms_code` STRING COMMENT 'Payment terms code from the original invoice (e.g., NET30, 2/10NET30). Used to validate discount eligibility and calculate DSO.. Valid values are `^[A-Z0-9]{2,10}$`',
    `posting_date` DATE COMMENT 'Date when the payment was posted to the general ledger. Used for financial period assignment and reporting.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the ar payment record',
    `remittance_advice_number` STRING COMMENT 'Reference number from customer remittance advice document. Links payment to customer payment notification (EDI 820 or paper remittance).. Valid values are `^[A-Z0-9]{6,25}$`',
    `reversal_date` DATE COMMENT 'Date when payment was reversed. Null if payment has not been reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this payment has been reversed. True if payment was subsequently voided or returned.',
    `reversal_reason_code` STRING COMMENT 'Reason code for payment reversal. Includes NSF (non-sufficient funds), stop payment, duplicate, fraud, customer request, or system error. [ENUM-REF-CANDIDATE: NSF|stop_payment|duplicate|fraud|customer_request|bank_error|system_error — 7 candidates stripped; promote to reference product]',
    `short_payment_flag` BOOLEAN COMMENT 'Indicates whether customer paid less than invoice amount without authorized deduction. Triggers deduction management workflow.',
    `source_system_code` STRING COMMENT 'The source system code of the ar payment record',
    `uom` STRING COMMENT 'The uom of the ar payment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the ar payment record',
    `value_date` DATE COMMENT 'Date when funds become available in the bank account. May differ from payment date due to clearing time.',
    CONSTRAINT pk_ar_payment PRIMARY KEY(`ar_payment_id`)
) COMMENT 'Accounts receivable payment record capturing cash receipts from trade customers against outstanding AR invoices. Records payment date, payment method (ACH, wire, check, EDI 820), amount received, currency, exchange rate, bank account, clearing document reference, partial payment flag, and deduction/short-payment details. Supports cash application, deduction management, and DSO calculation. Sourced from SAP S/4HANA FI-AR and Oracle Cloud Receivables.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key for the AP invoice entity.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which payment was or will be made. Used for cash management and bank reconciliation.',
    `company_code_id` BIGINT COMMENT 'The company code id of the ap invoice record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP invoices capture GL account code; FK to gl_account creates a true parent‑child relationship and removes the code column.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document used in three-way match verification to confirm materials or services were received.',
    `payment_run_id` BIGINT COMMENT 'Identifier for the automated payment run batch that processed this invoice payment. Used for payment reconciliation and audit trails.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched. Used for three-way match verification.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the vendor or supplier who issued this invoice. Links to the vendor master record.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the ap invoice record',
    `ap_invoice_number` STRING COMMENT 'The ap invoice number of the ap invoice record',
    `ap_invoice_status` STRING COMMENT 'The ap invoice status of the ap invoice record',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated. Typically the invoice date or goods receipt date depending on payment term configuration.',
    `clearing_document_number` STRING COMMENT 'The financial document number that cleared the open payable balance. Links the invoice to the payment transaction for reconciliation.',
    `ap_invoice_code` STRING COMMENT 'The ap invoice code of the ap invoice record',
    `cost_center_code` STRING COMMENT 'The cost center to which the invoice expense is allocated. Used for management accounting and departmental cost tracking.',
    `created_by_user` STRING COMMENT 'The user ID of the person who created the invoice record. Required for SOX-compliant audit trails and segregation of duties verification.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was first created in the system. Used for audit trails and Sarbanes-Oxley (SOX) compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the invoice is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `ap_invoice_description` STRING COMMENT 'The ap invoice description of the ap invoice record',
    `discount_amount` DECIMAL(18,2) COMMENT 'The cash discount amount available if payment is made within the early payment discount period. Used for working capital optimization.',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor according to the payment terms. Used for cash flow planning and Days Sales Outstanding (DSO) tracking.',
    `early_payment_discount_taken` DECIMAL(18,2) COMMENT 'The actual cash discount amount captured by paying the invoice within the early payment discount period. Key metric for working capital optimization.',
    `effective_from` DATE COMMENT 'The effective from of the ap invoice record',
    `effective_until` DATE COMMENT 'The effective until of the ap invoice record',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert the invoice amount to the companys local currency for financial reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice was posted. Used for monthly financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice was posted. Used for period-based financial reporting and year-end closing.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before any deductions, including all line items, taxes, and freight charges.',
    `invoice_category` STRING COMMENT 'Classification of the invoice by spend category (e.g., raw materials, packaging, contract manufacturing, indirect goods, services). Used for spend analytics and procurement reporting. [ENUM-REF-CANDIDATE: raw_materials|packaging|contract_manufacturing|indirect_goods|services|freight|utilities|rent — 8 candidates stripped; promote to reference product]',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the document date from the vendors invoice and is used for aging analysis.',
    `invoice_description` STRING COMMENT 'Free-text description or header text providing additional context about the invoice, such as the nature of goods or services purchased.',
    `invoice_number` STRING COMMENT 'The invoice number of the ap invoice record',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable process. Tracks the invoice from receipt through payment and clearing. [ENUM-REF-CANDIDATE: draft|posted|approved|paid|partially_paid|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `match_status` STRING COMMENT 'Status of the three-way match verification process comparing the invoice to the purchase order and goods receipt. Critical for payment approval workflow.. Valid values are `matched|unmatched|partially_matched|variance_pending|override_approved`',
    `modified_by_user` STRING COMMENT 'The user ID of the person who last modified the invoice record. Required for SOX-compliant audit trails.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was last modified. Used for change tracking and audit compliance.',
    `ap_invoice_name` STRING COMMENT 'The ap invoice name of the ap invoice record',
    `net_amount` DECIMAL(18,2) COMMENT 'The net payable amount after deducting any discounts or credits. This is the amount that will be paid to the vendor.',
    `notes` STRING COMMENT 'The notes of the ap invoice record',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'The outstanding amount of the ap invoice record',
    `payment_amount` DECIMAL(18,2) COMMENT 'The actual amount paid to the vendor. May differ from net amount if partial payments or adjustments were made.',
    `payment_block_code` STRING COMMENT 'Code indicating if the invoice is blocked for payment and the reason for the block (e.g., price variance, quantity variance, quality issue, pending approval).',
    `payment_date` DATE COMMENT 'The actual date payment was executed to the vendor. Used for cash flow tracking and Days Inventory Outstanding (DIO) calculation.',
    `payment_method` STRING COMMENT 'The method by which payment will be or was made to the vendor (e.g., wire transfer, ACH, check, EFT, credit card, virtual card).. Valid values are `wire_transfer|ach|check|eft|credit_card|virtual_card`',
    `payment_status` STRING COMMENT 'The payment status of the ap invoice record',
    `payment_terms` STRING COMMENT 'The payment terms of the ap invoice record',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the vendor (e.g., Net 30, 2/10 Net 30). Defines the due date calculation and early payment discount eligibility.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger. This date determines the fiscal period for financial reporting.',
    `profit_center_code` STRING COMMENT 'The profit center to which the invoice is allocated for segment reporting and EBITDA calculation by business unit.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the ap invoice record',
    `reference_document_number` STRING COMMENT 'Additional reference number for cross-referencing to other documents such as delivery notes, packing slips, or contract numbers.',
    `source_system_code` STRING COMMENT 'The source system code of the ap invoice record',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount charged on the invoice, including sales tax, VAT, GST, or other applicable taxes.',
    `tax_code` STRING COMMENT 'The tax jurisdiction code or tax type applied to the invoice (e.g., sales tax, VAT, GST). Used for tax reporting and compliance.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the ap invoice record',
    `uom` STRING COMMENT 'The uom of the ap invoice record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the ap invoice record',
    `vendor_bank_account_code` BIGINT COMMENT 'Reference to the vendors bank account to which payment was or will be sent. Required for electronic payment processing.',
    `vendor_invoice_number` STRING COMMENT 'The invoice number assigned by the vendor. This is the external reference number printed on the vendors invoice document.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the payment to the vendor as required by tax regulations. Must be remitted to tax authorities.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable master record representing the full trade payable lifecycle for raw materials, packaging, contract manufacturing, and indirect goods/services. Owns invoice receipt, three-way match verification, payment scheduling, payment execution, early payment discount capture, and clearing. Captures vendor invoice number, invoice date, posting date, due date, gross amount, tax, net amount, payment terms, currency, match status, payment method, payment date, payment amount, payment run ID, bank account reference, early discount taken, clearing document, and payment block details. The single source of truth for all payable balances, payment execution, DIO tracking, working capital optimization, and supplier payment management. Integrates with SAP S/4HANA MM-IV, FI-AP, and Oracle Cloud Payables.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment record. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'The ap invoice id of the ap payment record',
    `bank_account_id` BIGINT COMMENT 'The bank account id of the ap payment record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP payments include GL account code; FK to gl_account provides proper accounting linkage.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice being paid. Links to the accounts payable invoice record.',
    `payment_run_id` BIGINT COMMENT 'The payment run id of the ap payment record',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier receiving the payment. Links to the supplier master data.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the ap payment record',
    `ap_payment_number` STRING COMMENT 'The ap payment number of the ap payment record',
    `ap_payment_status` STRING COMMENT 'The ap payment status of the ap payment record',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the payment. Supports SOX-compliant audit trails and segregation of duties controls.',
    `approved_date` DATE COMMENT 'The date on which the payment was approved. Supports audit trails and payment cycle time analysis.',
    `clearing_date` DATE COMMENT 'The date on which the payment cleared the open invoice in the accounts payable subledger. Used for Days Inventory Outstanding (DIO) and working capital analysis.',
    `clearing_document_number` STRING COMMENT 'The document number assigned when the payment cleared the open invoice in the accounts payable subledger. Used for reconciliation and audit trails.',
    `ap_payment_code` STRING COMMENT 'The ap payment code of the ap payment record',
    `company_code` STRING COMMENT 'The company code (legal entity) that issued the payment. Used for multi-entity financial consolidation and reporting.',
    `cost_center_code` STRING COMMENT 'The cost center code to which the payment expense was allocated. Used for management accounting and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the payment record was first created in the system. Supports audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'The currency code of the ap payment record',
    `ap_payment_description` STRING COMMENT 'The ap payment description of the ap payment record',
    `discount_amount` DECIMAL(18,2) COMMENT 'The early payment discount amount taken by the company for paying the invoice before the discount deadline. Supports working capital optimization and supplier relationship management.',
    `discount_due_date` DATE COMMENT 'The date by which the payment must be made to qualify for the early payment discount. Used for working capital optimization decisions.',
    `due_date` DATE COMMENT 'The date by which the payment was contractually due to the supplier. Used to calculate on-time payment performance and avoid late payment penalties.',
    `effective_from` DATE COMMENT 'The effective from of the ap payment record',
    `effective_until` DATE COMMENT 'The effective until of the ap payment record',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the payment amount from the payment currency to the companys local currency. Used for financial consolidation and reporting.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the companys local reporting currency using the exchange rate. Used for consolidated financial reporting and EBITDA calculations.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the companys local reporting currency (e.g., USD). Used for financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the payment record. Supports SOX-compliant audit trails and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the payment record was last modified. Supports audit trails and change tracking for SOX compliance.',
    `ap_payment_name` STRING COMMENT 'The ap payment name of the ap payment record',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net payment amount after applying early payment discounts and any other adjustments. This is the actual amount transferred to the supplier.',
    `notes` STRING COMMENT 'The notes of the ap payment record',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross payment amount remitted to the supplier in the payment currency, before any adjustments or discounts.',
    `payment_approval_status` STRING COMMENT 'Approval status of the payment. Pending indicates awaiting approval, approved indicates authorized for processing, rejected indicates payment was denied. Supports SOX-compliant approval workflows.. Valid values are `pending|approved|rejected`',
    `payment_block_code` STRING COMMENT 'Code indicating if the payment was blocked for review or approval. Blank indicates no block. Used for payment control and fraud prevention.',
    `payment_block_reason` STRING COMMENT 'Description of the reason the payment was blocked (e.g., pending invoice verification, supplier on hold, duplicate payment suspected). Used for exception management.',
    `payment_block_released_by` STRING COMMENT 'User ID or name of the person who released the payment block and authorized the payment to proceed. Supports SOX-compliant audit trails.',
    `payment_block_released_date` DATE COMMENT 'The date on which the payment block was released and the payment was authorized to proceed. Supports audit trails and payment cycle time analysis.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP). Supports multi-currency payment processing.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the payment was issued or processed. Used for cash flow reporting and Days Sales Outstanding (DSO) calculations.',
    `payment_document_number` STRING COMMENT 'The externally-known payment document number assigned by the ERP system. Used for reconciliation and audit trails.',
    `payment_method` STRING COMMENT 'The payment instrument used to remit funds to the supplier. ACH (Automated Clearing House), wire transfer, check, EDI 820 (Electronic Data Interchange payment order), credit card, or direct debit.. Valid values are `ACH|wire_transfer|check|EDI_820|credit_card|direct_debit`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments about the payment. Used to capture special instructions, exceptions, or additional context for audit and reconciliation purposes.',
    `payment_reference` STRING COMMENT 'The payment reference of the ap payment record',
    `payment_reference_number` STRING COMMENT 'External reference number provided to the supplier for payment identification and reconciliation (e.g., check number, wire confirmation number, ACH trace number).',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment. Draft indicates initial creation, pending awaits approval, approved is ready for processing, processed has been sent to bank, cleared has been confirmed by bank, failed indicates processing error, cancelled indicates payment was voided. [ENUM-REF-CANDIDATE: draft|pending|approved|processed|cleared|failed|cancelled — 7 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'The payment terms agreed with the supplier (e.g., Net 30, 2/10 Net 30). Defines the due date and early payment discount eligibility.',
    `profit_center_code` STRING COMMENT 'The profit center code to which the payment expense was allocated. Used for segment reporting and EBITDA analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the ap payment record',
    `remittance_advice_sent_date` DATE COMMENT 'The date on which the remittance advice was sent to the supplier. Used for supplier communication tracking.',
    `remittance_advice_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a remittance advice was sent to the supplier to notify them of the payment details. True indicates sent, False indicates not sent.',
    `source_system_code` STRING COMMENT 'The source system code of the ap payment record',
    `uom` STRING COMMENT 'The uom of the ap payment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the ap payment record',
    `created_by` STRING COMMENT 'User ID or name of the person who created the payment record. Supports SOX-compliant audit trails.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment record capturing outgoing payments to suppliers for raw materials, packaging, and services. Records payment date, payment method (ACH, wire, check, EDI 820), payment amount, currency, exchange rate, bank account, payment run ID, clearing document, early payment discount taken, and payment block release authorization. Supports cash flow management, supplier relationship management, and working capital optimization. Sourced from SAP S/4HANA FI-AP.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` (
    `cogs_allocation_id` BIGINT COMMENT 'Unique identifier for the COGS allocation record. Primary key for the product costing and COGS allocation master.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for the production activity. Enables cost center profitability analysis.',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the cogs allocation record',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant where the product is produced and costed.',
    `product_bom_id` BIGINT COMMENT 'Reference to the bill of materials used for this cost calculation. Links cost to recipe/formula structure.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for internal P&L reporting and segment profitability analysis.',
    `routing_id` BIGINT COMMENT 'Reference to the production routing (sequence of operations) used for this cost calculation. Links cost to manufacturing process.',
    `sku_id` BIGINT COMMENT 'Reference to the material (finished good, semi-finished good, or raw material) for which COGS is allocated.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the cogs allocation record',
    `allocated_cost` DECIMAL(18,2) COMMENT 'The allocated cost of the cogs allocation record',
    `allocation_basis` STRING COMMENT 'The allocation basis of the cogs allocation record',
    `allocation_date` DATE COMMENT 'Date when the COGS allocation was calculated and posted. Key business event timestamp for cost assignment.',
    `allocation_method` STRING COMMENT 'Method used to allocate costs to the product: direct (traced), activity_based (ABC costing), weighted_average, FIFO (first-in-first-out), or standard (predetermined rate).. Valid values are `direct|activity_based|weighted_average|fifo|standard`',
    `allocation_period` STRING COMMENT 'The allocation period of the cogs allocation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the cogs allocation record',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved and released this cost estimate for use in inventory valuation and margin analysis.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost estimate was approved and released. Critical for SOX compliance and audit trail.',
    `cogs_allocation_code` STRING COMMENT 'The cogs allocation code of the cogs allocation record',
    `cogs_allocation_status` STRING COMMENT 'The cogs allocation status of the cogs allocation record',
    `costing_lot_size` DECIMAL(18,2) COMMENT 'Quantity basis used for cost calculation. Fixed costs are spread over this lot size to determine unit cost.',
    `costing_sheet` STRING COMMENT 'Template defining overhead calculation rules and cost component structure for this allocation.. Valid values are `^[A-Z0-9]{6}$`',
    `costing_type` STRING COMMENT 'Type of cost estimate: standard (baseline for valuation), actual (realized costs), planned (budgeted), or simulated (what-if scenario).. Valid values are `standard|actual|planned|simulated`',
    `costing_version` STRING COMMENT 'Version identifier for the costing run (e.g., standard cost, planned cost, actual cost). Enables parallel costing scenarios and version comparison.. Valid values are `^[A-Z0-9]{1,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this COGS allocation record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `depreciation_cost` DECIMAL(18,2) COMMENT 'Allocated depreciation expense for production equipment and facilities used in manufacturing.',
    `cogs_allocation_description` STRING COMMENT 'The cogs allocation description of the cogs allocation record',
    `direct_labor_cost` DECIMAL(18,2) COMMENT 'Cost component for direct production labor involved in manufacturing the product.',
    `effective_from` DATE COMMENT 'The effective from of the cogs allocation record',
    `effective_until` DATE COMMENT 'The effective until of the cogs allocation record',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year for the COGS allocation. Supports monthly cost tracking and variance analysis.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the COGS allocation applies. Enables year-over-year cost trend analysis.',
    `fixed_overhead_cost` DECIMAL(18,2) COMMENT 'Fixed manufacturing overhead costs that remain constant regardless of production volume (e.g., facility rent, salaries).',
    `freight_in_cost` DECIMAL(18,2) COMMENT 'Inbound freight and logistics costs for raw materials and components. Part of landed cost calculation.',
    `lot_size_unit` STRING COMMENT 'Unit of measure for the costing lot size (e.g., EA for each, KG for kilogram, L for liter).. Valid values are `^[A-Z]{2,3}$`',
    `machine_overhead_cost` DECIMAL(18,2) COMMENT 'Cost component for machine and equipment usage, including depreciation, maintenance, and operating costs.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this COGS allocation record was last modified. Audit trail for record updates.',
    `cogs_allocation_name` STRING COMMENT 'The cogs allocation name of the cogs allocation record',
    `notes` STRING COMMENT 'Free-text notes and comments regarding this cost allocation, including assumptions, adjustments, or special circumstances.',
    `other_cost` DECIMAL(18,2) COMMENT 'Miscellaneous cost components not classified in standard categories (e.g., quality testing, rework, scrap).',
    `packaging_cost` DECIMAL(18,2) COMMENT 'Cost component for primary, secondary, and tertiary packaging materials. Critical for CPG product costing.',
    `period` STRING COMMENT 'The period of the cogs allocation record',
    `price_control_indicator` STRING COMMENT 'Indicates whether material is valued at standard price (S) or moving average price (V). Critical for inventory valuation method.. Valid values are `S|V`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the cogs allocation record',
    `raw_material_cost` DECIMAL(18,2) COMMENT 'Cost component for raw materials and ingredients used in production. Key driver of COGS in consumer goods manufacturing.',
    `release_status` STRING COMMENT 'Lifecycle status of the cost estimate: draft (in progress), released (approved for use), locked (frozen for audit), archived (historical).. Valid values are `draft|released|locked|archived`',
    `source_system_code` STRING COMMENT 'The source system code of the cogs allocation record',
    `total_cost_amount` DECIMAL(18,2) COMMENT 'Total allocated cost per unit including all cost components (raw material, packaging, labor, overhead, freight, depreciation).',
    `uom` STRING COMMENT 'The uom of the cogs allocation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the cogs allocation record',
    `validity_end_date` DATE COMMENT 'End date until which this cost estimate remains valid. Null indicates open-ended validity.',
    `validity_start_date` DATE COMMENT 'Start date from which this cost estimate is valid and applicable for inventory valuation and margin calculation.',
    `valuation_class` STRING COMMENT 'Classification code that determines which general ledger accounts are updated during inventory movements and COGS posting.. Valid values are `^[A-Z0-9]{4}$`',
    `variable_overhead_cost` DECIMAL(18,2) COMMENT 'Variable manufacturing overhead costs that fluctuate with production volume (e.g., utilities, indirect materials).',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between standard cost and actual cost. Positive indicates unfavorable variance (actual > standard), negative indicates favorable variance.',
    `variance_category` STRING COMMENT 'Classification of cost variance by root cause: price (input cost change), quantity (usage deviation), mix (recipe change), yield (output efficiency), efficiency (labor/machine productivity), volume (fixed cost absorption).. Valid values are `price|quantity|mix|yield|efficiency|volume`',
    CONSTRAINT pk_cogs_allocation PRIMARY KEY(`cogs_allocation_id`)
) COMMENT 'Product costing and COGS allocation master for CPG manufacturing. Owns both standard cost estimates (planned) and actual cost allocations for finished goods, semi-finished goods, and raw materials. Captures cost component splits (raw material, packaging, direct labor, variable/fixed overhead, machine overhead, freight-in, depreciation), costing version, validity period, costing lot size, release status, plant, allocation date, fiscal period, standard vs actual cost, variance amount, variance category, and allocation method. The single source of truth for inventory valuation, SKU-level and brand-level gross margin analysis, manufacturing variance reporting, COGS decomposition, and make-vs-buy cost comparison. Sourced from SAP S/4HANA CO-PC (Product Costing).';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` (
    `standard_cost_id` BIGINT COMMENT 'Unique identifier for the standard cost record. Primary key for the standard cost master data.',
    `company_code_id` BIGINT COMMENT 'The company code id of the standard cost record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Standard cost records are defined per cost center; linking enables cost‑center level consolidation and provides a proper relational anchor.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility where this standard cost applies. Standard costs are plant-specific in CPG manufacturing.',
    `sku_id` BIGINT COMMENT 'Reference to the material (finished good, semi-finished good, or raw material) for which this standard cost is defined. Links to the product master.',
    `standard_sku_id` BIGINT COMMENT 'The standard sku id of the standard cost record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the standard cost record',
    `approval_status` STRING COMMENT 'The approval workflow status for this standard cost estimate. Ensures proper governance and SOX compliance for cost changes.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The user ID or name of the manager or controller who approved this standard cost estimate. Required for SOX compliance and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this standard cost estimate was approved. Critical for audit trail and SOX compliance.',
    `bom_usage` STRING COMMENT 'The BOM usage type (e.g., production, costing, engineering) that was used as the basis for material cost calculation in this estimate.',
    `standard_cost_code` STRING COMMENT 'The standard cost code of the standard cost record',
    `cost_estimate_created_by` STRING COMMENT 'The user ID or name of the cost accountant or system user who created this cost estimate. Used for audit trail and accountability.',
    `cost_estimate_created_timestamp` TIMESTAMP COMMENT 'The date and time when this standard cost record was first created in the source system. Critical for audit trail and SOX compliance.',
    `cost_estimate_modified_by` STRING COMMENT 'The user ID or name of the cost accountant or system user who last modified this cost estimate. Used for audit trail and change tracking.',
    `cost_estimate_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this standard cost record was last modified in the source system. Critical for audit trail and SOX compliance.',
    `cost_estimate_number` STRING COMMENT 'The unique business identifier for the cost estimate document in the source ERP system. Used for audit trail and traceability.',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'The absolute difference between the current standard cost and the previous standard cost. Positive indicates cost increase, negative indicates cost decrease.',
    `cost_variance_percentage` DECIMAL(18,2) COMMENT 'The percentage change in standard cost compared to the previous period. Calculated as (current - previous) / previous * 100.',
    `cost_version` STRING COMMENT 'The cost version of the standard cost record',
    `costing_lot_size` DECIMAL(18,2) COMMENT 'The production lot size (quantity) used as the basis for calculating the standard cost. Fixed costs are spread over this quantity.',
    `costing_lot_size_uom` STRING COMMENT 'The unit of measure for the costing lot size (e.g., EA, KG, L, CS). Must align with the materials base unit of measure.',
    `costing_sheet` STRING COMMENT 'The costing sheet identifier that defines the overhead calculation rules and surcharge rates applied in this cost estimate.',
    `costing_type` STRING COMMENT 'The type of cost estimate: standard (for inventory valuation), planned (for budgeting), actual (for variance analysis), or simulated (for what-if scenarios).. Valid values are `standard|planned|actual|simulated`',
    `costing_version` STRING COMMENT 'The costing version identifier that groups standard cost estimates for a specific planning or valuation scenario (e.g., current year, budget, simulation). Enables parallel costing scenarios.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the standard cost record',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the standard cost is expressed (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `standard_cost_description` STRING COMMENT 'The standard cost description of the standard cost record',
    `direct_labor_cost` DECIMAL(18,2) COMMENT 'The cost component for direct production labor (machine operators, line workers) allocated to one unit based on standard labor hours and rates.',
    `effective_from` DATE COMMENT 'The effective from of the standard cost record',
    `effective_until` DATE COMMENT 'The effective until of the standard cost record',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for which this standard cost estimate is applicable. Enables period-specific cost tracking.. Valid values are `^[0-9]{2}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this standard cost estimate is applicable. Standard costs are typically set annually and used for budgeting and variance analysis.. Valid values are `^[0-9]{4}$`',
    `fixed_overhead_cost` DECIMAL(18,2) COMMENT 'The cost component for fixed manufacturing overhead (plant management, utilities, rent) allocated to one unit based on the costing lot size.',
    `freight_in_cost` DECIMAL(18,2) COMMENT 'The cost component for inbound freight and logistics to bring raw materials and packaging to the plant, allocated to one unit.',
    `labor_cost` DECIMAL(18,2) COMMENT 'The labor cost of the standard cost record',
    `machine_overhead_cost` DECIMAL(18,2) COMMENT 'The cost component for machine and equipment overhead (depreciation, maintenance, energy) allocated to one unit based on machine hours.',
    `material_cost` DECIMAL(18,2) COMMENT 'The material cost of the standard cost record',
    `standard_cost_name` STRING COMMENT 'The standard cost name of the standard cost record',
    `notes` STRING COMMENT 'Free-text notes or comments about this standard cost estimate, such as assumptions, special considerations, or reasons for cost changes.',
    `other_cost` DECIMAL(18,2) COMMENT 'The cost component for miscellaneous or other costs not classified in the primary categories (e.g., scrap, rework, special charges).',
    `overhead_cost` DECIMAL(18,2) COMMENT 'The overhead cost of the standard cost record',
    `packaging_material_cost` DECIMAL(18,2) COMMENT 'The cost component for packaging materials (primary, secondary, tertiary) used for one unit. Critical for CPG cost structure analysis.',
    `previous_standard_cost` DECIMAL(18,2) COMMENT 'The total standard cost from the prior costing period or version. Used for variance analysis and cost trend reporting.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the standard cost record',
    `raw_material_cost` DECIMAL(18,2) COMMENT 'The cost component for raw materials consumed in the production of one unit. Key input for COGS and margin analysis.',
    `release_date` DATE COMMENT 'The date when this standard cost estimate was officially released and became active for inventory valuation and COGS calculation.',
    `release_status` STRING COMMENT 'The lifecycle status of the standard cost record: draft (under development), released (active for valuation), locked (frozen for audit), or archived (historical).. Valid values are `draft|released|locked|archived`',
    `routing_usage` STRING COMMENT 'The routing usage type (e.g., production, costing) that was used as the basis for labor and machine cost calculation in this estimate.',
    `source_system_code` STRING COMMENT 'The source system code of the standard cost record',
    `standard_cost_status` STRING COMMENT 'The standard cost status of the standard cost record',
    `total_standard_cost` DECIMAL(18,2) COMMENT 'The total standard cost per unit of the material, summing all cost components (raw material, packaging, labor, overhead, freight). This is the authoritative cost for inventory valuation and COGS.',
    `uom` STRING COMMENT 'The uom of the standard cost record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the standard cost record',
    `valid_from_date` DATE COMMENT 'The start date from which this standard cost estimate is effective. Used for time-dependent cost valuation and COGS calculation.',
    `valid_to_date` DATE COMMENT 'The end date until which this standard cost estimate is effective. Nullable for open-ended validity.',
    `valuation_variant` STRING COMMENT 'The valuation variant that defines the costing methodology and cost component structure used for this estimate (e.g., full costing, marginal costing).',
    `variable_overhead_cost` DECIMAL(18,2) COMMENT 'The cost component for variable manufacturing overhead (indirect materials, supplies, variable utilities) allocated to one unit.',
    `valid_from` DATE COMMENT 'The valid from of the standard cost record',
    `valid_to` DATE COMMENT 'The valid to of the standard cost record',
    CONSTRAINT pk_standard_cost PRIMARY KEY(`standard_cost_id`)
) COMMENT 'Standard cost master record for finished goods, semi-finished goods, and raw materials used in CPG manufacturing. Stores the cost estimate per SKU/material including cost component split (raw material, packaging, direct labor, machine overhead, fixed overhead, freight-in), costing version, validity period, plant, costing lot size, and release status. The authoritative source for inventory valuation, COGS calculation, and manufacturing variance analysis. Sourced from SAP S/4HANA CO-PC.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` (
    `finance_budget_id` BIGINT COMMENT 'Unique identifier for the finance budget record. Primary key for the finance budget entity.',
    `company_code_id` BIGINT COMMENT 'The company code id of the finance budget record',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this budget is allocated. Links budget planning to organizational cost structure.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Finance budgeting links budget lines to specific ESG commitments to track allocated ESG spend.',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the finance budget record',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `primary_finance_employee_id` BIGINT COMMENT 'Identifier of the individual or role responsible for managing and justifying this budget line. Supports accountability and budget governance.',
    `profit_center_id` BIGINT COMMENT 'The profit center id of the finance budget record',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Budget allocation process requires linking each finance_budget record to the specific R&D project for variance analysis and financial reporting.',
    `marketing_budget_id` BIGINT COMMENT 'Cross-reference link to authoritative SSOT table (marketing.marketing_budget.marketing_budget_id).',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual amount of the finance budget record',
    `allocation_method` STRING COMMENT 'Method used to allocate this budget across cost objects or organizational units (direct, proportional, activity-based, driver-based, manual).. Valid values are `direct|proportional|activity_based|driver_based|manual`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the finance budget record',
    `approval_status` STRING COMMENT 'Current approval status of the budget record indicating workflow state (draft, pending approval, approved, rejected, locked).. Valid values are `draft|pending_approval|approved|rejected|locked`',
    `approved_by_user` STRING COMMENT 'User ID or name of the individual who approved this budget line. Supports SOX-compliant audit trail and segregation of duties.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line was approved. Provides audit trail for budget approval workflow.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the finance budget record',
    `budget_category` STRING COMMENT 'High-level categorization of the budget type such as operating expense (OPEX), capital expenditure (CAPEX), headcount, revenue, cost of goods sold (COGS), marketing, or research and development (R&D). [ENUM-REF-CANDIDATE: opex|capex|headcount|revenue|cogs|marketing|r_and_d — 7 candidates stripped; promote to reference product]',
    `budget_code` STRING COMMENT 'The budget code of the finance budget record',
    `budget_name` STRING COMMENT 'The budget name of the finance budget record',
    `budget_status` STRING COMMENT 'The budget status of the finance budget record',
    `budget_type` STRING COMMENT 'The budget type of the finance budget record',
    `budget_version` STRING COMMENT 'The budget version of the finance budget record',
    `business_area_code` STRING COMMENT 'Business area or division code for code segment reporting. Enables matrix reporting across legal entities and business units.',
    `channel_code` STRING COMMENT 'Sales or distribution channel code (e.g., retail, e-commerce, wholesale, DTC) to which this budget is allocated. Enables channel-level budget planning.',
    `finance_budget_code` STRING COMMENT 'The finance budget code of the finance budget record',
    `comments` STRING COMMENT 'Additional free-text comments or notes related to this budget line. Provides supplementary context for budget review and analysis.',
    `controlling_area_code` STRING COMMENT 'Controlling area code representing the organizational unit for cost accounting and internal management reporting.',
    `cost_element_code` STRING COMMENT 'Cost element classification code used in controlling for cost type categorization (e.g., labor, materials, overhead).',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the finance budget record',
    `currency_code` STRING COMMENT 'The currency code of the finance budget record',
    `finance_budget_description` STRING COMMENT 'The finance budget description of the finance budget record',
    `ebitda_category` STRING COMMENT 'EBITDA bridge category classification for this budget line (revenue, COGS, operating expense, depreciation, amortization, non-operating). Supports EBITDA waterfall and bridge analysis.. Valid values are `revenue|cogs|operating_expense|depreciation|amortization|non_operating`',
    `effective_from` DATE COMMENT 'The effective from of the finance budget record',
    `effective_until` DATE COMMENT 'The effective until of the finance budget record',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert the local currency amount to the group currency amount. Supports currency translation audit trail.',
    `finance_budget_status` STRING COMMENT 'The finance budget status of the finance budget record',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year for which this budget applies. Enables period-level budget tracking.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this budget is planned. Supports multi-year budget planning and year-over-year analysis.',
    `functional_area_code` STRING COMMENT 'Functional area classification code (e.g., sales, manufacturing, administration) for functional cost analysis and reporting.',
    `group_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the currency in which the planned amount is converted.. Valid values are `^[A-Z]{3}$`',
    `ibp_integration_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line is integrated with the Integrated Business Planning (IBP) or Sales and Operations Planning (S&OP) process.',
    `justification_notes` STRING COMMENT 'Free-text notes providing business justification, rationale, or assumptions underlying this budget line. Supports zero-based budgeting (ZBB) and budget review processes.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the individual who last modified this budget record. Supports change tracking and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this budget record was last modified. Provides audit trail for budget changes and revisions.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local currency in which the planned amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `lock_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line is locked for editing. Supports budget freeze and period-end close controls.',
    `methodology` STRING COMMENT 'Budgeting methodology applied to this budget line (incremental, zero-based, activity-based, driver-based, rolling). Supports methodological transparency and audit.. Valid values are `incremental|zero_based|activity_based|driver_based|rolling`',
    `finance_budget_name` STRING COMMENT 'The finance budget name of the finance budget record',
    `notes` STRING COMMENT 'The notes of the finance budget record',
    `planned_amount_group` DECIMAL(18,2) COMMENT 'Planned budget amount converted to the currency. Used for consolidated financial reporting and cross-entity analysis.',
    `planned_amount_local` DECIMAL(18,2) COMMENT 'Planned budget amount in the local currency of the company code. Primary budget value for local financial planning and reporting.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Planned quantity or volume associated with this budget line (e.g., units produced, headcount, hours). Used for activity-based costing and volume variance analysis.',
    `product_line_code` STRING COMMENT 'Code identifying the product line or product category to which this budget is allocated. Supports product-level profitability analysis.',
    `profile_code` STRING COMMENT 'Budget profile or template code defining the budget structure, rules, and allocation logic applied to this budget line.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the finance budget record',
    `record_version` STRING COMMENT 'Version number of this budget record. Incremented with each modification to support optimistic locking and change history.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this budget record originated (e.g., SAP S/4HANA CO, Oracle Cloud Financials). Supports data lineage and reconciliation.',
    `uom` STRING COMMENT 'The uom of the finance budget record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance budget record',
    `valid_from_date` DATE COMMENT 'Start date from which this budget record is valid and effective. Supports time-dependent budget versioning and historical tracking.',
    `valid_to_date` DATE COMMENT 'End date until which this budget record is valid and effective. Null indicates an open-ended validity period.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage threshold for budget variance alerting and exception reporting. Used to trigger management review when actual spending deviates from budget.',
    `version` STRING COMMENT 'Version identifier for the budget record indicating whether it is the original budget, a revised budget, latest estimate, forecast, or rolling budget.. Valid values are `original|revised|latest_estimate|forecast|rolling`',
    CONSTRAINT pk_finance_budget PRIMARY KEY(`finance_budget_id`)
) COMMENT 'Financial budget record for the consumer goods enterprise covering annual, rolling, and zero-based budgets at both summary and line-item granularity. Captures budget version (original, revised, latest estimate), fiscal year, period, company code, cost center, profit center, GL account, cost element, product line, channel, planned quantity, planned amount in local and group currency, budget category (opex, capex, headcount), approval status, budget owner, and justification notes. Supports S&OP/IBP financial integration, variance-to-budget reporting, EBITDA bridge analysis, ZBB, and activity-based costing methodologies. Managed in SAP S/4HANA CO and Oracle Cloud Financials. [SSOT for concept budget.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset master data. Inferred role: MASTER_RESOURCE.',
    `company_code_id` BIGINT COMMENT 'The company code id of the fixed asset record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed assets are assigned to a cost center for expense tracking; the existing cost_center_code string is redundant once the FK is added.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_permit. Business justification: Asset compliance requires linking each fixed asset to its environmental permit for regulatory reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager responsible for the asset. Used for accountability, maintenance coordination, and asset custody tracking.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since the asset was placed in service. Represents the cumulative reduction in asset value over time. Used to calculate net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or historical cost of the asset at acquisition, including all costs necessary to bring the asset to working condition (purchase price, freight, installation, testing). Basis for depreciation calculation.',
    `acquisition_date` DATE COMMENT 'Date when the asset was acquired or purchased by the enterprise. Used as the starting point for depreciation calculation and asset lifecycle tracking.',
    `acquisition_value` DECIMAL(18,2) COMMENT 'The acquisition value of the fixed asset record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the fixed asset record',
    `asset_class` STRING COMMENT 'The asset class of the fixed asset record',
    `asset_class_code` STRING COMMENT 'Classification code that categorizes the asset by type (e.g., machinery, buildings, vehicles, IT equipment). Determines depreciation rules, useful life, and accounting treatment. Corresponds to SAP Asset Class or Oracle Asset Category.',
    `asset_description` STRING COMMENT 'Detailed textual description of the fixed asset, including make, model, specifications, and distinguishing characteristics. Used for identification and reporting purposes.',
    `asset_group_code` STRING COMMENT 'Grouping code for reporting and analysis purposes. Used to aggregate assets by category, function, or business unit for management reporting.',
    `asset_number` STRING COMMENT 'Externally-known unique asset identifier assigned by the enterprise. Business identifier used for asset tracking, reporting, and audit trails. Corresponds to SAP Asset Number or Oracle Asset Number.',
    `asset_serial_number` STRING COMMENT 'Manufacturer serial number or unique identifier assigned by the vendor. Used for warranty tracking, maintenance, and physical verification.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Indicates whether the asset is operational, under construction, retired, or disposed. Controls depreciation posting and asset transactions. [ENUM-REF-CANDIDATE: active|in_service|under_construction|retired|disposed|impaired|transferred|inactive — 8 candidates stripped; promote to reference product]',
    `business_area_code` STRING COMMENT 'Business area or division to which the asset belongs. Used for code reporting and segment analysis.',
    `capex_project_code` STRING COMMENT 'Capital project or work breakdown structure (WBS) element under which the asset was acquired. Used for capital budget tracking and project cost reconciliation.',
    `capitalization_date` DATE COMMENT 'Date when the asset was capitalized and placed in service. Depreciation begins from this date. May differ from acquisition date for assets under construction.',
    `fixed_asset_code` STRING COMMENT 'The fixed asset code of the fixed asset record',
    `created_by_user` STRING COMMENT 'User ID of the person who created the fixed asset record in the system. Used for audit trail and data governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fixed asset record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts (acquisition cost, depreciation, net book value). Typically the local currency of the company code.. Valid values are `^[A-Z]{3}$`',
    `depreciation_area_code` STRING COMMENT 'Depreciation area or book (e.g., book depreciation, tax depreciation, IFRS depreciation). Allows parallel valuation for different reporting purposes. Corresponds to SAP Depreciation Area.',
    `depreciation_end_date` DATE COMMENT 'Date when depreciation posting ends for the asset. Calculated based on useful life or set manually when the asset is fully depreciated, retired, or disposed.',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the cost of the asset over its useful life. Common methods include straight-line, declining balance, and units of production. Determines the depreciation expense pattern.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production|manual`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation posting begins for the asset. Typically the capitalization date or the first day of the following month, depending on enterprise policy.',
    `fixed_asset_description` STRING COMMENT 'The fixed asset description of the fixed asset record',
    `disposal_date` DATE COMMENT 'Date when the asset was disposed, sold, scrapped, or retired. Marks the end of the asset lifecycle. Used to calculate gain or loss on disposal.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from the sale or disposal of the asset. Used to calculate gain or loss on disposal (proceeds minus net book value at disposal).',
    `disposal_reason` STRING COMMENT 'Business reason for disposing of the asset. Used for asset lifecycle analysis, capital planning, and audit trails. [ENUM-REF-CANDIDATE: sale|scrap|obsolete|damaged|transfer|donation|end_of_life — 7 candidates stripped; promote to reference product]',
    `effective_from` DATE COMMENT 'The effective from of the fixed asset record',
    `effective_until` DATE COMMENT 'The effective until of the fixed asset record',
    `fixed_asset_status` STRING COMMENT 'The fixed asset status of the fixed asset record',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Cumulative impairment loss recognized on the asset when its recoverable amount falls below its carrying value. Required under IAS 36 Impairment of Assets. Reduces net book value.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified the fixed asset record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the fixed asset record was last modified. Used for audit trail and change tracking.',
    `last_revaluation_date` DATE COMMENT 'Date of the most recent asset revaluation. Revaluations adjust the carrying value to fair market value under IAS 16 revaluation model. Used for compliance and financial reporting.',
    `location_code` STRING COMMENT 'Specific location or sub-location within the plant where the asset is installed or stored. Enables granular asset tracking and physical inventory reconciliation.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or vendor who produced the asset. Used for warranty claims, spare parts sourcing, and vendor performance tracking.',
    `model_number` STRING COMMENT 'Manufacturer model or part number of the asset. Used for technical specifications, spare parts identification, and maintenance planning.',
    `fixed_asset_name` STRING COMMENT 'The fixed asset name of the fixed asset record',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset on the balance sheet, calculated as acquisition cost minus accumulated depreciation. Represents the remaining capitalized value of the asset.',
    `notes` STRING COMMENT 'The notes of the fixed asset record',
    `plant_code` STRING COMMENT 'Manufacturing plant, warehouse, or facility where the asset is physically located. Used for operational tracking and maintenance planning. Corresponds to SAP Plant or Oracle Inventory Organization.',
    `profit_center_code` STRING COMMENT 'Profit center to which the asset is assigned for internal profitability analysis. Used for segment reporting and performance measurement.',
    `purchase_order_number` STRING COMMENT 'Purchase order number used to acquire the asset. Links the asset to procurement records for audit trail and vendor reconciliation.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the fixed asset record',
    `revaluation_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent revaluation adjustment. Positive values indicate upward revaluation; negative values indicate impairment. Posted to revaluation reserve or income statement per IAS 16.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. The amount expected to be recovered through sale or disposal. Depreciation is calculated on acquisition cost minus salvage value.',
    `source_system_code` STRING COMMENT 'Identifier of the source system from which the fixed asset record originated (e.g., SAP, Oracle, legacy system). Used for data lineage and integration reconciliation.',
    `uom` STRING COMMENT 'The uom of the fixed asset record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the fixed asset record',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected economic useful life of the asset in years, as determined by asset class and enterprise policy. Used to calculate annual depreciation expense. May be fractional (e.g., 7.5 years).',
    `vendor_code` STRING COMMENT 'Identifier of the vendor or supplier from whom the asset was purchased. Used for vendor performance tracking and procurement analytics.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty expires. Used to determine whether repairs are covered under warranty or require capital expenditure.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master and lifecycle record for capital assets owned by the consumer goods enterprise — manufacturing equipment, production lines, warehouse automation, vehicles, buildings, and IT infrastructure. Covers the full asset lifecycle: acquisition, capitalization, depreciation, transfer, revaluation, impairment, and disposal. Captures asset class, description, acquisition date/cost, useful life, depreciation method, accumulated depreciation, net book value, plant/location, responsible cost center, and all transaction events (transaction type, posting date, amount, document reference, originating business process). Supports capex tracking, depreciation run reconciliation, asset lifecycle audit trail, and SOX-compliant fixed asset management. Sourced from SAP S/4HANA FI-AA and Oracle Cloud Fixed Assets.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Creator of intercompany transaction needed for transfer‑pricing documentation and audit traceability.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Intercompany transactions record GL account code; FK to gl_account creates a proper accounting relationship.',
    `journal_entry_id` BIGINT COMMENT 'The unique identifier of the consolidation elimination journal entry that reversed this intercompany transaction in the group financial statements.',
    `intercompany_journal_entry_id` BIGINT COMMENT 'The intercompany journal entry id of the intercompany transaction record',
    `company_code_id` BIGINT COMMENT 'The intercompany partner company code id of the intercompany transaction record',
    `netting_run_id` BIGINT COMMENT 'The unique identifier of the netting run in which this intercompany transaction was processed, if applicable.',
    `source_company_code_id` BIGINT COMMENT 'The source company code id of the intercompany transaction record',
    `target_company_code_id` BIGINT COMMENT 'The target company code id of the intercompany transaction record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the intercompany transaction record',
    `arms_length_validated_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the transfer price has been validated as compliant with arms-length pricing principles under OECD transfer pricing guidelines.',
    `business_area_code` STRING COMMENT 'The business area code representing the line of business or product category associated with this intercompany transaction.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'The date on which the intercompany receivable or payable was cleared through payment or offsetting entry.',
    `clearing_document_number` STRING COMMENT 'The document number of the payment or clearing entry that settled this intercompany transaction.. Valid values are `^[A-Z0-9]{10,20}$`',
    `intercompany_transaction_code` STRING COMMENT 'The intercompany transaction code of the intercompany transaction record',
    `cost_center_code` STRING COMMENT 'The cost center code associated with this intercompany transaction for management accounting and cost allocation purposes.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_by_user` STRING COMMENT 'The user ID of the person who created this intercompany transaction record in the ERP system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this intercompany transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the intercompany transaction record',
    `intercompany_transaction_description` STRING COMMENT 'The intercompany transaction description of the intercompany transaction record',
    `document_date` DATE COMMENT 'The date on the source document (invoice, agreement, or internal charge memo) that originated this intercompany transaction.',
    `due_date` DATE COMMENT 'The date by which the intercompany receivable or payable arising from this transaction is expected to be settled.',
    `effective_from` DATE COMMENT 'The effective from of the intercompany transaction record',
    `effective_until` DATE COMMENT 'The effective until of the intercompany transaction record',
    `elimination_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this intercompany transaction has been eliminated in the consolidated group financial statements.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction currency amount to the group currency amount.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the intercompany transaction was posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction was posted, derived from the posting date and the companys fiscal calendar.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the corporate groups reporting currency for consolidated financial statements.',
    `group_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code of the corporate groups reporting currency (typically USD, EUR, or other primary currency).. Valid values are `^[A-Z]{3}$`',
    `intercompany_transaction_status` STRING COMMENT 'The intercompany transaction status of the intercompany transaction record',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this intercompany transaction record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this intercompany transaction record was last modified.',
    `matching_status` STRING COMMENT 'Indicates whether this intercompany transaction has been successfully matched with the corresponding entry in the counterparty entitys records during the intercompany reconciliation process.. Valid values are `matched|unmatched|partially_matched|disputed`',
    `intercompany_transaction_name` STRING COMMENT 'The intercompany transaction name of the intercompany transaction record',
    `netting_status` STRING COMMENT 'Indicates whether this intercompany transaction has been included in an intercompany netting process to reduce cash movements between entities.. Valid values are `not_netted|netted|excluded_from_netting`',
    `notes` STRING COMMENT 'The notes of the intercompany transaction record',
    `payment_terms` STRING COMMENT 'The payment terms code defining the due date calculation and settlement conditions for this intercompany transaction.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The accounting date on which the intercompany transaction was posted to the general ledger. This is the principal business event timestamp for financial reporting and period assignment.',
    `profit_center_code` STRING COMMENT 'The profit center code associated with this intercompany transaction for internal profitability analysis.. Valid values are `^[A-Z0-9]{6,10}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the intercompany transaction record',
    `receiving_company_code` STRING COMMENT 'The company code of the legal entity receiving the intercompany transaction. Represents the crediting entity in the intercompany posting.. Valid values are `^[A-Z0-9]{4}$`',
    `reconciliation_reference` STRING COMMENT 'The unique reference number linking this intercompany transaction to its corresponding entry in the counterparty entitys books for reconciliation purposes.. Valid values are `^REC[0-9]{10}$`',
    `reconciliation_status` STRING COMMENT 'The reconciliation status of the intercompany transaction record',
    `reference_document_number` STRING COMMENT 'The external reference number from the source document (invoice, purchase order, service agreement) that originated this intercompany transaction.',
    `sending_company_code` STRING COMMENT 'The company code of the legal entity initiating or sending the intercompany transaction. Represents the debiting entity in the intercompany posting.. Valid values are `^[A-Z0-9]{4}$`',
    `source_system_code` STRING COMMENT 'The code identifying the source ERP system or financial application from which this intercompany transaction was extracted (e.g., SAP_S4, ORACLE_ERP).. Valid values are `^[A-Z0-9_]{3,10}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this intercompany transaction is subject to SOX internal control testing and audit procedures.',
    `tax_jurisdiction_code` STRING COMMENT 'The tax jurisdiction code applicable to this intercompany transaction for VAT, GST, or other indirect tax purposes.. Valid values are `^[A-Z]{2,3}$`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the intercompany transaction in the transaction currency, before any adjustments or eliminations.',
    `transaction_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the intercompany transaction was originally denominated.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The transaction date of the intercompany transaction record',
    `transaction_description` STRING COMMENT 'Free-text description providing additional context and business rationale for this intercompany transaction.',
    `transaction_document_number` STRING COMMENT 'The externally-known unique document number assigned to this intercompany transaction in the ERP system. Used for cross-reference and audit trail.. Valid values are `^[A-Z0-9]{10,20}$`',
    `transaction_number` STRING COMMENT 'The transaction number of the intercompany transaction record',
    `transaction_reference` STRING COMMENT 'The transaction reference of the intercompany transaction record',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the intercompany transaction in the financial close and consolidation process.. Valid values are `draft|posted|cleared|reconciled|eliminated|disputed`',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the cross-entity posting: goods transfer (finished goods sales), service charge (shared services allocation), management fee, royalty payment, intercompany loan, or dividend distribution.. Valid values are `goods_transfer|service_charge|management_fee|royalty|loan|dividend`',
    `transfer_price` DECIMAL(18,2) COMMENT 'The price charged for goods or services in this intercompany transaction, established according to the companys transfer pricing policy.',
    `transfer_pricing_method` STRING COMMENT 'The transfer pricing methodology applied to determine the arms-length price: Comparable Uncontrolled Price (CUP), Resale Price Method (RPM), Cost Plus Method (CPM), Transactional Net Margin Method (TNMM), Profit Split Method (PSM), or other.. Valid values are `CUP|RPM|CPM|TNMM|PSM|other`',
    `uom` STRING COMMENT 'The uom of the intercompany transaction record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the intercompany transaction record',
    `variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference between this intercompany transaction and its matched counterparty entry, if any discrepancy exists during reconciliation.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from this intercompany transaction, if applicable under local tax regulations.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany financial transaction record capturing cross-entity postings between legal entities within the consumer goods corporate group. Covers intercompany sales of finished goods, cost allocations, management fee charges, royalty payments, intercompany loans, and dividend distributions. Stores sending company code, receiving company code, transaction type, posting date, amount, currency, transfer price, arms-length validation flag, netting status, elimination flag, reconciliation reference, and matching status. Critical for consolidated financial reporting, transfer pricing compliance, intercompany elimination in group close, and regulatory documentation under OECD transfer pricing guidelines.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` (
    `finance_accrual_id` BIGINT COMMENT 'Unique identifier for the financial accrual record. Primary key for the accrual entity.',
    `company_code_id` BIGINT COMMENT 'The company code id of the finance accrual record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Finance accruals are posted against a cost center; the string code column becomes unnecessary after the FK is introduced.',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the finance accrual record',
    `employee_id` BIGINT COMMENT 'User ID of the finance manager or controller who approved the accrual entry. Required for SOX compliance and segregation of duties.',
    `supplier_id` BIGINT COMMENT 'Vendor or supplier identifier if the accrual relates to a specific vendor liability (e.g., rebate accrual, freight accrual). Null for internal accruals.',
    `tertiary_finance_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified the accrual entry. Tracks changes for audit trail and SOX compliance.',
    `trade_account_id` BIGINT COMMENT 'Customer or trade account identifier if the accrual relates to customer-specific trade spend or rebate. Null for non-customer accruals.',
    `promotion_accrual_id` BIGINT COMMENT 'Cross-reference link to authoritative SSOT table (promotion.promotion_accrual.promotion_accrual_id).',
    `accrual_amount` DECIMAL(18,2) COMMENT 'The accrual amount of the finance accrual record',
    `accrual_category` STRING COMMENT 'High-level accounting category of the accrual entry. Determines whether this is an expense accrual, liability accrual, revenue accrual, or prepaid asset.. Valid values are `expense|liability|revenue|asset`',
    `accrual_code` STRING COMMENT 'The accrual code of the finance accrual record',
    `accrual_date` DATE COMMENT 'The accrual date of the finance accrual record',
    `accrual_reference` STRING COMMENT 'The accrual reference of the finance accrual record',
    `accrual_status` STRING COMMENT 'Current lifecycle status of the accrual entry. Tracks the approval and posting workflow state for SOX compliance and audit trail.. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `accrual_type` STRING COMMENT 'Classification of the accrual by business purpose. Determines the nature of the expense or liability being recognized.. Valid values are `trade_spend|marketing|bonus|warranty|rebate|freight`',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the accrual in the base currency. Represents the estimated expense or liability being recognized in the current accounting period.',
    `approval_status` STRING COMMENT 'Approval workflow status for the accrual entry. Tracks whether the accrual has been reviewed and approved by authorized finance personnel.. Valid values are `not_required|pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual was approved. Part of the audit trail for period-end close activities.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes documenting the business rationale, assumptions, and any special circumstances related to the accrual. Supports external audit review.',
    `basis` STRING COMMENT 'Method by which the accrual was calculated and recorded. Indicates whether the accrual was manually entered by finance staff or automatically generated by system rules.. Valid values are `manual|automated_rule_based|statistical|estimated`',
    `business_area_code` STRING COMMENT 'Business area or division code for segment reporting. Enables consolidated financial statements by business line.. Valid values are `^[A-Z0-9]{4,6}$`',
    `calculation_method_description` STRING COMMENT 'Detailed explanation of how the accrual amount was calculated. Supports audit review and ensures transparency in accrual estimation methodology.',
    `finance_accrual_code` STRING COMMENT 'The finance accrual code of the finance accrual record',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual record was first created in the system. Establishes the audit trail timeline.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the accrual amount. Supports multi-currency accrual management for global operations.. Valid values are `^[A-Z]{3}$`',
    `finance_accrual_description` STRING COMMENT 'The finance accrual description of the finance accrual record',
    `document_date` DATE COMMENT 'Date on the source document that triggered the accrual. May differ from posting date for period-end adjustments.',
    `document_number` STRING COMMENT 'Externally-known unique document number assigned to this accrual entry in the financial system. Used for audit trail and cross-reference with source documents.. Valid values are `^[A-Z0-9]{10,20}$`',
    `effective_from` DATE COMMENT 'The effective from of the finance accrual record',
    `effective_until` DATE COMMENT 'The effective until of the finance accrual record',
    `finance_accrual_status` STRING COMMENT 'The finance accrual status of the finance accrual record',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the accrual is recognized. Typically 1-12 for monthly periods.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the accrual is recognized. Supports period-end reporting and year-over-year analysis.',
    `functional_area_code` STRING COMMENT 'Functional area classification for cost of sales accounting. Distinguishes between COGS, SG&A, R&D, and other functional expense categories.. Valid values are `^[A-Z0-9]{4,6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual record was last updated. Supports audit trail and change tracking for SOX compliance.',
    `material_code` STRING COMMENT 'Product or material SKU if the accrual is product-specific (e.g., warranty accrual by SKU). Null for non-product accruals.. Valid values are `^[A-Z0-9]{8,18}$`',
    `finance_accrual_name` STRING COMMENT 'The finance accrual name of the finance accrual record',
    `notes` STRING COMMENT 'The notes of the finance accrual record',
    `posting_date` DATE COMMENT 'Date when the accrual entry was posted to the general ledger. Determines the accounting period in which the accrual is recognized.',
    `profit_center_code` STRING COMMENT 'Profit center code for segment reporting and profitability analysis. Supports EBITDA reporting by business unit.. Valid values are `^[A-Z0-9]{4,10}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the finance accrual record',
    `reversal_date` DATE COMMENT 'Scheduled date when the accrual will be automatically reversed in the subsequent accounting period. Null for accruals that do not auto-reverse.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversal entry if the accrual has been reversed. Links the original accrual to its reversal for complete audit trail.. Valid values are `^[A-Z0-9]{10,20}$`',
    `reversal_reason_code` STRING COMMENT 'Reason code explaining why the accrual was reversed. Supports audit review and analysis of accrual accuracy.. Valid values are `auto_reversal|manual_correction|period_adjustment|error_correction|policy_change|estimate_update`',
    `source_document_reference` STRING COMMENT 'Unique identifier of the source document or transaction in the originating system. Enables traceability back to the source for audit purposes.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which the accrual originated (e.g., SAP_FI, ORACLE_FIN, MANUAL_ENTRY). Supports data lineage and reconciliation.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether the accrual entry meets SOX compliance requirements including proper documentation, approval, and audit trail. True if compliant, False otherwise.',
    `supporting_document_reference` STRING COMMENT 'Reference to supporting documentation or source system record that justifies the accrual. Required for SOX audit trail and compliance.',
    `uom` STRING COMMENT 'The uom of the finance accrual record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance accrual record',
    CONSTRAINT pk_finance_accrual PRIMARY KEY(`finance_accrual_id`)
) COMMENT 'Financial accrual and prepayment record for period-end close activities in the consumer goods enterprise. Captures accrual type (trade spend accrual, marketing accrual, bonus accrual, warranty accrual, rebate accrual), accrual basis (manual, automated rule-based), accrual amount, reversal date, GL account, cost center, profit center, supporting documentation reference, and approval status. Supports accurate period-end COGS and SG&A reporting and SOX-compliant accrual management. [SSOT for concept accrual.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` (
    `sox_control_id` BIGINT COMMENT 'Unique identifier for the SOX control record. Primary key for the sox_control data product.',
    `company_code_id` BIGINT COMMENT 'The company code id of the sox control record',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center to which the control owner belongs, used for organizational reporting and control coverage analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: SOX controls capture GL account code; FK to gl_account enables direct validation against the chart of accounts.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for executing and maintaining the control.',
    `sox_control_owner_employee_id` BIGINT COMMENT 'The sox control owner employee id of the sox control record',
    `tertiary_sox_tester_employee_id` BIGINT COMMENT 'Identifier of the internal auditor or external auditor who performed the most recent control test.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sox control record',
    `sox_control_code` STRING COMMENT 'The sox control code of the sox control record',
    `control_code` STRING COMMENT 'Business identifier for the control, typically following organizational control numbering scheme (e.g., FIN-AP-001, FIN-GL-005).. Valid values are `^[A-Z0-9]{3,20}$`',
    `control_description` STRING COMMENT 'The control description of the sox control record',
    `control_documentation_link` STRING COMMENT 'URL or file path to the detailed control documentation, including control narratives, process flows, and evidence repositories.',
    `control_effectiveness` STRING COMMENT 'The control effectiveness of the sox control record',
    `control_frequency` STRING COMMENT 'How often the control is performed or executed (e.g., daily reconciliation, monthly close review, event-driven approval).. Valid values are `daily|weekly|monthly|quarterly|annually|event-driven`',
    `control_name` STRING COMMENT 'Short descriptive name of the control (e.g., Three-Way Match for Purchase Orders, Journal Entry Approval).',
    `control_nature` STRING COMMENT 'Indicates whether the control is performed manually by personnel, automated through system configuration, or semi-automated requiring both system and manual steps.. Valid values are `manual|automated|semi-automated`',
    `control_objective` STRING COMMENT 'Detailed statement of what the control is designed to achieve, including the risk it mitigates and the assertion it supports (e.g., Ensure all vendor invoices are matched to purchase orders and receiving documents before payment to prevent unauthorized disbursements).',
    `control_owner_name` STRING COMMENT 'Full name of the control owner for reporting and accountability purposes.',
    `control_owner_title` STRING COMMENT 'Job title of the control owner (e.g., Accounts Payable Manager, Financial Controller, GL Accountant).',
    `control_status` STRING COMMENT 'Current lifecycle status of the control: active (in operation), inactive (temporarily suspended), under-review (being evaluated for changes), or retired (no longer applicable).. Valid values are `active|inactive|under-review|retired`',
    `control_type` STRING COMMENT 'Classification of the control based on its timing and purpose: preventive (stops errors before they occur), detective (identifies errors after occurrence), or corrective (remediates identified errors).. Valid values are `preventive|detective|corrective`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this control record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the sox control record',
    `deficiency_classification` STRING COMMENT 'Severity classification of any identified control deficiency: none (no issues), control deficiency (minor issue), significant deficiency (important enough to merit attention), or material weakness (reasonable possibility of material misstatement).. Valid values are `none|control-deficiency|significant-deficiency|material-weakness`',
    `sox_control_description` STRING COMMENT 'The sox control description of the sox control record',
    `effective_end_date` DATE COMMENT 'The date on which this control was retired or superseded. Null for active controls.',
    `effective_from` DATE COMMENT 'The effective from of the sox control record',
    `effective_start_date` DATE COMMENT 'The date from which this control became effective and operational.',
    `effective_until` DATE COMMENT 'The effective until of the sox control record',
    `effectiveness_rating` STRING COMMENT 'Overall assessment of control effectiveness based on testing results: effective (operating as designed), ineffective (deficiency identified), not-tested (testing not yet performed), or not-applicable (control not in scope for current period).. Valid values are `effective|ineffective|not-tested|not-applicable`',
    `exception_description` STRING COMMENT 'Detailed narrative describing the nature of exceptions identified during testing, including root cause analysis and impact assessment.',
    `exceptions_identified_count` STRING COMMENT 'The number of exceptions or deviations identified during the most recent control test.',
    `external_auditor_firm` STRING COMMENT 'Name of the external audit firm that reviewed this control (e.g., Deloitte, PwC, EY, KPMG).',
    `external_auditor_reviewed_indicator` BOOLEAN COMMENT 'Flag indicating whether this control has been reviewed by external auditors (true) or only by internal audit (false).',
    `financial_statement_assertion` STRING COMMENT 'The specific financial statement assertion that this control supports: existence (assets/liabilities exist), completeness (all transactions recorded), accuracy (amounts correct), valuation (proper measurement), rights and obligations (entity has legal claim), or presentation and disclosure (proper classification and disclosure).. Valid values are `existence|completeness|accuracy|valuation|rights-and-obligations|presentation-and-disclosure`',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter for which this control test and assessment applies, supporting quarterly SOX certification requirements.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this control test and assessment applies, supporting multi-year SOX compliance tracking.',
    `itgc_dependent_indicator` BOOLEAN COMMENT 'Flag indicating whether this control relies on IT general controls (true) or operates independently (false). ITGC-dependent controls require underlying IT controls to be effective.',
    `key_control_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a key control (true) or supporting control (false). Key controls are critical to preventing or detecting material misstatements and receive heightened testing and monitoring.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this control record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was last modified in the system.',
    `last_test_date` DATE COMMENT 'The last test date of the sox control record',
    `sox_control_name` STRING COMMENT 'The sox control name of the sox control record',
    `notes` STRING COMMENT 'The notes of the sox control record',
    `process_area` STRING COMMENT 'The process area of the sox control record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sox control record',
    `remediation_due_date` DATE COMMENT 'Target date by which identified deficiencies must be remediated, typically driven by materiality and external audit timelines.',
    `remediation_notes` STRING COMMENT 'Detailed notes on remediation activities, including actions taken, resources required, and progress updates.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts for identified deficiencies: not-required (no deficiency), planned (remediation plan approved), in-progress (actively remediating), completed (remediation finished), or validated (remediation effectiveness confirmed).. Valid values are `not-required|planned|in-progress|completed|validated`',
    `risk_area` STRING COMMENT 'The financial statement area or business process that this control addresses (e.g., Revenue Recognition, Accounts Payable, Inventory Valuation, Financial Close, COGS Allocation).',
    `source_system_code` STRING COMMENT 'The source system code of the sox control record',
    `sox_control_status` STRING COMMENT 'The sox control status of the sox control record',
    `test_conclusion` STRING COMMENT 'Detailed conclusion statement from the most recent control test, including auditor assessment, basis for conclusion, and any qualifications or limitations.',
    `test_date` DATE COMMENT 'The date on which the most recent control test was performed.',
    `test_method` STRING COMMENT 'The audit procedure used to test the control: inquiry (asking control owner), observation (watching control execution), inspection (examining evidence), re-performance (auditor executes control independently), or analytical review (comparing data patterns).. Valid values are `inquiry|observation|inspection|re-performance|analytical-review`',
    `test_population_size` STRING COMMENT 'The total number of items or transactions in the population from which the test sample was drawn.',
    `test_result` STRING COMMENT 'The test result of the sox control record',
    `test_sample_size` STRING COMMENT 'The number of items or transactions selected for testing in the most recent control test.',
    `tester_name` STRING COMMENT 'Full name of the tester for audit trail and accountability purposes.',
    `uom` STRING COMMENT 'The uom of the sox control record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sox control record',
    CONSTRAINT pk_sox_control PRIMARY KEY(`sox_control_id`)
) COMMENT 'SOX (Sarbanes-Oxley) internal control record defining and tracking the financial controls framework for the consumer goods enterprise. Covers the full control lifecycle: definition, testing, remediation, and certification. Captures control ID, name, objective, type (preventive/detective), frequency, risk area, responsible owner, test date, test method (inquiry, observation, inspection, re-performance), sample size, exceptions identified, remediation status, remediation due date, effectiveness rating, and test conclusion. Supports SOX 302/404 compliance, internal audit management, control deficiency tracking, and external auditor evidence packages.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Primary key for revenue_recognition',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Revenue recognition event creator is required for compliance reporting and audit of recognized revenue.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition events reference GL account code; FK to gl_account aligns revenue posting with the chart of accounts.',
    `invoice_id` BIGINT COMMENT 'Reference to the customer invoice associated with this revenue recognition event.',
    `original_event_revenue_recognition_id` BIGINT COMMENT 'Reference to the original revenue recognition event ID if this record is a reversal or adjustment.',
    `performance_obligation_id` BIGINT COMMENT 'Identifier for the specific performance obligation within the contract that is being satisfied. A contract may have multiple performance obligations (e.g., product delivery, extended warranty, promotional services).',
    `primary_revenue_contract_id` BIGINT COMMENT 'The primary revenue contract id of the revenue recognition record',
    `revenue_contract_id` BIGINT COMMENT 'Reference to the sales contract or customer agreement under which revenue is being recognized.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order or transaction that triggered this revenue recognition event.',
    `trade_account_id` BIGINT COMMENT 'Reference to the customer or trade account for whom revenue is being recognized.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the revenue recognition record',
    `approved_by_user` STRING COMMENT 'User ID or name of the person who approved this revenue recognition event for posting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this revenue recognition event was approved for posting.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier for the audit trail or approval workflow associated with this revenue recognition event.',
    `channel_code` STRING COMMENT 'Sales channel through which the transaction occurred (e.g., retail, e-commerce, wholesale, DSD).',
    `revenue_recognition_code` STRING COMMENT 'The revenue recognition code of the revenue recognition record',
    `company_code` STRING COMMENT 'Company code representing the legal entity for which revenue is being recognized.',
    `constraint_applied_flag` BOOLEAN COMMENT 'Indicates whether a constraint was applied to the variable consideration estimate to prevent revenue reversal in future periods.',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the revenue recognition event for cost allocation and tracking.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this revenue recognition event record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this revenue recognition event record was first created in the system.',
    `cumulative_catch_up_adjustment` DECIMAL(18,2) COMMENT 'Cumulative catch-up adjustment to revenue recognized in prior periods due to changes in estimates of variable consideration or performance obligation satisfaction.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which revenue amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'The deferred amount of the revenue recognition record',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'The amount of revenue deferred to future periods because the performance obligation has not yet been satisfied.',
    `revenue_recognition_description` STRING COMMENT 'The revenue recognition description of the revenue recognition record',
    `document_number` STRING COMMENT 'Unique accounting document number assigned to the revenue recognition journal entry in the financial system.',
    `effective_from` DATE COMMENT 'The effective from of the revenue recognition record',
    `effective_until` DATE COMMENT 'The effective until of the revenue recognition record',
    `estimated_returns_reserve` DECIMAL(18,2) COMMENT 'Reserve amount set aside for estimated product returns based on historical return rates and current sales.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year in which the revenue recognition event occurred.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the revenue recognition event occurred.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this revenue recognition event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this revenue recognition event record was last modified.',
    `revenue_recognition_name` STRING COMMENT 'The revenue recognition name of the revenue recognition record',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context or justification for the revenue recognition treatment applied.',
    `posting_date` DATE COMMENT 'Date on which the revenue recognition entry was posted to the general ledger.',
    `product_line_code` STRING COMMENT 'Product line or category code for the goods or services being recognized.',
    `profit_center_code` STRING COMMENT 'Profit center code for internal management reporting and profitability analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the revenue recognition record',
    `rebate_accrual` DECIMAL(18,2) COMMENT 'Accrued rebate amount expected to be paid to the customer based on volume or performance thresholds.',
    `recognition_code` STRING COMMENT 'The recognition code of the revenue recognition record',
    `recognition_date` DATE COMMENT 'The date on which revenue is recognized in the financial statements under ASC 606 or IFRS 15. This is the principal business event timestamp for this transaction.',
    `recognition_method` STRING COMMENT 'Method by which revenue is recognized: point-in-time (at delivery or transfer of control) or over-time (as performance obligation is satisfied over a period).. Valid values are `point_in_time|over_time`',
    `recognition_status` STRING COMMENT 'Current lifecycle status of the revenue recognition event: draft (pending approval), posted (finalized in GL), reversed (cancelled), or adjusted (modified after posting).. Valid values are `draft|posted|reversed|adjusted`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'The recognized amount of the revenue recognition record',
    `recognized_revenue_amount` DECIMAL(18,2) COMMENT 'The amount of revenue recognized in this event after applying all constraints and adjustments.',
    `revenue_recognition_status` STRING COMMENT 'The revenue recognition status of the revenue recognition record',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this revenue recognition event is a reversal or correction of a previously recognized amount.',
    `sku` STRING COMMENT 'Stock Keeping Unit identifier for the specific product or service being recognized.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this revenue recognition event originated (e.g., SAP S/4HANA FI, Oracle Cloud Financials).',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition event complies with SOX internal control requirements and has passed all required approval workflows.',
    `trade_promotion_deduction` DECIMAL(18,2) COMMENT 'Amount deducted from transaction price due to trade promotion allowances, discounts, or incentives provided to customers.',
    `transaction_price` DECIMAL(18,2) COMMENT 'Total transaction price allocated to this performance obligation before adjustments for variable consideration.',
    `uom` STRING COMMENT 'The uom of the revenue recognition record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the revenue recognition record',
    `variable_consideration_estimate` DECIMAL(18,2) COMMENT 'Estimated amount of variable consideration including trade promotions, rebates, volume discounts, returns, and other price concessions that reduce the transaction price.',
    CONSTRAINT pk_revenue_recognition PRIMARY KEY(`revenue_recognition_id`)
) COMMENT 'Revenue recognition event record capturing the timing and amount of revenue recognized under ASC 606 / IFRS 15 for consumer goods sales transactions. Stores performance obligation ID, contract reference, recognition date, recognition method (point-in-time vs over-time), recognized revenue amount, deferred revenue amount, variable consideration estimate (trade promotions, rebates, returns), constraint applied flag, and cumulative catch-up adjustment. Supports compliant revenue reporting and audit trail for complex CPG revenue arrangements.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the payment run for execution.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the bank account from which payments are disbursed.',
    `company_code_id` BIGINT COMMENT 'The company code id of the payment run record',
    `payment_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who initially created the payment run record.',
    `payment_executed_by_employee_id` BIGINT COMMENT 'The payment executed by employee id of the payment run record',
    `rerun_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (rerun_payment_run_id)',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the payment run record',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run received formal approval.',
    `payment_run_code` STRING COMMENT 'The payment run code of the payment run record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the payment run record',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the payment run.',
    `payment_run_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the payment run.',
    `effective_from` DATE COMMENT 'The effective from of the payment run record',
    `effective_until` DATE COMMENT 'The effective until of the payment run record',
    `error_count` BIGINT COMMENT 'Number of payment transactions that failed during the run.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Aggregate fees, charges, or taxes applied to the payment run.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross monetary value of all payments in the run before deductions.',
    `payment_run_name` STRING COMMENT 'The payment run name of the payment run record',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value transferred after fees are deducted.',
    `notes` STRING COMMENT 'The notes of the payment run record',
    `payment_count` STRING COMMENT 'The payment count of the payment run record',
    `payment_method` STRING COMMENT 'The payment method of the payment run record',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether the payment run was marked as high priority.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the payment run record',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this payment run record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this payment run record.',
    `run_date` DATE COMMENT 'The run date of the payment run record',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run execution completed or was terminated.',
    `run_number` STRING COMMENT 'External alphanumeric identifier assigned to the payment run by the finance system.',
    `run_reference` STRING COMMENT 'The run reference of the payment run record',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run execution started.',
    `run_status` STRING COMMENT 'The run status of the payment run record',
    `run_type` STRING COMMENT 'Category of the payment run indicating its purpose (e.g., payroll, supplier payments, tax payments, miscellaneous).',
    `scheduled_date` DATE COMMENT 'Planned calendar date on which the payment run was scheduled to execute.',
    `source_system_code` STRING COMMENT 'The source system code of the payment run record',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'The total payment amount of the payment run record',
    `transaction_count` BIGINT COMMENT 'Number of individual payment transactions included in the run.',
    `uom` STRING COMMENT 'The uom of the payment run record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the payment run record',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Primary key for bank_account',
    `company_code_id` BIGINT COMMENT 'The company code id of the bank account record',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the bank account record',
    `master_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (master_bank_account_id)',
    `account_currency` STRING COMMENT 'The account currency of the bank account record',
    `account_holder_name` STRING COMMENT 'Legal name of the entity or individual that owns the account.',
    `account_holder_tax_number` STRING COMMENT 'Tax identification number of the account holder (e.g., EIN, TIN).',
    `account_number` STRING COMMENT 'The primary account number assigned by the bank to identify the account.',
    `account_status` STRING COMMENT 'The account status of the bank account record',
    `account_type` STRING COMMENT 'Classification of the account based on its purpose and features.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the bank account record',
    `balance` DECIMAL(18,2) COMMENT 'Monetary amount currently held in the account.',
    `bank_account_number` STRING COMMENT 'The bank account number of the bank account record',
    `bank_account_status` STRING COMMENT 'Current lifecycle state of the account.',
    `bank_name` STRING COMMENT 'Legal name of the financial institution holding the account.',
    `branch_name` STRING COMMENT 'Name of the specific bank branch where the account is held.',
    `closed_date` DATE COMMENT 'Date when the account was closed or terminated, if applicable.',
    `bank_account_code` STRING COMMENT 'The bank account code of the bank account record',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the accounts functional currency. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|INR|BRL|CHF|CAD|AUD|... — promote to reference product]',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum total value of transactions allowed per day.',
    `bank_account_description` STRING COMMENT 'The bank account description of the bank account record',
    `effective_from` DATE COMMENT 'The effective from of the bank account record',
    `effective_until` DATE COMMENT 'The effective until of the bank account record',
    `iban` STRING COMMENT 'Standardized international identifier for the bank account.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual percentage rate applied to the account balance where applicable.',
    `is_joint_account` BOOLEAN COMMENT 'Indicates whether the account is held jointly with another party.',
    `last_reconciled_timestamp` TIMESTAMP COMMENT 'Date‑time when the account balance was last reconciled with the bank statement.',
    `monthly_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum total value of transactions allowed per month.',
    `bank_account_name` STRING COMMENT 'The bank account name of the bank account record',
    `notes` STRING COMMENT 'The notes of the bank account record',
    `opened_date` DATE COMMENT 'Date when the bank account became operational.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Maximum authorized overdraft amount for the account.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the bank account record',
    `source_system_code` STRING COMMENT 'The source system code of the bank account record',
    `swift_bic` STRING COMMENT 'The swift bic of the bank account record',
    `swift_code` STRING COMMENT 'Bank Identifier Code used for international transfers.',
    `uom` STRING COMMENT 'The uom of the bank account record',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the bank account record.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master reference table for bank_account. Referenced by bank_account_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Primary key for company_code',
    `chart_of_accounts_id` BIGINT COMMENT 'The chart of accounts id of the company code record',
    `controlling_area_id` BIGINT COMMENT 'Controlling area this company code operates within.',
    `parent_company_code_id` BIGINT COMMENT 'Self-referencing FK on company_code (parent_company_code_id)',
    `address_line1` STRING COMMENT 'First line of the entitys registered street address.',
    `address_line2` STRING COMMENT 'Second line of the entitys registered street address (optional).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the company code record',
    `city` STRING COMMENT 'City component of the entitys registered address.',
    `classification_type` STRING COMMENT 'Category describing the legal relationship of the entity within the corporate structure.',
    `company_code_code` STRING COMMENT 'Alphanumeric code used in ERP systems to identify the legal entity for accounting.',
    `company_code` STRING COMMENT 'The company code of the company code record',
    `company_code_status` STRING COMMENT 'The company code status of the company code record',
    `company_name` STRING COMMENT 'The company name of the company code record',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier associated with the entity for budgeting.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the legal entity is registered.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the company code record',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for reporting financials of the entity.',
    `company_code_description` STRING COMMENT 'The company code description of the company code record',
    `effective_from` DATE COMMENT 'Date when the legal entity became active for accounting purposes.',
    `effective_to` DATE COMMENT 'Date when the legal entity ceased to be active (null if still active).',
    `effective_until` DATE COMMENT 'The effective until of the company code record',
    `email_address` STRING COMMENT 'Main email address used for electronic correspondence with the entity.',
    `fiscal_year_variant` STRING COMMENT 'The fiscal year variant of the company code record',
    `industry_code` STRING COMMENT 'Standard industry classification (e.g., NAICS) for the entity.',
    `is_consolidated_entity` BOOLEAN COMMENT 'True if the entity is included in group financial consolidation.',
    `is_public_company` BOOLEAN COMMENT 'True if the entity is publicly listed; otherwise false.',
    `legal_entity_type` STRING COMMENT 'The legal entity type of the company code record',
    `legal_name` STRING COMMENT 'Full registered legal name of the company as per statutory filings.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the legal entity.',
    `local_currency` STRING COMMENT 'The local currency of the company code record',
    `company_code_name` STRING COMMENT 'Human‑readable name of the legal entity.',
    `notes` STRING COMMENT 'The notes of the company code record',
    `phone_number` STRING COMMENT 'Main telephone number for the entity.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the entitys registered address.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for official communications with the entity.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the company code record',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the company code record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the company code record.',
    `source_system_code` STRING COMMENT 'The source system code of the company code record',
    `state_province` STRING COMMENT 'State or province component of the entitys registered address.',
    `tax_number` STRING COMMENT 'Government‑issued tax identification number for the legal entity.',
    `uom` STRING COMMENT 'The uom of the company code record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the company code record',
    `value` STRING COMMENT 'The value of the company code record',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Master reference table for company_code. Referenced by company_code_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Primary key for chart_of_accounts',
    `controlling_area_id` BIGINT COMMENT 'The controlling area id of the chart of accounts record',
    `parent_chart_of_accounts_id` BIGINT COMMENT 'Self-referencing FK on chart_of_accounts (parent_chart_of_accounts_id)',
    `company_code_id` BIGINT COMMENT 'The company code id of the chart of accounts record',
    `account_count` STRING COMMENT 'Number of GL accounts in this chart.',
    `account_group` STRING COMMENT 'The account group of the chart of accounts record',
    `account_length` STRING COMMENT 'The account length of the chart of accounts record',
    `account_level` STRING COMMENT 'The account level of the chart of accounts record',
    `account_type` STRING COMMENT 'The account type of the chart of accounts record',
    `accounting_standard` STRING COMMENT 'The accounting standard of the chart of accounts record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the chart of accounts record',
    `blocked_flag` BOOLEAN COMMENT 'The blocked flag of the chart of accounts record',
    `chart_code` STRING COMMENT 'Chart of accounts code.',
    `chart_description` STRING COMMENT 'The chart description of the chart of accounts record',
    `chart_name` STRING COMMENT 'Chart of accounts name.',
    `chart_of_accounts_status` STRING COMMENT 'Lifecycle status of the chart.',
    `chart_of_accounts_type` STRING COMMENT 'The chart of accounts type of the chart of accounts record',
    `chart_type` STRING COMMENT 'The chart type of the chart of accounts record',
    `coa_code` STRING COMMENT 'The coa code of the chart of accounts record',
    `coa_description` STRING COMMENT 'The coa description of the chart of accounts record',
    `coa_name` STRING COMMENT 'The coa name of the chart of accounts record',
    `chart_of_accounts_code` STRING COMMENT 'The chart of accounts code of the chart of accounts record',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code of the chart of accounts record',
    `chart_of_accounts_description` STRING COMMENT 'Description of the chart of accounts.',
    `effective_from` DATE COMMENT 'The effective from of the chart of accounts record',
    `effective_until` DATE COMMENT 'The effective until of the chart of accounts record',
    `group_chart_flag` BOOLEAN COMMENT 'The group chart flag of the chart of accounts record',
    `is_active` BOOLEAN COMMENT 'The is active of the chart of accounts record',
    `is_blocked` BOOLEAN COMMENT 'Whether the chart is blocked for postings.',
    `is_group_chart` BOOLEAN COMMENT 'The is group chart of the chart of accounts record',
    `is_operating_chart` BOOLEAN COMMENT 'The is operating chart of the chart of accounts record',
    `is_operating_coa` BOOLEAN COMMENT 'The is operating coa of the chart of accounts record',
    `is_operational` BOOLEAN COMMENT 'Whether this is the operational chart.',
    `language_code` STRING COMMENT 'Maintenance language code.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the chart of accounts record',
    `length_of_account_number` STRING COMMENT 'Length of the account numbers in this chart.',
    `length_of_gl_account_number` STRING COMMENT 'The length of gl account number of the chart of accounts record',
    `maintenance_language` STRING COMMENT 'The maintenance language of the chart of accounts record',
    `chart_of_accounts_name` STRING COMMENT 'The chart of accounts name of the chart of accounts record',
    `notes` STRING COMMENT 'The notes of the chart of accounts record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the chart of accounts record',
    `source_system_code` STRING COMMENT 'The source system code of the chart of accounts record',
    `uom` STRING COMMENT 'The uom of the chart of accounts record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the chart of accounts record',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Master reference table for chart_of_accounts. Referenced by chart_of_accounts_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` (
    `controlling_area_id` BIGINT COMMENT 'Primary key for controlling_area',
    `parent_controlling_area_id` BIGINT COMMENT 'Self-referencing FK on controlling_area (parent_controlling_area_id)',
    `chart_of_accounts_id` BIGINT COMMENT 'The chart of accounts id of the controlling area record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the controlling area record',
    `area_name` STRING COMMENT 'The area name of the controlling area record',
    `controlling_area_code` STRING COMMENT 'Business key code assigned to the controlling area, unique within the enterprise.',
    `controlling_area_status` STRING COMMENT 'Current lifecycle status of the controlling area.',
    `controlling_area_type` STRING COMMENT 'Classification of the controlling area indicating whether it is used for cost accounting, profit center accounting, or both.',
    `controlling_currency` STRING COMMENT 'The controlling currency of the controlling area record',
    `cost_center_group` STRING COMMENT 'Logical grouping identifier for cost centers under this controlling area.',
    `cost_center_standard_hierarchy` STRING COMMENT 'The cost center standard hierarchy of the controlling area record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the controlling area record was first created in the system.',
    `currency` STRING COMMENT 'ISO 4217 currency code used for all financial postings in the controlling area.',
    `currency_code` STRING COMMENT 'The currency code of the controlling area record',
    `controlling_area_description` STRING COMMENT 'Long description providing context about the controlling areas purpose and scope.',
    `effective_from` DATE COMMENT 'The effective from of the controlling area record',
    `effective_until` DATE COMMENT 'The effective until of the controlling area record',
    `fiscal_year_variant` STRING COMMENT 'Identifier of the fiscal year variant applied to the controlling area for period accounting.',
    `controlling_area_name` STRING COMMENT 'Human‑readable name of the controlling area used in reports and UI.',
    `notes` STRING COMMENT 'The notes of the controlling area record',
    `profit_center_group` STRING COMMENT 'Logical grouping identifier for profit centers under this controlling area.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the controlling area record',
    `source_system_code` STRING COMMENT 'The source system code of the controlling area record',
    `uom` STRING COMMENT 'The uom of the controlling area record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the controlling area record.',
    `valid_from` DATE COMMENT 'Date from which the controlling area becomes effective.',
    `valid_to` DATE COMMENT 'Date on which the controlling area ceases to be effective; null if still active.',
    CONSTRAINT pk_controlling_area PRIMARY KEY(`controlling_area_id`)
) COMMENT 'Master reference table for controlling_area. Referenced by controlling_area_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` (
    `netting_run_id` BIGINT COMMENT 'Primary key for netting_run',
    `company_code_id` BIGINT COMMENT 'The company code id of the netting run record',
    `employee_id` BIGINT COMMENT 'The executed by employee id of the netting run record',
    `party_id` BIGINT COMMENT 'Identifier of the primary counterparty (e.g., vendor, subsidiary) involved in the netting run.',
    `reversal_netting_run_id` BIGINT COMMENT 'Self-referencing FK on netting_run (reversal_netting_run_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments (taxes, fees, discounts) applied during netting.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the netting run record',
    `netting_run_code` STRING COMMENT 'External code or number assigned to the netting run for reference in finance systems.',
    `counterparty_count` STRING COMMENT 'The counterparty count of the netting run record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the netting run record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the netting run amounts.',
    `netting_run_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the netting run.',
    `effective_from` DATE COMMENT 'Start date of the accounting period covered by the netting run.',
    `effective_until` DATE COMMENT 'End date of the accounting period covered by the netting run; null if open-ended.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross monetary value of all transactions before adjustments.',
    `is_automated` BOOLEAN COMMENT 'True if the netting run was triggered automatically by the system; false if manual.',
    `netting_run_name` STRING COMMENT 'The netting run name of the netting run record',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net monetary value after adjustments; should equal gross minus adjustments.',
    `netted_amount` DECIMAL(18,2) COMMENT 'The netted amount of the netting run record',
    `netting_cycle` STRING COMMENT 'Frequency at which this type of netting run is scheduled.',
    `netting_period` STRING COMMENT 'The netting period of the netting run record',
    `netting_run_status` STRING COMMENT 'Current processing state of the netting run.',
    `notes` STRING COMMENT 'The notes of the netting run record',
    `participant_count` STRING COMMENT 'The participant count of the netting run record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the netting run record',
    `run_date` DATE COMMENT 'The run date of the netting run record',
    `run_reason` STRING COMMENT 'Business reason why the netting run was executed (e.g., month‑end, cash‑flow optimization).',
    `run_reference` STRING COMMENT 'The run reference of the netting run record',
    `run_status` STRING COMMENT 'The run status of the netting run record',
    `run_timestamp` TIMESTAMP COMMENT 'Date and time when the netting run was initiated in the business process.',
    `run_type` STRING COMMENT 'Category of netting run based on the relationship of parties involved.',
    `source_system_code` STRING COMMENT 'The source system code of the netting run record',
    `total_netted_amount` DECIMAL(18,2) COMMENT 'The total netted amount of the netting run record',
    `total_transactions` STRING COMMENT 'Count of individual financial transactions included in this netting run.',
    `uom` STRING COMMENT 'The uom of the netting run record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the netting run record.',
    CONSTRAINT pk_netting_run PRIMARY KEY(`netting_run_id`)
) COMMENT 'Master reference table for netting_run. Referenced by netting_run_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` (
    `revenue_contract_id` BIGINT COMMENT 'Primary key for revenue_contract',
    `amended_revenue_contract_id` BIGINT COMMENT 'Self-referencing FK on revenue_contract (amended_revenue_contract_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the internal party owning the contract.',
    `company_code_id` BIGINT COMMENT 'The company code id of the revenue contract record',
    `revenue_contract_manager_employee_id` BIGINT COMMENT 'Identifier of the internal manager responsible for contract execution.',
    `trade_account_id` BIGINT COMMENT 'The trade account id of the revenue contract record',
    `amendment_count` STRING COMMENT 'Number of times the contract has been amended.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the revenue contract record',
    `annual_recurring_revenue` DECIMAL(18,2) COMMENT 'Projected recurring revenue per year from the contract.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the contract received formal approval.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the contract.',
    `billing_address` STRING COMMENT 'Address used for billing and tax purposes.',
    `billing_frequency` STRING COMMENT 'How often invoicing occurs under the contract.',
    `revenue_contract_code` STRING COMMENT 'The revenue contract code of the revenue contract record',
    `compliance_requirements` STRING COMMENT 'Text describing regulatory or internal compliance obligations tied to the contract.',
    `contract_description` STRING COMMENT 'Free‑form description of the contract scope and purpose.',
    `contract_end_date` DATE COMMENT 'The contract end date of the revenue contract record',
    `contract_name` STRING COMMENT 'Human‑readable name or title of the contract.',
    `contract_number` STRING COMMENT 'External contract reference number used in agreements and invoicing.',
    `contract_start_date` DATE COMMENT 'The contract start date of the revenue contract record',
    `contract_status` STRING COMMENT 'The contract status of the revenue contract record',
    `contract_type` STRING COMMENT 'Category of the agreement (e.g., product sale, service, licensing).',
    `contract_value` DECIMAL(18,2) COMMENT 'The contract value of the revenue contract record',
    `cost_allocation_method` STRING COMMENT 'Approach for allocating COGS to the contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the contract record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit extended to the counter‑party under the contract.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the contract currency.',
    `revenue_contract_description` STRING COMMENT 'The revenue contract description of the revenue contract record',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base price.',
    `effective_from` DATE COMMENT 'Date the contract becomes legally binding.',
    `effective_until` DATE COMMENT 'Planned termination date; null for open‑ended contracts.',
    `invoicing_address` STRING COMMENT 'Address to which invoices are sent.',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code governing the contract.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment.',
    `revenue_contract_name` STRING COMMENT 'The revenue contract name of the revenue contract record',
    `notes` STRING COMMENT 'The notes of the revenue contract record',
    `payment_method` STRING COMMENT 'Primary method used for payments under the contract.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed for the contract.',
    `performance_guarantee_amount` DECIMAL(18,2) COMMENT 'Monetary guarantee pledged for contract performance.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the revenue contract record',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract auto‑renews at expiry.',
    `revenue_contract_status` STRING COMMENT 'Current lifecycle state of the contract.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for the contract.',
    `service_level` STRING COMMENT 'Tier of service commitment associated with the contract.',
    `source_system_code` STRING COMMENT 'The source system code of the revenue contract record',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the contract is exempt from tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate for the contract (percentage).',
    `termination_date` DATE COMMENT 'Date the contract was terminated before the effective end date.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Gross monetary value of the contract at signing.',
    `uom` STRING COMMENT 'The uom of the revenue contract record',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the contract record.',
    CONSTRAINT pk_revenue_contract PRIMARY KEY(`revenue_contract_id`)
) COMMENT 'Master reference table for revenue_contract. Referenced by contract_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Primary key for performance_obligation',
    `allocated_from_performance_obligation_id` BIGINT COMMENT 'Self-referencing FK on performance_obligation (allocated_from_performance_obligation_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the performance obligation record.',
    `contract_party_id` BIGINT COMMENT 'Identifier of the external party (customer, vendor, partner) bound by the obligation.',
    `revenue_contract_id` BIGINT COMMENT 'The revenue contract id of the performance obligation record',
    `sku_id` BIGINT COMMENT 'The sku id of the performance obligation record',
    `actual_metric_date` DATE COMMENT 'Date on which the actual metric value was recorded.',
    `actual_metric_value` DECIMAL(18,2) COMMENT 'Measured value of the performance metric to date.',
    `allocated_transaction_price` DECIMAL(18,2) COMMENT 'The allocated transaction price of the performance obligation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the performance obligation record',
    `billing_schedule` STRING COMMENT 'Schedule that dictates when invoices are issued for the obligation.',
    `performance_obligation_code` STRING COMMENT 'The performance obligation code of the performance obligation record',
    `compliance_regulation` STRING COMMENT 'Reference to applicable regulatory framework (e.g., SOX, ASC 606).',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code to which the obligations costs are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the total amount.',
    `performance_obligation_description` STRING COMMENT 'Free‑form description of the performance obligation.',
    `effective_from` DATE COMMENT 'Date when the performance obligation becomes binding.',
    `effective_until` DATE COMMENT 'Date when the performance obligation ends or expires; null for open‑ended.',
    `internal_notes` STRING COMMENT 'Private comments for internal stakeholders; not exposed to external parties.',
    `is_renewable` BOOLEAN COMMENT 'Flag indicating whether the obligation is eligible for renewal.',
    `metric_target_value` DECIMAL(18,2) COMMENT 'Target value that must be achieved for the performance metric.',
    `metric_unit` STRING COMMENT 'Unit of measure for the performance metric.',
    `performance_obligation_name` STRING COMMENT 'The performance obligation name of the performance obligation record',
    `notes` STRING COMMENT 'The notes of the performance obligation record',
    `obligation_code` STRING COMMENT 'The obligation code of the performance obligation record',
    `obligation_description` STRING COMMENT 'The obligation description of the performance obligation record',
    `obligation_name` STRING COMMENT 'Human‑readable name or title of the performance obligation.',
    `obligation_number` STRING COMMENT 'External contract number or code assigned to the performance obligation.',
    `obligation_status` STRING COMMENT 'The obligation status of the performance obligation record',
    `obligation_type` STRING COMMENT 'Category of the performance obligation indicating its nature.',
    `payment_terms` STRING COMMENT 'Terms governing payment timing and conditions (e.g., Net 30).',
    `penalty_clause` STRING COMMENT 'Contractual penalty provisions for non‑performance or late delivery.',
    `performance_metric` STRING COMMENT 'Metric used to measure fulfillment of the obligation.',
    `performance_obligation_status` STRING COMMENT 'Current lifecycle state of the performance obligation.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the performance obligation record',
    `renewal_option` STRING COMMENT 'Indicates whether the obligation can be renewed and the renewal mechanism.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for this obligation per ASC 606.',
    `satisfaction_method` STRING COMMENT 'The satisfaction method of the performance obligation record',
    `satisfaction_status` STRING COMMENT 'The satisfaction status of the performance obligation record',
    `source_system_code` STRING COMMENT 'The source system code of the performance obligation record',
    `standalone_selling_price` DECIMAL(18,2) COMMENT 'The standalone selling price of the performance obligation record',
    `tax_applicable` BOOLEAN COMMENT 'Indicates whether taxes apply to the monetary amount of the obligation.',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to give notice before terminating the obligation.',
    `total_amount` DECIMAL(18,2) COMMENT 'Contractual monetary amount associated with the performance obligation.',
    `uom` STRING COMMENT 'The uom of the performance obligation record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance obligation record.',
    `version_number` STRING COMMENT 'Version of the performance obligation record for change tracking.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Master reference table for performance_obligation. Referenced by performance_obligation_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` (
    `material_ledger_posting_id` BIGINT COMMENT 'Primary key for material_ledger_posting',
    `company_code_id` BIGINT COMMENT 'The company code id of the material ledger posting record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Material ledger postings are recorded for a specific cost center; the code column is replaced by a proper FK.',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the material ledger posting record',
    `material_id` BIGINT COMMENT 'Identifier of the material (product) to which the posting relates.',
    `party_id` BIGINT COMMENT 'Identifier of the business partner (vendor, customer, or internal entity) associated with the posting.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `reversal_material_ledger_posting_id` BIGINT COMMENT 'Self-referencing FK on material_ledger_posting (reversal_material_ledger_posting_id)',
    `sku_id` BIGINT COMMENT 'The sku id of the material ledger posting record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the material ledger posting record',
    `amount_adjustment` DECIMAL(18,2) COMMENT 'Tax, fee, discount, or other monetary adjustment applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Base monetary value of the posting before taxes, fees, or discounts.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final monetary value after adjustments; the amount posted to the ledger.',
    `material_ledger_posting_code` STRING COMMENT 'The material ledger posting code of the material ledger posting record',
    `cost_component` STRING COMMENT 'Cost component (e.g., material, labor, overhead) associated with the posting.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the material ledger posting record',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the posting amounts. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CHF|AUD|CAD|... — promote to reference product]',
    `material_ledger_posting_description` STRING COMMENT 'The material ledger posting description of the material ledger posting record',
    `document_number` STRING COMMENT 'Reference to the accounting document generated by the posting.',
    `effective_from` DATE COMMENT 'The effective from of the material ledger posting record',
    `effective_until` DATE COMMENT 'The effective until of the material ledger posting record',
    `fiscal_period` STRING COMMENT 'The fiscal period of the material ledger posting record',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the posting belongs.',
    `is_reversal` BOOLEAN COMMENT 'Flag indicating whether this posting reverses a previous posting.',
    `ledger_account` STRING COMMENT 'GL account to which the posting amount is posted.',
    `material_ledger_posting_status` STRING COMMENT 'The material ledger posting status of the material ledger posting record',
    `material_ledger_posting_name` STRING COMMENT 'The material ledger posting name of the material ledger posting record',
    `notes` STRING COMMENT 'The notes of the material ledger posting record',
    `period` STRING COMMENT 'Fiscal period (month) of the posting within the fiscal year.',
    `plant_code` STRING COMMENT 'Code of the manufacturing/warehouse plant where the material is stocked.',
    `posting_amount` DECIMAL(18,2) COMMENT 'The posting amount of the material ledger posting record',
    `posting_date` DATE COMMENT 'The posting date of the material ledger posting record',
    `posting_number` STRING COMMENT 'External posting number assigned by the finance system for traceability.',
    `posting_reference` STRING COMMENT 'The posting reference of the material ledger posting record',
    `posting_status` STRING COMMENT 'Current processing state of the material ledger posting.',
    `posting_timestamp` TIMESTAMP COMMENT 'Date and time when the posting was created in the source system.',
    `posting_type` STRING COMMENT 'Category of posting indicating its purpose or origin.',
    `price_difference` DECIMAL(18,2) COMMENT 'The price difference of the material ledger posting record',
    `quantity` DECIMAL(18,2) COMMENT 'Physical quantity of material posted (in the unit of measure).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ledger posting record was first captured in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this ledger posting record.',
    `source_system_code` STRING COMMENT 'The source system code of the material ledger posting record',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the posted quantity. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|... — promote to reference product]',
    `uom` STRING COMMENT 'The uom of the material ledger posting record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the material ledger posting record',
    `valuation_area` STRING COMMENT 'Accounting area used for material valuation (e.g., company code).',
    `valuation_class` STRING COMMENT 'Classification that determines the valuation method for the material.',
    CONSTRAINT pk_material_ledger_posting PRIMARY KEY(`material_ledger_posting_id`)
) COMMENT 'Master reference table for material_ledger_posting. Referenced by material_ledger_posting_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `parent_party_id` BIGINT COMMENT 'Identifier of the parent party in a hierarchical relationship.',
    `supplier_id` BIGINT COMMENT 'Supplier this party resolves to.',
    `trade_account_id` BIGINT COMMENT 'Trade account this party resolves to.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the party record',
    `bank_account_number` STRING COMMENT 'Bank account number used for electronic payments to/from the party.',
    `bank_routing_number` STRING COMMENT 'Routing number associated with the partys bank account.',
    `city` STRING COMMENT 'City component of the partys primary address.',
    `classification` STRING COMMENT 'Business classification of the party for segmentation and reporting.',
    `party_code` STRING COMMENT 'The party code of the party record',
    `compliance_status` STRING COMMENT 'Current compliance standing of the party with internal and external regulations.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the partys primary address. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|CHN|IND|BRA|... — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the party record',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount extended to the party.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for transactions with the party.',
    `data_classification` STRING COMMENT 'Classification level applied to the party record for data governance.',
    `data_source_system` STRING COMMENT 'Name of the source system that originally created or supplied the party record.',
    `default_payment_method` STRING COMMENT 'Preferred method for settling invoices with the party.',
    `party_description` STRING COMMENT 'The party description of the party record',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the party.',
    `effective_end_date` DATE COMMENT 'Date when the partys relationship ends or is expected to end (nullable for ongoing relationships).',
    `effective_from` DATE COMMENT 'The effective from of the party record',
    `effective_start_date` DATE COMMENT 'Date when the party became effective for business transactions.',
    `effective_until` DATE COMMENT 'The effective until of the party record',
    `external_party_reference` STRING COMMENT 'Identifier used for the party in external source systems.',
    `global_location_number` STRING COMMENT 'Standardized global identifier for the partys physical location.',
    `industry_code` STRING COMMENT 'Standard industry classification code (e.g., NAICS) describing the partys primary business sector.',
    `is_blacklisted` BOOLEAN COMMENT 'Indicates whether the party is on a blacklist for compliance reasons.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent interaction or transaction involving the party.',
    `legal_name` STRING COMMENT 'Official legal name of the party as registered.',
    `party_name` STRING COMMENT 'Display name of the party (person or organization).',
    `notes` STRING COMMENT 'Additional free‑form information about the party.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party.',
    `party_type` STRING COMMENT 'High-level type of the party indicating whether it is an individual, corporate entity, government body, or partner.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the party.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the partys primary address.',
    `preferred_language` STRING COMMENT 'Language preferred for communications with the party.',
    `primary_address_line1` STRING COMMENT 'First line of the partys primary mailing address.',
    `primary_address_line2` STRING COMMENT 'Second line of the partys primary mailing address (optional).',
    `primary_email` STRING COMMENT 'Main email address used for electronic communication with the party.',
    `primary_phone` STRING COMMENT 'Main telephone number for contacting the party.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the party record',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the party record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the party record.',
    `registration_number` STRING COMMENT 'Official registration number of the party with the relevant corporate authority.',
    `risk_score` STRING COMMENT 'Numerical risk rating assigned to the party based on internal models.',
    `source_system_code` STRING COMMENT 'The source system code of the party record',
    `state` STRING COMMENT 'State or province component of the partys primary address.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the party is exempt from sales tax.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identification number (e.g., EIN, VAT).',
    `tax_number` STRING COMMENT 'The tax number of the party record',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the partys primary location.',
    `uom` STRING COMMENT 'The uom of the party record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the party record',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by party_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` (
    `contract_party_id` BIGINT COMMENT 'Primary key for contract_party',
    `parent_party_id` BIGINT COMMENT 'Identifier of the upstream or parent party in a hierarchical relationship (e.g., holding company).',
    `party_id` BIGINT COMMENT 'The related party id of the contract party record',
    `represented_by_contract_party_id` BIGINT COMMENT 'Self-referencing FK on contract_party (represented_by_contract_party_id)',
    `revenue_contract_id` BIGINT COMMENT 'The revenue contract id of the contract party record',
    `address_line1` STRING COMMENT 'First line of the partys street address.',
    `address_line2` STRING COMMENT 'Second line of the partys street address (optional).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the contract party record',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Reported annual revenue of the party for the most recent fiscal year.',
    `bank_account_number` STRING COMMENT 'Primary bank account number used for payments to the party.',
    `bank_routing_number` STRING COMMENT 'Routing number (or SWIFT/BIC) for the partys bank.',
    `city` STRING COMMENT 'City component of the partys address.',
    `contract_party_code` STRING COMMENT 'The contract party code of the contract party record',
    `contract_party_status` STRING COMMENT 'Current lifecycle status of the party relationship.',
    `country_code` STRING COMMENT 'Three‑letter country code of the partys primary address.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the contract party record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure the company is willing to extend to the party.',
    `currency_code` STRING COMMENT 'Currency used for invoicing and payments with the party.',
    `contract_party_description` STRING COMMENT 'The contract party description of the contract party record',
    `duns_number` STRING COMMENT 'Unique D&B identifier for the party.',
    `effective_end_date` DATE COMMENT 'Date when the contract party relationship ends or is scheduled to terminate (nullable for open‑ended).',
    `effective_from` DATE COMMENT 'The effective from of the contract party record',
    `effective_start_date` DATE COMMENT 'Date when the contract party relationship becomes effective.',
    `effective_until` DATE COMMENT 'The effective until of the contract party record',
    `email_address` STRING COMMENT 'Primary email address used for electronic communication with the party.',
    `industry_code` STRING COMMENT 'High‑level industry classification of the party.',
    `is_blacklisted` BOOLEAN COMMENT 'True if the party is prohibited from future transactions due to compliance issues.',
    `is_primary` BOOLEAN COMMENT 'The is primary of the contract party record',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether the party is exempt from sales tax.',
    `contract_party_name` STRING COMMENT 'Legal name of the party; for individuals this is the full personal name.',
    `notes` STRING COMMENT 'Additional remarks or comments about the party.',
    `number_of_employees` STRING COMMENT 'Total headcount of the partys organization.',
    `party_role` STRING COMMENT 'The party role of the contract party record',
    `party_type` STRING COMMENT 'Classification of the party (e.g., vendor, customer, partner, employee, government, internal, other).',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the party (e.g., Net 30, Net 60).',
    `phone_number` STRING COMMENT 'Primary telephone number for the party.',
    `postal_code` STRING COMMENT 'Postal / ZIP code of the partys address.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for contacting the party (email, phone, mail, portal).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the contract party record',
    `registration_number` STRING COMMENT 'Official registration number of the legal entity.',
    `risk_rating` STRING COMMENT 'Internal risk classification of the party based on credit and compliance assessment.',
    `segment` STRING COMMENT 'Market segment the party belongs to based on product positioning.',
    `sic_code` STRING COMMENT 'Standard Industrial Classification code describing the partys primary business activity.',
    `signatory_name` STRING COMMENT 'The signatory name of the contract party record',
    `signed_date` DATE COMMENT 'The signed date of the contract party record',
    `source_system_code` STRING COMMENT 'The source system code of the contract party record',
    `state_province` STRING COMMENT 'State or province component of the partys address.',
    `tax_number` STRING COMMENT 'Government‑issued tax identifier for the party (e.g., EIN, VAT).',
    `uom` STRING COMMENT 'The uom of the contract party record',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the contract party record.',
    CONSTRAINT pk_contract_party PRIMARY KEY(`contract_party_id`)
) COMMENT 'Master reference table for contract_party. Referenced by contract_party_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_intercompany_journal_entry_id` FOREIGN KEY (`intercompany_journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_netting_run_id` FOREIGN KEY (`netting_run_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`netting_run`(`netting_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_source_company_code_id` FOREIGN KEY (`source_company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_target_company_code_id` FOREIGN KEY (`target_company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_original_event_revenue_recognition_id` FOREIGN KEY (`original_event_revenue_recognition_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_primary_revenue_contract_id` FOREIGN KEY (`primary_revenue_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`revenue_contract`(`revenue_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_revenue_contract_id` FOREIGN KEY (`revenue_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`revenue_contract`(`revenue_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_rerun_payment_run_id` FOREIGN KEY (`rerun_payment_run_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_master_bank_account_id` FOREIGN KEY (`master_bank_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_parent_company_code_id` FOREIGN KEY (`parent_company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_parent_chart_of_accounts_id` FOREIGN KEY (`parent_chart_of_accounts_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ADD CONSTRAINT `fk_finance_controlling_area_parent_controlling_area_id` FOREIGN KEY (`parent_controlling_area_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ADD CONSTRAINT `fk_finance_controlling_area_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ADD CONSTRAINT `fk_finance_netting_run_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ADD CONSTRAINT `fk_finance_netting_run_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`party`(`party_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ADD CONSTRAINT `fk_finance_netting_run_reversal_netting_run_id` FOREIGN KEY (`reversal_netting_run_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`netting_run`(`netting_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ADD CONSTRAINT `fk_finance_revenue_contract_amended_revenue_contract_id` FOREIGN KEY (`amended_revenue_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`revenue_contract`(`revenue_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ADD CONSTRAINT `fk_finance_revenue_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_allocated_from_performance_obligation_id` FOREIGN KEY (`allocated_from_performance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`contract_party`(`contract_party_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_revenue_contract_id` FOREIGN KEY (`revenue_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`revenue_contract`(`revenue_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`party`(`party_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_reversal_material_ledger_posting_id` FOREIGN KEY (`reversal_material_ledger_posting_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting`(`material_ledger_posting_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ADD CONSTRAINT `fk_finance_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`party`(`party_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ADD CONSTRAINT `fk_finance_contract_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`party`(`party_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ADD CONSTRAINT `fk_finance_contract_party_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`party`(`party_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ADD CONSTRAINT `fk_finance_contract_party_represented_by_contract_party_id` FOREIGN KEY (`represented_by_contract_party_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`contract_party`(`contract_party_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ADD CONSTRAINT `fk_finance_contract_party_revenue_contract_id` FOREIGN KEY (`revenue_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`revenue_contract`(`revenue_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_consumer_goods_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `activity_type_indicator` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|assessment|distribution|activity_based');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `budget_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Profile Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `budget_profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|capital');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|planned');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_area` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Area');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `statistical_indicator` SET TAGS ('dbx_business_glossary_term' = 'Statistical Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'retail|wholesale|ecommerce|dtc|foodservice|export');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `consolidation_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `consolidation_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `cost_center_group_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `cost_center_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `planning_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Planning Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `product_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'product_line|brand|geography|channel|business_unit|cost_center');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `valuation_view` SET TAGS ('dbx_business_glossary_term' = 'Valuation View');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `valuation_view` SET TAGS ('dbx_value_regex' = 'legal|group|profit_center|management');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_short_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Short Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense|statistical');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_flag` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_indicator` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `blocked_for_posting` SET TAGS ('dbx_business_glossary_term' = 'Blocked For Posting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `blocked_for_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocked for Posting Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `budget_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `cash_flow_category` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `cash_flow_category` SET TAGS ('dbx_value_regex' = 'operating|investing|financing|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `cost_center_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow|retained_earnings|statistical');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `financial_statement_line_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line Item');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `intercompany_clearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Clearing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `line_item_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_name` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `open_item_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `pl_category` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `pl_statement_flag` SET TAGS ('dbx_business_glossary_term' = 'Pl Statement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `profit_center_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `retained_earnings_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Retained Earnings Account Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `sox_control_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Account Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `tax_code_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Code Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_business_glossary_term' = 'Accounting Principle');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|local_GAAP|tax|management');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_code` SET TAGS ('dbx_business_glossary_term' = 'Ledger Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `consolidation_ledger_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Ledger Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'local|group|hard|index');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_description` SET TAGS ('dbx_business_glossary_term' = 'Ledger Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `is_leading_ledger` SET TAGS ('dbx_business_glossary_term' = 'Is Leading Ledger Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `leading_ledger_flag` SET TAGS ('dbx_business_glossary_term' = 'Leading Ledger Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_status` SET TAGS ('dbx_business_glossary_term' = 'Ledger Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_type` SET TAGS ('dbx_value_regex' = 'leading|parallel|extension');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_name` SET TAGS ('dbx_business_glossary_term' = 'Ledger Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Variant');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `sox_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `supports_cost_of_sales_accounting` SET TAGS ('dbx_business_glossary_term' = 'Supports Cost of Sales (COGS) Accounting Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `supports_profit_center_accounting` SET TAGS ('dbx_business_glossary_term' = 'Supports Profit Center Accounting Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `supports_segment_reporting` SET TAGS ('dbx_business_glossary_term' = 'Supports Segment Reporting Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `valuation_view` SET TAGS ('dbx_business_glossary_term' = 'Valuation View');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `valuation_view` SET TAGS ('dbx_value_regex' = 'legal|group|profit_center|cost_center');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_posting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `baseline_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `batch_input_session` SET TAGS ('dbx_business_glossary_term' = 'Batch Input Session');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_code` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'M|B|G|P');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Header Text');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_name` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|posted|parked|cancelled|reversed');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '01|02|03|04|05|06');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `total_credit` SET TAGS ('dbx_business_glossary_term' = 'Total Credit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `total_debit` SET TAGS ('dbx_business_glossary_term' = 'Total Debit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'ledger_posting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Header Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_company_code_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Company Code Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Group Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_code` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `customer_account_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `customer_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `customer_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `customer_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `document_amount` SET TAGS ('dbx_business_glossary_term' = 'Document Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_status` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_text` SET TAGS ('dbx_business_glossary_term' = 'Line Text');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `local_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_name` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special General Ledger (GL) Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,24}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `amount_received` SET TAGS ('dbx_business_glossary_term' = 'Amount Received');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_document_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Document Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_document_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `clearing_reference` SET TAGS ('dbx_business_glossary_term' = 'Clearing Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `clearing_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_code` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `deduction_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Deduction Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `deduction_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `dso_aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO) Aging Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `dso_aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days|over_120_days');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_name` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|edi_payment|direct_debit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `trade_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Payment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_number` SET TAGS ('dbx_business_glossary_term' = 'Ar Payment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Ar Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_code` SET TAGS ('dbx_business_glossary_term' = 'Ar Payment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `days_to_pay` SET TAGS ('dbx_business_glossary_term' = 'Days to Pay');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `deduction_notes` SET TAGS ('dbx_business_glossary_term' = 'Deduction Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `deduction_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Deduction Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_description` SET TAGS ('dbx_business_glossary_term' = 'Ar Payment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `edi_transaction_set_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `edi_transaction_set_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{9,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `lockbox_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `lockbox_batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_name` SET TAGS ('dbx_business_glossary_term' = 'Ar Payment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `overpayment_flag` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `partial_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online_portal|mobile_app|edi_820|bank_transfer|lockbox|manual_entry');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire_transfer|check|credit_card|debit_card|electronic_funds_transfer');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_processor_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_processor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `remittance_advice_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `remittance_advice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,25}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `short_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Short Payment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_code` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `early_payment_discount_taken` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Taken');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_category` SET TAGS ('dbx_business_glossary_term' = 'Invoice Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|variance_pending|override_approved');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_name` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|eft|credit_card|virtual_card');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_bank_account_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_bank_account_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_bank_account_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_number` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_code` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_description` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_name` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_block_released_by` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Released By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_block_released_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Released Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire_transfer|check|EDI_820|credit_card|direct_debit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `cogs_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Allocation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `allocated_cost` SET TAGS ('dbx_business_glossary_term' = 'Allocated Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|weighted_average|fifo|standard');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `allocation_period` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `cogs_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Cogs Allocation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `cogs_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Cogs Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `costing_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Costing Lot Size');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `costing_sheet` SET TAGS ('dbx_business_glossary_term' = 'Costing Sheet');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `costing_sheet` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `costing_type` SET TAGS ('dbx_business_glossary_term' = 'Costing Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `costing_type` SET TAGS ('dbx_value_regex' = 'standard|actual|planned|simulated');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `costing_version` SET TAGS ('dbx_business_glossary_term' = 'Costing Version');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `costing_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `depreciation_cost` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `cogs_allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Cogs Allocation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `direct_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Direct Labor Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `fixed_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Fixed Overhead Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `freight_in_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight-In Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `lot_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `lot_size_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `machine_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Machine Overhead Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `cogs_allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Cogs Allocation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `other_cost` SET TAGS ('dbx_business_glossary_term' = 'Other Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `packaging_cost` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Control Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_value_regex' = 'S|V');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `raw_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'draft|released|locked|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `variable_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Variable Overhead Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ALTER COLUMN `variance_category` SET TAGS ('dbx_value_regex' = 'price|quantity|mix|yield|efficiency|volume');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `standard_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `bom_usage` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Usage');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_estimate_created_by` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_estimate_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_estimate_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_estimate_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_estimate_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_version` SET TAGS ('dbx_business_glossary_term' = 'Cost Version');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `costing_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Costing Lot Size');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `costing_lot_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Costing Lot Size Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `costing_sheet` SET TAGS ('dbx_business_glossary_term' = 'Costing Sheet');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `costing_type` SET TAGS ('dbx_business_glossary_term' = 'Costing Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `costing_type` SET TAGS ('dbx_value_regex' = 'standard|planned|actual|simulated');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `costing_version` SET TAGS ('dbx_business_glossary_term' = 'Costing Version');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_description` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `direct_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Direct Labor Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `fixed_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Fixed Overhead Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `freight_in_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight-In Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `machine_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Machine Overhead Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `other_cost` SET TAGS ('dbx_business_glossary_term' = 'Other Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Overhead Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `packaging_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `previous_standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Previous Standard Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `raw_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'draft|released|locked|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `routing_usage` SET TAGS ('dbx_business_glossary_term' = 'Routing Usage');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_status` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `total_standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `valuation_variant` SET TAGS ('dbx_business_glossary_term' = 'Valuation Variant');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `variable_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Variable Overhead Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'ledger_posting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_owner' = 'budget');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_concept' = 'finance_budget');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `primary_finance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `primary_finance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `primary_finance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `marketing_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `marketing_budget_id` SET TAGS ('dbx_ssot_xref' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|proportional|activity_based|driver_based|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|locked');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_description` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `ebitda_category` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `ebitda_category` SET TAGS ('dbx_value_regex' = 'revenue|cogs|operating_expense|depreciation|amortization|non_operating');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `ibp_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Business Planning (IBP) Integration Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `justification_notes` SET TAGS ('dbx_business_glossary_term' = 'Justification Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Budget Lock Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Budget Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'incremental|zero_based|activity_based|driver_based|rolling');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_name` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `planned_amount_group` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount Group Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `planned_amount_local` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount Local Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Profile Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|latest_estimate|forecast|rolling');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_value` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Value');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_group_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `capex_project_code` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposal Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_revaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revaluation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `revaluation_amount` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'ledger_posting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Elimination Journal Entry ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_run_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Run ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `source_company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Source Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `target_company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Target Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `arms_length_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Arms Length Validated Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `matching_status` SET TAGS ('dbx_business_glossary_term' = 'Matching Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `matching_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_name` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_status` SET TAGS ('dbx_business_glossary_term' = 'Netting Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_status` SET TAGS ('dbx_value_regex' = 'not_netted|netted|excluded_from_netting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_value_regex' = '^REC[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_document_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|posted|cleared|reconciled|eliminated|disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'goods_transfer|service_charge|management_fee|royalty|loan|dividend');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'CUP|RPM|CPM|TNMM|PSM|other');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` SET TAGS ('dbx_subdomain' = 'ledger_posting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` SET TAGS ('dbx_ssot_owner' = 'accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` SET TAGS ('dbx_ssot' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` SET TAGS ('dbx_ssot_concept' = 'finance_accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `finance_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Accrual ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `tertiary_finance_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `tertiary_finance_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `tertiary_finance_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `promotion_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Accrual Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `promotion_accrual_id` SET TAGS ('dbx_ssot_xref' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_category` SET TAGS ('dbx_business_glossary_term' = 'Accrual Category');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_category` SET TAGS ('dbx_value_regex' = 'expense|liability|revenue|asset');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_code` SET TAGS ('dbx_business_glossary_term' = 'Accrual Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_reference` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'trade_spend|marketing|bonus|warranty|rebate|freight');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Accrual Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'manual|automated_rule_based|statistical|estimated');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `calculation_method_description` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `calculation_method_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `calculation_method_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `finance_accrual_code` SET TAGS ('dbx_business_glossary_term' = 'Finance Accrual Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `finance_accrual_description` SET TAGS ('dbx_business_glossary_term' = 'Finance Accrual Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accrual Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `finance_accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Finance Accrual Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `finance_accrual_name` SET TAGS ('dbx_business_glossary_term' = 'Finance Accrual Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = 'auto_reversal|manual_correction|period_adjustment|error_correction|policy_change|estimate_update');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `sox_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley) Control ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `sox_control_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `sox_control_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `sox_control_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `tertiary_sox_tester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tester ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `tertiary_sox_tester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `tertiary_sox_tester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `sox_control_code` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Control Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Control Documentation Link');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|event-driven');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_business_glossary_term' = 'Control Nature');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_value_regex' = 'manual|automated|semi-automated');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_owner_title` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Title');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under-review|retired');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_value_regex' = 'none|control-deficiency|significant-deficiency|material-weakness');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `sox_control_description` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|ineffective|not-tested|not-applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `exceptions_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Identified Count');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `external_auditor_firm` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Firm');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `external_auditor_reviewed_indicator` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Reviewed Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `financial_statement_assertion` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Assertion');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `financial_statement_assertion` SET TAGS ('dbx_value_regex' = 'existence|completeness|accuracy|valuation|rights-and-obligations|presentation-and-disclosure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `itgc_dependent_indicator` SET TAGS ('dbx_business_glossary_term' = 'ITGC (IT General Controls) Dependent Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `key_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Key Control Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `sox_control_name` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_business_glossary_term' = 'Remediation Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not-required|planned|in-progress|completed|validated');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `risk_area` SET TAGS ('dbx_business_glossary_term' = 'Risk Area');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `sox_control_status` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `test_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Test Conclusion');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'inquiry|observation|inspection|re-performance|analytical-review');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `test_population_size` SET TAGS ('dbx_business_glossary_term' = 'Test Population Size');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `test_population_size` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `test_population_size` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `test_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Test Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `tester_name` SET TAGS ('dbx_business_glossary_term' = 'Tester Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'ledger_posting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `original_event_revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `primary_revenue_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `constraint_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Constraint Applied Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `cumulative_catch_up_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Catch-Up Adjustment');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `cumulative_catch_up_adjustment` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `cumulative_catch_up_adjustment` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_description` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `estimated_returns_reserve` SET TAGS ('dbx_business_glossary_term' = 'Estimated Returns Reserve');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_name` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `rebate_accrual` SET TAGS ('dbx_business_glossary_term' = 'Rebate Accrual');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_code` SET TAGS ('dbx_business_glossary_term' = 'Recognition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|adjusted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `recognized_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `sox_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `trade_promotion_deduction` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Deduction');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `transaction_price` SET TAGS ('dbx_business_glossary_term' = 'Transaction Price');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ALTER COLUMN `variable_consideration_estimate` SET TAGS ('dbx_business_glossary_term' = 'Variable Consideration Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_executed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_executed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_executed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `rerun_payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Rerun Payment Run Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `rerun_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_count` SET TAGS ('dbx_business_glossary_term' = 'Payment Count');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `run_reference` SET TAGS ('dbx_business_glossary_term' = 'Run Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `master_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Master Bank Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `master_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `master_bank_account_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `master_bank_account_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_business_glossary_term' = 'Account Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Tax Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Branch Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `branch_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `branch_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'Iban');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `is_joint_account` SET TAGS ('dbx_business_glossary_term' = 'Is Joint Account');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `last_reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciled Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_business_glossary_term' = 'Swift Bic');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Swift Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `parent_company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `parent_company_code_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Classification Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `company_code_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Company Code Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `company_code_description` SET TAGS ('dbx_business_glossary_term' = 'Company Code Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `is_consolidated_entity` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Entity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `is_public_company` SET TAGS ('dbx_business_glossary_term' = 'Is Public Company');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `company_code_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Value');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Chart Of Accounts Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_count` SET TAGS ('dbx_business_glossary_term' = 'Account Count');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_length` SET TAGS ('dbx_business_glossary_term' = 'Account Length');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_level` SET TAGS ('dbx_business_glossary_term' = 'Account Level');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `blocked_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocked Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_code` SET TAGS ('dbx_business_glossary_term' = 'Chart Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_description` SET TAGS ('dbx_business_glossary_term' = 'Chart Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_name` SET TAGS ('dbx_business_glossary_term' = 'Chart Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_status` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_type` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_type` SET TAGS ('dbx_business_glossary_term' = 'Chart Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `coa_code` SET TAGS ('dbx_business_glossary_term' = 'Coa Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `coa_description` SET TAGS ('dbx_business_glossary_term' = 'Coa Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `coa_name` SET TAGS ('dbx_business_glossary_term' = 'Coa Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_description` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `group_chart_flag` SET TAGS ('dbx_business_glossary_term' = 'Group Chart Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Is Blocked');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_group_chart` SET TAGS ('dbx_business_glossary_term' = 'Is Group Chart');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_operating_chart` SET TAGS ('dbx_business_glossary_term' = 'Is Operating Chart');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_operating_coa` SET TAGS ('dbx_business_glossary_term' = 'Is Operating Coa');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_operational` SET TAGS ('dbx_business_glossary_term' = 'Is Operational');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `length_of_account_number` SET TAGS ('dbx_business_glossary_term' = 'Length Of Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `length_of_account_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `length_of_account_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `length_of_gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'Length Of Gl Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `length_of_gl_account_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `length_of_gl_account_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `maintenance_language` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Language');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_name` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `parent_controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Controlling Area Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `parent_controlling_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `area_name` SET TAGS ('dbx_business_glossary_term' = 'Area Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `controlling_area_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `controlling_area_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `controlling_currency` SET TAGS ('dbx_business_glossary_term' = 'Controlling Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `cost_center_standard_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Standard Hierarchy');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `controlling_area_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `controlling_area_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`controlling_area` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `netting_run_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Run Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `reversal_netting_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Netting Run Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `reversal_netting_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `netting_run_code` SET TAGS ('dbx_business_glossary_term' = 'Netting Run Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `counterparty_count` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Count');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `netting_run_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `netting_run_name` SET TAGS ('dbx_business_glossary_term' = 'Netting Run Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `netted_amount` SET TAGS ('dbx_business_glossary_term' = 'Netted Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `netting_cycle` SET TAGS ('dbx_business_glossary_term' = 'Netting Cycle');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `netting_period` SET TAGS ('dbx_business_glossary_term' = 'Netting Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `netting_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `run_reason` SET TAGS ('dbx_business_glossary_term' = 'Run Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `run_reference` SET TAGS ('dbx_business_glossary_term' = 'Run Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `total_netted_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Netted Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `total_transactions` SET TAGS ('dbx_business_glossary_term' = 'Total Transactions');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `revenue_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contract Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `amended_revenue_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Amended Revenue Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `amended_revenue_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `revenue_contract_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `revenue_contract_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `revenue_contract_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `annual_recurring_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Recurring Revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `billing_address` SET TAGS ('dbx_business_glossary_term' = 'Billing Address');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `billing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `billing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `revenue_contract_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contract Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `revenue_contract_description` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contract Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `invoicing_address` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Address');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `invoicing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `invoicing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `revenue_contract_name` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contract Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `performance_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `revenue_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `allocated_from_performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated From Performance Obligation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `allocated_from_performance_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `revenue_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `actual_metric_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `actual_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Value');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `allocated_transaction_price` SET TAGS ('dbx_business_glossary_term' = 'Allocated Transaction Price');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `billing_schedule` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `performance_obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `is_renewable` SET TAGS ('dbx_business_glossary_term' = 'Is Renewable');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `metric_target_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Target Value');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Metric Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `performance_obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `performance_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `satisfaction_method` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `satisfaction_status` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `standalone_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Standalone Selling Price');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `standalone_selling_price` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `standalone_selling_price` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `tax_applicable` SET TAGS ('dbx_business_glossary_term' = 'Tax Applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` SET TAGS ('dbx_subdomain' = 'ledger_posting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `material_ledger_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Material Ledger Posting Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `reversal_material_ledger_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Material Ledger Posting Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `reversal_material_ledger_posting_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `amount_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Amount Adjustment');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Amount Gross');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Amount Net');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `material_ledger_posting_code` SET TAGS ('dbx_business_glossary_term' = 'Material Ledger Posting Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `cost_component` SET TAGS ('dbx_business_glossary_term' = 'Cost Component');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `material_ledger_posting_description` SET TAGS ('dbx_business_glossary_term' = 'Material Ledger Posting Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `ledger_account` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `material_ledger_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Material Ledger Posting Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `material_ledger_posting_name` SET TAGS ('dbx_business_glossary_term' = 'Material Ledger Posting Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `posting_amount` SET TAGS ('dbx_business_glossary_term' = 'Posting Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `posting_number` SET TAGS ('dbx_business_glossary_term' = 'Posting Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `posting_reference` SET TAGS ('dbx_business_glossary_term' = 'Posting Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `posting_type` SET TAGS ('dbx_business_glossary_term' = 'Posting Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `price_difference` SET TAGS ('dbx_business_glossary_term' = 'Price Difference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `valuation_area` SET TAGS ('dbx_business_glossary_term' = 'Valuation Area');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `parent_party_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Party Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `party_code` SET TAGS ('dbx_business_glossary_term' = 'Party Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `default_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `party_description` SET TAGS ('dbx_business_glossary_term' = 'Party Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Duns Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `external_party_reference` SET TAGS ('dbx_business_glossary_term' = 'External Party Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `global_location_number` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `global_location_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `global_location_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `is_blacklisted` SET TAGS ('dbx_business_glossary_term' = 'Is Blacklisted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `state` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `state` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `parent_party_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Party Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_id` SET TAGS ('dbx_renamed_from' = 'party_id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `represented_by_contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Represented By Contract Party Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `represented_by_contract_party_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `revenue_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `contract_party_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `contract_party_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `contract_party_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Description');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Duns Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `is_blacklisted` SET TAGS ('dbx_business_glossary_term' = 'Is Blacklisted');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Exempt');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `contract_party_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `contract_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `contract_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number Of Employees');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_role` SET TAGS ('dbx_business_glossary_term' = 'Party Role');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'vendor');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_customer' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_partner' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_employee' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_government' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_other' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_mail' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_portal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Sic Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`contract_party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
