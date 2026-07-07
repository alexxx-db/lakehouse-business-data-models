-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`finance` COMMENT 'SSOT for all project and corporate financial data including job costing, budget vs. actual, GL/AP/AR entries, progress billing, revenue recognition (percentage of completion), cost codes, cost centers, WBS-linked budgets, EVM financial outputs (CPI), cash flow forecasting, P&L (Profit and Loss), and EBITDA reporting. Integrates with SAP S/4HANA and Viewpoint Vista for construction accounting and IFRS/GAAP compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`cost_code` (
    `cost_code_id` BIGINT COMMENT 'Primary key for cost_code',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
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
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code in SAP S/4HANA Finance that this cost code maps to for financial statement reporting. Enables integration between project costing and corporate accounting.. Valid values are `^[0-9]{4,10}$`',
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
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this cost center is dedicated. Nullable for non-project cost centers (corporate overhead, regional offices, shared services). Used to link project-specific cost centers to the project master for WBS (Work Breakdown Structure) integration and job costing.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the manager or executive accountable for the financial performance of this cost center. Used for P&L (Profit and Loss) ownership, budget approval workflows, and variance analysis escalation.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the parent cost center in the organizational hierarchy. Enables roll-up reporting for regional, divisional, and corporate-level P&L (Profit and Loss) and EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) analysis. Nullable for top-level cost centers.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center to which this cost center is assigned. Profit centers aggregate revenue and costs for internal P&L (Profit and Loss) reporting; cost centers roll up into profit centers for EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) calculation.',
    `allocation_method` STRING COMMENT 'The methodology used to allocate or distribute costs from this cost center to other cost objects (projects, WBS (Work Breakdown Structure) elements, or profit centers). Direct charge posts costs explicitly; activity-based uses cost drivers; headcount and square footage are common overhead allocation bases; revenue-based allocates proportionally to project revenue; none indicates no allocation (terminal cost center).. Valid values are `direct_charge|activity_based|headcount|square_footage|revenue_based|none`',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved annual or period budget allocated to this cost center. Used for budget vs. actual variance reporting, CPI (Cost Performance Index) calculation in EVM (Earned Value Management), and financial forecasting.',
    `budget_period` STRING COMMENT 'The time horizon for which the budget amount is defined. Annual budgets align with fiscal year planning; quarterly and monthly budgets support rolling forecasts; project lifecycle budgets span the duration of a construction project from NTP (Notice to Proceed) to handover.. Valid values are `annual|quarterly|monthly|project_lifecycle`',
    `business_area` STRING COMMENT 'The business segment or division to which this cost center is assigned (e.g., Infrastructure, Energy, Commercial, Residential). Used for segment reporting under IFRS 8 and internal divisional P&L (Profit and Loss) analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_category` STRING COMMENT 'Accounting classification of the cost center for financial treatment. Direct centers charge costs to specific projects or WBS (Work Breakdown Structure) elements; indirect centers allocate costs via overhead rates; overhead centers represent corporate G&A (General and Administrative); capitalized centers accumulate costs for asset creation; expensed centers flow directly to P&L (Profit and Loss).. Valid values are `direct|indirect|overhead|capitalized|expensed`',
    `cost_center_code` STRING COMMENT 'The externally-known alphanumeric code identifying the cost center in financial systems and reports. Used in SAP S/4HANA CO-CCA (Cost Center Accounting) for posting and reporting. Typically follows organizational coding standards (e.g., project-based, regional, functional).. Valid values are `^[A-Z0-9]{4,12}$`',
    `company_code` STRING COMMENT 'The legal entity or company code to which this cost center belongs, as defined in SAP S/4HANA Financial Accounting (FI). Used for statutory reporting, intercompany eliminations, and IFRS/GAAP compliance.. Valid values are `^[A-Z0-9]{4}$`',
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
    `construction_project_id` BIGINT COMMENT 'Foreign key reference to the construction project to which this journal entry is allocated. Enables project-level P&L and EBITDA reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry posts to a specific GL account; linking to gl_account master eliminates code duplication and enables consistent account attributes.',
    `assignment_field` STRING COMMENT 'Free-form assignment field used for additional sorting, grouping, or reconciliation purposes (e.g., invoice number, payment reference).',
    `business_area_code` STRING COMMENT 'The business area or division for cross-company code reporting and segment analysis.',
    `company_code` STRING COMMENT 'The legal entity or company code to which this journal entry belongs. Used for consolidation and statutory reporting.',
    `cost_center_code` STRING COMMENT 'The cost center to which costs or revenues are allocated. Used for internal management reporting and cost control.',
    `cost_code` STRING COMMENT 'Construction-specific cost code for detailed job costing. Categorizes costs by type of work (e.g., labor, materials, equipment, subcontractor).',
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
    `wbs_element_code` STRING COMMENT 'The WBS element code linking this journal entry to a specific project phase or deliverable. Enables project-level financial tracking and EVM integration.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this journal entry document in the system.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core double-entry accounting document and its constituent debit/credit line items, capturing all financial postings in the construction enterprises general ledger. Each document contains a header (document number, posting date, document type, reference, reversal indicator) and one or more lines specifying GL account, cost center, WBS element, cost code, debit/credit amount, currency, tax code, and assignment fields. Covers standard accruals, cost allocations, revenue recognition entries (percentage-of-completion per IFRS 15), intercompany eliminations, period-end adjustments, reclassifications, and FX revaluation entries. Sourced from SAP S/4HANA FI-GL and Viewpoint Vista. Provides full project-level financial traceability from trial balance to source transaction for audit and IFRS/GAAP compliance. Owns both header-level and line-level data as a single SSOT.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for this entity representing one leg of a double-entry accounting transaction.',
    `account_id` BIGINT COMMENT 'Reference to the client or customer associated with this line item, if applicable. Used for accounts receivable reconciliation and revenue recognition.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this financial transaction is allocated. Links financial data to project master data for job costing and project P&L.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry lines need to be allocated to a cost center; replace the existing cost_center_code string with a proper foreign key.',
    `hr_employee_id` BIGINT COMMENT 'The system user ID of the person who posted this journal entry line. Provides audit trail for financial transaction accountability.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry line items reference GL accounts; FK provides authoritative account details.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header that contains this line item. Links this line to the overall transaction batch and posting context.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or subcontractor associated with this line item, if applicable. Used for accounts payable reconciliation and vendor spend analysis.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'The monetary amount of this journal entry line in the local reporting currency of the entity. Used for financial statement preparation and local statutory reporting.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'The monetary amount of this journal entry line in the original transaction currency, before any currency conversion. Enables multi-currency accounting and foreign exchange analysis.',
    `assignment_reference` STRING COMMENT 'Additional reference field used for payment allocation, clearing, and reconciliation. Often contains check numbers, wire transfer references, or clearing document numbers.',
    `baseline_amount` DECIMAL(18,2) COMMENT 'The base amount before tax and adjustments, used for payment terms calculation and cash discount determination.',
    `business_area_code` STRING COMMENT 'The business area or division to which this line item is allocated. Supports segment reporting and divisional P&L analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `clearing_date` DATE COMMENT 'The date on which this line item was cleared (matched with a payment or offsetting entry). Null if the item remains open.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing transaction that closed this line item. Used for payment reconciliation and audit trail.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `cost_code` STRING COMMENT 'Construction-specific cost code classifying the nature of the expense (e.g., labor, materials, equipment, subcontractor). Used for job costing and BOQ variance analysis.. Valid values are `^[0-9]{4,8}$`',
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
    `wbs_element_code` STRING COMMENT 'The WBS element code linking this financial transaction to a specific project phase or deliverable. Enables project-level financial tracking and EVM integration.. Valid values are `^[A-Z0-9.-]{6,24}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line item within a journal entry, capturing the GL account, cost center, WBS element, amount, currency, and posting date for each leg of a double-entry transaction. Enables granular drill-down from trial balance to source transaction for audit and IFRS/GAAP compliance. Sourced from SAP S/4HANA FI-GL line item tables.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`project_budget` (
    `project_budget_id` BIGINT COMMENT 'Unique identifier for the project budget record. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Needed to tie budget allocations directly to the governing contract, enabling cost control and variance reporting per agreement.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Budget approval process requires recording which employee approved the budget; essential for audit and compliance reports.',
    `carbon_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_target. Business justification: Carbon‑target management needs financial budget linkage to allocate funds for emissions‑reduction projects.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this budget belongs to. Links to the master project record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project budgets are associated with a cost center; replace the free‑text cost_center column with a foreign key.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Project budgets reference a cost code; replace the free‑text cost_code column with a foreign key to the cost_code master.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: ESG reporting requires linking budget allocations to the ESG report to track spend on sustainability initiatives.',
    `previous_budget_project_budget_id` BIGINT COMMENT 'Reference to the prior version of this budget record if this is a revision. Enables historical tracking and variance analysis across budget versions.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element this budget is assigned to. Enables hierarchical budget tracking aligned with project structure.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` (
    `finance_budget_revision_id` BIGINT COMMENT 'Unique identifier for the budget revision record. Primary key for the finance_budget_revision product.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Revision approval must capture the approving employee for financial control and audit trails.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this budget revision applies. Links to the project master data.',
    `cost_account_id` BIGINT COMMENT 'Reference to the cost account or cost code affected by this revision. Links budget changes to the project cost control structure.',
    `project_change_order_id` BIGINT COMMENT 'Reference to the formal change order that triggered this budget revision, if applicable. Null if the revision is not CO-driven.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element affected by this budget revision. Enables budget tracking at granular work package level.',
    `approval_authority_level` STRING COMMENT 'The organizational level or authority that approved this revision, based on delegation of authority (DOA) thresholds. Essential for governance compliance.. Valid values are `project_manager|program_director|finance_director|cfo|board|client`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or authority who approved the budget revision. Critical for governance and authorization audit trail.',
    `approved_date` DATE COMMENT 'Date when the budget revision received final approval. Null if not yet approved or if rejected.',
    `baseline_version` STRING COMMENT 'Identifier of the budget baseline version that this revision modifies. Enables tracking of budget evolution across multiple baseline snapshots.. Valid values are `^[A-Z0-9._-]{1,20}$`',
    `cash_flow_impact_period` STRING COMMENT 'The fiscal period (YYYY-MM format) in which this budget revision impacts project cash flow forecasting. Critical for liquidity planning.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `client_approval_date` DATE COMMENT 'Date when the client formally approved this budget revision, if client approval was required. Null if not yet approved or not required.',
    `client_approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether this budget revision requires formal client approval per contract terms. True if client sign-off is mandatory.',
    `client_reference_number` STRING COMMENT 'The clients own reference number or approval code for this budget revision, if provided. Facilitates cross-referencing with client systems.',
    `contingency_revision` DECIMAL(18,2) COMMENT 'The portion of the revision amount allocated to or released from project contingency reserves. Critical for risk management and reserve tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget revision record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this revision (e.g., USD, EUR, GBP). Essential for multi-currency project accounting.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which the revised budget becomes effective for cost control and financial reporting. May differ from approval date for retroactive or future-dated revisions.',
    `equipment_cost_revision` DECIMAL(18,2) COMMENT 'The portion of the revision amount allocated to equipment costs (rental, ownership, mobilization). Critical for equipment fleet budget management.',
    `evm_cpi_impact` DECIMAL(18,2) COMMENT 'The calculated impact of this budget revision on the project Cost Performance Index (CPI). Supports EVM analysis and performance forecasting.',
    `impact_on_contract_value` DECIMAL(18,2) COMMENT 'The impact of this revision on the total contract value with the client. Essential for revenue recognition and contract modification accounting per IFRS 15.',
    `impact_on_gmp` DECIMAL(18,2) COMMENT 'The impact of this revision on the project Guaranteed Maximum Price, if applicable. Critical for GMP contract administration and client billing.',
    `indirect_cost_revision` DECIMAL(18,2) COMMENT 'The portion of the revision amount allocated to indirect costs (overhead, general conditions, site facilities). Essential for full project cost accounting.',
    `labor_cost_revision` DECIMAL(18,2) COMMENT 'The portion of the revision amount allocated to labor costs. Enables cost category analysis and Earned Value Management (EVM) reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget revision record was last updated. Essential for change tracking and audit compliance.',
    `material_cost_revision` DECIMAL(18,2) COMMENT 'The portion of the revision amount allocated to material costs. Supports procurement planning and material budget tracking.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or supporting information related to this budget revision. Provides supplementary context for reviewers and auditors.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The budget amount before this revision was applied. Provides baseline for variance calculation and audit trail.',
    `requested_by` STRING COMMENT 'Name or identifier of the person or role who initiated the budget revision request. Provides accountability and audit trail.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'The new budget amount after applying this revision (original_budget_amount + revision_amount). Represents the current approved budget post-revision.',
    `revision_amount` DECIMAL(18,2) COMMENT 'The net change amount for this revision (positive for increase, negative for decrease). Represents the delta applied to the original budget.',
    `revision_number` STRING COMMENT 'Sequential or coded identifier for this budget revision within the project. Provides traceability and audit trail for budget evolution (e.g., REV-001, REV-002).. Valid values are `^[A-Z0-9]{1,20}$`',
    `revision_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the budget revision. Essential for root cause analysis and trend reporting on budget changes. [ENUM-REF-CANDIDATE: co_approved|scope_addition|scope_reduction|rate_escalation|productivity_variance|design_change|site_condition|regulatory_change|force_majeure|value_engineering|owner_directive|schedule_compression|resource_reallocation|market_adjustment|risk_materialized|other — 16 candidates stripped; promote to reference product]',
    `revision_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for the budget revision, providing context and justification for the change. Critical for audit trail and management review.',
    `revision_status` STRING COMMENT 'Current approval workflow status of the budget revision. Tracks the revision through the governance process from draft to final approval or rejection. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|cancelled|superseded — 7 candidates stripped; promote to reference product]',
    `revision_type` STRING COMMENT 'Classification of the budget revision type indicating the nature of the change: baseline (initial approved budget), reforecast (periodic re-estimation), change_order (CO-driven), scope_change (scope modification), management_directive (executive decision), eot_adjustment (Extension of Time cost impact), contingency_release (release of contingency funds), risk_provision (risk allowance adjustment). [ENUM-REF-CANDIDATE: baseline|reforecast|change_order|scope_change|management_directive|eot_adjustment|contingency_release|risk_provision — 8 candidates stripped; promote to reference product]',
    `subcontractor_cost_revision` DECIMAL(18,2) COMMENT 'The portion of the revision amount allocated to subcontractor costs. Supports subcontract management and procurement budget control.',
    `submitted_date` DATE COMMENT 'Date when the budget revision was formally submitted for approval. Marks the start of the approval workflow.',
    CONSTRAINT pk_finance_budget_revision PRIMARY KEY(`finance_budget_revision_id`)
) COMMENT 'Tracks all formal revisions to an approved project budget, capturing the revision number, reason code (change order, scope change, re-baseline, management directive), revised amounts by WBS/cost code, approval workflow status, and effective date. Provides a complete audit trail of budget evolution from original contract value through all approved change orders (COs) and EOT (Extension of Time) cost impacts. Essential for IFRS contract modification accounting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` (
    `job_cost_transaction_id` BIGINT COMMENT 'Unique identifier for the job cost transaction record. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset used or charged in this transaction. Applicable for equipment usage and rental cost transactions.',
    `commitment_item_id` BIGINT COMMENT 'Reference to the commitment line item (from purchase order or subcontract) against which this cost is drawn. Used for commitment vs. actual cost tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this cost transaction is posted.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Job cost transactions are charged to a cost center; FK enforces valid cost center reference.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the employee who performed the work or incurred the cost. Applicable for labor cost transactions sourced from timesheets.',
    `project_change_order_id` BIGINT COMMENT 'Reference to the project change order that authorized this cost, if applicable. Links cost transactions to scope changes and contract modifications.',
    `reversed_transaction_job_cost_transaction_id` BIGINT COMMENT 'Reference to the original job cost transaction that this record reverses or corrects. Null for original transactions.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or subcontractor who provided the goods or services for this transaction. Applicable for material, equipment rental, and subcontractor costs.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element within the project structure against which this cost is charged. Enables hierarchical cost rollup and EVM integration.',
    `approval_status` STRING COMMENT 'The approval workflow status of this cost transaction: pending (awaiting review), approved (validated and committed), or rejected (not accepted).. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this cost transaction. Used for audit trail and accountability.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this cost transaction was approved. Used for audit trail and workflow tracking.',
    `base_currency_cost` DECIMAL(18,2) COMMENT 'The total cost converted to the project or corporate base currency for consolidated financial reporting and P&L analysis.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this cost is billable to the client (true) or non-billable internal cost (false). Used for progress billing and revenue recognition.',
    `billed_flag` BOOLEAN COMMENT 'Indicates whether this cost has been included in a client invoice (true) or remains unbilled (false). Used for work-in-progress and revenue recognition tracking.',
    `cost_category` STRING COMMENT 'High-level classification of the cost transaction type: labor, material, equipment, subcontractor, overhead, or indirect costs.. Valid values are `labor|material|equipment|subcontractor|overhead|indirect`',
    `cost_code` STRING COMMENT 'Standardized cost code identifying the type of work or resource consumed (e.g., labor, material, equipment, subcontractor). Used for job costing classification and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost transaction record was first created in the system. Used for audit trail and data governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP). Required for multi-currency project accounting.. Valid values are `^[A-Z]{3}$`',
    `job_cost_transaction_description` STRING COMMENT 'Free-text description of the cost transaction providing additional context about the work performed, materials used, or services rendered.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the transaction amount to the project base currency. Null if transaction is in base currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (e.g., 2024-Q1, 2024-03) to which this transaction is assigned for financial reporting and period close.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this cost transaction is posted in the ERP system for financial accounting and IFRS/GAAP compliance.',
    `invoice_number` STRING COMMENT 'The vendor invoice number or internal billing document number associated with this cost transaction for accounts payable reconciliation.',
    `modified_by` STRING COMMENT 'The user or system that last modified this cost transaction record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost transaction record was last modified. Used for audit trail and data governance.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this cost transaction, including justifications, clarifications, or special handling instructions.',
    `posting_date` DATE COMMENT 'The date when the transaction was posted to the financial system. May differ from transaction_date due to approval or processing delays.',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with this cost transaction, linking it to procurement commitments and contract management.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`earned_value_record` (
    `earned_value_record_id` BIGINT COMMENT 'Unique identifier for the earned value management record. Primary key for the earned value snapshot.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project. Links this EVM record to the overall project context.',
    `cost_account_id` BIGINT COMMENT 'Reference to the cost account or cost code for which this EVM record is calculated. Enables cost tracking at the granular control account level.',
    `activity_id` BIGINT COMMENT 'The Oracle Primavera P6 activity identifier from which schedule progress data was sourced for this EVM record. Enables traceability to the source scheduling system.',
    `project_baseline_id` BIGINT COMMENT 'Reference to the project baseline against which this EVM record is measured. Links to the approved baseline for performance measurement.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Earned value records are snapshots against an approved project budget; linking provides budget context.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element for which this EVM record is computed. Links to the project work breakdown structure hierarchy.',
    `acwp_actual_cost` DECIMAL(18,2) COMMENT 'The actual costs incurred for the work performed during the reporting period. Sourced from SAP S/4HANA financial actuals.',
    `approval_date` DATE COMMENT 'The date on which this EVM record was approved by the project controls manager or PMO. Null if not yet approved.',
    `approved_by` STRING COMMENT 'The name or identifier of the project controls manager or PMO representative who approved this EVM record.',
    `bac_budget_at_completion` DECIMAL(18,2) COMMENT 'The total authorized budget for the WBS element or cost account. Represents the baseline budget against which performance is measured.',
    `bcwp_earned_value` DECIMAL(18,2) COMMENT 'The budgeted cost of work that has actually been completed as of the data date. Represents the value of work earned based on physical progress.',
    `bcws_planned_value` DECIMAL(18,2) COMMENT 'The authorized budget assigned to scheduled work for this WBS element and reporting period. Represents the planned value of work that should have been completed by the data date.',
    `comments` STRING COMMENT 'Free-text comments or notes from the cost engineer or project controls team regarding this EVM record. May include explanations of variances, forecast assumptions, or corrective actions.',
    `cost_engineer_name` STRING COMMENT 'The name of the cost engineer responsible for providing forecast inputs (ETC, remaining quantities, and rates) for this EVM record.',
    `cost_performance_index` DECIMAL(18,2) COMMENT 'The ratio of earned value to actual cost (BCWP / ACWP). A CPI less than 1.0 indicates cost overrun; greater than 1.0 indicates cost underrun. Key metric for cost efficiency.',
    `cost_variance` DECIMAL(18,2) COMMENT 'The difference between earned value and actual cost (BCWP - ACWP). A negative value indicates cost overrun; a positive value indicates cost underrun.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this EVM record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary values in this EVM record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_date` DATE COMMENT 'The as-of date for this EVM snapshot. Represents the point in time at which progress and cost data were captured for analysis.',
    `eac_calculation_method` STRING COMMENT 'The method used to calculate the EAC for this record. Options include CPI-based projection, SPI/CPI composite, bottom-up cost engineer forecast, management estimate, or atypical variance adjustment.. Valid values are `cpi_based|spi_cpi_composite|bottom_up_forecast|management_estimate|atypical_variance`',
    `eac_estimate_at_completion` DECIMAL(18,2) COMMENT 'The forecasted total cost of the WBS element or cost account at completion. Calculated using CPI-based or cost engineer forecast methods.',
    `etc_estimate_to_complete` DECIMAL(18,2) COMMENT 'The forecasted cost required to complete the remaining work from the data date. Derived from cost engineer inputs for remaining quantities and rates.',
    `forecast_confidence_level` STRING COMMENT 'The cost engineers confidence level in the ETC and EAC forecast for this record. Indicates the reliability of the cost-to-complete estimate.. Valid values are `high|medium|low`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this EVM record was last modified. Audit trail for record updates.',
    `percent_complete` DECIMAL(18,2) COMMENT 'The percentage of work completed for this WBS element or cost account as of the data date. Calculated as (BCWP / BAC) * 100.',
    `percent_spent` DECIMAL(18,2) COMMENT 'The percentage of budget spent as of the data date. Calculated as (ACWP / BAC) * 100.',
    `record_status` STRING COMMENT 'The current lifecycle status of this EVM record. Indicates whether the record is in draft, submitted for review, approved, revised, or closed.. Valid values are `draft|submitted|approved|revised|closed`',
    `remaining_work_quantity` DECIMAL(18,2) COMMENT 'The quantity of work remaining to be completed for this cost account. Input by cost engineers for ETC calculation. Units vary by work type (e.g., cubic meters, linear meters, hours).',
    `remaining_work_unit_rate` DECIMAL(18,2) COMMENT 'The forecasted unit rate for remaining work. Input by cost engineers to calculate ETC. Represents cost per unit of work (e.g., cost per cubic meter, cost per hour).',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period for which this EVM snapshot was computed. Defines the close of the measurement window.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period for which this EVM snapshot was computed. Defines the beginning of the measurement window.',
    `sap_wbs_element_code` STRING COMMENT 'The SAP S/4HANA WBS element code from which actual cost data (ACWP) was sourced. Enables traceability to the source ERP system.',
    `schedule_performance_index` DECIMAL(18,2) COMMENT 'The ratio of earned value to planned value (BCWP / BCWS). An SPI less than 1.0 indicates the project is behind schedule; greater than 1.0 indicates ahead of schedule.',
    `schedule_variance` DECIMAL(18,2) COMMENT 'The difference between earned value and planned value (BCWP - BCWS). A negative value indicates the project is behind schedule; a positive value indicates ahead of schedule.',
    `tcpi_to_complete_performance_index` DECIMAL(18,2) COMMENT 'The cost performance index required to achieve the budget at completion or estimate at completion. Calculated as (BAC - BCWP) / (BAC - ACWP) or (BAC - BCWP) / (EAC - ACWP).',
    `vac_variance_at_completion` DECIMAL(18,2) COMMENT 'The difference between the budget at completion and the estimate at completion (BAC - EAC). Indicates the expected cost overrun or underrun at project completion.',
    CONSTRAINT pk_earned_value_record PRIMARY KEY(`earned_value_record_id`)
) COMMENT 'Periodic EVM (Earned Value Management) snapshot record computed at the WBS/cost code level for each reporting period. Captures BCWS (Planned Value), BCWP (Earned Value), ACWP (Actual Cost), SV, CV, CPI, SPI, EAC, ETC (Estimate to Complete), VAC, and TCPI (To-Complete Performance Index). Includes cost engineer forecast inputs for remaining work quantities and rates. Integrates Oracle Primavera P6 schedule progress with SAP S/4HANA cost actuals. The authoritative source for EVM financial outputs and cost-to-complete analysis per PMI/ANSI 748 standard.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`progress_billing` (
    `progress_billing_id` BIGINT COMMENT 'Unique identifier for the progress billing record. Primary key for the progress billing entity.',
    `account_id` BIGINT COMMENT 'Reference to the client account being billed for this progress payment.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this progress billing is issued.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this progress billing is issued.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Progress billing amounts are charged to a cost center for cost tracking.',
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
    `invoice_number` STRING COMMENT 'Formal accounts receivable (AR) tax invoice number issued after payment certificate approval, used for financial accounting and collection tracking.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` (
    `revenue_recognition_entry_id` BIGINT COMMENT 'Unique identifier for the revenue recognition entry record.',
    `agreement_id` BIGINT COMMENT 'Reference to the construction contract for which revenue is being recognized.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project associated with this revenue recognition entry.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue recognition entries need to be allocated to a cost center for reporting.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Revenue recognition entries are created by finance staff; employee link enables accountability and IFRS/GAAP audit.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Revenue recognition entries need to reference the project budget to align recognized revenue with budgeted amounts.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element for which revenue is being recognized, enabling granular revenue tracking at the work package level.',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment made to a previously posted revenue recognition entry, including changes to cost estimates, contract modifications, or error corrections.',
    `auditor_reviewed_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition entry has been reviewed and validated by internal or external auditors as part of financial statement audit procedures.',
    `billed_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount billed to the client from contract inception through the end of the current recognition period, based on progress billing milestones or payment schedules.',
    `change_order_value_included` DECIMAL(18,2) COMMENT 'Cumulative value of approved change orders included in the contract value for this recognition period. Change orders modify the transaction price and must be accounted for under IFRS 15 / ASC 606 contract modification guidance.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'The percentage of contract completion calculated using the cost-to-cost method (cumulative costs incurred divided by estimated total costs), expressed as a percentage (0.00 to 100.00). This is the primary input for revenue recognition under the percentage-of-completion method.',
    `contract_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value and all monetary amounts in this entry.. Valid values are `^[A-Z]{3}$`',
    `contract_value` DECIMAL(18,2) COMMENT 'The total contract value (transaction price) as defined under IFRS 15 / ASC 606, representing the amount of consideration the entity expects to be entitled to in exchange for transferring promised goods or services.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition entry record was first created in the system.',
    `cumulative_costs_incurred` DECIMAL(18,2) COMMENT 'Total costs incurred to date on the contract, including direct labor, materials, equipment, subcontractor costs, and allocable indirect costs. Used as the numerator in the cost-to-cost percentage-of-completion calculation.',
    `deferred_revenue` DECIMAL(18,2) COMMENT 'Amount billed to the client but not yet recognized as revenue (contract liability), representing advance payments or over-billing relative to work performed. Calculated as billed to date minus revenue recognized to date when billed exceeds recognized revenue.',
    `estimated_gross_profit_at_completion` DECIMAL(18,2) COMMENT 'Forecasted total gross profit for the contract at completion, calculated as contract value minus estimated total costs. Used for forward-looking profitability analysis and loss recognition.',
    `estimated_total_costs` DECIMAL(18,2) COMMENT 'The current estimate of total costs expected to complete the contract, including all direct and indirect costs. Used as the denominator in the cost-to-cost percentage-of-completion calculation. Updated periodically based on project forecasts.',
    `fiscal_period` STRING COMMENT 'The fiscal period (1-12 or 1-13 for companies with 13-period calendars) within the fiscal year to which this revenue recognition entry belongs.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this revenue recognition entry belongs, supporting multi-year contract revenue tracking and financial reporting.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code to which the revenue recognized in period is posted in the financial accounting system.',
    `gross_profit_percentage` DECIMAL(18,2) COMMENT 'Gross profit margin to date expressed as a percentage of revenue recognized to date, calculated as (gross profit to date / revenue recognized to date) * 100.',
    `gross_profit_to_date` DECIMAL(18,2) COMMENT 'Cumulative gross profit recognized on the contract to date, calculated as revenue recognized to date minus cumulative costs incurred.',
    `loss_provision` DECIMAL(18,2) COMMENT 'Provision for anticipated loss on the contract if estimated total costs exceed contract value. Under IFRS 15 / ASC 606, losses on onerous contracts must be recognized immediately in full.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this revenue recognition entry record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition entry record was last modified.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this revenue recognition entry, including explanations of significant variances, estimate changes, or special circumstances.',
    `performance_obligation_description` STRING COMMENT 'Description of the distinct performance obligation(s) within the contract for which revenue is being recognized, as defined under IFRS 15 / ASC 606.',
    `posting_date` DATE COMMENT 'The date on which the revenue recognition entry was posted to the General Ledger, which may differ from the recognition date due to period-end close processes.',
    `prior_period_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this entry represents a correction or adjustment to revenue recognized in a prior accounting period, requiring disclosure under IFRS / GAAP.',
    `profit_center_code` STRING COMMENT 'The profit center code associated with this revenue recognition entry, enabling P&L and EBITDA reporting by business segment or division.',
    `recognition_date` DATE COMMENT 'The specific date on which the revenue recognition entry was recorded in the financial system.',
    `recognition_method` STRING COMMENT 'The method used to measure progress toward complete satisfaction of the performance obligation. Cost-to-cost is the primary method for construction contracts, but other methods may be used when appropriate.. Valid values are `cost_to_cost|units_of_delivery|milestones|time_elapsed`',
    `recognition_period` STRING COMMENT 'The accounting period (YYYY-MM format) for which revenue is being recognized under the percentage-of-completion method.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `retention_held_by_client` DECIMAL(18,2) COMMENT 'Cumulative retention amount withheld by the client from progress billings, typically released upon contract completion or after the Defects Liability Period (DLP). Represents a contract asset under IFRS 15.',
    `revenue_recognition_status` STRING COMMENT 'Current status of the revenue recognition entry in the financial workflow. Draft entries are pending review; posted entries are committed to the GL; adjusted entries have been modified; reversed entries have been backed out; final entries are locked after contract completion.. Valid values are `draft|posted|adjusted|reversed|final`',
    `revenue_recognized_in_period` DECIMAL(18,2) COMMENT 'Revenue recognized in the current accounting period, calculated as the difference between revenue recognized to date and revenue recognized in all prior periods. This is the amount posted to the General Ledger (GL) for the period.',
    `revenue_recognized_to_date` DECIMAL(18,2) COMMENT 'Cumulative revenue recognized from contract inception through the end of the current recognition period, calculated as contract value multiplied by completion percentage.',
    `source_document_number` STRING COMMENT 'The document number or reference identifier in the source system (e.g., SAP RAR document number) that generated this revenue recognition entry.',
    `unbilled_revenue` DECIMAL(18,2) COMMENT 'Revenue recognized but not yet billed to the client (contract asset), calculated as revenue recognized to date minus billed to date. A positive value indicates work performed ahead of billing; a negative value indicates over-billing (contract liability).',
    `created_by` STRING COMMENT 'User ID or name of the person who created this revenue recognition entry record.',
    CONSTRAINT pk_revenue_recognition_entry PRIMARY KEY(`revenue_recognition_entry_id`)
) COMMENT 'Periodic revenue recognition record applying the percentage-of-completion (POC) method per IFRS 15 / ASC 606 to each construction contract. Captures the recognition period, contract value, cumulative costs incurred, estimated total costs, completion percentage (cost-to-cost method), revenue recognized to date, revenue recognized in period, and deferred/unbilled revenue balance. Sourced from SAP S/4HANA Revenue Accounting and Reporting (RAR) module. The authoritative SSOT for construction revenue recognition compliance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key for invoice',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Invoices for permit fees must reference the specific permit to satisfy audit and regulatory reconciliation.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this invoice is charged. Enables job costing and project-level financial reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Accounts payable invoices must be assigned to a cost center for budget control and reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Invoice cost_code column is denormalized; linking to cost_code table enables accurate cost‑code reporting and variance analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accounts payable invoice must be associated with a GL account for posting; FK replaces code string.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order or subcontract against which this invoice is submitted. Used for three-way match validation (PO-GR-Invoice).',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` (
    `accounts_receivable_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts receivable invoice record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the client (project owner) to whom this invoice is issued. Links to the client master data product.',
    `agreement_id` BIGINT COMMENT 'Reference to the construction contract under which this invoice is raised. Links to the contract master agreement product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which work is being billed. Links to the construction project master data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Accounts receivable invoices should be linked to a cost center for reporting and allocation purposes.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accounts receivable invoice posts to GL; FK provides authoritative account data.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element being billed. Enables detailed cost tracking and revenue allocation at the work package level.',
    `aging_bucket` STRING COMMENT 'Classification of the invoice based on the number of days past the due date. Used for accounts receivable aging analysis and collection prioritization.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `amount_paid_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount received from the client against this invoice. Updated as partial or full payments are applied.',
    `billing_period_end_date` DATE COMMENT 'End date of the work period covered by this invoice. Defines the cutoff for work included in this billing cycle.',
    `billing_period_start_date` DATE COMMENT 'Start date of the work period covered by this invoice. Used for progress billing and percentage-of-completion revenue recognition.',
    `client_reference_number` STRING COMMENT 'Client-provided reference number or purchase order number that must appear on the invoice for their accounts payable processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice (e.g., USD, EUR, GBP, AED).. Valid values are `^[A-Z]{3}$`',
    `days_past_due` STRING COMMENT 'Number of calendar days the invoice is overdue. Calculated as current date minus due date for unpaid invoices past their due date.',
    `dispute_date` DATE COMMENT 'Date the client formally raised a dispute against this invoice. Null if no dispute exists.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the invoice is currently under dispute by the client. True if disputed, False otherwise.',
    `dispute_reason` STRING COMMENT 'Description of the reason the client has disputed this invoice. Null if no dispute exists.',
    `due_date` DATE COMMENT 'The contractual date by which payment is expected from the client. Used for aging bucket classification and late payment penalty calculations.',
    `gl_document_number` STRING COMMENT 'Document number assigned by the ERP system when the invoice was posted to the general ledger. Used for audit trail and reconciliation.',
    `gl_posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger in the ERP system. Used for financial period reconciliation.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before tax and retention deductions. Represents the certified value of work completed or milestone achieved.',
    `invoice_date` DATE COMMENT 'The date the invoice was formally issued to the client. This is the principal business event timestamp for revenue recognition and aging calculations.',
    `invoice_description` STRING COMMENT 'Detailed description of the work or milestone being billed. Provides context for the invoice line items and supports client review.',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice number issued to the client. This is the business identifier printed on the invoice document and referenced in payment correspondence.. Valid values are `^[A-Z0-9]{6,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts receivable workflow. Tracks progression from draft through payment to closure or dispute resolution. [ENUM-REF-CANDIDATE: draft|issued|partially_paid|paid|overdue|disputed|cancelled|written_off — 8 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the billing trigger and contract terms. Distinguishes between regular progress claims, milestone payments, variation orders, and retention releases. [ENUM-REF-CANDIDATE: progress_billing|milestone|advance_payment|retention_release|variation_order|final_account|credit_note|debit_note — 8 candidates stripped; promote to reference product]',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received against this invoice. Null if no payments have been received.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified. Updated whenever any field changes. Used for audit trail and change tracking.',
    `net_receivable_amount` DECIMAL(18,2) COMMENT 'Net amount receivable from the client after deducting retention and adding tax. This is the amount expected to be paid by the due date.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Calculated as net receivable amount minus amount paid to date.',
    `payment_certificate_date` DATE COMMENT 'Date the payment certificate was issued by the engineer or client representative. Typically precedes the invoice date.',
    `payment_certificate_number` STRING COMMENT 'Reference number of the payment certificate issued by the engineer or client representative approving the work value. This certificate authorizes the invoice issuance.',
    `payment_method` STRING COMMENT 'The payment instrument or method used by the client to settle this invoice (e.g., bank transfer, wire transfer, check, letter of credit).. Valid values are `bank_transfer|wire_transfer|check|letter_of_credit|direct_debit|cash`',
    `payment_terms` STRING COMMENT 'Contractual payment terms agreed with the client, defining the number of days from invoice date to due date (e.g., Net 30 means payment due within 30 days). [ENUM-REF-CANDIDATE: net_7|net_15|net_30|net_45|net_60|net_90|due_on_receipt|custom — 8 candidates stripped; promote to reference product]',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount withheld by the client as retention per contract terms. Typically a percentage of the gross amount held until project completion or defects liability period (DLP) expiry.',
    `retention_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of the gross amount withheld as retention. Typically ranges from 5% to 10% per FIDIC standard contract terms.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method used for revenue recognition on this invoice. Construction typically uses percentage-of-completion per IFRS 15 and GAAP ASC 606.. Valid values are `percentage_of_completion|completed_contract|milestone|point_in_time`',
    `revenue_recognized_amount` DECIMAL(18,2) COMMENT 'Amount of revenue recognized in the financial statements for this invoice. May differ from gross amount based on revenue recognition method and contract terms.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax (VAT, GST, or sales tax) applied to the invoice. Calculated based on applicable tax rates and jurisdictional rules.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percentage applied to calculate the tax amount. Varies by jurisdiction and project location.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as uncollectible bad debt. Null if not written off.',
    `write_off_date` DATE COMMENT 'Date the outstanding balance was written off as bad debt. Null if not written off.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether the outstanding balance has been written off as uncollectible. True if written off, False otherwise.',
    CONSTRAINT pk_accounts_receivable_invoice PRIMARY KEY(`accounts_receivable_invoice_id`)
) COMMENT 'Client-facing AR (Accounts Receivable) invoice record issued to project owners/clients for certified work, milestone payments, or variation orders. Captures invoice number, client reference, contract reference, invoice date, due date, gross amount, VAT/tax, retention deducted, net receivable, payment status, and aging bucket. Sourced from SAP S/4HANA FI-AR. Distinct from progress_billing (the claim submitted) — this is the formal tax invoice raised after payment certificate approval.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`payment_record` (
    `payment_record_id` BIGINT COMMENT 'Unique identifier for the payment transaction record. Primary key for the payment_record product.',
    `carbon_offset_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset. Business justification: Payments for carbon offsets need to reference the specific offset transaction for reconciliation.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this payment is made or received, enabling project-level cash flow tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payments are allocated to cost centers for cash‑flow forecasting and cost‑center performance tracking.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Payments are applied to a specific AP invoice; FK provides direct linkage for reconciliation.',
    `payment_run_id` BIGINT COMMENT 'Identifier for the batch payment run in which this payment was processed, used for grouping and reconciliation of multiple payments.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Payments of regulatory penalties need to be tied to the originating obligation for traceability and reporting.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or subcontractor receiving the outgoing payment (AP disbursement). Null for incoming payments.',
    `advance_payment_flag` BOOLEAN COMMENT 'Indicates whether this payment is an advance payment made before work completion or goods delivery.',
    `approval_date` DATE COMMENT 'Date when the payment was approved by the authorized approver, marking a key lifecycle event.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the payment transaction, for audit trail and accountability.',
    `bank_charges` DECIMAL(18,2) COMMENT 'Bank fees and transaction charges incurred for processing the payment, may be borne by payer or payee.',
    `bank_reference_number` STRING COMMENT 'Unique reference number assigned by the bank for the payment transaction, used for bank reconciliation and clearing.. Valid values are `^[A-Z0-9]{10,35}$`',
    `clearing_date` DATE COMMENT 'Date when the payment was cleared and confirmed by the bank, indicating successful fund transfer.',
    `clearing_status` STRING COMMENT 'Status of the payment in the bank clearing process, indicating whether funds have been successfully transferred.. Valid values are `not_cleared|cleared|partially_cleared|rejected`',
    `cost_code` STRING COMMENT 'Construction cost code for categorizing the payment within the project cost structure and WBS (Work Breakdown Structure).. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment record was first created in the system, for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount or cash discount amount deducted from the gross payment amount, if applicable.',
    `due_date` DATE COMMENT 'The contractual due date by which the payment should be made or received, based on invoice date and payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert the payment amount to the companys functional currency, if multi-currency transaction.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the companys functional currency using the exchange rate, for consolidated financial reporting.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the payment transaction is posted for financial accounting and P&L reporting.. Valid values are `^[0-9]{4,10}$`',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` (
    `finance_retention_ledger_id` BIGINT COMMENT 'Unique identifier for the retention ledger entry. Primary key for the finance retention ledger.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this retention is held or owed.',
    `billing_period_id` BIGINT COMMENT 'Reference to the billing period during which this retention was withheld or released.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this retention entry applies.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Retention ledger entries should reference the owning cost center for allocation and reporting.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty (client for receivable retention, subcontractor for payable retention).',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element to which this retention entry is allocated for cost control and reporting.',
    `cost_code` STRING COMMENT 'The cost code associated with this retention entry for job costing and financial tracking.',
    `cumulative_retention_balance` DECIMAL(18,2) COMMENT 'The total accumulated retention balance held or owed as of this ledger entry date.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this retention ledger entry.. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this retention entry is under dispute (True if disputed, False otherwise).',
    `dispute_reason` STRING COMMENT 'Description of the reason for retention dispute if the dispute flag is set.',
    `dlp_end_date` DATE COMMENT 'The end date of the Defects Liability Period, after which final retention is typically released.',
    `dlp_start_date` DATE COMMENT 'The start date of the Defects Liability Period, typically commencing at practical completion.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this retention transaction is allocated.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this retention transaction is allocated for financial reporting and budgeting.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code to which this retention entry is posted for financial reporting.',
    `gross_invoice_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before retention is withheld.',
    `invoice_reference_number` STRING COMMENT 'The invoice number or payment application reference associated with this retention withholding or release.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this retention ledger entry, including special conditions or release approvals.',
    `payment_certificate_number` STRING COMMENT 'The payment certificate number issued by the engineer or client authorizing payment and retention withholding.',
    `posting_date` DATE COMMENT 'The date on which this retention entry was posted to the General Ledger for financial reporting.',
    `practical_completion_certificate_date` DATE COMMENT 'The date on which the practical completion certificate was issued, triggering partial retention release and DLP commencement.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this retention ledger record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this retention ledger record was last updated in the data platform.',
    `retention_account_id` BIGINT COMMENT 'SSOT reference to canonical contract.contract_retention_ledger (single source of truth).',
    `retention_bond_indicator` BOOLEAN COMMENT 'Indicates whether a retention bond was provided in lieu of cash retention (True if bond provided, False otherwise).',
    `retention_bond_reference` STRING COMMENT 'Reference number of the retention bond if provided in lieu of cash retention.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'The percentage of the invoice or payment amount withheld as retention (e.g., 5.00 for 5% retention).',
    `retention_release_amount` DECIMAL(18,2) COMMENT 'The amount of retention released in this transaction (partial or full release).',
    `retention_release_date` DATE COMMENT 'The date on which retention was released to the contractor or subcontractor.',
    `retention_release_type` STRING COMMENT 'The type of retention release event: partial release, final release upon practical completion, DLP expiry release, or milestone-based release.. Valid values are `partial|final|dlp_expiry|milestone`',
    `retention_status` STRING COMMENT 'Current status of the retention balance: withheld, partially released, fully released, or disputed.. Valid values are `withheld|partially_released|fully_released|disputed`',
    `retention_type` STRING COMMENT 'Indicates whether this is retention receivable (client owes contractor) or retention payable (contractor owes subcontractor).. Valid values are `receivable|payable`',
    `retention_withheld_amount` DECIMAL(18,2) COMMENT 'The amount withheld as retention for this billing period or transaction.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this retention ledger entry in the source operational system.',
    `transaction_date` DATE COMMENT 'The business date on which this retention ledger transaction occurred (withholding or release event).',
    CONSTRAINT pk_finance_retention_ledger PRIMARY KEY(`finance_retention_ledger_id`)
) COMMENT 'Tracks retention (retainage) balances held by clients against the contractor and held by the contractor against subcontractors. Captures retention withheld per billing period, cumulative retention balance, DLP (Defects Liability Period) release schedule, partial release events, and final release upon practical completion certificate. Manages both receivable retention (client owes contractor) and payable retention (contractor owes subcontractor) in a single ledger. Critical for FIDIC and GMP contract financial management. [SSOT: distinct source of truth for finance domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` (
    `cash_flow_forecast_id` BIGINT COMMENT 'Unique identifier for the cash flow forecast record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Required for cash flow forecasting per contract to align financing with project cash needs; contracts define payment terms used in cash flow models.',
    `climate_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.climate_risk_assessment. Business justification: Cash‑flow forecasts must incorporate quantified climate‑risk financial impacts for risk‑adjusted planning.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this cash flow forecast is prepared. Null for corporate-level forecasts.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cash flow forecasts are prepared per cost center to track cash impact of cost allocations.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Cash‑flow forecasts are prepared by a finance analyst; linking to employee enables responsibility tracking and variance analysis.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` (
    `financial_guarantee_id` BIGINT COMMENT 'Unique identifier for the financial guarantee record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the construction contract for which this guarantee is issued or received.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project associated with this financial guarantee.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial guarantees are tied to a cost center for budgeting and exposure tracking.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Guarantee issuance is recorded by a responsible employee; linking supports traceability and regulatory reporting.',
    `amendment_count` STRING COMMENT 'Number of amendments or modifications made to the original financial guarantee terms.',
    `beneficiary_name` STRING COMMENT 'Name of the party entitled to call or claim against the financial guarantee (typically the client or contractor).',
    `beneficiary_type` STRING COMMENT 'Classification of the beneficiary party: client, contractor, subcontractor, supplier, or joint venture (JV).. Valid values are `client|contractor|subcontractor|supplier|joint_venture`',
    `bonding_capacity_impact_amount` DECIMAL(18,2) COMMENT 'Amount by which this guarantee reduces the organizations available bonding capacity with the surety.',
    `call_conditions` STRING COMMENT 'Detailed description of the conditions under which the beneficiary may call or claim against the financial guarantee.',
    `call_type` STRING COMMENT 'Type of call mechanism: on-demand (unconditional), conditional (requires proof of default), or documentary (requires specific documents).. Valid values are `on_demand|conditional|documentary`',
    `claim_amount` DECIMAL(18,2) COMMENT 'Monetary amount claimed by the beneficiary against the financial guarantee, if a call was made.',
    `claim_date` DATE COMMENT 'Date on which the beneficiary called or claimed against the financial guarantee, if applicable.',
    `collateral_description` STRING COMMENT 'Description of any collateral or security provided to the issuer (e.g., cash deposit, property lien, parent company indemnity).',
    `collateral_required_flag` BOOLEAN COMMENT 'Indicates whether the issuer required collateral or security to issue the guarantee (True) or not (False).',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the financial guarantee meets all contractual and regulatory compliance requirements (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the financial guarantee record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the face value amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which the financial guarantee becomes binding and enforceable.',
    `expiry_date` DATE COMMENT 'Date on which the financial guarantee expires and is no longer enforceable, unless extended or called prior.',
    `external_reference_code` STRING COMMENT 'External reference identifier or document number from the source system or issuing institution.',
    `face_value_amount` DECIMAL(18,2) COMMENT 'The maximum monetary value of the financial guarantee that can be claimed by the beneficiary.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which guarantee premium expenses or liabilities are posted.',
    `guarantee_number` STRING COMMENT 'Externally-known unique reference number assigned by the issuing bank or surety for this financial guarantee instrument.',
    `guarantee_status` STRING COMMENT 'Current lifecycle status of the financial guarantee: active (in force), expired (past expiry date), called (claim made), released (obligation discharged), cancelled (terminated early), or pending (awaiting issuance).. Valid values are `active|expired|called|released|cancelled|pending`',
    `guarantee_type` STRING COMMENT 'Classification of the financial guarantee instrument: performance bond, advance payment guarantee, retention bond, bid bond, parent company guarantee, or letter of credit.. Valid values are `performance_bond|advance_payment_guarantee|retention_bond|bid_bond|parent_company_guarantee|letter_of_credit`',
    `issue_date` DATE COMMENT 'Date on which the financial guarantee was issued and became effective.',
    `issuer_name` STRING COMMENT 'Name of the bank, surety company, or parent company that issued the financial guarantee.',
    `issuer_type` STRING COMMENT 'Type of institution issuing the guarantee: bank, surety company, parent company, or insurance company.. Valid values are `bank|surety_company|parent_company|insurance_company`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the financial guarantee.',
    `last_modified_by` STRING COMMENT 'User or system identifier of the person who last modified the financial guarantee record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the financial guarantee record was last modified in the system.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the financial guarantee.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Total premium or fee paid to the issuer for providing the financial guarantee.',
    `premium_payment_frequency` STRING COMMENT 'Frequency at which premium payments are made: one-time, annual, semi-annual, quarterly, or monthly.. Valid values are `one_time|annual|semi_annual|quarterly|monthly`',
    `premium_rate_percent` DECIMAL(18,2) COMMENT 'Annual premium rate expressed as a percentage of the face value amount.',
    `release_date` DATE COMMENT 'Date on which the financial guarantee was formally released and the obligation discharged.',
    `risk_exposure_amount` DECIMAL(18,2) COMMENT 'Current financial risk exposure represented by this guarantee, used for financial risk reporting and management.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this financial guarantee data originated (e.g., SAP S/4HANA, Viewpoint Vista).',
    `wbs_element_code` STRING COMMENT 'Work Breakdown Structure element code linking the guarantee to a specific project phase or deliverable.',
    `created_by` STRING COMMENT 'User or system identifier of the person who created the financial guarantee record.',
    CONSTRAINT pk_financial_guarantee PRIMARY KEY(`financial_guarantee_id`)
) COMMENT 'Master record for all financial instruments and guarantees issued or received in connection with construction contracts — performance bonds, advance payment guarantees, retention bonds, bid bonds, parent company guarantees, and letters of credit. Captures instrument type, issuing bank/surety, beneficiary, face value, currency, issue date, expiry date, call conditions, amendment history, premium/fee schedule, and current status (active/expired/called/released). Critical for bonding capacity management, surety relationship tracking, FIDIC/EPC contract compliance, and financial risk exposure reporting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Primary key for profit_center',
    `company_code_id` BIGINT COMMENT 'add column company_code_id (BIGINT) with FK to finance.company_code.company_code_id - profit centers belong to company codes',
    `parent_profit_center_id` BIGINT COMMENT 'Self-referencing FK on profit_center (parent_profit_center_id)',
    `actual_profit` DECIMAL(18,2) COMMENT 'Actual profit realized by the profit center.',
    `address_line1` STRING COMMENT 'First line of the profit centers physical address.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget allocated to the profit center for the fiscal period.',
    `profit_center_category` STRING COMMENT 'Business category classification of the profit center.',
    `city` STRING COMMENT 'City of the profit centers primary office.',
    `profit_center_code` STRING COMMENT 'Business code used to identify the profit center in external systems.',
    `cost_center_code` STRING COMMENT 'Associated cost center code used for internal cost allocation.',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'Direct costs attributable to the profit centers revenue.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the profit centers primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `profit_center_description` STRING COMMENT 'Detailed description of the profit centers purpose and scope.',
    `ebit` DECIMAL(18,2) COMMENT 'Earnings before interest and taxes for the profit center.',
    `ebitda` DECIMAL(18,2) COMMENT 'Earnings before interest, taxes, depreciation, and amortization for the profit center.',
    `effective_from` DATE COMMENT 'Date when the profit center became effective for reporting.',
    `effective_to` DATE COMMENT 'Date when the profit center ceased to be effective; null if still active.',
    `external_reference_code` STRING COMMENT 'Identifier of the profit center in external ERP systems (e.g., SAP, Viewpoint).',
    `financial_reporting_standard` STRING COMMENT 'Accounting standard used for the profit centers financial reporting.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the profit centers results are consolidated into higher‑level reporting.',
    `last_reported_date` DATE COMMENT 'Date of the most recent financial report for the profit center.',
    `profit_center_level` STRING COMMENT 'Hierarchical level of the profit center within the organization.',
    `manager` STRING COMMENT 'Name of the manager responsible for the profit center.',
    `profit_center_name` STRING COMMENT 'Human‑readable name of the profit center.',
    `notes` STRING COMMENT 'Free‑form notes related to the profit center.',
    `owner` STRING COMMENT 'Name of the owner or sponsor of the profit center.',
    `phone_number` STRING COMMENT 'Contact telephone number for the profit center.',
    `postal_code` STRING COMMENT 'Postal code for the profit centers address.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center.',
    `profit_center_type` STRING COMMENT 'Category of profit center indicating its organizational role.',
    `profit_margin_percent` DECIMAL(18,2) COMMENT 'Profit margin expressed as a percentage of revenue.',
    `region` STRING COMMENT 'Geographic region where the profit center operates.',
    `reporting_frequency` STRING COMMENT 'How often the profit center reports financial results.',
    `revenue` DECIMAL(18,2) COMMENT 'Total revenue generated by the profit center.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate for the profit centers earnings.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the profit center record.',
    `wbs_code` STRING COMMENT 'WBS code linking the profit center to project budgeting structures.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master reference table for profit_center. Referenced by profit_center_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`billing_period` (
    `billing_period_id` BIGINT COMMENT 'Primary key for billing_period',
    `construction_project_id` BIGINT COMMENT 'Foreign key to project.construction_project.construction_project_id',
    `prior_billing_period_id` BIGINT COMMENT 'Self-referencing FK on billing_period (prior_billing_period_id)',
    `adjustment_reason` STRING COMMENT 'Reason for any post‑close adjustments to the period.',
    `billing_cycle_code` STRING COMMENT 'Code that groups periods into a billing cycle (e.g., monthly cycle code).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing period record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for amounts in this period.',
    `billing_period_description` STRING COMMENT 'Optional free‑text description of the billing period.',
    `due_date` DATE COMMENT 'Standard payment due date for invoices generated in this period.',
    `effective_from` DATE COMMENT 'Date from which the period definition is effective for reporting.',
    `effective_until` DATE COMMENT 'Date until which the period definition remains valid (null for open‑ended).',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter number (1‑4) for the billing period.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the billing period belongs.',
    `is_adjusted` BOOLEAN COMMENT 'Indicates whether the period has been adjusted after initial posting.',
    `is_provisional` BOOLEAN COMMENT 'Indicates if the period is provisional (e.g., before final approval).',
    `payment_due_days` STRING COMMENT 'Number of days from invoice date until payment is due for this period.',
    `period_end_date` DATE COMMENT 'Last calendar date covered by the billing period.',
    `period_name` STRING COMMENT 'Human‑readable name or label for the billing period (e.g., “2024‑01”, “Q1‑2024”).',
    `period_sequence` STRING COMMENT 'Sequential order of the period within the fiscal year.',
    `period_start_date` DATE COMMENT 'First calendar date covered by the billing period.',
    `period_status` STRING COMMENT 'Current lifecycle status of the period.',
    `period_type` STRING COMMENT 'Classification of the billing period length.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing period record.',
    CONSTRAINT pk_billing_period PRIMARY KEY(`billing_period_id`)
) COMMENT 'Master reference table for billing_period. Referenced by billing_period_id.';

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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`commitment_item` (
    `commitment_item_id` BIGINT COMMENT 'Primary key for commitment_item',
    `commitment_id` BIGINT COMMENT 'Identifier of the parent commitment (header) to which this line belongs.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with this commitment line.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Commitment items are charged to a cost center; replace the existing code with a proper foreign key.',
    `parent_commitment_item_id` BIGINT COMMENT 'Self-referencing FK on commitment_item (parent_commitment_item_id)',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (e.g., material, equipment, labor) associated with this commitment line.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external vendor or subcontractor linked to this commitment line.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the commitment line before taxes or discounts.',
    `commitment_item_status` STRING COMMENT 'Current lifecycle status of the commitment line.',
    `commitment_type` STRING COMMENT 'Classification of the commitment line (e.g., budgeted, actual, forecast, change order).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the commitment line record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the amount.',
    `commitment_item_description` STRING COMMENT 'Free‑text description of the commitment line item.',
    `effective_date` DATE COMMENT 'Date on which the commitment line becomes effective.',
    `expiration_date` DATE COMMENT 'Date on which the commitment line expires or is scheduled to end (nullable if open‑ended).',
    `line_number` STRING COMMENT 'Sequential order of the line within the commitment.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the resource committed (units defined by unit_of_measure).',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is expressed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the commitment line record.',
    `wbs_code` STRING COMMENT 'WBS element code linking the commitment line to project hierarchy.',
    CONSTRAINT pk_commitment_item PRIMARY KEY(`commitment_item_id`)
) COMMENT 'Master reference table for commitment_item. Referenced by commitment_item_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the payment run.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payment runs are executed for a specific cost center; replace the string code with a foreign key.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the internal user who triggered or approved the run.',
    `prior_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (prior_payment_run_id)',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or subcontractor receiving the payments.',
    `accounting_period` STRING COMMENT 'Fiscal period (e.g., 2024‑03) for financial reporting.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run finished processing.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run actually started processing.',
    `approval_status` STRING COMMENT 'Current approval state of the payment run.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run received final approval.',
    `batch_number` STRING COMMENT 'External batch identifier used by the banking partner or ERP system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the payment run.',
    `payment_run_description` STRING COMMENT 'Free‑form text describing the purpose or context of the payment run.',
    `error_flag` BOOLEAN COMMENT 'True if any payment line in the run failed or was rejected.',
    `error_message` STRING COMMENT 'Human‑readable description of the error when error_flag is true.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Conversion rate applied when the run involves foreign currency.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the payment run was generated automatically by the system.',
    `number_of_payments` STRING COMMENT 'Total count of individual payment transactions included in the run.',
    `payment_channel` STRING COMMENT 'System or interface through which the payment run was initiated.',
    `payment_method` STRING COMMENT 'Instrument used to make the payments.',
    `payment_run_status` STRING COMMENT 'Current processing state of the payment run.',
    `run_number` STRING COMMENT 'Human‑readable sequential number assigned to the payment run.',
    `run_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the payment run was executed.',
    `run_type` STRING COMMENT 'Indicates whether the run is scheduled, ad‑hoc, or recurring.',
    `scheduled_date` DATE COMMENT 'Date on which the payment run was scheduled to occur.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage used to calculate total_tax_amount.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all payment line amounts before taxes and deductions.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount after taxes and deductions; the amount actually paid out.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax amount applied to the payment run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment run record.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`commitment` (
    `commitment_id` BIGINT COMMENT 'Primary key for commitment',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the commitment is allocated.',
    `hr_employee_id` BIGINT COMMENT 'Employee responsible for the commitment.',
    `parent_commitment_id` BIGINT COMMENT 'Self-referencing FK on commitment (parent_commitment_id)',
    `primary_original_commitment_id` BIGINT COMMENT 'Identifier of the original commitment when this record represents an amendment.',
    `project_budget_id` BIGINT COMMENT 'Identifier of the budget line that this commitment draws from.',
    `purchase_order_id` BIGINT COMMENT 'add column purchase_order_id (BIGINT) with FK to procurement.purchase_order.purchase_order_id - commitments are typically backed by POs',
    `vendor_id` BIGINT COMMENT 'Identifier of the external vendor or subcontractor linked to the commitment.',
    `accounting_period` STRING COMMENT 'Period identifier used for financial reporting.',
    `amount_committed` DECIMAL(18,2) COMMENT 'Total monetary value pledged by the commitment.',
    `approval_date` DATE COMMENT 'Date when the commitment received formal approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the commitment.',
    `commitment_category` STRING COMMENT 'High‑level classification indicating whether the commitment is capital‑expenditure or operational‑expenditure.',
    `change_order_number` STRING COMMENT 'Reference number for a change order that modifies the original commitment.',
    `commitment_number` STRING COMMENT 'External reference number or code assigned to the commitment by the originating system (e.g., SAP, Vista).',
    `commitment_status` STRING COMMENT 'Current lifecycle state of the commitment.',
    `commitment_type` STRING COMMENT 'Category of the financial commitment indicating its nature.',
    `cost_center_code` STRING COMMENT 'Code of the cost center charging the commitment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the commitment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the committed amount.',
    `commitment_description` STRING COMMENT 'Free‑form text describing the purpose and scope of the commitment.',
    `effective_from` DATE COMMENT 'Date when the commitment becomes binding.',
    `effective_until` DATE COMMENT 'Date when the commitment ends or expires; null for open‑ended commitments.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the commitment is booked.',
    `gl_account_code` STRING COMMENT 'Chart‑of‑accounts code to which the commitment is posted.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the commitment contains confidential information.',
    `is_retention` BOOLEAN COMMENT 'Indicates whether the commitment includes a retention amount.',
    `last_modified_by` STRING COMMENT 'User identifier who performed the most recent update.',
    `last_modified_date` DATE COMMENT 'Date of the most recent update to the record.',
    `notes` STRING COMMENT 'Additional free‑form remarks or comments about the commitment.',
    `owner_role` STRING COMMENT 'Role of the employee who owns the commitment.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the committed amount held as retention, if applicable.',
    `source` STRING COMMENT 'Originating system or process that created the commitment record.',
    `source_document_number` STRING COMMENT 'Reference number of the originating contract, purchase order, or agreement.',
    `source_document_type` STRING COMMENT 'Type of the originating document that generated the commitment.',
    `status_reason` STRING COMMENT 'Free‑form text explaining the reason for the current status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the commitment record.',
    `version` STRING COMMENT 'Sequential version number for amendments to the commitment.',
    `wbs_code` STRING COMMENT 'WBS element associated with the commitment for detailed budgeting.',
    CONSTRAINT pk_commitment PRIMARY KEY(`commitment_id`)
) COMMENT 'Master reference table for commitment. Referenced by commitment_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` (
    `finance_payment_application_id` BIGINT COMMENT 'Primary key for payment_application.',
    `agreement_id` BIGINT COMMENT '',
    `application_number` STRING COMMENT '',
    `application_status` STRING COMMENT '',
    `billing_period` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `gross_amount` DECIMAL(18,2) COMMENT '',
    `net_amount` DECIMAL(18,2) COMMENT '',
    `retention_amount` DECIMAL(18,2) COMMENT '',
    `submitted_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_finance_payment_application PRIMARY KEY(`finance_payment_application_id`)
) COMMENT 'Required product finance.payment_application ensured by structure enforcement.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` (
    `finance_lien_waiver_id` BIGINT COMMENT 'Primary key for lien_waiver.',
    `agreement_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `signed_date` DATE COMMENT '',
    `through_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `waiver_amount` DECIMAL(18,2) COMMENT '',
    `waiver_number` STRING COMMENT '',
    `waiver_status` STRING COMMENT '',
    `waiver_type` STRING COMMENT '',
    CONSTRAINT pk_finance_lien_waiver PRIMARY KEY(`finance_lien_waiver_id`)
) COMMENT 'Required product finance.lien_waiver ensured by structure enforcement.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ADD CONSTRAINT `fk_finance_cost_code_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_construction_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_construction_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_previous_budget_project_budget_id` FOREIGN KEY (`previous_budget_project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_commitment_item_id` FOREIGN KEY (`commitment_item_id`) REFERENCES `vibe_construction_v1`.`finance`.`commitment_item`(`commitment_item_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_reversed_transaction_job_cost_transaction_id` FOREIGN KEY (`reversed_transaction_job_cost_transaction_id`) REFERENCES `vibe_construction_v1`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_construction_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_billing_period_id` FOREIGN KEY (`billing_period_id`) REFERENCES `vibe_construction_v1`.`finance`.`billing_period`(`billing_period_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ADD CONSTRAINT `fk_finance_financial_guarantee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ADD CONSTRAINT `fk_finance_billing_period_prior_billing_period_id` FOREIGN KEY (`prior_billing_period_id`) REFERENCES `vibe_construction_v1`.`finance`.`billing_period`(`billing_period_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_parent_company_code_id` FOREIGN KEY (`parent_company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_parent_chart_of_accounts_id` FOREIGN KEY (`parent_chart_of_accounts_id`) REFERENCES `vibe_construction_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `vibe_construction_v1`.`finance`.`commitment`(`commitment_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_parent_commitment_item_id` FOREIGN KEY (`parent_commitment_item_id`) REFERENCES `vibe_construction_v1`.`finance`.`commitment_item`(`commitment_item_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_prior_payment_run_id` FOREIGN KEY (`prior_payment_run_id`) REFERENCES `vibe_construction_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ADD CONSTRAINT `fk_finance_commitment_parent_commitment_id` FOREIGN KEY (`parent_commitment_id`) REFERENCES `vibe_construction_v1`.`finance`.`commitment`(`commitment_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ADD CONSTRAINT `fk_finance_commitment_primary_original_commitment_id` FOREIGN KEY (`primary_original_commitment_id`) REFERENCES `vibe_construction_v1`.`finance`.`commitment`(`commitment_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ADD CONSTRAINT `fk_finance_commitment_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`finance` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_construction_v1`.`finance` SET TAGS ('pii_domain' = 'finance');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` SET TAGS ('pii_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_center_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `budget_allocation_flag` SET TAGS ('pii_business_glossary_term' = 'Budget Allocation Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `capitalization_flag` SET TAGS ('pii_business_glossary_term' = 'Capitalization Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_category` SET TAGS ('pii_value_regex' = 'labor|material|equipment|subcontract|overhead|indirect');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_status` SET TAGS ('pii_business_glossary_term' = 'Cost Code Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_status` SET TAGS ('pii_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_posting_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Posting Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_type` SET TAGS ('pii_business_glossary_term' = 'Cost Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_type` SET TAGS ('pii_value_regex' = 'direct|indirect|overhead|general_conditions');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `csi_division` SET TAGS ('pii_business_glossary_term' = 'Construction Specifications Institute (CSI) Division');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `csi_division` SET TAGS ('pii_value_regex' = '^(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9])$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_description` SET TAGS ('pii_business_glossary_term' = 'Cost Code Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `discipline_code` SET TAGS ('pii_business_glossary_term' = 'Discipline Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `evm_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Earned Value Management (EVM) Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `gl_account_code` SET TAGS ('pii_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_level` SET TAGS ('pii_business_glossary_term' = 'Cost Code Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `cost_code_name` SET TAGS ('pii_business_glossary_term' = 'Cost Code Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `parent_cost_code` SET TAGS ('pii_business_glossary_term' = 'Parent Cost Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `rate_currency_code` SET TAGS ('pii_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `rate_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `revenue_recognition_method` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `revenue_recognition_method` SET TAGS ('pii_value_regex' = 'percentage_of_completion|completed_contract|cost_to_cost|units_of_delivery');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = 'SAP_S4HANA|VIEWPOINT_VISTA|PRIMAVERA_P6|PROCORE|MANUAL');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `standard_rate` SET TAGS ('pii_business_glossary_term' = 'Standard Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `standard_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `tax_treatment_code` SET TAGS ('pii_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `tax_treatment_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `tax_treatment_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `wbs_compatible_flag` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Compatible Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` SET TAGS ('pii_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('pii_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('pii_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('pii_value_regex' = 'direct_charge|activity_based|headcount|square_footage|revenue_based|none');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('pii_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('pii_value_regex' = 'annual|quarterly|monthly|project_lifecycle');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('pii_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('pii_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('pii_value_regex' = 'direct|indirect|overhead|capitalized|expensed');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('pii_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('pii_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('pii_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('pii_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('pii_value_regex' = 'active|inactive|planned|closed|suspended');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('pii_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('pii_value_regex' = 'project|regional_office|corporate_overhead|shared_service|support_function|operational');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('pii_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('pii_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `functional_area` SET TAGS ('pii_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `is_billable` SET TAGS ('pii_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('pii_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `overhead_rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Overhead Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('pii_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `site_location` SET TAGS ('pii_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('pii_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('pii_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `company_code_id` SET TAGS ('pii_business_glossary_term' = 'Company Code ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_class` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Class');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_class` SET TAGS ('pii_value_regex' = 'balance_sheet|profit_and_loss|statistical');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('pii_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_short_name` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Short Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('pii_value_regex' = 'active|blocked|closed|pending_approval');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('pii_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `alternative_account_number` SET TAGS ('pii_business_glossary_term' = 'Alternative Account Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `alternative_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `alternative_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('pii_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('pii_business_glossary_term' = 'Cash Flow Classification');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('pii_value_regex' = 'operating|investing|financing|not_applicable');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('pii_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cost_center_required_indicator` SET TAGS ('pii_business_glossary_term' = 'Cost Center Required Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('pii_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('pii_value_regex' = 'primary|secondary|revenue|not_applicable');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_indicator` SET TAGS ('pii_business_glossary_term' = 'Cost Element Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `currency_type` SET TAGS ('pii_business_glossary_term' = 'Currency Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `currency_type` SET TAGS ('pii_value_regex' = 'local|group|transaction|project');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('pii_business_glossary_term' = 'Field Status Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('pii_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `line_item_display_indicator` SET TAGS ('pii_business_glossary_term' = 'Line Item Display Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `open_item_management_indicator` SET TAGS ('pii_business_glossary_term' = 'Open Item Management Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `planning_level` SET TAGS ('pii_business_glossary_term' = 'Planning Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `posting_allowed_indicator` SET TAGS ('pii_business_glossary_term' = 'Posting Allowed Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `profit_and_loss_classification` SET TAGS ('pii_business_glossary_term' = 'Profit and Loss (P&L) Classification');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `profit_center_required_indicator` SET TAGS ('pii_business_glossary_term' = 'Profit Center Required Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_indicator` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `retained_earnings_account_indicator` SET TAGS ('pii_business_glossary_term' = 'Retained Earnings Account Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('pii_business_glossary_term' = 'Sort Key');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('pii_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `tolerance_group` SET TAGS ('pii_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `trading_partner_required_indicator` SET TAGS ('pii_business_glossary_term' = 'Trading Partner Required Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `valid_from_date` SET TAGS ('pii_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `valid_to_date` SET TAGS ('pii_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `wbs_element_required_indicator` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Required Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`gl_account` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `assignment_field` SET TAGS ('pii_business_glossary_term' = 'Assignment Field');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `business_area_code` SET TAGS ('pii_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('pii_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `credit_amount` SET TAGS ('pii_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `debit_amount` SET TAGS ('pii_business_glossary_term' = 'Debit Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('pii_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('pii_value_regex' = 'SA|AA|KR|DR|AB|RV');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('pii_business_glossary_term' = 'Entry Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('pii_value_regex' = 'draft|posted|parked|reversed|cancelled');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('pii_value_regex' = 'spot|average|budget|closing');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `header_text` SET TAGS ('pii_business_glossary_term' = 'Header Text');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('pii_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `line_item_text` SET TAGS ('pii_business_glossary_term' = 'Line Item Text');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_credit_amount` SET TAGS ('pii_business_glossary_term' = 'Local Currency Credit Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_debit_amount` SET TAGS ('pii_business_glossary_term' = 'Local Currency Debit Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `percentage_of_completion` SET TAGS ('pii_business_glossary_term' = 'Percentage of Completion (POC)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `posted_by` SET TAGS ('pii_business_glossary_term' = 'Posted By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('pii_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_code` SET TAGS ('pii_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document` SET TAGS ('pii_business_glossary_term' = 'Reference Document');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `revenue_recognition_method` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `revenue_recognition_method` SET TAGS ('pii_value_regex' = 'cost_to_cost|units_delivered|milestones|time_elapsed');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('pii_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('pii_value_regex' = '01|02|03|04|05');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('pii_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_code` SET TAGS ('pii_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `wbs_element_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'User ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('pii_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_transaction_currency` SET TAGS ('pii_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_reference` SET TAGS ('pii_business_glossary_term' = 'Assignment Reference');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_amount` SET TAGS ('pii_business_glossary_term' = 'Baseline Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('pii_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('pii_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('pii_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_code` SET TAGS ('pii_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('pii_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('pii_value_regex' = 'D|C');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('pii_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `entry_timestamp` SET TAGS ('pii_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('pii_business_glossary_term' = 'Line Item Text');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('pii_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('pii_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('pii_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('pii_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('pii_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('pii_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_type` SET TAGS ('pii_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('pii_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('pii_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('pii_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9.-]{6,24}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` SET TAGS ('pii_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `project_budget_id` SET TAGS ('pii_business_glossary_term' = 'Project Budget ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `carbon_target_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Target Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `esg_report_id` SET TAGS ('pii_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `previous_budget_project_budget_id` SET TAGS ('pii_business_glossary_term' = 'Previous Budget ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `approved_change_order_amount` SET TAGS ('pii_business_glossary_term' = 'Approved Change Order (CO) Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `baseline_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_code` SET TAGS ('pii_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_name` SET TAGS ('pii_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_notes` SET TAGS ('pii_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_owner` SET TAGS ('pii_business_glossary_term' = 'Budget Owner');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('pii_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('pii_value_regex' = 'draft|approved|active|frozen|closed|superseded');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_type` SET TAGS ('pii_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_type` SET TAGS ('pii_value_regex' = 'contract|internal|contingency|management_reserve|baseline|forecast');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Budget Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budget_variance_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `budgeted_quantity` SET TAGS ('pii_business_glossary_term' = 'Budgeted Quantity');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `committed_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `contingency_reserve_amount` SET TAGS ('pii_business_glossary_term' = 'Contingency Reserve Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `contract_line_item_reference` SET TAGS ('pii_business_glossary_term' = 'Contract Line Item Reference');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `current_approved_budget` SET TAGS ('pii_business_glossary_term' = 'Current Approved Budget (CAB)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `forecast_at_completion` SET TAGS ('pii_business_glossary_term' = 'Forecast at Completion (FAC)');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `is_baseline_budget` SET TAGS ('pii_business_glossary_term' = 'Is Baseline Budget Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `management_reserve_amount` SET TAGS ('pii_business_glossary_term' = 'Management Reserve Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `original_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ALTER COLUMN `unit_rate` SET TAGS ('pii_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` SET TAGS ('pii_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `finance_budget_revision_id` SET TAGS ('pii_business_glossary_term' = 'Finance Budget Revision Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `cost_account_id` SET TAGS ('pii_business_glossary_term' = 'Cost Account Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `project_change_order_id` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `approval_authority_level` SET TAGS ('pii_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `approval_authority_level` SET TAGS ('pii_value_regex' = 'project_manager|program_director|finance_director|cfo|board|client');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Approved Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `baseline_version` SET TAGS ('pii_business_glossary_term' = 'Budget Baseline Version');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `baseline_version` SET TAGS ('pii_value_regex' = '^[A-Z0-9._-]{1,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `cash_flow_impact_period` SET TAGS ('pii_business_glossary_term' = 'Cash Flow Impact Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `cash_flow_impact_period` SET TAGS ('pii_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `client_approval_date` SET TAGS ('pii_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `client_approval_required` SET TAGS ('pii_business_glossary_term' = 'Client Approval Required Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `client_reference_number` SET TAGS ('pii_business_glossary_term' = 'Client Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `contingency_revision` SET TAGS ('pii_business_glossary_term' = 'Contingency Revision Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Effective Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `equipment_cost_revision` SET TAGS ('pii_business_glossary_term' = 'Equipment Cost Revision Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `evm_cpi_impact` SET TAGS ('pii_business_glossary_term' = 'Earned Value Management (EVM) Cost Performance Index (CPI) Impact');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `impact_on_contract_value` SET TAGS ('pii_business_glossary_term' = 'Impact on Contract Value');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `impact_on_gmp` SET TAGS ('pii_business_glossary_term' = 'Impact on Guaranteed Maximum Price (GMP)');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `indirect_cost_revision` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Revision Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `labor_cost_revision` SET TAGS ('pii_business_glossary_term' = 'Labor Cost Revision Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `material_cost_revision` SET TAGS ('pii_business_glossary_term' = 'Material Cost Revision Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `original_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `requested_by` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Requested By');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `revised_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `revision_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `revision_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `revision_reason_code` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Reason Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `revision_reason_description` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Reason Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `revision_status` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `revision_type` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `subcontractor_cost_revision` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Cost Revision Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ALTER COLUMN `submitted_date` SET TAGS ('pii_business_glossary_term' = 'Budget Revision Submitted Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` SET TAGS ('pii_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `job_cost_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Job Cost Transaction ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `commitment_item_id` SET TAGS ('pii_business_glossary_term' = 'Commitment Item ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `project_change_order_id` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `reversed_transaction_job_cost_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `base_currency_cost` SET TAGS ('pii_business_glossary_term' = 'Base Currency Cost');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `billable_flag` SET TAGS ('pii_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `billed_flag` SET TAGS ('pii_business_glossary_term' = 'Billed Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `cost_category` SET TAGS ('pii_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `cost_category` SET TAGS ('pii_value_regex' = 'labor|material|equipment|subcontractor|overhead|indirect');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `job_cost_transaction_description` SET TAGS ('pii_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `source_transaction_reference` SET TAGS ('pii_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `total_cost` SET TAGS ('pii_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('pii_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_value_regex' = 'draft|posted|approved|reversed|cancelled');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` SET TAGS ('pii_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `earned_value_record_id` SET TAGS ('pii_business_glossary_term' = 'Earned Value Record ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `cost_account_id` SET TAGS ('pii_business_glossary_term' = 'Cost Account ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Oracle Primavera P6 Activity ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `project_baseline_id` SET TAGS ('pii_business_glossary_term' = 'Baseline ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `project_budget_id` SET TAGS ('pii_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `acwp_actual_cost` SET TAGS ('pii_business_glossary_term' = 'Actual Cost of Work Performed (ACWP) / Actual Cost (AC)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'EVM Record Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `bac_budget_at_completion` SET TAGS ('pii_business_glossary_term' = 'Budget at Completion (BAC)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `bcwp_earned_value` SET TAGS ('pii_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP) / Earned Value (EV)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `bcws_planned_value` SET TAGS ('pii_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS) / Planned Value (PV)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'EVM Record Comments');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `cost_engineer_name` SET TAGS ('pii_business_glossary_term' = 'Cost Engineer Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `cost_performance_index` SET TAGS ('pii_business_glossary_term' = 'Cost Performance Index (CPI)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `cost_variance` SET TAGS ('pii_business_glossary_term' = 'Cost Variance (CV)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `data_date` SET TAGS ('pii_business_glossary_term' = 'Data Date (As-Of Date)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `eac_calculation_method` SET TAGS ('pii_business_glossary_term' = 'Estimate at Completion (EAC) Calculation Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `eac_calculation_method` SET TAGS ('pii_value_regex' = 'cpi_based|spi_cpi_composite|bottom_up_forecast|management_estimate|atypical_variance');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `eac_estimate_at_completion` SET TAGS ('pii_business_glossary_term' = 'Estimate at Completion (EAC)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `etc_estimate_to_complete` SET TAGS ('pii_business_glossary_term' = 'Estimate to Complete (ETC)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `forecast_confidence_level` SET TAGS ('pii_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `forecast_confidence_level` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `percent_complete` SET TAGS ('pii_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `percent_spent` SET TAGS ('pii_business_glossary_term' = 'Percent Spent');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'EVM Record Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|revised|closed');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `remaining_work_quantity` SET TAGS ('pii_business_glossary_term' = 'Remaining Work Quantity');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `remaining_work_unit_rate` SET TAGS ('pii_business_glossary_term' = 'Remaining Work Unit Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `sap_wbs_element_code` SET TAGS ('pii_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `schedule_performance_index` SET TAGS ('pii_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `schedule_variance` SET TAGS ('pii_business_glossary_term' = 'Schedule Variance (SV)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `tcpi_to_complete_performance_index` SET TAGS ('pii_business_glossary_term' = 'To-Complete Performance Index (TCPI)');
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ALTER COLUMN `vac_variance_at_completion` SET TAGS ('pii_business_glossary_term' = 'Variance at Completion (VAC)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `progress_billing_id` SET TAGS ('pii_business_glossary_term' = 'Progress Billing ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `project_budget_id` SET TAGS ('pii_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `aging_bucket` SET TAGS ('pii_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `aging_bucket` SET TAGS ('pii_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `amount_received` SET TAGS ('pii_business_glossary_term' = 'Amount Received');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `billing_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `billing_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `certification_date` SET TAGS ('pii_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `client_reference_number` SET TAGS ('pii_business_glossary_term' = 'Client Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `current_period_claim` SET TAGS ('pii_business_glossary_term' = 'Current Period Claim');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `cutoff_date` SET TAGS ('pii_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `engineer_approval_name` SET TAGS ('pii_business_glossary_term' = 'Engineer Approval Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `gross_amount_due` SET TAGS ('pii_business_glossary_term' = 'Gross Amount Due');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `invoice_due_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `materials_stored_on_site` SET TAGS ('pii_business_glossary_term' = 'Materials Stored On-Site');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `net_amount_due` SET TAGS ('pii_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `outstanding_balance` SET TAGS ('pii_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_application_number` SET TAGS ('pii_business_glossary_term' = 'Payment Application Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_certificate_type` SET TAGS ('pii_business_glossary_term' = 'Payment Certificate Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_certificate_type` SET TAGS ('pii_value_regex' = 'interim|final|advance|milestone|retention_release|variation');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_received_date` SET TAGS ('pii_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `payment_terms_days` SET TAGS ('pii_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `percentage_complete` SET TAGS ('pii_business_glossary_term' = 'Percentage Complete');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `previous_amount_billed` SET TAGS ('pii_business_glossary_term' = 'Previous Amount Billed');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `retention_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `scheduled_value` SET TAGS ('pii_business_glossary_term' = 'Scheduled Value');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `tax_rate` SET TAGS ('pii_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ALTER COLUMN `work_completed_to_date` SET TAGS ('pii_business_glossary_term' = 'Work Completed to Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `revenue_recognition_entry_id` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognition Entry ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `project_budget_id` SET TAGS ('pii_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `auditor_reviewed_flag` SET TAGS ('pii_business_glossary_term' = 'Auditor Reviewed Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `billed_to_date` SET TAGS ('pii_business_glossary_term' = 'Billed To Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `change_order_value_included` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Value Included');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `completion_percentage` SET TAGS ('pii_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `contract_currency_code` SET TAGS ('pii_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `contract_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `contract_value` SET TAGS ('pii_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `cumulative_costs_incurred` SET TAGS ('pii_business_glossary_term' = 'Cumulative Costs Incurred');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `deferred_revenue` SET TAGS ('pii_business_glossary_term' = 'Deferred Revenue');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `estimated_gross_profit_at_completion` SET TAGS ('pii_business_glossary_term' = 'Estimated Gross Profit At Completion');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `estimated_total_costs` SET TAGS ('pii_business_glossary_term' = 'Estimated Total Costs');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `gross_profit_percentage` SET TAGS ('pii_business_glossary_term' = 'Gross Profit Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `gross_profit_to_date` SET TAGS ('pii_business_glossary_term' = 'Gross Profit To Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `loss_provision` SET TAGS ('pii_business_glossary_term' = 'Loss Provision');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `performance_obligation_description` SET TAGS ('pii_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `prior_period_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Period Adjustment Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `profit_center_code` SET TAGS ('pii_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `recognition_date` SET TAGS ('pii_business_glossary_term' = 'Recognition Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `recognition_method` SET TAGS ('pii_business_glossary_term' = 'Recognition Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `recognition_method` SET TAGS ('pii_value_regex' = 'cost_to_cost|units_of_delivery|milestones|time_elapsed');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `recognition_period` SET TAGS ('pii_business_glossary_term' = 'Recognition Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `recognition_period` SET TAGS ('pii_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `retention_held_by_client` SET TAGS ('pii_business_glossary_term' = 'Retention Held By Client');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `revenue_recognition_status` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `revenue_recognition_status` SET TAGS ('pii_value_regex' = 'draft|posted|adjusted|reversed|final');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `revenue_recognized_in_period` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognized In Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `revenue_recognized_to_date` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognized To Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `source_document_number` SET TAGS ('pii_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `unbilled_revenue` SET TAGS ('pii_business_glossary_term' = 'Unbilled Revenue');
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_description` SET TAGS ('pii_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `hold_flag` SET TAGS ('pii_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `hold_reason` SET TAGS ('pii_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_value_regex' = 'standard|progress_claim|credit_note|debit_note|prepayment|final');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `net_payable_amount` SET TAGS ('pii_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'wire_transfer|check|ach|credit_card|letter_of_credit');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('pii_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('pii_value_regex' = '^[A-Z0-9 ]{3,30}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `retention_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `tax_rate` SET TAGS ('pii_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_value_regex' = 'matched|unmatched|partial_match|override');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `accounts_receivable_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('pii_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('pii_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `amount_paid_to_date` SET TAGS ('pii_business_glossary_term' = 'Amount Paid to Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `client_reference_number` SET TAGS ('pii_business_glossary_term' = 'Client Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `days_past_due` SET TAGS ('pii_business_glossary_term' = 'Days Past Due');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `dispute_date` SET TAGS ('pii_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `gl_document_number` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `gl_posting_date` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `invoice_description` SET TAGS ('pii_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `net_receivable_amount` SET TAGS ('pii_business_glossary_term' = 'Net Receivable Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('pii_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `payment_certificate_date` SET TAGS ('pii_business_glossary_term' = 'Payment Certificate Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `payment_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Payment Certificate Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'bank_transfer|wire_transfer|check|letter_of_credit|direct_debit|cash');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `retention_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `retention_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Retention Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `revenue_recognition_method` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `revenue_recognition_method` SET TAGS ('pii_value_regex' = 'percentage_of_completion|completed_contract|milestone|point_in_time');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `revenue_recognized_amount` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognized Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `write_off_amount` SET TAGS ('pii_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `write_off_date` SET TAGS ('pii_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ALTER COLUMN `write_off_flag` SET TAGS ('pii_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_record_id` SET TAGS ('pii_business_glossary_term' = 'Payment Record ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `carbon_offset_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Offset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Accounts Payable Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_run_id` SET TAGS ('pii_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `advance_payment_flag` SET TAGS ('pii_business_glossary_term' = 'Advance Payment Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `bank_charges` SET TAGS ('pii_business_glossary_term' = 'Bank Charges');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `bank_reference_number` SET TAGS ('pii_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `bank_reference_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `clearing_date` SET TAGS ('pii_business_glossary_term' = 'Bank Clearing Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `clearing_status` SET TAGS ('pii_business_glossary_term' = 'Bank Clearing Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `clearing_status` SET TAGS ('pii_value_regex' = 'not_cleared|cleared|partially_cleared|rejected');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `cost_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `functional_currency_amount` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `gl_account_code` SET TAGS ('pii_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `invoice_references` SET TAGS ('pii_business_glossary_term' = 'Invoice References');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `net_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `partial_payment_flag` SET TAGS ('pii_business_glossary_term' = 'Partial Payment Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_approval_status` SET TAGS ('pii_business_glossary_term' = 'Payment Approval Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_approval_status` SET TAGS ('pii_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_channel` SET TAGS ('pii_value_regex' = 'erp_system|banking_portal|manual_entry|edi|api');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_document_number` SET TAGS ('pii_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_document_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'wire_transfer|ach|cheque|cash|letter_of_credit|bank_draft');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_notes` SET TAGS ('pii_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_priority` SET TAGS ('pii_business_glossary_term' = 'Payment Priority');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_priority` SET TAGS ('pii_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_purpose` SET TAGS ('pii_business_glossary_term' = 'Payment Purpose');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'draft|pending|cleared|failed|cancelled|reversed');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'outgoing|incoming');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `po_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `po_number` SET TAGS ('pii_value_regex' = '^PO[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'not_reconciled|reconciled|discrepancy|under_review');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `remittance_advice` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `retention_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `value_date` SET TAGS ('pii_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ALTER COLUMN `withholding_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_ssot_master' = 'contract.contract_retention_ledger');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_ssot' = 'finance.finance_retention_ledger');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_ssot_scope' = 'finance');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_ssot_counterpart' = 'contract.contract_retention_ledger');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `finance_retention_ledger_id` SET TAGS ('pii_business_glossary_term' = 'Finance Retention Ledger ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `billing_period_id` SET TAGS ('pii_business_glossary_term' = 'Billing Period ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `cumulative_retention_balance` SET TAGS ('pii_business_glossary_term' = 'Cumulative Retention Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `dlp_end_date` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `dlp_start_date` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `gross_invoice_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `invoice_reference_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `payment_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Payment Certificate Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `practical_completion_certificate_date` SET TAGS ('pii_business_glossary_term' = 'Practical Completion Certificate Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_account_id` SET TAGS ('pii_business_glossary_term' = 'Contract Retention Ledger Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_account_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_account_id` SET TAGS ('pii_ssot' = 'contract.contract_retention_ledger');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_bond_indicator` SET TAGS ('pii_business_glossary_term' = 'Retention Bond Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_bond_reference` SET TAGS ('pii_business_glossary_term' = 'Retention Bond Reference');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_release_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Release Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_release_date` SET TAGS ('pii_business_glossary_term' = 'Retention Release Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_release_type` SET TAGS ('pii_business_glossary_term' = 'Retention Release Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_release_type` SET TAGS ('pii_value_regex' = 'partial|final|dlp_expiry|milestone');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_status` SET TAGS ('pii_business_glossary_term' = 'Retention Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_status` SET TAGS ('pii_value_regex' = 'withheld|partially_released|fully_released|disputed');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_type` SET TAGS ('pii_business_glossary_term' = 'Retention Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_type` SET TAGS ('pii_value_regex' = 'receivable|payable');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `retention_withheld_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Withheld Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ALTER COLUMN `transaction_date` SET TAGS ('pii_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` SET TAGS ('pii_subdomain' = 'treasury_risk');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('pii_business_glossary_term' = 'Cash Flow Forecast ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `climate_risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Climate Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `advance_drawdown_amount` SET TAGS ('pii_business_glossary_term' = 'Advance Drawdown Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `bond_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Bond Premium Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `bonding_capacity_utilization` SET TAGS ('pii_business_glossary_term' = 'Bonding Capacity Utilization');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `closing_cash_balance` SET TAGS ('pii_business_glossary_term' = 'Closing Cash Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `credit_facility_utilization` SET TAGS ('pii_business_glossary_term' = 'Credit Facility Utilization');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `cumulative_cash_position` SET TAGS ('pii_business_glossary_term' = 'Cumulative Cash Position');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `equipment_hire_amount` SET TAGS ('pii_business_glossary_term' = 'Equipment Hire Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_assumptions` SET TAGS ('pii_business_glossary_term' = 'Forecast Assumptions');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_date` SET TAGS ('pii_business_glossary_term' = 'Forecast Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_granularity` SET TAGS ('pii_business_glossary_term' = 'Forecast Granularity');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_granularity` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_identifier` SET TAGS ('pii_business_glossary_term' = 'Forecast Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_status` SET TAGS ('pii_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|superseded|archived');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_type` SET TAGS ('pii_business_glossary_term' = 'Forecast Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_type` SET TAGS ('pii_value_regex' = 'project_level|corporate_level|wbs_level|contract_level');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_version` SET TAGS ('pii_business_glossary_term' = 'Forecast Version');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecasted_inflow_amount` SET TAGS ('pii_business_glossary_term' = 'Forecasted Inflow Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecasted_outflow_amount` SET TAGS ('pii_business_glossary_term' = 'Forecasted Outflow Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `material_procurement_amount` SET TAGS ('pii_business_glossary_term' = 'Material Procurement Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `milestone_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Milestone Payment Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `net_cash_flow_amount` SET TAGS ('pii_business_glossary_term' = 'Net Cash Flow Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `opening_cash_balance` SET TAGS ('pii_business_glossary_term' = 'Opening Cash Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `payroll_amount` SET TAGS ('pii_business_glossary_term' = 'Payroll Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `peak_funding_requirement` SET TAGS ('pii_business_glossary_term' = 'Peak Funding Requirement');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `prepared_by` SET TAGS ('pii_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `retention_release_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Release Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `s_curve_profile_indicator` SET TAGS ('pii_business_glossary_term' = 'S-Curve Profile Indicator');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `s_curve_profile_indicator` SET TAGS ('pii_value_regex' = 'front_loaded|linear|back_loaded|custom');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `subcontractor_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Payment Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `variance_percentage` SET TAGS ('pii_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `variance_to_prior_forecast` SET TAGS ('pii_business_glossary_term' = 'Variance to Prior Forecast');
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ALTER COLUMN `working_capital_gap` SET TAGS ('pii_business_glossary_term' = 'Working Capital Gap');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` SET TAGS ('pii_subdomain' = 'treasury_risk');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `financial_guarantee_id` SET TAGS ('pii_business_glossary_term' = 'Financial Guarantee Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `beneficiary_name` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `beneficiary_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `beneficiary_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `beneficiary_type` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `beneficiary_type` SET TAGS ('pii_value_regex' = 'client|contractor|subcontractor|supplier|joint_venture');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `bonding_capacity_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Bonding Capacity Impact Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `call_conditions` SET TAGS ('pii_business_glossary_term' = 'Call Conditions');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `call_type` SET TAGS ('pii_business_glossary_term' = 'Call Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `call_type` SET TAGS ('pii_value_regex' = 'on_demand|conditional|documentary');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `claim_amount` SET TAGS ('pii_business_glossary_term' = 'Claim Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `claim_date` SET TAGS ('pii_business_glossary_term' = 'Claim Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `collateral_description` SET TAGS ('pii_business_glossary_term' = 'Collateral Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `collateral_required_flag` SET TAGS ('pii_business_glossary_term' = 'Collateral Required Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `face_value_amount` SET TAGS ('pii_business_glossary_term' = 'Face Value Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `guarantee_number` SET TAGS ('pii_business_glossary_term' = 'Guarantee Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `guarantee_status` SET TAGS ('pii_business_glossary_term' = 'Guarantee Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `guarantee_status` SET TAGS ('pii_value_regex' = 'active|expired|called|released|cancelled|pending');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `guarantee_type` SET TAGS ('pii_business_glossary_term' = 'Guarantee Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `guarantee_type` SET TAGS ('pii_value_regex' = 'performance_bond|advance_payment_guarantee|retention_bond|bid_bond|parent_company_guarantee|letter_of_credit');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `issuer_name` SET TAGS ('pii_business_glossary_term' = 'Issuer Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `issuer_type` SET TAGS ('pii_business_glossary_term' = 'Issuer Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `issuer_type` SET TAGS ('pii_value_regex' = 'bank|surety_company|parent_company|insurance_company');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `last_amendment_date` SET TAGS ('pii_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `premium_payment_frequency` SET TAGS ('pii_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `premium_payment_frequency` SET TAGS ('pii_value_regex' = 'one_time|annual|semi_annual|quarterly|monthly');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `premium_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Premium Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `release_date` SET TAGS ('pii_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `risk_exposure_amount` SET TAGS ('pii_business_glossary_term' = 'Risk Exposure Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `wbs_element_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` SET TAGS ('pii_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('pii_business_glossary_term' = 'Profit Center Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('pii_business_glossary_term' = 'Parent Profit Center Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `actual_profit` SET TAGS ('pii_business_glossary_term' = 'Actual Profit');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `actual_profit` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('pii_business_glossary_term' = 'Profit Center Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('pii_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('pii_business_glossary_term' = 'Cost Of Goods Sold');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `ebit` SET TAGS ('pii_business_glossary_term' = 'Ebit');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `ebit` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `ebitda` SET TAGS ('pii_business_glossary_term' = 'Ebitda');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `ebitda` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `financial_reporting_standard` SET TAGS ('pii_business_glossary_term' = 'Financial Reporting Standard');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `is_consolidated` SET TAGS ('pii_business_glossary_term' = 'Is Consolidated');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `last_reported_date` SET TAGS ('pii_business_glossary_term' = 'Last Reported Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_level` SET TAGS ('pii_business_glossary_term' = 'Profit Center Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `manager` SET TAGS ('pii_business_glossary_term' = 'Profit Center Manager');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `owner` SET TAGS ('pii_business_glossary_term' = 'Profit Center Owner');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_margin_percent` SET TAGS ('pii_business_glossary_term' = 'Profit Margin Percent');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `profit_margin_percent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `revenue` SET TAGS ('pii_business_glossary_term' = 'Revenue');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `revenue` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`profit_center` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Wbs Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `billing_period_id` SET TAGS ('pii_business_glossary_term' = 'Billing Period Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `prior_billing_period_id` SET TAGS ('pii_business_glossary_term' = 'Prior Billing Period Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `prior_billing_period_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `billing_cycle_code` SET TAGS ('pii_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `billing_period_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('pii_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `is_adjusted` SET TAGS ('pii_business_glossary_term' = 'Is Adjusted');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `is_provisional` SET TAGS ('pii_business_glossary_term' = 'Is Provisional');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `payment_due_days` SET TAGS ('pii_business_glossary_term' = 'Payment Due Days');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `period_name` SET TAGS ('pii_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `period_sequence` SET TAGS ('pii_business_glossary_term' = 'Period Sequence');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `period_status` SET TAGS ('pii_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `period_type` SET TAGS ('pii_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('pii_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `parent_company_code_id` SET TAGS ('pii_business_glossary_term' = 'Parent Company Code Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `parent_company_code_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `business_area` SET TAGS ('pii_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `classification` SET TAGS ('pii_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_code` SET TAGS ('pii_business_glossary_term' = 'Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `cost_center` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `dissolution_date` SET TAGS ('pii_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `external_reference_number` SET TAGS ('pii_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `financial_reporting_standard` SET TAGS ('pii_business_glossary_term' = 'Financial Reporting Standard');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `incorporation_date` SET TAGS ('pii_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `industry_code` SET TAGS ('pii_business_glossary_term' = 'Industry Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `is_consolidated` SET TAGS ('pii_business_glossary_term' = 'Is Consolidated');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `legal_form` SET TAGS ('pii_business_glossary_term' = 'Legal Form');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `company_code_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `parent_company_code` SET TAGS ('pii_business_glossary_term' = 'Parent Company Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `profit_center` SET TAGS ('pii_business_glossary_term' = 'Profit Center');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `segment` SET TAGS ('pii_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('pii_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`company_code` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Parent Chart Of Accounts Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('pii_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_reporting_code` SET TAGS ('pii_business_glossary_term' = 'Financial Reporting Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_budgetable` SET TAGS ('pii_business_glossary_term' = 'Is Budgetable');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_cash_account` SET TAGS ('pii_business_glossary_term' = 'Is Cash Account');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_consolidation_account` SET TAGS ('pii_business_glossary_term' = 'Is Consolidation Account');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_external` SET TAGS ('pii_business_glossary_term' = 'Is External');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_intercompany` SET TAGS ('pii_business_glossary_term' = 'Is Intercompany');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('pii_business_glossary_term' = 'Normal Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `opening_balance` SET TAGS ('pii_business_glossary_term' = 'Opening Balance');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `profit_center_code` SET TAGS ('pii_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_code` SET TAGS ('pii_business_glossary_term' = 'Tax Reporting Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` SET TAGS ('pii_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `commitment_item_id` SET TAGS ('pii_business_glossary_term' = 'Commitment Item Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `commitment_id` SET TAGS ('pii_business_glossary_term' = 'Commitment Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `parent_commitment_item_id` SET TAGS ('pii_business_glossary_term' = 'Parent Commitment Item Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `parent_commitment_item_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `resource_id` SET TAGS ('pii_business_glossary_term' = 'Resource Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `commitment_item_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `commitment_type` SET TAGS ('pii_business_glossary_term' = 'Commitment Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `commitment_item_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Wbs Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('pii_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `prior_payment_run_id` SET TAGS ('pii_business_glossary_term' = 'Prior Payment Run Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `prior_payment_run_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `accounting_period` SET TAGS ('pii_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `actual_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `error_flag` SET TAGS ('pii_business_glossary_term' = 'Error Flag');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `error_message` SET TAGS ('pii_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `is_automated` SET TAGS ('pii_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `number_of_payments` SET TAGS ('pii_business_glossary_term' = 'Number Of Payments');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `run_number` SET TAGS ('pii_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `run_type` SET TAGS ('pii_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `total_gross_amount` SET TAGS ('pii_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `total_net_amount` SET TAGS ('pii_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `total_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` SET TAGS ('pii_subdomain' = 'cost_control');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `commitment_id` SET TAGS ('pii_business_glossary_term' = 'Commitment Identifier');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Commitment Owner Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `parent_commitment_id` SET TAGS ('pii_business_glossary_term' = 'Parent Commitment Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `parent_commitment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `primary_original_commitment_id` SET TAGS ('pii_business_glossary_term' = 'Original Commitment Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `project_budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `accounting_period` SET TAGS ('pii_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `amount_committed` SET TAGS ('pii_business_glossary_term' = 'Amount Committed');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `commitment_category` SET TAGS ('pii_business_glossary_term' = 'Commitment Category');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `change_order_number` SET TAGS ('pii_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `commitment_number` SET TAGS ('pii_business_glossary_term' = 'Commitment Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `commitment_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `commitment_type` SET TAGS ('pii_business_glossary_term' = 'Commitment Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `commitment_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'Gl Account Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `is_retention` SET TAGS ('pii_business_glossary_term' = 'Is Retention');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `last_modified_date` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `owner_role` SET TAGS ('pii_business_glossary_term' = 'Commitment Owner Role');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Commitment Source');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `source_document_number` SET TAGS ('pii_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `source_document_type` SET TAGS ('pii_business_glossary_term' = 'Source Document Type');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Commitment Version');
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Wbs Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `finance_payment_application_id` SET TAGS ('pii_business_glossary_term' = 'Payment Application Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `application_number` SET TAGS ('pii_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `application_status` SET TAGS ('pii_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `billing_period` SET TAGS ('pii_business_glossary_term' = 'Billing Period');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `retention_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `submitted_date` SET TAGS ('pii_business_glossary_term' = 'Submitted Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` SET TAGS ('pii_subdomain' = 'payment_processing');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `finance_lien_waiver_id` SET TAGS ('pii_business_glossary_term' = 'Lien Waiver Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `signed_date` SET TAGS ('pii_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `through_date` SET TAGS ('pii_business_glossary_term' = 'Through Date');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `waiver_amount` SET TAGS ('pii_business_glossary_term' = 'Waiver Amount');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `waiver_number` SET TAGS ('pii_business_glossary_term' = 'Waiver Number');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `waiver_status` SET TAGS ('pii_business_glossary_term' = 'Waiver Status');
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ALTER COLUMN `waiver_type` SET TAGS ('pii_business_glossary_term' = 'Waiver Type');
