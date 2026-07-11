-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`finance` COMMENT 'Authoritative domain for general ledger (GL), accounts payable (AP), accounts receivable (AR), fixed assets (FA), cost center management, budgeting, P&L reporting, EBITDA tracking, CapEx/OpEx classification, revenue management, royalty income accounting, and multi-entity consolidation via SAP S/4HANA. GAAP/IFRS compliant financial statements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts framework this account belongs to. Supports multiple COA structures for different regions or business units.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (company code) to which this GL account belongs. Supports multi-entity consolidation across franchise and company-owned operations.',
    `parent_account_gl_account_id` BIGINT COMMENT 'Reference to the parent account in the account hierarchy for roll-up reporting. Null for top-level accounts. Enables multi-level account group hierarchies.',
    `account_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for accounts that manage balances in a specific currency (e.g., USD, EUR, GBP). Null for accounts managed only in company code currency.. Valid values are `^[A-Z]{3}$`',
    `account_description` STRING COMMENT 'Detailed business description of the account purpose, usage guidelines, and what types of transactions should be posted to this account.',
    `account_group` STRING COMMENT 'SAP account group code that defines the accounts characteristics, field status, and number range. Controls account behavior and validation rules in SAP S/4HANA.',
    `account_name` STRING COMMENT 'Human-readable short name or title of the GL account (e.g., Food Cost - Beef, Franchise Royalty Revenue, Depreciation - Equipment).',
    `account_number` STRING COMMENT 'The externally-known unique account code used across all legal entities in the chart of accounts. Typically 6-10 digit numeric code following SAP S/4HANA GL numbering convention.. Valid values are `^[0-9]{6,10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account: active for normal use, blocked for temporarily suspended, closed for permanently retired, pending_activation for newly created accounts awaiting approval.. Valid values are `active|blocked|closed|pending_activation`',
    `account_type` STRING COMMENT 'High-level classification of the account into one of the five fundamental financial statement categories: asset, liability, equity, revenue, or expense.. Valid values are `asset|liability|equity|revenue|expense`',
    `alternate_account_number` STRING COMMENT 'Alternative or legacy account code used for cross-reference, migration mapping, or external reporting (e.g., mapping to previous ERP system account numbers).',
    `balance_sheet_classification` STRING COMMENT 'Specific balance sheet line item classification for asset, liability, and equity accounts. Set to not_applicable for P&L (Profit and Loss) accounts (revenue/expense).. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `cash_flow_classification` STRING COMMENT 'Classification of this account for cash flow statement presentation: operating for operational cash flows, investing for CapEx (Capital Expenditure) and asset transactions, financing for debt and equity, not_applicable for non-cash accounts.. Valid values are `operating|investing|financing|not_applicable`',
    `consolidation_account_number` STRING COMMENT 'Mapped account number used in corporate consolidation reporting to standardize accounts across multiple legal entities and chart of accounts structures.',
    `cost_element_category` STRING COMMENT 'Classification of cost element: primary for costs posted from external transactions (FI to CO), secondary for internal allocations and assessments, not_applicable if not a cost element.. Valid values are `primary|secondary|not_applicable`',
    `cost_element_indicator` BOOLEAN COMMENT 'Flag indicating whether this GL account is also defined as a cost element in SAP Controlling (CO) module for cost center and internal order postings.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this GL account record. Supports accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this GL account record was first created in the system. Audit trail for account master data governance.',
    `field_status_group` STRING COMMENT 'SAP field status group code that controls which fields are required, optional, or suppressed when posting transactions to this account.',
    `financial_statement_category` STRING COMMENT 'Detailed sub-classification within the account type for financial statement presentation (e.g., Current Assets, Long-Term Liabilities, Operating Revenue, Cost of Goods Sold (COGS), Selling General and Administrative (SG&A)).',
    `functional_area` STRING COMMENT 'Business function or operational area this account supports (e.g., Restaurant Operations, Franchise, Supply Chain, Marketing, Corporate, Real Estate). Used for segment reporting and management accounting.',
    `gaap_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is used in GAAP-compliant financial statements. Supports dual-ledger reporting for companies reporting under both GAAP and IFRS.',
    `ifrs_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is used in IFRS-compliant financial statements. Supports dual-ledger reporting for companies reporting under both GAAP and IFRS.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is used for intercompany transactions between legal entities that require elimination during consolidation.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this GL account record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this GL account record was last updated. Tracks changes to account master data for audit and compliance.',
    `line_item_display_indicator` BOOLEAN COMMENT 'Flag indicating whether individual line item details are stored and displayed for this account. True for most operational accounts; false for summary accounts.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or business context about this GL account (e.g., usage guidelines, approval requirements, historical context).',
    `open_item_management_indicator` BOOLEAN COMMENT 'Flag indicating whether this account uses open item management for tracking and clearing individual transactions (e.g., for clearing accounts, suspense accounts).',
    `planning_level` STRING COMMENT 'Granularity level at which budget planning and forecasting is performed for this account (e.g., corporate, region, restaurant, cost_center).',
    `posting_allowed_indicator` BOOLEAN COMMENT 'Flag indicating whether direct transaction postings are allowed to this account. False for summary/header accounts that only receive totals from sub-accounts.',
    `profit_loss_classification` STRING COMMENT 'Specific P&L statement line item classification for revenue and expense accounts (e.g., Sales Revenue, COGS (Cost of Goods Sold), Labor Cost, Occupancy Cost, EBITDA (Earnings Before Interest Taxes Depreciation and Amortization)). Null for balance sheet accounts.',
    `reconciliation_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a reconciliation account (subledger control account) that summarizes detailed transactions from AP (Accounts Payable), AR (Accounts Receivable), or FA (Fixed Assets) subledgers.',
    `segment_reporting_indicator` BOOLEAN COMMENT 'Flag indicating whether transactions posted to this account are included in segment reporting for business unit, geographic, or product line analysis.',
    `sort_key` STRING COMMENT 'SAP sort key that determines the default sorting and grouping of line items posted to this account (e.g., by posting date, document number, or business partner).',
    `statistical_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a statistical account used for tracking non-monetary quantities (e.g., headcount, transaction counts, cover counts) without affecting financial balances.',
    `tax_category` STRING COMMENT 'Tax treatment classification for this account (e.g., taxable_revenue, non_taxable_revenue, input_tax, output_tax, exempt). Used for sales tax, VAT, and GST reporting.',
    `valid_from_date` DATE COMMENT 'Date from which this GL account becomes active and available for transaction posting. Supports time-dependent account master data.',
    `valid_to_date` DATE COMMENT 'Date until which this GL account remains active. Null for accounts with no planned end date. Used for account retirement and historical reporting.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'Chart of accounts master record for the general ledger in SAP S/4HANA (CO/GL modules). Defines every account code used across all legal entities, including P&L accounts, balance sheet accounts, cost element accounts, and statistical accounts. Supports multi-entity consolidation, GAAP/IFRS dual-ledger reporting, and account group hierarchies. Each record carries account type (asset, liability, equity, revenue, expense), functional area, account group, and currency settings.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key.',
    `franchisee_id` BIGINT COMMENT 'The unique identifier of the franchisee who owns/operates this cost center. Nullable for company-owned units. Links to franchise agreement, royalty rate, and franchise fee structures in FranConnect.',
    `hierarchy_node_id` BIGINT COMMENT 'The identifier of the node in the cost center standard hierarchy. Used to roll up costs from individual units to regions to divisions to corporate totals for consolidated P&L reporting.',
    `site_id` BIGINT COMMENT 'Foreign key reference to the physical location or restaurant unit profile. Links cost center to real estate, address, and site selection data. Nullable for non-location-based cost centers (e.g., corporate departments).',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Cost allocation and budgeting are performed per territory; linking cost_center to territory enables territory‑level expense reporting.',
    `brand_code` STRING COMMENT 'The brand identifier for multi-brand restaurant portfolios. Examples: QSR1, CASUAL2, FINE3. Used for brand-level P&L reporting, brand standard compliance, and marketing campaign segmentation.. Valid values are `^[A-Z0-9]{2,6}$`',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved annual budget amount for this cost center in local currency. Used for variance analysis, Labor% and COGS% target setting, and OpEx control. Updated during annual budgeting cycles and mid-year reforecasts.',
    `budget_year` STRING COMMENT 'The fiscal year for which the budget_amount is applicable. Enables multi-year budget tracking and year-over-year variance analysis.',
    `business_area_code` STRING COMMENT 'The SAP business area classification. Used to segment financial reporting by line of business (e.g., QSR, casual dining, catering, franchise operations) for multi-brand or multi-format portfolios.. Valid values are `^[A-Z0-9]{4}$`',
    `capex_eligible_flag` BOOLEAN COMMENT 'Indicates whether this cost center is eligible to receive capital expenditure allocations. True for restaurant units (equipment, R&M), distribution centers, and major corporate facilities. False for pure administrative departments. Used to distinguish CapEx from OpEx in financial reporting.',
    `cost_center_category` STRING COMMENT 'High-level categorization of the cost centers role. Revenue-generating centers (FOH, BOH) directly contribute to sales; support centers (maintenance, training) enable operations; administrative centers (HR, finance) provide governance; overhead centers (facilities, utilities) are indirect; capital project centers track CapEx initiatives.. Valid values are `revenue_generating|support|administrative|overhead|capital_project`',
    `cost_center_code` STRING COMMENT 'The externally-known alphanumeric code for the cost center as defined in SAP S/4HANA Controlling module. Used in financial reporting and P&L statements.. Valid values are `^[A-Z0-9]{4,12}$`',
    `cogs_percent_target` DECIMAL(18,2) COMMENT 'The target COGS% (cost of goods sold as a percentage of revenue) for this cost center. Critical KPI for food cost management. Typical QSR targets range from 25-35%. Used for menu engineering, pricing strategy, and supplier negotiations.',
    `company_code` STRING COMMENT 'The SAP company code (legal entity) to which this cost center belongs. Used for GAAP/IFRS financial statement consolidation and statutory reporting. Company-owned units vs franchise entities are distinguished here.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'The SAP Controlling Area to which this cost center belongs. Controlling areas represent the highest level of cost accounting organization, typically aligned with legal entities or major geographic regions for multi-entity consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active centers accept cost postings; inactive centers are temporarily disabled; pending centers are awaiting approval; closed centers are permanently retired; suspended centers are on hold; planned centers are scheduled for future activation (e.g., NRO pipeline).. Valid values are `active|inactive|pending|closed|suspended|planned`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by organizational function. Restaurant units are individual QSR locations; regional offices manage geographic territories; corporate departments are headquarters functions; shared service centers provide centralized support; distribution centers handle supply chain; franchise support manages franchisee relations.. Valid values are `restaurant_unit|regional_office|corporate_department|shared_service_center|distribution_center|franchise_support`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where this cost center operates. Used for multi-country consolidation, currency translation, and jurisdiction-specific compliance (FDA, USDA, local health departments).. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'The user ID of the person who created this cost center record. Used for audit trails and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost center record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for this cost centers local currency. Used for budget planning, cost allocation, and multi-currency consolidation in GAAP/IFRS financial statements.. Valid values are `^[A-Z]{3}$`',
    `cost_center_description` STRING COMMENT 'Free-text description providing additional context about this cost centers purpose, scope, or special characteristics. Used for documentation and reporting clarity.',
    `drive_thru_lanes` STRING COMMENT 'The number of drive-thru lanes at this location. Nullable for non-DT formats. Critical for SOS (Speed of Service) analysis, throughput capacity planning, and DT-specific cost allocation.',
    `format_code` STRING COMMENT 'The restaurant format classification. Examples: DT (Drive-Thru), DINE_IN, KIOSK, FOOD_COURT, AIRPORT, GHOST_KITCHEN. Used for format-specific cost benchmarking, throughput analysis, and real estate site selection.. Valid values are `^[A-Z0-9]{2,6}$`',
    `franchise_flag` BOOLEAN COMMENT 'Indicates whether this cost center represents a franchise-owned unit (true) or a company-owned unit (false). Critical for revenue recognition (royalty income vs direct sales), P&L consolidation, and franchise compliance tracking.',
    `functional_area_code` STRING COMMENT 'The functional area classification for inter-unit-code reporting. Typical values include operations, marketing, R&D, administration, IT, finance. Used for functional P&L views and OpEx analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `labor_percent_target` DECIMAL(18,2) COMMENT 'The target Labor% (labor cost as a percentage of revenue) for this cost center. Critical KPI for restaurant operations. Typical QSR targets range from 20-30%. Used for workforce scheduling optimization and P&L performance evaluation.',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this cost center record. Used for audit trails and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost center record was last updated. Used for change tracking and data freshness validation.',
    `cost_center_name` STRING COMMENT 'The full business name of the cost center (e.g., Store #1234 - Downtown Chicago, Regional Office - Midwest, Corporate HR Department).',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or historical context. Examples: Undergoing renovation Q2 2024, Pilot location for new POS system, Seasonal closure Nov-Mar.',
    `opex_allocation_method` STRING COMMENT 'The method used to allocate shared operating expenses to this cost center. Direct costs are posted directly; allocated methods distribute corporate overhead based on revenue, headcount, square footage, transaction volume, or fixed percentages. Used for full-absorption P&L reporting.. Valid values are `direct|allocated_revenue|allocated_headcount|allocated_sqft|allocated_transactions|fixed_percentage`',
    `parent_cost_center_code` STRING COMMENT 'The cost center code of the immediate parent in the organizational hierarchy. Nullable for top-level cost centers. Enables recursive hierarchy traversal for regional and corporate rollups.',
    `profit_center_code` STRING COMMENT 'The profit center assignment for this cost center. Profit centers are used for internal P&L reporting and EBITDA tracking. Restaurant units typically map 1:1 to profit centers; corporate departments may roll up to shared profit centers.. Valid values are `^[A-Z0-9]{4,10}$`',
    `region_code` STRING COMMENT 'The geographic region code for this cost center. Used for regional P&L rollups, SSS (Same-Store Sales) analysis, and regional manager accountability. Examples: NEAST, SWEST, MIDWEST, INTL.. Valid values are `^[A-Z]{2,4}$`',
    `seating_capacity` STRING COMMENT 'The number of customer seats available at this cost center location. Nullable for non-dine-in formats (drive-thru only, ghost kitchens). Used for cover count analysis, table turn calculations, and throughput benchmarking.',
    `square_footage` STRING COMMENT 'The total interior square footage of this cost center facility. Used for OpEx allocation (utilities, CAM charges), productivity metrics (sales per square foot), and real estate valuation.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center becomes effective and can accept cost postings. Aligns with NRO (New Restaurant Opening) dates for restaurant units or organizational change effective dates for corporate centers.',
    `valid_to_date` DATE COMMENT 'The date through which this cost center remains effective. Nullable for open-ended cost centers. Populated when a restaurant closes, a department is dissolved, or a regional office is consolidated.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center master data and cost allocation activity from SAP S/4HANA CO module. Represents the smallest unit of cost accountability — individual restaurant units, regional offices, corporate departments, and shared service centers. Master data tracks cost center type (restaurant, regional, corporate), responsible manager, controlling area, profit center assignment, valid-from/to dates, and hierarchy node. Allocation activity captures periodic distributions of shared costs (corporate overhead, IT, HR, marketing fund) using defined allocation keys (headcount, revenue, square footage), including sender/receiver relationships, allocation cycles, allocation rules, basis amounts, and reversal indicators. Enables fully-loaded restaurant P&L, Labor%/COGS%/OpEx allocation, accurate EBITDA by unit, and transparent overhead burden rates for franchise vs. company-owned comparisons.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for the profit center master record in SAP S/4HANA EC-PCA module.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Consolidated profit‑center financial reporting per franchisee needs a direct FK; the business runs profit‑center performance dashboards by franchisee.',
    `hierarchy_node_id` BIGINT COMMENT 'Identifier of the node in the profit center standard hierarchy. Used for roll-up reporting and multi-level P&L consolidation.',
    `parent_profit_center_id` BIGINT COMMENT 'Reference to the parent profit center in the organizational hierarchy. Enables recursive roll-up for regional and brand-level P&L aggregation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for profit center manager assignment used in monthly P&L reporting to attribute financial results to a responsible employee.',
    `unit_id` BIGINT COMMENT 'Reference to the physical restaurant unit if this profit center represents a single location. Null for aggregated profit centers (regional, brand-level).',
    `aov_target_amount` DECIMAL(18,2) COMMENT 'Target annual revenue for this profit center expressed in the profit centers functional currency. Used for AUV benchmarking and performance variance analysis.',
    `brand_code` STRING COMMENT 'Code identifying the restaurant brand or concept associated with this profit center (e.g., QSR Brand A, Casual Dining Brand B). Supports brand-level AUV and SSS reporting.',
    `business_area_code` STRING COMMENT 'SAP business area code for inter-unit-code reporting. Enables consolidated P&L views across multiple legal entities within the same business segment.',
    `profit_center_category` STRING COMMENT 'Functional category of the profit center. Operating centers generate direct revenue; non-operating centers represent overhead or shared services allocated to operating units.. Valid values are `operating|non_operating|corporate|shared_services`',
    `closure_date` DATE COMMENT 'Date the profit center ceased operations. Null for active profit centers. Used for historical P&L analysis and closed-unit portfolio reporting.',
    `closure_reason` STRING COMMENT 'Business reason for profit center closure (e.g., lease expiration, underperformance, market exit, franchise termination). Used for portfolio optimization analysis.',
    `profit_center_code` STRING COMMENT 'Business identifier code for the profit center as defined in SAP controlling area. Used in financial reporting and P&L statements.. Valid values are `^[A-Z0-9]{4,10}$`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity to which this profit center belongs. Used for external financial reporting and GAAP/IFRS compliance.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_unit_code` STRING COMMENT 'Code identifying the consolidation unit for multi-entity financial consolidation. Used in GAAP/IFRS-compliant consolidated financial statement preparation.',
    `controlling_area_code` STRING COMMENT 'SAP controlling area to which this profit center is assigned. Controlling area represents the organizational unit for cost accounting and internal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_group_code` STRING COMMENT 'Code of the cost center group associated with this profit center. Links profit center P&L to underlying cost center actuals for COGS and OpEx analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for P&L reporting (e.g., USD, EUR, GBP). Determines the functional currency for this profit centers financial transactions.. Valid values are `^[A-Z]{3}$`',
    `ebitda_target_amount` DECIMAL(18,2) COMMENT 'Target EBITDA for this profit center expressed in the profit centers functional currency. Used for profitability benchmarking and executive performance evaluation.',
    `geographic_region_code` STRING COMMENT 'Code representing the geographic region (e.g., Northeast, Southwest, EMEA, APAC). Used for regional P&L consolidation and market performance analysis.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this profit center record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was last updated. Used for change tracking and data quality monitoring.',
    `lock_indicator` BOOLEAN COMMENT 'Flag indicating whether the profit center is locked for transaction posting. Locked centers cannot receive new P&L entries but remain visible for historical reporting.',
    `marketing_fund_rate_percent` DECIMAL(18,2) COMMENT 'Marketing fund contribution rate percentage for franchise profit centers. Represents the percentage of gross sales contributed to the brand marketing fund.',
    `profit_center_name` STRING COMMENT 'Full descriptive name of the profit center (e.g., Downtown Chicago QSR Unit 1234, Northeast Regional Franchise Group, Company-Owned Casual Dining Segment).',
    `notes` STRING COMMENT 'Free-text notes and comments about the profit center. Used to document special circumstances, organizational changes, or reporting exceptions.',
    `opening_date` DATE COMMENT 'Date the profit center commenced operations. Used to calculate operating tenure for SSS eligibility and maturity-based performance benchmarking.',
    `ownership_model` STRING COMMENT 'Ownership structure of the profit center. Determines revenue recognition treatment, royalty income accounting, and CapEx/OpEx allocation rules.. Valid values are `company_owned|franchise|joint_venture|licensed`',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center. Active centers participate in P&L reporting; inactive centers are excluded from current period consolidation.. Valid values are `active|inactive|pending|closed`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Royalty rate percentage applied to franchise profit centers. Represents the percentage of gross sales remitted to the franchisor as ongoing royalty income.',
    `segment_reporting_flag` BOOLEAN COMMENT 'Indicates whether this profit center is a reportable segment under GAAP ASC 280 or IFRS 8. Reportable segments require separate disclosure in external financial statements.',
    `segment_type` STRING COMMENT 'Classification of the profit center by business segment type. Determines the level of P&L aggregation and reporting hierarchy.. Valid values are `restaurant_unit|brand_segment|geographic_region|franchise_group|company_owned_group|channel_segment`',
    `short_name` STRING COMMENT 'Abbreviated name or alias for the profit center used in reports and dashboards for space-constrained displays.',
    `sss_eligible_flag` BOOLEAN COMMENT 'Indicates whether this profit center is included in Same-Store Sales (SSS) / Comparable Store Sales (Comp Sales) calculations. Typically requires 12+ months of operating history.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the primary tax jurisdiction for this profit center. Determines applicable sales tax, VAT, and income tax treatment in P&L reporting.',
    `valid_from_date` DATE COMMENT 'Effective start date for this profit center record. Profit center becomes active for P&L posting and reporting from this date forward.',
    `valid_to_date` DATE COMMENT 'Effective end date for this profit center record. Profit center is excluded from P&L posting and reporting after this date. Null for open-ended validity.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Profit center master record from SAP S/4HANA EC-PCA module. Represents a business segment for internal P&L reporting — individual restaurant units, brand segments, geographic regions, or franchise vs. company-owned groupings. Supports SSS (Same-Store Sales) reporting, AUV (Average Unit Volume) tracking, and EBITDA decomposition by segment. Carries hierarchy assignment, controlling area, and responsible executive.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Identifier of the chart of accounts assigned to this legal entity in SAP S/4HANA FI. Defines the GL account structure for financial postings.',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Foreign key reference to the parent legal entity in the corporate hierarchy. Null for the ultimate parent company.',
    `primary_ultimate_parent_entity_legal_entity_id` BIGINT COMMENT 'Foreign key reference to the top-level parent entity in the corporate structure. Used for ultimate consolidation and consolidated financial reporting.',
    `accounting_standard` STRING COMMENT 'Primary accounting framework used for financial statement preparation. GAAP for US entities, IFRS for international, or local statutory standards.. Valid values are `GAAP|IFRS|local_statutory`',
    `address_line_1` STRING COMMENT 'First line of the legal entitys registered office address as filed with corporate registry.',
    `address_line_2` STRING COMMENT 'Second line of the legal entitys registered office address (suite, floor, building name).',
    `city` STRING COMMENT 'City or municipality of the legal entitys registered office.',
    `company_code` STRING COMMENT 'Four-character alphanumeric code uniquely identifying the legal entity in SAP S/4HANA FI. Used as the organizational unit for financial accounting and external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_group_code` STRING COMMENT 'Identifier of the consolidation group or reporting segment this entity belongs to for multi-entity financial consolidation.',
    `consolidation_method` STRING COMMENT 'Method used to consolidate this entitys financial results into consolidated financial reporting. Full for subsidiaries, equity for associates, none for non-consolidated entities.. Valid values are `full|proportionate|equity|none`',
    `controlling_area` STRING COMMENT 'SAP S/4HANA organizational unit for cost accounting, internal reporting, and profitability analysis. May span multiple company codes.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the legal entitys registered office address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was first created in the system.',
    `credit_control_area` STRING COMMENT 'SAP S/4HANA organizational unit for managing customer credit limits and credit exposure across one or more company codes.',
    `dissolution_date` DATE COMMENT 'Date the legal entity was officially dissolved or ceased operations. Null for active entities.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet for business credit and supplier management.. Valid values are `^[0-9]{9}$`',
    `effective_from_date` DATE COMMENT 'Date from which this legal entity record is effective for financial posting and reporting. Used for time-dependent organizational changes.',
    `effective_to_date` DATE COMMENT 'Date until which this legal entity record is effective. Null for currently active entities. Used for historical tracking of organizational changes.',
    `entity_status` STRING COMMENT 'Current operational and legal status of the entity. Active entities post transactions; inactive entities are retained for historical reporting.. Valid values are `active|inactive|dormant|liquidation|dissolved`',
    `entity_type` STRING COMMENT 'Classification of the legal entity structure. Determines ownership model, consolidation treatment, and reporting obligations.. Valid values are `company_owned|franchise_subsidiary|holding_company|joint_venture|partnership|branch`',
    `fiscal_year_end_month` STRING COMMENT 'Month number (1-12) representing the end of the entitys fiscal year. 12 = December for calendar year entities.',
    `fiscal_year_variant` STRING COMMENT 'Code defining the fiscal year calendar structure (e.g., calendar year, 4-4-5 retail calendar, 52/53 week year) used by this entity.',
    `incorporation_date` DATE COMMENT 'Date the legal entity was officially registered or incorporated with the governing jurisdiction.',
    `intercompany_clearing_flag` BOOLEAN COMMENT 'Indicates whether this entity participates in automated intercompany clearing and reconciliation processes for intra-group transactions.',
    `jurisdiction_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the jurisdiction where the entity is incorporated and legally domiciled.. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_state_province` STRING COMMENT 'State, province, or sub-national jurisdiction where the entity is registered. Relevant for federal systems (USA, Canada, etc.).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was last updated.',
    `legal_name` STRING COMMENT 'Full registered legal name of the entity as filed with government authorities. Used on official financial statements, tax filings, and legal contracts.',
    `lei_code` STRING COMMENT '20-character alphanumeric Legal Entity Identifier issued by the Global LEI Foundation for financial transaction reporting and regulatory compliance.. Valid values are `^[A-Z0-9]{20}$`',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the entitys functional currency for financial reporting and local statutory books.. Valid values are `^[A-Z]{3}$`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity ownership held by the parent entity. 100.00 for wholly-owned subsidiaries, less for joint ventures or minority interests.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the legal entitys registered office.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for the legal entity.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact or registered agent for the legal entity.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact for the legal entity.',
    `profit_center_required_flag` BOOLEAN COMMENT 'Indicates whether profit center assignment is mandatory for all financial postings in this legal entity. True enforces segment reporting compliance.',
    `registration_number` STRING COMMENT 'Official registration or incorporation number assigned by the jurisdictions corporate registry.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code used for consolidated consolidated financial reporting. Typically USD for US-based parent companies.. Valid values are `^[A-Z]{3}$`',
    `segment_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this entity is subject to segment reporting requirements under GAAP ASC 280 or IFRS 8.',
    `short_name` STRING COMMENT 'Abbreviated or trade name used for internal reporting and operational reference.',
    `state_province` STRING COMMENT 'State, province, or region of the legal entitys registered office.',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identifier (EIN in USA, VAT number in EU, etc.) used for tax filing and reporting.',
    `vat_registration_number` STRING COMMENT 'VAT or GST registration number for entities operating in jurisdictions with value-added tax systems. Used for tax reporting and invoice compliance.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master record for each legal entity (company code) within the Restaurants corporate structure and intercompany transaction activity from SAP S/4HANA FI. Covers company-owned operating entities, holding companies, franchise subsidiaries, and joint ventures across all geographies. Entity master stores fiscal year variant, chart of accounts assignment, local currency, tax jurisdiction, GAAP/IFRS reporting standard, and consolidation group membership. Intercompany activity captures management fee charges, shared service allocations, intercompany loans, cross-entity food supply transfers, netting status, elimination flags, and reconciliation periods. Foundation for multi-entity financial consolidation, intercompany elimination in consolidated financial statements, and segment reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry header in SAP S/4HANA FI-GL.',
    `employee_id` BIGINT COMMENT 'SAP user ID of the person who approved this journal entry for posting. Populated only for entries requiring approval workflow. Used for segregation of duties compliance.',
    `approver_user_employee_id` BIGINT COMMENT 'SAP user ID of the person who approved this journal entry for posting. Populated only for entries requiring approval workflow. Used for segregation of duties compliance.',
    `journal_employee_id` BIGINT COMMENT 'SAP user ID of the person or system account that posted this journal entry. Used for audit trail and segregation of duties monitoring.',
    `journal_last_modified_user_employee_id` BIGINT COMMENT 'SAP user ID of the person who last modified this journal entry header (e.g., added notes, changed status). Blank if never modified after initial posting.',
    `primary_journal_employee_id` BIGINT COMMENT 'SAP user ID of the person or system account that posted this journal entry. Used for audit trail and segregation of duties monitoring.',
    `adjustment_period_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry was posted in a special adjustment period (periods 13-16) for year-end close. True if adjustment period; False if regular period.',
    `approval_timestamp` TIMESTAMP COMMENT 'Exact date and time when the journal entry was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if no approval required or not yet approved.',
    `audit_class` STRING COMMENT 'Classification of the journal entry for audit sampling and risk assessment. Values: standard (routine posting), high_risk (unusual or large amount), manual_adjustment (manual journal entry requiring scrutiny), system_generated (automated posting).. Valid values are `standard|high_risk|manual_adjustment|system_generated`',
    `baseline_payment_date` DATE COMMENT 'The baseline date from which payment terms are calculated (typically document date or posting date). Used to determine net due date and discount periods. Format: yyyy-MM-dd.',
    `batch_input_session` STRING COMMENT 'Name of the batch input session if this journal entry was posted via batch processing (e.g., mass upload, automated interface). Blank for manually posted entries.',
    `clearing_date` DATE COMMENT 'The date on which this journal entry was cleared. Populated only for cleared documents. Format: yyyy-MM-dd.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing document if this journal entry has been cleared (e.g., open item cleared by payment or offsetting entry). Blank if not cleared.. Valid values are `^[0-9]{10}$`',
    `company_code` STRING COMMENT 'Four-character alphanumeric code identifying the legal entity within the SAP organizational structure. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for purposes of external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_transaction_type` STRING COMMENT 'Three-character code classifying the journal entry for consolidation purposes (e.g., 100=standard posting, 200=intercompany elimination, 300=currency translation adjustment, 400=consolidation adjustment). Used in multi-entity financial consolidation.. Valid values are `^[A-Z0-9]{3}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the document currency (e.g., USD, EUR, GBP). All line item amounts in this journal entry are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date printed on the source document (invoice date, receipt date, contract date). May differ from posting date. Used for aging analysis and payment terms calculation. Format: yyyy-MM-dd.',
    `document_header_text` STRING COMMENT 'Free-text description or memo entered at the document header level. Provides business context for the journal entry (e.g., Monthly depreciation run, Accrual for Q4 marketing expenses).',
    `document_number` STRING COMMENT 'Ten-digit accounting document number assigned by SAP upon posting. The externally-known unique identifier for this journal entry within the company code and fiscal year. Used for audit trail and cross-reference.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'Two-character code classifying the nature of the accounting document (e.g., SA=GL account document, KR=vendor invoice, DR=customer invoice, AB=accounting document, AA=asset posting). Controls number ranges and posting keys.. Valid values are `^[A-Z]{2}$`',
    `entry_date` DATE COMMENT 'The calendar date on which the document was entered into the SAP system by the user. Used for audit trail and processing time analysis. Format: yyyy-MM-dd.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert document currency to local currency at the time of posting. Expressed as local currency per one unit of document currency.',
    `fiscal_period` STRING COMMENT 'Numeric posting period within the fiscal year (1-12 for regular periods, 13-16 for special/adjustment periods). Used for monthly P&L reporting and period-end close.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year in which the document is posted. Determines the accounting period structure and year-end closing scope.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry involves intercompany transactions between multiple legal entities within the corporate group. True if intercompany; False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Exact date and time of the last modification to this journal entry header. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if never modified.',
    `ledger_group` STRING COMMENT 'Two-character code identifying the ledger in which this entry is posted (e.g., 0L=leading ledger for GAAP, 2L=IFRS ledger, 3L=management ledger). Supports parallel accounting for multiple reporting standards.. Valid values are `^[A-Z0-9]{2}$`',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company code local currency. Used for statutory reporting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `net_due_date` DATE COMMENT 'The calculated due date for payment based on payment terms and baseline date. Used for cash flow forecasting and AP/AR aging. Format: yyyy-MM-dd.',
    `parked_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is in parked status (saved but not yet posted). True if parked; False if posted. Parked documents do not update GL balances until posted.',
    `payment_terms_code` STRING COMMENT 'Four-character code defining payment terms for vendor invoices or customer invoices (e.g., net 30, 2/10 net 30). Used to calculate due dates and cash discount eligibility.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger. Determines the fiscal period assignment and is the primary date for financial reporting. Format: yyyy-MM-dd.',
    `posting_key` STRING COMMENT 'Two-digit numeric code that controls the type of posting (debit or credit) and the account type (e.g., 40=debit GL, 50=credit GL, 01=debit customer, 31=debit vendor). Determines field status and processing logic.. Valid values are `^[0-9]{2}$`',
    `posting_timestamp` TIMESTAMP COMMENT 'Exact date and time when the journal entry was posted to the general ledger. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and real-time reporting.',
    `reference_document_number` STRING COMMENT 'Free-text field for external reference numbers such as vendor invoice number, purchase order number, or intercompany document reference. Used for reconciliation and audit trail.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a prior posting. True if this document reverses another document; False otherwise.',
    `reversal_reason_code` STRING COMMENT 'Two-character code explaining why the document was reversed (e.g., 01=reversal in current period, 02=reversal in next period, 03=error correction). Populated only for reversal documents.. Valid values are `^[A-Z0-9]{2}$`',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is True. Maintains audit trail for accrual reversals and error corrections.. Valid values are `^[0-9]{10}$`',
    `source_system_code` STRING COMMENT 'Code identifying the originating system for this journal entry (e.g., SAP_ECC, SAP_S4, LEGACY_GL, COUPA, WORKDAY). Used for data lineage and interface reconciliation.. Valid values are `^[A-Z0-9]{3,10}$`',
    `tax_reporting_date` DATE COMMENT 'The date used for tax reporting purposes (may differ from posting date based on jurisdiction rules). Used for VAT/GST returns and sales tax filings. Format: yyyy-MM-dd.',
    `trading_partner_company_code` STRING COMMENT 'Four-character company code of the intercompany trading partner. Populated only when intercompany_indicator is True. Used for intercompany reconciliation and elimination entries.. Valid values are `^[A-Z0-9]{4}$`',
    `transaction_code` STRING COMMENT 'SAP transaction code (T-code) used to create this journal entry (e.g., FB01, FB50, F-02). Indicates the posting method and user interface path.. Valid values are `^[A-Z0-9_]{4,10}$`',
    `workflow_status` STRING COMMENT 'Current state of the journal entry in the approval workflow. Values: draft (initial entry), pending_approval (submitted for review), approved (authorized but not posted), posted (final state in GL), rejected (not approved), cancelled (voided before posting).. Valid values are `draft|pending_approval|approved|posted|rejected|cancelled`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry from SAP S/4HANA FI-GL, encompassing both header and line-level detail. Captures every financial posting across all legal entities — accruals, reversals, intercompany eliminations, period-end adjustments, and manual corrections. Header stores document type, posting date, fiscal period, reference document, ledger (leading/non-leading), currency, and posting user. Each line carries GL account, cost center, profit center, functional area, business area, debit/credit amount in document and local currency, tax code, assignment field, and line item text. The authoritative audit trail for all GL movements supporting GAAP/IFRS compliance, P&L drill-down, balance sheet construction, intercompany reconciliation, and external audit evidence.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for granular GL transaction tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link line to cost_center master to normalize cost center details.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset master record if this line represents a fixed asset transaction (acquisition, depreciation, disposal). Null for non-FA entries.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace gl_account_code with authoritative FK to gl_account for detailed account attributes.',
    `profile_id` BIGINT COMMENT 'Reference to the customer master record if this line represents an accounts receivable transaction. Null for non-AR entries.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header. Links this line to the overall accounting document.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor master record if this line represents an accounts payable transaction. Null for non-AP entries.',
    `journal_profile_id` BIGINT COMMENT 'Reference to the customer master record if this line represents an accounts receivable transaction. Null for non-AR entries.',
    `journal_vendor_procurement_supplier_id` BIGINT COMMENT 'Reference to the vendor master record if this line represents an accounts payable transaction. Null for non-AP entries.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Link line to profit_center master for consistent profit center data.',
    `amount_document_currency` DECIMAL(18,2) COMMENT 'Transaction amount in the original document currency. Used for multi-currency transactions before conversion to local currency.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Transaction amount converted to the local reporting currency of the legal entity. Used for consolidated financial statements.',
    `assignment_field` STRING COMMENT 'Free-text assignment field for additional reference information. Often used for invoice numbers, PO numbers, or internal tracking codes.',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms calculation. Typically the invoice date or goods receipt date.',
    `business_area_code` STRING COMMENT 'Business area for segment reporting. May represent franchise vs. company-owned, or QSR vs. casual dining divisions.. Valid values are `^[A-Z0-9]{2,6}$`',
    `clearing_date` DATE COMMENT 'Date on which this open item was cleared (paid or settled). Null if still open.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing entry that settled this open item. Null if the line item is still open.',
    `company_code` STRING COMMENT 'Four-character company code representing the legal entity. Required for multi-entity consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line is a debit (D) or credit (C) entry. Fundamental to double-entry bookkeeping.. Valid values are `D|C`',
    `document_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the document currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date of the source document (invoice date, receipt date). May differ from posting date for backdated or future-dated entries.',
    `due_date` DATE COMMENT 'Payment due date for AP/AR line items. Calculated based on posting date and payment terms. Null for non-payable/receivable entries.',
    `entry_date` DATE COMMENT 'Date on which the journal entry was created in the system. Audit trail for data entry timing.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied to convert document currency to local currency. Null if currencies are the same.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year. Typically 1-12 for monthly periods, or 1-13 for year-end adjustments.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this line item is posted. Derived from the posting date and fiscal calendar configuration.',
    `functional_area_code` STRING COMMENT 'Functional area classification for cost-of-sales accounting. Distinguishes COGS, labor, R&M, marketing, and administrative expenses.. Valid values are `^[A-Z0-9]{2,6}$`',
    `line_item_text` STRING COMMENT 'Descriptive text explaining the purpose or nature of this journal entry line. Provides business context for the transaction.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry. Determines the order of debit and credit entries.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local reporting currency.. Valid values are `^[A-Z]{3}$`',
    `payment_terms_code` STRING COMMENT 'Payment terms code for AP/AR line items. Defines due date calculation and discount terms.. Valid values are `^[A-Z0-9]{2,6}$`',
    `posting_date` DATE COMMENT 'Date on which this line item was posted to the general ledger. Determines the fiscal period assignment.',
    `posting_key` STRING COMMENT 'Two-digit posting key that controls the account type (GL, vendor, customer, asset) and debit/credit indicator. SAP-specific control field.. Valid values are `^[0-9]{2}$`',
    `reference_document_number` STRING COMMENT 'External reference document number (e.g., vendor invoice number, customer receipt number). Links GL entry to source transaction.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this line item is a reversal entry. True if this line reverses a prior posting.',
    `reversed_document_number` STRING COMMENT 'Document number of the original entry that this line reverses. Null if not a reversal.',
    `special_gl_indicator` STRING COMMENT 'Single-character code for special GL transactions (e.g., down payments, guarantees, bills of exchange). Blank for standard postings.. Valid values are `^[A-Z]$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for this line item in local currency. Null if the line is non-taxable.',
    `tax_code` STRING COMMENT 'Tax code applied to this line item. Determines sales tax, VAT, or GST treatment for revenue and expense transactions.. Valid values are `^[A-Z0-9]{2,6}$`',
    `trading_partner_code` STRING COMMENT 'Trading partner code for intercompany transactions. Identifies the counterparty legal entity for consolidation and elimination entries.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_code` STRING COMMENT 'SAP transaction code (T-code) used to create this entry (e.g., FB01, FB50, MIRO). Audit trail for process identification.. Valid values are `^[A-Z0-9]{4,8}$`',
    `user_name` STRING COMMENT 'SAP user ID of the person who created this journal entry line. Audit trail for accountability.',
    `value_date` DATE COMMENT 'Value date for cash management and bank reconciliation. Represents the effective date funds are available or debited.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit/credit line items within a GL journal entry from SAP S/4HANA FI-GL. Each line carries GL account, cost center, profit center, functional area, business area, amount in document and local currency, tax code, assignment field, and line item text. Enables granular P&L and balance sheet drill-down, cost center reporting, and intercompany reconciliation at the line level.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key.',
    `employee_id` BIGINT COMMENT 'The user ID of the person who created the invoice record in the system. Used for audit trail and accountability.',
    `ap_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the invoice for payment. Used for audit trail and segregation of duties compliance.',
    `ap_modified_by_user_employee_id` BIGINT COMMENT 'The user ID of the person who last modified the invoice record. Used for audit trail and change accountability.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier or vendor who issued this invoice. Links to vendor master data.',
    `unit_id` BIGINT COMMENT 'Identifier for the restaurant location or unit to which this invoice expense is allocated. Used for unit-level P&L and Average Unit Volume (AUV) analysis.',
    `ap_unit_id` BIGINT COMMENT 'Identifier for the restaurant location or unit to which this invoice expense is allocated. Used for unit-level P&L and Average Unit Volume (AUV) analysis.',
    `ap_vendor_procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the supplier or vendor who issued this invoice. Links to vendor master data.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the invoice for payment. Used for audit trail and segregation of duties compliance.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Allows AP invoices for marketing media purchases to be tied to the originating campaign, supporting financial reconciliation and campaign ROI calculations.',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment. Used for tracking approval cycle time and compliance with payment policies.',
    `approval_status` STRING COMMENT 'Status of the invoice approval workflow. Indicates whether the invoice has been reviewed and approved for payment by authorized personnel.. Valid values are `pending|approved|rejected`',
    `company_code` STRING COMMENT 'Four-character code representing the legal entity or company within the enterprise for which this invoice is recorded. Used for multi-entity consolidation and P&L reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'The cost center to which the invoice expense is allocated. Used for departmental cost tracking and management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice, including early payment discounts, volume discounts, or promotional allowances.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms. Used for cash flow forecasting and aging analysis.',
    `dunning_level` STRING COMMENT 'The dunning level or escalation stage for overdue invoices. Zero indicates no dunning. Higher numbers indicate escalated collection efforts.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert foreign currency invoice amounts to the company code local currency. Null for invoices in local currency.',
    `expense_category` STRING COMMENT 'High-level categorization of the invoice expense type. Used for Cost of Goods Sold (COGS) percentage and Operating Expense (OpEx) tracking.. Valid values are `food_beverage|equipment|repairs_maintenance|utilities|services|other`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice was posted. Used for monthly financial close and period-over-period analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice was posted, derived from the posting date. Used for annual financial reporting and year-over-year analysis.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the invoice expense is posted. Used for P&L reporting and financial statement preparation.',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number confirming physical receipt of goods or services. Used for three-way matching.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before any deductions, including line item charges and taxes. Represents the full amount billed by the vendor.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the principal business event timestamp for the invoice transaction.',
    `invoice_description` STRING COMMENT 'Free-text description or memo field providing additional context about the invoice, such as the nature of goods or services purchased.',
    `invoice_number` STRING COMMENT 'The vendor-assigned invoice number as printed on the supplier invoice document. This is the externally-known business identifier for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow.. Valid values are `draft|posted|approved|paid|cancelled|on_hold`',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type (standard invoice, credit memo for returns, debit memo for additional charges, prepayment, or recurring invoice).. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Net invoice amount converted to the company code local currency using the exchange rate. Used for consolidated financial reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was last modified. Used for audit trail and change tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount payable to the vendor after applying discounts and adjustments. This is the amount that will be paid.',
    `payment_block_indicator` STRING COMMENT 'Code indicating whether payment is blocked and the reason for the block (e.g., pricing dispute, quantity variance, quality issue). Empty if no block is active.',
    `payment_date` DATE COMMENT 'The date the invoice was actually paid to the vendor. Null if the invoice is unpaid.',
    `payment_method` STRING COMMENT 'The payment instrument or method used to pay the invoice (check, ACH, wire transfer, credit card, cash).. Valid values are `check|ach|wire_transfer|credit_card|cash`',
    `payment_reference_number` STRING COMMENT 'The payment document number or transaction reference assigned when the invoice was paid. Used for payment reconciliation and audit trail.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the vendor (e.g., Net 30, 2/10 Net 30). Determines due date calculation and early payment discount eligibility.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger. Used for period assignment and financial reporting.',
    `purchase_order_number` STRING COMMENT 'The purchase order number against which this invoice is being verified. Used for three-way matching and spend tracking.',
    `reference_document_number` STRING COMMENT 'Reference to a related document such as the original invoice for a credit memo, or a contract number. Provides audit trail and document linkage.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice, including sales tax, VAT, GST, or other applicable taxes.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing purchase order (PO), goods receipt (GR), and invoice. Indicates whether the invoice matches the PO and GR within tolerance or has variances.. Valid values are `matched|variance_quantity|variance_price|variance_gr|not_applicable|pending`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the invoice payment as required by tax regulations. Reduces the net payment to the vendor.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable vendor invoice and payment lifecycle from SAP S/4HANA FI-AP, encompassing invoice header, line-level detail, and outbound payment settlement. Records all supplier invoices for food and beverage purchases, equipment, R&M, utilities, and services. Header stores vendor ID, invoice date, due date, payment terms, gross/net amount, tax, currency, payment block, three-way match status, and dunning level. Each line captures purchased item/service, quantity, unit price, GL account, cost center, PO reference, goods receipt reference, and tax code. Payment data stores payment method (ACH, wire, check), payment date, bank account, cleared invoice references, discount taken, and payment run ID. Enables COGS% analysis by ingredient category, food vs. non-food spend split, three-way match reconciliation, DPO (Days Payable Outstanding) tracking, cash discount optimization, and cash flow forecasting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` (
    `ap_invoice_line_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice line item. Primary key for the AP invoice line detail record.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location that will consume or utilize this purchased item. Enables location-level COGS and OpEx analysis for unit economics.',
    `ap_unit_id` BIGINT COMMENT 'Reference to the restaurant location that will consume or utilize this purchased item. Enables location-level COGS and OpEx analysis for unit economics.',
    `contract_id` BIGINT COMMENT 'Reference to the supplier contract governing pricing and terms for this purchase. Enables contract compliance validation and price variance analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Normalize cost center reference by linking to cost_center master.',
    `employee_id` BIGINT COMMENT 'User ID or name of the person who approved this invoice line for payment. Provides audit trail for financial controls and segregation of duties compliance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace gl_account_code with FK to gl_account for authoritative account details.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document confirming physical delivery of items. Critical for three-way match validation in procurement cycle.',
    `ingredient_id` BIGINT COMMENT 'Reference to the material master record for the purchased item. Links to inventory SKU for food ingredients, packaging, and supplies.',
    `ap_invoice_id` BIGINT COMMENT 'Reference to the parent AP invoice header record. Links this line item to its parent invoice document.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order for this invoice line. Used for three-way match reconciliation between PO, goods receipt, and invoice.',
    `procurement_supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor providing the goods or services. Enables supplier spend analysis and vendor performance tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Normalize profit center reference by linking to profit_center master.',
    `stock_item_id` BIGINT COMMENT 'Reference to the material master record for the purchased item. Links to inventory SKU for food ingredients, packaging, and supplies.',
    `approval_status` STRING COMMENT 'Current approval workflow status for this invoice line. Pending indicates awaiting review; approved indicates cleared for payment; rejected indicates dispute or error.. Valid values are `pending|approved|rejected|on_hold`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line was approved for payment. Documents the approval event for audit trail and payment processing timing.',
    `asset_number` STRING COMMENT 'Fixed asset number if this line represents a capital expenditure. Links invoice to asset master for depreciation tracking and asset lifecycle management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was first created in the system. Provides audit trail for data lineage and invoice processing timeline.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line (e.g., USD, EUR, GBP). Supports multi-currency procurement for global operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'Date when the goods or services were delivered to the restaurant or distribution center. Used for lead time analysis and inventory valuation timing.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this invoice line. May include volume discounts, promotional allowances, or early payment discounts negotiated with supplier.',
    `expense_category` STRING COMMENT 'High-level classification of the expense type. Enables COGS% analysis by ingredient category and food vs. non-food spend split for restaurant operations. [ENUM-REF-CANDIDATE: food|beverage|packaging|supplies|equipment|maintenance|utilities|services|other — 9 candidates stripped; promote to reference product]',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when this invoice line was posted. Enables monthly P&L reporting and period-over-period variance analysis.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this invoice line was posted. Supports multi-year financial analysis and year-over-year COGS trend reporting.',
    `goods_receipt_line_number` STRING COMMENT 'Specific line number on the goods receipt document that this invoice line references. Enables line-level matching between GR and invoice.',
    `internal_order_number` STRING COMMENT 'Internal order number for project or campaign-specific expense tracking. Used for CapEx projects, NRO (New Restaurant Opening), or marketing campaigns.',
    `invoice_date` DATE COMMENT 'Date when the supplier issued the invoice. Used for payment terms calculation and aging analysis in accounts payable management.',
    `is_capex` BOOLEAN COMMENT 'Boolean flag indicating whether this line item represents a capital expenditure. True for equipment, facility improvements, and long-term assets; false for operating expenses.',
    `is_cogs` BOOLEAN COMMENT 'Boolean flag indicating whether this line item is classified as Cost of Goods Sold. True for food, beverage, and packaging; false for OpEx items.',
    `line_amount` DECIMAL(18,2) COMMENT 'Total amount for this invoice line before tax (quantity × unit price). Represents the net line value for GL posting and COGS analysis.',
    `line_number` STRING COMMENT 'Sequential line item number within the invoice. Determines the ordering and position of this line in the invoice document.',
    `line_type` STRING COMMENT 'Classification of the invoice line item indicating whether it represents a purchased item, service, freight charge, tax, discount, or surcharge.. Valid values are `item|service|freight|tax|discount|surcharge`',
    `match_status` STRING COMMENT 'Status of the three-way match reconciliation between purchase order, goods receipt, and invoice. Matched indicates successful validation; variance indicates discrepancies requiring review.. Valid values are `matched|unmatched|variance|blocked`',
    `material_code` STRING COMMENT 'Stock Keeping Unit (SKU) code for the purchased material. Business-readable identifier for inventory items and ingredients.',
    `material_description` STRING COMMENT 'Full text description of the purchased material or service. Provides human-readable detail about the line item for reporting and analysis.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this invoice line record. Provides accountability for changes and supports audit trail requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was last modified. Tracks changes for audit trail and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text notes or comments about this invoice line. May include special instructions, variance explanations, or additional context for accounting and operations teams.',
    `payment_terms` STRING COMMENT 'Payment terms code defining the due date calculation and early payment discount eligibility (e.g., Net 30, 2/10 Net 30). Inherited from supplier master or contract.',
    `posting_date` DATE COMMENT 'Date when this invoice line was posted to the general ledger. Determines the accounting period for financial statement recognition and COGS timing.',
    `purchase_order_line_number` STRING COMMENT 'Specific line number on the purchase order that this invoice line references. Enables line-level matching between PO and invoice.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the material or service invoiced on this line. Used for unit price calculation and variance analysis against PO and GR quantities.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this invoice line. Includes sales tax, VAT, or GST based on applicable jurisdiction and tax code.',
    `tax_code` STRING COMMENT 'Tax jurisdiction and rate code applied to this line item. Determines sales tax, VAT, or GST calculation based on location and product taxability.',
    `total_line_amount` DECIMAL(18,2) COMMENT 'Final total amount for this invoice line including tax and discounts (line_amount + tax_amount - discount_amount). Represents the complete line value for payment.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the invoiced quantity (e.g., EA for each, LB for pounds, CS for cases, GAL for gallons). Critical for foodservice ingredient procurement.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure for this line item. Used to calculate line amount and analyze price variance against PO and contract pricing.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary variance between invoice line amount and expected amount based on PO and GR. Positive values indicate overcharges; negative values indicate undercharges requiring investigation.',
    `variance_reason` STRING COMMENT 'Explanation or reason code for any variance between invoice and expected amounts. Documents price changes, quantity discrepancies, or billing errors for audit trail.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for project accounting. Enables detailed cost tracking for capital projects, renovations, and multi-phase initiatives.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this invoice line record. Supports audit trail and accountability for data entry and invoice processing.',
    CONSTRAINT pk_ap_invoice_line PRIMARY KEY(`ap_invoice_line_id`)
) COMMENT 'Line-level detail for accounts payable invoices from SAP S/4HANA FI-AP. Each line captures the purchased item or service, quantity, unit price, GL account assignment, cost center, purchase order reference, goods receipt reference, tax code, and line amount. Enables COGS% analysis by ingredient category, food vs. non-food spend split, and three-way match reconciliation at the SKU level.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment transaction. Primary key.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the vendor receiving payment. Links to food suppliers, equipment vendors, landlords, and service providers.',
    `ap_vendor_procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the vendor receiving payment. Links to food suppliers, equipment vendors, landlords, and service providers.',
    `bank_account_id` BIGINT COMMENT 'Identifier for the companys bank account from which payment was debited. Used for cash management and bank reconciliation.',
    `employee_id` BIGINT COMMENT 'User ID or system identifier that initiated the payment run or created the payment document.',
    `payment_run_id` BIGINT COMMENT 'Identifier for the batch payment run that generated this payment. Groups multiple payments processed together.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the companys payment account.',
    `business_area` STRING COMMENT 'Business area or division code for inter-unit reporting (e.g., QSR, casual dining, franchise operations).',
    `clearing_date` DATE COMMENT 'Date when the payment cleared the companys bank account and funds were debited. Null if not yet cleared.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity making the payment. Used for multi-entity consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'Cost center code charged for this payment. Used for Profit and Loss (P&L) reporting and Operating Expenditure (OpEx) tracking.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system. Used for audit trail and compliance reporting.',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'Cash discount amount deducted from invoice total for early payment. Supports supplier relationship management and Cost of Goods Sold (COGS) optimization.',
    `document_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the payment amount (e.g., USD, CAD, EUR, GBP, MXN).. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied to convert document currency to local currency. Null if currencies are the same.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when payment was posted. Used for monthly Profit and Loss (P&L) reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the payment was posted. Used for period-based financial reporting and year-end closing.',
    `gl_account` STRING COMMENT 'General ledger account number to which payment expense is posted. Supports GAAP/IFRS compliant financial statements.. Valid values are `^[0-9]{6,10}$`',
    `invoice_count` STRING COMMENT 'Number of invoices cleared by this payment. A single payment may settle multiple invoices.',
    `local_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the company codes local reporting currency.. Valid values are `^[A-Z]{3}$`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the company codes local currency for consolidation and Profit and Loss (P&L) reporting.',
    `modified_by` STRING COMMENT 'User ID of the last person who modified the payment record (e.g., status change, cancellation, reversal).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment record. Used for change tracking and audit compliance.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total payment amount in document currency. Net amount remitted to vendor after discounts and adjustments.',
    `payment_block_reason` STRING COMMENT 'Reason code if payment was blocked or held for review (e.g., duplicate invoice, pricing dispute, quality issue). Null if not blocked.',
    `payment_date` DATE COMMENT 'Date the payment was issued or scheduled to be sent to the vendor. Principal business event timestamp for cash management and Days Payable Outstanding (DPO) tracking.',
    `payment_description` STRING COMMENT 'Free-text description or memo field providing additional context about the payment purpose or special handling instructions.',
    `payment_document_number` STRING COMMENT 'SAP payment document number assigned during payment run. Externally-known business identifier for this payment.. Valid values are `^[A-Z0-9]{10}$`',
    `payment_method` STRING COMMENT 'Payment instrument used to remit funds to vendor. ACH (Automated Clearing House) for domestic electronic transfers, wire for same-day transfers, check for paper-based payments, EFT for general electronic transfers, virtual card for card-based B2B payments.. Valid values are `ACH|wire_transfer|check|electronic_funds_transfer|virtual_card|international_wire`',
    `payment_priority` STRING COMMENT 'Priority level assigned to payment for processing sequence. Urgent for critical suppliers, high for preferred vendors, normal for standard terms, low for deferred payments.. Valid values are `urgent|high|normal|low`',
    `payment_processor` STRING COMMENT 'Name of third-party payment processor or banking partner used to execute the payment (e.g., JP Morgan, Bank of America, Citibank).',
    `payment_reference_number` STRING COMMENT 'Bank-assigned reference or confirmation number for the payment transaction. Used for reconciliation and dispute resolution.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment. Pending: scheduled but not yet sent. Processed: sent to bank. Cleared: funds debited from company account. Failed: rejected by bank. Cancelled: voided before processing. Reversed: reversed after clearing.. Valid values are `pending|processed|cleared|failed|cancelled|reversed`',
    `payment_terms` STRING COMMENT 'Payment terms code applied to this payment (e.g., Net 30, 2/10 Net 30). Determines discount eligibility and due date calculation.',
    `payment_type` STRING COMMENT 'Classification of payment purpose. Vendor invoice for goods/services, credit memo for returns, down payment for Capital Expenditure (CapEx) projects, advance payment for future delivery, expense reimbursement for employee-paid vendor costs.. Valid values are `vendor_invoice|credit_memo|down_payment|advance_payment|expense_reimbursement`',
    `profit_center` STRING COMMENT 'Profit center code for internal management reporting. Used for segment profitability analysis and Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) tracking.. Valid values are `^[A-Z0-9]{6,10}$`',
    `reconciliation_status` STRING COMMENT 'Bank reconciliation status indicating whether payment has been matched to bank statement. Unreconciled: not yet matched. Reconciled: matched to bank statement. Exception: discrepancy found. Pending review: awaiting manual review.. Valid values are `unreconciled|reconciled|exception|pending_review`',
    `remittance_email` STRING COMMENT 'Vendor email address to which remittance advice is sent. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `value_date` DATE COMMENT 'Date when funds are expected to be available in the vendors account. Used for cash flow forecasting.',
    `vendor_account_number` STRING COMMENT 'Vendors bank account number or payment account identifier used for remittance.',
    `vendor_name` STRING COMMENT 'Legal name of the vendor receiving payment.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld from payment per regulatory requirements. Remitted separately to tax authorities.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment run records from SAP S/4HANA FI-AP. Captures outbound payments to food suppliers, equipment vendors, landlords (CAM charges), and service providers. Stores payment method (ACH, wire, check), payment date, bank account, cleared invoice references, discount taken, payment amount in local and document currency, and payment run ID. Supports cash management, DPO (Days Payable Outstanding) tracking, and supplier relationship management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts receivable invoice record. Primary key.',
    `profile_id` BIGINT COMMENT 'Identifier of the customer or franchisee being billed. Links to customer master data for billing party details.',
    `unit_id` BIGINT COMMENT 'Restaurant location associated with the invoice when billing is location-specific (e.g., royalty based on location sales). Null for corporate-level billings.',
    `ar_profile_id` BIGINT COMMENT 'Identifier of the customer or franchisee being billed. Links to customer master data for billing party details.',
    `ar_unit_id` BIGINT COMMENT 'Restaurant location associated with the invoice when billing is location-specific (e.g., royalty based on location sales). Null for corporate-level billings.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link AR invoice to cost_center master to avoid duplicated code values.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee when the invoice is for royalty or franchise fee billing. Null for non-franchise revenue streams.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace string GL account reference with FK to gl_account for consistency.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Link AR invoice to profit_center master for consistent reporting.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Manual adjustments applied to the invoice for credits, rebates, or billing corrections. Can be positive or negative.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for invoice mailing. Includes street number and name.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address for suite, apartment, or building information. Optional field.',
    `billing_city` STRING COMMENT 'City name for the billing address. Used for invoice mailing and tax jurisdiction determination.',
    `billing_contact_name` STRING COMMENT 'Name of the primary billing contact at the customer or franchisee organization. Used for invoice delivery and payment inquiries.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166 country code for the billing address. Used for international invoicing and tax compliance.. Valid values are `^[A-Z]{3}$`',
    `billing_email` STRING COMMENT 'Email address for electronic invoice delivery and billing communications. Primary channel for invoice distribution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_period_end_date` DATE COMMENT 'End date of the period covered by this invoice. Used for royalty and franchise fee revenue recognition alignment.',
    `billing_period_start_date` DATE COMMENT 'Start date of the period covered by this invoice. Relevant for royalty invoices based on monthly or weekly sales performance.',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address. Required for invoice delivery and tax jurisdiction determination.',
    `billing_state_province` STRING COMMENT 'State or province code for the billing address. Used for tax calculation and regulatory reporting.',
    `business_area` STRING COMMENT 'SAP business area for segment reporting. Enables P&L analysis by brand, region, or business unit.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity issuing the invoice. Used for multi-entity consolidation and legal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created the invoice record. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, GBP). Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the invoice. May include early payment discounts, volume discounts, or promotional adjustments.',
    `due_date` DATE COMMENT 'Date by which payment is expected based on payment terms. Used for aging analysis and dunning trigger calculations.',
    `dunning_level` STRING COMMENT 'Current dunning level for overdue invoices. Indicates escalation stage in the collection process (0=no dunning, 1=first reminder, 2=second reminder, 3=final notice, etc.).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied for foreign currency invoices to convert to company reporting currency. Null for domestic currency transactions.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes, discounts, or adjustments. Represents the base billing amount for goods or services.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued. Represents the business event date for revenue recognition and aging calculations.',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice number assigned by SAP S/4HANA for customer billing. Used for customer communication and payment reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the collection workflow. Tracks progression from draft through payment to closure or write-off. [ENUM-REF-CANDIDATE: draft|open|partially_paid|paid|overdue|written_off|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on revenue stream: royalty invoices to franchisees, franchise fee billings, catering and corporate account charges, gift card liability settlements, intercompany charges, or rebate billings.. Valid values are `royalty|franchise_fee|catering|gift_card_settlement|intercompany|rebate`',
    `last_dunning_date` DATE COMMENT 'Date the most recent dunning notice was sent to the customer. Used to track collection activity and determine next dunning action.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the invoice record. Used for change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was last modified. Tracks changes for audit and data quality monitoring.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final invoice amount due after applying taxes, discounts, and adjustments. This is the amount the customer must pay.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the invoice. May include special billing instructions, dispute details, or collection notes.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid amount on the invoice. Updated as payments are received and applied. Zero when invoice is fully paid.',
    `payment_method` STRING COMMENT 'Expected or preferred payment method for this invoice. Guides payment processing and reconciliation.. Valid values are `ach|wire_transfer|check|credit_card|direct_debit|cash`',
    `payment_reference` STRING COMMENT 'Reference number or identifier provided to customer for payment remittance. Used for automated payment matching and reconciliation.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreement (e.g., Net 30, Net 15, Due on Receipt). Determines due date calculation and discount eligibility.. Valid values are `^[A-Z0-9]{2,10}$`',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger. May differ from invoice date due to period-end processing or batch posting.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue from this invoice is recognized for financial reporting purposes. May differ from invoice date per GAAP/IFRS revenue recognition rules.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on the invoice. Includes sales tax, VAT, or other applicable taxes based on jurisdiction.',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable invoice and payment lifecycle from SAP S/4HANA FI-AR. Covers all revenue-generating billings and their collection: royalty invoices to franchisees, catering and corporate account billings, gift card liability settlements, and intercompany charges. Invoice data stores customer/franchisee ID, invoice date, due date, payment terms, gross amount, tax, currency, dunning level, and collection status. Payment receipt data captures payment method, receipt date, bank clearing account, applied invoice references, unapplied cash amounts, and DSO (Days Sales Outstanding) impact. Supports royalty income accounting, franchise fee revenue recognition (ASC 606/IFRS 15), franchisee cash flow monitoring, and aging analysis.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` (
    `ar_payment_id` BIGINT COMMENT 'Unique identifier for the accounts receivable payment record. Primary key.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank clearing account where the payment was deposited. Links to cash management and bank reconciliation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Normalize cost center reference on AR payment.',
    `profile_id` BIGINT COMMENT 'Reference to the customer (franchisee, corporate catering client, or intercompany entity) who made the payment.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace GL account code with FK to gl_account for authoritative data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Normalize profit center reference on AR payment.',
    `ach_trace_number` STRING COMMENT 'The ACH network trace number for ACH payments. Enables tracking and reconciliation of electronic payments.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been allocated to specific invoices. Used to track payment application progress.',
    `check_number` STRING COMMENT 'The check number for check payments. Null for electronic payment methods. Used for audit trails and bank reconciliation.',
    `clearing_date` DATE COMMENT 'The date when the payment cleared the bank and funds were confirmed available. May differ from receipt date for checks and ACH.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity receiving the payment. Supports multi-entity consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `created_by_user` STRING COMMENT 'The SAP user ID who created the payment record. Used for audit trails and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when the payment record was first created in SAP. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the payment amount (e.g., USD, EUR, GBP). Required for multi-currency operations and foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'The early payment discount amount deducted by the customer when paying within discount terms. Reduces net cash received.',
    `dso_impact_days` STRING COMMENT 'The number of days between invoice due date and payment receipt date. Used to calculate DSO metrics and monitor collection efficiency.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert payment currency to company code functional currency. Null for domestic currency payments.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) when the payment was posted. Ranges from 1-12 for standard calendar periods, with special periods for year-end adjustments.',
    `fiscal_year` STRING COMMENT 'The fiscal year when the payment was posted. Derived from posting date and used for period-based financial reporting.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the company code functional currency using the exchange rate. Used for consolidated financial reporting.',
    `modified_by_user` STRING COMMENT 'The SAP user ID who last modified the payment record. Used for audit trails and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when the payment record was last modified. Used for audit trails and data synchronization.',
    `notes` STRING COMMENT 'Free-text notes or comments about the payment. Used to document special circumstances, customer communications, or application instructions.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the payment received, before any deductions or allocations. Expressed in the payment currency.',
    `payment_document_number` STRING COMMENT 'The externally-known SAP payment document number assigned to this AR payment receipt. Used for reconciliation and audit trails.. Valid values are `^[A-Z0-9]{10}$`',
    `payment_method` STRING COMMENT 'The financial instrument used for payment: wire transfer, ACH (Automated Clearing House), check, credit card, debit card, or cash.. Valid values are `wire_transfer|ach|check|credit_card|debit_card|cash`',
    `payment_processor` STRING COMMENT 'The third-party payment processor or gateway used for credit card or digital payments (e.g., Stripe, PayPal, Square). Null for direct bank payments.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment: received (entered), cleared (bank confirmed), applied (allocated to invoices), partially applied, unapplied (cash on account), reversed, or voided. [ENUM-REF-CANDIDATE: received|cleared|applied|partially_applied|unapplied|reversed|voided — 7 candidates stripped; promote to reference product]',
    `payment_type` STRING COMMENT 'Classification of the payment purpose: royalty income, franchise fees, marketing fund contributions, catering invoice payments, or intercompany settlements.. Valid values are `royalty|franchise_fee|marketing_fund|catering_invoice|intercompany_settlement|other`',
    `posting_date` DATE COMMENT 'The accounting period date when the payment was posted to the general ledger. Determines which fiscal period recognizes the cash receipt.',
    `receipt_date` DATE COMMENT 'The business date when the payment was received and recorded in the AR system. Used for Days Sales Outstanding (DSO) calculation and revenue recognition.',
    `reference_number` STRING COMMENT 'Customer-provided reference number or remittance advice identifier. Used to match payments to invoices during application.',
    `reversal_date` DATE COMMENT 'The date when the payment was reversed. Null for non-reversed payments. Used for audit trails and financial period corrections.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this payment has been reversed. True if reversed, False if active. Reversed payments remain in history for audit trails.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for payment reversal (e.g., NSF - non-sufficient funds, duplicate entry, customer dispute, bank error). Null for non-reversed payments. [ENUM-REF-CANDIDATE: NSF|duplicate|dispute|bank_error|wrong_account|fraud|other — promote to reference product]',
    `transaction_reference` STRING COMMENT 'The payment processor transaction identifier for card or digital wallet payments. Used for chargeback management and reconciliation.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that remains unallocated to invoices. Represents cash on account or overpayments requiring future application.',
    `wire_confirmation_number` STRING COMMENT 'Bank-provided confirmation or trace number for wire transfer payments. Used for payment verification and dispute resolution.',
    CONSTRAINT pk_ar_payment PRIMARY KEY(`ar_payment_id`)
) COMMENT 'Accounts receivable payment receipt records from SAP S/4HANA FI-AR. Captures inbound payments from franchisees (royalties, franchise fees, marketing fund contributions), corporate catering clients, and intercompany settlements. Stores payment method, receipt date, bank clearing account, applied invoice references, unapplied cash amounts, and DSO (Days Sales Outstanding) impact. Critical for royalty income reconciliation and franchise cash flow monitoring.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key sourced from SAP S/4HANA FI-AA asset master.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the asset was purchased. Links to vendor master for procurement and warranty tracking.',
    `fixed_vendor_procurement_supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the asset was purchased. Links to vendor master for procurement and warranty tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager responsible for the custody and maintenance of the asset. Supports accountability and asset stewardship.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location or corporate facility where the asset is physically located. Links to location master for site-level asset reporting.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since acquisition. Contra-asset account that reduces the gross book value to net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of the fixed asset at acquisition including purchase price, installation, freight, and other directly attributable costs. Recorded in USD.',
    `acquisition_date` DATE COMMENT 'Date when the fixed asset was acquired or placed into service. Used as the start date for depreciation calculations and useful life tracking.',
    `asset_class` STRING COMMENT 'Classification category of the fixed asset used for grouping and reporting. Determines depreciation rules and capitalization thresholds per GAAP/IFRS standards.. Valid values are `kitchen_equipment|pos_hardware|leasehold_improvements|furniture_fixtures|vehicles|it_infrastructure`',
    `asset_description` STRING COMMENT 'Detailed business description of the fixed asset including make, model, and specifications (e.g., Vulcan 6-Burner Gas Range Model XYZ123).',
    `asset_number` STRING COMMENT 'Externally-known unique asset tag or serial number assigned to the fixed asset for tracking and identification purposes. Used for physical asset verification and audit trails.. Valid values are `^[A-Z0-9]{8,12}$`',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Determines whether depreciation is active and whether the asset appears on the balance sheet. [ENUM-REF-CANDIDATE: active|in_service|under_construction|retired|disposed|impaired|held_for_sale — 7 candidates stripped; promote to reference product]',
    `asset_subclass` STRING COMMENT 'Detailed sub-classification within the asset class for granular tracking (e.g., Fryers, Grills, KDS Units under kitchen_equipment).',
    `capex_project_code` STRING COMMENT 'Reference code linking the asset to the originating capital expenditure project or budget line item. Supports CapEx tracking and ROI analysis.. Valid values are `^[A-Z]{3}-[0-9]{6}$`',
    `cost_center_code` STRING COMMENT 'SAP cost center code to which depreciation expense is allocated. Supports P&L reporting by organizational unit and enables labor% and CoGS% analysis.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in the SAP S/4HANA system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost and book value (e.g., USD, EUR, GBP). Supports multi-currency consolidation for international operations.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate periodic depreciation expense. Straight-line is most common for restaurant equipment; declining balance may be used for vehicles.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `disposal_date` DATE COMMENT 'Date when the asset was retired, sold, or otherwise disposed of. Triggers final depreciation calculation and removal from active asset register.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed of. Determines accounting treatment and tax implications for gain/loss recognition.. Valid values are `sold|scrapped|donated|traded_in|transferred`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value received from the sale or disposal of the asset. Used to calculate gain or loss on disposal for P&L reporting.',
    `gl_account_code` STRING COMMENT 'General ledger account code for the asset account in the chart of accounts. Used for financial statement preparation and GAAP/IFRS compliance.. Valid values are `^[0-9]{6,10}$`',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset has been tested for impairment and found to have a carrying value exceeding its recoverable amount per GAAP/IFRS standards.',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Amount of impairment loss recognized when the assets carrying value exceeds its fair value or value in use. Recorded as a non-cash charge to P&L.',
    `insurance_policy_number` STRING COMMENT 'Policy number for property and casualty insurance covering the asset. Used for claims processing and risk management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was last updated in the SAP S/4HANA system. Supports change tracking and audit compliance.',
    `last_physical_inventory_date` DATE COMMENT 'Date of the most recent physical verification or audit of the asset. Supports SOX compliance and internal control over fixed assets.',
    `lease_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset is subject to a lease agreement (finance lease or operating lease under ASC 842 / IFRS 16). Determines right-of-use asset treatment.',
    `manufacturer_name` STRING COMMENT 'Name of the equipment manufacturer or brand (e.g., Vulcan, Hobart, NCR). Supports vendor performance analysis and standardization initiatives.',
    `model_number` STRING COMMENT 'Manufacturer model number or SKU for the asset. Used for parts ordering, service manuals, and replacement planning.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset calculated as acquisition cost minus accumulated depreciation. Represents the asset value on the balance sheet.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, or historical context about the asset (e.g., Replaced due to fire damage 2022-03-15).',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the asset acquisition. Provides audit trail to procurement documentation and invoice matching.. Valid values are `^PO-[0-9]{8,10}$`',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Subtracted from acquisition cost to determine depreciable base.',
    `serial_number` STRING COMMENT 'Manufacturer serial number for the asset. Used for warranty claims, service tracking, and theft recovery.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected useful life of the asset in years as determined by GAAP/IFRS guidelines and company policy. Used to calculate annual depreciation expense.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty expires. Used to plan for extended service contracts and budget for repairs and maintenance (R&M).',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master record, depreciation lifecycle, and impairment tracking from SAP S/4HANA FI-AA. Tracks all capitalized assets across company-owned restaurants and corporate facilities: kitchen equipment (fryers, grills, KDS units), POS hardware, leasehold improvements, furniture and fixtures, vehicles, and IT infrastructure. Master data stores asset class, acquisition date, acquisition cost, useful life, depreciation method, salvage value, and CapEx project reference. Depreciation detail captures periodic planned/posted depreciation by fiscal period, depreciation area (book, tax, IFRS), depreciation amount, accumulated depreciation, net book value, and depreciation key. Supports CapEx vs. OpEx classification, EBITDA calculation (adding back D&A), tax depreciation schedules, impairment testing, and asset disposal/retirement processing for restaurant closures and remodels.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` (
    `asset_depreciation_id` BIGINT COMMENT 'Unique identifier for the asset depreciation posting record. Primary key for the asset_depreciation product.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location where the asset is deployed. Supports location-level asset tracking and P&L allocation for restaurant operations.',
    `asset_unit_id` BIGINT COMMENT 'Reference to the restaurant location where the asset is deployed. Supports location-level asset tracking and P&L allocation for restaurant operations.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset being depreciated. Links to the fixed asset master record in SAP FI-AA.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the franchise entity that owns or operates the asset. Null for company-owned assets. Supports franchise vs. company-owned asset segmentation.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total accumulated depreciation for this asset in this depreciation area as of the end of this fiscal period. Cumulative sum of all prior depreciation postings.',
    `acquisition_value` DECIMAL(18,2) COMMENT 'Original acquisition or construction cost of the fixed asset in this depreciation area. Basis for depreciation calculation.',
    `asset_acquisition_date` DATE COMMENT 'Date on which the fixed asset was acquired or placed in service. Determines the start of depreciation. Format: yyyy-MM-dd.',
    `asset_class` STRING COMMENT 'Asset class code categorizing the fixed asset (e.g., building, kitchen equipment, furniture, vehicles, leasehold improvements). Determines default depreciation parameters and GL account assignments.. Valid values are `^[A-Z0-9]{4,8}$`',
    `asset_description` STRING COMMENT 'Short textual description of the fixed asset (e.g., Fryer - Kitchen Station 3, POS Terminal - Front Counter). Provides business context for the asset.',
    `asset_retirement_date` DATE COMMENT 'Date on which the fixed asset was retired, sold, or scrapped. Null if the asset is still in service. Format: yyyy-MM-dd.',
    `asset_serial_number` STRING COMMENT 'Manufacturer serial number or unique identifier for the physical asset. Used for equipment tracking and warranty management.',
    `company_code` STRING COMMENT 'Four-character company code identifying the legal entity for which depreciation is posted. Aligns with SAP organizational structure.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'Cost center to which the depreciation expense is allocated. Supports restaurant-level or department-level P&L reporting.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_by_user` STRING COMMENT 'User ID of the person or system process that created this depreciation record. Supports audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this depreciation record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record. Aligns with the company code currency.. Valid values are `^[A-Z]{3}$`',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Periodic depreciation expense amount posted for this asset in this fiscal period and depreciation area. Expressed in the company code currency.',
    `depreciation_area` STRING COMMENT 'Depreciation area code indicating the valuation view: 01=Book Depreciation (GAAP), 10=Tax Depreciation, 15=IFRS, 20=Cost Accounting, 30=Consolidated, 40=Group Valuation. Supports parallel accounting requirements.. Valid values are `01|10|15|20|30|40`',
    `depreciation_key` STRING COMMENT 'Four-character code defining the depreciation calculation method (e.g., straight-line, declining balance, units of production). Controls depreciation calculation logic in SAP FI-AA.. Valid values are `^[A-Z0-9]{4}$`',
    `depreciation_method` STRING COMMENT 'Business-friendly name of the depreciation calculation method applied. Derived from depreciation_key for reporting clarity.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production|double_declining_balance`',
    `depreciation_run_date` DATE COMMENT 'Date on which the depreciation calculation batch job was executed. May differ from posting_date in case of backdated runs. Format: yyyy-MM-dd.',
    `depreciation_status` STRING COMMENT 'Status of the depreciation posting: posted=successfully posted to GL, planned=calculated but not yet posted, reversed=posting reversed due to correction, adjusted=manual adjustment applied.. Valid values are `posted|planned|reversed|adjusted`',
    `document_number` STRING COMMENT 'SAP FI document number for the depreciation posting. Links to the GL document for audit trail and drill-down.. Valid values are `^[0-9]{10}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period (1-12 or 1-13 for special periods) within the fiscal year for which depreciation is posted. Supports monthly and period-end close processes.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year for which the depreciation is posted. Aligns with the restaurants financial reporting calendar.',
    `gl_account_accumulated_depreciation` STRING COMMENT 'GL account number to which the accumulated depreciation is credited. Contra-asset account on the balance sheet.. Valid values are `^[0-9]{6,10}$`',
    `gl_account_depreciation_expense` STRING COMMENT 'GL account number to which the depreciation expense is debited. Typically a P&L expense account.. Valid values are `^[0-9]{6,10}$`',
    `impairment_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the asset has been tested for impairment and an impairment loss has been recognized. True if impaired, False otherwise.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'Cumulative impairment loss recognized for this asset in this depreciation area. Null if no impairment has been recorded.',
    `modified_by_user` STRING COMMENT 'User ID of the person or system process that last modified this depreciation record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this depreciation record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Net book value of the asset as of the end of this fiscal period. Calculated as acquisition_value minus accumulated_depreciation. Represents the carrying amount on the balance sheet.',
    `posting_date` DATE COMMENT 'Date on which the depreciation transaction was posted to the general ledger. Format: yyyy-MM-dd.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Remaining useful life of the asset in years as of the end of this fiscal period. Calculated as useful_life_years minus elapsed depreciation periods.',
    `reversal_document_number` STRING COMMENT 'SAP FI document number of the reversal posting if this depreciation has been reversed. Null if not reversed.. Valid values are `^[0-9]{10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this depreciation posting has been reversed. True if reversed, False otherwise.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Estimated useful life of the asset in years as configured in the depreciation key for this depreciation area. Used for straight-line and other time-based depreciation methods.',
    CONSTRAINT pk_asset_depreciation PRIMARY KEY(`asset_depreciation_id`)
) COMMENT 'Periodic depreciation posting records from SAP S/4HANA FI-AA. Captures planned and posted depreciation runs for each fixed asset by fiscal period, depreciation area (book, tax, IFRS), depreciation amount, accumulated depreciation, net book value, and depreciation key. Supports EBITDA calculation (adding back D&A), tax depreciation schedules, and impairment testing for restaurant assets.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `unit_id` BIGINT COMMENT 'Identifier of the specific restaurant location to which this budget line applies. Null for corporate or regional-level budgets.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for linking each marketing campaign to its allocated financial budget, enabling budget variance reporting and ROI analysis.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the individual or department responsible for managing and monitoring this budget line.',
    `amount` DECIMAL(18,2) COMMENT 'The budgeted monetary amount for the specified GL account, cost center, and fiscal period. Expressed in the reporting currency.',
    `approval_date` DATE COMMENT 'The date on which the budget record was formally approved by the approving authority.',
    `approving_authority` STRING COMMENT 'Name or identifier of the individual or committee that approved this budget line (e.g., CFO, Budget Committee, Regional Director).',
    `baseline_amount` DECIMAL(18,2) COMMENT 'The baseline or prior-year budget amount used as a reference point for variance analysis and year-over-year comparisons.',
    `brand_code` STRING COMMENT 'Code representing the restaurant brand or concept to which this budget applies (e.g., QSR Brand A, Casual Dining Brand B).',
    `budget_status` STRING COMMENT 'Current approval and lifecycle status of the budget record. Draft indicates work in progress, Submitted indicates pending approval, Approved indicates finalized, Rejected indicates not approved, Locked indicates no further changes allowed.. Valid values are `draft|submitted|approved|rejected|locked`',
    `budget_type` STRING COMMENT 'Classification of the budget line by expense or revenue category. OpEx (Operating Expenditure), CapEx (Capital Expenditure), Labor, Food Cost, Revenue, COGS (Cost of Goods Sold), Marketing, R&M (Repairs and Maintenance). [ENUM-REF-CANDIDATE: opex|capex|labor|food_cost|revenue|cogs|marketing|rm — 8 candidates stripped; promote to reference product]',
    `budget_category` STRING COMMENT 'High-level categorization of the budget line for reporting and analysis purposes (e.g., Store Operations, Corporate Overhead, Franchise Support, New Restaurant Opening).',
    `consolidation_entity` STRING COMMENT 'Legal entity or consolidation unit for multi-entity financial consolidation and GAAP/IFRS reporting.',
    `cost_center_code` STRING COMMENT 'The cost center code representing the organizational unit responsible for this budget line. Used for departmental and location-level budget tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the budget amount is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this budget record ceases to be effective. Null for open-ended budgets.',
    `effective_start_date` DATE COMMENT 'The date from which this budget record becomes effective and applicable for financial planning and reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year, typically numbered 1-12 or 1-13 for organizations with 13-period calendars.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget record applies, represented as a four-digit year (e.g., 2024).',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this budget amount is allocated. Maps to the SAP S/4HANA chart of accounts.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified this budget record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, or explanations related to this budget line item.',
    `nro_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line is associated with a New Restaurant Opening (NRO) project. True if NRO-related, False otherwise.',
    `nro_project_code` STRING COMMENT 'Unique project code for the New Restaurant Opening initiative if this budget line is NRO-related. Null for non-NRO budgets.',
    `ownership_type` STRING COMMENT 'Indicates whether the budget applies to a company-owned location, a franchise location, or a joint venture.. Valid values are `company_owned|franchise|joint_venture`',
    `profit_center_code` STRING COMMENT 'The profit center code representing the business segment or revenue-generating unit for P&L reporting and profitability analysis.',
    `region_code` STRING COMMENT 'Geographic region code for regional budget aggregation and reporting (e.g., Northeast, Southwest, EMEA, APAC).',
    `subcategory` STRING COMMENT 'Detailed subcategory within the budget category for granular expense or revenue classification (e.g., Utilities, Rent, Advertising, Training).',
    `variance_threshold_pct` DECIMAL(18,2) COMMENT 'The acceptable variance threshold percentage for budget-to-actual reporting. Variances exceeding this threshold trigger alerts or reviews.',
    `version_code` STRING COMMENT 'Version of the budget record indicating whether it is the original budget, a revised budget, a forecast, a reforecast, or the final approved budget.. Valid values are `original|revised|forecast|reforecast|final`',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this budget record.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual and rolling financial budget and forecast records from SAP S/4HANA CO, encompassing plan header and granular line-level allocations with cash forecasting integration. Stores budget version (original, revised, rolling forecast), fiscal year, approval status, and approving authority. Line-level detail specifies GL account, cost center or profit center, fiscal period, budget category (food cost, labor, occupancy, marketing, R&M, CapEx), planned amount, and currency. Supports monthly phasing of annual budgets, variance analysis (actual vs. budget), NRO CapEx budgeting, daypart-level labor budgeting, food cost (COGS%) targets by restaurant unit, cash flow forecasting by period, and liquidity planning for treasury operations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key.',
    `unit_id` BIGINT COMMENT 'Reference to the specific restaurant location if this budget line is allocated at the unit level. Null for corporate or regional budget lines.',
    `budget_unit_id` BIGINT COMMENT 'Reference to the specific restaurant location if this budget line is allocated at the unit level. Null for corporate or regional budget lines.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Needed to trace individual budget line items to the specific campaign they support for detailed spend tracking and performance measurement.',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget plan that contains this line item.',
    `allocation_driver` STRING COMMENT 'Business metric or driver used as the basis for allocation (e.g., revenue, transaction count, square footage, headcount). Null if allocation_method is direct.',
    `allocation_method` STRING COMMENT 'Method used to allocate or calculate this budget line (e.g., direct assignment, proportional allocation based on revenue, driver-based using transaction volume, zero-based budgeting, incremental from prior year).. Valid values are `direct|proportional|driver_based|zero_based|incremental`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line was approved. Null if not yet approved.',
    `baseline_amount` DECIMAL(18,2) COMMENT 'Prior year or baseline amount used as the starting point for this budget line. Supports variance analysis and incremental budgeting.',
    `budget_category` STRING COMMENT 'High-level classification of the budget line by expense or revenue type. Aligns with P&L statement structure and industry-standard categories (COGS, labor, occupancy, etc.). [ENUM-REF-CANDIDATE: food_cost|beverage_cost|labor|occupancy|marketing|utilities|repairs_maintenance|supplies|franchise_fees|other_operating|capex|opex — 12 candidates stripped; promote to reference product]',
    `budget_percentage_target` DECIMAL(18,2) COMMENT 'Target percentage of revenue or total budget that this line represents (e.g., COGS% target of 30.00, Labor% target of 25.00). Used for ratio-based budgeting and variance analysis.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget line within the approval and execution workflow.. Valid values are `draft|submitted|approved|active|closed|cancelled`',
    `budget_subcategory` STRING COMMENT 'Detailed subcategory within the budget category for granular tracking (e.g., within labor: FOH labor, BOH labor, management labor; within food cost: protein, produce, dairy).',
    `budget_version` STRING COMMENT 'Version or type of budget this line represents (original annual budget, mid-year revision, rolling forecast, or actual results for comparison).. Valid values are `original|revised|forecast|actual`',
    `company_code` STRING COMMENT 'Four-character SAP company code representing the legal entity or operating unit to which this budget line applies.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'Cost center code representing the organizational unit responsible for this budget line (e.g., specific restaurant, regional office, corporate department).. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the person who created this budget line record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the planned amount (e.g., USD, EUR, GBP). Supports multi-currency budgeting for international operations.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Service period or daypart for which this budget line applies. Supports daypart-level labor budgeting and revenue planning. Null if not daypart-specific.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `effective_end_date` DATE COMMENT 'Date when this budget line expires or is superseded. Null for open-ended budget lines.',
    `effective_start_date` DATE COMMENT 'Date when this budget line becomes effective and active for financial planning and control.',
    `fiscal_period` STRING COMMENT 'Fiscal period number within the fiscal year (typically 1-12 for monthly periods, or 1-13 for 4-4-5 retail calendar). Supports monthly phasing of annual budgets.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which this budget line applies (e.g., 2024).',
    `gl_account_code` STRING COMMENT 'General ledger account number to which this budget line is allocated. Represents the nature of the expense or revenue (e.g., food cost, labor, occupancy, marketing).. Valid values are `^[0-9]{6,10}$`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the person who last modified this budget line record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, assumptions, or justification for this budget line.',
    `planned_amount` DECIMAL(18,2) COMMENT 'Budgeted monetary amount for this line item in the specified currency. Represents the target spend or revenue for the fiscal period.',
    `profit_center` STRING COMMENT 'Profit center code for internal P&L reporting and performance measurement. May represent a restaurant unit, brand, or geographic region.. Valid values are `^[A-Z0-9]{6,10}$`',
    `quantity_target` DECIMAL(18,2) COMMENT 'Budgeted quantity or volume for non-monetary metrics (e.g., labor hours, transaction count, covers, units sold). Null for purely monetary budget lines.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity target (e.g., hours, transactions, covers, cases, pounds). Null if quantity_target is not applicable.',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'Absolute monetary variance threshold that triggers alerts or requires management review. Null if no threshold is set.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage variance threshold that triggers alerts or requires management review. Null if no threshold is set.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Granular line-level budget allocations within a budget plan. Each line specifies the GL account, cost center or profit center, fiscal period, budget category (food cost, labor, occupancy, marketing, R&M), planned amount, and currency. Supports monthly phasing of annual budgets, daypart-level labor budgeting, and food cost (COGS%) targets by restaurant unit.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` (
    `royalty_accrual_id` BIGINT COMMENT 'Unique identifier for the royalty accrual record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Identifier of the franchise agreement governing this royalty accrual. Links to the franchise agreement master data.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee entity for which royalty is being accrued. Links to the franchise master data.',
    `original_accrual_royalty_accrual_id` BIGINT COMMENT 'Reference to the original royalty_accrual_id being adjusted, if this is an adjustment entry. Null for original accruals.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location for which royalty is being accrued. Links to the restaurant location master data.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace royalty accrual GL account strings with FKs to gl_account for accurate revenue and receivable tracking.',
    `royalty_unit_id` BIGINT COMMENT 'Identifier of the restaurant location for which royalty is being accrued. Links to the restaurant location master data.',
    `accrual_period_end_date` DATE COMMENT 'End date of the period for which royalty is being accrued. Defines the boundary of the revenue recognition period.',
    `accrual_period_start_date` DATE COMMENT 'Start date of the period for which royalty is being accrued. Typically the first day of a week, month, or quarter depending on royalty calculation frequency.',
    `accrued_royalty_amount` DECIMAL(18,2) COMMENT 'Total royalty amount accrued for the period, calculated as royalty_base_net_sales multiplied by royalty_rate_percent. Represents the franchise royalty revenue to be recognized.',
    `adjustment_indicator` BOOLEAN COMMENT 'Flag indicating whether this accrual is an adjustment to a prior period accrual. True if this is a correction or adjustment entry.',
    `adjustment_reason` STRING COMMENT 'Business reason for the adjustment if adjustment_indicator is true. Examples: sales correction, rate change, prior period adjustment, dispute resolution.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity recording the royalty accrual. Used for multi-entity consolidation and financial reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'Cost center code for management accounting allocation. Typically the franchise operations or franchise development cost center.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_by_user` STRING COMMENT 'User ID or username of the person or system process that created this accrual record. Audit trail field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty accrual record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this accrual record. Supports multi-currency franchise operations.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year for which royalty is being accrued. Typically 1-12 for monthly or 1-4 for quarterly.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the royalty accrual period falls. Used for financial reporting and consolidation.',
    `franconnect_calculation_reference` STRING COMMENT 'Unique identifier of the royalty calculation in FranConnect. Used for reconciliation between FranConnect and SAP S/4HANA.',
    `gl_document_number` STRING COMMENT 'SAP general ledger document number for the accrual posting. Used for audit trail and reconciliation back to SAP S/4HANA.. Valid values are `^[A-Z0-9]{10}$`',
    `gl_posting_date` DATE COMMENT 'Date on which the accrual was posted to the general ledger in SAP S/4HANA. May differ from recognition_date due to period-end adjustments.',
    `marketing_fund_contribution` DECIMAL(18,2) COMMENT 'Marketing fund contribution amount accrued for the period, typically calculated as a percentage of net sales. Separate from royalty but often collected together.',
    `marketing_fund_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to net sales to calculate the marketing fund contribution. Defined in the franchise agreement.',
    `modified_by_user` STRING COMMENT 'User ID or username of the person or system process that last modified this accrual record. Audit trail field.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty accrual record was last modified. Audit trail field.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this royalty accrual. May include details about disputes, adjustments, or special circumstances.',
    `profit_center` STRING COMMENT 'Profit center code for segment reporting. Used for P&L reporting by business unit or geographic region.. Valid values are `^[A-Z0-9]{6,10}$`',
    `recognition_date` DATE COMMENT 'Date on which the accrued royalty revenue was recognized in the general ledger. Null if not yet recognized.',
    `recognition_status` STRING COMMENT 'Current revenue recognition status of the accrual. Tracks the lifecycle from initial accrual through final recognition in the general ledger.. Valid values are `accrued|recognized|deferred|reversed|adjusted`',
    `reversal_date` DATE COMMENT 'Date on which the accrual was reversed in the general ledger. Null if not reversed.',
    `reversal_document_number` STRING COMMENT 'SAP general ledger document number for the reversal posting, if applicable. Null if not reversed.. Valid values are `^[A-Z0-9]{10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this accrual has been reversed. True if a reversal document has been posted.',
    `royalty_base_net_sales` DECIMAL(18,2) COMMENT 'Net sales amount used as the base for calculating royalty. Typically gross sales less discounts, refunds, and allowable deductions per franchise agreement.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to the royalty base to calculate the royalty amount. Defined in the franchise agreement and may vary by franchisee or agreement tier.',
    `technology_fee` DECIMAL(18,2) COMMENT 'Technology fee amount accrued for the period. May be a flat fee or percentage-based, covering POS, digital ordering, and other technology services provided to franchisees.',
    `technology_fee_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to net sales to calculate the technology fee, if applicable. May be null if technology fee is a flat amount.',
    `total_accrued_amount` DECIMAL(18,2) COMMENT 'Total amount accrued for the period, including royalty, marketing fund contribution, and technology fee. Represents the total receivable from the franchisee for this period.',
    CONSTRAINT pk_royalty_accrual PRIMARY KEY(`royalty_accrual_id`)
) COMMENT 'Periodic royalty income accrual records for franchise royalty revenue recognition from SAP S/4HANA FI-AR and FranConnect. Captures franchisee ID, royalty rate, royalty base (net sales), accrual period, accrued royalty amount, marketing fund contribution, technology fee, and recognition status. Supports GAAP/IFRS revenue recognition (ASC 606/IFRS 15) for franchise royalty streams and reconciliation against FranConnect royalty calculations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'add column cost_center_id (BIGINT) with FK to finance.cost_center.cost_center_id - intercompany transactions need cost center allocation for management reporting',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace string GL account references with FKs to gl_account for intercompany transaction clarity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Intercompany transactions belong to sending and receiving legal entities; replace string codes with proper FK to legal_entity for referential integrity.',
    `created_by_user` STRING COMMENT 'The SAP user ID of the person or system account that created the intercompany transaction record in SAP S/4HANA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was first created in SAP S/4HANA. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `document_date` DATE COMMENT 'The date on the source document or invoice that originated the intercompany transaction. Format: yyyy-MM-dd.',
    `document_number` STRING COMMENT 'The SAP financial document number assigned to the intercompany posting. Ten-digit numeric identifier unique within company code and fiscal year.. Valid values are `^[0-9]{10}$`',
    `due_date` DATE COMMENT 'The date by which the intercompany transaction amount is due for settlement between entities. Format: yyyy-MM-dd.',
    `elimination_date` DATE COMMENT 'The date on which the intercompany transaction was eliminated during the consolidation process. Null if not yet eliminated. Format: yyyy-MM-dd.',
    `elimination_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this intercompany transaction has been eliminated in the consolidated financial statements. True if eliminated, False if not yet eliminated.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency to group currency at the time of posting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or posting period) within the fiscal year in which the transaction is recorded. Typically 1-12 for monthly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction is recorded, per the companys financial calendar.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the consolidated financial reporting currency for consolidated financial statements and intercompany elimination.',
    `group_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the consolidated financial reporting currency used for consolidation (typically USD for Restaurants).. Valid values are `^[A-Z]{3}$`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the local currency of the sending company code for local statutory reporting.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local currency of the sending company code.. Valid values are `^[A-Z]{3}$`',
    `modified_by_user` STRING COMMENT 'The SAP user ID of the person or system account that last modified the intercompany transaction record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was last modified in SAP S/4HANA. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `netting_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this transaction is part of an intercompany netting arrangement where offsetting balances are settled periodically. True if netting applies, False otherwise.',
    `payment_terms` STRING COMMENT 'The payment terms agreed between the sending and receiving entities for settlement of the intercompany transaction (e.g., Net 30, Net 60).',
    `posting_date` DATE COMMENT 'The date on which the intercompany transaction was posted to the general ledger in SAP S/4HANA. Format: yyyy-MM-dd.',
    `profit_center_code` STRING COMMENT 'The profit center code associated with the intercompany transaction for segment reporting and profitability analysis.. Valid values are `^[A-Z0-9]{6,10}$`',
    `reconciliation_period` STRING COMMENT 'The fiscal period (YYYY-MM format) in which the intercompany transaction is scheduled for or has completed reconciliation.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the intercompany transaction has been successfully reconciled between the sending and receiving entities.. Valid values are `matched|unmatched|partially_matched|under_review`',
    `reference_document_number` STRING COMMENT 'External reference number from the originating system or invoice that supports the intercompany transaction (e.g., purchase order number, invoice number).',
    `reversal_document_number` STRING COMMENT 'The SAP financial document number of the reversal posting, if this transaction has been reversed. Null if not reversed.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this intercompany transaction has been reversed. True if reversed, False otherwise.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the business reason for reversing the intercompany transaction (e.g., error correction, duplicate posting, pricing adjustment). Null if not reversed.',
    `settlement_date` DATE COMMENT 'The actual date on which the intercompany transaction was settled or paid. Null if not yet settled. Format: yyyy-MM-dd.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the intercompany transaction in the transaction currency, before any adjustments or eliminations.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the intercompany transaction was originally denominated.. Valid values are `^[A-Z]{3}$`',
    `transaction_description` STRING COMMENT 'Free-text description providing additional context and details about the nature and purpose of the intercompany transaction.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the intercompany transaction indicating its processing and reconciliation state.. Valid values are `draft|posted|reconciled|disputed|reversed|eliminated`',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the charge or transfer between legal entities.. Valid values are `management_fee|shared_service_allocation|intercompany_loan|food_supply_transfer|royalty_charge|rent_allocation`',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany billing and settlement records between legal entities within the Restaurants corporate group from SAP S/4HANA FI. Covers management fee charges, shared service allocations, intercompany loans, and cross-entity food supply transfers. Stores sending entity, receiving entity, transaction type, amount, netting status, elimination flag, and reconciliation period. Essential for multi-entity consolidation and intercompany elimination in consolidated financial statements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` (
    `tax_posting_id` BIGINT COMMENT 'Unique identifier for the tax posting transaction record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link tax posting to cost_center master for proper cost allocation.',
    `franchisee_id` BIGINT COMMENT 'Reference to the franchise entity responsible for the tax posting, applicable for franchise-operated locations.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace tax posting GL account string with FK to gl_account.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center (restaurant unit, franchise entity, or business segment) associated with this tax posting.',
    `profile_id` BIGINT COMMENT 'Reference to the customer to whom goods or services were sold, applicable for sales tax and output VAT postings.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor from whom goods or services were purchased, applicable for use tax and input VAT postings.',
    `tax_profile_id` BIGINT COMMENT 'Reference to the customer to whom goods or services were sold, applicable for sales tax and output VAT postings.',
    `unit_id` BIGINT COMMENT 'Reference to the specific restaurant location where the taxable transaction occurred, if applicable.',
    `tax_unit_id` BIGINT COMMENT 'Reference to the specific restaurant location where the taxable transaction occurred, if applicable.',
    `tax_vendor_procurement_supplier_id` BIGINT COMMENT 'Reference to the vendor from whom goods or services were purchased, applicable for use tax and input VAT postings.',
    `adjustment_reason` STRING COMMENT 'Explanation for any manual adjustment or correction made to the tax posting after initial recording.',
    `audit_flag` BOOLEAN COMMENT 'Indicator that this tax posting has been flagged for review during a tax audit or compliance examination.',
    `company_code` STRING COMMENT 'Four-character code identifying the legal entity within the SAP system for which the tax posting is recorded.. Valid values are `^[A-Z0-9]{4}$`',
    `created_by_user` STRING COMMENT 'User ID or system account that created this tax posting record.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this tax posting record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tax amounts (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date on the source document (invoice, receipt) that triggered the tax posting.',
    `document_line_item` STRING COMMENT 'Line item number within the financial document that represents this specific tax posting entry.',
    `document_number` STRING COMMENT 'The SAP financial document number that contains this tax posting. Externally-known unique identifier for the transaction.. Valid values are `^[A-Z0-9]{10}$`',
    `exemption_certificate_number` STRING COMMENT 'The certificate number for tax-exempt transactions, if the transaction qualifies for exemption.',
    `exemption_reason` STRING COMMENT 'Business reason or regulatory basis for tax exemption, if applicable (e.g., resale, nonprofit, government entity).',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for the tax posting. Typically 1-12 or 1-13 for companies with 13-period calendars.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the tax posting is recorded for financial reporting purposes.',
    `invoice_number` STRING COMMENT 'The invoice or billing document number that triggered the tax posting.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this tax posting record.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this tax posting record was last modified in the data platform.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, explanations, or special instructions related to the tax posting.',
    `payment_date` DATE COMMENT 'The date when the tax liability was paid to the tax authority.',
    `payment_reference_number` STRING COMMENT 'The reference or confirmation number from the tax authority for the payment transaction.',
    `posting_date` DATE COMMENT 'The date when the tax transaction was posted to the general ledger. Principal business event timestamp for the tax posting.',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with the taxable purchase transaction, if applicable.',
    `reporting_period` STRING COMMENT 'The tax reporting period for which this posting must be included in tax filings. Format: YYYY-Q# for quarterly or YYYY-M## for monthly.. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$`',
    `reversal_document_number` STRING COMMENT 'The document number of the original posting that this entry reverses, if reversal_indicator is true.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this tax posting is a reversal of a previous posting due to correction or cancellation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount posted to the general ledger. Principal quantitative result of the tax posting.',
    `tax_authority_name` STRING COMMENT 'Name of the governmental tax authority to which the tax is owed (e.g., California Department of Tax and Fee Administration, IRS).',
    `tax_code` STRING COMMENT 'The tax code that determines the tax type, rate, and GL account assignment. Examples include sales tax codes, use tax codes, VAT codes.. Valid values are `^[A-Z0-9]{2,4}$`',
    `tax_direction` STRING COMMENT 'Indicates whether this is an input tax (tax paid on purchases) or output tax (tax collected on sales).. Valid values are `input|output`',
    `tax_filing_status` STRING COMMENT 'Current lifecycle status of the tax posting in the filing and payment process.. Valid values are `pending|filed|paid|audited|adjusted`',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax authority jurisdiction (state, county, city) where the tax applies. Format: country-state/province-locality.. Valid values are `^[A-Z]{2}-[A-Z0-9]{2,6}$`',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percentage applied to the taxable base amount to calculate the tax amount. Stored as decimal (e.g., 8.250 for 8.25%).',
    `tax_type` STRING COMMENT 'Classification of the tax transaction by type: sales tax (collected from customers), use tax (self-assessed), VAT (value-added tax), withholding tax, excise tax, or franchise tax.. Valid values are `sales_tax|use_tax|vat|withholding_tax|excise_tax|franchise_tax`',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The gross amount subject to tax before the tax is calculated. This is the base upon which the tax rate is applied.',
    CONSTRAINT pk_tax_posting PRIMARY KEY(`tax_posting_id`)
) COMMENT 'Tax-related financial postings from SAP S/4HANA FI-TX. Records sales tax, use tax, VAT, and withholding tax transactions across all restaurant operations and franchise billings. Stores tax code, tax jurisdiction, taxable base amount, tax amount, tax type (input/output), reporting period, and tax authority. Supports multi-jurisdiction tax compliance, FDA/state health department fee tracking, and quarterly/annual tax filings.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`period_close` (
    `period_close_id` BIGINT COMMENT 'Unique identifier for the financial period close record.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Period close records should reference the master financial period entity; replace separate year/period fields with FK.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this period close applies.',
    `employee_id` BIGINT COMMENT 'The system user ID of the person who signed off on the period close.',
    `period_sign_off_user_employee_id` BIGINT COMMENT 'The system user ID of the person who signed off on the period close.',
    `accrual_posting_status` STRING COMMENT 'Status of accrual journal entries posting for the period (e.g., payroll accruals, utility accruals, rent accruals).. Valid values are `not_started|in_progress|completed|verified`',
    `actual_close_date` DATE COMMENT 'The actual date when the period close was completed and signed off.',
    `adjustment_entry_count` STRING COMMENT 'The number of manual journal entries posted during the period close process.',
    `ap_reconciliation_status` STRING COMMENT 'Status of accounts payable sub-ledger reconciliation to general ledger for the period.. Valid values are `not_started|in_progress|completed|verified`',
    `ar_reconciliation_status` STRING COMMENT 'Status of accounts receivable sub-ledger reconciliation to general ledger for the period.. Valid values are `not_started|in_progress|completed|verified`',
    `audit_readiness_flag` BOOLEAN COMMENT 'Indicates whether the period close documentation and supporting evidence are ready for internal or external audit review.',
    `bank_reconciliation_status` STRING COMMENT 'Status of bank account reconciliation activities for the period.. Valid values are `not_started|in_progress|completed|verified|exceptions_pending`',
    `close_completed_timestamp` TIMESTAMP COMMENT 'The date and time when the period close process was fully completed and locked.',
    `close_duration_hours` DECIMAL(18,2) COMMENT 'The total number of hours elapsed from close initiation to completion, used for process efficiency tracking.',
    `close_initiated_timestamp` TIMESTAMP COMMENT 'The date and time when the period close process was initiated.',
    `close_phase` STRING COMMENT 'The specific phase of the period close workflow (pre-close activities, soft close for preliminary reporting, hard close for final lock, post-close adjustments).. Valid values are `pre_close|soft_close|hard_close|post_close`',
    `close_status` STRING COMMENT 'Current status of the period close process indicating the phase of completion. [ENUM-REF-CANDIDATE: not_started|in_progress|pre_close|soft_close|hard_close|completed|reopened — 7 candidates stripped; promote to reference product]',
    `company_code` STRING COMMENT 'Four-character SAP company code representing the legal entity for financial reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this period close record was first created in the system.',
    `depreciation_run_date` DATE COMMENT 'The date when the depreciation calculation run was executed for this period.',
    `depreciation_run_status` STRING COMMENT 'Status of the fixed asset depreciation calculation and posting run for the period.. Valid values are `not_started|in_progress|completed|verified`',
    `exception_count` STRING COMMENT 'The number of reconciliation exceptions or issues identified during the period close process.',
    `financial_statement_status` STRING COMMENT 'Status of Profit and Loss (P&L), balance sheet, and cash flow statement preparation and approval for the period.. Valid values are `not_started|draft|review|approved|published`',
    `gl_account_reconciliation_status` STRING COMMENT 'Status of general ledger account reconciliation activities for balance sheet and income statement accounts.. Valid values are `not_started|in_progress|completed|verified`',
    `intercompany_reconciliation_status` STRING COMMENT 'Status of intercompany transaction reconciliation and elimination entries for multi-entity consolidation.. Valid values are `not_started|in_progress|completed|verified|exceptions_pending`',
    `inventory_valuation_status` STRING COMMENT 'Status of inventory valuation and Cost of Goods Sold (COGS) calculation for the period.. Valid values are `not_started|in_progress|completed|verified`',
    `marketing_fund_accrual_status` STRING COMMENT 'Status of marketing fund contribution accrual calculation and posting for the period.. Valid values are `not_started|in_progress|completed|verified`',
    `modified_by_user` STRING COMMENT 'The system user ID of the person who last modified this period close record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this period close record was last modified.',
    `notes` STRING COMMENT 'Free-text notes capturing key issues, decisions, or commentary related to this period close.',
    `period_type` STRING COMMENT 'The type of financial period being closed (monthly, quarterly, annual, or special adjustment period).. Valid values are `monthly|quarterly|annual|special`',
    `reopen_authorized_by` STRING COMMENT 'The name of the senior finance leader who authorized the reopening of the closed period.',
    `reopen_reason` STRING COMMENT 'The business justification for reopening a previously closed period (e.g., audit adjustment, error correction, late invoice).',
    `reopen_timestamp` TIMESTAMP COMMENT 'The date and time when the period was reopened after initial close.',
    `responsible_controller_email` STRING COMMENT 'The email address of the financial controller responsible for this period close.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_controller_name` STRING COMMENT 'The name of the financial controller responsible for executing and signing off on this period close.',
    `royalty_accrual_status` STRING COMMENT 'Status of franchise royalty income accrual calculation and posting for the period.. Valid values are `not_started|in_progress|completed|verified`',
    `scheduled_close_date` DATE COMMENT 'The target date by which the period close should be completed according to the financial calendar.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'The date and time when the responsible controller formally signed off on the completed period close.',
    `tax_provision_status` STRING COMMENT 'Status of income tax provision calculation and posting for the period.. Valid values are `not_started|in_progress|completed|verified`',
    `variance_analysis_status` STRING COMMENT 'Status of budget-to-actual variance analysis and commentary preparation for the period.. Valid values are `not_started|in_progress|completed|reviewed`',
    CONSTRAINT pk_period_close PRIMARY KEY(`period_close_id`)
) COMMENT 'Financial period-end close activity tracking, consolidation output, and compliance evidence record for each legal entity and fiscal period from SAP S/4HANA FI. Captures close phase (pre-close, soft close, hard close), task completion status, responsible controller, accrual posting status, depreciation run status, intercompany reconciliation status, elimination journal status, consolidated trial balance sign-off, and final sign-off timestamp. Includes SOX control evidence (segregation of duties verification, reconciliation sign-offs, management assertion documentation) and audit trail for external auditor access. Supports the monthly/quarterly/annual close calendar, consolidated financial statement preparation (balance sheet, income statement, cash flow statement), audit readiness, and GAAP/IFRS compliance timelines.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation record. Primary key.',
    `allocation_rule_id` BIGINT COMMENT 'The specific allocation rule or assessment within the cycle that governs how costs are distributed. Defines sender-receiver relationships and allocation basis.',
    `employee_id` BIGINT COMMENT 'The SAP user ID of the person or system account that executed the allocation run.',
    `unit_id` BIGINT COMMENT 'The unique identifier of the restaurant unit receiving the allocated cost. Enables unit-level EBITDA and fully-loaded P&L reporting.',
    `cost_unit_id` BIGINT COMMENT 'The unique identifier of the restaurant unit receiving the allocated cost. Enables unit-level EBITDA and fully-loaded P&L reporting.',
    `cost_user_employee_id` BIGINT COMMENT 'The SAP user ID of the person or system account that executed the allocation run.',
    `legal_entity_id` BIGINT COMMENT 'The unique identifier of the franchise entity if the receiver is a franchised restaurant. Null for company-owned units. Used for franchise-level cost roll-up.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace cost allocation GL account code fields with FKs to gl_account for accurate allocation tracking.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount allocated from the sender cost center to the receiver cost center in this record. This is the product of total sender cost and allocation percentage.',
    `allocation_basis_type` STRING COMMENT 'The method or driver used to allocate costs. Common bases include headcount (FTE), revenue (AUV), square footage, transaction count (ADT), labor hours, fixed percentage, or custom formula. [ENUM-REF-CANDIDATE: headcount|revenue|square_footage|transaction_count|labor_hours|fixed_percentage|custom — 7 candidates stripped; promote to reference product]',
    `allocation_basis_value` DECIMAL(18,2) COMMENT 'The quantity or weight of the allocation basis for the receiver. For example, if basis is headcount, this is the FTE count; if revenue, this is the AUV amount.',
    `allocation_batch_number` STRING COMMENT 'The batch or job identifier for the allocation run. All allocations executed in the same cycle run share the same batch ID for traceability.',
    `allocation_cycle_code` STRING COMMENT 'The identifier of the allocation cycle or segment that defines the allocation rules and sequence. Examples: CORP_OH (corporate overhead), IT_ALLOC (IT cost allocation), MKT_FUND (marketing fund distribution).',
    `allocation_description` STRING COMMENT 'Free-text description of the allocation. May include details about the allocation purpose, sender service, or special instructions.',
    `allocation_document_number` STRING COMMENT 'The SAP document number assigned to this cost allocation posting. Used for audit trail and reversal reference.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the sender cost center total that is allocated to this receiver. Calculated as receiver basis value divided by total basis value across all receivers. Expressed as decimal (e.g., 0.0523 for 5.23%).',
    `allocation_run_date` DATE COMMENT 'The date on which the allocation cycle was executed. May differ from posting date if batch processing is used.',
    `allocation_status` STRING COMMENT 'The current status of the allocation record. Posted indicates successful posting; reversed indicates the allocation was reversed; parked indicates saved but not posted; error indicates posting failure.. Valid values are `posted|reversed|parked|error`',
    `allocation_type` STRING COMMENT 'The CO allocation method used. Assessment allocates costs without detail traceability; distribution maintains sender cost element detail; periodic reposting moves costs between cost centers; settlement closes internal orders or projects.. Valid values are `assessment|distribution|periodic_reposting|settlement`',
    `brand_code` STRING COMMENT 'The restaurant brand to which the receiver cost center belongs. Used for brand-level cost analysis and EBITDA reporting.',
    `company_code` STRING COMMENT 'The legal entity company code to which this allocation belongs. Links to the financial accounting entity.',
    `controlling_area_code` STRING COMMENT 'The controlling area in which this allocation is executed. Represents the organizational unit for cost accounting.',
    `cost_element_code` STRING COMMENT 'The controlling cost element that classifies the nature of the allocated cost (e.g., IT services, HR services, rent, utilities). Used for cost type analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the allocated amount. Typically USD for US operations, but may vary for international entities.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for this allocation. Typically 1-12, may include special periods 13-16 for year-end adjustments.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the cost allocation is posted. Four-digit year format.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost allocation record was last modified. Updated on any change to the record.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this allocation record. May include manual adjustments, special circumstances, or audit annotations.',
    `ownership_model` STRING COMMENT 'The ownership model of the receiver restaurant unit. Company-owned units receive full allocations; franchise units may receive limited allocations per franchise agreement.. Valid values are `company_owned|franchise|joint_venture`',
    `posting_date` DATE COMMENT 'The date on which the cost allocation was posted to the general ledger and controlling documents.',
    `receiver_cost_center_code` STRING COMMENT 'The cost center to which costs are being allocated. Typically a restaurant unit cost center or operational department that consumes the shared service.',
    `receiver_cost_center_name` STRING COMMENT 'The descriptive name of the receiver cost center. Denormalized for reporting convenience.',
    `receiver_profit_center_code` STRING COMMENT 'The profit center to which the allocated cost is assigned. Used for segment reporting and restaurant-level P&L.',
    `reversal_document_number` STRING COMMENT 'The document number of the original allocation that this record reverses, or the document number of the reversal if this record was reversed. Null if no reversal relationship exists.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this allocation record is a reversal of a previous allocation. True if this is a reversal posting.',
    `reversal_reason_code` STRING COMMENT 'The reason code for reversing the allocation. Examples: incorrect period, incorrect basis, duplicate posting, correction required.',
    `sender_cost_center_code` STRING COMMENT 'The cost center from which costs are being allocated. Typically a shared service or corporate overhead cost center (e.g., IT, HR, Finance, Marketing Fund).',
    `sender_cost_center_name` STRING COMMENT 'The descriptive name of the sender cost center. Denormalized for reporting convenience.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Cost allocation and distribution records from SAP S/4HANA CO module. Captures periodic allocations of shared costs (corporate overhead, IT, HR, marketing fund) to restaurant cost centers and profit centers using defined allocation keys (headcount, revenue, square footage). Stores sender cost center, receiver cost center, allocation cycle, allocation rule, allocation basis, allocated amount, fiscal period, and reversal indicator. Enables fully-loaded restaurant P&L, accurate EBITDA by unit, and transparent overhead burden rates for franchise vs. company-owned comparisons.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`capex_project` (
    `capex_project_id` BIGINT COMMENT 'Unique identifier for the capital expenditure project record. Primary key.',
    `unit_id` BIGINT COMMENT 'Foreign key to the restaurant location this CapEx project is associated with (for NRO, remodel, or site-specific equipment projects). Null for corporate-level technology or multi-site programs.',
    `capex_unit_id` BIGINT COMMENT 'Foreign key to the restaurant location this CapEx project is associated with (for NRO, remodel, or site-specific equipment projects). Null for corporate-level technology or multi-site programs.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Needed for capital‑expenditure planning linking each capex project to the specific facility it upgrades, used in CAPEX approval and facility budgeting processes.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key to the franchise entity if this CapEx project is franchise-funded or co-funded. Null for company-owned projects.',
    `actual_capitalization_date` DATE COMMENT 'Actual date when the project was capitalized and assets placed in service. Null if not yet capitalized.',
    `actual_completion_date` DATE COMMENT 'Actual date when project work was completed and assets were ready for use. Null if project is still in progress.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures posted to the project to date. Includes invoiced costs, accruals, and internal labor capitalized.',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee that approved the project (e.g., CFO, CapEx Committee, Board of Directors).',
    `approval_date` DATE COMMENT 'Date when the CapEx project was formally approved by the governance committee or authorized signatory.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total capital budget approved for this project by the CapEx governance committee or executive leadership. Represents the authorized spending limit.',
    `asset_class` STRING COMMENT 'Fixed asset class that will receive the capitalized costs. Determines depreciation method and useful life.. Valid values are `building|equipment|technology|vehicle|furniture|leasehold_improvement`',
    `auc_gl_account` STRING COMMENT 'General ledger account number for the Asset Under Construction balance sheet line item. Costs accumulate here until capitalization.. Valid values are `^[0-9]{6,10}$`',
    `business_justification` STRING COMMENT 'Business case rationale for the capital investment, including strategic alignment, expected benefits, and financial analysis.',
    `cancellation_reason` STRING COMMENT 'Explanation for project cancellation if status is cancelled. Null for active or completed projects.',
    `capex_category` STRING COMMENT 'Strategic classification of the CapEx investment. Growth = revenue expansion, maintenance = asset replacement, compliance = regulatory requirement, efficiency = cost reduction, strategic = competitive positioning.. Valid values are `growth|maintenance|compliance|efficiency|strategic`',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'Total committed costs via purchase orders and contracts not yet invoiced. Used for budget consumption tracking and forecasting.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity responsible for this CapEx project. Links to finance.legal_entity for consolidation and reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'Cost center responsible for project oversight and ongoing asset maintenance post-capitalization.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this project record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CapEx project record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this project record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Depreciation method to be applied once the asset is capitalized (e.g., straight_line, declining_balance).. Valid values are `straight_line|declining_balance|units_of_production`',
    `expected_capitalization_date` DATE COMMENT 'Planned date when the project will be capitalized and transferred from AUC to fixed assets, triggering depreciation start.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this project record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CapEx project record was last modified.',
    `notes` STRING COMMENT 'Free-form notes and comments for additional context, issues, or special considerations.',
    `payback_period_months` STRING COMMENT 'Expected number of months to recover the capital investment through incremental cash flows or cost savings.',
    `planned_completion_date` DATE COMMENT 'Target date for project completion as defined in the project plan.',
    `profit_center_code` STRING COMMENT 'Profit center to which this CapEx project is assigned. Used for segment reporting and P&L allocation of depreciation expense.. Valid values are `^[A-Z0-9]{6,10}$`',
    `project_description` STRING COMMENT 'Detailed narrative description of the project scope, objectives, and deliverables.',
    `project_manager_email` STRING COMMENT 'Corporate email address of the project manager for communication and escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `project_manager_name` STRING COMMENT 'Full name of the project manager responsible for execution and delivery.',
    `project_name` STRING COMMENT 'Human-readable name of the capital project (e.g., NRO - Dallas Market Street, Remodel - Chicago Loop Kitchen Upgrade).',
    `project_number` STRING COMMENT 'Business identifier for the CapEx project as assigned in SAP PS. Externally visible project code used in financial reporting and approvals.. Valid values are `^[A-Z0-9]{8,15}$`',
    `project_phase` STRING COMMENT 'Current phase of the project lifecycle. Initiation = business case development, design = architectural/engineering, procurement = vendor selection, construction = build-out, commissioning = testing and handover, closeout = final accounting and asset transfer.. Valid values are `initiation|design|procurement|construction|commissioning|closeout`',
    `project_start_date` DATE COMMENT 'Official start date of the project, typically when budget is approved and work begins.',
    `project_status` STRING COMMENT 'Current lifecycle status of the CapEx project. Planning = under development, approved = budget authorized, in_progress = construction/implementation underway, on_hold = temporarily suspended, completed = work finished, cancelled = terminated before completion, closed = financially closed and capitalized. [ENUM-REF-CANDIDATE: planning|approved|in_progress|on_hold|completed|cancelled|closed — 7 candidates stripped; promote to reference product]',
    `project_type` STRING COMMENT 'Classification of the capital project. NRO = New Restaurant Opening, remodel = major renovation, equipment_replacement = asset refresh, technology_infrastructure = IT/POS systems, maintenance_capex = major repairs capitalized, facility_expansion = capacity additions.. Valid values are `NRO|remodel|equipment_replacement|technology_infrastructure|maintenance_capex|facility_expansion`',
    `remaining_budget_amount` DECIMAL(18,2) COMMENT 'Calculated remaining budget: approved_budget_amount minus (actual_spend_amount + committed_cost_amount). Indicates available funds.',
    `risk_rating` STRING COMMENT 'Overall risk assessment for the project based on complexity, budget size, timeline, and dependencies. Used for governance oversight.. Valid values are `low|medium|high|critical`',
    `roi_target_percent` DECIMAL(18,2) COMMENT 'Target return on investment percentage established during project approval. Used for post-implementation performance evaluation.',
    `sponsor_name` STRING COMMENT 'Executive sponsor or business owner accountable for project outcomes and ROI realization.',
    `useful_life_years` STRING COMMENT 'Expected useful life in years for depreciation purposes once the asset is capitalized.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Budget variance: actual_spend_amount minus approved_budget_amount. Positive indicates over-budget, negative indicates under-budget.',
    `variance_percent` DECIMAL(18,2) COMMENT 'Budget variance as a percentage of approved budget: (variance_amount / approved_budget_amount) * 100.',
    CONSTRAINT pk_capex_project PRIMARY KEY(`capex_project_id`)
) COMMENT 'Capital expenditure project master record from SAP S/4HANA PS (Project System) and FI-AA. Tracks NRO (New Restaurant Opening) builds, remodel programs, equipment replacement initiatives, and technology infrastructure investments. Stores project type (NRO, remodel, maintenance CapEx), approved budget, actual spend-to-date, committed costs, project phase, asset under construction (AUC) account, expected capitalization date, and ROI target. Supports CapEx governance and CapEx vs. OpEx classification.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key. Role: MASTER_RESOURCE.',
    `house_bank_id` BIGINT COMMENT 'SAP house bank identifier. Groups multiple accounts under a single banking relationship for payment processing and cash management.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Bank accounts are owned by a legal entity; replace company_code string with FK to legal_entity for proper hierarchy.',
    `account_holder_name` STRING COMMENT 'Legal name of the account holder as registered with the bank. Typically matches the legal entity name but may differ for special-purpose accounts.',
    `account_name` STRING COMMENT 'The legal name or title of the bank account as registered with the financial institution.',
    `account_number` STRING COMMENT 'The bank account number. Stored in masked or encrypted format for PCI DSS compliance. Restricted access required.',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Active accounts are available for transactions; inactive accounts are dormant but not closed; closed accounts are permanently terminated; frozen accounts are temporarily blocked; pending activation accounts are awaiting setup completion.. Valid values are `active|inactive|closed|frozen|pending_activation`',
    `account_type` STRING COMMENT 'Classification of the bank account by its primary business purpose: operating (daily transactions), payroll (employee payments), concentration (cash pooling), zero-balance (subsidiary sweep), escrow (restricted funds), reserve (regulatory or contractual hold).. Valid values are `operating|payroll|concentration|zero_balance|escrow|reserve`',
    `bank_key` STRING COMMENT 'Country-specific bank identifier. In the US this is the ABA routing number; in other countries it may be a sort code, bank code, or clearing number.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution holding the account.',
    `bank_statement_delivery_method` STRING COMMENT 'How bank statements are delivered: electronic (email or portal), paper (postal mail), or both.. Valid values are `electronic|paper|both`',
    `branch_address` STRING COMMENT 'Full street address of the bank branch. Classified as confidential organizational contact data.',
    `branch_name` STRING COMMENT 'Name of the specific bank branch where the account is held, if applicable.',
    `cash_pool_group` STRING COMMENT 'Identifier for the cash pooling or notional pooling group this account belongs to. Used for multi-entity liquidity management and interest optimization.',
    `closing_date` DATE COMMENT 'The date the bank account was closed or terminated. Null for active accounts.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166 country code where the bank account is domiciled (e.g., USA, CAN, MEX, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this bank account record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the account (e.g., USD, EUR, GBP, CAD, MXN). Defines the denomination of balances and transactions.. Valid values are `^[A-Z]{3}$`',
    `dual_signature_required_flag` BOOLEAN COMMENT 'Indicates whether two authorized signatories are required for transactions above a certain threshold. True if dual control is mandated; false otherwise.',
    `dual_signature_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which dual signature is required. Null if dual signature is not applicable or always required.',
    `electronic_banking_code` STRING COMMENT 'Identifier or login ID for online banking or electronic funds transfer systems. Confidential to prevent unauthorized access.',
    `gl_account_code` STRING COMMENT 'The GL account code in the chart of accounts that this bank account reconciles to. Used for daily bank reconciliation and cash position reporting.',
    `iban` STRING COMMENT 'International Bank Account Number for accounts in IBAN-participating countries. Up to 34 alphanumeric characters. Restricted due to account identification sensitivity.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the account balance, expressed as a percentage. May be positive for interest-bearing accounts or negative for fee-based accounts.',
    `last_reconciliation_date` DATE COMMENT 'The date of the most recent successful bank reconciliation for this account.',
    `minimum_balance_amount` DECIMAL(18,2) COMMENT 'Minimum balance required to avoid fees or maintain account status. Null if no minimum is required.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this bank account record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments about the bank account (e.g., usage restrictions, special terms, historical context).',
    `opening_date` DATE COMMENT 'The date the bank account was opened with the financial institution.',
    `overdraft_facility_flag` BOOLEAN COMMENT 'Indicates whether the account has an overdraft or line of credit facility. True if overdraft is available; false otherwise.',
    `overdraft_limit_amount` DECIMAL(18,2) COMMENT 'Maximum overdraft or credit line available on this account. Null if no overdraft facility exists.',
    `payment_method_supported` STRING COMMENT 'Comma-separated list of payment methods supported by this account (e.g., ACH, wire, check, EFT, SEPA). [ENUM-REF-CANDIDATE: ACH|wire|check|EFT|SEPA|BACS|CHAPS|RTP — promote to reference product]',
    `primary_contact_email` STRING COMMENT 'Email address of the primary bank contact. Classified as confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary relationship manager or contact person at the bank for this account.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary bank contact. Classified as confidential organizational contact data.',
    `reconciliation_frequency` STRING COMMENT 'How often this bank account is reconciled against the general ledger: daily (high-volume operating accounts), weekly (moderate activity), monthly (low activity or reserve accounts).. Valid values are `daily|weekly|monthly`',
    `signatory_list` STRING COMMENT 'Comma-separated list of employee IDs or names authorized to sign checks or approve wire transfers on this account. Confidential for fraud prevention.',
    `swift_code` STRING COMMENT 'Bank Identifier Code (BIC) or SWIFT code for international wire transfers. 8 or 11 character alphanumeric code identifying the bank and branch.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Corporate bank account master record and daily transactional statement activity from SAP S/4HANA FI-TR (Treasury). Master data defines all operating, payroll, concentration, and zero-balance accounts across legal entities and geographies — storing bank name, account number (masked), IBAN/routing, account type, currency, cash pool group, signatory list, and reconciliation GL account. Statement lines capture daily electronic bank statement imports including value date, posting date, transaction type (credit/debit), amount, bank reference, counterparty name, clearing status, and matched GL posting. Supports daily automated bank reconciliation, real-time cash position reporting, fraud detection for restaurant cash deposits, POS settlement flow matching, and treasury cash pooling across entities.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` (
    `bank_statement_line_id` BIGINT COMMENT 'Unique identifier for the bank statement line item. Primary key for this entity.',
    `bank_account_id` BIGINT COMMENT 'Internal identifier for the bank account in SAP S/4HANA FI-TR. Links to the house bank and account configuration.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location associated with this transaction. Critical for restaurant-level cash reconciliation and POS settlement matching.',
    `bank_statement_id` BIGINT COMMENT 'Reference to the parent bank statement header containing this line item.',
    `bank_unit_id` BIGINT COMMENT 'Identifier of the restaurant location associated with this transaction. Critical for restaurant-level cash reconciliation and POS settlement matching.',
    `pos_settlement_batch_id` BIGINT COMMENT 'Reference to the POS settlement batch that generated this deposit. Used to match bank deposits to daily POS sales.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: REQUIRED: Bank statement reconciliation must reference the supplier to validate payments, a core accounting control.',
    `reversed_line_bank_statement_line_id` BIGINT COMMENT 'Reference to the original bank statement line that this transaction reverses, if applicable.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary amount of the bank transaction in the statement currency. Always positive; sign is indicated by transaction_type.',
    `bank_reference_number` STRING COMMENT 'Unique reference number assigned by the bank to this transaction. Used for bank inquiries and dispute resolution.',
    `clearing_date` DATE COMMENT 'Date on which the bank statement line was successfully matched and cleared against GL postings in SAP.',
    `clearing_document_number` STRING COMMENT 'SAP document number of the GL posting that cleared this bank statement line. Used for audit trail and drill-down.',
    `clearing_status` STRING COMMENT 'Status of the bank statement line in the reconciliation process. Indicates whether the transaction has been matched to GL postings.. Valid values are `uncleared|cleared|partially_cleared|manual_review|rejected`',
    `company_code` STRING COMMENT 'SAP company code identifying the legal entity to which this bank transaction belongs. Used for multi-entity consolidation and financial reporting.',
    `cost_center_code` STRING COMMENT 'Cost center assignment for the transaction, if applicable. Used for internal cost allocation and management reporting.',
    `counterparty_account_number` STRING COMMENT 'Bank account number of the counterparty. May be masked or partial depending on bank reporting.',
    `counterparty_bank_code` STRING COMMENT 'Bank identifier for the counterparty financial institution (e.g., routing number, SWIFT code, sort code).',
    `counterparty_name` STRING COMMENT 'Name of the party on the other side of the transaction (payer for credits, payee for debits). Used for matching and reconciliation.',
    `created_by_user` STRING COMMENT 'User ID or system account that created this record in the lakehouse.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the lakehouse silver layer.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert transaction currency to local currency. Null if currencies are the same.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year for financial reporting and period closing.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the transaction was posted, based on the company code fiscal calendar.',
    `fraud_detection_rule` STRING COMMENT 'Name or code of the fraud detection rule that triggered the fraud flag, if applicable.',
    `fraud_flag` BOOLEAN COMMENT 'Indicator that this transaction has been flagged for potential fraud or suspicious activity requiring investigation.',
    `gl_account_code` STRING COMMENT 'GL account to which this bank transaction was posted. Typically the main bank clearing account.',
    `import_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank statement line was imported into SAP S/4HANA from the electronic bank statement file.',
    `line_sequence_number` STRING COMMENT 'Sequential line number within the bank statement, used for ordering and reference.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the company code local currency for general ledger posting and P&L reporting.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this record in the lakehouse.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last modified in the lakehouse silver layer.',
    `notes` STRING COMMENT 'Free-text notes added by treasury or accounting staff during reconciliation or investigation.',
    `payment_reference` STRING COMMENT 'Payment reference or remittance information provided by the payer. Critical for matching to invoices and customer accounts.',
    `posting_date` DATE COMMENT 'The date on which the transaction is posted to the general ledger in SAP S/4HANA. May differ from value date for accounting period control.',
    `profit_center_code` STRING COMMENT 'Profit center assignment for segment reporting and P&L analysis. May represent a restaurant unit or brand.',
    `reconciliation_difference_amount` DECIMAL(18,2) COMMENT 'Difference amount identified during reconciliation between bank statement and GL postings. Zero when fully reconciled.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this line item is a reversal of a previous transaction.',
    `transaction_code` STRING COMMENT 'Bank-specific transaction code identifying the type of banking operation (e.g., wire transfer, check deposit, ACH, card settlement). Maps to BAI or MT940 transaction codes.',
    `transaction_date` DATE COMMENT 'The actual date the transaction occurred at the bank. Represents the real-world business event timestamp.',
    `transaction_description` STRING COMMENT 'Narrative description of the transaction provided by the bank, including purpose and additional details.',
    `transaction_type` STRING COMMENT 'Indicates whether the transaction is a credit (incoming funds) or debit (outgoing funds) to the bank account.. Valid values are `credit|debit`',
    `value_date` DATE COMMENT 'The date on which funds become available or are debited from the account. Used for cash position reporting and interest calculation.',
    CONSTRAINT pk_bank_statement_line PRIMARY KEY(`bank_statement_line_id`)
) COMMENT 'Electronic bank statement line items imported into SAP S/4HANA FI-TR for daily cash reconciliation. Each line captures value date, posting date, transaction type (credit/debit), amount, bank reference, counterparty name, clearing status, and matched GL posting. Supports automated bank reconciliation, cash position reporting, and fraud detection for restaurant cash deposits and POS settlement flows.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` (
    `lease_liability_id` BIGINT COMMENT 'Unique identifier for the lease_liability data product (auto-inserted pre-linking).',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Lease liabilities are associated with a legal entity; add FK to capture ownership.',
    `renewed_lease_liability_id` BIGINT COMMENT 'Self-referencing FK on lease_liability (renewed_lease_liability_id)',
    CONSTRAINT pk_lease_liability PRIMARY KEY(`lease_liability_id`)
) COMMENT 'Lease obligation and right-of-use (ROU) asset master record for ASC 842/IFRS 16 compliance from SAP S/4HANA RE-FX. Tracks operating and finance leases for restaurant locations, equipment, and vehicles. Stores lease term, commencement date, monthly payment, discount rate, ROU asset value, lease liability balance, modification history, and renewal/termination options. Critical for restaurant operators where 80%+ of locations are leased — supports balance sheet presentation, lease expense recognition, and lease maturity analysis.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`financial_period` (
    `financial_period_id` BIGINT COMMENT 'Unique identifier for the financial period record. Primary key.',
    `financial_comparative_prior_period_id` BIGINT COMMENT 'Foreign key reference to the immediately preceding period (e.g., prior month). Used for sequential period-over-period analysis.',
    `financial_comparative_prior_year_period_id` BIGINT COMMENT 'Foreign key reference to the equivalent period in the prior fiscal year. Used for year-over-year comparative analysis and SSS reporting.',
    `ledger_id` BIGINT COMMENT 'Two-character code identifying the ledger (leading ledger for primary GAAP, non-leading ledger for parallel IFRS, special purpose ledger for management reporting). Supports multi-GAAP parallel accounting.',
    `primary_prior_financial_period_id` BIGINT COMMENT 'Self-referencing FK on financial_period (prior_financial_period_id)',
    `comparative_prior_period_id` BIGINT COMMENT '',
    `comparative_prior_year_period_id` BIGINT COMMENT '',
    `accounting_principle` STRING COMMENT 'Accounting standard applied in this ledger: US_GAAP (United States Generally Accepted Accounting Principles), IFRS (International Financial Reporting Standards), local_GAAP (country-specific standards), management (internal reporting).. Valid values are `US_GAAP|IFRS|local_GAAP|management`',
    `adjustment_posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether adjustment postings (corrections, reclassifications) are allowed in this period after initial close. Used for controlled reopening during audit or correction cycles.',
    `adjustment_reason` STRING COMMENT 'Reason code or description for why the period is an adjustment period.',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether this period is subject to external audit review. Typically true for year-end periods and quarterly periods for publicly traded entities.',
    `audit_trail_flag` BOOLEAN COMMENT 'True if changes to this period are tracked for audit purposes.',
    `calendar_days_count` STRING COMMENT 'Total number of calendar days in the period. Used for daily average calculations and period normalization in financial analysis.',
    `calendar_month` STRING COMMENT 'Month number (1‑12) in the calendar year.',
    `calendar_quarter` STRING COMMENT 'Quarter number (1‑4) in the calendar year.',
    `calendar_year` STRING COMMENT 'Gregorian calendar year of the period.',
    `close_actual_date` DATE COMMENT 'Actual date when the period-end close process was completed and the period status changed to closed. Null if period is still open.',
    `close_scheduled_date` DATE COMMENT 'Target date for completing the period-end close process. Used for close calendar planning and tracking adherence to financial reporting deadlines.',
    `close_variance_days` STRING COMMENT 'Number of days between scheduled and actual close date (positive if late, negative if early). Used to track period-end close efficiency and identify process improvement opportunities.',
    `company_code` STRING COMMENT 'Four-character alphanumeric code identifying the legal entity in SAP S/4HANA. Links this period to a specific company within the multi-entity structure.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_group_code` STRING COMMENT 'Code identifying the consolidation group for multi‑entity reporting.',
    `consolidation_required_flag` BOOLEAN COMMENT 'Indicates whether this period requires multi-entity consolidation processing. True for periods where intercompany eliminations and consolidated financial reporting are performed.',
    `created_by_user` STRING COMMENT 'User ID or username of the person who created this financial period record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial period record was first created in the system. Used for audit trail and data lineage tracking.',
    `day_count` STRING COMMENT 'Total count of calendar days covered by the period.',
    `financial_period_description` STRING COMMENT 'Optional free‑text description of the period.',
    `effective_end_date` DATE COMMENT 'Date when the period ceases to be effective (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the period becomes effective for reporting purposes.',
    `end_date` DATE COMMENT 'Last calendar day of the financial period.',
    `exchange_rate_to_reporting` DECIMAL(18,2) COMMENT 'Conversion rate from functional currency to reporting currency for the period.',
    `exchange_rate_type` STRING COMMENT 'Type of exchange rate applied for currency translation in this period: average (period average rate for P&L), closing (period-end rate for balance sheet), budget (planning rate), historical (acquisition date rate for fixed assets).. Valid values are `average|closing|budget|historical`',
    `financial_statement_type` STRING COMMENT 'Type of financial statement the period primarily supports.. Valid values are `balance_sheet|income_statement|cash_flow|equity`',
    `fiscal_month` STRING COMMENT 'Month number (1‑12) within the fiscal year.',
    `fiscal_period_code` STRING COMMENT 'Standard code used by SAP for the fiscal period (e.g., "2023P01").',
    `fiscal_quarter` STRING COMMENT 'Quarter number (1‑4) within the fiscal year.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which this period belongs. May differ from calendar year depending on fiscal year variant configuration.',
    `fiscal_year_variant` STRING COMMENT 'Two-character code defining the fiscal calendar structure (number of periods, special periods, year-end rules) used by the company code. Determines how the fiscal year is divided into posting periods.. Valid values are `^[A-Z0-9]{2}$`',
    `holiday_indicator` STRING COMMENT 'Degree to which holidays affect the period.. Valid values are `none|partial|full`',
    `is_adjustment_period` BOOLEAN COMMENT 'True if the period is used for post‑close adjustments.',
    `is_current` BOOLEAN COMMENT 'True if this period is the active reporting period.',
    `is_estimated` BOOLEAN COMMENT 'True if the period values are based on estimates rather than actuals.',
    `is_holiday_period` BOOLEAN COMMENT 'True if the period includes a recognized holiday schedule.',
    `is_interim` BOOLEAN COMMENT 'True if the period is an interim (non‑full) reporting period.',
    `ledger_type` STRING COMMENT 'Classification of the ledger: leading (primary GAAP ledger for statutory reporting), non_leading (parallel IFRS or local GAAP ledger), special_purpose (management or segment reporting ledger).. Valid values are `leading|non_leading|special_purpose`',
    `lock_flag` BOOLEAN COMMENT 'True when the period is locked for posting to prevent changes.',
    `modified_by_user` STRING COMMENT 'User ID or username of the person who last modified this financial period record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial period record was last modified. Updated whenever period status, close dates, or other attributes change.',
    `notes` STRING COMMENT 'Free-text field for recording period-specific notes, exceptions, or special circumstances (e.g., Includes acquisition of XYZ brand, Impacted by COVID-19 closures, Leap year adjustment).',
    `period_category` STRING COMMENT 'Business classification of the period data.. Valid values are `actual|budget|forecast|plan`',
    `period_end_date` DATE COMMENT 'Last calendar date of the financial period. Defines the end of the posting window for transactions assigned to this period.',
    `period_key` STRING COMMENT 'Compact code representing the period (e.g., FY2023Q1, FY2023M04).',
    `period_name` STRING COMMENT 'Human-readable name or label for the period (e.g., January 2024, Q1 FY2024, Period 13 - Year-End Adjustments). Used for reporting and user interface display.',
    `period_number` STRING COMMENT 'Sequential period number within the fiscal year (typically 1-12 for monthly periods, or 1-13 for 4-4-5 retail calendars). Special periods (13, 14, 15, 16) used for year-end adjustments.',
    `period_sequence_number` STRING COMMENT 'Sequential order of the period within its fiscal year.',
    `period_start_date` DATE COMMENT 'First calendar date of the financial period. Defines the beginning of the posting window for transactions assigned to this period.',
    `period_status` STRING COMMENT 'Current posting status of the period: not_opened (future period, no posting allowed), open (active posting allowed), closed (period-end close completed, limited posting), locked (archived, no posting allowed).. Valid values are `not_opened|open|closed|locked`',
    `period_type` STRING COMMENT 'Classification of the period: regular (standard posting period), special (year-end adjustment period 13-16), or adjustment (mid-year correction period).. Valid values are `regular|special|adjustment`',
    `posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether new transactions can be posted to this period. True if period is open for posting, false if closed or locked.',
    `quarter_number` STRING COMMENT 'Fiscal quarter number (1-4) to which this period belongs. Supports quarterly financial reporting and Same-Store Sales (SSS) analysis.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for consolidated financial reporting in this period (e.g., USD for US Dollar, EUR for Euro). Used for multi-currency consolidation.. Valid values are `^[A-Z]{3}$`',
    `segment_reporting_flag` BOOLEAN COMMENT 'True if the period is used for segment‑level reporting.',
    `sss_eligible_flag` BOOLEAN COMMENT 'Indicates whether this period is eligible for Same-Store Sales (SSS) or Comparable Store Sales (Comp Sales) analysis. Typically true for periods where stores have been open for at least 12-13 months.',
    `start_date` DATE COMMENT 'First calendar day of the financial period.',
    `tax_reporting_flag` BOOLEAN COMMENT 'True if the period is used for tax reporting calculations.',
    `tax_reporting_period_flag` BOOLEAN COMMENT 'Indicates whether this period is a tax reporting period requiring submission of tax returns (e.g., quarterly estimated tax, annual tax filing). Used for tax compliance tracking.',
    `working_days_count` STRING COMMENT 'Number of business working days in the period, excluding weekends and holidays. Used for normalizing operational metrics and labor cost analysis.',
    `year_period_key` STRING COMMENT 'Concatenated key combining fiscal year and period number (format: YYYYPPP, e.g., 2024001 for FY2024 Period 1). Used for sorting and comparative period analysis.. Valid values are `^[0-9]{4}[0-9]{3}$`',
    CONSTRAINT pk_financial_period PRIMARY KEY(`financial_period_id`)
) COMMENT 'Master reference table for financial_period. ';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who triggered the payment run.',
    `reversed_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (reversed_payment_run_id)',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run finished processing.',
    `approval_status` STRING COMMENT 'Current approval state of the payment run.',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the payment run.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run was approved.',
    `batch_reference` STRING COMMENT 'External reference or identifier for the batch used by downstream systems.',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the payment run for accounting allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the payment run amounts.',
    `payment_run_description` STRING COMMENT 'Free‑form text describing the purpose or context of the payment run.',
    `error_count` BIGINT COMMENT 'Number of errors encountered during processing of the run.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems (e.g., banking partner) to reference the run.',
    `fiscal_period` STRING COMMENT 'Fiscal period (e.g., Q1, Q2) for the payment run.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the payment run belongs.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the payment run was generated automatically by the system.',
    `notes` STRING COMMENT 'Additional free‑form notes captured for the payment run.',
    `payment_channel` STRING COMMENT 'Technical channel through which the payment run was processed.',
    `payment_method` STRING COMMENT 'Instrument used to execute the payments.',
    `payment_run_type` STRING COMMENT 'Classification of the run based on its business purpose.',
    `processing_time_seconds` STRING COMMENT 'Total elapsed time in seconds for the run to complete.',
    `region_code` STRING COMMENT 'Geographic region identifier for the payment run (e.g., NA, EU, APAC).',
    `retry_flag` BOOLEAN COMMENT 'True if the run is a retry of a previously failed run.',
    `run_number` STRING COMMENT 'Business-visible sequential number assigned to the payment run.',
    `run_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run was initiated in the business process.',
    `scheduled_date` DATE COMMENT 'Planned calendar date for the payment run execution.',
    `settlement_date` DATE COMMENT 'Date on which the payments are settled with banks or vendors.',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Total discounts deducted from the gross amount.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all payment amounts before taxes, discounts, and fees.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount payable after taxes and discounts.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax amount applied to the payment run.',
    `transaction_count` BIGINT COMMENT 'Count of individual payment transactions included in the run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment run record.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`house_bank` (
    `house_bank_id` BIGINT COMMENT 'Primary key for house_bank',
    `parent_house_bank_id` BIGINT COMMENT 'Self-referencing FK on house_bank (parent_house_bank_id)',
    `account_number` STRING COMMENT 'Account number held at the house bank for cash transactions.',
    `bank_address` STRING COMMENT 'Primary street address of the bank.',
    `bank_type` STRING COMMENT 'Classification of the bank relationship.',
    `branch_code` STRING COMMENT 'Code identifying the specific branch of the bank.',
    `city` STRING COMMENT 'City where the bank is located.',
    `contact_email` STRING COMMENT 'Primary email address for bank communications.',
    `contact_phone` STRING COMMENT 'Primary telephone number for bank communications.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the bank location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the house bank record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the bank account.',
    `house_bank_description` STRING COMMENT 'Additional free-text description or notes about the house bank.',
    `effective_from` DATE COMMENT 'Date when the house bank relationship becomes effective.',
    `effective_until` DATE COMMENT 'Date when the house bank relationship ends, if applicable.',
    `internal_code` STRING COMMENT 'Internal code used by the organization to reference the house bank.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this house bank is the default for cash management operations.',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent account reconciliation with the house bank.',
    `house_bank_name` STRING COMMENT 'Legal name of the bank used for cash management.',
    `region` STRING COMMENT 'Geographic region classification for the house bank.',
    `routing_number` STRING COMMENT 'Routing number used for domestic transfers (e.g., ABA number).',
    `settlement_method` STRING COMMENT 'Preferred method for settling payments with this house bank.',
    `house_bank_status` STRING COMMENT 'Current operational status of the house bank.',
    `swift_code` STRING COMMENT 'International SWIFT/BIC code identifying the bank.',
    `tax_id_number` STRING COMMENT 'Tax identification number of the bank.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the house bank record.',
    CONSTRAINT pk_house_bank PRIMARY KEY(`house_bank_id`)
) COMMENT 'Master reference table for house_bank. Referenced by house_bank_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` (
    `bank_statement_id` BIGINT COMMENT 'Primary key for bank_statement',
    `bank_account_id` BIGINT COMMENT 'add column bank_account_id (BIGINT) with FK to finance.bank_account.bank_account_id - bank statements must reference which bank account they belong to',
    `prior_bank_statement_id` BIGINT COMMENT 'Self-referencing FK on bank_statement (prior_bank_statement_id)',
    `account_number` STRING COMMENT 'The bank account number to which this statement belongs.',
    `bank_name` STRING COMMENT 'Name of the financial institution that issued the statement.',
    `closing_balance` DECIMAL(18,2) COMMENT 'Account balance at the end of the statement period.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used in the statement.',
    `file_format` STRING COMMENT 'Digital format of the statement file.',
    `file_path` STRING COMMENT 'Storage location or URI of the statement file within the data lake.',
    `generated_timestamp` TIMESTAMP COMMENT 'Date‑time when the statement file was generated by the bank.',
    `is_electronic` BOOLEAN COMMENT 'True if the statement was delivered electronically; false if paper.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the statement record.',
    `notes` STRING COMMENT 'Free‑form field for any extra information or comments.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Account balance at the start of the statement period.',
    `period_end` DATE COMMENT 'Last calendar date covered by the statement.',
    `period_start` DATE COMMENT 'First calendar date covered by the statement.',
    `processed_by` STRING COMMENT 'User identifier of the employee who processed the statement.',
    `processing_timestamp` TIMESTAMP COMMENT 'Date‑time when the statement was processed into the system.',
    `received_date` DATE COMMENT 'Date the statement was received by the finance team.',
    `reconciliation_status` STRING COMMENT 'Result of the automated or manual reconciliation of the statement.',
    `statement_description` STRING COMMENT 'Optional free‑text description or notes about the statement.',
    `statement_hash` STRING COMMENT 'Hash value used to verify the integrity of the statement file.',
    `statement_number` STRING COMMENT 'Human‑readable identifier assigned by the bank for the statement period.',
    `statement_type` STRING COMMENT 'Classification of the statement frequency or purpose.',
    `bank_statement_status` STRING COMMENT 'Current lifecycle status of the statement.',
    `total_credits` DECIMAL(18,2) COMMENT 'Aggregate amount of all credit transactions in the statement.',
    `total_debits` DECIMAL(18,2) COMMENT 'Aggregate amount of all debit transactions in the statement.',
    `transaction_count` STRING COMMENT 'Number of individual transactions recorded in the statement.',
    CONSTRAINT pk_bank_statement PRIMARY KEY(`bank_statement_id`)
) COMMENT 'Master reference table for bank_statement. Referenced by bank_statement_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` (
    `pos_settlement_batch_id` BIGINT COMMENT 'Primary key for pos_settlement_batch',
    `cost_center_id` BIGINT COMMENT 'Identifier of the internal cost center associated with the batch for accounting allocation.',
    `resubmitted_pos_settlement_batch_id` BIGINT COMMENT 'Self-referencing FK on pos_settlement_batch (resubmitted_pos_settlement_batch_id)',
    `batch_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the settlement batch.',
    `batch_number` STRING COMMENT 'Human‑readable batch code assigned by the finance system.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Exact moment the settlement event occurred in the source system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement batch record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values in the batch.',
    `merchant_code` BIGINT COMMENT 'Unique identifier of the merchant (restaurant entity) to which the batch belongs.',
    `merchant_name` STRING COMMENT 'Legal name of the restaurant or franchise associated with the batch.',
    `period_end_date` DATE COMMENT 'End date of the accounting period covered by the settlement batch.',
    `period_start_date` DATE COMMENT 'Start date of the accounting period covered by the settlement batch.',
    `processing_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement batch was processed by the finance system.',
    `settlement_date` DATE COMMENT 'Calendar date on which the batch settlement is recorded.',
    `settlement_method` STRING COMMENT 'Mechanism used to transfer funds to the merchant.',
    `settlement_type` STRING COMMENT 'Frequency or nature of the settlement batch (e.g., daily, weekly).',
    `pos_settlement_batch_status` STRING COMMENT 'Current processing state of the settlement batch.',
    `total_fee_amount` DECIMAL(18,2) COMMENT 'Total of processing and service fees deducted from the gross amount.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all transaction amounts before taxes, fees, and adjustments.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount payable to the merchant after taxes and fees.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax component for the settlement batch.',
    `transaction_count` STRING COMMENT 'Number of individual POS transactions included in the batch.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the settlement batch record.',
    CONSTRAINT pk_pos_settlement_batch PRIMARY KEY(`pos_settlement_batch_id`)
) COMMENT 'Master reference table for pos_settlement_batch. Referenced by pos_settlement_batch_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` (
    `allocation_rule_id` BIGINT COMMENT 'Primary key for allocation_rule',
    `cost_center_id` BIGINT COMMENT 'add column cost_center_id (BIGINT) with FK to finance.cost_center.cost_center_id - allocation rules need to specify target cost centers',
    `parent_allocation_rule_id` BIGINT COMMENT 'Self-referencing FK on allocation_rule (parent_allocation_rule_id)',
    `allocation_basis` STRING COMMENT 'Business metric on which allocation is based.',
    `allocation_method` STRING COMMENT 'Method used to calculate allocation.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage value applied when method is percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was created.',
    `allocation_rule_description` STRING COMMENT 'Detailed description of the rule purpose and logic.',
    `effective_from` DATE COMMENT 'Date when the rule becomes effective.',
    `effective_until` DATE COMMENT 'Date when the rule expires; null if indefinite.',
    `fixed_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount allocated per period.',
    `is_system_generated` BOOLEAN COMMENT 'Indicates if the rule was generated by system processes.',
    `notes` STRING COMMENT 'Free-text field for any extra information.',
    `priority` STRING COMMENT 'Priority order when multiple rules apply; lower number = higher priority.',
    `rule_code` STRING COMMENT 'Business code used to reference the rule.',
    `rule_name` STRING COMMENT 'Descriptive name of the allocation rule.',
    `rule_type` STRING COMMENT 'Category of rule such as cost, revenue, overhead, intercompany, or budget.',
    `allocation_rule_status` STRING COMMENT 'Current lifecycle status of the rule.',
    `updated_by` STRING COMMENT 'User or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule.',
    `variable_amount_formula` STRING COMMENT 'Expression defining variable allocation amount.',
    `created_by` STRING COMMENT 'User or system that created the rule.',
    CONSTRAINT pk_allocation_rule PRIMARY KEY(`allocation_rule_id`)
) COMMENT 'Master reference table for allocation_rule. Referenced by allocation_rule_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` (
    `hierarchy_node_id` BIGINT COMMENT 'Primary key for hierarchy_node',
    `parent_hierarchy_node_id` BIGINT COMMENT 'Self-referencing FK on hierarchy_node (parent_hierarchy_node_id)',
    `parent_node_id` BIGINT COMMENT 'Identifier of the immediate parent node in the hierarchy.',
    `business_unit` STRING COMMENT 'Name of the business unit to which the node belongs.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center code associated with the node for budgeting and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hierarchy node record was first created.',
    `hierarchy_node_description` STRING COMMENT 'Optional free‑text description providing additional context about the node.',
    `effective_from` DATE COMMENT 'Date when the node becomes effective in the hierarchy.',
    `effective_until` DATE COMMENT 'Date when the node ceases to be effective; null if open‑ended.',
    `external_system_code` STRING COMMENT 'Identifier of the node in an external system (e.g., SAP hierarchy ID).',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the node within the hierarchy (root = 0).',
    `hierarchy_path` STRING COMMENT 'Delimited path representing the nodes ancestry (e.g., /1/4/23).',
    `is_leaf` BOOLEAN COMMENT 'Indicates whether the node has no child nodes.',
    `node_code` STRING COMMENT 'Unique business code identifying the node within its hierarchy.',
    `node_name` STRING COMMENT 'Human‑readable name of the hierarchy node.',
    `node_type` STRING COMMENT 'Classification of the node indicating its role in the hierarchy (e.g., organization, region, brand).',
    `node_value` DECIMAL(18,2) COMMENT 'Monetary or quantitative value associated with the node (e.g., budget allocation).',
    `node_weight` DECIMAL(18,2) COMMENT 'Numeric weight assigned to the node for allocation or scoring purposes.',
    `profit_center_code` STRING COMMENT 'Financial profit‑center code linked to the node for performance measurement.',
    `region_code` STRING COMMENT 'Standardized code representing the geographic region of the node.',
    `sort_order` STRING COMMENT 'Integer used to order sibling nodes under the same parent.',
    `hierarchy_node_status` STRING COMMENT 'Current lifecycle status of the node.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the hierarchy node record.',
    CONSTRAINT pk_hierarchy_node PRIMARY KEY(`hierarchy_node_id`)
) COMMENT 'Master reference table for hierarchy_node. Referenced by hierarchy_node_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Primary key for ledger',
    `parent_ledger_id` BIGINT COMMENT 'Self-referencing FK on ledger (parent_ledger_id)',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual amount posted to the ledger for the period.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount for the ledger period.',
    `ledger_category` STRING COMMENT 'Accounting category of the ledger as defined by GAAP/IFRS.',
    `closing_balance` DECIMAL(18,2) COMMENT 'Balance at the end of the fiscal period.',
    `ledger_code` STRING COMMENT 'External code or number used to reference the ledger in financial reports and ERP systems.',
    `consolidation_level` STRING COMMENT 'Level at which the ledger is consolidated.',
    `cost_center_code` STRING COMMENT 'Code of the cost center associated with the ledger.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ledger record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the functional currency for the ledger.',
    `current_balance` DECIMAL(18,2) COMMENT 'Real‑time balance of the ledger.',
    `department_code` STRING COMMENT 'Organizational department linked to the ledger.',
    `ledger_description` STRING COMMENT 'Free‑form description providing additional context about the ledger.',
    `effective_from` DATE COMMENT 'Date when the ledger becomes effective for posting.',
    `effective_until` DATE COMMENT 'Date when the ledger is retired or superseded (null if open‑ended).',
    `exchange_rate_to_reporting` DECIMAL(18,2) COMMENT 'Conversion rate from functional currency to reporting currency.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the ledger balances belong.',
    `is_budgeted` BOOLEAN COMMENT 'Indicates whether the ledger has an associated budget.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the ledger is part of a consolidated financial statement.',
    `last_reconciled_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful reconciliation of the ledger.',
    `ledger_type` STRING COMMENT 'Category of ledger indicating its purpose within the chart of accounts.',
    `ledger_name` STRING COMMENT 'Human‑readable name of the ledger (e.g., "Corporate GL", "Restaurant Cost Center").',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the ledger.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance at the start of the fiscal period.',
    `period` STRING COMMENT 'Financial reporting period (quarter or full year) for the ledger.',
    `reporting_currency_code` STRING COMMENT 'Currency in which the ledger is reported for consolidated financial statements.',
    `ledger_status` STRING COMMENT 'Current operational status of the ledger.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ledger record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual amounts.',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between budgeted and actual amounts.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'Master reference table for ledger. Referenced by ledger_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Primary key for chart_of_accounts',
    `parent_account_id` BIGINT COMMENT 'Identifier of the immediate parent account in the hierarchical chart.',
    `parent_chart_of_accounts_id` BIGINT COMMENT 'Self-referencing FK on chart_of_accounts (parent_chart_of_accounts_id)',
    `account_name` STRING COMMENT 'Descriptive name of the GL account used in financial reporting.',
    `account_number` STRING COMMENT 'Unique alphanumeric code assigned to the GL account by the finance system.',
    `account_subtype` STRING COMMENT 'Secondary classification providing more granular detail (e.g., Cash, Accounts Receivable).',
    `account_type` STRING COMMENT 'Primary classification of the account for financial statement mapping.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount for the account for the fiscal year.',
    `cost_center_code` STRING COMMENT 'Code linking the account to a cost center for expense allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code applicable to the account balances.',
    `chart_of_accounts_description` STRING COMMENT 'Extended textual description of the account purpose and usage.',
    `effective_from` DATE COMMENT 'Date when the account becomes effective for posting.',
    `effective_to` DATE COMMENT 'Date when the account is retired or no longer usable (null if open-ended).',
    `external_reference` STRING COMMENT 'Identifier used to map the GL account to external financial systems.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the account belongs.',
    `gl_account_group` STRING COMMENT 'Logical grouping of accounts for reporting roll‑ups.',
    `is_budgeted` BOOLEAN COMMENT 'Indicates whether the account is included in the annual budgeting process.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the account is included in legal entity consolidation.',
    `is_tax_account` BOOLEAN COMMENT 'True if the account is used for tax‑related postings.',
    `last_review_date` DATE COMMENT 'Date of the most recent governance or compliance review of the account.',
    `chart_of_accounts_level` STRING COMMENT 'Depth level of the account within the chart hierarchy (root = 0).',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance.',
    `profit_center_code` STRING COMMENT 'Code linking the account to a profit center for revenue attribution.',
    `reporting_category` STRING COMMENT 'Category used for internal management reporting.',
    `segment_code` STRING COMMENT 'Identifier of the business segment (e.g., Dine‑In, Delivery) associated with the account.',
    `chart_of_accounts_status` STRING COMMENT 'Current lifecycle status of the GL account.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for tax accounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the account record.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Master reference table for chart_of_accounts. Referenced by chart_of_accounts_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_parent_account_gl_account_id` FOREIGN KEY (`parent_account_gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_primary_ultimate_parent_entity_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_entity_legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_original_accrual_royalty_accrual_id` FOREIGN KEY (`original_accrual_royalty_accrual_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`royalty_accrual`(`royalty_accrual_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_house_bank_id` FOREIGN KEY (`house_bank_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_bank_statement_id` FOREIGN KEY (`bank_statement_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_statement`(`bank_statement_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_pos_settlement_batch_id` FOREIGN KEY (`pos_settlement_batch_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`pos_settlement_batch`(`pos_settlement_batch_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_reversed_line_bank_statement_line_id` FOREIGN KEY (`reversed_line_bank_statement_line_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_statement_line`(`bank_statement_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_renewed_lease_liability_id` FOREIGN KEY (`renewed_lease_liability_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`lease_liability`(`lease_liability_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_financial_comparative_prior_period_id` FOREIGN KEY (`financial_comparative_prior_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_financial_comparative_prior_year_period_id` FOREIGN KEY (`financial_comparative_prior_year_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_primary_prior_financial_period_id` FOREIGN KEY (`primary_prior_financial_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_comparative_prior_period_id` FOREIGN KEY (`comparative_prior_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_comparative_prior_year_period_id` FOREIGN KEY (`comparative_prior_year_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_reversed_payment_run_id` FOREIGN KEY (`reversed_payment_run_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ADD CONSTRAINT `fk_finance_house_bank_parent_house_bank_id` FOREIGN KEY (`parent_house_bank_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_prior_bank_statement_id` FOREIGN KEY (`prior_bank_statement_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_statement`(`bank_statement_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ADD CONSTRAINT `fk_finance_pos_settlement_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ADD CONSTRAINT `fk_finance_pos_settlement_batch_resubmitted_pos_settlement_batch_id` FOREIGN KEY (`resubmitted_pos_settlement_batch_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`pos_settlement_batch`(`pos_settlement_batch_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_parent_allocation_rule_id` FOREIGN KEY (`parent_allocation_rule_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ADD CONSTRAINT `fk_finance_hierarchy_node_parent_hierarchy_node_id` FOREIGN KEY (`parent_hierarchy_node_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ADD CONSTRAINT `fk_finance_hierarchy_node_parent_node_id` FOREIGN KEY (`parent_node_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_parent_ledger_id` FOREIGN KEY (`parent_ledger_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_parent_chart_of_accounts_id` FOREIGN KEY (`parent_chart_of_accounts_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_restaurants_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `parent_account_gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent General Ledger (GL) Account ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_business_glossary_term' = 'Account Currency');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|closed|pending_activation');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `alternate_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternate Account Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `alternate_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `alternate_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Statement Classification');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_value_regex' = 'operating|investing|financing|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `gaap_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Account Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `ifrs_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Account Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `line_item_display_indicator` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `open_item_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `posting_allowed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `profit_loss_classification` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Classification');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `segment_reporting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `statistical_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_node_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `capex_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Eligible Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'revenue_generating|support|administrative|overhead|capital_project');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cogs_percent_target` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold Percent (COGS%) Target');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cogs_percent_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended|planned');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'restaurant_unit|regional_office|corporate_department|shared_service_center|distribution_center|franchise_support');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `drive_thru_lanes` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Lanes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Format Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `format_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `franchise_flag` SET TAGS ('dbx_business_glossary_term' = 'Franchise Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_boilerplate_cleaned' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `labor_percent_target` SET TAGS ('dbx_business_glossary_term' = 'Labor Percent (Labor%) Target');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `labor_percent_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `opex_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OpEx) Allocation Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `opex_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|allocated_revenue|allocated_headcount|allocated_sqft|allocated_transactions|fixed_percentage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `hierarchy_node_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Node Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `aov_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV) Target Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_boilerplate_cleaned' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_value_regex' = 'operating|non_operating|corporate|shared_services');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `consolidation_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `cost_center_group_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `ebitda_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Target Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `marketing_fund_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Ownership Model');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'company_owned|franchise|joint_venture|licensed');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `segment_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Segment Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'restaurant_unit|brand_segment|geographic_region|franchise_group|company_owned_group|channel_segment');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `sss_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales (SSS) Eligible Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_entity_legal_entity_id` SET TAGS ('dbx_boilerplate_cleaned' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS|local_statutory');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'full|proportionate|equity|none');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_boilerplate_cleaned' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dormant|liquidation|dissolved');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'company_owned|franchise_subsidiary|holding_company|joint_venture|partnership|branch');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `intercompany_clearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Clearing Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_state_province` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State or Province');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `profit_center_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_boilerplate_cleaned' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `segment_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `approver_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `approver_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_last_modified_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_last_modified_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `adjustment_period_indicator` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Period Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `audit_class` SET TAGS ('dbx_business_glossary_term' = 'Audit Class');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `audit_class` SET TAGS ('dbx_value_regex' = 'standard|high_risk|manual_adjustment|system_generated');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `baseline_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `batch_input_session` SET TAGS ('dbx_business_glossary_term' = 'Batch Input Session');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `consolidation_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Transaction Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `consolidation_transaction_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `net_due_date` SET TAGS ('dbx_business_glossary_term' = 'Net Due Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `parked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Parked Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|rejected|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_document_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Document Currency');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special General Ledger (GL) Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `user_name` SET TAGS ('dbx_business_glossary_term' = 'User Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_value_regex' = 'food_beverage|equipment|repairs_maintenance|utilities|services|other');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|posted|approved|paid|cancelled|on_hold');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire_transfer|credit_card|cash');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance_quantity|variance_price|variance_gr|not_applicable|pending');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `ap_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice Line ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `ap_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice Header ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|on_hold');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `goods_receipt_line_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Line Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `is_capex` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Expenditure (CapEx)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `is_cogs` SET TAGS ('dbx_business_glossary_term' = 'Is Cost of Goods Sold (COGS)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'item|service|freight|tax|discount|surcharge');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|variance|blocked');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `purchase_order_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Quantity');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `total_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Line Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `business_area` SET TAGS ('dbx_boilerplate_cleaned' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `discount_taken_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `document_currency` SET TAGS ('dbx_business_glossary_term' = 'Document Currency');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `document_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `invoice_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Count');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire_transfer|check|electronic_funds_transfer|virtual_card|international_wire');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|failed|cancelled|reversed');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'vendor_invoice|credit_memo|down_payment|advance_payment|expense_reimbursement');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|exception|pending_review');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Remittance Email');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Account Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Email Address');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'royalty|franchise_fee|catering|gift_card_settlement|intercompany|rebate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|direct_debit|cash');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Payment ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `discount_taken_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `dso_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO) Impact Days');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|debit_card|cash');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'royalty|franchise_fee|marketing_fund|catering_invoice|intercompany_settlement|other');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `wire_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Confirmation Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_capital');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'kitchen_equipment|pos_hardware|leasehold_improvements|furniture_fixtures|vehicles|it_infrastructure');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_subclass` SET TAGS ('dbx_business_glossary_term' = 'Asset Subclass');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `capex_project_code` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Project Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `capex_project_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{6}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|scrapped|donated|traded_in|transferred');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `lease_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lease Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` SET TAGS ('dbx_subdomain' = 'asset_capital');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_depreciation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Depreciation ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `acquisition_value` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Value');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Retirement Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Serial Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = '01|10|15|20|30|40');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production|double_declining_balance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_status` SET TAGS ('dbx_value_regex' = 'posted|planned|reversed|adjusted');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `gl_account_accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Accumulated Depreciation');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `gl_account_accumulated_depreciation` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `gl_account_depreciation_expense` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Depreciation Expense');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `gl_account_depreciation_expense` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `baseline_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|locked');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `consolidation_entity` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entity');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `nro_flag` SET TAGS ('dbx_business_glossary_term' = 'New Restaurant Opening (NRO) Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `nro_project_code` SET TAGS ('dbx_business_glossary_term' = 'New Restaurant Opening (NRO) Project Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'company_owned|franchise|joint_venture');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Budget Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `variance_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `version_code` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|reforecast|final');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_driver` SET TAGS ('dbx_business_glossary_term' = 'Allocation Driver');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|proportional|driver_based|zero_based|incremental');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `baseline_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Budget Percentage Target');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Budget Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|actual');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `quantity_target` SET TAGS ('dbx_business_glossary_term' = 'Quantity Target');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `original_accrual_royalty_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Original Accrual ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `accrual_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `accrual_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `accrued_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Royalty Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `adjustment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `franconnect_calculation_reference` SET TAGS ('dbx_business_glossary_term' = 'FranConnect Calculation ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `gl_document_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `gl_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `marketing_fund_contribution` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Contribution');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `marketing_fund_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Recognition Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'accrued|recognized|deferred|reversed|adjusted');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_base_net_sales` SET TAGS ('dbx_business_glossary_term' = 'Royalty Base Net Sales');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `technology_fee` SET TAGS ('dbx_business_glossary_term' = 'Technology Fee');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `technology_fee_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Technology Fee Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ALTER COLUMN `total_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Accrued Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_date` SET TAGS ('dbx_business_glossary_term' = 'Elimination Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_boilerplate_cleaned' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_boilerplate_cleaned' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Netting Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|under_review');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reconciled|disputed|reversed|eliminated');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'management_fee|shared_service_allocation|intercompany_loan|food_supply_transfer|royalty_charge|rent_allocation');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjustment Reason');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Audit Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `document_line_item` SET TAGS ('dbx_business_glossary_term' = 'Document Line Item Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Reason');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_direction` SET TAGS ('dbx_business_glossary_term' = 'Tax Direction');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_direction` SET TAGS ('dbx_value_regex' = 'input|output');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_filing_status` SET TAGS ('dbx_value_regex' = 'pending|filed|paid|audited|adjusted');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'sales_tax|use_tax|vat|withholding_tax|excise_tax|franchise_tax');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `period_sign_off_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `period_sign_off_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `period_sign_off_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `accrual_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Posting Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `accrual_posting_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `adjustment_entry_count` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Entry Count');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `ap_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `ap_reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `ar_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `ar_reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `audit_readiness_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Readiness Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `bank_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `bank_reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|exceptions_pending');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `close_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Completed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `close_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Close Duration Hours');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `close_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Initiated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `close_phase` SET TAGS ('dbx_business_glossary_term' = 'Close Phase');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `close_phase` SET TAGS ('dbx_value_regex' = 'pre_close|soft_close|hard_close|post_close');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_business_glossary_term' = 'Close Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `depreciation_run_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `depreciation_run_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `financial_statement_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `financial_statement_status` SET TAGS ('dbx_value_regex' = 'not_started|draft|review|approved|published');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `gl_account_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `gl_account_reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|exceptions_pending');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `inventory_valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `inventory_valuation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `marketing_fund_accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Accrual Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `marketing_fund_accrual_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|special');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `reopen_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Reopen Authorized By');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `reopen_reason` SET TAGS ('dbx_business_glossary_term' = 'Reopen Reason');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `reopen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reopen Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `responsible_controller_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Controller Email');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `responsible_controller_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `responsible_controller_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `responsible_controller_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `responsible_controller_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Controller Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `royalty_accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `royalty_accrual_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `scheduled_close_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Close Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `tax_provision_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `tax_provision_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `variance_analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Variance Analysis Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `variance_analysis_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|reviewed');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_value` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Value');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Batch ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Allocation Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_document_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|parked|error');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'assessment|distribution|periodic_reposting|settlement');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Ownership Model');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'company_owned|franchise|joint_venture');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `receiver_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Receiver Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `receiver_cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Receiver Cost Center Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `receiver_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Receiver Profit Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `sender_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `sender_cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` SET TAGS ('dbx_subdomain' = 'asset_capital');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Project ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `capex_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `actual_capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Capitalization Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'building|equipment|technology|vehicle|furniture|leasehold_improvement');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `auc_gl_account` SET TAGS ('dbx_business_glossary_term' = 'Asset Under Construction (AUC) General Ledger (GL) Account');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `auc_gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `capex_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `capex_category` SET TAGS ('dbx_value_regex' = 'growth|maintenance|compliance|efficiency|strategic');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `expected_capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Capitalization Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period Months');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Email');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'initiation|design|procurement|construction|commissioning|closeout');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'NRO|remodel|equipment_replacement|technology_infrastructure|maintenance_capex|facility_expansion');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `remaining_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `roi_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Target Percent');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'treasury_cash');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|frozen|pending_activation');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|payroll|concentration|zero_balance|escrow|reserve');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_key` SET TAGS ('dbx_business_glossary_term' = 'Bank Key');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_statement_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Delivery Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_statement_delivery_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|both');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `cash_pool_group` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Group');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `dual_signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Signature Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `dual_signature_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Dual Signature Threshold Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `electronic_banking_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Banking ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `electronic_banking_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `overdraft_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Facility Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `payment_method_supported` SET TAGS ('dbx_business_glossary_term' = 'Payment Methods Supported');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_list` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory List');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Code (BIC)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` SET TAGS ('dbx_subdomain' = 'treasury_cash');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `bank_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Line ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `bank_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `pos_settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Settlement Batch ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `reversed_line_bank_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Line ID');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'uncleared|cleared|partially_cleared|manual_review|rejected');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Account Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Bank Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `fraud_detection_rule` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Rule');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `import_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Import Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `reconciliation_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Difference Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'credit|debit');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` SET TAGS ('dbx_subdomain' = 'asset_capital');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ALTER COLUMN `lease_liability_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for lease_liability');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ALTER COLUMN `renewed_lease_liability_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Lease Liability Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ALTER COLUMN `renewed_lease_liability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `financial_comparative_prior_period_id` SET TAGS ('dbx_business_glossary_term' = 'Comparative Prior Period Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `financial_comparative_prior_year_period_id` SET TAGS ('dbx_business_glossary_term' = 'Comparative Prior Year Period Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `primary_prior_financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Financial Period Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `primary_prior_financial_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `comparative_prior_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `comparative_prior_period_id` SET TAGS ('dbx_relationship_label' = 'comparative_prior_period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `comparative_prior_year_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `comparative_prior_year_period_id` SET TAGS ('dbx_relationship_label' = 'comparative_prior_year_period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_business_glossary_term' = 'Accounting Principle');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_value_regex' = 'US_GAAP|IFRS|local_GAAP|management');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `adjustment_posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posting Allowed Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `audit_trail_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `calendar_days_count` SET TAGS ('dbx_business_glossary_term' = 'Calendar Days Count');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `calendar_month` SET TAGS ('dbx_business_glossary_term' = 'Calendar Month');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `calendar_quarter` SET TAGS ('dbx_business_glossary_term' = 'Calendar Quarter');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `close_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Close Actual Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `close_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Close Scheduled Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `close_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Close Variance Days');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `consolidation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `consolidation_required_flag` SET TAGS ('dbx_boilerplate_cleaned' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `day_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Days in Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `financial_period_description` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `exchange_rate_to_reporting` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to Reporting Currency');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'average|closing|budget|historical');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `financial_statement_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `financial_statement_type` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow|equity');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `fiscal_period_code` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `holiday_indicator` SET TAGS ('dbx_business_glossary_term' = 'Holiday Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `holiday_indicator` SET TAGS ('dbx_value_regex' = 'none|partial|full');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `is_adjustment_period` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Period Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Current Period Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Estimated Period Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `is_holiday_period` SET TAGS ('dbx_business_glossary_term' = 'Holiday Period Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `is_interim` SET TAGS ('dbx_business_glossary_term' = 'Interim Period Indicator');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `ledger_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `ledger_type` SET TAGS ('dbx_value_regex' = 'leading|non_leading|special_purpose');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Period Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_category` SET TAGS ('dbx_business_glossary_term' = 'Period Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_category` SET TAGS ('dbx_value_regex' = 'actual|budget|forecast|plan');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_key` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Key');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Period Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'not_opened|open|closed|locked');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'regular|special|adjustment');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `quarter_number` SET TAGS ('dbx_business_glossary_term' = 'Quarter Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `segment_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `sss_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales (SSS) Eligible Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `tax_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `tax_reporting_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `working_days_count` SET TAGS ('dbx_business_glossary_term' = 'Working Days Count');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `year_period_key` SET TAGS ('dbx_business_glossary_term' = 'Year Period Key');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `year_period_key` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[0-9]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `reversed_payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Payment Run Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `reversed_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch Reference');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `processing_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Time Seconds');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `retry_flag` SET TAGS ('dbx_business_glossary_term' = 'Retry Flag');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` SET TAGS ('dbx_subdomain' = 'treasury_cash');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank Identifier');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `parent_house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Parent House Bank Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `parent_house_bank_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `bank_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Address');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `bank_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `bank_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `bank_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `house_bank_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `internal_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `house_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `house_bank_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Swift Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `swift_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `swift_code` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Id Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` SET TAGS ('dbx_subdomain' = 'treasury_cash');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Identifier');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `prior_bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Bank Statement Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `prior_bank_statement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Generated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `is_electronic` SET TAGS ('dbx_business_glossary_term' = 'Is Electronic');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Period End');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Period Start');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `processed_by` SET TAGS ('dbx_business_glossary_term' = 'Processed By');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `statement_description` SET TAGS ('dbx_business_glossary_term' = 'Statement Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `statement_hash` SET TAGS ('dbx_business_glossary_term' = 'Statement Hash');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `bank_statement_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `total_credits` SET TAGS ('dbx_business_glossary_term' = 'Total Credits');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `total_debits` SET TAGS ('dbx_business_glossary_term' = 'Total Debits');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` SET TAGS ('dbx_subdomain' = 'treasury_cash');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `pos_settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Settlement Batch Identifier');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `resubmitted_pos_settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Resubmitted Pos Settlement Batch Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `resubmitted_pos_settlement_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `batch_description` SET TAGS ('dbx_business_glossary_term' = 'Batch Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Business Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `merchant_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `pos_settlement_batch_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `total_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `parent_allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Allocation Rule Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `parent_allocation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `is_system_generated` SET TAGS ('dbx_business_glossary_term' = 'Is System Generated');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `variable_amount_formula` SET TAGS ('dbx_business_glossary_term' = 'Variable Amount Formula');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `hierarchy_node_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Identifier');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `parent_hierarchy_node_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy Node Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `parent_hierarchy_node_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `parent_node_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Node Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `hierarchy_node_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `is_leaf` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `node_value` SET TAGS ('dbx_business_glossary_term' = 'Node Value');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `node_weight` SET TAGS ('dbx_business_glossary_term' = 'Node Weight');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `hierarchy_node_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `parent_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Ledger Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `parent_ledger_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `ledger_category` SET TAGS ('dbx_business_glossary_term' = 'Ledger Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `closing_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `ledger_code` SET TAGS ('dbx_business_glossary_term' = 'Ledger Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Level');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `ledger_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `exchange_rate_to_reporting` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate To Reporting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Is Budgeted');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `last_reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciled Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `ledger_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `ledger_name` SET TAGS ('dbx_business_glossary_term' = 'Ledger Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `opening_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `ledger_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `variance_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Identifier');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Chart Of Accounts Id');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_subtype` SET TAGS ('dbx_business_glossary_term' = 'Account Subtype');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_group` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Group');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Is Budgeted');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_tax_account` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Account');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_level` SET TAGS ('dbx_business_glossary_term' = 'Level');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Reporting Category');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
