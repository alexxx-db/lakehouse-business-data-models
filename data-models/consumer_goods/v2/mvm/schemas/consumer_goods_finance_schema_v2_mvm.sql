-- Schema for Domain: finance | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-27 07:48:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`finance` COMMENT 'Owns financial planning, accounting, and reporting including general ledger, accounts payable/receivable, cost accounting, COGS allocation, EBITDA reporting, DSO/DIO tracking, budgeting, revenue recognition, and SOX-compliant financial controls and audit trails. Integrates with SAP S/4HANA FI/CO and Oracle Cloud Financials.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key for the cost center master record in SAP S/4HANA CO module.',
    `company_code_id` BIGINT COMMENT 'The company code id of the cost center record',
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
    `company_code_id` BIGINT COMMENT 'Reference to the company code (legal entity) to which this GL account belongs. Links to the company_code master data.',
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
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
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
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Journal entries belong to a specific ledger; adding ledger_id FK links each entry to its ledger without removing existing ledger_group (kept for reporting).',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center for segment reporting and profitability analysis. Used for EBITDA calculation by business unit.',
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
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Journal entry lines for GR/IR accruals, goods receipt postings, and AP invoice postings reference the originating PO for three-way match audit trails and procurement-to-pay reconciliation. This is a s',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_invoice. Business justification: Journal entry lines generated from AP invoice processing reference the originating supplier invoice for AP subledger-to-GL reconciliation, audit trail completeness, and period-end AP accrual reporting',
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
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: In SAP S/4HANA FI, every AR invoice generates a corresponding FI document (journal entry) for the revenue and receivable posting. Linking ar_invoice to journal_entry enables full audit trail from trad',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: In SAP FI, AR invoices are assigned to profit centers for revenue recognition by business segment. This FK enables profit center-level revenue reporting and EBITDA analysis by segment. No redundant pr',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: ar_payment currently stores company_code as a denormalized STRING. Replacing with a proper FK to company_code.company_code_id normalizes the relationship and enables multi-entity AR reporting. The com',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ar_payment currently stores cost_center_code as a denormalized STRING. Replacing with a proper FK to cost_center.cost_center_id normalizes the relationship, enabling cost center-level cash receipt ana',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR payments store GL account code; FK to gl_account consolidates GL reference.',
    `invoice_id` BIGINT COMMENT 'Reference to the AR invoice being paid. Links payment to the originating billing document.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: AR cash receipts generate clearing journal entries in SAP FI (debit bank, credit AR). Linking ar_payment to journal_entry enables reconciliation of cash receipts to GL postings, supporting DSO trackin',
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
    `company_code_id` BIGINT COMMENT 'The company code id of the ap invoice record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ap_invoice currently stores cost_center_code as a denormalized STRING. Replacing with a proper FK to cost_center.cost_center_id normalizes the relationship, enabling cost center-level AP spend analysi',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP invoices capture GL account code; FK to gl_account creates a true parent‑child relationship and removes the code column.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document used in three-way match verification to confirm materials or services were received.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: In SAP S/4HANA FI, every AP invoice generates a corresponding FI document (journal entry) for the expense and payable posting. Linking ap_invoice to journal_entry enables full audit trail from trade p',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: ap_invoice currently stores profit_center_code as a denormalized STRING. Replacing with a proper FK to profit_center.profit_center_id normalizes the relationship, enabling JOIN-based profit center rep',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched. Used for three-way match verification.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the vendor or supplier who issued this invoice. Links to the vendor master record.',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_invoice. Business justification: The finance AP invoice (ap_invoice) should reference the procurement supplier invoice (supplier_invoice) to complete the three-way match process (PO-GR-Invoice) and enable AP subledger reconciliation.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the ap invoice record',
    `ap_invoice_number` STRING COMMENT 'The ap invoice number of the ap invoice record',
    `ap_invoice_status` STRING COMMENT 'The ap invoice status of the ap invoice record',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated. Typically the invoice date or goods receipt date depending on payment term configuration.',
    `clearing_document_number` STRING COMMENT 'The financial document number that cleared the open payable balance. Links the invoice to the payment transaction for reconciliation.',
    `ap_invoice_code` STRING COMMENT 'The ap invoice code of the ap invoice record',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: ap_payment currently stores company_code as a denormalized STRING. Replacing with a proper FK to company_code.company_code_id normalizes the relationship and enables multi-entity AP payment reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ap_payment currently stores cost_center_code as a denormalized STRING. Replacing with a proper FK to cost_center.cost_center_id normalizes the relationship, enabling cost center-level outgoing payment',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP payments include GL account code; FK to gl_account provides proper accounting linkage.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice being paid. Links to the accounts payable invoice record.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: AP outgoing payments generate clearing journal entries in SAP FI (debit AP, credit bank). Linking ap_payment to journal_entry enables reconciliation of outgoing payments to GL postings, supporting DPO',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: ap_payment currently stores profit_center_code as a denormalized STRING. Replacing with a proper FK to profit_center.profit_center_id normalizes the relationship, enabling JOIN-based profit center rep',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier receiving the payment. Links to the supplier master data.',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_invoice. Business justification: AP payments settle specific supplier invoices; this link is essential for payment-to-invoice matching, outstanding liability reporting, and cash flow forecasting. Without it, AP aging and payment stat',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the ap payment record',
    `ap_payment_number` STRING COMMENT 'The ap payment number of the ap payment record',
    `ap_payment_status` STRING COMMENT 'The ap payment status of the ap payment record',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the payment. Supports SOX-compliant audit trails and segregation of duties controls.',
    `approved_date` DATE COMMENT 'The date on which the payment was approved. Supports audit trails and payment cycle time analysis.',
    `clearing_date` DATE COMMENT 'The date on which the payment cleared the open invoice in the accounts payable subledger. Used for Days Inventory Outstanding (DIO) and working capital analysis.',
    `clearing_document_number` STRING COMMENT 'The document number assigned when the payment cleared the open invoice in the accounts payable subledger. Used for reconciliation and audit trails.',
    `ap_payment_code` STRING COMMENT 'The ap payment code of the ap payment record',
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
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the ap payment record',
    `remittance_advice_sent_date` DATE COMMENT 'The date on which the remittance advice was sent to the supplier. Used for supplier communication tracking.',
    `remittance_advice_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a remittance advice was sent to the supplier to notify them of the payment details. True indicates sent, False indicates not sent.',
    `source_system_code` STRING COMMENT 'The source system code of the ap payment record',
    `uom` STRING COMMENT 'The uom of the ap payment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the ap payment record',
    `created_by` STRING COMMENT 'User ID or name of the person who created the payment record. Supports SOX-compliant audit trails.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment record capturing outgoing payments to suppliers for raw materials, packaging, and services. Records payment date, payment method (ACH, wire, check, EDI 820), payment amount, currency, exchange rate, bank account, payment run ID, clearing document, early payment discount taken, and payment block release authorization. Supports cash flow management, supplier relationship management, and working capital optimization. Sourced from SAP S/4HANA FI-AP.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` (
    `standard_cost_id` BIGINT COMMENT 'Unique identifier for the standard cost record. Primary key for the standard cost master data.',
    `company_code_id` BIGINT COMMENT 'The company code id of the standard cost record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Standard cost records are defined per cost center; linking enables cost‑center level consolidation and provides a proper relational anchor.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Standard costs are mapped to specific GL accounts (inventory valuation accounts, COGS accounts, variance accounts) in SAP CO/FI integration. This FK enables direct linkage between standard cost record',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility where this standard cost applies. Standard costs are plant-specific in CPG manufacturing.',
    `sku_id` BIGINT COMMENT 'Reference to the material (finished good, semi-finished good, or raw material) for which this standard cost is defined. Links to the product master.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: In CPG cost accounting, standard costs for finished goods and raw materials are assigned to profit centers for segment P&L reporting and COGS allocation by business unit. This FK enables profit center',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Standard costs for purchased materials are derived from contracted prices in supplier agreements. This link enables cost accountants to trace standard cost basis to the underlying supply contract — a ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Standard costs for externally purchased materials are set based on the designated standard suppliers pricing. This link supports make-vs-buy analysis, cost variance reporting, and annual standard cos',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Primary key for company_code',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_parent_company_code_id` FOREIGN KEY (`parent_company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_consumer_goods_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Header Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Payment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_code` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Code');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'transaction_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_number` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_code` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Code');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Date');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
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
