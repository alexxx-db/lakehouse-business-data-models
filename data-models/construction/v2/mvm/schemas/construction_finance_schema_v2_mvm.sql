-- Schema for Domain: finance | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-27 01:56:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`finance` COMMENT 'SSOT for all project and corporate financial data including job costing, budget vs. actual, GL/AP/AR entries, progress billing, revenue recognition (percentage of completion), cost codes, cost centers, WBS-linked budgets, EVM financial outputs (CPI), cash flow forecasting, P&L (Profit and Loss), and EBITDA reporting. Integrates with SAP S/4HANA and Viewpoint Vista for construction accounting and IFRS/GAAP compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`cost_code` (
    `cost_code_id` BIGINT COMMENT 'Primary key for cost_code',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: cost_code has a gl_account_code STRING column but no FK to the gl_account master. In construction accounting, each cost code maps to a specific GL account for financial posting (e.g., CSI division 03 ',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether cost postings to this code require additional approval workflow beyond standard posting authorization. Used for high-risk or high-value cost categories.',
    `budget_allocation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this cost code can have budget allocated to it. Typically True for leaf-level codes and False for parent/rollup codes.',
    `capitalization_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether costs posted to this code should be capitalized as assets on the balance sheet rather than expensed. Critical for Engineering Procurement and Construction (EPC) projects and asset-intensive developments.',
    `cost_category` STRING COMMENT 'The primary classification of the cost code into major expenditure categories. Used for high-level financial reporting and Profit and Loss (P&L) analysis.. Valid values are `labor|material|equipment|subcontract|overhead|indirect`',
    `cost_code` STRING COMMENT 'The unique alphanumeric cost code identifier used across all project accounting systems. This is the externally-known business identifier used in SAP S/4HANA Project Systems and Viewpoint Vista for budget allocation and actual cost posting.. Valid values are `^[A-Z0-9]{2,20}$`',
    `cost_code_status` STRING COMMENT 'Current lifecycle status of the cost code. Active codes are available for budget allocation and cost posting. Inactive codes are retained for historical reporting but cannot be used for new transactions. Deprecated codes have been superseded by newer classifications.. Valid values are `active|inactive|deprecated|pending_approval`',
    `cost_posting_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether actual costs can be posted directly to this cost code. Typically True for detailed codes and False for summary/rollup codes.',
    `cost_type` STRING COMMENT 'Classification indicating whether the cost is directly attributable to a specific project deliverable (direct) or allocated across multiple activities (indirect/overhead). Critical for job costing and Earned Value Management (EVM) calculations.. Valid values are `direct|indirect|overhead|general_conditions`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost code record was first created in the system. Part of the standard audit trail for master data management.',
    `csi_division` STRING COMMENT 'The two-digit CSI MasterFormat division number (00-49) that this cost code maps to. Provides standardized alignment with construction specifications and Bill of Quantities (BOQ) structures.. Valid values are `^(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9])$`',
    `cost_code_description` STRING COMMENT 'Detailed description of the cost code explaining the scope of work, materials, or services covered by this classification. Provides additional context beyond the name for proper cost allocation.',
    `discipline_code` STRING COMMENT 'The engineering or construction discipline associated with this cost code (e.g., CIVIL, STRUCT, MECH, ELEC, INST for Mechanical Electrical Plumbing (MEP) disciplines). Used for discipline-specific cost tracking and resource planning.',
    `effective_end_date` DATE COMMENT 'The date after which this cost code is no longer active for new transactions. Null for currently active codes. Used for cost code retirement and historical reporting.',
    `effective_start_date` DATE COMMENT 'The date from which this cost code becomes active and available for use in budget allocation and cost posting. Supports time-based cost code structures and phased project implementations.',
    `evm_eligible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether costs posted to this code are included in Earned Value Management (EVM) calculations including Cost Performance Index (CPI) and Schedule Performance Index (SPI) metrics.',
    `external_reference_code` STRING COMMENT 'The unique identifier for this cost code in the source system (e.g., SAP S/4HANA Cost Element number, Viewpoint Vista Cost Code ID). Used for cross-system reconciliation and integration.',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person who last modified this cost code record. Used for change tracking and data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost code record was last modified. Part of the standard audit trail for master data management and change tracking.',
    `cost_code_level` STRING COMMENT 'The hierarchical level of this cost code within the Cost Breakdown Structure (CBS). Typically ranges from 1 (top-level category) to 4 (detailed line item). Level 1 might be Labor, Level 2 Structural Labor, Level 3 Steel Erection Labor.',
    `cost_code_name` STRING COMMENT 'The full descriptive name of the cost code providing human-readable identification of the cost category (e.g., Structural Steel Erection, Concrete Formwork Labor, Electrical Conduit Installation).',
    `notes` STRING COMMENT 'Free-text field for additional notes, usage guidelines, or special instructions related to this cost code. Provides context for proper application and interpretation.',
    `parent_cost_code` STRING COMMENT 'The cost code of the parent category in the hierarchical Cost Breakdown Structure (CBS). Null for top-level cost codes. Enables roll-up reporting and hierarchical budget analysis.',
    `rate_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the standard rate (e.g., USD, EUR, GBP). Required for multi-currency projects and international joint ventures.. Valid values are `^[A-Z]{3}$`',
    `revenue_recognition_method` STRING COMMENT 'The accounting method used for revenue recognition associated with this cost code. Percentage of completion is the most common method for construction projects under IFRS 15 and ASC 606.. Valid values are `percentage_of_completion|completed_contract|cost_to_cost|units_of_delivery`',
    `source_system_code` STRING COMMENT 'Identifier of the operational system of record from which this cost code was originally sourced or is mastered. Supports multi-system integration and data lineage tracking.. Valid values are `SAP_S4HANA|VIEWPOINT_VISTA|PRIMAVERA_P6|PROCORE|MANUAL`',
    `standard_rate` DECIMAL(18,2) COMMENT 'The standard cost rate per unit of measure for this cost code. Used for budget estimation, variance analysis, and Earned Value Management (EVM) calculations. May represent labor rate per hour, material cost per unit, or equipment rate per day.',
    `tax_treatment_code` STRING COMMENT 'Code indicating the tax treatment for costs posted to this cost code (e.g., TAXABLE, EXEMPT, ZERO_RATED). Used for Value Added Tax (VAT) and sales tax compliance in multi-jurisdiction projects.',
    `unit_of_measure` STRING COMMENT 'The standard unit of measure for quantity tracking associated with this cost code (e.g., hours for labor, cubic yards for concrete, linear feet for piping, each for equipment). Used for productivity analysis and Material Take-Off (MTO) reconciliation.',
    `wbs_compatible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this cost code can be directly linked to Work Breakdown Structure (WBS) elements in Oracle Primavera P6 and SAP S/4HANA Project Systems for integrated schedule and cost management.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this cost code record in the system. Used for audit trail and data governance.',
    CONSTRAINT pk_cost_code PRIMARY KEY(`cost_code_id`)
) COMMENT 'Reference master for the construction cost coding taxonomy used to classify all project expenditures into standardized categories. Defines the hierarchical cost breakdown structure (CBS) — typically 2-4 levels deep — covering labor, materials, equipment, subcontract, and overhead categories. Each cost code carries a unique identifier, description, parent code, level indicator, unit of measure for quantity tracking, standard rate (where applicable), and active/inactive status. Used across SAP S/4HANA Project Systems and Viewpoint Vista as the authoritative classification spine for budget allocation, actual cost posting, EVM reporting, and job cost analysis.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Primary key for cost_center',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Required for Cost Center Allocation Report per client, enabling profitability analysis by linking each cost center to the client account it serves.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: cost_center has a company_code STRING column but no FK to the company_code master. In SAP controlling (CO), every cost center belongs to exactly one company code (legal entity). This is a fundamental ',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the parent cost center in the organizational hierarchy. Enables roll-up reporting for regional, divisional, and corporate-level P&L (Profit and Loss) and EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) analysis. Nullable for top-level cost centers.',
    `allocation_method` STRING COMMENT 'The methodology used to allocate or distribute costs from this cost center to other cost objects (projects, WBS (Work Breakdown Structure) elements, or profit centers). Direct charge posts costs explicitly; activity-based uses cost drivers; headcount and square footage are common overhead allocation bases; revenue-based allocates proportionally to project revenue; none indicates no allocation (terminal cost center).. Valid values are `direct_charge|activity_based|headcount|square_footage|revenue_based|none`',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved annual or period budget allocated to this cost center. Used for budget vs. actual variance reporting, CPI (Cost Performance Index) calculation in EVM (Earned Value Management), and financial forecasting.',
    `budget_period` STRING COMMENT 'The time horizon for which the budget amount is defined. Annual budgets align with fiscal year planning; quarterly and monthly budgets support rolling forecasts; project lifecycle budgets span the duration of a construction project from NTP (Notice to Proceed) to handover.. Valid values are `annual|quarterly|monthly|project_lifecycle`',
    `business_area` STRING COMMENT 'The business segment or division to which this cost center is assigned (e.g., Infrastructure, Energy, Commercial, Residential). Used for segment reporting under IFRS 8 and internal divisional P&L (Profit and Loss) analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_category` STRING COMMENT 'Accounting classification of the cost center for financial treatment. Direct centers charge costs to specific projects or WBS (Work Breakdown Structure) elements; indirect centers allocate costs via overhead rates; overhead centers represent corporate G&A (General and Administrative); capitalized centers accumulate costs for asset creation; expensed centers flow directly to P&L (Profit and Loss).. Valid values are `direct|indirect|overhead|capitalized|expensed`',
    `cost_center_code` STRING COMMENT 'The externally-known alphanumeric code identifying the cost center in financial systems and reports. Used in SAP S/4HANA CO-CCA (Cost Center Accounting) for posting and reporting. Typically follows organizational coding standards (e.g., project-based, regional, functional).. Valid values are `^[A-Z0-9]{4,12}$`',
    `controlling_area` STRING COMMENT 'The SAP S/4HANA Controlling (CO) area to which this cost center belongs. Controlling areas represent organizational units for internal management accounting and can span multiple company codes. Used for cross-company cost center reporting and consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_group` STRING COMMENT 'A user-defined grouping or classification for aggregating related cost centers in reports (e.g., all regional offices, all project cost centers for a specific client, all MEP (Mechanical Electrical and Plumbing) cost centers). Used for flexible reporting hierarchies beyond the standard organizational structure.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active centers accept postings; inactive centers are temporarily disabled; planned centers are approved but not yet operational; closed centers are archived and no longer accept transactions; suspended centers are on hold pending review or restructuring.. Valid values are `active|inactive|planned|closed|suspended`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by its primary business function. Project cost centers track job-specific costs; regional offices track geographic operations; corporate overhead captures non-project administrative costs; shared services represent centralized functions (IT, HR, Finance); support functions include PMO (Project Management Office), procurement, and QA/QC (Quality Assurance/Quality Control); operational centers track site-level or equipment-based activities.. Valid values are `project|regional_office|corporate_overhead|shared_service|support_function|operational`',
    `cost_element_group` STRING COMMENT 'The primary cost element group or cost category that this cost center typically incurs (e.g., labor, materials, equipment, subcontractor, overhead). Used for cost structure analysis and variance reporting by cost type.',
    `created_by_user` STRING COMMENT 'The username or identifier of the system user who created this cost center record. Used for accountability, audit trails, and access control reviews.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system. Used for audit trails, data lineage tracking, and compliance with financial record-keeping regulations.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this cost centers budget and actuals are denominated (e.g., USD, EUR, GBP). Used for multi-currency consolidation and foreign exchange variance analysis.. Valid values are `^[A-Z]{3}$`',
    `cost_center_description` STRING COMMENT 'Extended free-text description providing additional context about the cost centers purpose, scope, and responsibilities. Used for documentation, audit trails, and onboarding new finance team members.',
    `functional_area` STRING COMMENT 'The primary functional discipline or department this cost center supports. Used for cross-project functional cost analysis, overhead allocation, and shared-service chargeback models. [ENUM-REF-CANDIDATE: engineering|procurement|construction|quality|safety|finance|hr|it|legal|admin — 10 candidates stripped; promote to reference product]',
    `hierarchy_level` STRING COMMENT 'The depth of this cost center in the organizational hierarchy tree. Level 1 represents corporate or top-level centers; higher numbers represent nested project, site, or functional centers. Used for drill-down reporting and aggregation logic.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether costs incurred in this cost center are billable to external clients or internal projects. True for project cost centers with reimbursable contracts; false for corporate overhead and non-billable support functions. Used for revenue recognition and progress billing logic.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the system user who last modified this cost center record. Used for change accountability, audit trails, and data quality investigations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was last updated. Used for change tracking, audit compliance, and data quality monitoring.',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether this cost center is locked for new postings. True when the cost center is under audit, pending closure, or frozen for period-end reporting. Used to enforce financial controls and prevent unauthorized transactions.',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center, used for human-readable identification in financial reports, dashboards, and P&L (Profit and Loss) statements.',
    `overhead_rate_percentage` DECIMAL(18,2) COMMENT 'The standard overhead rate (as a percentage) applied to direct costs posted to this cost center. Used for indirect cost allocation, GMP (Guaranteed Maximum Price) contract pricing, and full absorption costing. Nullable for cost centers that do not apply overhead rates.',
    `region_code` STRING COMMENT 'Three-letter code representing the geographic region or country where this cost center operates (e.g., USA, GBR, ARE). Used for regional P&L (Profit and Loss) reporting, tax jurisdiction mapping, and geographic segment analysis.. Valid values are `^[A-Z]{3}$`',
    `site_location` STRING COMMENT 'The physical site, office, or facility location associated with this cost center. Used for site-level cost tracking, field operations reporting, and HSE (Health Safety and Environment) cost allocation.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center becomes effective and can accept financial postings. Used for time-dependent cost center master data and period-based reporting.',
    `valid_to_date` DATE COMMENT 'The date until which this cost center remains effective. Nullable for open-ended cost centers. Used to manage cost center lifecycle, project closeout, and organizational restructuring.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational unit master representing financial responsibility centers within the construction enterprise — project cost centers, regional offices, corporate overhead centers, and shared-service centers. Maps to SAP S/4HANA cost center accounting (CO-CCA) and serves as the primary dimension for internal P&L reporting, overhead allocation, and EBITDA decomposition. Each cost center has a responsible manager, validity period, and hierarchy assignment.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Primary key for gl_account',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts framework to which this account belongs (e.g., Corporate COA, IFRS COA, Local Statutory COA).',
    `company_code_id` BIGINT COMMENT 'Reference to the company code (legal entity) to which this account belongs. Supports multi-entity chart of accounts.',
    `account_class` STRING COMMENT 'High-level classification indicating whether the account appears on the balance sheet, Profit and Loss (P&L) statement, or is a statistical (non-financial) account.. Valid values are `balance_sheet|profit_and_loss|statistical`',
    `account_group` STRING COMMENT 'Grouping code used to aggregate accounts for reporting and analysis (e.g., Direct Construction Costs, Overhead, Operating Expenses, Current Assets).',
    `account_name` STRING COMMENT 'The full descriptive name of the account (e.g., Construction Materials - Direct Costs, Accounts Payable - Trade, Revenue - EPC Contracts).',
    `account_number` STRING COMMENT 'The externally-known unique account number in the chart of accounts. Typically a 4-10 digit numeric code used in all financial postings and reports.. Valid values are `^[0-9]{4,10}$`',
    `account_short_name` STRING COMMENT 'Abbreviated name or label for the account used in condensed reports and user interfaces.',
    `account_status` STRING COMMENT 'Current lifecycle status of the account: active (in use), blocked (no new postings), closed (archived), or pending approval (awaiting activation).. Valid values are `active|blocked|closed|pending_approval`',
    `account_type` STRING COMMENT 'The fundamental financial statement category: asset, liability, equity, revenue, or expense. Determines balance sheet vs. Profit and Loss (P&L) classification.. Valid values are `asset|liability|equity|revenue|expense`',
    `alternative_account_number` STRING COMMENT 'Alternative or legacy account number used for cross-reference, migration mapping, or external reporting (e.g., statutory chart of accounts).',
    `balance_sheet_classification` STRING COMMENT 'Detailed balance sheet line item classification (e.g., Current Assets - Cash, Non-Current Liabilities - Long-Term Debt, Equity - Retained Earnings). Null for P&L accounts.',
    `cash_flow_classification` STRING COMMENT 'Classification for cash flow statement reporting: operating activities, investing activities, financing activities, or not applicable for non-cash accounts.. Valid values are `operating|investing|financing|not_applicable`',
    `consolidation_account_number` STRING COMMENT 'The corresponding account number in the group consolidation chart of accounts. Used for mapping local entity accounts to group reporting structure.',
    `cost_center_required_indicator` BOOLEAN COMMENT 'Flag indicating whether a cost center must be specified when posting to this account. Enforces cost allocation discipline.',
    `cost_element_category` STRING COMMENT 'Classification of the cost element: primary (direct posting from FI), secondary (internal allocation), revenue, or not applicable if not a cost element.. Valid values are `primary|secondary|revenue|not_applicable`',
    `cost_element_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is also a cost element in the controlling (CO) module, enabling integration with project costing and Work Breakdown Structure (WBS) budgets.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this account master record was first created in the system.',
    `currency_type` STRING COMMENT 'Indicates the currency perspective for this account: local (entity currency), group (consolidation currency), transaction (original currency), or project (project-specific currency).. Valid values are `local|group|transaction|project`',
    `field_status_group` STRING COMMENT 'Configuration key that controls which fields are required, optional, or suppressed when posting to this account (e.g., cost center, WBS, profit center).',
    `functional_area` STRING COMMENT 'Business function or division associated with the account (e.g., Project Operations, Corporate Overhead, Procurement, MEP Services). Used for segment reporting.',
    `line_item_display_indicator` BOOLEAN COMMENT 'Flag indicating whether individual line items (journal entries) are stored and can be displayed for this account. Required for detailed transaction analysis.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this account master record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this account master record was last modified.',
    `open_item_management_indicator` BOOLEAN COMMENT 'Flag indicating whether open item management is active for this account (e.g., for clearing transactions like AP/AR, advances, or accruals).',
    `planning_level` STRING COMMENT 'Indicates the level at which budgeting and planning are performed for this account (e.g., Corporate, Division, Project, Cost Center).',
    `posting_allowed_indicator` BOOLEAN COMMENT 'Flag indicating whether direct postings are allowed to this account. False for summary/control accounts that only receive automatic postings.',
    `profit_and_loss_classification` STRING COMMENT 'Detailed Profit and Loss (P&L) line item classification (e.g., Revenue - Construction Contracts, Cost of Sales - Direct Labor, Operating Expenses - General & Administrative). Null for balance sheet accounts.',
    `profit_center_required_indicator` BOOLEAN COMMENT 'Flag indicating whether a profit center must be specified when posting to this account. Supports segment profitability analysis.',
    `reconciliation_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a reconciliation account (subledger control account) for Accounts Payable (AP), Accounts Receivable (AR), or asset accounting.',
    `retained_earnings_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this is the retained earnings account used for year-end profit/loss transfer and equity rollforward.',
    `sort_key` STRING COMMENT 'Default sort key used for line item display and reporting (e.g., posting date, document number, reference). Controls how transactions are ordered.',
    `tax_category` STRING COMMENT 'Tax classification code indicating how this account is treated for tax purposes (e.g., Input Tax, Output Tax, Non-Taxable, Exempt). Used for VAT/GST reporting.',
    `tolerance_group` STRING COMMENT 'Tolerance group code that defines permissible payment differences, exchange rate variances, and rounding tolerances for this account.',
    `trading_partner_required_indicator` BOOLEAN COMMENT 'Flag indicating whether a trading partner (intercompany entity) must be specified when posting to this account. Used for intercompany eliminations.',
    `valid_from_date` DATE COMMENT 'The date from which this account is valid and available for posting. Supports time-dependent chart of accounts changes.',
    `valid_to_date` DATE COMMENT 'The date until which this account is valid. Null for accounts with no planned end date. Used for account retirement and chart of accounts evolution.',
    `wbs_element_required_indicator` BOOLEAN COMMENT 'Flag indicating whether a Work Breakdown Structure (WBS) element must be specified when posting to this account. Ensures project-level cost tracking.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this account master record in the system.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General Ledger chart of accounts master defining every account used in the construction enterprises financial statements — revenue accounts, cost-of-construction accounts, overhead, assets, liabilities, and equity. Sourced from SAP S/4HANA FI-GL and aligned to IFRS/GAAP chart of accounts. Provides the authoritative account classification for all journal entries, AP/AR postings, and financial consolidation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry document. Primary key for the journal entry record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: AR subledger journal entries for revenue recognition, retainage accruals, and client billing adjustments must reference the client account for AR reconciliation and aged-debtor reporting. Construction',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: journal_entry has a company_code STRING column but no FK to the company_code master. In SAP S/4HANA-aligned construction accounting, every journal entry belongs to exactly one company code (legal enti',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: journal_entry carries a cost_center_code STRING column but has no FK to the cost_center master. In SAP-style construction accounting, every journal entry is posted to a cost center for management acco',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: journal_entry has a cost_code STRING column but no FK to the cost_code master. Construction journal entries are classified by cost code for job costing and WBS alignment. Adding cost_code_id normalize',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry posts to a specific GL account; linking to gl_account master eliminates code duplication and enables consistent account attributes.',
    `timesheet_id` BIGINT COMMENT 'Foreign key linking to workforce.timesheet. Business justification: Payroll journal entry posting process: payroll accruals and labor cost journal entries are generated from approved timesheet batches. This FK enables GL auditors to trace payroll journal entries back ',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_invoice. Business justification: Construction AP journal entries are posted from vendor invoices. A direct FK from journal_entry to vendor_invoice enables GL-to-source-document audit traceability, a standard requirement for construct',
    `assignment_field` STRING COMMENT 'Free-form assignment field used for additional sorting, grouping, or reconciliation purposes (e.g., invoice number, payment reference).',
    `business_area_code` STRING COMMENT 'The business area or division for cross-company code reporting and segment analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was first created in the system. Used for audit trail and compliance.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The credit amount for this journal entry line in the document currency. Zero if this is a debit entry.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the journal entry amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `debit_amount` DECIMAL(18,2) COMMENT 'The debit amount for this journal entry line in the document currency. Zero if this is a credit entry.',
    `document_date` DATE COMMENT 'The date on the source document or invoice that originated this journal entry. May differ from posting date for period-end adjustments.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned to this journal entry in the general ledger system. Used for audit trail and reference in financial reports.',
    `document_type` STRING COMMENT 'Classification of the journal entry document type. SA=Standard Accrual, AA=Asset Accounting, KR=Vendor Invoice, DR=Customer Invoice, AB=Accounting Document, RV=Reversal Document.. Valid values are `SA|AA|KR|DR|AB|RV`',
    `entry_status` STRING COMMENT 'Current lifecycle status of the journal entry. Draft=not yet posted, Posted=finalized in GL, Parked=saved but not posted, Reversed=reversed by another entry, Cancelled=voided.. Valid values are `draft|posted|parked|reversed|cancelled`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert document currency amounts to local currency. Applicable for multi-currency transactions.',
    `exchange_rate_type` STRING COMMENT 'The type of exchange rate used for currency conversion. Spot=transaction date rate, Average=period average, Budget=budgeted rate, Closing=period-end rate.. Valid values are `spot|average|budget|closing`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which this journal entry is assigned. Typically 1-12 for monthly periods, or 13-16 for special closing periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this journal entry is assigned for financial reporting purposes.',
    `header_text` STRING COMMENT 'Free-form descriptive text at the document header level explaining the purpose or context of the journal entry.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry represents an intercompany transaction requiring elimination during consolidation.',
    `line_item_text` STRING COMMENT 'Free-form descriptive text at the line item level providing additional context for this specific posting.',
    `local_currency_credit_amount` DECIMAL(18,2) COMMENT 'The credit amount converted to the local currency of the company code for statutory reporting.',
    `local_currency_debit_amount` DECIMAL(18,2) COMMENT 'The debit amount converted to the local currency of the company code for statutory reporting.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this journal entry document.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was last modified in the system. Used for audit trail and change tracking.',
    `percentage_of_completion` DECIMAL(18,2) COMMENT 'The percentage of completion used for revenue recognition entries under IFRS 15. Represents the stage of project completion at the time of this journal entry.',
    `posted_by` STRING COMMENT 'The user ID or name of the person who posted this journal entry to the general ledger, finalizing the transaction.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry was posted to the general ledger. Represents the moment the entry became final and immutable.',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger. This is the principal business event timestamp for financial period assignment and reporting.',
    `posting_key` STRING COMMENT 'Two-digit code that controls the type of posting (debit or credit) and the account type (GL, customer, vendor, asset). Standard SAP posting keys include 40=GL Debit, 50=GL Credit.',
    `profit_center_code` STRING COMMENT 'The profit center to which revenues and costs are allocated for segment reporting and profitability analysis.',
    `reference_document` STRING COMMENT 'External reference number or identifier linking this journal entry to source documents such as invoices, purchase orders, or contracts.',
    `revenue_recognition_method` STRING COMMENT 'The method used to calculate percentage of completion for revenue recognition. Cost-to-cost=based on costs incurred, Units-delivered=based on deliverables, Milestones=based on project milestones, Time-elapsed=based on time.. Valid values are `cost_to_cost|units_delivered|milestones|time_elapsed`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is a reversal of a previous entry. True if this is a reversal document.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversal. 01=Error Correction, 02=Period-End Adjustment, 03=Accrual Reversal, 04=Reclassification, 05=Other.. Valid values are `01|02|03|04|05`',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is true.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this journal entry line in the document currency.',
    `tax_code` STRING COMMENT 'The tax code applied to this journal entry line, determining the tax rate and tax account for automatic tax calculation.',
    `trading_partner_code` STRING COMMENT 'The trading partner company code for intercompany transactions, used for consolidation and elimination entries.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this journal entry document in the system.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core double-entry accounting document and its constituent debit/credit line items, capturing all financial postings in the construction enterprises general ledger. Each document contains a header (document number, posting date, document type, reference, reversal indicator) and one or more lines specifying GL account, cost center, WBS element, cost code, debit/credit amount, currency, tax code, and assignment fields. Covers standard accruals, cost allocations, revenue recognition entries (percentage-of-completion per IFRS 15), intercompany eliminations, period-end adjustments, reclassifications, and FX revaluation entries. Sourced from SAP S/4HANA FI-GL and Viewpoint Vista. Provides full project-level financial traceability from trial balance to source transaction for audit and IFRS/GAAP compliance. Owns both header-level and line-level data as a single SSOT.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for this entity representing one leg of a double-entry accounting transaction.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this financial transaction is allocated. Links financial data to project master data for job costing and project P&L.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry lines need to be allocated to a cost center; replace the existing cost_center_code string with a proper foreign key.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: journal_entry_line has a cost_code STRING column but no FK to the cost_code master. Individual debit/credit line items in construction accounting are classified by cost code for granular job costing. ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry line items reference GL accounts; FK provides authoritative account details.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header that contains this line item. Links this line to the overall transaction batch and posting context.',
    `timesheet_line_id` BIGINT COMMENT 'Foreign key linking to workforce.timesheet_line. Business justification: Payroll journal line audit trail: individual journal entry lines for labor costs must be traceable to the specific timesheet line that originated them. This supports line-level payroll reconciliation ',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or subcontractor associated with this line item, if applicable. Used for accounts payable reconciliation and vendor spend analysis.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Line-level WBS cost allocation: individual journal entry lines are coded to WBS elements for granular cost tracking. journal_entry_line.wbs_element_code is denormalized. This FK enables line-item WBS ',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'The monetary amount of this journal entry line in the local reporting currency of the entity. Used for financial statement preparation and local statutory reporting.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'The monetary amount of this journal entry line in the original transaction currency, before any currency conversion. Enables multi-currency accounting and foreign exchange analysis.',
    `assignment_reference` STRING COMMENT 'Additional reference field used for payment allocation, clearing, and reconciliation. Often contains check numbers, wire transfer references, or clearing document numbers.',
    `baseline_amount` DECIMAL(18,2) COMMENT 'The base amount before tax and adjustments, used for payment terms calculation and cash discount determination.',
    `business_area_code` STRING COMMENT 'The business area or division to which this line item is allocated. Supports segment reporting and divisional P&L analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `clearing_date` DATE COMMENT 'The date on which this line item was cleared (matched with a payment or offsetting entry). Null if the item remains open.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing transaction that closed this line item. Used for payment reconciliation and audit trail.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line is a debit (D) or credit (C) entry in the double-entry accounting system.. Valid values are `D|C`',
    `document_date` DATE COMMENT 'The date on the source document (invoice, receipt, contract) that originated this journal entry line. May differ from posting date due to processing lag.',
    `due_date` DATE COMMENT 'The payment due date for this line item, calculated based on payment terms and document date. Critical for cash flow management and aging reports.',
    `entry_timestamp` TIMESTAMP COMMENT 'The system timestamp when this journal entry line was created in the ERP system. Used for audit trail and transaction sequencing.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency to local currency. Critical for multi-currency consolidation and FX gain/loss calculation.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this journal entry line is assigned. Enables period-over-period financial analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this journal entry line is assigned, based on the posting date and the organizations fiscal calendar.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this journal entry line was last modified. Tracks changes for audit compliance and data lineage.',
    `line_item_text` STRING COMMENT 'Free-text description or memo for this journal entry line, providing additional context for the transaction. Used for audit trail and user clarification.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry, establishing the order of debit and credit legs within the transaction.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local reporting currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `payment_terms_code` STRING COMMENT 'The payment terms code applicable to this line item, defining due dates and cash discount conditions. Used for cash flow forecasting and AP/AR aging.. Valid values are `^[A-Z0-9]{2,6}$`',
    `posting_date` DATE COMMENT 'The accounting date on which this journal entry line was posted to the general ledger. Determines the fiscal period for financial statement inclusion.',
    `posting_key` STRING COMMENT 'SAP-specific posting key that controls the account type (GL, vendor, customer) and debit/credit indicator. Used for system-level transaction control.. Valid values are `^[0-9]{2}$`',
    `profit_center_code` STRING COMMENT 'The profit center responsible for this line item. Enables profitability analysis and internal management reporting by business unit.. Valid values are `^[A-Z0-9]{4,10}$`',
    `reference_document_number` STRING COMMENT 'The source document number (invoice number, PO number, payment reference) that originated this journal entry line. Provides audit trail to source transaction.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `reference_document_type` STRING COMMENT 'The type of source document that originated this journal entry line. Classifies the transaction origin for audit and reconciliation purposes. [ENUM-REF-CANDIDATE: invoice|purchase_order|payment|receipt|adjustment|accrual|reversal — 7 candidates stripped; promote to reference product]',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item is a reversal of a previous entry. Used for error correction tracking and audit compliance.',
    `reversed_document_number` STRING COMMENT 'The document number of the original entry that this line item reverses. Provides audit trail for corrections and adjustments.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount associated with this line item in local currency. Supports tax reporting and reconciliation to tax authorities.',
    `tax_code` STRING COMMENT 'The tax code applied to this line item, determining the tax rate and tax account posting. Used for VAT, sales tax, and GST compliance reporting.. Valid values are `^[A-Z0-9]{2,6}$`',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the original transaction currency.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line item within a journal entry, capturing the GL account, cost center, WBS element, amount, currency, and posting date for each leg of a double-entry transaction. Enables granular drill-down from trial balance to source transaction for audit and IFRS/GAAP compliance. Sourced from SAP S/4HANA FI-GL line item tables.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`project_budget` (
    `project_budget_id` BIGINT COMMENT 'Unique identifier for the project budget record. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project budgets are associated with a cost center; replace the free‑text cost_center column with a foreign key.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Project budgets reference a cost code; replace the free‑text cost_code column with a foreign key to the cost_code master.',
    `previous_budget_project_budget_id` BIGINT COMMENT 'Reference to the prior version of this budget record if this is a revision. Enables historical tracking and variance analysis across budget versions.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Total actual costs incurred to date against this budget. Includes invoiced amounts and accrued costs. Used for EVM Actual Cost of Work Performed (ACWP).',
    `approval_date` DATE COMMENT 'Date when this budget record was formally approved by authorized stakeholders. Triggers budget activation and commitment authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this budget. Used for audit trail and accountability.',
    `approved_change_order_amount` DECIMAL(18,2) COMMENT 'Cumulative sum of all approved change order adjustments to the budget. Includes client-approved scope changes and contract modifications.',
    `baseline_date` DATE COMMENT 'Date when this budget was approved and baselined. Establishes the performance measurement baseline for EVM.',
    `budget_code` STRING COMMENT 'Unique business identifier for the budget record. Used for external reporting and cross-system reference.. Valid values are `^[A-Z0-9]{6,20}$`',
    `budget_name` STRING COMMENT 'Descriptive name of the budget line item or WBS budget element. Human-readable identifier for reporting.',
    `budget_notes` STRING COMMENT 'Free-text notes and comments about this budget record. Captures assumptions, constraints, change justifications, and other contextual information.',
    `budget_owner` STRING COMMENT 'Name or identifier of the project manager or cost manager responsible for managing this budget. Accountable for budget performance.',
    `budget_period_end_date` DATE COMMENT 'End date of the budget period this record applies to. Defines the time window for budget consumption and variance analysis.',
    `budget_period_start_date` DATE COMMENT 'Start date of the budget period this record applies to. Used for time-phased budget tracking and cash flow forecasting.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget record. Approved budgets are baselined; active budgets are in use; frozen budgets are locked for change control.. Valid values are `draft|approved|active|frozen|closed|superseded`',
    `budget_type` STRING COMMENT 'Classification of the budget record. Contract budget represents client-approved amounts; internal budget represents target cost; contingency and management reserve represent risk buffers.. Valid values are `contract|internal|contingency|management_reserve|baseline|forecast`',
    `budget_unit_of_measure` STRING COMMENT 'Unit of measure for quantity-based budgets (e.g., cubic meters for concrete, linear meters for piping, hours for labor). Used for unit rate calculations.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Difference between current approved budget and actual costs. Positive values indicate under-budget; negative values indicate over-budget.',
    `budgeted_quantity` DECIMAL(18,2) COMMENT 'Planned quantity of work or materials for this budget line. Used with unit rates to calculate total budget amounts.',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'Total value of purchase orders and subcontracts issued against this budget. Represents contractual obligations not yet invoiced.',
    `contingency_reserve_amount` DECIMAL(18,2) COMMENT 'Budget allocation for identified risks and known-unknowns. Managed by the project manager and released through change control process.',
    `contract_line_item_reference` STRING COMMENT 'Reference to the specific contract line item or BOQ item this budget corresponds to. Links budget to contractual scope and payment terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget record. Supports multi-currency project accounting.. Valid values are `^[A-Z]{3}$`',
    `current_approved_budget` DECIMAL(18,2) COMMENT 'The current total approved budget including original budget plus all approved change orders. This is the active baseline for Earned Value Management (EVM) calculations.',
    `forecast_at_completion` DECIMAL(18,2) COMMENT 'Projected total cost at project completion based on current performance trends. Used for variance analysis and early warning of budget overruns.',
    `funding_source` STRING COMMENT 'Source of funding for this budget (e.g., client payment, internal investment, joint venture contribution, government grant). Used for cash flow and financial reporting.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this budget record is currently active and available for cost posting. Inactive budgets are closed or superseded.',
    `is_baseline_budget` BOOLEAN COMMENT 'Indicates whether this budget record represents the approved performance measurement baseline for EVM. True for baseline budgets used in BCWS calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this budget record was last updated. Tracks the most recent change for audit and synchronization purposes.',
    `management_reserve_amount` DECIMAL(18,2) COMMENT 'Budget allocation for unknown-unknowns and unidentified risks. Held at executive level and not part of the performance measurement baseline.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The initial approved budget amount at project baseline. Represents the starting contract value or internal target cost before any change orders.',
    `revision_number` STRING COMMENT 'Sequential version number for this budget record. Incremented with each approved change to maintain audit trail of budget evolution.',
    `unit_rate` DECIMAL(18,2) COMMENT 'Cost per unit of measure for this budget item. Multiplied by budgeted quantity to derive total budget amount.',
    CONSTRAINT pk_project_budget PRIMARY KEY(`project_budget_id`)
) COMMENT 'Authoritative WBS-linked budget record for each construction project, capturing the approved contract budget, internal target cost, contingency reserves, and management reserve. Tracks original budget, approved change order (CO) adjustments, and current approved budget (CAB) at each WBS level. Integrates with Oracle Primavera P6 baseline data and SAP S/4HANA PS module. Serves as the baseline for EVM (Earned Value Management) calculations including BCWS (Budgeted Cost of Work Scheduled).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` (
    `job_cost_transaction_id` BIGINT COMMENT 'Unique identifier for the job cost transaction record. Primary key for this entity.',
    `cost_account_id` BIGINT COMMENT 'Foreign key linking to project.cost_account. Business justification: Cost account posting: job cost transactions post to project cost accounts — this is the fundamental cost accumulation relationship in construction job costing. Cost controllers require this link to ag',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Job cost transactions are charged to a cost center; FK enforces valid cost center reference.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: job_cost_transaction has a cost_code STRING column but no FK to the cost_code master. Every job cost transaction must be classified by a cost code — this is the core of construction job costing (e.g.,',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: job_cost_transaction has a gl_account_code STRING column but no FK to the gl_account master. Job cost transactions post to GL accounts for financial reporting (IFRS/GAAP compliance). Adding gl_account',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Phase-level cost tracking: job cost transactions must be attributable to project phases for phase cost reporting and gate review financial analysis. Construction cost controllers require phase-level a',
    `reversed_transaction_job_cost_transaction_id` BIGINT COMMENT 'Reference to the original job cost transaction that this record reverses or corrects. Null for original transactions.',
    `timesheet_line_id` BIGINT COMMENT 'Foreign key linking to workforce.timesheet_line. Business justification: Labor job cost posting process: each posted timesheet line generates a job_cost_transaction. This FK enables labor cost audit traceability — auditors and project controllers must trace every job cost ',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or subcontractor who provided the goods or services for this transaction. Applicable for material, equipment rental, and subcontractor costs.',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_invoice. Business justification: Construction job cost transactions are triggered by vendor invoice postings. A direct FK from job_cost_transaction to vendor_invoice enables cost-posting-to-source-invoice traceability for audit, thre',
    `approval_status` STRING COMMENT 'The approval workflow status of this cost transaction: pending (awaiting review), approved (validated and committed), or rejected (not accepted).. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this cost transaction. Used for audit trail and accountability.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this cost transaction was approved. Used for audit trail and workflow tracking.',
    `base_currency_cost` DECIMAL(18,2) COMMENT 'The total cost converted to the project or corporate base currency for consolidated financial reporting and P&L analysis.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this cost is billable to the client (true) or non-billable internal cost (false). Used for progress billing and revenue recognition.',
    `billed_flag` BOOLEAN COMMENT 'Indicates whether this cost has been included in a client invoice (true) or remains unbilled (false). Used for work-in-progress and revenue recognition tracking.',
    `cost_category` STRING COMMENT 'High-level classification of the cost transaction type: labor, material, equipment, subcontractor, overhead, or indirect costs.. Valid values are `labor|material|equipment|subcontractor|overhead|indirect`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost transaction record was first created in the system. Used for audit trail and data governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP). Required for multi-currency project accounting.. Valid values are `^[A-Z]{3}$`',
    `job_cost_transaction_description` STRING COMMENT 'Free-text description of the cost transaction providing additional context about the work performed, materials used, or services rendered.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the transaction amount to the project base currency. Null if transaction is in base currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (e.g., 2024-Q1, 2024-03) to which this transaction is assigned for financial reporting and period close.',
    `modified_by` STRING COMMENT 'The user or system that last modified this cost transaction record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost transaction record was last modified. Used for audit trail and data governance.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this cost transaction, including justifications, clarifications, or special handling instructions.',
    `posting_date` DATE COMMENT 'The date when the transaction was posted to the financial system. May differ from transaction_date due to approval or processing delays.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the resource consumed or work performed (e.g., labor hours, material units, equipment hours). Used for unit cost analysis.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal or correction of a previously posted cost (true) or an original transaction (false).',
    `source_transaction_reference` STRING COMMENT 'The unique transaction identifier in the source system. Enables traceability back to the originating record for audit and reconciliation.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost amount for this transaction (quantity × unit_cost). Represents the actual cost posted to the project for EVM ACWP and CPI calculations.',
    `transaction_date` DATE COMMENT 'The business date when the cost was incurred or the work was performed. Used for period-based cost reporting and EVM actual cost (ACWP) calculations.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction identifier or document number from the source system (e.g., timesheet number, invoice number, receipt number).',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the cost transaction: draft (pending approval), posted (committed to ledger), approved (validated), reversed (corrected), or cancelled.. Valid values are `draft|posted|approved|reversed|cancelled`',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of measure for this transaction. Used to calculate total cost and for rate variance analysis.',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is measured (e.g., hours, cubic meters, tons, each). Aligns with industry standard UOM codes.',
    `created_by` STRING COMMENT 'The user or system that created this cost transaction record. Used for audit trail and data lineage.',
    CONSTRAINT pk_job_cost_transaction PRIMARY KEY(`job_cost_transaction_id`)
) COMMENT 'Granular cost transaction record capturing every actual cost posted against a construction projects WBS element and cost code — labor timesheets, material receipts, equipment usage charges, subcontractor invoices, and overhead allocations. The primary source for job costing and cost-to-complete analysis. Sourced from Viewpoint Vista job costing module and SAP S/4HANA CO-PA. Feeds EVM actual cost (ACWP) calculations and CPI (Cost Performance Index) reporting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`progress_billing` (
    `progress_billing_id` BIGINT COMMENT 'Unique identifier for the progress billing record. Primary key for the progress billing entity.',
    `account_id` BIGINT COMMENT 'Reference to the client account being billed for this progress payment.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this progress billing is issued.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this progress billing is issued.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Progress billing amounts are charged to a cost center for cost tracking.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: progress_billing has an invoice_number STRING column but no FK to the invoice master. In construction, a progress billing / payment application generates a formal AR invoice. Linking progress_billing ',
    `master_services_agreement_id` BIGINT COMMENT 'Foreign key linking to client.master_services_agreement. Business justification: Progress billing applications in construction are governed by MSA payment terms, retention clauses, and milestone schedules. Payment certificate processing and retention release calculations require d',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Milestone-triggered billing: progress billing applications in construction are triggered by milestone completion certification. Linking progress_billing to the triggering project_milestone enables pay',
    `payment_certificate_id` BIGINT COMMENT 'Foreign key linking to contract.payment_certificate. Business justification: Progress billing applications are raised after engineer payment certificates are issued. Linking them enables billing-to-certification reconciliation — a mandatory process in construction contract adm',
    `progress_update_id` BIGINT COMMENT 'Foreign key linking to schedule.progress_update. Business justification: Progress billing applications are directly derived from schedule progress updates — the percentage_complete and period data in progress_update is the contractual basis for the billing claim. Quantity ',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Progress billing should be associated with the underlying project budget for variance analysis.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element for which this progress billing is being claimed.',
    `aging_bucket` STRING COMMENT 'Accounts receivable aging classification based on days past due: current (not yet due), 1-30 days, 31-60 days, 61-90 days, over 90 days.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `amount_received` DECIMAL(18,2) COMMENT 'Total amount received from the client against this invoice, including partial payments.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this progress billing claim.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this progress billing claim.',
    `certification_date` DATE COMMENT 'Date when the payment certificate was certified or approved by the engineer or client representative.',
    `client_reference_number` STRING COMMENT 'Client-provided reference number or purchase order number associated with this payment application.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this progress billing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this progress billing record.. Valid values are `^[A-Z]{3}$`',
    `current_period_claim` DECIMAL(18,2) COMMENT 'Amount claimed in the current billing period, calculated as work_completed_to_date minus previous_amount_billed.',
    `cutoff_date` DATE COMMENT 'The measurement cutoff date for work completed and eligible for billing in this payment application.',
    `engineer_approval_name` STRING COMMENT 'Name of the engineer or client representative who certified or approved the payment certificate.',
    `gross_amount_due` DECIMAL(18,2) COMMENT 'Gross amount due before retention and taxes, equal to current_period_claim.',
    `invoice_date` DATE COMMENT 'Date when the formal AR invoice was issued to the client.',
    `invoice_due_date` DATE COMMENT 'Payment due date for the invoice, typically calculated as invoice_date plus contract payment terms (e.g., Net 30, Net 60).',
    `materials_stored_on_site` DECIMAL(18,2) COMMENT 'Value of materials delivered and stored on-site but not yet incorporated into the work, eligible for billing per contract terms.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this progress billing record was last modified or updated.',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Net amount due after deducting retention, calculated as gross_amount_due minus retention_amount.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this invoice, calculated as net_amount_due plus tax_amount minus amount_received.',
    `payment_application_number` STRING COMMENT 'Unique business identifier for the payment application (e.g., AIA G702 application number or FIDIC payment certificate number).',
    `payment_certificate_type` STRING COMMENT 'Type of payment certificate being issued: interim (monthly progress), final (project completion), advance (mobilization), milestone (specific deliverable), retention_release (DLP completion), or variation (change order).. Valid values are `interim|final|advance|milestone|retention_release|variation`',
    `payment_received_date` DATE COMMENT 'Date when payment was received from the client for this invoice.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the progress billing: draft (being prepared), submitted (sent to client), under_review (client reviewing), certified (approved by engineer), invoiced (AR invoice raised), partially_paid (partial payment received), paid (fully paid), overdue (past due date), disputed (under dispute), cancelled (voided). [ENUM-REF-CANDIDATE: draft|submitted|under_review|certified|invoiced|partially_paid|paid|overdue|disputed|cancelled — 10 candidates stripped; promote to reference product]',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date to payment due date as per contract payment terms (e.g., 30, 60, 90 days).',
    `percentage_complete` DECIMAL(18,2) COMMENT 'Percentage of work completed for the billing line item as of the cutoff date, used for percentage-of-completion revenue recognition.',
    `previous_amount_billed` DECIMAL(18,2) COMMENT 'Cumulative amount billed in all prior payment applications, used to calculate the current period claim.',
    `remarks` STRING COMMENT 'Additional notes, comments, or clarifications related to this progress billing, including dispute details or payment conditions.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Monetary value of retention withheld from the current period claim, calculated as current_period_claim multiplied by retention_percentage.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the billed amount withheld by the client as retention (typically 5-10%) until project completion or DLP expiry.',
    `scheduled_value` DECIMAL(18,2) COMMENT 'Total contract value or scheduled value for the work scope covered by this billing line (from BOQ or contract schedule).',
    `submission_date` DATE COMMENT 'Date when the payment application was submitted to the client or engineer for review and certification.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Value-added tax (VAT) or goods and services tax (GST) applied to the net amount due, per local tax regulations.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate percentage applied to calculate the tax amount (e.g., VAT or GST rate).',
    `work_completed_to_date` DECIMAL(18,2) COMMENT 'Cumulative value of work completed from project start through the current billing period cutoff date.',
    CONSTRAINT pk_progress_billing PRIMARY KEY(`progress_billing_id`)
) COMMENT 'Construction progress billing, payment certification, and client AR invoice lifecycle record covering the full claim-to-collection cycle. Captures the payment application (AIA G702/G703 or FIDIC payment certificate) including scheduled value by WBS/BOQ line, percentage complete, amount earned to date, current period claim, retention withheld, and net amount due. Also owns the formal AR tax invoice raised after payment certificate approval — invoice number, client reference, contract reference, invoice date, due date, gross amount, VAT/GST, retention deducted, net receivable, payment status, aging bucket, and collection history. Sourced from Procore, SAP S/4HANA FI-AR, and Viewpoint Vista. The authoritative SSOT for all client-facing billing, accounts receivable invoices, and receivables management in construction.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key for invoice',
    `activity_resource_assignment_id` BIGINT COMMENT 'Foreign key linking to schedule.activity_resource_assignment. Business justification: Subcontractor and supplier invoices are validated against the activity resource assignment that authorized the work. Three-way matching (assignment → PO → invoice) is a standard construction AP contro',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Accounts payable invoices must be assigned to a cost center for budget control and reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Invoice cost_code column is denormalized; linking to cost_code table enables accurate cost‑code reporting and variance analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accounts payable invoice must be associated with a GL account for posting; FK replaces code string.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or subcontractor who issued this invoice. Links to the vendor master data in the procurement domain.',
    `approval_status` STRING COMMENT 'Current status of the invoice in the approval workflow. Tracks whether the invoice has been reviewed and approved by authorized personnel per delegation of authority (DOA) matrix.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved the invoice for payment. Used for audit trail and accountability.',
    `approved_date` DATE COMMENT 'The date the invoice was approved for payment. Used for workflow metrics and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the accounts payable system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). Used for multi-currency accounting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `invoice_description` STRING COMMENT 'Free-text description of the goods or services covered by this invoice. Provides context for the invoice line items and supports audit and review processes.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any early payment discount or negotiated discount applied to the invoice. Reduces the net payable amount.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the invoice is currently under dispute. True if there is a disagreement on invoice accuracy, pricing, or delivery that must be resolved before payment.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for the invoice dispute. Captures details of pricing discrepancies, quantity mismatches, quality issues, or other disagreements.',
    `due_date` DATE COMMENT 'The date by which payment is due per the payment terms. Used for cash flow forecasting, aging reports, and late payment penalty calculation.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this invoice is allocated. Used for monthly/quarterly financial reporting and variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this invoice is allocated for financial reporting purposes. Used for annual P&L, EBITDA, and budget vs. actual analysis.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before tax, retention, and other adjustments. Represents the base value of goods or services invoiced.',
    `hold_flag` BOOLEAN COMMENT 'Boolean indicator of whether the invoice is on hold pending additional information or resolution of issues. True if payment is temporarily suspended.',
    `hold_reason` STRING COMMENT 'Free-text description of the reason the invoice is on hold. May include missing documentation, pending approvals, or compliance issues.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued by the vendor or subcontractor. This is the principal business event timestamp for the invoice and is used for aging analysis and payment term calculation.',
    `invoice_number` STRING COMMENT 'The externally-known unique invoice number assigned by the vendor or subcontractor. This is the business identifier used for correspondence, payment reference, and three-way matching.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. Tracks progression from receipt through approval to payment or dispute resolution. [ENUM-REF-CANDIDATE: received|pending_approval|approved|disputed|on_hold|paid|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice type. Standard invoices are for completed deliveries; progress claims are for work-in-progress per percentage of completion; credit/debit notes are adjustments; prepayments are advance payments; final invoices close out a contract.. Valid values are `standard|progress_claim|credit_note|debit_note|prepayment|final`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'The final amount payable to the vendor after applying tax, retention, discounts, and other adjustments. This is the amount that will be paid or has been paid.',
    `payment_date` DATE COMMENT 'The actual date payment was made to the vendor or subcontractor. Null if invoice is unpaid. Used for cash flow analysis and Days Payable Outstanding (DPO) calculation.',
    `payment_method` STRING COMMENT 'The payment instrument or method used to pay this invoice (e.g., wire transfer, check, ACH, credit card, letter of credit). Used for cash management and reconciliation.. Valid values are `wire_transfer|check|ach|credit_card|letter_of_credit`',
    `payment_reference_number` STRING COMMENT 'The unique reference number or transaction ID for the payment made against this invoice. Used for bank reconciliation and audit trail.',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this invoice (e.g., Net 30, Net 60, 2/10 Net 30). Defines the payment schedule and any early payment discount conditions.. Valid values are `^[A-Z0-9 ]{3,30}$`',
    `received_date` DATE COMMENT 'The date the invoice was received and recorded in the accounts payable system. Used for internal processing metrics and aging analysis.',
    `retention_amount` DECIMAL(18,2) COMMENT 'The amount withheld from payment as retention per contract terms. Typically held until project completion or Defects Liability Period (DLP) expiry. Common in construction contracts per FIDIC terms.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'The percentage of the invoice amount withheld as retention per contract terms. Typically 5-10% in construction contracts per FIDIC conditions.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax or Value Added Tax (VAT) amount applied to the invoice. Used for tax reporting and compliance with local tax regulations.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The tax or VAT rate applied to this invoice, expressed as a percentage. Used for tax calculation and compliance reporting.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation between Purchase Order (PO), Goods Receipt (GR), and Invoice. Ensures invoice accuracy and prevents overpayment.. Valid values are `matched|unmatched|partial_match|override`',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Vendor and subcontractor invoice record in the Accounts Payable (AP) ledger, capturing the full supplier billing lifecycle from receipt through approval to payment. Records invoice number, vendor/subcontractor reference, PO/subcontract reference, invoice date, due date, gross amount, tax/VAT amount, retention withheld, net payable, payment terms, approval workflow status, three-way match status (PO-GR-Invoice), and dispute/hold flags. Sourced from SAP S/4HANA FI-AP and Viewpoint Vista AP module. Covers supplier invoices for materials, equipment hire, professional services, and subcontractor progress claims. The authoritative SSOT for all accounts payable obligations in the construction enterprise.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`payment_record` (
    `payment_record_id` BIGINT COMMENT 'Unique identifier for the payment transaction record. Primary key for the payment_record product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this payment is made or received, enabling project-level cash flow tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payments are allocated to cost centers for cash‑flow forecasting and cost‑center performance tracking.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: payment_record has a cost_code STRING column but no FK to the cost_code master. Payments in construction are classified by cost code for job costing and budget variance tracking. Adding cost_code_id n',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: payment_record has a gl_account_code STRING column but no FK to the gl_account master. Payment transactions clear against specific GL accounts (AP clearing, bank accounts). Adding gl_account_id normal',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Payments are applied to a specific AP invoice; FK provides direct linkage for reconciliation.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Milestone payment tracking: payment records for milestone-based construction contracts must reference the triggering milestone for payment certification compliance and retention release tracking. Cont',
    `payment_certificate_id` BIGINT COMMENT 'Foreign key linking to contract.payment_certificate. Business justification: Finance payment records track actual disbursements; payment certificates authorize those disbursements. Linking them enables certified-vs-paid reconciliation reports — a mandatory contract administrat',
    `payment_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.payment_schedule. Business justification: Contract payment schedules define due dates and amounts; finance payment records track actuals. This link enables scheduled-vs-actual payment variance analysis — a standard contract financial performa',
    `progress_billing_id` BIGINT COMMENT 'Foreign key linking to finance.progress_billing. Business justification: payment_record captures both AP (vendor) and AR (client) payments. For AR payments, the payment should be linked to the progress billing / payment application it settles. progress_billing tracks outst',
    `subcontract_payment_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract_payment. Business justification: Subcontract payment records in finance must reconcile to subcontract payment obligations in the contract domain. This link supports subcontractor payment reconciliation reporting and audit trail requi',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or subcontractor receiving the outgoing payment (AP disbursement). Null for incoming payments.',
    `advance_payment_flag` BOOLEAN COMMENT 'Indicates whether this payment is an advance payment made before work completion or goods delivery.',
    `approval_date` DATE COMMENT 'Date when the payment was approved by the authorized approver, marking a key lifecycle event.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the payment transaction, for audit trail and accountability.',
    `bank_charges` DECIMAL(18,2) COMMENT 'Bank fees and transaction charges incurred for processing the payment, may be borne by payer or payee.',
    `bank_reference_number` STRING COMMENT 'Unique reference number assigned by the bank for the payment transaction, used for bank reconciliation and clearing.. Valid values are `^[A-Z0-9]{10,35}$`',
    `clearing_date` DATE COMMENT 'Date when the payment was cleared and confirmed by the bank, indicating successful fund transfer.',
    `clearing_status` STRING COMMENT 'Status of the payment in the bank clearing process, indicating whether funds have been successfully transferred.. Valid values are `not_cleared|cleared|partially_cleared|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment record was first created in the system, for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount or cash discount amount deducted from the gross payment amount, if applicable.',
    `due_date` DATE COMMENT 'The contractual due date by which the payment should be made or received, based on invoice date and payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert the payment amount to the companys functional currency, if multi-currency transaction.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the companys functional currency using the exchange rate, for consolidated financial reporting.',
    `invoice_references` STRING COMMENT 'Comma-separated list of invoice document numbers that are cleared or partially cleared by this payment transaction.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment record was last modified or updated, for audit trail and change tracking.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount paid or received after all adjustments, discounts, withholding taxes, and bank charges.',
    `partial_payment_flag` BOOLEAN COMMENT 'Indicates whether this is a partial payment that does not fully settle the referenced invoices or obligations.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the payment transaction in the transaction currency, before any adjustments or fees.',
    `payment_approval_status` STRING COMMENT 'Approval workflow status for the payment, indicating whether it has been authorized by the appropriate authority levels.. Valid values are `pending_approval|approved|rejected`',
    `payment_channel` STRING COMMENT 'The interface or system channel through which the payment was initiated or received (e.g., ERP system, banking portal, manual entry).. Valid values are `erp_system|banking_portal|manual_entry|edi|api`',
    `payment_date` DATE COMMENT 'The actual date when the payment was executed or received. This is the principal business event timestamp for the transaction.',
    `payment_document_number` STRING COMMENT 'Externally-known unique payment document number assigned by the ERP system (SAP S/4HANA or Viewpoint Vista). Used for reconciliation and audit trail.. Valid values are `^[A-Z0-9]{8,20}$`',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to execute the payment (e.g., wire transfer, ACH, cheque, cash, LC drawdown).. Valid values are `wire_transfer|ach|cheque|cash|letter_of_credit|bank_draft`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments related to the payment transaction, capturing special instructions or contextual information.',
    `payment_priority` STRING COMMENT 'Priority level assigned to the payment for processing sequence and cash flow management.. Valid values are `urgent|high|normal|low`',
    `payment_purpose` STRING COMMENT 'Business purpose or reason for the payment (e.g., material supply, subcontractor labor, equipment rental, progress billing).',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction in the payment processing workflow.. Valid values are `draft|pending|cleared|failed|cancelled|reversed`',
    `payment_terms` STRING COMMENT 'Contractual payment terms applicable to this transaction (e.g., Net 30, Net 60, 2/10 Net 30), governing due dates and discounts.',
    `payment_type` STRING COMMENT 'Classification of payment direction: outgoing payments to vendors/subcontractors (AP disbursements) or incoming receipts from clients (AR collections).. Valid values are `outgoing|incoming`',
    `po_number` STRING COMMENT 'Purchase order number associated with the payment, typically for vendor payments linked to procurement transactions.. Valid values are `^PO[0-9]{8,12}$`',
    `reconciliation_date` DATE COMMENT 'Date when the payment was successfully reconciled with the bank statement during the bank reconciliation process.',
    `reconciliation_status` STRING COMMENT 'Status of bank reconciliation for this payment, indicating whether it has been matched with bank statement entries.. Valid values are `not_reconciled|reconciled|discrepancy|under_review`',
    `remittance_advice` STRING COMMENT 'Detailed remittance information sent to the payee explaining which invoices or obligations are being settled by this payment.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the payment as retention per contract terms, to be released upon project completion or defects liability period.',
    `value_date` DATE COMMENT 'The effective date when funds are available or debited in the bank account, used for cash flow and liquidity management.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld at source as per local tax regulations, deducted from the gross payment amount.',
    CONSTRAINT pk_payment_record PRIMARY KEY(`payment_record_id`)
) COMMENT 'Financial payment transaction record capturing both outgoing payments to vendors/subcontractors (AP disbursements) and incoming receipts from clients (AR collections). Captures payment date, payment method (wire transfer, cheque, ACH, LC drawdown), bank account, amount paid/received, currency, exchange rate, invoice references cleared, bank clearing status, and remittance advice details. Supports multi-currency payment runs, partial payments, and bank reconciliation. Sourced from SAP S/4HANA FI payment runs and Viewpoint Vista.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` (
    `cash_flow_forecast_id` BIGINT COMMENT 'Unique identifier for the cash flow forecast record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Required for cash flow forecasting per contract to align financing with project cash needs; contracts define payment terms used in cash flow models.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this cash flow forecast is prepared. Null for corporate-level forecasts.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cash flow forecasts are prepared per cost center to track cash impact of cost allocations.',
    `lookahead_plan_id` BIGINT COMMENT 'Foreign key linking to schedule.lookahead_plan. Business justification: Short-term cash flow forecasts (4–6 week horizon) are built directly from the lookahead plan — planned activities drive projected labor, material, and subcontractor outflows. Project accountants updat',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Milestone-driven cash flow: construction cash flow forecasts are structured around milestone payment dates. cash_flow_forecast.milestone_payment_amount signals this relationship. Finance teams model i',
    `payment_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.payment_schedule. Business justification: Cash flow forecasts in construction are built from contract payment schedules. Linking forecast periods to specific payment schedule installments enables automated S-curve population and forecast-vs-s',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Phase-structured cash flow: construction cash flow forecasts are organized by project phase for S-curve analysis and phase-level funding requirement planning. Finance directors require phase-level cas',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: cash_flow_forecast is a forward-looking projection that should be anchored to the authoritative project budget. The project_budget contains the approved contract value, forecast at completion, and bud',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Long-range cash flow forecasts and S-curves are generated from the schedule baseline (BCWS time-phasing). The s_curve_profile_indicator on cash_flow_forecast signals this dependency. Project finance t',
    `staffing_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.staffing_plan. Business justification: Payroll cash flow forecasting process: cash_flow_forecast.payroll_amount is derived from staffing plan headcount and labor rates. Finance teams link cash flow forecasts to staffing plans to project we',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element if the forecast is prepared at a granular work package level. Null for project-level or corporate-level forecasts.',
    `advance_drawdown_amount` DECIMAL(18,2) COMMENT 'Forecasted drawdown of advance payments or mobilization advances from the client, typically secured by advance payment guarantees.',
    `approval_date` DATE COMMENT 'Date on which the forecast was formally approved for use in financial planning and decision-making.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the forecast, typically the project manager, finance director, or CFO.',
    `bond_premium_amount` DECIMAL(18,2) COMMENT 'Forecasted payments for performance bonds, advance payment guarantees, and other surety instruments required by the contract.',
    `bonding_capacity_utilization` DECIMAL(18,2) COMMENT 'Percentage of total bonding capacity utilized by this forecast, relevant for corporate-level forecasts to monitor surety capacity constraints.',
    `closing_cash_balance` DECIMAL(18,2) COMMENT 'Projected cash balance at the end of the forecast period, calculated as opening balance plus net cash flow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was first created in the system.',
    `credit_facility_utilization` DECIMAL(18,2) COMMENT 'Percentage of available credit facility or working capital line utilized to meet the peak funding requirement, relevant for corporate treasury management.',
    `cumulative_cash_position` DECIMAL(18,2) COMMENT 'Cumulative cash position at the end of the forecast period, representing the running total of net cash flows from project inception or corporate fiscal year start.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this forecast (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `equipment_hire_amount` DECIMAL(18,2) COMMENT 'Forecasted payments for equipment rental and hire charges, including plant, machinery, and temporary facilities.',
    `forecast_assumptions` STRING COMMENT 'Key assumptions underlying the forecast, including payment term assumptions, progress rate assumptions, inflation factors, and risk contingencies.',
    `forecast_date` DATE COMMENT 'The date on which this forecast was prepared or last updated, representing the as-of date for the forecast assumptions.',
    `forecast_granularity` STRING COMMENT 'The time interval granularity at which cash flows are forecasted: daily for short-term liquidity management, weekly for near-term project cash planning, monthly for standard project forecasting, or quarterly for long-term corporate planning.. Valid values are `daily|weekly|monthly|quarterly`',
    `forecast_identifier` STRING COMMENT 'Business-readable identifier for the forecast, typically combining project code, forecast period, and version (e.g., PRJ-2024-001-V3).',
    `forecast_period_end_date` DATE COMMENT 'The end date of the period covered by this cash flow forecast.',
    `forecast_period_start_date` DATE COMMENT 'The start date of the period covered by this cash flow forecast.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast: draft for work-in-progress, submitted for review, approved for active use, superseded when replaced by a newer version, or archived for historical reference.. Valid values are `draft|submitted|approved|superseded|archived`',
    `forecast_type` STRING COMMENT 'Classification of the forecast scope: project-level for individual construction projects, corporate-level for enterprise-wide treasury forecasting, WBS-level for granular work package forecasts, or contract-level for specific contract cash management.. Valid values are `project_level|corporate_level|wbs_level|contract_level`',
    `forecast_version` STRING COMMENT 'Version number of the forecast, incremented with each revision to track forecast evolution and variance analysis over time.',
    `forecasted_inflow_amount` DECIMAL(18,2) COMMENT 'Total projected cash inflows for the forecast period, including client milestone payments, retention releases, advance drawdowns, and other receipts.',
    `forecasted_outflow_amount` DECIMAL(18,2) COMMENT 'Total projected cash outflows for the forecast period, including subcontractor payments, material procurement, payroll, equipment hire, bond premiums, and other disbursements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was last updated, supporting audit trail and version control.',
    `material_procurement_amount` DECIMAL(18,2) COMMENT 'Forecasted payments for material purchases and procurement, based on Purchase Orders (PO) and supplier payment terms.',
    `milestone_payment_amount` DECIMAL(18,2) COMMENT 'Forecasted client milestone payments expected during the period, based on contract payment schedules and progress billing milestones.',
    `net_cash_flow_amount` DECIMAL(18,2) COMMENT 'Net cash flow for the forecast period, calculated as forecasted inflows minus forecasted outflows, indicating the expected cash position change.',
    `notes` STRING COMMENT 'Additional notes, comments, or explanations regarding the forecast, including significant changes from prior versions or special circumstances.',
    `opening_cash_balance` DECIMAL(18,2) COMMENT 'Cash balance at the beginning of the forecast period, serving as the starting point for the periods cash flow projection.',
    `payroll_amount` DECIMAL(18,2) COMMENT 'Forecasted payroll disbursements for direct labor and site personnel, including wages, benefits, and statutory contributions.',
    `peak_funding_requirement` DECIMAL(18,2) COMMENT 'Maximum negative cash position expected during the forecast period, indicating the highest working capital or credit facility draw required.',
    `prepared_by` STRING COMMENT 'Name or identifier of the individual or team who prepared the forecast, typically the project controls team or corporate treasury analyst.',
    `retention_release_amount` DECIMAL(18,2) COMMENT 'Forecasted release of retention amounts held by the client, typically released upon project completion or after the Defects Liability Period (DLP).',
    `s_curve_profile_indicator` STRING COMMENT 'Classification of the cash flow profile shape: front-loaded for projects with high early expenditure, linear for steady cash flow, back-loaded for projects with late-stage heavy spending, or custom for non-standard profiles.. Valid values are `front_loaded|linear|back_loaded|custom`',
    `subcontractor_payment_amount` DECIMAL(18,2) COMMENT 'Forecasted payments to subcontractors for work performed, based on subcontract payment terms and progress certificates.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between current and prior forecast, calculated as (current - prior) / prior * 100, indicating forecast volatility.',
    `variance_to_prior_forecast` DECIMAL(18,2) COMMENT 'Difference between the current forecast net cash flow and the previous forecast version for the same period, used for forecast accuracy tracking and trend analysis.',
    `working_capital_gap` DECIMAL(18,2) COMMENT 'Difference between forecasted outflows and inflows timing, representing the working capital financing need to bridge payment obligations before receipt of client payments.',
    CONSTRAINT pk_cash_flow_forecast PRIMARY KEY(`cash_flow_forecast_id`)
) COMMENT 'Forward-looking cash flow projection record for construction projects and the corporate entity, capturing forecast inflows (client milestone payments, retention releases, advance drawdowns) and outflows (subcontractor payments, material procurement, payroll, equipment hire, bond premiums) by period (weekly/monthly). Includes S-curve cash flow profile, cumulative cash position, peak funding requirement, working capital gap analysis, and variance to prior forecast. Supports both project-level forecasting for contract cash management and corporate-level treasury forecasting for bonding capacity and credit facility utilization.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Primary key for company_code',
    `parent_company_code_id` BIGINT COMMENT 'Self-referencing FK on company_code (parent_company_code_id)',
    `address_line1` STRING COMMENT 'Primary street address of the company location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `business_area` STRING COMMENT 'Higher‑level business area classification for reporting.',
    `chart_of_accounts` STRING COMMENT 'Reference to the chart of accounts used by the entity.',
    `city` STRING COMMENT 'City where the company is located.',
    `classification` STRING COMMENT 'Category describing the legal relationship of the entity within the corporate group.',
    `company_code_code` STRING COMMENT 'Unique alphanumeric identifier assigned to the legal entity for accounting and reporting.',
    `company_code_status` STRING COMMENT 'Current lifecycle state of the company entity.',
    `cost_center` STRING COMMENT 'Identifier of the cost center associated with the entity.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the company location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the company code record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for reporting for this company.',
    `company_code_description` STRING COMMENT 'Free‑text description of the companys primary activities and scope.',
    `dissolution_date` DATE COMMENT 'Date the entity was legally dissolved, if applicable.',
    `effective_from` DATE COMMENT 'Date when the company code became effective for accounting purposes.',
    `effective_to` DATE COMMENT 'Date when the company code ceased to be effective (null if still active).',
    `external_reference_number` STRING COMMENT 'Identifier used by external partner or regulatory systems to reference this entity.',
    `financial_reporting_standard` STRING COMMENT 'Accounting framework applied to the entitys financial statements.',
    `incorporation_date` DATE COMMENT 'Date the entity was legally incorporated.',
    `industry_code` STRING COMMENT 'Standard industry code (e.g., NAICS) describing the primary business activity.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the entity is included in group financial consolidation.',
    `legal_form` STRING COMMENT 'Legal structure of the entity.',
    `company_code_name` STRING COMMENT 'Legal name of the company entity.',
    `parent_company_code` STRING COMMENT 'Company code of the immediate parent legal entity, if any.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the company address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person.',
    `primary_contact_name` STRING COMMENT 'Name of the primary person to contact for the company.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `profit_center` STRING COMMENT 'Identifier of the profit center to which the entity reports.',
    `segment` STRING COMMENT 'Business segment to which the entity belongs for strategic reporting.',
    `state_province` STRING COMMENT 'State or province of the company location.',
    `tax_number` STRING COMMENT 'Government‑issued tax identifier for the legal entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the company code record.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Master reference table for company_code. Referenced by company_code_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Primary key for chart_of_accounts',
    `company_code_id` BIGINT COMMENT 'add column company_code_id (BIGINT) with FK to finance.company_code.company_code_id - charts of accounts are owned by company codes',
    `parent_chart_of_accounts_id` BIGINT COMMENT 'Self-referencing FK on chart_of_accounts (parent_chart_of_accounts_id)',
    `account_hierarchy_level` STRING COMMENT 'Numeric level indicating the depth of the account within the chart hierarchy (e.g., 1 = top‑level, 2 = sub‑account).',
    `account_name` STRING COMMENT 'Human‑readable name of the account as displayed in financial statements and reports.',
    `account_number` STRING COMMENT 'Unique alphanumeric code assigned to the account, used in financial postings and reporting.',
    `account_type` STRING COMMENT 'Category of the account defining its role in the balance sheet or income statement.',
    `chart_of_accounts_status` STRING COMMENT 'Current lifecycle state of the account (e.g., active for posting, inactive for archival).',
    `cost_center_code` STRING COMMENT 'Code linking the account to a cost center for internal cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the chart of accounts record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the account is denominated.',
    `chart_of_accounts_description` STRING COMMENT 'Extended textual description providing context or usage notes for the account.',
    `effective_from` DATE COMMENT 'Date when the account becomes valid for posting.',
    `effective_to` DATE COMMENT 'Date when the account is retired or becomes invalid; null if still active.',
    `financial_reporting_code` STRING COMMENT 'Code that maps the account to external financial reporting standards (e.g., IFRS, GAAP).',
    `is_budgetable` BOOLEAN COMMENT 'True if the account is included in budgeting and forecasting processes.',
    `is_cash_account` BOOLEAN COMMENT 'True if the account represents cash or cash equivalents.',
    `is_consolidation_account` BOOLEAN COMMENT 'True if the account is used in corporate consolidation reporting.',
    `is_external` BOOLEAN COMMENT 'True if the account is used for external parties (e.g., vendors, customers).',
    `is_intercompany` BOOLEAN COMMENT 'True if the account records intercompany transactions.',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the start of the fiscal period, expressed in the accounts currency.',
    `profit_center_code` STRING COMMENT 'Code linking the account to a profit center for profitability analysis.',
    `tax_reporting_code` STRING COMMENT 'Code used for tax reporting and compliance purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the chart of accounts record.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Master reference table for chart_of_accounts. Referenced by chart_of_accounts_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ADD CONSTRAINT `fk_finance_cost_code_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ADD CONSTRAINT `fk_finance_cost_code_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_construction_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_construction_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_previous_budget_project_budget_id` FOREIGN KEY (`previous_budget_project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_reversed_transaction_job_cost_transaction_id` FOREIGN KEY (`reversed_transaction_job_cost_transaction_id`) REFERENCES `vibe_construction_v1`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_progress_billing_id` FOREIGN KEY (`progress_billing_id`) REFERENCES `vibe_construction_v1`.`finance`.`progress_billing`(`progress_billing_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_parent_company_code_id` FOREIGN KEY (`parent_company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_parent_chart_of_accounts_id` FOREIGN KEY (`parent_chart_of_accounts_id`) REFERENCES `vibe_construction_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_construction_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` SET TAGS ('dbx_subdomain' = 'project_costing');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `budget_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `capitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'labor|material|equipment|subcontract|overhead|indirect');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Posting Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|general_conditions');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `csi_division` SET TAGS ('dbx_business_glossary_term' = 'Construction Specifications Institute (CSI) Division');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `csi_division` SET TAGS ('dbx_value_regex' = '^(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9])$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `discipline_code` SET TAGS ('dbx_business_glossary_term' = 'Discipline Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `evm_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Earned Value Management (EVM) Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_level` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `parent_cost_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'percentage_of_completion|completed_contract|cost_to_cost|units_of_delivery');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|VIEWPOINT_VISTA|PRIMAVERA_P6|PROCORE|MANUAL');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `standard_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `standard_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `wbs_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Compatible Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'project_costing');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct_charge|activity_based|headcount|square_footage|revenue_based|none');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|project_lifecycle');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|capitalized|expensed');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed|suspended');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'project|regional_office|corporate_overhead|shared_service|support_function|operational');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `overhead_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_class` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Class');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_class` SET TAGS ('dbx_value_regex' = 'balance_sheet|profit_and_loss|statistical');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_short_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Short Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|closed|pending_approval');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Account Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Classification');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_value_regex' = 'operating|investing|financing|not_applicable');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cost_center_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|revenue|not_applicable');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'local|group|transaction|project');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `line_item_display_indicator` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `open_item_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `posting_allowed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `profit_and_loss_classification` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Classification');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `profit_center_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `retained_earnings_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Retained Earnings Account Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `trading_partner_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Required Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `wbs_element_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Required Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Source Timesheet Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'SA|AA|KR|DR|AB|RV');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|posted|parked|reversed|cancelled');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'spot|average|budget|closing');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Header Text');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Credit Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Debit Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `percentage_of_completion` SET TAGS ('dbx_business_glossary_term' = 'Percentage of Completion (POC)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'cost_to_cost|units_delivered|milestones|time_elapsed');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '01|02|03|04|05');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `timesheet_line_id` SET TAGS ('dbx_business_glossary_term' = 'Source Timesheet Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reference');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` SET TAGS ('dbx_subdomain' = 'project_costing');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `previous_budget_project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Budget ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `approved_change_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Change Order (CO) Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|frozen|closed|superseded');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'contract|internal|contingency|management_reserve|baseline|forecast');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Budget Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budgeted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Quantity');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `contingency_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reserve Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `contract_line_item_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item Reference');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `current_approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Current Approved Budget (CAB)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `forecast_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Forecast at Completion (FAC)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `is_baseline_budget` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Budget Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `management_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Management Reserve Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` SET TAGS ('dbx_subdomain' = 'project_costing');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `job_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Job Cost Transaction ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `reversed_transaction_job_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `timesheet_line_id` SET TAGS ('dbx_business_glossary_term' = 'Source Timesheet Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `base_currency_cost` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Cost');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `billed_flag` SET TAGS ('dbx_business_glossary_term' = 'Billed Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'labor|material|equipment|subcontractor|overhead|indirect');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `job_cost_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|posted|approved|reversed|cancelled');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` SET TAGS ('dbx_subdomain' = 'billing_payments');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `progress_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Billing ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `master_services_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Services Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `progress_update_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Update Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `amount_received` SET TAGS ('dbx_business_glossary_term' = 'Amount Received');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `client_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Client Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `current_period_claim` SET TAGS ('dbx_business_glossary_term' = 'Current Period Claim');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `engineer_approval_name` SET TAGS ('dbx_business_glossary_term' = 'Engineer Approval Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `gross_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount Due');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `invoice_due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `materials_stored_on_site` SET TAGS ('dbx_business_glossary_term' = 'Materials Stored On-Site');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `net_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_application_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_certificate_type` SET TAGS ('dbx_value_regex' = 'interim|final|advance|milestone|retention_release|variation');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `percentage_complete` SET TAGS ('dbx_business_glossary_term' = 'Percentage Complete');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `previous_amount_billed` SET TAGS ('dbx_business_glossary_term' = 'Previous Amount Billed');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `scheduled_value` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Value');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `work_completed_to_date` SET TAGS ('dbx_business_glossary_term' = 'Work Completed to Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` SET TAGS ('dbx_subdomain' = 'billing_payments');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `activity_resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Resource Assignment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|progress_claim|credit_note|debit_note|prepayment|final');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|credit_card|letter_of_credit');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9 ]{3,30}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partial_match|override');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` SET TAGS ('dbx_subdomain' = 'billing_payments');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Record ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accounts Payable Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `progress_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Billing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `subcontract_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Payment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `advance_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `bank_charges` SET TAGS ('dbx_business_glossary_term' = 'Bank Charges');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Clearing Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Clearing Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'not_cleared|cleared|partially_cleared|rejected');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `invoice_references` SET TAGS ('dbx_business_glossary_term' = 'Invoice References');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `partial_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'erp_system|banking_portal|manual_entry|edi|api');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|cheque|cash|letter_of_credit|bank_draft');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_purpose` SET TAGS ('dbx_business_glossary_term' = 'Payment Purpose');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'draft|pending|cleared|failed|cancelled|reversed');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'outgoing|incoming');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_reconciled|reconciled|discrepancy|under_review');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `remittance_advice` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` SET TAGS ('dbx_subdomain' = 'billing_payments');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `lookahead_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `staffing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Staffing Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `advance_drawdown_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Drawdown Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `bond_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Premium Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `bonding_capacity_utilization` SET TAGS ('dbx_business_glossary_term' = 'Bonding Capacity Utilization');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `closing_cash_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Cash Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `credit_facility_utilization` SET TAGS ('dbx_business_glossary_term' = 'Credit Facility Utilization');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `cumulative_cash_position` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Cash Position');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `equipment_hire_amount` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hire Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Forecast Assumptions');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_granularity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Granularity');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_granularity` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_identifier` SET TAGS ('dbx_business_glossary_term' = 'Forecast Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|superseded|archived');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'project_level|corporate_level|wbs_level|contract_level');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecasted_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Inflow Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecasted_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Outflow Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `material_procurement_amount` SET TAGS ('dbx_business_glossary_term' = 'Material Procurement Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `milestone_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `net_cash_flow_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Flow Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `opening_cash_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Cash Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `payroll_amount` SET TAGS ('dbx_business_glossary_term' = 'Payroll Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `peak_funding_requirement` SET TAGS ('dbx_business_glossary_term' = 'Peak Funding Requirement');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `retention_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `s_curve_profile_indicator` SET TAGS ('dbx_business_glossary_term' = 'S-Curve Profile Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `s_curve_profile_indicator` SET TAGS ('dbx_value_regex' = 'front_loaded|linear|back_loaded|custom');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `subcontractor_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Payment Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `variance_to_prior_forecast` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Forecast');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `working_capital_gap` SET TAGS ('dbx_business_glossary_term' = 'Working Capital Gap');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `parent_company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Code Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `parent_company_code_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `financial_reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Standard');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `legal_form` SET TAGS ('dbx_business_glossary_term' = 'Legal Form');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `parent_company_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Chart Of Accounts Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_budgetable` SET TAGS ('dbx_business_glossary_term' = 'Is Budgetable');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_cash_account` SET TAGS ('dbx_business_glossary_term' = 'Is Cash Account');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidation Account');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'Is External');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Is Intercompany');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
