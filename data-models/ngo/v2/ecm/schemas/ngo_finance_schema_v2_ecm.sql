-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`finance` COMMENT 'Systems of record: SAP S/4HANA (GL, AP, AR, FM), SAP FICO, Integra (IRC), SUN Systems. Accounting frameworks: IPSAS (UN agencies), US GAAP/ASC 958 (US-based INGOs), IFRS (international NGOs). Dual-framework reporting supported via configurable chart of accounts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`finance_fund` (
    `finance_fund_id` BIGINT COMMENT 'Primary key',
    `obligation_id` BIGINT COMMENT 'FK to compliance obligation',
    `constituent_id` BIGINT COMMENT 'FK to donor constituent',
    `cost_center_id` BIGINT COMMENT 'FK to cost center [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `exchange_rate_id` BIGINT COMMENT 'Fund currency',
    `nicra_rate_id` BIGINT COMMENT 'FK to NICRA rate',
    `funding_source_id` BIGINT COMMENT 'FK to funding source',
    `parent_fund_finance_fund_id` BIGINT COMMENT 'Self-ref to parent fund',
    `allowable_cost_categories` DECIMAL(18,2) COMMENT 'Allowable cost categories [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `audit_required_flag` BOOLEAN COMMENT 'Whether audit required',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget amount [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `chart_of_accounts_segment` STRING COMMENT 'COA segment',
    `closed_timestamp` TIMESTAMP COMMENT 'Fund closed timestamp',
    `committed_amount` DECIMAL(18,2) COMMENT 'Committed amount [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the compliance condition applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this finance fund.',
    `current_balance` DECIMAL(18,2) COMMENT 'Current balance [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `donor_reporting_frequency` STRING COMMENT 'Attribute capturing the donor reporting frequency information for the finance fund entity.',
    `effective_end_date` DATE COMMENT 'Date and time when the effective end event occurred for this finance fund.',
    `effective_start_date` DATE COMMENT 'Date and time when the effective start event occurred for this finance fund.',
    `expended_amount` DECIMAL(18,2) COMMENT 'Expended amount [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `fiscal_period` STRING COMMENT 'Attribute capturing the fiscal period information for the finance fund entity.',
    `fiscal_year` STRING COMMENT 'Attribute capturing the fiscal year information for the finance fund entity.',
    `fund_code` STRING COMMENT 'Standardized code representing the fund classification or category.',
    `fund_name` STRING COMMENT 'Human-readable name or label for the fund.',
    `fund_status` STRING COMMENT 'Current status indicator for the fund workflow state.',
    `fund_type` STRING COMMENT 'Classification type categorizing the fund for this record.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Indirect cost rate [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `last_audit_date` DATE COMMENT 'Date and time when the last audit event occurred for this finance fund.',
    `last_report_date` DATE COMMENT 'Date and time when the last report event occurred for this finance fund.',
    `manager_name` STRING COMMENT 'Fund manager name',
    `match_fulfilled_amount` DECIMAL(18,2) COMMENT 'Match fulfilled amount [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `match_requirement_percentage` DECIMAL(18,2) COMMENT 'Attribute capturing the match requirement percentage information for the finance fund entity.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this finance fund.',
    `next_audit_date` DATE COMMENT 'Date and time when the next audit event occurred for this finance fund.',
    `next_report_due_date` DATE COMMENT 'Date and time when the next report due event occurred for this finance fund.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the finance fund entity.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Opening balance [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `program_code` STRING COMMENT 'Standardized code representing the program classification or category.',
    `purpose` STRING COMMENT 'Fund purpose',
    `restriction_type` STRING COMMENT 'Restriction type (IPSAS: with/without donor restrictions; US GAAP ASC 958)',
    `unallowable_cost_categories` DECIMAL(18,2) COMMENT 'Unallowable cost categories [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    CONSTRAINT pk_finance_fund PRIMARY KEY(`finance_fund_id`)
) COMMENT 'Financial fund entity tracking restricted and unrestricted funds per IPSAS/US GAAP ASC 958. Source: SAP, SunSystems, or equivalent ERP fund module. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP/S4HANA (VISION Fund Master), eZHACT. Accounting framework: IPSAS 23 (Revenue from Non-Exchange Transactions) / US GAAP ASC 958-605 (Revenue Recognition for Not-for-Profit Entities) / IFRS as applicable.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key for the cost center master record. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Cost centers (programs/field offices) have specific compliance obligations (CHS commitments, sphere standards, donor-specific requirements). Program managers track obligations by cost center for opera',
    `country_id` BIGINT COMMENT 'ISO 3166-1 alpha-3 country code indicating the primary geographic location of this cost center. Used for country office cost centers, field operations, and regional program management. Nullable for headquarters or global cost centers.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in the organizational hierarchy. Enables roll-up reporting from field offices to regional hubs to headquarters. Nullable for top-level cost centers. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `user_account_id` BIGINT COMMENT 'Reference to the user who created this cost center record. Used for accountability and audit purposes. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who is accountable for budget performance, expense approval, and financial stewardship of this cost center. Used in RACI (Responsible Accountable Consulted Informed) matrices and budget versus actual (BvA) reporting.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Cost centers track IT platform-specific expenses (ERP licenses, grants management subscriptions) for budget allocation and indirect cost recovery. Required for platform cost reports in NICRA calculati',
    `tertiary_cost_approved_by_user_user_account_id` BIGINT COMMENT 'Reference to the user who approved this cost center for activation. Typically a finance director, controller, or Chief Financial Officer (CFO). Nullable for cost centers not yet approved. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `activity_type` STRING COMMENT 'The primary activity or service provided by this cost center (e.g., beneficiary registration, field assessment, grant management, financial reporting, volunteer coordination). Used for activity-based costing and internal service billing.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount for this cost center for the current fiscal year. Used in Budget versus Actual (BvA) variance analysis and financial stewardship reporting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `approval_status` STRING COMMENT 'Workflow approval status for new or modified cost centers. Draft cost centers are under construction; pending approval cost centers await finance or executive review; approved cost centers are active; rejected cost centers require revision.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center was approved for activation. Used for audit trail and compliance reporting. Nullable for cost centers not yet approved.',
    `budget_currency_code` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for the cost centers budget and financial reporting. Used for multi-currency organizations with country offices operating in local currencies. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `cost_center_category` STRING COMMENT 'SAP S/4HANA cost center category classification. Production cost centers deliver direct program services; service cost centers provide internal support; administrative cost centers manage overhead; auxiliary cost centers support shared services; project cost centers are time-bound; temporary cost centers are short-term or pilot initiatives. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `production|service|administrative|auxiliary|project|temporary`',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center was permanently closed and all balances were transferred or reconciled. Used for grant closeout, project completion, and organizational restructuring. Nullable for active cost centers.',
    `cost_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the cost center in SAP S/4HANA and Unit4 ERP. Used in general ledger posting, budget tracking, and financial reporting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `^[A-Z0-9]{4,12}$`',
    `company_code` STRING COMMENT 'The SAP S/4HANA or Unit4 ERP company code representing the legal entity to which this cost center belongs. Used for multi-entity consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The SAP S/4HANA controlling area (CO module) to which this cost center is assigned. Controlling areas represent organizational units for internal cost accounting and management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The methodology used to allocate shared or indirect costs to this cost center. Direct allocation assigns costs explicitly; proportional uses a percentage driver; headcount allocates by staff count; square footage uses physical space; activity-based costing (ABC) uses cost drivers; not allocated for cost centers that do not receive shared cost allocations. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `direct|proportional|headcount|square_footage|activity_based|not_allocated`',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active cost centers accept expense postings; inactive cost centers are temporarily disabled; suspended cost centers are under review; closed cost centers are permanently retired; pending activation cost centers are awaiting approval. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `active|inactive|suspended|closed|pending_activation`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by functional expense category per GAAP for nonprofits. Program cost centers support direct mission delivery; administrative cost centers support organizational management; fundraising cost centers support donor cultivation and gift processing; general and administrative (G&A) support overall operations; mission support provides enabling services; field operations manage country office and site-level activities. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `program|administrative|fundraising|general_and_administrative|mission_support|field_operations`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system. Used for audit trail and data lineage tracking.',
    `department` STRING COMMENT 'The functional department or division to which this cost center belongs (e.g., Health Programs, WASH, Education, Finance, Human Resources, Monitoring Evaluation and Learning). Used for cross-cutting organizational reporting.',
    `cost_center_description` STRING COMMENT 'Detailed narrative description of the cost centers purpose, scope, and responsibilities. Includes information on program activities, geographic coverage, donor restrictions, and organizational context. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `effective_end_date` DATE COMMENT 'The date on which this cost center ceases to be active. Nullable for open-ended cost centers. Used for project-specific or time-bound organizational units.',
    `effective_start_date` DATE COMMENT 'The date from which this cost center becomes active and can accept expense allocations and budget assignments.',
    `external_reference_code` STRING COMMENT 'The unique identifier for this cost center in external systems such as donor grant management systems (GMS), partner organization ERPs, or government reporting portals. Used for cross-system reconciliation and International Aid Transparency Initiative (IATI) reporting.',
    `functional_expense_classification` STRING COMMENT 'GAAP functional expense category per FASB ASC 958-720. Program services are mission-delivery activities; management and general (M&G) are administrative overhead; fundraising supports donor cultivation; membership development supports constituent engagement. Required for Form 990 and audited financial statements.. Valid values are `program_services|management_and_general|fundraising|membership_development`',
    `fund_restriction_type` STRING COMMENT 'Classification of donor-imposed restrictions on funds allocated to this cost center per FASB ASC 958-205. Unrestricted funds have no donor-imposed restrictions; temporarily restricted funds have time or purpose restrictions that will lapse; permanently restricted funds (endowments) must be maintained in perpetuity.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `hierarchy_level` STRING COMMENT 'The depth of this cost center in the organizational hierarchy tree. Level 1 represents headquarters or top-level divisions; higher numbers represent nested field offices, country offices, or project sites.',
    `indirect_cost_eligible_flag` BOOLEAN COMMENT 'Indicates whether expenses posted to this cost center are eligible for indirect cost recovery under the organizations Negotiated Indirect Cost Rate Agreement (NICRA). True for direct program cost centers; false for administrative or already-indirect cost centers. Used in Facilities and Administration (F&A) cost allocation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was most recently updated. Used for change tracking and audit trail.',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center as it appears in financial reports and organizational charts. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `nicra_base_category` STRING COMMENT 'The indirect cost base category used for calculating indirect cost recovery for this cost center per the organizations NICRA with the federal government. Modified Total Direct Costs (MTDC) is the most common base; direct salaries and wages is used for some research organizations; total direct costs includes all direct expenses. Not applicable for cost centers that do not participate in indirect cost allocation.. Valid values are `modified_total_direct_costs|direct_salaries_and_wages|total_direct_costs|other|not_applicable`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, donor conditions, compliance requirements, or historical context relevant to this cost center.',
    `profit_center` STRING COMMENT 'The profit center code for organizations using profit center accounting in SAP S/4HANA. Used for segment reporting and internal performance measurement. Nullable for nonprofits not using profit center structures.. Valid values are `^[A-Z0-9]{4,10}$`',
    `program_area` STRING COMMENT 'The thematic program area or sector this cost center supports (e.g., WASH - Water Sanitation and Hygiene, GBV - Gender-Based Violence, Health, Education, Livelihoods, Emergency Response). Used for Sustainable Development Goal (SDG) alignment and donor reporting.',
    `region` STRING COMMENT 'Geographic region for multi-country or regional cost centers. Used for regional program offices, humanitarian response hubs, and Development Assistance Committee (DAC) reporting. [ENUM-REF-CANDIDATE: africa|asia_pacific|europe|latin_america_caribbean|middle_east|north_america|global — 7 candidates stripped; promote to reference product]',
    `year_to_date_actual_amount` DECIMAL(18,2) COMMENT 'The cumulative actual expenses posted to this cost center from the start of the fiscal year to the current reporting period. Used in BvA reporting and burn rate analysis. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master record for organizational cost centers used to allocate expenses across programs, departments, country offices, and projects. Captures cost center code, name, type (program, administrative, fundraising), responsible manager, parent cost center (for hierarchy), organizational hierarchy level, associated country or region, active status, and functional expense classification per GAAP. The SSOT for organizational cost structure used in SAP S/4HANA and Unit4 ERP for cost allocation, indirect cost recovery, NICRA base calculations, and Budget vs. Actual reporting. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP S/4HANA CO module, VISION. Framework: IPSAS 18 (Segment Reporting) / US GAAP ASC 958-720 (Functional Expenses).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account. Primary key for the GL account master data.',
    `exchange_rate_id` BIGINT COMMENT 'The ISO 4217 three-letter currency code for this GL account (e.g., USD, EUR, GBP). Nonprofits operating internationally may maintain accounts in multiple currencies.',
    `account_description` STRING COMMENT 'Detailed business description of the GL account purpose, usage guidelines, and what types of transactions should be posted to this account.',
    `account_group` STRING COMMENT 'The account group or category within the Chart of Accounts structure (e.g., Current Assets, Fixed Assets, Restricted Contributions, Program Expenses).',
    `account_name` STRING COMMENT 'The human-readable descriptive name of the GL account (e.g., Cash - Operating Account, Grant Revenue - USAID, Program Salaries - WASH).',
    `account_number` STRING COMMENT 'The externally-known unique account number within the Chart of Accounts (CoA) structure. This is the business identifier used in SAP S/4HANA and Unit4 ERP for all financial transactions and reporting.. Valid values are `^[0-9]{4,10}$`',
    `account_owner` STRING COMMENT 'The name or identifier of the business owner or responsible party for this GL account (e.g., Finance Director, Program Manager, Grant Manager).',
    `account_status` STRING COMMENT 'The current lifecycle status of the GL account: active (available for posting), inactive (temporarily suspended), blocked (posting prohibited), or closed (permanently retired).. Valid values are `active|inactive|blocked|closed`',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the GL account: asset, liability, net asset (equity for nonprofits per FASB ASC 958), revenue, or expense.. Valid values are `asset|liability|net_asset|revenue|expense`',
    `budget_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to budget control and Budget versus Actual (BvA) monitoring. When true, transactions require budget availability checking before posting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `coa_structure_code` STRING COMMENT 'The Chart of Accounts structure identifier or version code. Nonprofits may maintain multiple CoA structures for different legal entities or reporting requirements.',
    `consolidation_account_number` STRING COMMENT 'The GL account number used for consolidated financial reporting across multiple legal entities or country offices. Used when the nonprofit has a multi-entity structure.',
    `cost_allocation_base_flag` BOOLEAN COMMENT 'Indicates whether this account serves as an allocation base for distributing indirect costs across programs and grants (e.g., direct salaries, total direct costs). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'The OECD Development Assistance Committee sector classification code for international development activities. Required for International Aid Transparency Initiative (IATI) reporting.',
    `donor_restricted_flag` BOOLEAN COMMENT 'Indicates whether this account tracks donor-restricted funds requiring specific usage compliance and separate reporting per donor agreements and FASB ASC 958.',
    `effective_end_date` DATE COMMENT 'The date when this GL account was closed or became inactive. Null for currently active accounts.',
    `effective_start_date` DATE COMMENT 'The date when this GL account became active and available for transaction posting in the Chart of Accounts.',
    `external_reporting_code` STRING COMMENT 'The mapping code used for external regulatory reporting (e.g., IRS Form 990 line item, IATI activity code, donor-specific reporting category).',
    `financial_statement_classification` STRING COMMENT 'The primary financial statement where this account appears: balance sheet (statement of financial position), statement of activities (income statement equivalent for nonprofits), statement of functional expenses, statement of cash flows, or off-balance-sheet.. Valid values are `balance_sheet|statement_of_activities|statement_of_functional_expenses|statement_of_cash_flows|off_balance_sheet`',
    `functional_expense_category` STRING COMMENT 'The functional expense classification required by FASB ASC 958 for expense accounts: program services, management and general (administrative), fundraising, or not applicable (for non-expense accounts). Used for Form 990 reporting and functional expense allocation.. Valid values are `program|management_general|fundraising|not_applicable`',
    `fund_restriction_class` STRING COMMENT 'The net asset restriction classification per FASB ASC 958: unrestricted (no donor restrictions), temporarily restricted (time or purpose restrictions), or permanently restricted (endowment principal). Critical for nonprofit fund accounting and donor compliance.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `grant_eligible_flag` BOOLEAN COMMENT 'Indicates whether expenses posted to this account are eligible for reimbursement under federal grants per OMB Uniform Guidance 2 CFR 200. Critical for grant financial management and cost allocation.',
    `hierarchy_level` STRING COMMENT 'The level of this account within the Chart of Accounts hierarchy (e.g., 1 for top-level summary accounts, 2 for sub-accounts, 3 for detail posting accounts).',
    `indirect_cost_pool_flag` BOOLEAN COMMENT 'Indicates whether this account is part of the indirect cost pool for Negotiated Indirect Cost Rate Agreement (NICRA) calculations and Facilities and Administration (F&A) cost allocation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was most recently updated.',
    `last_posting_date` DATE COMMENT 'The date of the most recent transaction posted to this GL account. Used for account activity monitoring and dormant account identification.',
    `natural_expense_classification` STRING COMMENT 'The natural classification of expense by type (e.g., salaries, benefits, travel, supplies, professional fees, rent, utilities). Used alongside functional classification for comprehensive expense reporting per FASB ASC 958.',
    `normal_balance_indicator` DECIMAL(18,2) COMMENT 'Indicates whether this account normally carries a debit or credit balance per double-entry accounting principles. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this GL account usage, restrictions, or compliance requirements.',
    `posting_eligible_flag` BOOLEAN COMMENT 'Indicates whether transactions can be directly posted to this account (true for detail accounts) or if it is a summary/roll-up account that only receives aggregated balances (false).',
    `program_service_code` STRING COMMENT 'The program or service line code that this account supports (e.g., WASH, Health, Education, Emergency Response). Used for program-level financial reporting and Monitoring Evaluation and Learning (MEL).',
    `reconciliation_account_flag` BOOLEAN COMMENT 'Indicates whether this account requires regular reconciliation (e.g., bank accounts, accounts receivable, accounts payable control accounts). Used for internal control and audit compliance.',
    `sdg_alignment_code` STRING COMMENT 'The United Nations Sustainable Development Goal(s) that activities posted to this account contribute toward (e.g., SDG 1 - No Poverty, SDG 6 - Clean Water and Sanitation). Used for impact reporting.',
    `tax_relevance_indicator` STRING COMMENT 'Indicates the tax treatment of transactions posted to this account: taxable income, non-taxable, tax-exempt per IRS 501(c)(3) regulations, or not applicable.. Valid values are `taxable|non_taxable|exempt|not_applicable`',
    `unrelated_business_income_flag` BOOLEAN COMMENT 'Indicates whether revenue posted to this account constitutes Unrelated Business Income (UBI) subject to taxation under IRS regulations for tax-exempt organizations.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger account in the chart of accounts. Source systems: SAP S/4HANA FI. Configurable for IPSAS (UN agencies) or US GAAP/ASC 958 (US nonprofits) or IFRS. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP S/4HANA General Ledger, VISION. Accounting framework: IPSAS 1 (Presentation of Financial Statements) / US GAAP ASC 958-210 (Balance Sheet for Not-for-Profit Entities).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry entity.',
    `award_id` BIGINT COMMENT 'Foreign key reference to the grant or award that this journal entry is financially associated with. Critical for grant-specific financial tracking, budget versus actual reporting, and donor reporting compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries are allocated to cost centers at the header level. This FK enables cost center reporting and management analysis. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Journal entries are often specific to a country office. Finance needs country-level expense tracking for management reporting, donor reporting, and HQ consolidation.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each journal entry for audit trail and accountability - fundamental accounting control requirement in nonprofit financial management.',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Distribution expenses are recorded via journal entries. Finance needs to link JEs to specific distributions for cost tracking, audit trail, and distribution cost analysis.',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code indicating the transaction currency of this journal entry (e.g., USD, EUR, GBP). Essential for multi-currency grant accounting and foreign exchange management.',
    `field_deployment_id` BIGINT COMMENT 'Foreign key linking to field.deployment. Business justification: Deployment costs are recorded via journal entries. Finance needs to link JEs to deployments for cost tracking, audit trail, and deployment cost analysis.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Journal entries are allocated to funds at the header level. This FK enables fund-level reporting and ensures compliance with donor restrictions.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Journal entries are posted to specific fiscal periods for financial reporting and period close processes. The existing fiscal_year (INT) and fiscal_period (INT) columns are denormalized representation',
    `intervention_id` BIGINT COMMENT 'Foreign key reference to the program or project that this journal entry supports. Enables program-level cost tracking, budget monitoring, and Results-Based Management (RBM) financial reporting.',
    `journal_functional_currency_code` BIGINT COMMENT 'Three-letter ISO 4217 code for the organizations functional reporting currency. All journal entries are ultimately reported in this currency for consolidated financial statements.',
    `user_account_id` BIGINT COMMENT 'User ID of the person who posted this journal entry to the general ledger. Critical for audit trail, segregation of duties monitoring, and accountability.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Many journal entries relate to specific field sites (site operating costs, site setup costs). Finance needs to track expenses by site for management reporting and site cost analysis.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Journal entries support regulatory filings (Form 990 financial statements, single audit schedules). Auditors and preparers trace filing amounts back to specific GL entries for substantiation and audit',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Journal entries originate from specific platforms (accounting system, grants management, payroll). Audit trail requirement: every GL posting must be traceable to source system for financial audits and',
    `tertiary_journal_created_by_user_user_account_id` BIGINT COMMENT 'User ID of the person who originally created this journal entry document. May differ from posting_user_id if entry creation and posting are performed by different individuals.',
    `wash_intervention_id` BIGINT COMMENT 'Foreign key linking to field.wash_intervention. Business justification: WASH intervention expenses are recorded via journal entries. Finance needs to link JEs to interventions for cost tracking and intervention cost analysis.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry was approved for posting. Null if not yet approved. Part of the audit trail for approval workflow compliance.',
    `audit_trail_notes` STRING COMMENT 'Additional free-text notes or comments added for audit trail purposes, explaining unusual circumstances, supporting documentation references, or special handling instructions.',
    `batch_number` STRING COMMENT 'Batch identifier grouping multiple journal entries that were posted together as a single batch. Used for batch-level approval workflows and mass reversal operations.',
    `company_code` STRING COMMENT 'Legal entity or company code within the ERP system to which this journal entry belongs. Essential for multi-entity nonprofit organizations with separate legal entities or country offices.',
    `compliance_flag` BOOLEAN COMMENT 'Compliance status flag indicating whether this journal entry has been reviewed for regulatory compliance (OMB Uniform Guidance, FASB ASC 958, donor restrictions). Used for compliance monitoring and audit preparation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry record was first created in the system. Foundational audit timestamp for record lifecycle tracking.',
    `document_date` DATE COMMENT 'The date the journal entry document was created or originated, which may differ from the posting date. Used for audit trail and document sequencing.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned to this journal entry in the ERP system (SAP S/4HANA or Unit4). Used for audit trails and cross-system reconciliation.',
    `document_type` STRING COMMENT 'Classification of the journal entry document type indicating the nature of the posting: original entry, reversal of prior entry, accrual for period-end, cost allocation, reclassification between accounts, or manual adjustment.. Valid values are `original|reversal|accrual|allocation|reclassification|adjustment`',
    `entry_description` STRING COMMENT 'Detailed narrative description of the business purpose and nature of this journal entry. Provides context for financial reviewers, auditors, and future reference.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency amounts to the organizations functional currency (typically USD). Null for entries in functional currency. Critical for multi-currency grant financial management.',
    `functional_area` STRING COMMENT 'Functional area classification (e.g., program services, management and general, fundraising) required for nonprofit functional expense reporting per FASB ASC 958. Supports Form 990 and donor reporting.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The Negotiated Indirect Cost Rate Agreement (NICRA) rate applied to this journal entry for facilities and administration (F&A) cost allocation. Expressed as a decimal (e.g., 0.1500 for 15%). Critical for federal grant compliance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `is_adjustment` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a manual adjustment or correction entry (as opposed to a system-generated or routine operational entry). True for adjustments; false for standard entries.',
    `is_inter_company` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an inter-company or inter-entity transaction requiring elimination in consolidated financial statements. True for inter-company entries; false otherwise.',
    `ledger_group` STRING COMMENT 'Ledger group or ledger type identifier (e.g., leading ledger, extension ledger, parallel accounting ledger) used in systems supporting multiple parallel accounting views. Supports GAAP and IFRS parallel reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry was last modified. Null if never modified. Critical for audit trail and change history tracking.',
    `posting_date` DATE COMMENT 'The business date on which this journal entry was posted to the general ledger. This is the effective date for financial reporting and determines which fiscal period the entry impacts.',
    `posting_key` STRING COMMENT 'System-specific posting key code (from SAP or Unit4) that determines the account type (debit/credit) and controls which fields are required during entry. Technical control field for ERP posting logic.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry in the approval and posting workflow. Tracks progression from draft creation through approval to final posting in the general ledger.. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `reference_document_number` STRING COMMENT 'External reference number linking this journal entry to source documents such as invoices, payment vouchers, grant agreements, or other originating transactions. Supports audit trail and source document traceability.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a previously posted entry. True if this entry reverses another entry; false otherwise.',
    `reversal_reason` STRING COMMENT 'Free-text explanation of why this journal entry was reversed. Required for audit compliance and internal control documentation when reversal_indicator is true.',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is true. Maintains bidirectional audit trail for reversals.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry. Source systems: SAP S/4HANA FI, SUN Systems, Integra. Frameworks: IPSAS (UN), US GAAP/ASC 958 (US INGOs), IFRS. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP S/4HANA FI module, VISION. Accounting framework: IPSAS 1/2/3 / US GAAP ASC 958. Form 990 Part IX mapping where applicable for US-registered entities.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for the journal entry line product.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that this line item is charged to. Enables grant financial management and compliance reporting per OMB Uniform Guidance 2 CFR 200.',
    `budget_line_id` BIGINT COMMENT 'Reference to the budget line item against which this actual expenditure or revenue is tracked. Enables Budget versus Actual (BvA) variance analysis. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry lines are allocated to cost centers for expense tracking and management reporting. This FK enables joining to get cost center hierarchy, manager, and program area. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code representing the functional currency in which the debit and credit amounts are denominated.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Journal entry lines are allocated to funds for fund accounting and donor restriction tracking. This FK enables joining to get fund type, restriction type, and donor information.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Every journal entry line posts to a GL account. This is the core relationship for the general ledger. The FK enables joining to get account type, financial statement classification, and CoA hierarchy.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header that contains this line item. Links the line to its transaction header.',
    `original_line_journal_entry_line_id` BIGINT COMMENT 'Reference to the original journal entry line ID that this line reverses or corrects. Null if this is not a reversal. Supports audit trail and error correction tracking.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with this line item for accounts payable transactions. Supports vendor payment tracking and procurement compliance.',
    `allowable_cost_flag` BOOLEAN COMMENT 'Boolean indicator of whether this cost is allowable under the applicable grant or award terms per OMB Uniform Guidance. Used for grant financial compliance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `approval_status` STRING COMMENT 'The approval status of this journal entry line within the financial workflow. Tracks whether the line has been reviewed, approved, and posted to the GL.. Valid values are `pending|approved|rejected|posted`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line was approved. Supports audit trails and compliance reporting.',
    `approved_by` STRING COMMENT 'The user ID or name of the person who approved this journal entry line. Supports internal controls and audit trails per OMB Uniform Guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line record was first created in the system. Supports audit trails and data lineage.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The credit amount for this journal entry line in the functional currency. Null or zero if this is a debit line. Used for double-entry bookkeeping per GAAP. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `debit_amount` DECIMAL(18,2) COMMENT 'The debit amount for this journal entry line in the functional currency. Null or zero if this is a credit line. Used for double-entry bookkeeping per GAAP. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `direct_cost_flag` BOOLEAN COMMENT 'Boolean indicator of whether this line item represents a direct cost (true) or an indirect/overhead cost (false). Used for cost allocation and grant compliance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `donor_restriction_type` STRING COMMENT 'Classification of donor restrictions on the funds used in this line item per FASB ASC 958: unrestricted, temporarily restricted (time or purpose), or permanently restricted (endowment).. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `effective_date` DATE COMMENT 'The effective date of the transaction represented by this line item. May differ from posting date for accruals, deferrals, and period adjustments.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this line belongs. Used for monthly and quarterly financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this journal entry line belongs. Used for annual financial reporting and multi-year analysis.',
    `functional_expense_category` STRING COMMENT 'Classification of the expense by functional category as required by FASB ASC 958: program services, management and general, or fundraising. Used for Form 990 and donor reporting.. Valid values are `program_services|management_and_general|fundraising`',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The Negotiated Indirect Cost Rate Agreement (NICRA) rate applied to this line item for Facilities and Administration (F&A) cost allocation per OMB Uniform Guidance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `intercompany_flag` BOOLEAN COMMENT 'Boolean indicator of whether this line item represents an intercompany or inter-entity transaction between organizational units or affiliated entities.',
    `invoice_number` STRING COMMENT 'The vendor invoice number or internal invoice reference associated with this line item. Used for accounts payable reconciliation and audit trails.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `line_description` STRING COMMENT 'Narrative description of the journal entry line item. Provides context and explanation for the transaction, supporting audit trails and financial transparency.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry, used for ordering and referencing individual line items within the parent entry.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this journal entry line. Supports audit trails and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line record was last modified. Supports audit trails and change tracking.',
    `natural_account_classification` STRING COMMENT 'The natural classification of the expense by type of expenditure (e.g., salaries, benefits, travel, supplies). Complements functional expense reporting per FASB ASC 958. [ENUM-REF-CANDIDATE: salary|benefits|travel|supplies|equipment|occupancy|professional_services — 7 candidates stripped; promote to reference product]',
    `payment_reference` DECIMAL(18,2) COMMENT 'The payment reference or check number associated with this line item for accounts payable or accounts receivable transactions. Supports cash reconciliation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `posting_date` DATE COMMENT 'The date on which this journal entry line was posted to the general ledger. Used for period-end closing and financial reporting cutoff.',
    `profit_center_code` STRING COMMENT 'The profit center or revenue-generating unit associated with this line item. Used for revenue attribution and financial performance analysis by business unit.. Valid values are `^[A-Z0-9]{2,10}$`',
    `program_code` STRING COMMENT 'The program or project code to which this line item is allocated. Supports program-level financial tracking and Results-Based Management (RBM) reporting.. Valid values are `^[A-Z0-9]{2,15}$`',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this line item is a reversal or correction of a previous journal entry line. Used for audit trails and error correction tracking.',
    `source_document_reference` STRING COMMENT 'Reference to the source document or transaction that generated this journal entry line (e.g., invoice ID, payroll batch ID, grant disbursement ID). Supports audit trails.',
    `source_system_code` STRING COMMENT 'Identifier of the source system or module from which this journal entry line originated (e.g., AP, AR, Payroll, Grant Management). Supports data lineage and reconciliation.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `tax_code` STRING COMMENT 'Tax code or VAT code applicable to this line item. Used for tax compliance, reporting, and recovery in jurisdictions where the nonprofit operates.. Valid values are `^[A-Z0-9]{1,10}$`',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this journal entry line. Supports audit trails and data lineage.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line item within a GL journal entry. Captures line number, GL account, cost center, fund, grant reference, program code, debit or credit amount, functional expense category, natural account classification, tax code, profit center, and narrative description. Enables granular fund accounting, cost allocation, and grant financial reporting at the transaction line level per FASB ASC 958 and OMB Uniform Guidance. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Accounting framework: IPSAS 1 / US GAAP ASC 958-220. Each line maps to a cost center and fund per IPSAS segment reporting or ASC 958 functional expense classification.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Budgets must include costs for compliance obligations (audit fees, external review costs, certification expenses). Budget planning requires identifying applicable obligations to ensure adequate fundin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgets are allocated to cost centers for budget vs. actual tracking. This FK enables joining to get cost center hierarchy, manager, and program area. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Country office budgets are standard. Finance needs to track budgets by country office for country-level financial management and HQ consolidation.',
    `constituent_id` BIGINT COMMENT 'Foreign key reference to the donor or funding organization that provided the resources for this budget. Essential for donor-specific financial reporting and stewardship.',
    `donor_fund_id` BIGINT COMMENT 'Foreign key reference to the fund associated with this budget. Links the budget to the fund accounting structure for restricted and unrestricted fund tracking per FASB ASC 958.',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the budget amounts (e.g., USD, EUR, GBP). Essential for multi-currency grant management and financial consolidation.',
    `nicra_rate_id` BIGINT COMMENT 'Foreign key linking to finance.nicra_rate. Business justification: Budgets reference NICRA rates for indirect cost budgeting. This FK enables joining to get the approved rate percentage and effective dates.',
    `award_id` BIGINT COMMENT 'Foreign key reference to the grant award record if this is a grant-type budget. Links the budget to the specific donor award for compliance tracking and financial reporting.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Site-level budgets are common in nonprofit operations. Finance needs to track budgets by site for site management, budget vs. actual reporting, and site planning.',
    `approval_date` DATE COMMENT 'The date when this budget was formally approved by the designated authority (e.g., Finance Director, Board of Directors, donor). Marks the transition from draft to approved status.',
    `approved_modifications_count` STRING COMMENT 'The number of formal modifications or amendments that have been approved for this budget since initial approval. Tracks budget revision history and compliance with donor prior-approval requirements.',
    `approving_authority` STRING COMMENT 'The name or title of the individual or body that approved this budget (e.g., Chief Financial Officer, Executive Director, Board of Directors, Donor Program Officer).',
    `award_ceiling_amount` DECIMAL(18,2) COMMENT 'The maximum allowable expenditure under the grant award, including all approved modifications. For grant-type budgets, this represents the donors total funding commitment and cannot be exceeded without prior approval. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_status` DECIMAL(18,2) COMMENT 'Current lifecycle state of the budget. Draft indicates initial preparation; submitted means under review; approved indicates formal authorization; revised indicates modifications post-approval; active indicates currently in use; closed indicates budget period ended; cancelled indicates budget was terminated before completion. [ENUM-REF-CANDIDATE: draft|submitted|approved|revised|active|closed|cancelled — 7 candidates stripped; promote to reference product] [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_type` DECIMAL(18,2) COMMENT 'Classification of the budget by its purpose and funding nature. Operational budgets support ongoing organizational activities; project budgets are tied to specific initiatives; grant budgets are donor-funded and compliance-driven; capital budgets fund long-term assets; restricted budgets have donor-imposed limitations; unrestricted budgets have no donor restrictions. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `burn_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total approved budget that has been expended to date. Calculated as (total_actual_expenditure / total_approved_amount) * 100. Used to monitor spending pace and forecast budget depletion.',
    `budget_code` DECIMAL(18,2) COMMENT 'Externally-known unique alphanumeric code identifying this budget in financial systems and donor reports. Used as the business identifier for budget tracking and reference. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `compliance_notes` STRING COMMENT 'Free-text field capturing special compliance requirements, donor conditions, or restrictions specific to this budget (e.g., procurement rules, allowable cost categories, geographic restrictions). Used by finance and program staff to ensure adherence to donor terms.',
    `cost_share_requirement_amount` DECIMAL(18,2) COMMENT 'The amount of cost-sharing or matching funds required by the donor as a condition of the grant. Represents the organizations commitment to contribute resources beyond the donor award. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the system. Used for audit trail and data lineage tracking.',
    `direct_cost_budget` DECIMAL(18,2) COMMENT 'The portion of the total budget allocated to direct costs that can be specifically attributed to program activities, such as salaries, supplies, and travel directly supporting the program or grant. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `donor_reporting_frequency` STRING COMMENT 'The frequency at which financial reports must be submitted to the donor for this budget. Drives the cadence of Budget vs. Actual (BvA) reporting and compliance monitoring.. Valid values are `monthly|quarterly|semi-annually|annually|upon_request`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies, represented as a four-digit year (e.g., 2024). Aligns with the organizations financial reporting calendar.. Valid values are `^[0-9]{4}$`',
    `icr_rate_applied` DECIMAL(18,2) COMMENT 'The indirect cost rate percentage applied to calculate the indirect cost budget. Expressed as a percentage (e.g., 15.00 for 15%). May be based on NICRA or donor-imposed rate caps.',
    `indirect_cost_budget` DECIMAL(18,2) COMMENT 'The portion of the total budget allocated to indirect costs (overhead, facilities, administration) that support the organization but cannot be directly attributed to a single program or grant. Calculated using the Indirect Cost Rate (ICR). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `last_modification_date` DATE COMMENT 'The date of the most recent approved modification to this budget. Used to track budget revision history and ensure compliance with donor reporting timelines.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `budget_name` DECIMAL(18,2) COMMENT 'Descriptive name of the budget, typically including program or grant reference for easy identification by finance and program staff. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `owner` STRING COMMENT 'The name or identifier of the individual responsible for managing and monitoring this budget (e.g., Program Manager, Finance Manager). Accountable for budget performance and variance management.',
    `period_end_date` DATE COMMENT 'The date when this budget period ends. For grant budgets, this aligns with the award period end date. Used to calculate burn rate and remaining budget availability.',
    `period_start_date` DATE COMMENT 'The date when this budget period begins. For grant budgets, this aligns with the award period start date. Critical for Budget vs. Actual (BvA) tracking and compliance reporting.',
    `prior_approval_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which budget modifications or reallocations require prior written approval from the donor. Varies by donor and grant terms (e.g., USAID, DFID, UN agencies). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `program_code` STRING COMMENT 'The program or project code associated with this budget. Links the budget to specific programmatic activities for Monitoring, Evaluation, and Learning (MEL) and Results-Based Management (RBM) reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `total_actual_expenditure` DECIMAL(18,2) COMMENT 'The cumulative actual expenditure recorded against this budget to date. Used in Budget vs. Actual (BvA) variance analysis and burn rate calculations. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `total_approved_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount for this budget period, including both direct and indirect costs. Represents the authorized spending ceiling. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `total_variance_amount` DECIMAL(18,2) COMMENT 'The difference between the total approved budget amount and the total actual expenditure. Positive variance indicates under-spending; negative variance indicates over-spending. Key metric for Budget vs. Actual (BvA) reporting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Organizational or programme budget. Source systems: SAP BPC/BW, SAP FM, Adaptive Planning. Supports IPSAS and US GAAP budget frameworks. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP BPC/S4HANA Budget module, eZHACT. Framework: IPSAS 24 (Presentation of Budget Information) / US GAAP voluntary budget-to-actual disclosure.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `award_id` BIGINT COMMENT 'Reference to the grant award this budget line belongs to. Links budget line to the parent grant award for financial tracking and compliance.',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget document or budget version that contains this line item. Enables tracking of budget revisions and amendments. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers for expense tracking and reporting. The cost_center_code string should be replaced with a proper FK to cost_center. This enables joining to get cost center h [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Budget lines must map to specific donor compliance requirements (allowable cost categories, cost-sharing mandates, prior approval thresholds). Grant managers verify budget line compliance against dono',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for budget amounts. Essential for multi-currency grant management and financial consolidation.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Budget lines are allocated to specific funds (restricted or unrestricted). The fund_code string should be replaced with FK to finance_fund to enable joining for fund restriction type, donor, and balan',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Budget lines can be site-specific (site operating budget, site setup budget). Finance needs site-level budget detail for planning, tracking, and site cost management.',
    `activity_code` STRING COMMENT 'Specific program activity or intervention this budget line funds. Supports Logical Framework (LogFrame) and Theory of Change (ToC) budget alignment.. Valid values are `^[A-Z0-9]{2,20}$`',
    `allocation_method` STRING COMMENT 'Method used to allocate shared or indirect costs to this budget line. Ensures transparent and auditable cost allocation per OMB Uniform Guidance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `direct|fte|square_footage|headcount|usage|other`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total cost allocated to this budget line when using proportional allocation methods. Expressed as a decimal (e.g., 0.2500 for 25%). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `approval_date` DATE COMMENT 'Date when this budget line was formally approved by the authorized budget authority or donor. Establishes the baseline for BvA tracking.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who approved this budget line. Supports audit trail and accountability.',
    `budget_line_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the budget line. Tracks approval workflow and budget lock-down for financial control. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_narrative` DECIMAL(18,2) COMMENT 'Detailed justification and description of the budget line item. Explains the purpose, calculation basis, and alignment with program activities. Required for donor budget submissions. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_period_type` DECIMAL(18,2) COMMENT 'Granularity of the budget period for this line item. Determines reporting frequency and BvA tracking intervals. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `cost_share_source` STRING COMMENT 'Source of cost-sharing contribution for this budget line. Distinguishes between organizational funds, third-party contributions, in-kind, or cash match. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `organizational|third_party|in_kind|cash`',
    `cost_type` STRING COMMENT 'Classification of cost as direct (attributable to a single program), indirect (Facilities and Administration / F&A), or shared (allocated across multiple programs). Critical for NICRA compliance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `direct|indirect|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was first created in the system. Supports audit trail and data lineage.',
    `donor_budget_category` DECIMAL(18,2) COMMENT 'Donor-specific budget category or line item code as required by the funding source. Maps internal budget structure to donor reporting templates. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `expense_category` STRING COMMENT 'High-level classification of the budget line expenditure type. Aligns with OMB Uniform Guidance cost categories and donor budget templates. [ENUM-REF-CANDIDATE: personnel|travel|equipment|supplies|contractual|other_direct|indirect — 7 candidates stripped; promote to reference product]',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Negotiated Indirect Cost Rate Agreement (NICRA) percentage applied to this budget line if it is an indirect cost. Expressed as a decimal (e.g., 0.1500 for 15%). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `is_allowable` BOOLEAN COMMENT 'Indicates whether this budget line represents an allowable cost under the grant terms and OMB Uniform Guidance. Used for compliance validation.',
    `is_cost_share` BOOLEAN COMMENT 'Indicates whether this budget line represents a cost-sharing or matching contribution required by the donor. Critical for grant compliance tracking. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `line_number` STRING COMMENT 'Sequential or hierarchical line number within the budget document. Used for ordering and referencing specific budget lines in donor reports and financial statements.. Valid values are `^[A-Z0-9]{1,20}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was last modified. Tracks data currency and change history.',
    `notes` STRING COMMENT 'Additional comments, assumptions, or clarifications related to this budget line. Provides supplementary context for budget reviewers and auditors.',
    `original_amount` DECIMAL(18,2) COMMENT 'Initial planned expenditure or revenue amount for this budget line as approved in the original budget submission. Baseline for tracking budget changes. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `program_code` STRING COMMENT 'Program or project code this budget line supports. Enables program-level budget tracking and Results-Based Management (RBM) reporting.. Valid values are `^[A-Z0-9]{2,20}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units planned for this budget line. Used in conjunction with unit cost to calculate total budget amount.',
    `revised_amount` DECIMAL(18,2) COMMENT 'Current approved budget amount after amendments, reallocations, or donor-approved modifications. Used for current-period BvA tracking. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `revision_number` STRING COMMENT 'Sequential version number tracking amendments and modifications to this budget line. Enables budget change history and audit compliance.',
    `revision_reason` STRING COMMENT 'Explanation for the most recent revision to this budget line. Documents the business justification for budget amendments.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit for this budget line. Multiplied by quantity to derive the total budget amount. Supports transparent budget calculation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `unit_description` STRING COMMENT 'Description of the unit of measure for this budget line (e.g., staff month, trip, item, training session). Provides context for quantity-based budget calculations.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line item within an approved budget, representing the planned expenditure or revenue for a specific GL account, cost center, fund, program activity, or period. Captures budget line number, GL account, cost center, fund, program code, budget period (monthly, quarterly, annual), planned amount, revised amount, budget narrative, and expense category. Enables granular BvA tracking, grant financial management, and donor budget reporting at the line level. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`payable` (
    `payable_id` BIGINT COMMENT 'Primary key for payable',
    `award_id` BIGINT COMMENT 'Reference to the grant or award against which this payable is charged. Critical for restricted fund tracking and grant financial management.',
    `bank_account_id` BIGINT COMMENT 'Reference to the organizations bank account from which payment was disbursed. Used for cash management and bank reconciliation.',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for this expenditure. Used for budget control and cost allocation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Payables are processed at country office level. Finance needs to track payables by country office for country-level AP management and cash flow planning.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each payable invoice for accountability and audit trail in accounts payable processing.',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Vendor invoices for distribution supplies/services link to specific distributions. Finance needs this for distribution cost tracking, audit trail, and distribution cost analysis.',
    `donor_fund_id` BIGINT COMMENT 'Reference to the fund (restricted, unrestricted, temporarily restricted, permanently restricted) to which this payable is allocated. Essential for nonprofit fund accounting.',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). Required for multi-currency operations and exchange rate tracking.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Payables are posted to fiscal periods for accounts payable aging, accrual accounting, and financial statement preparation. The existing fiscal_year (INT) and fiscal_period (INT) columns are denormaliz',
    `gl_account_id` BIGINT COMMENT 'Reference to the general ledger account code in the Chart of Accounts (CoA) where this payable expense is recorded.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document confirming delivery of goods or services. Used in three-way match process. Null if goods receipt not applicable. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_run_id` BIGINT COMMENT 'Identifier for the batch payment run in which this invoice was processed. Used for grouping payments and treasury operations. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Vendor invoices often relate to specific sites (site supplies, site services). Finance needs to track payables by site for site cost management and budget tracking.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order for three-way match validation (PO, goods receipt, invoice). Null for non-PO invoices.',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Vendor payments require sanctions screening before disbursement per OFAC/UN sanctions compliance. Treasury operations link each payable to screening result to document compliance and prevent prohibite',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Vendor invoices for software licenses, cloud services, and support contracts must be tracked by platform for cost allocation, grant charging, and platform cost reports used in indirect cost rate calcu',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom goods or services were procured. Links to the vendor master data.',
    `approval_status` STRING COMMENT 'Current approval workflow status. Invoices must be approved before payment per internal controls and segregation of duties requirements.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the invoice for payment. Required for audit trail and accountability per OMB Uniform Guidance.',
    `approved_date` DATE COMMENT 'Date the invoice was approved for payment. Used for workflow tracking and compliance reporting. Format: yyyy-MM-dd.',
    `clearing_document_number` STRING COMMENT 'SAP clearing document number that closes the open payable item in the general ledger. Links invoice posting to payment posting for account reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payable invoice record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount or negotiated discount amount applied to the invoice. Reduces the net payable amount. In invoice currency. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `dispute_date` DATE COMMENT 'Date the invoice was flagged as disputed. Used for vendor relationship management and dispute resolution tracking. Format: yyyy-MM-dd.',
    `dispute_reason` STRING COMMENT 'Reason code or description if the invoice is disputed (e.g., pricing discrepancy, quantity mismatch, quality issue). Null if not disputed.',
    `due_date` DATE COMMENT 'Date by which payment is due per the payment terms. Used for cash flow planning and to avoid late payment penalties. Format: yyyy-MM-dd.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert invoice currency to the organizations functional currency (typically USD for US-based nonprofits). Rate at invoice date or payment date per accounting policy.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Invoice net amount converted to the organizations functional currency using the exchange rate. Used for general ledger posting and financial reporting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Negotiated Indirect Cost Rate Agreement (NICRA) rate applied to this expenditure for Facilities and Administration (F&A) cost allocation. Critical for federal grant compliance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice. Used to calculate payment terms and aging. Format: yyyy-MM-dd.',
    `invoice_description` STRING COMMENT 'Free-text description of the goods or services covered by this invoice. Provides business context for the expenditure.',
    `invoice_gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes and adjustments. Base amount for goods or services procured, in invoice currency. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `invoice_net_amount` DECIMAL(18,2) COMMENT 'Net payable amount after applying taxes, withholding tax, and discounts. This is the amount to be paid to the vendor. In invoice currency. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `invoice_number` STRING COMMENT 'Vendor-provided invoice number. Business identifier for the payable transaction. Must be unique per vendor for audit trail and reconciliation.',
    `invoice_received_date` DATE COMMENT 'Date the invoice was received by the organization. Used for processing time tracking and internal controls. Format: yyyy-MM-dd.',
    `is_grant_eligible` BOOLEAN COMMENT 'Flag indicating whether this expenditure is allowable and allocable to the associated grant per OMB Uniform Guidance cost principles. True if eligible, False if not.',
    `is_restricted_fund` BOOLEAN COMMENT 'Flag indicating whether this payable is charged to a restricted fund with donor-imposed limitations. True if restricted, False if unrestricted. Critical for FASB ASC 958 compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payable invoice record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `payment_date` DATE COMMENT 'Actual date the payment was disbursed to the vendor. Null if payment has not yet been made. Format: yyyy-MM-dd. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_document_number` DECIMAL(18,2) COMMENT 'System-generated payment document number or check number. Links the payable to the actual payment transaction for reconciliation and audit. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_method` DECIMAL(18,2) COMMENT 'Method used to disburse payment to the vendor. Critical for cash management, bank reconciliation, and audit trail documentation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the payable invoice in the procure-to-pay process. Tracks progression from invoice receipt through payment disbursement. [ENUM-REF-CANDIDATE: open|scheduled|partially_paid|paid|disputed|cancelled|on_hold — 7 candidates stripped; promote to reference product] [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_terms` DECIMAL(18,2) COMMENT 'Contractual payment terms agreed with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Determines due date calculation and early payment discount eligibility. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice (VAT, sales tax, GST, etc.). In invoice currency. Used for tax reporting and compliance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation comparing purchase order, goods receipt, and invoice. Matched status is required for automated payment approval per internal controls.. Valid values are `matched|unmatched|partially_matched|not_applicable|override`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld at source per local tax regulations. Reduces the net payment to vendor. In invoice currency. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    CONSTRAINT pk_payable PRIMARY KEY(`payable_id`)
) COMMENT 'Unified Accounts Payable (AP) record in SAP S/4HANA managing the full procure-to-pay lifecycle from invoice receipt through payment disbursement. Captures invoice number, vendor reference, invoice date, due date, payment terms, invoice currency, total amount, tax amount, withholding tax, three-way match status (PO, goods receipt, invoice), payment status (open, partially paid, paid, disputed, cancelled), payment date, payment method (wire transfer, check, ACH, mobile money), payment document number, bank account, clearing document reference, payment run ID, exchange rate, cost center, fund, and grant reference. Supports procurement-to-pay cycle, grant expenditure documentation, cash management, and financial audit compliance per OMB Uniform Guidance. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP FI-AP, VISION. Framework: IPSAS 19 (Provisions, Contingent Liabilities) / US GAAP ASC 958.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`payable_payment` (
    `payable_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment transaction. Primary key for the payable payment record. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `award_id` BIGINT COMMENT 'Identifier of the grant or award that is funding this payment. Links to the grant master data for grant expenditure tracking and donor reporting compliance.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the organizational bank account from which the payment is disbursed. Links to the bank account master data for cash management and reconciliation.',
    `bank_transaction_id` BIGINT COMMENT 'The unique transaction identifier assigned by the bank for this payment. Used for bank reconciliation and dispute resolution.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payments are allocated to cost centers for expense tracking. This FK enables joining to get cost center details and hierarchy for management reporting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `country_id` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the payment was made or the vendor is located. Used for geographic reporting and compliance with country-specific regulations.',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 code for the organizational functional or reporting currency (e.g., USD for US-based NGOs). Used for financial consolidation and donor reporting.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Payments are allocated to funds for fund accounting and donor restriction compliance. This FK enables joining to get fund restriction type and donor information.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Payments post to GL accounts for financial reporting. This FK enables joining to get account classification and financial statement mapping.',
    `payable_id` BIGINT COMMENT 'Foreign key linking to finance.payable. Business justification: Payments apply to payable invoices. This FK enables joining to get the invoice details, vendor, purchase order, and three-way match status.',
    `payment_run_id` BIGINT COMMENT 'Foreign key linking to finance.payment_run. Business justification: Payable payments are executed as part of payment runs (batch payment processing). The existing payment_run_code (STRING) column is a denormalized representation that should be replaced with a proper F [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor, partner, or service provider receiving the payment. Links to the vendor master data in the procurement or partner management system.',
    `activity_code` STRING COMMENT 'The specific activity or sub-project code within the program that this payment funds. Supports detailed grant budget tracking and Results-Based Management (RBM).',
    `approval_date` DATE COMMENT 'The date on which the payment was approved by the authorized signatory or approval workflow. Part of the internal control and audit trail.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved the payment. Used for segregation of duties and audit compliance.',
    `clearing_date` DATE COMMENT 'The date on which the payment cleared the bank and the funds were successfully transferred to the vendor. Used for cash reconciliation and liquidity management.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing transaction that links this payment to the original invoice or payable document in the accounts payable ledger. Used for reconciliation and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was first created in the ERP system. Part of the audit trail for financial transactions.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The amount of early payment discount or other reduction applied to the payment. Used for cash management optimization and vendor relationship management. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `due_date` DATE COMMENT 'The date by which the payment is due to the vendor according to the payment terms. Used for cash flow forecasting and avoiding late payment penalties.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment amount to the organizational reporting currency. Used for multi-currency grant financial management and consolidation.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the organizational functional currency using the exchange rate. Used for consolidated financial reporting and budget versus actual analysis. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `is_grant_funded` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is funded by a specific grant or donor award. Used for grant expenditure tracking and donor reporting.',
    `is_indirect_cost` BOOLEAN COMMENT 'Boolean flag indicating whether this payment represents an indirect cost (Facilities and Administration) subject to the Negotiated Indirect Cost Rate Agreement (NICRA). Used for federal grant compliance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `is_restricted_fund` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is charged to a restricted fund (temporarily or permanently restricted). Critical for FASB ASC 958 net asset classification.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was last modified or updated. Used for change tracking and audit compliance.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount disbursed to the vendor after applying discounts, withholding taxes, and other adjustments. This is the actual cash outflow. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the payment in the payment currency before any adjustments or deductions. This is the principal monetary value of the disbursement. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (e.g., USD, EUR, GBP). Supports multi-currency operations in international humanitarian programs. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_date` DATE COMMENT 'The date on which the payment was executed or is scheduled to be executed. This is the business event date for cash management and grant expenditure reporting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_description` DECIMAL(18,2) COMMENT 'A detailed description of the purpose or nature of the payment. Provides context for financial reporting, audit, and grant compliance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_document_number` DECIMAL(18,2) COMMENT 'The externally-known payment document number assigned by the ERP system (SAP S/4HANA or Unit4). Used for reconciliation and audit trail purposes. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_method` DECIMAL(18,2) COMMENT 'The financial instrument or mechanism used to disburse funds to the vendor or partner (e.g., wire transfer, check, ACH, mobile money for field operations). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_reference` DECIMAL(18,2) COMMENT 'Free-text reference or memo field for additional payment details, remittance information, or special instructions. Often included in payment advice to vendors. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the payment transaction in the accounts payable workflow. Tracks progression from draft through approval to final clearing or cancellation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_process|cleared|cancelled|failed|reversed — 8 candidates stripped; promote to reference product] [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_terms` DECIMAL(18,2) COMMENT 'The agreed payment terms with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Used for cash flow planning and vendor relationship management. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_type` DECIMAL(18,2) COMMENT 'Classification of the payment by its business purpose or recipient category. Distinguishes between vendor payments, partner disbursements, grant advances, staff reimbursements, and other payment types. [ENUM-REF-CANDIDATE: vendor_payment|partner_payment|grant_advance|reimbursement|petty_cash|salary|consultant_fee — 7 candidates stripped; promote to reference product] [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `program_code` STRING COMMENT 'The program or project code that this payment supports. Used for program-level financial tracking, Monitoring Evaluation and Learning (MEL), and donor reporting.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the payment as required by local tax regulations. Common for consultant fees and international vendor payments. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    CONSTRAINT pk_payable_payment PRIMARY KEY(`payable_payment_id`)
) COMMENT 'Accounts Payable (AP) payment transaction recording the disbursement of funds to vendors, partners, or service providers from SAP S/4HANA. Captures payment document number, payment date, payment method (wire transfer, check, ACH, mobile money), bank account, payment currency, exchange rate, total payment amount, clearing document reference, fund, cost center, grant reference, and payment run ID. Supports cash management, grant expenditure reporting, and financial audit compliance. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`receivable` (
    `receivable_id` BIGINT COMMENT 'Primary key for receivable',
    `award_id` BIGINT COMMENT 'Reference to the grant or award under which this receivable was generated, enabling grant drawdown tracking and fund accounting.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor, government agency, sub-grantee, or cost-sharing partner responsible for payment of this invoice.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receivables are allocated to cost centers for revenue tracking and program reporting. This FK enables joining to get cost center hierarchy and program area. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Receivables (grant drawdowns, reimbursements) are processed at country office level. Finance needs to track receivables by country office for AR management and cash flow planning.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each receivable invoice for accountability in revenue recognition and billing processes.',
    `donor_fund_id` BIGINT COMMENT 'Reference to the restricted or unrestricted fund to which this receivable is allocated, supporting fund accounting and donor restrictions.',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code in which the invoice was issued (e.g., USD, EUR, GBP).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Receivables post to GL accounts for financial reporting. This FK enables joining to get account classification and financial statement mapping.',
    `aging_days` STRING COMMENT 'Number of days the receivable has been outstanding since the invoice date, used for aging analysis and collection prioritization.',
    `allowance_for_doubtful_accounts` DECIMAL(18,2) COMMENT 'Estimated amount of this receivable that may not be collectible, supporting the contra-asset allowance account per GAAP.',
    `bank_account_number` STRING COMMENT 'Bank account number into which the payment was deposited, supporting cash reconciliation and treasury management.',
    `billing_contact_email` STRING COMMENT 'Email address of the billing contact at the payer organization for invoice delivery and payment coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Name of the contact person at the payer organization responsible for processing and approving payment of this invoice.',
    `billing_contact_phone` STRING COMMENT 'Phone number of the billing contact at the payer organization for follow-up on payment status and dispute resolution.',
    `billing_description` STRING COMMENT 'Narrative description of the goods, services, or grant deliverables for which this invoice was issued to the payer.',
    `clearing_document_reference` STRING COMMENT 'Reference to the clearing document in SAP S/4HANA or Unit4 ERP that applied the payment to this receivable invoice.',
    `collection_status` STRING COMMENT 'Current status of the receivable in the collection lifecycle, tracking progress from issuance through final resolution.. Valid values are `open|partially_collected|collected|written_off|disputed|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this receivable invoice record was first created in the financial system, supporting audit trail and data lineage.',
    `deposit_confirmation_number` STRING COMMENT 'Bank-provided confirmation or transaction number for the deposit, enabling bank reconciliation and audit trail.',
    `dispute_flag` BOOLEAN COMMENT 'Indicator of whether the payer has disputed this invoice, triggering special handling and resolution processes.',
    `dispute_reason` STRING COMMENT 'Reason provided by the payer for disputing the invoice, supporting resolution and adjustment processes.',
    `dispute_resolution_date` DATE COMMENT 'Date on which the invoice dispute was resolved, allowing the receivable to return to normal collection status.',
    `due_date` DATE COMMENT 'Date by which payment is expected from the payer according to the agreed payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when converting the invoice currency to the organizations functional currency for accounting purposes.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Invoice amount converted to the organizations functional currency using the applicable exchange rate for general ledger posting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Total amount billed on the invoice in the invoice currency, representing the full receivable value at issuance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `invoice_date` DATE COMMENT 'Date on which the invoice was issued to the payer, marking the start of the payment terms period.',
    `invoice_delivery_method` STRING COMMENT 'Method by which the invoice was delivered to the payer (e.g., email, postal mail, electronic portal).. Valid values are `email|postal_mail|electronic_portal|fax|hand_delivery`',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice number issued to the payer for billing and payment reference purposes.',
    `invoice_sent_date` DATE COMMENT 'Date on which the invoice was sent or delivered to the payer, establishing the start of the payment terms period.',
    `last_reminder_date` DATE COMMENT 'Date on which the most recent payment reminder or collection notice was sent to the payer.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this receivable invoice record, supporting accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this receivable invoice record was last modified, supporting audit trail and change tracking.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid balance remaining on the invoice after applying all receipts, adjustments, and write-offs. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_terms` DECIMAL(18,2) COMMENT 'Contractual payment terms agreed with the payer, defining the number of days allowed for payment after invoice date. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `program_code` STRING COMMENT 'Program or project code to which this receivable is allocated, enabling program-level financial reporting and grant compliance.',
    `receipt_date` DATE COMMENT 'Date on which payment was received from the payer, marking the cash receipt event for this receivable. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `receipt_document_number` STRING COMMENT 'Internal document number or reference assigned to the cash receipt transaction in the financial system. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `receipt_method` STRING COMMENT 'Method or instrument by which payment was received from the payer (e.g., wire transfer, check, ACH, online payment). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `wire_transfer|check|ach|online_payment|credit_card|cash`',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue associated with this receivable was recognized in the general ledger per FASB ASC 958 revenue recognition principles. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as uncollectible bad debt, reducing the outstanding balance and recognized as bad debt expense. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `write_off_date` DATE COMMENT 'Date on which the receivable was written off as uncollectible, marking the removal from active accounts receivable.',
    `write_off_reason` STRING COMMENT 'Business reason or justification for writing off the receivable, supporting audit trail and financial controls.',
    CONSTRAINT pk_receivable PRIMARY KEY(`receivable_id`)
) COMMENT 'Unified Accounts Receivable (AR) record in SAP S/4HANA managing the full donor-billing-to-collection lifecycle from invoice issuance through cash receipt. Captures invoice number, payer reference (donor, government agency, sub-grantee, cost-sharing partner), invoice date, due date, payment terms, invoice currency, total amount, outstanding balance, collection status (open, partially collected, collected, written off), receipt date, receipt method (wire transfer, check, online payment), receipt document number, bank account, clearing document reference, deposit confirmation number, exchange rate, fund, grant reference, and revenue recognition date. Supports grant drawdown tracking, donor billing, revenue recognition per FASB ASC 958, and cash flow management. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP FI-AR, VISION. Framework: IPSAS 29 (Financial Instruments: Recognition and Measurement) / US GAAP ASC 310.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` (
    `receivable_receipt_id` BIGINT COMMENT 'Unique identifier for the accounts receivable cash receipt transaction. Primary key for the receivable receipt record. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `award_id` BIGINT COMMENT 'Reference to the grant award or funding agreement against which this receipt is applied. Links to the grant domain award master for restricted fund tracking.',
    `bank_account_id` BIGINT COMMENT 'Reference to the organizations bank account into which the funds were deposited. Used for cash management and bank reconciliation.',
    `constituent_id` BIGINT COMMENT 'Reference to the constituent (donor, government agency, or sub-grantee) who made the payment. Links to the donor domain constituent master.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member recorded each receipt for accountability in cash receipts and revenue recognition processes.',
    `donor_fund_id` BIGINT COMMENT 'Reference to the fund (restricted, unrestricted, temporarily restricted, or permanently restricted) to which this receipt is allocated. Critical for FASB ASC 958 net asset classification.',
    `exchange_rate_id` BIGINT COMMENT 'The three-letter ISO 4217 currency code in which the payment was received (e.g., USD, EUR, GBP). Critical for multi-currency grant management. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Receivable receipts are posted to fiscal periods for revenue recognition and cash flow reporting. The existing fiscal_year (INT) and fiscal_period (INT) columns are denormalized representations that s',
    `receivable_id` BIGINT COMMENT 'Foreign key linking to finance.receivable. Business justification: Receipts apply to receivable invoices. This FK enables joining to get the invoice details, constituent, and outstanding balance. No visible redundant column to remove.',
    `check_number` STRING COMMENT 'The check number if the receipt method is check. Used for tracking and reconciliation of paper-based payments.',
    `clearing_document_number` STRING COMMENT 'Reference to the clearing document in the financial system that links this receipt to the original accounts receivable invoice or pledge. Used for AR reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this receivable receipt record was first created in the system. Used for audit trails and data lineage.',
    `deposit_confirmation_number` STRING COMMENT 'Bank-provided confirmation or transaction reference number for the deposit. Used for bank reconciliation and audit verification.',
    `deposit_date` DATE COMMENT 'The date when funds were physically deposited into the bank account. Used for bank reconciliation and cash flow analysis.',
    `donor_restriction_purpose` STRING COMMENT 'Description of the donor-imposed restriction on the use of funds (e.g., specific program, geographic area, or time period). Critical for restricted fund compliance.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the receipt amount to the organizations functional currency (typically USD). Used for multi-currency grant accounting.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The receipt amount converted to the organizations functional currency using the exchange rate. Used for consolidated financial reporting and general ledger posting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `gl_posting_reference` STRING COMMENT 'Reference to the general ledger journal entry or posting document created for this receipt. Links AR receipt to GL for financial statement preparation.',
    `grant_drawdown_request_number` STRING COMMENT 'Reference to the grant drawdown or reimbursement request submitted to the donor or government agency. Links receipt to the originating funding request for compliance tracking.',
    `is_in_kind_conversion` BOOLEAN COMMENT 'Indicates whether this cash receipt represents the monetization or conversion of a previously recorded in-kind donation (e.g., sale of donated goods).',
    `is_matching_gift` BOOLEAN COMMENT 'Indicates whether this receipt is a matching gift from a corporate donor or foundation matching an individual donors contribution.',
    `is_refund` BOOLEAN COMMENT 'Indicates whether this receipt is a refund or return of funds previously disbursed (e.g., sub-grantee returning unused funds, vendor refund).',
    `modified_by_user` STRING COMMENT 'The username or identifier of the system user who last modified this receipt record. Used for accountability and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this receivable receipt record was last modified. Used for change tracking and audit trails.',
    `notes` STRING COMMENT 'Free-text notes or comments about the receipt, including special handling instructions, donor communications, or reconciliation issues.',
    `payer_reference` STRING COMMENT 'External reference or remittance information provided by the payer (donor, government agency, or sub-grantee) to identify the purpose of the payment.',
    `posting_date` DATE COMMENT 'The date when the receipt was posted to the general ledger. May differ from receipt_date due to batch processing or period-end adjustments.',
    `receipt_amount` DECIMAL(18,2) COMMENT 'The total amount of cash received in the receipt currency. This is the gross amount before any adjustments or allocations. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `receipt_channel` STRING COMMENT 'The interface or channel through which the payment was received (e.g., bank transfer, mail, online donor portal, mobile app, in-person at field office). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `bank_transfer|mail|online_portal|mobile_app|in_person|third_party_processor`',
    `receipt_date` DATE COMMENT 'The business date when the cash receipt was received or deposited. This is the principal business event timestamp for revenue recognition and cash flow reporting. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `receipt_document_number` STRING COMMENT 'The externally-known unique document number assigned to this cash receipt in the financial system (SAP S/4HANA or Unit4 ERP). Used for audit trails and reconciliation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `^[A-Z0-9-]{6,20}$`',
    `receipt_method` STRING COMMENT 'The payment instrument or mechanism used to remit funds (e.g., wire transfer, ACH, check, credit card, online payment platform). [ENUM-REF-CANDIDATE: wire_transfer|ach|check|credit_card|debit_card|online_payment|mobile_payment|cash — 8 candidates stripped; promote to reference product] [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the cash receipt in the accounts receivable workflow. Tracks progression from initial entry through final reconciliation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `draft|posted|cleared|reversed|voided|reconciled`',
    `reconciliation_date` DATE COMMENT 'The date when this receipt was successfully reconciled with the bank statement. Used for cash management and audit compliance.',
    `reconciliation_status` STRING COMMENT 'Status of bank reconciliation for this receipt. Tracks whether the receipt has been matched to the bank statement and any discrepancies resolved.. Valid values are `pending|reconciled|discrepancy|under_review`',
    `restriction_type` STRING COMMENT 'The net asset classification of the receipt under FASB ASC 958: unrestricted, temporarily restricted (time or purpose), or permanently restricted (endowment).. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `revenue_recognition_date` DATE COMMENT 'The date when revenue is recognized for this receipt under FASB ASC 958 revenue recognition rules. May differ from receipt_date for conditional grants or pledges. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `wire_transfer_reference` STRING COMMENT 'Bank wire transfer reference number or SWIFT message identifier for electronic fund transfers. Used for high-value grant drawdowns and major gifts.',
    CONSTRAINT pk_receivable_receipt PRIMARY KEY(`receivable_receipt_id`)
) COMMENT 'Accounts Receivable (AR) cash receipt recording the collection of funds from donors, government agencies, or sub-grantees in SAP S/4HANA. Captures receipt document number, receipt date, payer reference, receipt method (wire transfer, check, online payment), bank account, receipt currency, exchange rate, amount received, clearing document reference, fund, grant reference, and deposit confirmation number. Supports grant drawdown reconciliation, donor payment tracking, and cash flow management. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`grant_budget` (
    `grant_budget_id` BIGINT COMMENT 'Unique identifier for the grant budget record. Primary key for the grant budget entity in Unit4 ERP. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `award_id` BIGINT COMMENT 'Reference to the parent grant award for which this budget was approved. Links to the grant award master record.',
    `staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `constituent_id` BIGINT COMMENT 'Reference to the donor organization providing the grant funding. Links to the donor constituent master record.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Grant budgets are managed at country office level. Finance needs to track grant budgets by country office for country-level grant management and reporting.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Grant budgets must satisfy donor-specific compliance requirements (budget format, cost categories, indirect cost limitations). Award managers link budgets to requirements for compliance verification d',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget (e.g., USD, EUR, GBP).',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Grant budgets are allocated to funds for fund accounting. This FK enables joining to get fund restriction type, donor, and balance information.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this grant budget supports. Links to the program master record for Monitoring Evaluation and Learning (MEL) tracking.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Grant budgets can be site-specific. Finance needs to track grant budgets by site for site-level grant management, reporting, and compliance.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Grant-funded technology projects (DHIS2 implementation, mobile data collection rollout) require budget tracking by platform for donor reporting. Real business need: platform-specific budget vs. actual',
    `approved_modification_count` STRING COMMENT 'Number of approved budget modifications or amendments made since the original budget approval. Tracks budget revision history.',
    `budget_approval_date` DATE COMMENT 'Date when the grant budget was officially approved by the donor and became effective for expenditure authorization. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_category` DECIMAL(18,2) COMMENT 'Classification of the budget by funding purpose and restriction type. Aligns with FASB ASC 958 net asset classification requirements. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_closeout_date` DATE COMMENT 'Date when the grant budget was officially closed out after all financial reporting and reconciliation requirements were completed. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_code` DECIMAL(18,2) COMMENT 'Unique alphanumeric code assigned to this grant budget in Unit4 ERP for tracking and reporting purposes. Used in Chart of Accounts (CoA) mapping and General Ledger (GL) integration. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_name` DECIMAL(18,2) COMMENT 'Descriptive name of the grant budget, typically reflecting the program or project name and donor. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_narrative` DECIMAL(18,2) COMMENT 'Detailed narrative justification and explanation of the budget line items, cost assumptions, and allocation methodology submitted to the donor. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_notes` DECIMAL(18,2) COMMENT 'Additional notes, comments, or special instructions related to budget management, donor restrictions, or compliance requirements. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_period_end_date` DATE COMMENT 'End date of the budget period. Expenditures after this date may require prior approval or budget modification. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_period_start_date` DATE COMMENT 'Start date of the budget period during which approved funds may be obligated and expended. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the grant budget. Tracks progression from draft through approval to active execution and eventual closure. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|amended|closed|suspended — 7 candidates stripped; promote to reference product] [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_submission_date` DATE COMMENT 'Date when the grant budget was submitted to the donor for review and approval. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `budget_version_number` DECIMAL(18,2) COMMENT 'Version number of the budget document. Increments with each approved modification or amendment to maintain audit trail. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `compliance_framework` STRING COMMENT 'Primary regulatory or donor compliance framework governing this grant budget (e.g., OMB 2 CFR 200, USAID ADS, DFID Terms and Conditions, UN Financial Rules). [ENUM-REF-CANDIDATE: OMB_2_CFR_200|USAID_ADS|DFID_TC|UN_Financial_Rules|EU_FPA|Private_Foundation|Other — promote to reference product]',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Required cost-sharing or matching contribution amount that the organization must provide from non-grant sources to meet donor requirements. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant budget record was first created in Unit4 ERP system.',
    `direct_cost_budget` DECIMAL(18,2) COMMENT 'Approved budget amount allocated to direct costs that can be specifically attributed to the grant program activities (salaries, supplies, travel, equipment). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `donor_reference_number` STRING COMMENT 'External reference number or grant agreement number assigned by the donor organization (USAID, DFID, UN agency, private foundation).',
    `icr_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate indirect costs. Expressed as a percentage of the direct cost base (e.g., 15.00 represents 15%).',
    `indirect_cost_budget` DECIMAL(18,2) COMMENT 'Approved budget amount allocated to indirect costs (Facilities and Administration or F&A costs) that support the grant but cannot be directly attributed to specific activities. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `is_multi_year` BOOLEAN COMMENT 'Indicates whether this budget spans multiple fiscal years (True) or is contained within a single fiscal year (False).',
    `last_modification_date` DATE COMMENT 'Date of the most recent approved budget modification or amendment.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this grant budget record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant budget record was last modified in Unit4 ERP system.',
    `nicra_rate` DECIMAL(18,2) COMMENT 'Federally negotiated indirect cost rate established through a Negotiated Indirect Cost Rate Agreement (NICRA) with the cognizant federal agency. May differ from the ICR rate applied if donor caps indirect costs.',
    `total_award_amount` DECIMAL(18,2) COMMENT 'Total approved funding amount for the grant award. Represents the ceiling for all expenditures under this budget. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this grant budget record.',
    CONSTRAINT pk_grant_budget PRIMARY KEY(`grant_budget_id`)
) COMMENT 'Grant-specific budget master record in Unit4 ERP representing the approved financial plan for a single grant award. Captures grant reference, donor reference, grant budget code, total award amount, direct cost budget, indirect cost budget, ICR rate applied, NICRA rate, budget period start and end dates, budget status, approved modifications, cost-share requirement amount, and currency. Distinct from the general budget entity as it carries grant-specific compliance attributes per OMB 2 CFR 200 and donor requirements (USAID, DFID, UN). | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP Grants Management (GM), eZHACT. Framework: IPSAS 23 / US GAAP ASC 958-605 / 2 CFR 200 Subpart D.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` (
    `nicra_rate_id` BIGINT COMMENT 'Primary key for nicra_rate',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each NICRA rate for accountability in indirect cost rate management and compliance.',
    `nicra_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.nicra_agreement. Business justification: Finance nicra_rate table operationalizes rates from compliance nicra_agreement. Finance applies rates; compliance maintains agreement terms. Link ensures rate application matches negotiated agreement ',
    `administrative_rate` DECIMAL(18,2) COMMENT 'The administrative component of the Facilities and Administration (F&A) rate, if the NICRA separates facilities and administrative costs. This rate covers general administration, departmental administration, and sponsored projects administration.',
    `agreement_number` STRING COMMENT 'The official agreement number assigned by the cognizant federal agency to this Negotiated Indirect Cost Rate Agreement. This is the externally-known identifier used in grant reporting and compliance documentation.',
    `agreement_status` STRING COMMENT 'The current lifecycle status of the NICRA agreement. Draft indicates the agreement is being prepared; pending approval means it has been submitted to the cognizant agency; approved means the agency has accepted it; active means it is currently in effect; expired means the effective period has ended; superseded means a newer agreement has replaced it; terminated means it was cancelled before expiration. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|expired|superseded|terminated — 7 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'The date on which the cognizant federal agency officially approved the NICRA agreement. This may differ from the negotiation date if there was a review period.',
    `audit_period_end_date` DATE COMMENT 'The end date of the audit period on which this NICRA rate is based. For final rates, this is the period for which actual costs were audited to establish the rate.',
    `audit_period_start_date` DATE COMMENT 'The start date of the audit period on which this NICRA rate is based. For final rates, this is the period for which actual costs were audited to establish the rate.',
    `carryforward_adjustment_amount` DECIMAL(18,2) COMMENT 'The dollar amount of carryforward adjustment from prior periods that must be applied when using this rate. Carryforward adjustments occur when provisional rates differ from final rates, requiring reconciliation in subsequent periods. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `cognizant_agency_code` STRING COMMENT 'The code identifying the federal agency responsible for negotiating and approving this indirect cost rate agreement. Common cognizant agencies include USAID, HHS, USDA, and DOD. The cognizant agency is typically the agency providing the most federal funding to the organization.',
    `cognizant_agency_name` STRING COMMENT 'The full name of the federal agency responsible for negotiating and approving this indirect cost rate agreement (e.g., United States Agency for International Development, Department of Health and Human Services).',
    `cost_base_type` STRING COMMENT 'The cost base to which the indirect cost rate is applied. Modified Total Direct Costs (MTDC) is the most common base and excludes capital expenditures, equipment, subawards over $25K, and other specific costs. Total Direct Costs includes all direct costs. Salaries and Wages base applies the rate only to personnel costs. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `modified_total_direct_costs|total_direct_costs|salaries_and_wages|direct_salaries|other`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this NICRA rate record was first created in the system. Used for audit trail and data lineage tracking.',
    `de_minimis_rate_flag` BOOLEAN COMMENT 'Indicates whether this record represents the use of the de minimis indirect cost rate. Organizations that have never received a negotiated rate may elect to use a de minimis rate of 10% of Modified Total Direct Costs per OMB Uniform Guidance.',
    `document_reference_url` STRING COMMENT 'URL or file path to the official NICRA agreement document. This provides direct access to the signed agreement for audit and compliance purposes.',
    `effective_end_date` DATE COMMENT 'The date on which this negotiated indirect cost rate expires and is no longer applicable to federal grants. This is the end of the rate period as specified in the NICRA agreement. Nullable for open-ended agreements pending renegotiation.',
    `effective_start_date` DATE COMMENT 'The date on which this negotiated indirect cost rate becomes effective and can be applied to federal grants. This is the beginning of the rate period as specified in the NICRA agreement.',
    `facilities_rate` DECIMAL(18,2) COMMENT 'The facilities component of the Facilities and Administration (F&A) rate, if the NICRA separates facilities and administrative costs. This rate covers depreciation, operations and maintenance, library, and other facility-related costs.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this NICRA rate applies. Format typically YYYY or YYYY-YYYY for multi-year agreements. This helps track which rate applies to which grant period.',
    `fringe_benefit_rate` DECIMAL(18,2) COMMENT 'The negotiated fringe benefit rate expressed as a percentage, if included in the NICRA agreement. Fringe benefits are often negotiated alongside indirect cost rates and applied to salaries and wages to calculate total personnel costs.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this NICRA rate is currently active and should be used for indirect cost calculations on new grants. True means the rate is within its effective period and approved for use; False means it is expired, superseded, or not yet effective.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this NICRA rate record in the system. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this NICRA rate record was last updated in the system. Used for audit trail and change tracking.',
    `negotiation_date` DATE COMMENT 'The date on which the indirect cost rate was formally negotiated and agreed upon with the cognizant federal agency. This is the date the NICRA agreement was signed.',
    `organizational_unit_code` STRING COMMENT 'The code identifying the organizational unit (division, department, or legal entity) to which this NICRA rate applies. Some organizations negotiate separate rates for different divisions or subsidiaries.',
    `organizational_unit_name` STRING COMMENT 'The name of the organizational unit (division, department, or legal entity) to which this NICRA rate applies.',
    `rate_category` STRING COMMENT 'The functional category or pool to which this rate applies. Organizations may have multiple rate categories such as headquarters operations, field operations, research, or program-specific pools. This allows for different indirect cost rates for different types of activities.',
    `rate_percentage` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate expressed as a percentage. This rate is applied to the applicable cost base to calculate allowable indirect cost recovery on federally-funded grants. For example, a rate of 15.50 means 15.50% of the base can be recovered as indirect costs.',
    `rate_type` STRING COMMENT 'The type of indirect cost rate negotiated with the federal government. Predetermined rates are negotiated in advance for a future period; fixed rates are established for a specific period and not subject to adjustment; provisional rates are temporary rates subject to adjustment; final rates are established after costs are known and audited.. Valid values are `predetermined|fixed|provisional|final`',
    `special_remarks` STRING COMMENT 'Free-text field capturing any special conditions, limitations, or instructions specified in the NICRA agreement. This may include restrictions on which grants the rate applies to, special calculation methods, or other agency-imposed conditions.',
    `successor_agreement_number` STRING COMMENT 'The agreement number of the subsequent NICRA that supersedes or replaces this agreement. Populated when a new rate is negotiated.',
    CONSTRAINT pk_nicra_rate PRIMARY KEY(`nicra_rate_id`)
) COMMENT 'Negotiated Indirect Cost Rate Agreement (NICRA) master record defining the approved indirect cost rates negotiated with the US federal government (typically USAID or HHS). Captures NICRA agreement number, rate type (predetermined, fixed, provisional, final), applicable base (modified total direct costs, total direct costs, salaries and wages), rate percentage, effective start and end dates, cognizant federal agency, agreement status, and applicable organizational unit. Used for indirect cost recovery calculations on federally-funded grants per OMB 2 CFR 200. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP CO, cognizant agency submissions. Framework: 2 CFR 200.414 (Indirect Costs) / IPSAS 18 segment allocation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation transaction record. Primary key. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `award_id` BIGINT COMMENT 'Reference to the grant award to which this cost allocation applies. Links the allocation to specific donor funding agreements.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Cost allocations target country offices (HQ costs allocated to countries). Finance needs to track allocations by country office for country-level cost management and full cost accounting.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each cost allocation for accountability in cost allocation processes and grant compliance.',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Shared costs can be allocated to specific distributions. Finance needs this for full distribution cost tracking and accurate cost per beneficiary calculations.',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the allocated amount (e.g., USD, EUR, GBP).',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.team. Business justification: Shared costs can be allocated to specific teams. Finance needs this for team cost tracking and accurate team budget vs. actual reporting.',
    `nicra_rate_id` BIGINT COMMENT 'Foreign key linking to finance.nicra_rate. Business justification: Cost allocations use NICRA rates to calculate indirect cost allocations. This FK enables joining to get the rate percentage, cost base type, and cognizant agency information.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Cost allocations are posted to specific fiscal periods for indirect cost distribution and financial reporting. The existing fiscal_year (INT) and fiscal_period (STRING) columns are denormalized repres',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Cost allocations post to specific GL accounts. This FK enables joining to get account classification, financial statement mapping, and account hierarchy for proper financial reporting.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this cost allocation applies. Links the allocation to specific programmatic activities.',
    `nicra_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.nicra_agreement. Business justification: Cost allocations must follow NICRA agreement terms (cost pools, allocation bases, exclusions). Controllers link allocations to agreement to ensure compliance with negotiated indirect cost recovery met',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Cost allocations often target specific sites (shared costs allocated to sites). Finance needs to track allocations by site for site cost management and full cost accounting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocations originate from a source cost center. This FK enables tracking which cost center is the source of allocated costs. Label prefix source_ distinguishes this from target_cost_center_id. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Cost allocations originate from a source fund. This FK enables tracking which fund is the source of allocated costs and ensures compliance with donor restrictions. Label prefix source_ distinguishes',
    `target_cost_center_id` BIGINT COMMENT 'FK to finance.cost_center [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `target_finance_fund_id` BIGINT COMMENT 'FK to finance.finance_fund',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary value of the cost being allocated from the source to the target. Represents the actual dollar amount distributed in this allocation transaction. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `allocation_basis` STRING COMMENT 'The quantitative basis or driver used to calculate the allocation distribution, such as headcount, square footage, direct costs, full-time equivalents (FTE), revenue, beneficiary count, transaction volume, or time spent. [ENUM-REF-CANDIDATE: headcount|square_footage|direct_costs|fte|revenue|beneficiary_count|transaction_volume|time_spent — 8 candidates stripped; promote to reference product] [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `allocation_basis_quantity` DECIMAL(18,2) COMMENT 'The quantitative measure of the allocation basis used in the calculation (e.g., number of employees, square feet, total direct costs). Used in conjunction with allocation_rate to compute allocated_amount. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `allocation_basis_unit` STRING COMMENT 'The unit of measure for the allocation basis quantity (e.g., employees, square_feet, USD, FTE, hours). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `allocation_date` DATE COMMENT 'The business date on which the cost allocation was executed and recorded in the general ledger. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `allocation_document_number` STRING COMMENT 'Externally-known unique document number for this cost allocation transaction, used for audit trail and reference in financial systems. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `^[A-Z0-9]{8,20}$`',
    `allocation_method` STRING COMMENT 'The methodology used to distribute costs across grants, programs, or cost centers. Common methods include direct assignment, proportional distribution, NICRA-based rates, step-down allocation, activity-based costing, headcount-based, or square footage-based. [ENUM-REF-CANDIDATE: direct|proportional|nicra_based|step_down|activity_based|headcount|square_footage — 7 candidates stripped; promote to reference product] [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments providing additional context, justification, or documentation for this cost allocation transaction. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `allocation_rate` DECIMAL(18,2) COMMENT 'The rate or percentage applied to the allocation basis to calculate the allocated amount. For NICRA-based allocations, this represents the negotiated indirect cost rate. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the cost allocation transaction: draft (being prepared), pending approval (awaiting review), approved (authorized), posted (recorded in GL), reversed (cancelled), or rejected (not approved). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `draft|pending_approval|approved|posted|reversed|rejected`',
    `approval_date` DATE COMMENT 'The date on which this cost allocation was approved by the authorized financial manager or controller.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this cost allocation transaction.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this cost allocation to supporting documentation, audit logs, or source system transaction records for compliance and audit purposes.',
    `compliance_flag` BOOLEAN COMMENT 'Indicator of whether this cost allocation meets OMB Uniform Guidance and donor compliance requirements: compliant, non-compliant, under review, or exempt.',
    `cost_category` STRING COMMENT 'Classification of the cost being allocated: direct program costs, indirect costs, facilities and administration (F&A), shared services, or overhead. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).. Valid values are `direct|indirect|facilities|administration|shared_services|overhead`',
    `cost_pool` STRING COMMENT 'The name or identifier of the cost pool from which costs are being allocated. Cost pools aggregate similar indirect costs for distribution. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was first created in the system.',
    `is_fa_cost` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation represents Facilities and Administration (F&A) costs, also known as indirect costs, that are recoverable under federal grants. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `is_restricted_fund` BOOLEAN COMMENT 'Boolean flag indicating whether the target fund is a restricted fund with donor-imposed limitations on the use of resources.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was last modified or updated in the system.',
    `posting_date` DATE COMMENT 'The date on which this cost allocation was posted to the general ledger and became part of the official financial records.',
    `reversal_date` DATE COMMENT 'The date on which this cost allocation was reversed or cancelled, if applicable. Null if the allocation has not been reversed.',
    `reversal_reason` STRING COMMENT 'Explanation for why this cost allocation was reversed or cancelled, if applicable.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Transactional record of indirect cost and shared cost allocations distributed across grants, programs, cost centers, and funds. Captures allocation document number, allocation date, allocation method (direct, proportional, NICRA-based, step-down), source cost center, target cost center, source fund, target fund, grant reference, allocated amount, allocation basis (headcount, square footage, direct costs), allocation rate applied, fiscal period, and approval status. Supports F&A (Facilities and Administration) cost recovery and OMB Uniform Guidance compliance. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP CO-PA, VISION. Framework: IPSAS 18 / US GAAP ASC 958-720 / 2 CFR 200 Subpart E (Cost Principles) / NICRA methodology.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key for the bank account entity.',
    `country_id` BIGINT COMMENT 'The 3-letter ISO 3166-1 alpha-3 country code representing the country where the bank account is domiciled. Supports geographic reporting, compliance monitoring, and regional cash management.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each bank account record for accountability in bank account setup and treasury management.',
    `exchange_rate_id` BIGINT COMMENT 'The 3-letter ISO 4217 currency code representing the denomination of the bank account (e.g., USD, EUR, GBP, CHF). Critical for multi-currency cash management and foreign exchange tracking.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Bank accounts are designated for specific funds (restricted or unrestricted). This FK enables joining to get fund restriction type, donor, and balance information.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bank accounts map to GL accounts for financial reporting. This FK enables joining to get the GL account classification and financial statement mapping.',
    `award_id` BIGINT COMMENT 'Foreign key reference to the specific grant award associated with this bank account, if the account is dedicated to a single grant or project. Supports grant financial management and compliance reporting.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Donor-restricted bank accounts require disclosure in regulatory filings (Form 990 Schedule D, single audit notes). Link supports automated filing preparation and ensures restricted cash is properly re',
    `account_name` STRING COMMENT 'The official name or title of the bank account as registered with the financial institution. Typically reflects the organization name, office, or fund designation.',
    `account_number` STRING COMMENT 'The full bank account number as issued by the financial institution. May be masked for security purposes in reporting layers. Critical for payment processing, reconciliation, and fund transfers.',
    `account_number_masked` STRING COMMENT 'Partially masked version of the bank account number for display in reports and user interfaces (e.g., ****1234). Protects sensitive financial data while allowing account identification.',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Active accounts are operational for transactions; dormant accounts have no recent activity but remain open; closed accounts are permanently deactivated; frozen accounts are temporarily suspended due to compliance or security issues; pending activation accounts are newly opened but not yet operational.. Valid values are `active|dormant|closed|frozen|pending_activation`',
    `account_type` STRING COMMENT 'Classification of the bank account based on its operational purpose. Operating accounts support general organizational expenses; restricted accounts hold donor-restricted funds; payroll accounts are dedicated to staff compensation; project accounts are tied to specific grants or programs; donor-specific accounts are ring-fenced per donor requirements. [ENUM-REF-CANDIDATE: operating|restricted|payroll|project|donor_specific|savings|escrow|petty_cash — 8 candidates stripped; promote to reference product]',
    `available_balance` DECIMAL(18,2) COMMENT 'The available balance in the bank account, accounting for pending transactions, holds, and minimum balance requirements. Represents the actual funds available for disbursement. Denominated in the account currency. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `bank_branch_code` STRING COMMENT 'The unique code assigned to the bank branch by the financial institution or national banking authority. Used for domestic payment routing and reconciliation.',
    `bank_branch_name` STRING COMMENT 'The name or identifier of the specific bank branch where the account is domiciled. Supports localized banking operations and correspondence.',
    `bank_contact_email` STRING COMMENT 'The email address of the primary contact person at the financial institution for this bank account. Used for correspondence and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bank_contact_name` STRING COMMENT 'The name of the primary contact person at the financial institution for this bank account. Supports relationship management and issue resolution.',
    `bank_contact_phone` STRING COMMENT 'The phone number of the primary contact person at the financial institution for this bank account. Used for urgent inquiries and issue resolution.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution where the account is held. Essential for payment routing, reconciliation, and financial reporting.',
    `closing_date` DATE COMMENT 'The date when the bank account was officially closed. Null for active or dormant accounts. Marks the end of the account lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was first created in the system. Supports audit trail and data lineage tracking.',
    `current_balance` DECIMAL(18,2) COMMENT 'The current balance of the bank account as of the last update or reconciliation. Denominated in the account currency. Used for cash flow monitoring and liquidity management. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `donor_name` STRING COMMENT 'The name of the donor or funding agency whose funds are held in this account, applicable for donor-specific or restricted accounts. Supports donor reporting and fund segregation requirements.',
    `donor_restriction_flag` BOOLEAN COMMENT 'Indicates whether this bank account holds donor-restricted funds that can only be used for specific purposes as stipulated by the donor. True if restricted; false if unrestricted. Critical for FASB ASC 958 compliance and donor stewardship.',
    `iban` STRING COMMENT 'The International Bank Account Number, a standardized international numbering system for bank accounts. Used primarily in Europe and other regions for cross-border payments. Format varies by country but always starts with 2-letter country code followed by 2 check digits.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]+$`',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether this bank account earns interest on deposited funds. True if interest-bearing; false otherwise. Relevant for savings accounts and certain restricted fund accounts.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to this bank account, expressed as a decimal (e.g., 0.0250 for 2.5%). Applicable only for interest-bearing accounts. Used for interest income forecasting and financial planning.',
    `last_reconciliation_date` DATE COMMENT 'The date when the bank account was last successfully reconciled against the General Ledger (GL). Used to monitor compliance with reconciliation frequency requirements and identify overdue reconciliations.',
    `last_transaction_date` DATE COMMENT 'The date of the most recent transaction (deposit, withdrawal, or transfer) on this bank account. Used to identify dormant accounts and monitor account activity.',
    `minimum_balance_requirement` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in this bank account to avoid fees or penalties, as stipulated by the financial institution. Denominated in the account currency. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this bank account. May include donor stipulations, operational constraints, or historical context.',
    `office_location` STRING COMMENT 'The organizational office or location that owns and manages this bank account (e.g., Headquarters, Kenya Country Office, Syria Regional Office). Supports decentralized financial management and cost center allocation.',
    `opening_date` DATE COMMENT 'The date when the bank account was officially opened with the financial institution. Marks the start of the account lifecycle.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'The maximum overdraft amount permitted on this bank account, if overdraft protection is enabled. Denominated in the account currency. Null if no overdraft protection exists.',
    `overdraft_protection_flag` BOOLEAN COMMENT 'Indicates whether this bank account has overdraft protection enabled. True if overdraft protection is active; false otherwise. Overdraft protection allows transactions to proceed even if the account balance is insufficient, subject to bank terms.',
    `reconciliation_frequency` STRING COMMENT 'The required frequency for reconciling this bank account against the General Ledger (GL). High-volume or high-risk accounts may require daily reconciliation; lower-activity accounts may be reconciled monthly or quarterly per internal controls policy.. Valid values are `daily|weekly|monthly|quarterly`',
    `routing_number` STRING COMMENT 'The 9-digit routing transit number (RTN) used in the United States for domestic wire transfers, ACH transactions, and check processing. Identifies the financial institution in the US banking system.. Valid values are `^[0-9]{9}$`',
    `signatory_requirement` STRING COMMENT 'The number and level of authorized signatories required to approve transactions on this bank account. Single signatory allows one authorized person; dual signatory requires two; triple requires three; board approval requires formal board resolution. Supports segregation of duties and fraud prevention.. Valid values are `single|dual|triple|board_approval`',
    `signatory_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which elevated signatory requirements apply. For example, transactions below this amount may require single signatory, while transactions above require dual or board approval. Denominated in the account currency. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `swift_code` STRING COMMENT 'The Society for Worldwide Interbank Financial Telecommunication (SWIFT) code, also known as Bank Identifier Code (BIC). An 8 or 11-character code used for international wire transfers and cross-border payments. Format: 4-letter bank code, 2-letter country code, 2-character location code, optional 3-character branch code.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was last updated in the system. Supports audit trail and change tracking.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master record for all organizational bank accounts managed by the NGO across headquarters, regional offices, and country offices. Captures bank account number (masked), bank name, bank branch, SWIFT/BIC code, IBAN, account currency, account type (operating, restricted, payroll, project, donor-specific), country, account status (active, dormant, closed), signatory requirements and thresholds, fund association for restricted accounts, GL reconciliation account reference, and reconciliation frequency. Supports multi-currency cash management, restricted fund segregation, donor ring-fencing requirements, and financial controls across global operations. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: SAP FI-BL (Bank Ledger), VISION Treasury. Framework: IPSAS 2 (Cash Flow Statements) / US GAAP ASC 230.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` (
    `bank_reconciliation_id` BIGINT COMMENT 'Unique identifier for the bank reconciliation record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant award if this bank account is dedicated to a specific grant or donor-restricted fund. Links to the grant award registry.',
    `bank_account_id` BIGINT COMMENT 'Reference to the bank account being reconciled. Links to the master bank account registry.',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the bank account and all monetary amounts in this reconciliation.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Bank reconciliations are allocated to funds for fund accounting. This FK enables joining to get fund restriction type and donor information.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bank reconciliations reconcile bank statement balances to GL account balances. This FK enables joining to get the GL account being reconciled and its classification.',
    `internal_review_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_review. Business justification: Bank reconciliations are subject to internal compliance reviews as part of financial controls testing. Internal audit teams link reconciliations to review findings for control deficiency tracking and ',
    `user_account_id` BIGINT COMMENT 'System user identifier of the finance staff member who performed the reconciliation. Links to the workforce user registry.',
    `tertiary_bank_approved_by_user_user_account_id` BIGINT COMMENT 'System user identifier of the authorized approver. Links to the workforce user registry.',
    `adjusted_bank_balance` DECIMAL(18,2) COMMENT 'Bank statement closing balance after adjustments for outstanding deposits, outstanding checks, and other in-transit items. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `adjusted_gl_balance` DECIMAL(18,2) COMMENT 'General ledger book balance after adjustments for unrecorded bank charges, interest, and other reconciling items. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `approval_date` DATE COMMENT 'Date when the bank reconciliation was formally approved by an authorized approver.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized approver who formally approved the bank reconciliation.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this bank reconciliation to external audit documentation, supporting schedules, or compliance evidence.',
    `compliance_flag` BOOLEAN COMMENT 'Flag indicating whether this bank reconciliation meets all internal control requirements, OMB Uniform Guidance standards, and donor compliance obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank reconciliation record was first created in the system.',
    `exception_count` STRING COMMENT 'Number of exceptions or discrepancies identified during the reconciliation that require follow-up or corrective action.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year to which this bank reconciliation belongs.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this bank reconciliation period belongs, used for financial reporting and audit purposes.',
    `gl_book_balance` DECIMAL(18,2) COMMENT 'Cash balance recorded in the general ledger for the corresponding GL account at the reconciliation date. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `is_restricted_fund` BOOLEAN COMMENT 'Flag indicating whether the bank account holds donor-restricted funds subject to specific use restrictions and compliance requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank reconciliation record was last modified or updated.',
    `outstanding_checks_amount` DECIMAL(18,2) COMMENT 'Total amount of checks issued and recorded in the general ledger but not yet cleared by the bank. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `outstanding_deposits_amount` DECIMAL(18,2) COMMENT 'Total amount of deposits recorded in the general ledger but not yet reflected on the bank statement (deposits in transit). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `reconciled_by` STRING COMMENT 'Name or identifier of the finance staff member who performed the bank reconciliation.',
    `reconciliation_date` DATE COMMENT 'Date when the bank reconciliation activity was performed and completed by the reconciling officer.',
    `reconciliation_document_number` STRING COMMENT 'Externally-known business identifier for the bank reconciliation document, used for audit trail and reference purposes.',
    `reconciliation_notes` STRING COMMENT 'Free-text notes and comments documenting reconciling items, variances, adjustments, and any issues identified during the reconciliation process.',
    `reconciliation_period_end_date` DATE COMMENT 'End date of the reconciliation period covered by this bank reconciliation activity.',
    `reconciliation_period_start_date` DATE COMMENT 'Start date of the reconciliation period covered by this bank reconciliation activity.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the bank reconciliation process. Tracks workflow from initiation through approval.. Valid values are `in_progress|reconciled|approved|rejected|pending_review|reopened`',
    `reconciling_items_count` STRING COMMENT 'Total number of reconciling items identified during the bank reconciliation process, including outstanding deposits, outstanding checks, and unrecorded transactions.',
    `review_date` DATE COMMENT 'Date when the bank reconciliation was reviewed by a supervisor or manager.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the supervisor or manager who reviewed the bank reconciliation for accuracy and completeness.',
    `statement_closing_balance` DECIMAL(18,2) COMMENT 'Closing balance as reported on the bank statement at the end of the reconciliation period. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `statement_date` DATE COMMENT 'Official date of the bank statement being reconciled against the general ledger.',
    `statement_opening_balance` DECIMAL(18,2) COMMENT 'Opening balance as reported on the bank statement at the beginning of the reconciliation period. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `unrecorded_bank_charges_amount` DECIMAL(18,2) COMMENT 'Total amount of bank service charges, fees, and other deductions appearing on the bank statement but not yet recorded in the general ledger. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `unrecorded_bank_credits_amount` DECIMAL(18,2) COMMENT 'Total amount of bank interest income, wire transfers, or other credits appearing on the bank statement but not yet recorded in the general ledger. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between adjusted GL balance and adjusted bank balance. A zero variance indicates successful reconciliation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    CONSTRAINT pk_bank_reconciliation PRIMARY KEY(`bank_reconciliation_id`)
) COMMENT 'Transactional record of bank statement reconciliation activities matching GL cash balances against bank statement transactions for each bank account and period. Captures reconciliation period, bank account reference, statement date, statement opening balance, statement closing balance, GL book balance, reconciling items count, outstanding deposits, outstanding checks, unrecorded bank charges, reconciliation status (in progress, reconciled, approved), and reconciling officer. Supports financial controls and audit compliance. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` (
    `exchange_rate_id` BIGINT COMMENT 'Unique identifier for the exchange rate record. Primary key for the exchange rate reference master.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each exchange rate for accountability in foreign exchange rate management and multi-currency operations.',
    `from_exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code representing the source currency in the exchange rate pair (e.g., USD, EUR, GBP). The currency being converted from.. Valid values are `^[A-Z]{3}$`',
    `primary_superseded_by_rate_exchange_rate_id` BIGINT COMMENT 'Reference to the exchange rate record that replaces this rate. Nullable for current active rates. Creates a chain of rate succession for historical tracking and audit purposes.',
    `to_exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code representing the target currency in the exchange rate pair (e.g., USD, EUR, GBP). The currency being converted to.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Exchange rates are effective for fiscal periods and used for multi-currency financial reporting and revaluation. The existing fiscal_year (INT) and fiscal_period (STRING) columns are denormalized repr',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this exchange rate requires formal approval before being activated for use in financial transactions. True indicates approval workflow is required; false indicates rate can be used immediately upon publication.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate was formally approved for use. Nullable for rates that do not require approval. Establishes the point at which the rate became authorized for financial transactions.',
    `approved_by_user` STRING COMMENT 'Username or identifier of the authorized user who approved this exchange rate for use in financial transactions. Nullable for rates that do not require approval. Supports audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate record was first created in the system. Supports audit trail and data lineage tracking.',
    `donor_required_rate_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this exchange rate is mandated by a specific donor or grant agreement. True indicates the rate must be used for specific donor reporting; false indicates it is a general organizational rate. Critical for grant compliance.',
    `effective_date` DATE COMMENT 'The date from which this exchange rate becomes valid and should be used for currency conversions. Represents the start of the rates applicability period.',
    `expiration_date` DATE COMMENT 'The date on which this exchange rate ceases to be valid. Nullable for rates that remain effective until superseded. Represents the end of the rates applicability period.',
    `inverse_rate_value` DECIMAL(18,2) COMMENT 'The inverse of the exchange rate value, representing how many units of the source currency equal one unit of the target currency. Calculated as 1 divided by exchange_rate_value. Facilitates bidirectional currency conversions.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who most recently modified this exchange rate record. Tracks responsibility for the latest changes and supports audit trail requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate record was most recently updated. Tracks the latest change to any field in the record for audit and data quality purposes.',
    `mid_market_rate_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this rate represents the mid-market rate (the midpoint between buy and sell rates). True indicates a neutral market rate without spread markup; false indicates a rate that may include transaction costs or spreads.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or explanatory remarks about this exchange rate. May include information about unusual market conditions, donor-specific requirements, or deviations from standard rate sources.',
    `rate_calculation_method` STRING COMMENT 'Description of the methodology used to calculate or derive the exchange rate. For average rates, describes the averaging period and calculation approach. For budget rates, describes the forecasting methodology. Ensures transparency in rate determination.',
    `rate_publication_timestamp` TIMESTAMP COMMENT 'The exact date and time when the exchange rate was officially published or released by the rate source. Provides precise temporal reference for rate validity and audit purposes.',
    `rate_source` STRING COMMENT 'The authoritative source or provider of the exchange rate data. Examples include central banks (Federal Reserve, European Central Bank), commercial providers (OANDA, Bloomberg, Reuters), UN Operational Rates of Exchange, or internal treasury systems. Ensures traceability and auditability of rate origins.',
    `rate_source_reference` STRING COMMENT 'External reference identifier or URL from the rate source system that can be used to verify or trace back to the original rate publication. Supports audit trail and compliance verification.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the exchange rate record. Active rates are currently in use, inactive rates are no longer valid, superseded rates have been replaced by newer rates, pending rates are awaiting approval, and draft rates are under preparation.. Valid values are `active|inactive|superseded|pending|draft`',
    `rate_type` STRING COMMENT 'Classification of the exchange rate indicating its purpose and calculation method. Spot rates are real-time market rates, average rates are period averages, budget rates are planning rates, closing rates are end-of-period rates, forward rates are future-dated contracts, and historical rates are past reference rates.. Valid values are `spot|average|budget|closing|forward|historical`',
    `revaluation_rate_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this rate is designated for use in general ledger foreign currency revaluation processes. True indicates the rate should be used for balance sheet revaluation; false indicates it is for transactional purposes only.',
    `spread_percentage` DECIMAL(18,2) COMMENT 'The percentage spread or markup applied to the base exchange rate to account for transaction costs, bank fees, or foreign exchange margins. Expressed as a decimal (e.g., 0.0150 for 1.5%). Nullable for rates without spreads.',
    `un_operational_rate_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this rate is sourced from the United Nations Operational Rates of Exchange, commonly used by international NGOs and humanitarian organizations for standardized multi-currency reporting.',
    `usage_context` STRING COMMENT 'Description of the specific business contexts or transaction types for which this exchange rate should be used. Examples include donor reporting, budget planning, accounts payable processing, grant financial statements, or general ledger revaluation. Provides guidance for appropriate rate application.',
    `value` DECIMAL(18,2) COMMENT 'The numeric exchange rate value representing how many units of the target currency equal one unit of the source currency. For example, if USD to EUR rate is 0.85, then 1 USD equals 0.85 EUR. Stored with six decimal places for precision.',
    `variance_from_prior_rate` DECIMAL(18,2) COMMENT 'The absolute difference between this exchange rate value and the immediately preceding rate for the same currency pair and rate type. Facilitates trend analysis and identification of significant rate movements.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The percentage change between this exchange rate and the immediately preceding rate for the same currency pair and rate type. Expressed as a decimal (e.g., 0.0250 for 2.5% increase). Supports volatility monitoring and financial risk assessment.',
    CONSTRAINT pk_exchange_rate PRIMARY KEY(`exchange_rate_id`)
) COMMENT 'Reference master for currency exchange rates used across all multi-currency financial transactions, grant reporting, and donor financial statements. Captures currency pair (from/to currency), rate type (spot, average, budget, closing), exchange rate value, effective date, rate source (central bank, OANDA, UN operational rate), and rate status. Supports multi-currency fund accounting, grant financial reporting in donor currencies, and FASB ASC 958 foreign currency translation. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity. Systems-of-record: UN Treasury (UNORE rates), SAP FI currency tables. Framework: IPSAS 4 (Effects of Changes in Foreign Exchange Rates) / US GAAP ASC 830.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` (
    `fund_compliance_tracking_id` BIGINT COMMENT 'Unique identifier for this fund-requirement compliance tracking record. Primary key.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member assigned responsibility for ensuring this funds compliance with this specific requirement. May differ from the general requirement owner.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key to donor_requirement. Identifies which donor requirement applies to this fund.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key to finance_fund. Identifies which fund this compliance tracking applies to.',
    `compliance_status` STRING COMMENT 'Current status of this funds compliance with this specific requirement. Tracks progress from initiation through approval or waiver. Distinct from the donor_requirement.compliance_status which may aggregate across multiple funds.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this fund-requirement compliance tracking record was created in the system.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this compliance tracking record was last updated.',
    `last_verification_date` DATE COMMENT 'The most recent date on which compliance with this requirement was verified for this fund. Used for audit trail and to determine when next verification is due.',
    `notes` STRING COMMENT 'Free-text notes specific to this funds compliance with this requirement, including fund-specific challenges, accommodations, or context.',
    `requirement_applicability_end_date` DATE COMMENT 'The date on which this donor requirement ceases to apply to this specific fund. May differ from fund effective_end_date if requirement is waived or modified.',
    `requirement_applicability_start_date` DATE COMMENT 'The date from which this donor requirement becomes applicable to this specific fund. May differ from the fund effective_start_date if requirement is added mid-grant.',
    `waiver_decision_date` DATE COMMENT 'Date on which the donor made a decision (granted or denied) on the waiver request for this fund-requirement combination.',
    `waiver_request_date` DATE COMMENT 'Date on which a waiver was formally requested for this fund-requirement combination.',
    `waiver_status` STRING COMMENT 'Status of any waiver request for this requirement as it applies to this specific fund. A requirement may be waived for one fund but not others.',
    CONSTRAINT pk_fund_compliance_tracking PRIMARY KEY(`fund_compliance_tracking_id`)
) COMMENT 'This association product represents the compliance relationship between finance_fund and donor_requirement. It captures the applicability and compliance status of specific donor requirements to individual funds. Each record links one fund to one donor requirement with attributes that track when the requirement applies, compliance verification, and waiver status. Essential for grant financial management, audit preparation, and donor reporting per OMB Uniform Guidance 2 CFR 200.. Existence Justification: In NGO grant financial management, a single fund can be subject to multiple donor compliance requirements (financial reporting, audit, procurement rules, anti-terrorism certification), and a single donor requirement (e.g., quarterly financial reporting per OMB Uniform Guidance) can apply to multiple funds managed by the organization. Organizations actively manage compliance status, verification dates, and waiver requests at the fund-requirement level because compliance obligations vary by fund based on donor source, grant terms, and restriction type. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Primary key for fiscal_period',
    `budget_version_id` BIGINT COMMENT 'Reference to the budget version applicable to this fiscal period. Used for Budget vs. Actual (BvA) tracking and variance analysis. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `exchange_rate_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for financial reporting in this period (e.g., USD, EUR, GBP). Supports multi-currency nonprofit operations.',
    `fiscal_prior_year_period_id` BIGINT COMMENT 'Reference to the corresponding fiscal period in the prior fiscal year. Enables year-over-year comparative analysis.',
    `primary_prior_fiscal_period_id` BIGINT COMMENT 'Self-referencing FK on fiscal_period (prior_fiscal_period_id)',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether this fiscal period requires external audit review, typically for annual periods or grant compliance.',
    `closed_date` DATE COMMENT 'The date when the fiscal period was officially closed. Nullable if period is still open or future.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was first created in the system.',
    `days_in_period` STRING COMMENT 'Total number of calendar days in the fiscal period. Used for prorations, accruals, and time-weighted calculations.',
    `fiscal_period_description` STRING COMMENT 'Detailed description or notes about the fiscal period, including any special considerations, adjustments, or organizational context.',
    `end_date` DATE COMMENT 'The last day of the fiscal period. Defines when the period closes for financial transactions and reporting.',
    `exchange_rate_date` DATE COMMENT 'The date for which exchange rates are locked for multi-currency translation in this fiscal period. Nullable for single-currency organizations.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this period belongs (e.g., 2024). Supports non-calendar fiscal years common in nonprofit organizations.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this fiscal period record is currently active and available for use in financial transactions and reporting.',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this is a special adjustment period (typically Period 13) used for year-end closing entries and corrections.',
    `is_year_end_period` BOOLEAN COMMENT 'Indicates whether this is the final period of the fiscal year, requiring special year-end closing procedures and financial statement preparation.',
    `locked_date` DATE COMMENT 'The date when the fiscal period was permanently locked, preventing any further modifications. Nullable if not yet locked.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was last modified. Updated whenever period status or attributes change.',
    `opened_date` DATE COMMENT 'The date when the fiscal period was officially opened for transaction posting. May differ from start_date due to administrative processes.',
    `period_code` STRING COMMENT 'Short alphanumeric code representing the fiscal period (e.g., FY24-Q1, P01-2024). Used as a business identifier for reporting and reference.',
    `period_name` STRING COMMENT 'Human-readable name of the fiscal period (e.g., January 2024, Q1 FY2024, Period 1 - FY2024).',
    `period_number` STRING COMMENT 'Sequential number of the period within the fiscal year (e.g., 1 for January, 4 for Q1, 12 for December). Used for ordering and reporting.',
    `period_status` STRING COMMENT 'Current lifecycle status of the fiscal period. Open allows transactions; closed prevents new entries but allows adjustments; locked is final and immutable; future indicates not yet active.',
    `period_type` STRING COMMENT 'Classification of the fiscal period by duration and frequency (monthly, quarterly, semi-annual, annual, or custom).',
    `quarter_number` STRING COMMENT 'The fiscal quarter number (1-4) to which this period belongs. Nullable for non-quarterly periods.',
    `start_date` DATE COMMENT 'The first day of the fiscal period. Defines when the period becomes effective for financial transactions and reporting.',
    `working_days_in_period` STRING COMMENT 'Number of business working days in the fiscal period, excluding weekends and holidays. Used for operational metrics and staffing calculations.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Master reference table for fiscal_period. Referenced by fiscal_period_id. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `award_id` BIGINT COMMENT 'Reference to the grant associated with this payment run, if payments are grant-funded.',
    `bank_account_id` BIGINT COMMENT 'Reference to the organizations bank account from which payments in this run are disbursed.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for the payments in this run, used for cost allocation and budget tracking. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `exchange_rate_id` BIGINT COMMENT 'The three-letter ISO 4217 currency code for all payments in this run.',
    `finance_fund_id` BIGINT COMMENT 'Reference to the fund from which payments in this run are sourced, critical for restricted fund tracking and compliance.',
    `staff_member_id` BIGINT COMMENT 'Reference to the user or employee who created this payment run record.',
    `payment_staff_member_id` BIGINT COMMENT 'Reference to the user or employee who approved this payment run for execution.',
    `rerun_of_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (rerun_of_payment_run_id) [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the payment run was approved for execution.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this payment run to detailed audit trail records for compliance and investigation purposes.',
    `batch_reference_number` STRING COMMENT 'External batch reference number provided by the bank or payment processor for reconciliation purposes.',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when the payment run was fully completed and all payments were processed.',
    `compliance_flag` BOOLEAN COMMENT 'Flag indicating whether this payment run has been reviewed and marked as compliant with applicable regulations and policies.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the payment run record was first created in the system.',
    `payment_run_description` STRING COMMENT 'Free-text description providing additional context or notes about the purpose and scope of this payment run.',
    `error_message` STRING COMMENT 'System-generated error message or failure reason if the payment run encountered processing errors.',
    `execution_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment run was executed and payments were initiated.',
    `failed_amount` DECIMAL(18,2) COMMENT 'The total monetary value of payments that failed during processing in this run. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `failed_payment_count` DECIMAL(18,2) COMMENT 'The number of payments that failed during processing in this run. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year when this payment run is executed.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this payment run is executed, used for financial reporting and budget tracking.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this payment run is part of a recurring payment schedule.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the payment run record was last updated.',
    `notes` STRING COMMENT 'Internal notes or comments added by finance staff regarding this payment run for audit and operational purposes.',
    `payment_channel` DECIMAL(18,2) COMMENT 'The interface or system channel through which the payment run was initiated and processed. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_due_date` DATE COMMENT 'The date by which payments in this run are due to be received by payees, used for scheduling and compliance. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_method` DECIMAL(18,2) COMMENT 'The financial instrument or mechanism used to execute payments in this run (e.g., ACH, wire transfer, check). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `reconciliation_date` DATE COMMENT 'The date on which this payment run was reconciled with bank records.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether this payment run has been reconciled with bank statements and payment confirmations.',
    `recurrence_pattern` STRING COMMENT 'The frequency pattern for recurring payment runs, if applicable.',
    `run_number` STRING COMMENT 'Business identifier for the payment run, typically formatted as PR-YYYYMMDD-NNNN for external reference and audit trails.',
    `run_type` STRING COMMENT 'Classification of the payment run based on its purpose and processing requirements.',
    `scheduled_date` DATE COMMENT 'The date on which the payment run is scheduled to be executed.',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run in the approval and execution workflow.',
    `successful_amount` DECIMAL(18,2) COMMENT 'The total monetary value of payments that were successfully processed in this run. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `successful_payment_count` DECIMAL(18,2) COMMENT 'The number of payments that were successfully processed and completed in this run. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `total_amount` DECIMAL(18,2) COMMENT 'The total monetary value of all payments included in this payment run. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `total_payment_count` DECIMAL(18,2) COMMENT 'The total number of individual payment transactions included in this payment run. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` (
    `bank_transaction_id` BIGINT COMMENT 'Primary key for bank_transaction',
    `award_id` BIGINT COMMENT 'Identifier of the grant or award associated with this transaction, used for grant financial management and compliance.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the bank account associated with this transaction.',
    `user_account_id` BIGINT COMMENT 'Identifier of the user who created this bank transaction record in the system.',
    `bank_modified_by_user_user_account_id` BIGINT COMMENT 'Identifier of the user who last modified this bank transaction record.',
    `bank_user_account_id` BIGINT COMMENT 'Identifier of the user who performed the reconciliation of this transaction.',
    `component_id` BIGINT COMMENT 'Identifier of the program or project to which this transaction is attributed for cost allocation and reporting.',
    `constituent_id` BIGINT COMMENT 'Identifier of the donor associated with this transaction if it represents a donation or contribution.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Bank transactions are allocated to cost centers for expense tracking and budget monitoring. The existing cost_center_code (STRING) column is a denormalized representation that should be replaced with  [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the transaction amount.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Bank transactions are tagged to funds for restricted fund tracking and donor compliance. The existing fund_code (STRING) column is a denormalized representation that should be replaced with a proper F',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bank transactions are coded to GL accounts for financial reporting and bank reconciliation. The existing gl_account_code (STRING) column is a denormalized representation that should be replaced with a',
    `reversal_bank_transaction_id` BIGINT COMMENT 'Self-referencing FK on bank_transaction (reversal_bank_transaction_id)',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier associated with this transaction if it represents a payment for goods or services.',
    `bank_statement_date` DATE COMMENT 'The date of the bank statement on which this transaction appeared.',
    `check_number` STRING COMMENT 'The check number if the transaction was executed via paper or electronic check.',
    `counterparty_account_number` STRING COMMENT 'Bank account number of the counterparty (other party) involved in the transaction.',
    `counterparty_bank_name` STRING COMMENT 'Name of the financial institution holding the counterpartys account.',
    `counterparty_routing_number` STRING COMMENT 'Bank routing number or SWIFT code for the counterpartys financial institution.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank transaction record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The amount credited to the account for this transaction. Null if transaction is a debit. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `debit_amount` DECIMAL(18,2) COMMENT 'The amount debited from the account for this transaction. Null if transaction is a credit. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `invoice_number` STRING COMMENT 'Reference number of the invoice being paid or associated with this transaction.',
    `is_indirect_cost` BOOLEAN COMMENT 'Flag indicating whether this transaction represents an indirect cost subject to NICRA (Negotiated Indirect Cost Rate Agreement) allocation. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `is_restricted_fund` BOOLEAN COMMENT 'Flag indicating whether this transaction involves restricted funds subject to donor or grant stipulations.',
    `memo` STRING COMMENT 'Additional notes or memo text associated with the transaction for internal reference or clarification.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank transaction record was last modified or updated.',
    `payee_name` STRING COMMENT 'Name of the individual or organization receiving funds in this transaction.',
    `payer_name` STRING COMMENT 'Name of the individual or organization providing funds in this transaction.',
    `payment_channel` DECIMAL(18,2) COMMENT 'The interface or channel through which the transaction was initiated (online banking, mobile app, branch, ATM, phone, mail). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `payment_method` DECIMAL(18,2) COMMENT 'The instrument or mechanism used to execute the transaction (wire transfer, ACH, check, card, cash, electronic funds transfer). [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `reconciliation_date` DATE COMMENT 'The date when this transaction was reconciled with internal accounting records.',
    `reconciliation_status` STRING COMMENT 'Indicates whether this bank transaction has been matched and reconciled with internal accounting records.',
    `restriction_type` STRING COMMENT 'Classification of fund restriction per FASB ASC 958 nonprofit accounting standards.',
    `running_balance` DECIMAL(18,2) COMMENT 'The account balance after this transaction has been applied, used for reconciliation and cash position tracking. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the bank transaction in the accounts base currency. Positive for credits/deposits, negative for debits/withdrawals. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `transaction_date` DATE COMMENT 'The date when the bank transaction occurred or was posted to the account.',
    `transaction_description` STRING COMMENT 'Detailed narrative description of the bank transaction purpose, often provided by the bank or entered by the user.',
    `transaction_reference_number` STRING COMMENT 'Externally-known unique reference number assigned by the bank or payment processor for this transaction. Used for reconciliation and audit trails.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the bank transaction indicating its processing state.',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise date and time when the bank transaction was executed or recorded by the banking system.',
    `transaction_type` STRING COMMENT 'Classification of the bank transaction indicating the nature of the movement (deposit, withdrawal, transfer, fee, interest, refund).',
    `value_date` DATE COMMENT 'The effective date when funds become available or are debited, used for interest calculation and cash flow management.',
    CONSTRAINT pk_bank_transaction PRIMARY KEY(`bank_transaction_id`)
) COMMENT 'Master reference table for bank_transaction. Referenced by bank_transaction_id. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`budget_version` (
    `budget_version_id` BIGINT COMMENT 'Primary key for budget_version [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `award_id` BIGINT COMMENT 'Reference to the specific grant or donor agreement if this budget version is grant-specific. Nullable for organization-wide budgets.',
    `budget_id` BIGINT COMMENT 'Connect finance.budget_version by adding column budget_id (BIGINT) with FK to finance.budget.budget_id because budget_version has only a self-ref and one inbound reference. P3: connect_table: finance.budget_version** - add column budget_id  [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `exchange_rate_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget version (e.g., USD, EUR, GBP).',
    `finance_fund_id` BIGINT COMMENT 'Reference to the fund (restricted, unrestricted, temporarily restricted, endowment) to which this budget version applies.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational entity (e.g., headquarters, regional office, program unit) to which this budget version applies.',
    `parent_version_id` BIGINT COMMENT 'Reference to the parent budget version from which this version was derived (e.g., revised budget referencing original budget). Nullable for original versions.',
    `prior_budget_version_id` BIGINT COMMENT 'Self-referencing FK on budget_version (prior_budget_version_id) [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `program_id` BIGINT COMMENT 'Reference to the program or service line to which this budget version applies. Nullable for organization-wide budgets.',
    `approval_date` DATE COMMENT 'The date on which this budget version was formally approved by the authorized governing body or management.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or committee who approved this budget version.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget version record was first created in the system.',
    `budget_version_description` STRING COMMENT 'Detailed description of the budget version, including purpose, scope, key assumptions, and any special considerations or constraints.',
    `effective_end_date` DATE COMMENT 'The date on which this budget version ceases to be effective. Nullable for open-ended versions.',
    `effective_start_date` DATE COMMENT 'The date from which this budget version becomes effective and operational for financial planning and tracking.',
    `expense_budget_amount` DECIMAL(18,2) COMMENT 'The total budgeted expense amount for this version, including program, administrative, and fundraising costs. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `fiscal_period` STRING COMMENT 'The fiscal period covered by this budget version (e.g., Q1, Q2, M01, M12, ANNUAL).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget version applies (e.g., 2024).',
    `is_baseline` BOOLEAN COMMENT 'Indicates whether this version serves as the baseline budget for variance analysis and budget-versus-actual reporting.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget version is locked from further modifications. Typically true for approved and active budgets.',
    `locked_by` STRING COMMENT 'Name or identifier of the person who locked this budget version.',
    `locked_date` DATE COMMENT 'The date on which this budget version was locked from further changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget version record was last modified in the system.',
    `notes` STRING COMMENT 'Additional notes, comments, or annotations related to this budget version, including change rationale or special instructions.',
    `revenue_budget_amount` DECIMAL(18,2) COMMENT 'The total budgeted revenue amount for this version, including grants, donations, and earned income. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `review_date` DATE COMMENT 'The date on which this budget version was reviewed by the finance committee or management team.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the person or committee who reviewed this budget version.',
    `budget_version_status` STRING COMMENT 'Current lifecycle status of the budget version indicating its approval state and operational validity.',
    `submission_date` DATE COMMENT 'The date on which this budget version was submitted for review and approval.',
    `submitted_by` STRING COMMENT 'Name or identifier of the person who submitted this budget version for approval.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total budgeted amount for this version across all line items and categories. [framework] Recognized/measured per configurable accounting framework: IPSAS, US GAAP ASC 958, Form 990 (IPSAS for UN agencies; US GAAP ASC 958 / Form 990 for US nonprofits).',
    `version_code` STRING COMMENT 'Business identifier code for the budget version (e.g., FY2024_V1, FY2024_REVISED, FY2024_FINAL). Used for external reference and reporting.',
    `version_name` STRING COMMENT 'Human-readable name of the budget version (e.g., FY2024 Original Budget, Q2 Revised Budget, Final Approved Budget).',
    `version_sequence` STRING COMMENT 'Sequential number indicating the order of this version within the fiscal year (e.g., 1 for original, 2 for first revision, 3 for second revision).',
    `version_type` STRING COMMENT 'Classification of the budget version indicating its purpose and stage in the budget lifecycle.',
    CONSTRAINT pk_budget_version PRIMARY KEY(`budget_version_id`)
) COMMENT 'Master reference table for budget_version. Referenced by budget_version_id. | Accounting framework: configurable for US GAAP (ASC 958), IPSAS (UN/INGO), or IFRS as applicable. [accounting_framework] Accounting framework references (configurable): IPSAS (UN agencies); US GAAP ASC 958 (US nonprofits, currently the only reference); Form 990 (US IRS, currently referenced). IPSAS is recognized alongside US GAAP (ASC 958) and Form 990; framework applied per reporting entity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`finance`.`finance_face_form` (
    `finance_face_form_id` BIGINT COMMENT 'Unique identifier for the finance face form record.',
    `exchange_rate_id` BIGINT COMMENT 'Reference identifier linking to the associated exchange rate entity.',
    `finance_fund_id` BIGINT COMMENT 'Reference identifier linking to the associated finance fund entity.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `micro_assessment_id` BIGINT COMMENT 'Reference identifier linking to the associated micro assessment entity.',
    `partner_org_id` BIGINT COMMENT 'Reference identifier linking to the associated partner org entity.',
    `authorized_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the authorized quantity or measurement.',
    `balance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the balance quantity or measurement.',
    `certification_date` DATE COMMENT 'Date and time when the certification event occurred for this finance face form.',
    `certified_by_name` STRING COMMENT 'Human-readable name or label for the certified by.',
    `certified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the certified condition applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this finance face form.',
    `expenditure_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the expenditure quantity or measurement.',
    `face_form_number` STRING COMMENT 'Count or number of face form items associated with this record.',
    `face_form_status` STRING COMMENT 'Current status indicator for the face form workflow state.',
    `ip_transfer_modality` STRING COMMENT 'IP transfer modality enum: Direct Cash Transfer/Reimbursement/Direct Payment',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this finance face form.',
    `liquidated_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the liquidated quantity or measurement.',
    `reporting_period_end_date` DATE COMMENT 'Date and time when the reporting period end event occurred for this finance face form.',
    `reporting_period_start_date` DATE COMMENT 'Date and time when the reporting period start event occurred for this finance face form.',
    `reporting_quarter` STRING COMMENT 'Attribute capturing the reporting quarter information for the finance face form entity.',
    CONSTRAINT pk_finance_face_form PRIMARY KEY(`finance_face_form_id`)
) COMMENT 'HACT quarterly Funding Authorization and Certificate of Expenditures (FACE) liquidation form.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_nicra_rate_id` FOREIGN KEY (`nicra_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`nicra_rate`(`nicra_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_parent_fund_finance_fund_id` FOREIGN KEY (`parent_fund_finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_journal_functional_currency_code` FOREIGN KEY (`journal_functional_currency_code`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_ngo_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_original_line_journal_entry_line_id` FOREIGN KEY (`original_line_journal_entry_line_id`) REFERENCES `vibe_ngo_v1`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_nicra_rate_id` FOREIGN KEY (`nicra_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`nicra_rate`(`nicra_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_ngo_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_bank_transaction_id` FOREIGN KEY (`bank_transaction_id`) REFERENCES `vibe_ngo_v1`.`finance`.`bank_transaction`(`bank_transaction_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_payable_id` FOREIGN KEY (`payable_id`) REFERENCES `vibe_ngo_v1`.`finance`.`payable`(`payable_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_ngo_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_receivable_id` FOREIGN KEY (`receivable_id`) REFERENCES `vibe_ngo_v1`.`finance`.`receivable`(`receivable_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_nicra_rate_id` FOREIGN KEY (`nicra_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`nicra_rate`(`nicra_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_target_cost_center_id` FOREIGN KEY (`target_cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_target_finance_fund_id` FOREIGN KEY (`target_finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ADD CONSTRAINT `fk_finance_exchange_rate_from_exchange_rate_id` FOREIGN KEY (`from_exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ADD CONSTRAINT `fk_finance_exchange_rate_primary_superseded_by_rate_exchange_rate_id` FOREIGN KEY (`primary_superseded_by_rate_exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ADD CONSTRAINT `fk_finance_exchange_rate_to_exchange_rate_id` FOREIGN KEY (`to_exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ADD CONSTRAINT `fk_finance_exchange_rate_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ADD CONSTRAINT `fk_finance_fund_compliance_tracking_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_budget_version_id` FOREIGN KEY (`budget_version_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_version`(`budget_version_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_fiscal_prior_year_period_id` FOREIGN KEY (`fiscal_prior_year_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_primary_prior_fiscal_period_id` FOREIGN KEY (`primary_prior_fiscal_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_rerun_of_payment_run_id` FOREIGN KEY (`rerun_of_payment_run_id`) REFERENCES `vibe_ngo_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_reversal_bank_transaction_id` FOREIGN KEY (`reversal_bank_transaction_id`) REFERENCES `vibe_ngo_v1`.`finance`.`bank_transaction`(`bank_transaction_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_parent_version_id` FOREIGN KEY (`parent_version_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_version`(`budget_version_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_prior_budget_version_id` FOREIGN KEY (`prior_budget_version_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_version`(`budget_version_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_face_form` ADD CONSTRAINT `fk_finance_finance_face_form_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `vibe_ngo_v1`.`finance`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_face_form` ADD CONSTRAINT `fk_finance_finance_face_form_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`finance` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`finance` SET TAGS ('pii_domain' = 'finance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_subdomain' = 'fund_management');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_ssot_scope' = 'finance_fund_accounting');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_ssot_owner' = 'finance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_ssot_boundary' = 'accounting_fund');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_disambiguated_from' = 'donor.donor_fund');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ALTER COLUMN `fund_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ALTER COLUMN `manager_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` SET TAGS ('pii_subdomain' = 'fund_management');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `country_id` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `tertiary_cost_approved_by_user_user_account_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `activity_type` SET TAGS ('pii_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `budget_currency_code` SET TAGS ('pii_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('pii_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('pii_value_regex' = 'production|service|administrative|auxiliary|project|temporary');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('pii_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('pii_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('pii_value_regex' = 'direct|proportional|headcount|square_footage|activity_based|not_allocated');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('pii_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|closed|pending_activation');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('pii_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('pii_value_regex' = 'program|administrative|fundraising|general_and_administrative|mission_support|field_operations');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `department` SET TAGS ('pii_business_glossary_term' = 'Department');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('pii_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `functional_expense_classification` SET TAGS ('pii_business_glossary_term' = 'Functional Expense Classification');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `functional_expense_classification` SET TAGS ('pii_value_regex' = 'program_services|management_and_general|fundraising|membership_development');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `fund_restriction_type` SET TAGS ('pii_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `fund_restriction_type` SET TAGS ('pii_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `indirect_cost_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Eligible Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `nicra_base_category` SET TAGS ('pii_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Base Category');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `nicra_base_category` SET TAGS ('pii_value_regex' = 'modified_total_direct_costs|direct_salaries_and_wages|total_direct_costs|other|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center` SET TAGS ('pii_business_glossary_term' = 'Profit Center');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `program_area` SET TAGS ('pii_business_glossary_term' = 'Program Area');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ALTER COLUMN `year_to_date_actual_amount` SET TAGS ('pii_business_glossary_term' = 'Year-to-Date (YTD) Actual Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_description` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('pii_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_owner` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Owner');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('pii_value_regex' = 'active|inactive|blocked|closed');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('pii_value_regex' = 'asset|liability|net_asset|revenue|expense');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `budget_control_flag` SET TAGS ('pii_business_glossary_term' = 'Budget Control Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `coa_structure_code` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts (CoA) Structure Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('pii_business_glossary_term' = 'Consolidation General Ledger (GL) Account Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `cost_allocation_base_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Base Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `dac_sector_code` SET TAGS ('pii_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `donor_restricted_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Restricted Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `external_reporting_code` SET TAGS ('pii_business_glossary_term' = 'External Reporting Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `financial_statement_classification` SET TAGS ('pii_business_glossary_term' = 'Financial Statement Classification');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `financial_statement_classification` SET TAGS ('pii_value_regex' = 'balance_sheet|statement_of_activities|statement_of_functional_expenses|statement_of_cash_flows|off_balance_sheet');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `functional_expense_category` SET TAGS ('pii_business_glossary_term' = 'Functional Expense Category');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `functional_expense_category` SET TAGS ('pii_value_regex' = 'program|management_general|fundraising|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `fund_restriction_class` SET TAGS ('pii_business_glossary_term' = 'Fund Restriction Class');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `fund_restriction_class` SET TAGS ('pii_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `grant_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Grant Eligible Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts (CoA) Hierarchy Level');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `indirect_cost_pool_flag` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Pool Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `last_posting_date` SET TAGS ('pii_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `natural_expense_classification` SET TAGS ('pii_business_glossary_term' = 'Natural Expense Classification');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `normal_balance_indicator` SET TAGS ('pii_business_glossary_term' = 'Normal Balance Indicator');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `posting_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Posting Eligible Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `program_service_code` SET TAGS ('pii_business_glossary_term' = 'Program Service Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_flag` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `sdg_alignment_code` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `tax_relevance_indicator` SET TAGS ('pii_business_glossary_term' = 'Tax Relevance Indicator');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `tax_relevance_indicator` SET TAGS ('pii_value_regex' = 'taxable|non_taxable|exempt|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `unrelated_business_income_flag` SET TAGS ('pii_business_glossary_term' = 'Unrelated Business Income (UBI) Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ALTER COLUMN `unrelated_business_income_flag` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `distribution_event_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `field_deployment_id` SET TAGS ('pii_business_glossary_term' = 'Deployment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_functional_currency_code` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Posting User Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `user_account_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_created_by_user_user_account_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_created_by_user_user_account_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `wash_intervention_id` SET TAGS ('pii_business_glossary_term' = 'Wash Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `audit_trail_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('pii_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('pii_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('pii_value_regex' = 'original|reversal|accrual|allocation|reclassification|adjustment');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_description` SET TAGS ('pii_business_glossary_term' = 'Entry Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('pii_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `is_adjustment` SET TAGS ('pii_business_glossary_term' = 'Adjustment Indicator');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `is_inter_company` SET TAGS ('pii_business_glossary_term' = 'Inter-Company Indicator');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('pii_business_glossary_term' = 'Ledger Group');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('pii_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('pii_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('pii_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('pii_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `original_line_journal_entry_line_id` SET TAGS ('pii_business_glossary_term' = 'Original Line ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `allowable_cost_flag` SET TAGS ('pii_business_glossary_term' = 'Allowable Cost Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|posted');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `credit_amount` SET TAGS ('pii_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_amount` SET TAGS ('pii_business_glossary_term' = 'Debit Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `direct_cost_flag` SET TAGS ('pii_business_glossary_term' = 'Direct Cost Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `donor_restriction_type` SET TAGS ('pii_business_glossary_term' = 'Donor Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `donor_restriction_type` SET TAGS ('pii_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_expense_category` SET TAGS ('pii_business_glossary_term' = 'Functional Expense Category');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_expense_category` SET TAGS ('pii_value_regex' = 'program_services|management_and_general|fundraising');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `intercompany_flag` SET TAGS ('pii_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `invoice_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('pii_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `natural_account_classification` SET TAGS ('pii_business_glossary_term' = 'Natural Account Classification');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_reference` SET TAGS ('pii_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('pii_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `program_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `source_document_reference` SET TAGS ('pii_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` SET TAGS ('pii_subdomain' = 'budget_control');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Donor Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `nicra_rate_id` SET TAGS ('pii_business_glossary_term' = 'Finance Nicra Rate Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Award ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `approved_modifications_count` SET TAGS ('pii_business_glossary_term' = 'Approved Modifications Count');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `approving_authority` SET TAGS ('pii_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `award_ceiling_amount` SET TAGS ('pii_business_glossary_term' = 'Award Ceiling Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('pii_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('pii_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `burn_rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Burn Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `budget_code` SET TAGS ('pii_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `cost_share_requirement_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Share Requirement Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `direct_cost_budget` SET TAGS ('pii_business_glossary_term' = 'Direct Cost Budget');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi-annually|annually|upon_request');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `icr_rate_applied` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate (ICR) Applied');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `indirect_cost_budget` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Budget');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `last_modification_date` SET TAGS ('pii_business_glossary_term' = 'Last Modification Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `owner` SET TAGS ('pii_business_glossary_term' = 'Budget Owner');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `prior_approval_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Prior Approval Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `program_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `total_actual_expenditure` SET TAGS ('pii_business_glossary_term' = 'Total Actual Expenditure');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `total_approved_amount` SET TAGS ('pii_business_glossary_term' = 'Total Approved Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ALTER COLUMN `total_variance_amount` SET TAGS ('pii_business_glossary_term' = 'Total Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` SET TAGS ('pii_subdomain' = 'budget_control');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `activity_code` SET TAGS ('pii_business_glossary_term' = 'Activity Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `activity_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('pii_value_regex' = 'direct|fte|square_footage|headcount|usage|other');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Budget Line Approval Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('pii_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `budget_narrative` SET TAGS ('pii_business_glossary_term' = 'Budget Line Narrative');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `budget_period_type` SET TAGS ('pii_business_glossary_term' = 'Budget Period Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `cost_share_source` SET TAGS ('pii_business_glossary_term' = 'Cost Share Source');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `cost_share_source` SET TAGS ('pii_value_regex' = 'organizational|third_party|in_kind|cash');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `cost_type` SET TAGS ('pii_business_glossary_term' = 'Cost Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `cost_type` SET TAGS ('pii_value_regex' = 'direct|indirect|shared');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `donor_budget_category` SET TAGS ('pii_business_glossary_term' = 'Donor Budget Category');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `expense_category` SET TAGS ('pii_business_glossary_term' = 'Expense Category');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `is_allowable` SET TAGS ('pii_business_glossary_term' = 'Is Allowable Cost');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `is_cost_share` SET TAGS ('pii_business_glossary_term' = 'Is Cost Share');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `original_amount` SET TAGS ('pii_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `program_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Budget Line Quantity');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `revised_amount` SET TAGS ('pii_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Budget Line Revision Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ALTER COLUMN `unit_description` SET TAGS ('pii_business_glossary_term' = 'Unit Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` SET TAGS ('pii_subdomain' = 'payables_processing');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `payable_id` SET TAGS ('pii_business_glossary_term' = 'Payable Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `distribution_event_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `goods_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `payment_run_id` SET TAGS ('pii_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `sanctions_screening_id` SET TAGS ('pii_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `clearing_document_number` SET TAGS ('pii_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `dispute_date` SET TAGS ('pii_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `functional_currency_amount` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `invoice_description` SET TAGS ('pii_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `invoice_gross_amount` SET TAGS ('pii_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `invoice_net_amount` SET TAGS ('pii_business_glossary_term' = 'Invoice Net Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `invoice_received_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `is_grant_eligible` SET TAGS ('pii_business_glossary_term' = 'Is Grant Eligible');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `is_restricted_fund` SET TAGS ('pii_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `payment_document_number` SET TAGS ('pii_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_value_regex' = 'matched|unmatched|partially_matched|not_applicable|override');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` SET TAGS ('pii_subdomain' = 'payables_processing');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payable_payment_id` SET TAGS ('pii_business_glossary_term' = 'Payable Payment ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `bank_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Bank Transaction ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `bank_transaction_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `country_id` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payable_id` SET TAGS ('pii_business_glossary_term' = 'Payable Invoice Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_run_id` SET TAGS ('pii_business_glossary_term' = 'Payment Run Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `activity_code` SET TAGS ('pii_business_glossary_term' = 'Activity Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Payment Approval Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `clearing_date` SET TAGS ('pii_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('pii_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `is_grant_funded` SET TAGS ('pii_business_glossary_term' = 'Is Grant Funded');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `is_indirect_cost` SET TAGS ('pii_business_glossary_term' = 'Is Indirect Cost');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `is_restricted_fund` SET TAGS ('pii_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('pii_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_description` SET TAGS ('pii_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_document_number` SET TAGS ('pii_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_reference` SET TAGS ('pii_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` SET TAGS ('pii_subdomain' = 'payables_processing');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `receivable_id` SET TAGS ('pii_business_glossary_term' = 'Receivable Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `aging_days` SET TAGS ('pii_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `allowance_for_doubtful_accounts` SET TAGS ('pii_business_glossary_term' = 'Allowance for Doubtful Accounts');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `bank_account_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `bank_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_email` SET TAGS ('pii_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_name` SET TAGS ('pii_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `billing_description` SET TAGS ('pii_business_glossary_term' = 'Billing Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `clearing_document_reference` SET TAGS ('pii_business_glossary_term' = 'Clearing Document Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `collection_status` SET TAGS ('pii_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `collection_status` SET TAGS ('pii_value_regex' = 'open|partially_collected|collected|written_off|disputed|under_review');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `deposit_confirmation_number` SET TAGS ('pii_business_glossary_term' = 'Deposit Confirmation Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `dispute_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `functional_currency_amount` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `invoice_amount` SET TAGS ('pii_business_glossary_term' = 'Invoice Total Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `invoice_delivery_method` SET TAGS ('pii_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `invoice_delivery_method` SET TAGS ('pii_value_regex' = 'email|postal_mail|electronic_portal|fax|hand_delivery');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `invoice_sent_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Sent Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `last_reminder_date` SET TAGS ('pii_business_glossary_term' = 'Last Payment Reminder Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `outstanding_balance` SET TAGS ('pii_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Payment Receipt Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `receipt_document_number` SET TAGS ('pii_business_glossary_term' = 'Receipt Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `receipt_method` SET TAGS ('pii_business_glossary_term' = 'Payment Receipt Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `receipt_method` SET TAGS ('pii_value_regex' = 'wire_transfer|check|ach|online_payment|credit_card|cash');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `revenue_recognition_date` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `write_off_amount` SET TAGS ('pii_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `write_off_date` SET TAGS ('pii_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ALTER COLUMN `write_off_reason` SET TAGS ('pii_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` SET TAGS ('pii_subdomain' = 'payables_processing');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receivable_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Receivable Receipt ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Receipt Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receivable_id` SET TAGS ('pii_business_glossary_term' = 'Receivable Invoice Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `clearing_document_number` SET TAGS ('pii_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `deposit_confirmation_number` SET TAGS ('pii_business_glossary_term' = 'Deposit Confirmation Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `deposit_date` SET TAGS ('pii_business_glossary_term' = 'Deposit Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `donor_restriction_purpose` SET TAGS ('pii_business_glossary_term' = 'Donor Restriction Purpose');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `functional_currency_amount` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `gl_posting_reference` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Posting Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `grant_drawdown_request_number` SET TAGS ('pii_business_glossary_term' = 'Grant Drawdown Request Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `is_in_kind_conversion` SET TAGS ('pii_business_glossary_term' = 'Is In-Kind Conversion');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `is_matching_gift` SET TAGS ('pii_business_glossary_term' = 'Is Matching Gift');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `is_refund` SET TAGS ('pii_business_glossary_term' = 'Is Refund');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Receipt Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `payer_reference` SET TAGS ('pii_business_glossary_term' = 'Payer Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_amount` SET TAGS ('pii_business_glossary_term' = 'Receipt Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_channel` SET TAGS ('pii_business_glossary_term' = 'Receipt Channel');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_channel` SET TAGS ('pii_value_regex' = 'bank_transfer|mail|online_portal|mobile_app|in_person|third_party_processor');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_document_number` SET TAGS ('pii_business_glossary_term' = 'Receipt Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_document_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_method` SET TAGS ('pii_business_glossary_term' = 'Receipt Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_status` SET TAGS ('pii_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_status` SET TAGS ('pii_value_regex' = 'draft|posted|cleared|reversed|voided|reconciled');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|reconciled|discrepancy|under_review');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `restriction_type` SET TAGS ('pii_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `restriction_type` SET TAGS ('pii_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `revenue_recognition_date` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ALTER COLUMN `wire_transfer_reference` SET TAGS ('pii_business_glossary_term' = 'Wire Transfer Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` SET TAGS ('pii_subdomain' = 'budget_control');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `grant_budget_id` SET TAGS ('pii_business_glossary_term' = 'Grant Budget Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Budget Manager Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `staff_member_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `staff_member_id` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `approved_modification_count` SET TAGS ('pii_business_glossary_term' = 'Approved Modification Count');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_approval_date` SET TAGS ('pii_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_category` SET TAGS ('pii_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_closeout_date` SET TAGS ('pii_business_glossary_term' = 'Budget Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_code` SET TAGS ('pii_business_glossary_term' = 'Grant Budget Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_name` SET TAGS ('pii_business_glossary_term' = 'Grant Budget Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_narrative` SET TAGS ('pii_business_glossary_term' = 'Budget Narrative');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_notes` SET TAGS ('pii_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_status` SET TAGS ('pii_business_glossary_term' = 'Grant Budget Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_submission_date` SET TAGS ('pii_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `budget_version_number` SET TAGS ('pii_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `compliance_framework` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `cost_share_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Share Requirement Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `direct_cost_budget` SET TAGS ('pii_business_glossary_term' = 'Direct Cost Budget');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `donor_reference_number` SET TAGS ('pii_business_glossary_term' = 'Donor Reference Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `icr_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `indirect_cost_budget` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Budget');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `is_multi_year` SET TAGS ('pii_business_glossary_term' = 'Multi-Year Budget Indicator');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `last_modification_date` SET TAGS ('pii_business_glossary_term' = 'Last Modification Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `nicra_rate` SET TAGS ('pii_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `total_award_amount` SET TAGS ('pii_business_glossary_term' = 'Total Award Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` SET TAGS ('pii_subdomain' = 'budget_control');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `nicra_rate_id` SET TAGS ('pii_business_glossary_term' = 'Nicra Rate Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `nicra_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Nicra Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `administrative_rate` SET TAGS ('pii_business_glossary_term' = 'Facilities and Administration (F&A) Administrative Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'NICRA Agreement Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'NICRA Agreement Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'NICRA Approval Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `audit_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `audit_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `carryforward_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Carryforward Adjustment Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `carryforward_adjustment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `cognizant_agency_code` SET TAGS ('pii_business_glossary_term' = 'Cognizant Federal Agency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `cognizant_agency_name` SET TAGS ('pii_business_glossary_term' = 'Cognizant Federal Agency Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `cognizant_agency_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `cognizant_agency_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `cost_base_type` SET TAGS ('pii_business_glossary_term' = 'Cost Base Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `cost_base_type` SET TAGS ('pii_value_regex' = 'modified_total_direct_costs|total_direct_costs|salaries_and_wages|direct_salaries|other');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `de_minimis_rate_flag` SET TAGS ('pii_business_glossary_term' = 'De Minimis Rate Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `document_reference_url` SET TAGS ('pii_business_glossary_term' = 'NICRA Document Reference URL');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'NICRA Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'NICRA Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `facilities_rate` SET TAGS ('pii_business_glossary_term' = 'Facilities and Administration (F&A) Facilities Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `fringe_benefit_rate` SET TAGS ('pii_business_glossary_term' = 'Fringe Benefit Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `last_modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `negotiation_date` SET TAGS ('pii_business_glossary_term' = 'NICRA Negotiation Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `organizational_unit_code` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `organizational_unit_name` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `organizational_unit_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `organizational_unit_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `rate_category` SET TAGS ('pii_business_glossary_term' = 'NICRA Rate Category');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `rate_type` SET TAGS ('pii_business_glossary_term' = 'NICRA Rate Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `rate_type` SET TAGS ('pii_value_regex' = 'predetermined|fixed|provisional|final');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `special_remarks` SET TAGS ('pii_business_glossary_term' = 'NICRA Special Remarks');
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ALTER COLUMN `successor_agreement_number` SET TAGS ('pii_business_glossary_term' = 'Successor NICRA Agreement Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` SET TAGS ('pii_subdomain' = 'budget_control');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `distribution_event_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `field_team_id` SET TAGS ('pii_business_glossary_term' = 'Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `nicra_rate_id` SET TAGS ('pii_business_glossary_term' = 'Finance Nicra Rate Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `nicra_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Nicra Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Source Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Source Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `target_cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Target Cost Center Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `target_cost_center_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `target_finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Target Finance Fund Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `target_finance_fund_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('pii_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('pii_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_quantity` SET TAGS ('pii_business_glossary_term' = 'Allocation Basis Quantity');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_unit` SET TAGS ('pii_business_glossary_term' = 'Allocation Basis Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('pii_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_document_number` SET TAGS ('pii_business_glossary_term' = 'Allocation Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_document_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('pii_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('pii_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rate` SET TAGS ('pii_business_glossary_term' = 'Allocation Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|approved|posted|reversed|rejected');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('pii_value_regex' = 'direct|indirect|facilities|administration|shared_services|overhead');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_pool` SET TAGS ('pii_business_glossary_term' = 'Cost Pool');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `is_fa_cost` SET TAGS ('pii_business_glossary_term' = 'Is Facilities and Administration (F&A) Cost');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `is_restricted_fund` SET TAGS ('pii_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_date` SET TAGS ('pii_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` SET TAGS ('pii_subdomain' = 'treasury_reconciliation');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `country_id` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Award ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('pii_value_regex' = 'active|dormant|closed|frozen|pending_activation');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('pii_business_glossary_term' = 'Available Balance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_code` SET TAGS ('pii_business_glossary_term' = 'Bank Branch Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_business_glossary_term' = 'Bank Contact Email');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_business_glossary_term' = 'Bank Contact Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Bank Contact Phone');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `closing_date` SET TAGS ('pii_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('pii_business_glossary_term' = 'Current Balance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `donor_name` SET TAGS ('pii_business_glossary_term' = 'Donor Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `donor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `donor_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `donor_name` SET TAGS ('pii_person_type' = 'person_name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `donor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `donor_name` SET TAGS ('pii_masking_policy' = 'mask_non_prod');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `donor_name` SET TAGS ('pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `donor_restriction_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Restriction Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `interest_bearing_flag` SET TAGS ('pii_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('pii_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `last_transaction_date` SET TAGS ('pii_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_requirement` SET TAGS ('pii_business_glossary_term' = 'Minimum Balance Requirement');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `office_location` SET TAGS ('pii_business_glossary_term' = 'Office Location');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `office_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `opening_date` SET TAGS ('pii_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('pii_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `overdraft_protection_flag` SET TAGS ('pii_business_glossary_term' = 'Overdraft Protection Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_requirement` SET TAGS ('pii_business_glossary_term' = 'Signatory Requirement');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_requirement` SET TAGS ('pii_value_regex' = 'single|dual|triple|board_approval');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Signatory Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('pii_business_glossary_term' = 'SWIFT Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('pii_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_subdomain' = 'treasury_reconciliation');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_business_glossary_term' = 'Bank Reconciliation ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `internal_review_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Reconciled By User ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `tertiary_bank_approved_by_user_user_account_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance` SET TAGS ('pii_business_glossary_term' = 'Adjusted Bank Balance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_gl_balance` SET TAGS ('pii_business_glossary_term' = 'Adjusted General Ledger (GL) Balance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `exception_count` SET TAGS ('pii_business_glossary_term' = 'Exception Count');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `gl_book_balance` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Book Balance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `is_restricted_fund` SET TAGS ('pii_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_checks_amount` SET TAGS ('pii_business_glossary_term' = 'Outstanding Checks Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_deposits_amount` SET TAGS ('pii_business_glossary_term' = 'Outstanding Deposits Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciled_by` SET TAGS ('pii_business_glossary_term' = 'Reconciled By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_document_number` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Document Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_notes` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'in_progress|reconciled|approved|rejected|pending_review|reopened');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciling_items_count` SET TAGS ('pii_business_glossary_term' = 'Reconciling Items Count');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_closing_balance` SET TAGS ('pii_business_glossary_term' = 'Statement Closing Balance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('pii_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_opening_balance` SET TAGS ('pii_business_glossary_term' = 'Statement Opening Balance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `unrecorded_bank_charges_amount` SET TAGS ('pii_business_glossary_term' = 'Unrecorded Bank Charges Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `unrecorded_bank_credits_amount` SET TAGS ('pii_business_glossary_term' = 'Unrecorded Bank Credits Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `from_exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'From Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `from_exchange_rate_id` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `primary_superseded_by_rate_exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Rate ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `to_exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'To Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `to_exchange_rate_id` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `approved_by_user` SET TAGS ('pii_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `donor_required_rate_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Required Rate Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `inverse_rate_value` SET TAGS ('pii_business_glossary_term' = 'Inverse Exchange Rate Value');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `last_modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `mid_market_rate_flag` SET TAGS ('pii_business_glossary_term' = 'Mid-Market Rate Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `rate_calculation_method` SET TAGS ('pii_business_glossary_term' = 'Rate Calculation Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `rate_publication_timestamp` SET TAGS ('pii_business_glossary_term' = 'Rate Publication Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `rate_source` SET TAGS ('pii_business_glossary_term' = 'Rate Source');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `rate_source_reference` SET TAGS ('pii_business_glossary_term' = 'Rate Source Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `rate_status` SET TAGS ('pii_business_glossary_term' = 'Rate Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `rate_status` SET TAGS ('pii_value_regex' = 'active|inactive|superseded|pending|draft');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `rate_type` SET TAGS ('pii_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `rate_type` SET TAGS ('pii_value_regex' = 'spot|average|budget|closing|forward|historical');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `revaluation_rate_flag` SET TAGS ('pii_business_glossary_term' = 'Revaluation Rate Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `spread_percentage` SET TAGS ('pii_business_glossary_term' = 'Spread Percentage');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `un_operational_rate_flag` SET TAGS ('pii_business_glossary_term' = 'United Nations (UN) Operational Rate Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `usage_context` SET TAGS ('pii_business_glossary_term' = 'Usage Context');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `value` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate Value');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `variance_from_prior_rate` SET TAGS ('pii_business_glossary_term' = 'Variance from Prior Rate');
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ALTER COLUMN `variance_percentage` SET TAGS ('pii_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` SET TAGS ('pii_subdomain' = 'treasury_reconciliation');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` SET TAGS ('pii_association_edges' = 'finance.finance_fund,compliance.donor_requirement');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `fund_compliance_tracking_id` SET TAGS ('pii_business_glossary_term' = 'Fund Compliance Tracking ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Compliance Requirement ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund ID');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `last_modified_date` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `last_verification_date` SET TAGS ('pii_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `requirement_applicability_end_date` SET TAGS ('pii_business_glossary_term' = 'Requirement Applicability End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `requirement_applicability_start_date` SET TAGS ('pii_business_glossary_term' = 'Requirement Applicability Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `waiver_decision_date` SET TAGS ('pii_business_glossary_term' = 'Waiver Decision Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `waiver_request_date` SET TAGS ('pii_business_glossary_term' = 'Waiver Request Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ALTER COLUMN `waiver_status` SET TAGS ('pii_business_glossary_term' = 'Waiver Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `budget_version_id` SET TAGS ('pii_business_glossary_term' = 'Budget Version Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_prior_year_period_id` SET TAGS ('pii_business_glossary_term' = 'Prior Year Period Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `primary_prior_fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Prior Fiscal Period Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `primary_prior_fiscal_period_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `audit_required_flag` SET TAGS ('pii_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `closed_date` SET TAGS ('pii_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `days_in_period` SET TAGS ('pii_business_glossary_term' = 'Days In Period');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `exchange_rate_date` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `is_adjustment_period` SET TAGS ('pii_business_glossary_term' = 'Is Adjustment Period');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `is_year_end_period` SET TAGS ('pii_business_glossary_term' = 'Is Year End Period');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `locked_date` SET TAGS ('pii_business_glossary_term' = 'Locked Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `opened_date` SET TAGS ('pii_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_code` SET TAGS ('pii_business_glossary_term' = 'Period Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_number` SET TAGS ('pii_business_glossary_term' = 'Period Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('pii_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('pii_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `quarter_number` SET TAGS ('pii_business_glossary_term' = 'Quarter Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`fiscal_period` ALTER COLUMN `working_days_in_period` SET TAGS ('pii_business_glossary_term' = 'Working Days In Period');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` SET TAGS ('pii_subdomain' = 'payables_processing');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('pii_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `payment_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `payment_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `payment_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `rerun_of_payment_run_id` SET TAGS ('pii_business_glossary_term' = 'Rerun Of Payment Run Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `rerun_of_payment_run_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `batch_reference_number` SET TAGS ('pii_business_glossary_term' = 'Batch Reference Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `completed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `error_message` SET TAGS ('pii_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `execution_timestamp` SET TAGS ('pii_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `failed_amount` SET TAGS ('pii_business_glossary_term' = 'Failed Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `failed_payment_count` SET TAGS ('pii_business_glossary_term' = 'Failed Payment Count');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `is_recurring` SET TAGS ('pii_business_glossary_term' = 'Is Recurring');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `recurrence_pattern` SET TAGS ('pii_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `run_number` SET TAGS ('pii_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `run_type` SET TAGS ('pii_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `successful_amount` SET TAGS ('pii_business_glossary_term' = 'Successful Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `successful_payment_count` SET TAGS ('pii_business_glossary_term' = 'Successful Payment Count');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ALTER COLUMN `total_payment_count` SET TAGS ('pii_business_glossary_term' = 'Total Payment Count');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` SET TAGS ('pii_subdomain' = 'treasury_reconciliation');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `bank_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Bank Transaction Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Created By User User Account Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `bank_modified_by_user_user_account_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User User Account Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `bank_user_account_id` SET TAGS ('pii_business_glossary_term' = 'User Account Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `component_id` SET TAGS ('pii_business_glossary_term' = 'Component Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `reversal_bank_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Reversal Bank Transaction Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `reversal_bank_transaction_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `bank_statement_date` SET TAGS ('pii_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `counterparty_account_number` SET TAGS ('pii_business_glossary_term' = 'Counterparty Account Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `counterparty_account_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `counterparty_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `counterparty_bank_name` SET TAGS ('pii_business_glossary_term' = 'Counterparty Bank Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `counterparty_bank_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `counterparty_bank_name` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `counterparty_routing_number` SET TAGS ('pii_business_glossary_term' = 'Counterparty Routing Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `counterparty_routing_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `counterparty_routing_number` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `credit_amount` SET TAGS ('pii_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `debit_amount` SET TAGS ('pii_business_glossary_term' = 'Debit Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `is_indirect_cost` SET TAGS ('pii_business_glossary_term' = 'Is Indirect Cost');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `is_restricted_fund` SET TAGS ('pii_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `memo` SET TAGS ('pii_business_glossary_term' = 'Memo');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payee_name` SET TAGS ('pii_business_glossary_term' = 'Payee Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payee_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payee_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payee_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payer_name` SET TAGS ('pii_business_glossary_term' = 'Payer Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payer_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payer_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `restriction_type` SET TAGS ('pii_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `running_balance` SET TAGS ('pii_business_glossary_term' = 'Running Balance');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('pii_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `transaction_date` SET TAGS ('pii_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `transaction_description` SET TAGS ('pii_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ALTER COLUMN `value_date` SET TAGS ('pii_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` SET TAGS ('pii_subdomain' = 'budget_control');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` SET TAGS ('pii_accounting_framework' = 'IPSAS');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` SET TAGS ('pii_US_GAAP_ASC_958' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` SET TAGS ('pii_Form_990' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `budget_version_id` SET TAGS ('pii_business_glossary_term' = 'Budget Version Identifier');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `exchange_rate_id` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Organization Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `parent_version_id` SET TAGS ('pii_business_glossary_term' = 'Parent Version Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `prior_budget_version_id` SET TAGS ('pii_business_glossary_term' = 'Prior Budget Version Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `prior_budget_version_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'Program Id');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `budget_version_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `expense_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Expense Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `is_baseline` SET TAGS ('pii_business_glossary_term' = 'Is Baseline');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `is_locked` SET TAGS ('pii_business_glossary_term' = 'Is Locked');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `locked_by` SET TAGS ('pii_business_glossary_term' = 'Locked By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `locked_date` SET TAGS ('pii_business_glossary_term' = 'Locked Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `revenue_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Revenue Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `budget_version_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `submitted_by` SET TAGS ('pii_business_glossary_term' = 'Submitted By');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `total_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `version_code` SET TAGS ('pii_business_glossary_term' = 'Version Code');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `version_name` SET TAGS ('pii_business_glossary_term' = 'Version Name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `version_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `version_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `version_sequence` SET TAGS ('pii_business_glossary_term' = 'Version Sequence');
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ALTER COLUMN `version_type` SET TAGS ('pii_business_glossary_term' = 'Version Type');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_face_form` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_face_form` SET TAGS ('pii_subdomain' = 'treasury_reconciliation');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_face_form` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_face_form` SET TAGS ('pii_hact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_face_form` ALTER COLUMN `certified_by_name` SET TAGS ('pii_type' = 'name');
