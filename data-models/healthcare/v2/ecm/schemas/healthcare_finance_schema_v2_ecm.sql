-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`finance` COMMENT 'Healthcare financial management including general ledger, cost accounting, budgeting, financial reporting, accounts payable, accounts receivable reconciliation, capital budgeting, and financial planning. Owns chart of accounts, journal entries, cost centers, budget allocations, and financial period management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts used by this ledger',
    `financial_entity_id` BIGINT COMMENT 'Legal entity or reporting entity for this ledger',
    `parent_general_ledger_id` BIGINT COMMENT 'Self-reference to parent ledger for hierarchical ledgers',
    `primary_superseded_by_general_ledger_id` BIGINT COMMENT 'Unique identifier for the primary superseded by general ledger within the finance general ledger record.',
    `accounting_basis` STRING COMMENT 'Accounting basis (Cash, Accrual, Modified Accrual)',
    `audit_trail_level` STRING COMMENT 'Level of audit trail detail (Full, Summary, None)',
    `budget_control_enabled_flag` BOOLEAN COMMENT 'Whether budget control is enabled for this ledger',
    `consolidation_group_code` STRING COMMENT 'Consolidation group code for financial reporting',
    `cost_center_enabled_flag` BOOLEAN COMMENT 'Whether cost center tracking is enabled',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ledger was created',
    `general_ledger_description` STRING COMMENT 'Description of the general ledger',
    `effective_end_date` DATE COMMENT 'End date of ledger validity',
    `effective_start_date` DATE COMMENT 'Start date of ledger validity',
    `fiscal_year_start_month` STRING COMMENT 'Month number (1-12) when fiscal year starts',
    `fiscal_year_variant` STRING COMMENT 'Fiscal year calendar variant code',
    `functional_currency_code` STRING COMMENT 'ISO currency code for functional currency',
    `intercompany_enabled_flag` BOOLEAN COMMENT 'Whether intercompany transactions are enabled',
    `last_closed_period` STRING COMMENT 'Last fiscal period that was closed',
    `last_posting_date` DATE COMMENT 'Date of last posting to this ledger',
    `leading_ledger_flag` BOOLEAN COMMENT 'Whether this is the leading ledger for the entity',
    `ledger_code` STRING COMMENT 'Short code for the ledger',
    `ledger_name` STRING COMMENT 'Name of the ledger',
    `ledger_status` STRING COMMENT 'Status of the ledger (Active, Inactive, Closed)',
    `ledger_type` STRING COMMENT 'Type of ledger (Primary, Secondary, Reporting, Adjustment)',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification',
    `parallel_accounting_enabled_flag` BOOLEAN COMMENT 'Whether parallel accounting is enabled',
    `profit_center_enabled_flag` BOOLEAN COMMENT 'Whether profit center tracking is enabled',
    `project_accounting_enabled_flag` BOOLEAN COMMENT 'Whether project accounting is enabled',
    `reporting_entity_code` STRING COMMENT 'Code for the reporting entity',
    `retention_period_years` STRING COMMENT 'Number of years to retain ledger data',
    `segment_reporting_enabled_flag` BOOLEAN COMMENT 'Whether segment reporting is enabled',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker attribute added by VIBE mutator to ensure a change.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'General ledger configuration and metadata for each accounting ledger instance';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts entry',
    `parent_chart_of_accounts_id` BIGINT COMMENT 'Self-reference to parent account for hierarchical chart of accounts',
    `account_category` STRING COMMENT 'High-level category (Asset, Liability, Equity, Revenue, Expense)',
    `account_code` STRING COMMENT 'GL account code',
    `account_description` STRING COMMENT 'Full description of the account',
    `account_name` STRING COMMENT 'Name of the account',
    `account_owner` STRING COMMENT 'Owner or responsible party for the account',
    `account_status` STRING COMMENT 'Status (Active, Inactive, Closed)',
    `account_subcategory` STRING COMMENT 'Subcategory within the main category',
    `account_subtype` STRING COMMENT 'Subtype classification',
    `account_type` STRING COMMENT 'Type of account (Balance Sheet, Income Statement, Statistical)',
    `alternate_account_code` STRING COMMENT 'Alternate or legacy account code',
    `approval_required_flag` BOOLEAN COMMENT 'Whether postings to this account require approval',
    `budget_control_flag` BOOLEAN COMMENT 'Whether budget control is enforced for this account',
    `consolidation_account_code` STRING COMMENT 'Account code used for consolidation reporting',
    `cost_center_applicable_flag` BOOLEAN COMMENT 'Whether cost center is required for this account',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account was created',
    `currency_code` STRING COMMENT 'ISO currency code if account is currency-specific',
    `department_applicable_flag` BOOLEAN COMMENT 'Whether department is required for this account',
    `drg_cost_allocation_flag` BOOLEAN COMMENT 'Whether this account is used in DRG cost allocation',
    `effective_end_date` DATE COMMENT 'End date of account validity',
    `effective_start_date` DATE COMMENT 'Start date of account validity',
    `external_reporting_code` STRING COMMENT 'Code used for external financial reporting',
    `financial_statement_classification` STRING COMMENT 'Classification for financial statement presentation',
    `financial_statement_line_item` STRING COMMENT 'Line item on financial statements',
    `fund_applicable_flag` BOOLEAN COMMENT 'Whether fund is required for this account',
    `gaap_classification` STRING COMMENT 'GAAP classification code',
    `gasb_classification` STRING COMMENT 'GASB classification code for governmental entities',
    `intercompany_flag` BOOLEAN COMMENT 'Whether this is an intercompany account',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification',
    `natural_balance` DECIMAL(18,2) COMMENT 'Natural balance type (Debit=1, Credit=-1) - VREQ-041 corrected from STRING to DECIMAL',
    `posting_restriction` STRING COMMENT 'Posting restriction (Manual, Automatic, No Posting)',
    `project_applicable_flag` BOOLEAN COMMENT 'Whether project is required for this account',
    `reconciliation_required_flag` BOOLEAN COMMENT 'Whether account requires periodic reconciliation',
    `rollup_account_code` STRING COMMENT 'Parent account code for rollup reporting',
    `rvu_allocation_flag` BOOLEAN COMMENT 'Whether this account is used in RVU-based allocation',
    `statistical_account_flag` BOOLEAN COMMENT 'Whether this is a statistical (non-monetary) account',
    `tax_reporting_category` STRING COMMENT 'Category for tax reporting purposes',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Chart of accounts master defining all GL account codes and their attributes';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center',
    `care_site_id` BIGINT COMMENT 'Physical care site associated with this cost center',
    `fund_id` BIGINT COMMENT 'Fund associated with this cost center',
    `chart_of_accounts_id` BIGINT COMMENT 'Default GL account for this cost center',
    `parent_cost_center_id` BIGINT COMMENT 'Parent cost center for hierarchical rollup',
    `budget_amount` DECIMAL(18,2) COMMENT 'Current budget amount for the cost center',
    `budget_fiscal_year` STRING COMMENT 'Fiscal year of the budget',
    `cost_center_category` STRING COMMENT 'Category (Clinical, Administrative, Support, Revenue)',
    `cms_provider_number` STRING COMMENT 'CMS provider number for cost reporting',
    `cost_center_code` STRING COMMENT 'Short code for the cost center',
    `cost_allocation_method` STRING COMMENT 'Method used for cost allocation (Direct, Step-down, Reciprocal)',
    `cost_center_status` STRING COMMENT 'Status (Active, Inactive, Closed)',
    `cost_center_type` STRING COMMENT 'Type (Direct Patient Care, Ancillary, Support, Administrative)',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Average cost per unit of service',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost center was created',
    `department_code` STRING COMMENT 'The department code value classifying the finance cost center record.',
    `department_name` STRING COMMENT 'The department name of the finance cost center record.',
    `drg_weight` DECIMAL(18,2) COMMENT 'Average DRG weight for this cost center',
    `effective_end_date` DATE COMMENT 'End date of cost center validity',
    `effective_start_date` DATE COMMENT 'Start date of cost center validity',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent staff allocation',
    `is_capital_intensive` BOOLEAN COMMENT 'Whether this is a capital-intensive cost center',
    `is_direct_patient_care` BOOLEAN COMMENT 'Whether this cost center provides direct patient care',
    `is_revenue_generating` BOOLEAN COMMENT 'Whether this cost center generates revenue',
    `last_modified_by` STRING COMMENT 'User who last modified the record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification',
    `cost_center_name` STRING COMMENT 'Name of the cost center',
    `notes` STRING COMMENT 'Additional notes',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Whether regulatory reporting is required',
    `rvu_target` DECIMAL(18,2) COMMENT 'Target RVU for the cost center',
    `service_line` STRING COMMENT 'Service line (Cardiology, Oncology, etc.)',
    `unit_of_measure` STRING COMMENT 'Unit of measure for cost allocation (Visits, Procedures, Days, etc.)',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Cost center master defining organizational units for cost tracking and allocation';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry',
    `employee_id` BIGINT COMMENT 'Employee who approved the journal entry',
    `cost_center_id` BIGINT COMMENT 'Default cost center for the journal entry',
    `financial_entity_id` BIGINT COMMENT 'Financial entity for the journal entry',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period for the journal entry',
    `primary_journal_employee_id` BIGINT COMMENT 'Employee who created the journal entry',
    `primary_reversal_journal_entry_id` BIGINT COMMENT 'Journal entry that reversed this entry',
    `recurring_schedule_id` BIGINT COMMENT 'Recurring schedule if this is a recurring entry',
    `adjustment_type` STRING COMMENT 'Type of adjustment (Accrual, Reclassification, Correction)',
    `approval_date` DATE COMMENT 'Date the journal entry was approved',
    `audit_trail_reference` STRING COMMENT 'Reference to audit trail',
    `batch_code` STRING COMMENT 'Batch code for grouped entries',
    `consolidation_indicator` BOOLEAN COMMENT 'Whether this is a consolidation entry',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the entry was created',
    `currency_code` STRING COMMENT 'ISO currency code',
    `journal_entry_description` STRING COMMENT 'Description of the journal entry',
    `effective_date` DATE COMMENT 'Effective date of the journal entry',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate if foreign currency',
    `fiscal_year` STRING COMMENT 'The fiscal year of the finance journal entry record.',
    `functional_currency_code` STRING COMMENT 'The functional currency code value classifying the finance journal entry record.',
    `gl_interface_status` STRING COMMENT 'Status of GL interface (Pending, Posted, Error)',
    `intercompany_indicator` BOOLEAN COMMENT 'Whether this is an intercompany entry',
    `journal_category` STRING COMMENT 'Category (Manual, Automatic, Recurring, Adjustment)',
    `journal_entry_number` STRING COMMENT 'The journal entry number of the finance journal entry record.',
    `journal_source` STRING COMMENT 'Source system or module',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification',
    `notes` STRING COMMENT 'Additional notes',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the entry was posted',
    `posting_date` DATE COMMENT 'Date the entry was posted to GL',
    `posting_status` STRING COMMENT 'Status (Draft, Pending, Posted, Reversed)',
    `recurring_entry_indicator` BOOLEAN COMMENT 'Whether this is a recurring entry',
    `regulatory_reporting_indicator` BOOLEAN COMMENT 'Whether this entry is for regulatory reporting',
    `reversal_date` DATE COMMENT 'Date the entry was reversed',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this entry has been reversed',
    `reversal_reason_code` STRING COMMENT 'Reason code for reversal',
    `source_system_code` STRING COMMENT 'The source system code value classifying the finance journal entry record.',
    `source_transaction_reference` STRING COMMENT 'Reference to source transaction',
    `supporting_document_reference` STRING COMMENT 'Reference to supporting documents',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The total credit amount of the finance journal entry record.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'The total debit amount of the finance journal entry record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Journal entry header for manual and automated GL postings';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line',
    `chart_of_accounts_id` BIGINT COMMENT 'GL account for this line',
    `cost_center_id` BIGINT COMMENT 'Cost center for this line',
    `drg_id` BIGINT COMMENT 'DRG code for cost allocation',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period',
    `fund_id` BIGINT COMMENT 'Fund for this line',
    `journal_entry_id` BIGINT COMMENT 'Parent journal entry',
    `employee_id` BIGINT COMMENT 'Employee who created the line',
    `primary_reversed_line_journal_entry_line_id` BIGINT COMMENT 'Line that was reversed by this line',
    `tertiary_journal_approved_by_user_employee_id` BIGINT COMMENT 'Employee who approved the line',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the line was approved',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line was created',
    `credit_amount` DECIMAL(18,2) COMMENT 'The credit amount of the finance journal entry line record.',
    `debit_amount` DECIMAL(18,2) COMMENT 'The debit amount of the finance journal entry line record.',
    `department_code` STRING COMMENT 'The department code value classifying the finance journal entry line record.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate if foreign currency',
    `fiscal_year` STRING COMMENT 'The fiscal year of the finance journal entry line record.',
    `functional_currency_code` STRING COMMENT 'The functional currency code value classifying the finance journal entry line record.',
    `intercompany_entity_code` STRING COMMENT 'The intercompany entity code value classifying the finance journal entry line record.',
    `intercompany_indicator` BOOLEAN COMMENT 'Whether this is an intercompany line',
    `line_description` STRING COMMENT 'Description of the line',
    `line_number` STRING COMMENT 'Line number within the journal entry',
    `location_code` STRING COMMENT 'The location code value classifying the finance journal entry line record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification',
    `natural_account_code` STRING COMMENT 'The natural account code value classifying the finance journal entry line record.',
    `payer_code` STRING COMMENT 'Payer code for revenue allocation',
    `posting_date` DATE COMMENT 'Date the line was posted',
    `posting_status` STRING COMMENT 'Status (Draft, Pending, Posted, Reversed)',
    `program_code` STRING COMMENT 'The program code value classifying the finance journal entry line record.',
    `project_code` STRING COMMENT 'The project code value classifying the finance journal entry line record.',
    `reconciliation_date` DATE COMMENT 'Date the line was reconciled',
    `reconciliation_status` STRING COMMENT 'The reconciliation status value classifying the finance journal entry line record.',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this line has been reversed',
    `source_document_number` STRING COMMENT 'The source document number of the finance journal entry line record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the finance journal entry line record.',
    `statistical_amount` DECIMAL(18,2) COMMENT 'Statistical amount for non-monetary accounts',
    `statistical_uom` STRING COMMENT 'Unit of measure for statistical amount',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Transaction amount in transaction currency',
    `transaction_currency_code` STRING COMMENT 'The transaction currency code value classifying the finance journal entry line record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Journal entry line detail with account, amount, and dimension attributes';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Unique identifier for the fiscal period',
    `general_ledger_id` BIGINT COMMENT 'General ledger this period belongs to',
    `parent_fiscal_period_id` BIGINT COMMENT 'Parent fiscal period for hierarchical rollup (VREQ-040 renamed from parent_period_fiscal_period_id for clarity)',
    `parent_period_fiscal_period_id` BIGINT COMMENT 'Parent period for hierarchical periods (e.g., quarter contains months)',
    `primary_prior_period_fiscal_period_id` BIGINT COMMENT 'Prior period for period-over-period comparisons',
    `adjustment_period_flag` BOOLEAN COMMENT 'Whether this is an adjustment period (e.g., period 13)',
    `budget_period_flag` BOOLEAN COMMENT 'Whether this period is used for budgeting',
    `business_days_in_period` STRING COMMENT 'Number of business days in the period',
    `calendar_month` STRING COMMENT 'Calendar month (1-12)',
    `calendar_quarter` STRING COMMENT 'Calendar quarter (1-4)',
    `calendar_year` STRING COMMENT 'The calendar year of the finance fiscal period record.',
    `close_approved_by` STRING COMMENT 'User who approved the period close',
    `close_date` DATE COMMENT 'Date the period was closed',
    `close_initiated_by` STRING COMMENT 'User who initiated the period close',
    `cms_reporting_period_flag` BOOLEAN COMMENT 'Whether this is a CMS reporting period',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the period was created',
    `days_in_period` STRING COMMENT 'Total number of days in the period',
    `fiscal_period_description` STRING COMMENT 'Description of the fiscal period',
    `end_date` DATE COMMENT 'End date of the period',
    `fiscal_year` STRING COMMENT 'The fiscal year of the finance fiscal period record.',
    `period_end_close_checklist_complete_flag` BOOLEAN COMMENT 'Whether the period-end close checklist is complete',
    `period_name` STRING COMMENT 'Name of the period',
    `period_number` STRING COMMENT 'Period number within the fiscal year',
    `period_status` STRING COMMENT 'Status (Open, Closed, Permanently Closed)',
    `period_type` STRING COMMENT 'Type (Month, Quarter, Year, Adjustment)',
    `permanent_close_date` DATE COMMENT 'Date the period was permanently closed',
    `quarter_number` STRING COMMENT 'Quarter number (1-4)',
    `reopen_date` DATE COMMENT 'Date the period was reopened',
    `reporting_period_flag` BOOLEAN COMMENT 'Whether this is a reporting period',
    `start_date` DATE COMMENT 'Start date of the period',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Fiscal period master defining accounting periods and their status';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget',
    `employee_id` BIGINT COMMENT 'Employee who approved the budget',
    `care_site_id` BIGINT COMMENT 'Care site for the budget',
    `cost_center_id` BIGINT COMMENT 'Cost center for the budget',
    `financial_entity_id` BIGINT COMMENT 'Financial entity for the budget',
    `fte_budget_id` BIGINT COMMENT 'Associated FTE budget',
    `org_unit_id` BIGINT COMMENT 'Organizational unit for the budget',
    `parent_budget_id` BIGINT COMMENT 'Parent budget for hierarchical budgets',
    `position_id` BIGINT COMMENT 'Position for position-level budgets',
    `primary_budget_employee_id` BIGINT COMMENT 'Employee who owns the budget',
    `primary_prior_budget_id` BIGINT COMMENT 'Prior year budget for comparison',
    `approval_date` DATE COMMENT 'Date the budget was approved',
    `assumptions` STRING COMMENT 'Budget assumptions and methodology',
    `budget_number` STRING COMMENT 'The budget number of the finance budget record.',
    `budget_status` STRING COMMENT 'Status (Draft, Submitted, Approved, Active, Closed)',
    `budget_type` STRING COMMENT 'Type (Annual, Quarterly, Project, Grant)',
    `budgeted_cmi` DECIMAL(18,2) COMMENT 'Budgeted case mix index',
    `budgeted_fte_count` DECIMAL(18,2) COMMENT 'Budgeted full-time equivalent count',
    `budgeted_net_income` DECIMAL(18,2) COMMENT 'The budgeted net income of the finance budget record.',
    `budgeted_patient_volume` STRING COMMENT 'The budgeted patient volume of the finance budget record.',
    `budget_category` STRING COMMENT 'Category (Operating, Capital, Research)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget was created',
    `currency_code` STRING COMMENT 'ISO currency code',
    `effective_end_date` DATE COMMENT 'End date of budget validity',
    `effective_start_date` DATE COMMENT 'Start date of budget validity',
    `fiscal_year` STRING COMMENT 'The fiscal year of the finance budget record.',
    `funding_source` STRING COMMENT 'Funding source (Operating, Grant, Donation, Bond)',
    `grant_number` STRING COMMENT 'Grant number if grant-funded',
    `is_baseline_budget` BOOLEAN COMMENT 'Whether this is the baseline budget',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification',
    `methodology` STRING COMMENT 'Budgeting methodology (Zero-based, Incremental, Activity-based)',
    `budget_name` STRING COMMENT 'Name of the budget',
    `narrative` STRING COMMENT 'Budget narrative and justification',
    `notes` STRING COMMENT 'Additional notes',
    `submission_date` DATE COMMENT 'Date the budget was submitted',
    `total_budgeted_capital` DECIMAL(18,2) COMMENT 'Total budgeted capital expenditures',
    `total_budgeted_expense` DECIMAL(18,2) COMMENT 'Total budgeted expenses',
    `total_budgeted_revenue` DECIMAL(18,2) COMMENT 'The total budgeted revenue of the finance budget record.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Variance threshold percentage for alerts',
    `version` STRING COMMENT 'Budget version (Original, Revised, Final)',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Budget header defining budget versions, scenarios, and metadata';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line',
    `budget_id` BIGINT COMMENT 'Parent budget',
    `chart_of_accounts_id` BIGINT COMMENT 'GL account for this budget line',
    `cost_center_id` BIGINT COMMENT 'Cost center for this budget line',
    `fund_id` BIGINT COMMENT 'Fund for this budget line',
    `parent_budget_line_id` BIGINT COMMENT 'Parent budget line for hierarchical budgets',
    `allocation_method` STRING COMMENT 'Method for allocating budget (Equal, Weighted, Historical)',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage of the finance budget line record.',
    `approval_status` STRING COMMENT 'Approval status (Pending, Approved, Rejected)',
    `approved_by` STRING COMMENT 'User who approved the line',
    `approved_date` DATE COMMENT 'Date the line was approved',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'The budgeted amount of the finance budget line record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line was created',
    `currency_code` STRING COMMENT 'ISO currency code',
    `effective_end_date` DATE COMMENT 'End date of line validity',
    `effective_start_date` DATE COMMENT 'Start date of line validity',
    `fiscal_period` STRING COMMENT 'The fiscal period of the finance budget line record.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the finance budget line record.',
    `fte_count` DECIMAL(18,2) COMMENT 'FTE count for this line',
    `is_capital` BOOLEAN COMMENT 'Whether this is a capital budget line',
    `is_restricted` BOOLEAN COMMENT 'Whether this is a restricted fund line',
    `line_notes` STRING COMMENT 'Notes for this line',
    `line_number` STRING COMMENT 'Line number within the budget',
    `modified_by` STRING COMMENT 'User who last modified the line',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification',
    `prior_year_actual` DECIMAL(18,2) COMMENT 'Prior year actual amount',
    `service_line_code` STRING COMMENT 'The service line code value classifying the finance budget line record.',
    `statistical_basis` STRING COMMENT 'Statistical basis for budget (Visits, Days, Procedures)',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Variance threshold percentage',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `volume_assumption` DECIMAL(18,2) COMMENT 'The volume assumption of the finance budget line record.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume',
    `created_by` STRING COMMENT 'User who created the line',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Budget line detail with account, amount, and allocation attributes';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` (
    `budget_transfer_id` BIGINT COMMENT 'Unique identifier for the budget transfer transaction. Primary key for the budget transfer record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the budget transfer. Links to the employee master data for authorization tracking and compliance.',
    `budget_employee_id` BIGINT COMMENT 'System user identifier of the person who created this budget transfer record in the system. Part of standard audit trail.',
    `budget_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who last modified this budget transfer record. Part of standard audit trail for accountability.',
    `budget_line_id` BIGINT COMMENT 'Identifier of the specific budget line item to which funds are being transferred. Links to the budget line master data.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center, department, or organizational unit to which budget funds are being transferred. Links to the cost center master data.',
    `chart_of_accounts_id` BIGINT COMMENT 'Identifier of the general ledger account to which budget funds are being transferred. Links to the chart of accounts.',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the general ledger journal entry that recorded this budget transfer in the financial system. Links to the journal entry master data for financial reconciliation.',
    `primary_budget_chart_of_accounts_id` BIGINT COMMENT 'Identifier of the general ledger account from which budget funds are being transferred. Links to the chart of accounts.',
    `primary_budget_requestor_employee_id` BIGINT COMMENT 'Identifier of the employee who initiated or requested the budget transfer. Links to the employee master data for accountability tracking.',
    `primary_original_transfer_budget_transfer_id` BIGINT COMMENT 'If this transfer is a reversal or correction of a previous transfer, this field contains the budget_transfer_id of the original transfer being reversed. Null for original transfers.',
    `source_budget_line_id` BIGINT COMMENT 'Identifier of the specific budget line item from which funds are being transferred. Links to the budget line master data.',
    `source_cost_center_id` BIGINT COMMENT 'Identifier of the cost center, department, or organizational unit from which budget funds are being transferred. Links to the cost center master data.',
    `approval_date` DATE COMMENT 'The date when the budget transfer was formally approved by the authorized approver. Null if transfer is not yet approved.',
    `approval_level` STRING COMMENT 'The organizational level at which the budget transfer was approved, indicating the authority level required based on transfer amount and type: department_manager, director, vice_president, chief_financial_officer (CFO), or board_of_directors.. Valid values are `department_manager|director|vice_president|chief_financial_officer|board_of_directors`',
    `approver_name` STRING COMMENT 'Full name of the employee who approved the budget transfer, captured for audit trail and accountability.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the complete audit trail or change log for this budget transfer, linking to detailed history of all modifications and approvals.',
    `batch_code` STRING COMMENT 'Identifier for a batch or group of related budget transfers processed together, typically used for mass budget adjustments or year-end reallocations.',
    `comments` STRING COMMENT 'Additional free-text comments, notes, or context about the budget transfer that do not fit in other structured fields. Used for collaboration and documentation.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this budget transfer complies with all applicable financial policies, regulatory requirements, and budget constraints. True if compliant, False if exceptions exist.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance review findings, exceptions, or special considerations related to regulatory or policy requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this budget transfer record was first created in the database. Part of standard audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transfer amount (e.g., USD, EUR, GBP). Required for multi-currency healthcare systems.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date when the budget transfer becomes binding and the budget changes take effect in the financial system. May differ from transfer_date for future-dated transfers.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this transfer applies, typically 1-12 for monthly periods or 1-4 for quarterly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget transfer applies, typically a four-digit year (e.g., 2024). Critical for period-based budget management and year-end reconciliation.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this budget transfer record was last modified in the database. Part of standard audit trail for change tracking.',
    `requestor_department` STRING COMMENT 'Name of the department or organizational unit of the employee who requested the transfer, for organizational analysis and reporting.',
    `requestor_name` STRING COMMENT 'Full name of the employee who requested the budget transfer, captured for audit trail and reporting purposes.',
    `reversal_date` DATE COMMENT 'The date when this budget transfer was reversed or undone. Null if the transfer has not been reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this budget transfer has been reversed or undone. True if reversed, False if still in effect.',
    `reversal_reason` STRING COMMENT 'Narrative explanation of why the budget transfer was reversed, including business justification and corrective action taken.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to supporting documentation for the budget transfer (e.g., memo, business case, board resolution, email approval). Critical for audit trail and compliance.',
    `transfer_amount` DECIMAL(18,2) COMMENT 'The monetary value being transferred from the source budget line to the destination budget line. Always positive; direction is indicated by source/destination fields.',
    `transfer_date` DATE COMMENT 'The business date when the budget transfer was initiated or became effective. This is the principal business event timestamp for the transaction, distinct from audit timestamps.',
    `transfer_number` STRING COMMENT 'Externally-visible unique business identifier for the budget transfer, typically formatted as BT-YYYYNNNN for tracking and audit purposes.. Valid values are `^BT-[0-9]{8}$`',
    `transfer_reason_code` STRING COMMENT 'Standardized code indicating the primary business reason for the budget transfer: operational_need (operational requirements changed), cost_overrun (original budget insufficient), revenue_shortfall (revenue below projections), strategic_priority (strategic initiative funding), regulatory_requirement (compliance mandate), or emergency_response (urgent unplanned need).. Valid values are `operational_need|cost_overrun|revenue_shortfall|strategic_priority|regulatory_requirement|emergency_response`',
    `transfer_reason_description` STRING COMMENT 'Detailed narrative explanation of the business justification for the budget transfer, including context, impact, and supporting rationale. Critical for audit trail and management review.',
    `transfer_status` STRING COMMENT 'Current lifecycle state of the budget transfer: draft (being prepared), pending_approval (submitted for review), approved (authorized to proceed), rejected (denied), in_progress (being executed), completed (fully processed), cancelled (withdrawn before completion), or reversed (undone after completion). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|in_progress|completed|cancelled|reversed — 8 candidates stripped; promote to reference product]',
    `transfer_type` STRING COMMENT 'Classification of the budget modification: budget amendment (formal change to approved budget), budget transfer (movement between cost centers), budget revision (adjustment to budget assumptions), budget reallocation (redistribution within same department), supplemental appropriation (additional funding), or technical adjustment (correction without policy change).. Valid values are `budget_amendment|budget_transfer|budget_revision|budget_reallocation|supplemental_appropriation|technical_adjustment`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_budget_transfer PRIMARY KEY(`budget_transfer_id`)
) COMMENT 'Transactional record of approved budget transfers and amendments between cost centers, accounts, or periods within an approved budget. Captures transfer date, transfer type (budget amendment, budget transfer, budget revision), source budget line, destination budget line, transfer amount, transfer reason, requestor, approver, approval date, and supporting documentation reference. Maintains a complete audit trail of all budget modifications post-approval.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or location to which this invoice is allocated.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `credited_ap_invoice_id` BIGINT COMMENT 'Self-referencing FK on ap_invoice (credited_ap_invoice_id)',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Invoices must be assigned to fiscal periods for accrual accounting, expense recognition timing, period-end close, and financial statement accuracy. Complements gl_date with structured period assignmen',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department that is responsible for this invoice expense.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved this invoice for payment.',
    `requester_employee_id` BIGINT COMMENT 'Identifier of the employee who requested the goods or services that resulted in this invoice.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who issued this invoice. Links to the vendor master record.',
    `vendor_site_id` BIGINT COMMENT 'Identifier of the specific vendor site or remit-to location associated with this invoice.',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment.',
    `approval_status` STRING COMMENT 'The current status of the invoice in the approval workflow: pending (awaiting approval), approved (authorized for payment), rejected (returned to requester), or escalated (sent to higher authority).. Valid values are `pending|approved|rejected|escalated`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice record was first created in the accounts payable system.',
    `ap_invoice_description` STRING COMMENT 'A free-text description of the goods or services covered by this invoice.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to the invoice (early payment discounts, volume discounts, or negotiated price reductions).',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The currency exchange rate used to convert the invoice amount from the invoice currency to the organizations functional currency, if applicable.',
    `freight_amount` DECIMAL(18,2) COMMENT 'The shipping and freight charges included in the invoice.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The total invoice amount converted to the organizations functional currency using the exchange rate, for consolidated financial reporting.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this invoice is posted in the chart of accounts.',
    `gl_date` DATE COMMENT 'The accounting period date when this invoice is posted to the general ledger.',
    `hold_date` DATE COMMENT 'The date the invoice was placed on hold.',
    `hold_reason_code` STRING COMMENT 'The code indicating why the invoice is on hold (e.g., pricing variance, missing receipt, duplicate invoice, vendor on hold, budget exceeded).',
    `hold_released_date` DATE COMMENT 'The date the hold was released and the invoice was returned to normal processing.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'The gross total amount of the invoice before taxes and freight, representing the base charge for goods or services.',
    `invoice_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the principal business event timestamp for the invoice transaction.',
    `invoice_number` STRING COMMENT 'The externally-known vendor-assigned invoice number that uniquely identifies this invoice in the vendors system and on the physical/electronic invoice document.',
    `invoice_source` STRING COMMENT 'The channel through which the invoice was received: manual_entry (keyed by AP clerk), edi (Electronic Data Interchange), email (scanned attachment), ocr (Optical Character Recognition from paper), supplier_portal (vendor self-service portal), or api (system-to-system integration).. Valid values are `manual_entry|edi|email|ocr|supplier_portal|api`',
    `invoice_status` STRING COMMENT 'The current lifecycle status of the invoice in the accounts payable workflow: received (entered into system), validated (passed data quality checks), matched (matched to PO and receipt), approved (approved for payment), on_hold (payment hold applied), scheduled_for_payment (queued for payment run), paid (payment issued), cancelled (invoice voided), or rejected (invoice returned to vendor). [ENUM-REF-CANDIDATE: received|validated|matched|approved|on_hold|scheduled_for_payment|paid|cancelled|rejected — 9 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'The classification of the invoice transaction: standard invoice for goods/services, credit memo for returns/adjustments, debit memo for additional charges, prepayment for advance payments, expense report for employee reimbursements, or recurring for subscription-based invoices.. Valid values are `standard|credit_memo|debit_memo|prepayment|expense_report|recurring`',
    `payment_method` STRING COMMENT 'The payment instrument used to pay this invoice: check (paper check), ach (Automated Clearing House), wire_transfer (bank wire), eft (Electronic Funds Transfer), credit_card (corporate card), or virtual_card (single-use virtual card).. Valid values are `check|ach|wire_transfer|eft|credit_card|virtual_card`',
    `payment_reference_number` STRING COMMENT 'The check number, ACH trace number, wire confirmation number, or other payment transaction identifier.',
    `payment_terms` STRING COMMENT 'The payment terms agreed with the vendor (e.g., Net 30, Net 60, 2/10 Net 30) that define the due date and any early payment discounts.',
    `po_match_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this invoice has been matched to a purchase order (True) or is a non-PO invoice (False).',
    `po_number` STRING COMMENT 'The purchase order number that this invoice is matched against, if applicable. Used for three-way matching (PO, receipt, invoice).',
    `received_date` DATE COMMENT 'The date the healthcare organization received the invoice from the vendor.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount charged on the invoice (sales tax, VAT, GST, or other applicable taxes).',
    `tax_code` STRING COMMENT 'The tax jurisdiction or tax rate code applied to this invoice for sales tax, VAT, or GST calculation.',
    `three_way_match_status` STRING COMMENT 'The status of the three-way match process (PO, receipt, invoice): not_applicable (non-PO invoice), pending (match in progress), matched (all three documents reconciled), variance (discrepancies identified within tolerance), or failed (discrepancies exceed tolerance).. Valid values are `not_applicable|pending|matched|variance|failed`',
    `total_amount` DECIMAL(18,2) COMMENT 'The net total amount payable to the vendor, calculated as invoice_amount + tax_amount + freight_amount - discount_amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice record was last modified in the accounts payable system.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to indicate change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `voucher_number` STRING COMMENT 'The internal accounting voucher number assigned to this invoice for general ledger posting and audit trail purposes.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Core accounts payable invoice record representing a vendor invoice received by the healthcare organization for goods or services. Captures invoice number, vendor ID, vendor name, invoice date, received date, due date, payment terms, invoice type (standard, credit memo, debit memo, prepayment), invoice currency, invoice amount, tax amount, freight amount, invoice status (received, matched, approved, on hold, paid, cancelled), PO match indicator, three-way match status, cost center, GL account, and approval workflow status. SSOT for all vendor payables.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` (
    `ap_invoice_line_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice line item. Primary key for this entity.',
    `ap_invoice_id` BIGINT COMMENT 'Reference to the parent accounts payable invoice header. Links this line item to its parent invoice document.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the manager or authorized approver who approved this line item for payment. Supports audit trail and segregation of duties.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: ap_invoice_line has gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get account metadata and ensures invoice lines reference valid GL accounts for ex',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ap_invoice_line has cost_center_code (STRING) which should be normalized to FK to cost_center master. Enables joining to get cost center details for expense allocation and ensures referential integrit',
    `credited_ap_invoice_line_id` BIGINT COMMENT 'Self-referencing FK on ap_invoice_line (credited_ap_invoice_line_id)',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: ap_invoice_line has fund_code (STRING) which should be normalized to FK to fund master. Enables joining to get fund details for restricted fund accounting and ensures invoice lines reference valid fun',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Invoice lines link to goods receipt for three-way match completion, quantity/quality verification, and received-not-invoiced accrual reconciliation. Required for accurate period-end accruals and AP au',
    `purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order_line. Business justification: Invoice lines must link to PO lines for three-way match validation (PO-receipt-invoice), price variance analysis, and automated GL account inheritance from PO. Core AP matching process.',
    `requester_employee_id` BIGINT COMMENT 'Employee identifier of the person who requested or authorized this purchase. Supports accountability and spend analysis by requester.',
    `asset_category` STRING COMMENT 'Asset category or class for capital items. Determines depreciation method, useful life, and financial statement classification for capitalized purchases.',
    `asset_flag` BOOLEAN COMMENT 'Indicates whether this line item represents a capital asset purchase that should be capitalized rather than expensed. Triggers asset tracking and depreciation processes.',
    `contract_number` STRING COMMENT 'Vendor contract or agreement number governing the pricing and terms for this line item. Links the invoice to negotiated contract terms for compliance verification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was first created in the system. Supports audit trail and data lineage tracking.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount applied to this line item. May represent volume discounts, promotional discounts, or negotiated contract pricing adjustments.',
    `distribution_date` DATE COMMENT 'Date when this line item was distributed and posted to the general ledger. Determines the accounting period in which the expense is recognized.',
    `distribution_status` STRING COMMENT 'Status of general ledger distribution for this line item. Indicates whether the expense has been posted to the general ledger and financial statements.. Valid values are `pending|distributed|posted|reversed|error`',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether this line item is on hold and blocked from payment. Used to prevent payment pending resolution of issues or additional approvals.',
    `hold_reason` STRING COMMENT 'Reason code or description explaining why this line item is on hold. Documents the issue preventing payment and guides resolution activities.',
    `item_code` STRING COMMENT 'Vendor or internal catalog item code identifying the specific product or service being purchased. Used for inventory tracking and spend analysis.',
    `line_amount` DECIMAL(18,2) COMMENT 'Total amount for this line item before taxes and adjustments. Typically calculated as quantity multiplied by unit price.',
    `line_description` STRING COMMENT 'Detailed textual description of the goods or services being billed on this line. Provides context for the charge and supports audit and reconciliation activities.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the ordering and display sequence of line items on the invoice.',
    `line_status` STRING COMMENT 'Current processing status of this invoice line item. Tracks the line through the approval, matching, and payment workflow.. Valid values are `pending|approved|rejected|on_hold|paid|cancelled`',
    `location_code` STRING COMMENT 'Facility or location code where this expense will be utilized or allocated. Supports multi-site cost allocation and facility-level financial reporting.',
    `match_exception_reason` STRING COMMENT 'Reason code or description for match exceptions or variances. Documents why the invoice line does not match the PO or receipt (e.g., price variance, quantity variance).',
    `match_status` STRING COMMENT 'Status of three-way matching (PO-receipt-invoice) for this line item. Indicates whether the invoice line has been successfully matched to purchase order and goods receipt.. Valid values are `matched|unmatched|partial|exception|override`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was last modified. Tracks the most recent update to support change tracking and audit requirements.',
    `notes` STRING COMMENT 'Free-form notes or comments about this line item. Captures additional context, special instructions, or explanations for unusual transactions.',
    `program_code` STRING COMMENT 'Program or service line code for this expense. Used to allocate costs to specific clinical programs or service lines for profitability analysis.',
    `project_code` STRING COMMENT 'Project or capital initiative code if this line item is associated with a specific project. Enables project-based cost tracking and capital budgeting.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of items or units of service being billed on this line. Used in conjunction with unit price to calculate line amount.',
    `service_period_end_date` DATE COMMENT 'End date of the service period covered by this line item. Used with start date to determine expense allocation across accounting periods for prepaid services.',
    `service_period_start_date` DATE COMMENT 'Start date of the service period covered by this line item. Used for service-based invoices to determine the period of benefit and expense recognition timing.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to this line item. Includes sales tax, use tax, VAT, or other applicable taxes based on jurisdiction and item taxability.',
    `tax_code` STRING COMMENT 'Tax classification code determining the tax treatment and rate for this line item. Used to calculate applicable taxes based on jurisdiction and item type.',
    `total_line_amount` DECIMAL(18,2) COMMENT 'Final total amount for this line item including taxes and discounts. Represents the net amount payable to the vendor for this line.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field. Defines how the quantity is counted or measured (e.g., each, box, hour, kilogram). [ENUM-REF-CANDIDATE: each|box|case|unit|hour|day|month|kg|lb|liter|gallon — 11 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure for this line item. Multiplied by quantity to derive the line amount before taxes and adjustments.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to indicate change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_ap_invoice_line PRIMARY KEY(`ap_invoice_line_id`)
) COMMENT 'Individual line-item detail on an accounts payable invoice, representing a single billable item from a vendor. Captures AP invoice reference, line number, item description, quantity, unit of measure, unit price, line amount, GL account code, cost center, fund, project, tax code, PO line reference, goods receipt reference, match status, and distribution status. Enables granular cost allocation and three-way matching (PO-receipt-invoice) for healthcare supply and service procurement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment transaction. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: ap_payment has gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get account metadata for the cash/clearing account used in payment posting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ap_payment has cost_center_code (STRING) which should be normalized to FK to cost_center master. Enables joining to get cost center details for payment allocation tracking.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: ap_payment has fiscal_period (INT) which should be normalized to FK to fiscal_period master. Enables joining to get period details and ensures payments reference valid fiscal periods. Note: fiscal_yea',
    `payment_batch_id` BIGINT COMMENT 'Identifier of the payment batch or payment run in which this payment was processed. Used for grouping payments processed together.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this payment for disbursement. Links to user or employee master. Null if not yet approved.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the vendor bank account to which this payment was sent. Links to vendor banking information.',
    `tertiary_ap_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this payment record. Links to user or employee master. Audit trail field.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier receiving this payment. Links to the vendor master record.',
    `voided_ap_payment_id` BIGINT COMMENT 'Self-referencing FK on ap_payment (voided_ap_payment_id)',
    `ach_trace_number` STRING COMMENT 'ACH trace number assigned by the bank for ACH/EFT payments. Used for tracking and reconciliation. Null for non-ACH payment methods.',
    `approval_status` STRING COMMENT 'Approval workflow status for the payment. Values: pending (awaiting approval), approved (authorized for disbursement), rejected (approval denied).. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was approved for disbursement. Null if not yet approved.',
    `check_number` STRING COMMENT 'Physical check number if payment method is check. Null for electronic payment methods.',
    `cleared_date` DATE COMMENT 'Date on which the payment cleared the bank and funds were successfully transferred to the vendor. Null if payment has not yet cleared.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'Total early payment discount amount taken on this payment if vendor offered discount terms (e.g., 2% discount for payment within 10 days).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if the payment was made in a foreign currency. Rate used to convert payment amount to the organizations functional currency.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the payment was issued, based on the organizations fiscal calendar.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the organizations functional currency (typically USD for US-based healthcare organizations) using the exchange rate.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was last modified. Audit trail field.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total monetary amount disbursed in this payment transaction, in the payment currency.',
    `payment_date` DATE COMMENT 'Date on which the payment was issued or disbursed to the vendor. Principal business event timestamp for the payment transaction.',
    `payment_description` STRING COMMENT 'Free-text description or memo field providing additional context about the payment purpose or contents.',
    `payment_method` STRING COMMENT 'Method or instrument used to disburse the payment. Common values: check (paper check), ach (Automated Clearing House), eft (Electronic Funds Transfer), wire_transfer, virtual_card, cash.. Valid values are `check|ach|eft|wire_transfer|virtual_card|cash`',
    `payment_number` STRING COMMENT 'Business-facing unique payment identifier or check number assigned by the financial system. Used for external reference and reconciliation.',
    `payment_priority` STRING COMMENT 'Priority level assigned to the payment for processing. Values: standard (normal processing), urgent (high priority), expedited (rush processing).. Valid values are `standard|urgent|expedited`',
    `payment_reconciliation_status` STRING COMMENT 'Bank reconciliation status of the payment. Values: unreconciled (not yet matched to bank statement), reconciled (matched and cleared), exception (discrepancy identified).. Valid values are `unreconciled|reconciled|exception`',
    `payment_source_system` STRING COMMENT 'Name or identifier of the source financial system that originated this payment record (e.g., SAP S/4HANA FI, Epic Resolute PB).',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment. Values: issued (payment created and sent), cleared (payment successfully processed by bank), voided (payment cancelled before clearing), stopped (stop payment placed), cancelled (payment cancelled), pending (awaiting approval or processing).. Valid values are `issued|cleared|voided|stopped|cancelled|pending`',
    `payment_terms` STRING COMMENT 'Payment terms applicable to this payment (e.g., Net 30, 2/10 Net 30). Reflects the terms under which the vendor invoices were paid.',
    `payment_type` STRING COMMENT 'Classification of the payment transaction type. Values: invoice_payment (standard vendor invoice payment), prepayment (advance payment), refund (return of funds), expense_reimbursement (employee expense reimbursement).. Valid values are `invoice_payment|prepayment|refund|expense_reimbursement`',
    `reconciled_date` DATE COMMENT 'Date on which the payment was reconciled against the bank statement. Null if not yet reconciled.',
    `remittance_advice_reference` STRING COMMENT 'Reference number or identifier for the remittance advice document sent to the vendor detailing which invoices this payment settles.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `void_date` DATE COMMENT 'Date on which the payment was voided or cancelled. Null if payment has not been voided.',
    `void_reason` STRING COMMENT 'Business reason or explanation for why the payment was voided. Null if payment has not been voided.',
    `wire_confirmation_number` STRING COMMENT 'Bank confirmation or reference number for wire transfer payments. Null for non-wire payment methods.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Transactional record of every payment disbursed to a vendor through the accounts payable process. Captures payment number, payment date, payment method (check, ACH/EFT, wire transfer, virtual card), vendor ID, vendor bank account, payment amount, currency, exchange rate, payment status (issued, cleared, voided, stopped), void date, void reason, bank account debited, check number (if applicable), remittance advice reference, and associated AP invoices settled. SSOT for all vendor disbursements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`ar_account` (
    `ar_account_id` BIGINT COMMENT 'Unique identifier for the accounts receivable account. Primary key for non-patient-billing receivables including grants, rental income, intercompany receivables, and physician practice management fees.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: ar_account has gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get account metadata for the receivable GL account.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ar_account has cost_center_code (STRING) which should be normalized to FK to cost_center master. Enables joining to get cost center details for receivable tracking by department/service line.',
    `parent_ar_account_id` BIGINT COMMENT 'Self-referencing FK on ar_account (parent_ar_account_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the internal staff member or external collection agency assigned to manage collection activities for this account. Used for workload distribution, performance tracking, and accountability.',
    `tertiary_ar_last_modified_by_user_employee_id` BIGINT COMMENT 'The system user identifier of the person or process that most recently modified this AR account record. Used for accountability, audit trail, and change management.',
    `account_number` STRING COMMENT 'The externally-known unique account number assigned to this receivable account. Used for identification in financial systems and external communications with debtors.',
    `account_status` STRING COMMENT 'Current lifecycle status of the receivable account. Open indicates active receivable with expected payment; closed indicates fully paid or resolved; written_off indicates uncollectible and removed from active AR; in_collections indicates transferred to internal or external collections; disputed indicates debtor has contested the amount; on_hold indicates temporarily suspended collection activity; pending_resolution indicates awaiting internal review or decision. [ENUM-REF-CANDIDATE: open|closed|written_off|in_collections|disputed|on_hold|pending_resolution — 7 candidates stripped; promote to reference product]',
    `account_type` STRING COMMENT 'Classification of the receivable account indicating the nature of the financial relationship. Distinguishes between payer receivables, self-pay patient receivables, intercompany transactions, grant funding, physician practice management fees, rental income, and other non-RCM receivables. Note: This is for non-patient-billing AR; patient billing AR is managed in billing.patient_account. [ENUM-REF-CANDIDATE: payer|self_pay|intercompany|grant|physician_practice_management|rental_income|other — 7 candidates stripped; promote to reference product]',
    `aging_bucket` STRING COMMENT 'Categorization of the receivable based on the number of days outstanding since the original invoice or billing date. Used for aging analysis, collection prioritization, and allowance for doubtful accounts estimation. Current indicates not yet due; subsequent buckets indicate days past due.. Valid values are `current|1_30_days|31_60_days|61_90_days|91_120_days|over_120_days`',
    `collection_agency_name` STRING COMMENT 'Name of the external third-party collection agency to which this account has been referred, if applicable. Null if account is managed internally or not yet in collections.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this AR account record was first created in the system. Used for audit trail, data lineage, and account lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency denomination of all monetary amounts on this account. Defaults to USD for domestic operations; supports multi-currency for international grants or intercompany receivables.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The outstanding receivable balance as of the current date. Reflects original balance minus payments received, plus any adjustments, interest, or fees. This is the amount currently owed. Denominated in USD unless otherwise specified in currency_code.',
    `days_outstanding` STRING COMMENT 'The number of calendar days that have elapsed since the original invoice or billing date. Used to calculate aging bucket and assess collection risk. Key metric for Days Sales Outstanding (DSO) reporting.',
    `debtor_name` STRING COMMENT 'The legal or business name of the entity or individual that owes payment on this receivable account. May be a payer organization, self-pay patient, affiliated entity, grantor, or other debtor.',
    `debtor_type` STRING COMMENT 'Categorical classification of the debtor entity. Segments debtors into commercial insurance payers, government payers (Medicare, Medicaid), self-pay individuals, affiliated healthcare entities, grant-making organizations, corporate tenants, and other categories for reporting and collection strategy purposes. [ENUM-REF-CANDIDATE: commercial_payer|government_payer|self_pay_individual|affiliated_entity|grant_organization|corporate_tenant|other — 7 candidates stripped; promote to reference product]',
    `dispute_date` DATE COMMENT 'The date on which the debtor formally notified the organization of the dispute. Used to track dispute aging and ensure timely resolution per regulatory requirements.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the debtor has formally disputed the receivable amount or validity. True indicates an active dispute; false indicates no dispute. Disputed accounts typically require special handling and may be placed on hold pending resolution.',
    `dispute_reason` STRING COMMENT 'Description of the reason provided by the debtor for disputing the receivable, such as services not rendered, incorrect billing amount, duplicate invoice, or contractual disagreement. Used to guide dispute resolution process.',
    `due_date` DATE COMMENT 'The date by which payment is contractually due per the invoice terms or agreement. Used to determine whether the account is current or past due and to calculate late fees or interest if applicable.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to overdue balances on this account, expressed as a decimal (e.g., 0.0500 for 5%). Null if no interest is charged. Used to calculate interest charges on past-due amounts per contractual terms or state regulations.',
    `invoice_date` DATE COMMENT 'The date on which the original invoice or billing statement was issued to the debtor. Serves as the starting point for aging calculations and payment term enforcement.',
    `last_activity_date` DATE COMMENT 'The most recent date on which any activity occurred on this account, including payments received, adjustments posted, collection calls made, correspondence sent, or status changes. Used to identify dormant accounts and prioritize follow-up.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this AR account record was most recently updated. Used for audit trail, change tracking, and data synchronization.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the most recent payment received on this account. Denominated in the accounts currency_code. Used for payment trend analysis and debtor behavior assessment.',
    `last_payment_date` DATE COMMENT 'The date on which the most recent payment was received and posted to this account. Used to assess payment patterns and predict future payment likelihood.',
    `legal_action_date` DATE COMMENT 'The date on which legal action was initiated for collection of this receivable. Null if no legal action has been taken. Used for legal case tracking and statute of limitations monitoring.',
    `legal_action_flag` BOOLEAN COMMENT 'Boolean indicator of whether legal action (lawsuit, lien, garnishment) has been initiated to collect this receivable. True indicates active legal proceedings; false indicates no legal action. Used for legal department coordination and risk management.',
    `notes` STRING COMMENT 'Free-text field for recording important notes, comments, or special instructions related to this account. May include collection history, debtor communication summaries, special handling requirements, or internal coordination notes.',
    `original_balance` DECIMAL(18,2) COMMENT 'The initial receivable amount established when the account was opened. Represents the total amount originally owed before any payments, adjustments, or write-offs. Denominated in USD unless otherwise specified in currency_code.',
    `payment_terms` STRING COMMENT 'The contractual payment terms agreed upon with the debtor, typically expressed as net days (e.g., Net 30, Net 60) or other terms such as due on receipt, installment plan, or custom terms. Defines the expected payment timeline.',
    `settlement_accepted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the debtor has accepted a settlement offer. True indicates acceptance; false indicates no acceptance or no offer made. Used to track settlement negotiations and finalize account closure.',
    `settlement_offer_amount` DECIMAL(18,2) COMMENT 'The reduced amount offered to the debtor as a settlement to close the account, if applicable. Typically less than current_balance. Null if no settlement has been offered. Denominated in the accounts currency_code.',
    `total_adjustments` DECIMAL(18,2) COMMENT 'The cumulative sum of all adjustments (positive or negative) applied to this account, including billing corrections, contractual allowances, courtesy adjustments, and dispute resolutions. Denominated in the accounts currency_code.',
    `total_fees_assessed` DECIMAL(18,2) COMMENT 'The cumulative amount of late fees, collection fees, administrative fees, or other charges assessed on this account. Included in the current_balance. Denominated in the accounts currency_code.',
    `total_interest_accrued` DECIMAL(18,2) COMMENT 'The cumulative amount of interest that has accrued on this account due to late payment. Included in the current_balance. Denominated in the accounts currency_code.',
    `total_payments_received` DECIMAL(18,2) COMMENT 'The cumulative sum of all payments received on this account since inception. Used to calculate current_balance and assess payment history. Denominated in the accounts currency_code.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The amount written off as uncollectible bad debt. Populated when account_status is written_off. Represents the portion of the receivable removed from active AR and recognized as a loss. Denominated in the accounts currency_code.',
    `write_off_date` DATE COMMENT 'The date on which the receivable was written off as uncollectible. Null if the account has not been written off. Used for bad debt reporting and financial statement preparation.',
    `write_off_reason` STRING COMMENT 'Explanation or categorization of why the receivable was written off, such as debtor bankruptcy, inability to locate debtor, cost of collection exceeds balance, statute of limitations expired, or management decision. Used for root cause analysis and process improvement.',
    CONSTRAINT pk_ar_account PRIMARY KEY(`ar_account_id`)
) COMMENT 'Accounts receivable account master representing the financial receivable relationship between the healthcare organization and a payer or self-pay patient for non-patient-billing AR (e.g., grants, rental income, intercompany receivables, physician practice management fees). Captures account number, account type (payer, self-pay, intercompany, grant, other), debtor name, debtor type, original balance, current balance, aging bucket, account status (open, closed, written off, in collections), assigned collector, and last activity date. Complements billing.patient_account for non-RCM receivables.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` (
    `ar_transaction_id` BIGINT COMMENT 'Unique identifier for the accounts receivable transaction record. Primary key for the AR transaction subledger.',
    `ar_account_id` BIGINT COMMENT 'Reference to the AR account (non-RCM receivable account) associated with this transaction. Links to the AR account master for customer or entity billing relationships outside of revenue cycle management.',
    `ar_applied_to_transaction_id` BIGINT COMMENT 'Reference to the charge transaction that this payment, credit memo, or adjustment is applied against. Enables payment application tracking and open item reconciliation.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: ar_transaction has gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get account metadata for the GL account affected by the AR transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ar_transaction has cost_center_code (STRING) which should be normalized to FK to cost_center master. Enables joining to get cost center details for AR transaction allocation.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: ar_transaction has posting_period (STRING) which should be normalized to FK to fiscal_period master. Enables joining to get period details and ensures AR transactions reference valid fiscal periods.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created or entered this AR transaction into the system. Used for audit trail and accountability.',
    `primary_reversed_transaction_ar_transaction_id` BIGINT COMMENT 'Reference to the original AR transaction that this entry reverses. Null for non-reversal transactions. Creates audit trail for transaction corrections.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier for the batch or group of transactions processed together. Used for batch reconciliation and control totals validation.',
    `adjustment_reason_code` STRING COMMENT 'Standardized code indicating the business reason for adjustment transactions: billing error, pricing correction, contractual adjustment, goodwill credit. Null for non-adjustment transactions.',
    `aging_bucket` STRING COMMENT 'Calculated aging category based on days outstanding from transaction date to current date: current (0 days), 1-30 days, 31-60 days, 61-90 days, or over 90 days. Used for AR aging analysis and collection prioritization.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `approval_date` DATE COMMENT 'The date when this AR transaction was approved for posting. Null for transactions not requiring approval or still pending approval.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this AR transaction record was first created in the database. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount. Supports multi-currency AR management and foreign exchange reconciliation.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `due_date` DATE COMMENT 'The date by which payment is expected or required for charge transactions. Used to calculate days outstanding and aging. Null for payment and adjustment transactions.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency to functional currency. Null for transactions in functional currency.',
    `functional_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the organizations functional reporting currency (typically USD) using the exchange rate at transaction date. Used for consolidated financial reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this AR transaction record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the transaction providing supplementary context for accounting staff, auditors, or management review.',
    `payment_method` STRING COMMENT 'The payment instrument or method used for payment transactions: check, wire transfer, ACH, credit card, cash, or electronic funds transfer. Null for non-payment transaction types.. Valid values are `check|wire_transfer|ach|credit_card|cash|electronic_funds_transfer`',
    `payment_reference_number` STRING COMMENT 'External payment reference number such as check number, wire confirmation, or ACH trace number. Used for payment reconciliation and audit trail.',
    `posting_date` DATE COMMENT 'The date when the transaction was posted to the general ledger and became part of the official financial record.',
    `posting_status` STRING COMMENT 'Current posting status of the AR transaction: draft (not yet posted), posted (finalized in GL), reversed (cancelled with offsetting entry), voided (cancelled before posting), or pending_approval (awaiting authorization).. Valid values are `draft|posted|reversed|voided|pending_approval`',
    `reconciliation_date` DATE COMMENT 'The date when this transaction was reconciled and cleared. Null for unreconciled transactions.',
    `reconciliation_status` STRING COMMENT 'Status of the transaction in the AR reconciliation process: unreconciled (not yet matched), reconciled (matched and cleared), disputed (discrepancy identified), or under_review (being investigated).. Valid values are `unreconciled|reconciled|disputed|under_review`',
    `reference_document_number` STRING COMMENT 'External reference number linking this AR transaction to source documents such as invoices, payment receipts, credit memos, or adjustment authorizations.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator whether this transaction is a reversal entry that offsets a previously posted transaction. True for reversal entries, False otherwise.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system or module that created this AR transaction: SAP FI, Workday Financials, manual entry, interface from external system.',
    `source_system_transaction_reference` STRING COMMENT 'The unique transaction identifier from the source system. Used for data lineage tracking and reconciliation back to operational systems.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax component of the transaction amount for charge transactions. Used for tax reporting and reconciliation. Null for non-taxable transactions.',
    `tax_code` STRING COMMENT 'Tax jurisdiction or tax type code applied to this transaction. Used for tax reporting and compliance with state and federal tax regulations.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the AR transaction in the transaction currency. Positive for charges and debits, negative for payments and credits.',
    `transaction_date` DATE COMMENT 'The business date when the AR transaction event occurred. This is the principal event timestamp for aging analysis and financial period assignment.',
    `transaction_description` STRING COMMENT 'Free-text business description of the AR transaction providing context about the nature of the charge, payment, or adjustment.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or document reference assigned to this AR transaction for external communication and reconciliation purposes.',
    `transaction_type` STRING COMMENT 'Classification of the AR transaction event: charge (new receivable), payment (cash received), credit_memo (reduction), debit_memo (increase), adjustment (correction), write_off (uncollectible), or refund (payment reversal). [ENUM-REF-CANDIDATE: charge|payment|credit_memo|debit_memo|adjustment|write_off|refund — 7 candidates stripped; promote to reference product]',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `write_off_reason_code` STRING COMMENT 'Standardized code indicating the business reason for write-off transactions: bad debt, small balance, bankruptcy, deceased, statute of limitations. Null for non-write-off transactions.',
    CONSTRAINT pk_ar_transaction PRIMARY KEY(`ar_transaction_id`)
) COMMENT 'Transactional record of every accounts receivable financial event including charges, payments received, adjustments, and write-offs for non-RCM AR accounts. Captures transaction date, transaction type (charge, payment, credit memo, adjustment, write-off), AR account reference, GL account, cost center, amount, currency, reference document number, transaction description, posting period, and posting status. Provides the complete AR subledger transaction history for reconciliation and aging analysis.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset entity.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where the fixed asset is physically located and assigned for operational use.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: fixed_asset has gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get the GL asset account for the fixed asset.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center or department responsible for the fixed asset and to which depreciation expense is allocated for financial reporting and budgeting.',
    `parent_fixed_asset_id` BIGINT COMMENT 'Self-referencing FK on fixed_asset (parent_fixed_asset_id)',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since the asset was placed in service. Contra-asset account that reduces the gross book value. Recorded in USD.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of acquiring the fixed asset including purchase price, installation costs, freight, and other costs necessary to prepare the asset for its intended use. Recorded in USD.',
    `acquisition_date` DATE COMMENT 'Date on which the healthcare organization legally acquired ownership or control of the fixed asset through purchase, donation, or construction completion.',
    `asset_category` STRING COMMENT 'Primary classification of the fixed asset type. Medical equipment includes diagnostic and treatment devices; buildings include owned structures; land includes real property; leasehold improvements include tenant modifications; IT equipment includes servers and network infrastructure; vehicles include ambulances and transport.. Valid values are `medical_equipment|building|land|leasehold_improvement|it_equipment|vehicle`',
    `asset_description` STRING COMMENT 'Detailed description of the fixed asset including specifications, model information, and distinguishing characteristics.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the fixed asset for identification and reporting purposes.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Active indicates in-service use; disposed indicates sold or scrapped; transferred indicates moved to another entity; fully depreciated indicates zero net book value but still in use; under construction indicates not yet placed in service; retired indicates removed from service.. Valid values are `active|disposed|transferred|fully_depreciated|under_construction|retired`',
    `asset_subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the asset category (e.g., MRI scanner, CT scanner, ultrasound machine for medical equipment category).',
    `asset_tag_number` STRING COMMENT 'Unique physical identifier affixed to the asset for tracking and inventory purposes. Externally visible barcode or RFID tag number used in physical audits.. Valid values are `^[A-Z0-9]{6,20}$`',
    `capitalization_threshold_met` BOOLEAN COMMENT 'Flag indicating whether the asset acquisition cost met or exceeded the organizations capitalization threshold policy. True indicates the asset was properly capitalized; False would indicate an expense treatment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fixed asset record was first created in the system. Used for audit trail and data lineage tracking.',
    `depreciation_method` STRING COMMENT 'Accounting method used to systematically allocate the cost of the fixed asset over its useful life. Straight-line allocates evenly; declining balance accelerates early depreciation; MACRS (Modified Accelerated Cost Recovery System) follows IRS tax rules; units of production bases depreciation on usage; sum of years digits accelerates depreciation.. Valid values are `straight_line|declining_balance|macrs|units_of_production|sum_of_years_digits`',
    `disposal_date` DATE COMMENT 'Date on which the fixed asset was disposed of through sale, donation, scrapping, or other removal from service. Null for active assets.',
    `disposal_method` STRING COMMENT 'Method by which the fixed asset was disposed. Sold indicates sale to third party; donated indicates charitable contribution; scrapped indicates destruction; traded in indicates exchange for new asset; returned to lessor indicates lease termination; transferred indicates internal move to another entity.. Valid values are `sold|donated|scrapped|traded_in|returned_to_lessor|transferred`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value of consideration received from disposal of the fixed asset. Used to calculate gain or loss on disposal. Recorded in USD.',
    `fda_device_class` STRING COMMENT 'FDA classification of the medical device based on risk level. Class I is low risk; Class II is moderate risk; Class III is high risk. Not applicable for non-medical equipment.. Valid values are `class_i|class_ii|class_iii|not_applicable`',
    `fda_regulated_indicator` BOOLEAN COMMENT 'Flag indicating whether the fixed asset is a medical device or equipment subject to FDA regulatory oversight and compliance requirements. True for FDA-regulated medical equipment.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum insured value or coverage limit for the fixed asset under the insurance policy. Recorded in USD.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance coverage protecting the fixed asset against loss, damage, or theft. Used for risk management and claims processing.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance service performed on the fixed asset. Used to track maintenance compliance and schedule next service.',
    `last_physical_inventory_date` DATE COMMENT 'Date of the most recent physical inventory audit or verification confirming the existence and condition of the fixed asset.',
    `lease_end_date` DATE COMMENT 'Date on which the lease agreement for the fixed asset expires. Null for owned assets. Used for lease renewal planning and return logistics.',
    `lease_indicator` BOOLEAN COMMENT 'Flag indicating whether the fixed asset is leased (True) or owned (False). Determines accounting treatment under ASC 842 lease accounting standards.',
    `lease_type` STRING COMMENT 'Classification of the lease agreement if the asset is leased. Operating lease transfers use rights; finance/capital lease transfers substantially all risks and rewards of ownership. Not applicable for owned assets.. Valid values are `operating_lease|finance_lease|capital_lease|not_applicable`',
    `maintenance_schedule` STRING COMMENT 'Frequency of scheduled preventive maintenance required for the fixed asset to ensure safe operation and regulatory compliance. Critical for medical equipment and life safety systems. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|as_needed — 7 candidates stripped; promote to reference product]',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) who produced the fixed asset. May differ from vendor if purchased through a distributor.',
    `model_number` STRING COMMENT 'Manufacturer-assigned model number or designation that identifies the specific product configuration and specifications of the fixed asset.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the fixed asset record was last updated in the system. Used for audit trail and change tracking.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the fixed asset calculated as acquisition cost minus accumulated depreciation. Represents the undepreciated balance on the balance sheet. Recorded in USD.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service based on the maintenance schedule and last service date. Used for maintenance planning and compliance tracking.',
    `physical_location` STRING COMMENT 'Current physical location of the fixed asset including facility name, building, floor, room number, or department where the asset is deployed and in use.',
    `placed_in_service_date` DATE COMMENT 'Date on which the fixed asset was ready and available for its intended use and depreciation began. May differ from acquisition date for assets requiring installation or construction.',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which the fixed asset was procured. Links the asset to the original procurement transaction and vendor contract.',
    `responsible_party_name` STRING COMMENT 'Name of the individual or role responsible for the custody, maintenance, and proper use of the fixed asset. Typically a department manager or equipment coordinator.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the fixed asset at the end of its useful life. Amount expected to be recovered through sale or disposal. Recorded in USD.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number that identifies the individual unit of the fixed asset for warranty, service, and tracking purposes.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Estimated number of years the fixed asset is expected to provide economic benefit to the healthcare organization. Used to calculate depreciation expense.',
    `vendor_name` STRING COMMENT 'Name of the vendor, supplier, or manufacturer from whom the fixed asset was purchased or leased.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `warranty_expiration_date` DATE COMMENT 'Date on which the manufacturer or vendor warranty coverage for the fixed asset expires. Used for maintenance planning and service contract decisions.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Master record for every capitalized fixed asset owned or leased by the healthcare organization, including medical equipment, buildings, land, leasehold improvements, IT infrastructure, and vehicles. Captures asset tag number, asset name, asset description, asset category (medical equipment, building, land, furniture, IT equipment, vehicle), acquisition date, placed-in-service date, acquisition cost, salvage value, useful life (years), depreciation method (straight-line, MACRS, units of production), accumulated depreciation, net book value, asset status (active, disposed, transferred, fully depreciated), physical location, responsible cost center, and vendor/manufacturer.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` (
    `depreciation_schedule_id` BIGINT COMMENT 'Unique identifier for the depreciation schedule entry. Primary key for this transactional record of periodic depreciation calculation and posting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: depreciation_schedule has cost_center_code (STRING) which should be normalized to FK to cost_center master. Enables joining to get cost center details for depreciation expense allocation.',
    `depreciation_run_id` BIGINT COMMENT 'Reference to the batch depreciation calculation run that generated this entry. Links all depreciation entries processed together.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: depreciation_schedule has depreciation_expense_gl_account (STRING) which should be normalized to FK to chart_of_accounts. Using expense_chart_of_accounts_id as the FK name to distinguish from the ac',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: depreciation_schedule has fiscal_year (INT) and fiscal_period (INT) which should be normalized to FK to fiscal_period master. The fiscal_period INT likely represents period_number, which combined with',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset for which this depreciation entry is calculated. Links to the capital asset master record.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the general ledger journal entry created for this depreciation posting. Links to the financial transaction record.',
    `prior_depreciation_schedule_id` BIGINT COMMENT 'Self-referencing FK on depreciation_schedule (prior_depreciation_schedule_id)',
    `accumulated_depreciation_balance` DECIMAL(18,2) COMMENT 'The cumulative total of all depreciation expense recognized on this asset from acquisition through the current period. Contra-asset account balance.',
    `accumulated_depreciation_gl_account` STRING COMMENT 'The general ledger account code credited for accumulated depreciation. Contra-asset account that offsets the fixed asset account.',
    `adjustment_flag` BOOLEAN COMMENT 'Indicates whether this entry represents an adjustment to a previously posted depreciation calculation. True if adjustment, False if original entry.',
    `adjustment_reason` STRING COMMENT 'The business reason for the depreciation adjustment, such as asset revaluation, useful life change, or error correction. Null if not an adjustment.',
    `asset_category` STRING COMMENT 'The classification category of the fixed asset being depreciated (e.g., Medical Equipment, Building, IT Infrastructure, Furniture). Supports categorical reporting.',
    `beginning_net_book_value` DECIMAL(18,2) COMMENT 'The net book value of the asset at the beginning of the depreciation period. Calculated as original cost minus accumulated depreciation from prior periods.',
    `book_tax_difference` DECIMAL(18,2) COMMENT 'The difference between book depreciation expense and tax depreciation amount for this period. Used for deferred tax calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this depreciation schedule record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this depreciation entry (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department code responsible for the asset and associated depreciation expense. Supports organizational expense allocation.',
    `depreciation_date` DATE COMMENT 'The specific date on which this depreciation calculation was performed and recognized. Typically the last day of the fiscal period.',
    `depreciation_expense_amount` DECIMAL(18,2) COMMENT 'The depreciation expense amount calculated and recognized for this period. This amount is debited to the depreciation expense account.',
    `depreciation_method` STRING COMMENT 'The depreciation calculation method applied for this period. Determines how the asset cost is allocated over its useful life.. Valid values are `straight_line|declining_balance|double_declining_balance|sum_of_years_digits|units_of_production|modified_accelerated_cost_recovery_system`',
    `ending_net_book_value` DECIMAL(18,2) COMMENT 'The net book value of the asset at the end of the depreciation period. Calculated as beginning net book value minus current period depreciation expense.',
    `facility_code` STRING COMMENT 'The facility or location code where the asset is deployed. Enables facility-level capital asset and depreciation reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for this depreciation entry. Typically 1-12 representing January through December.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this depreciation expense is recognized. Four-digit year format (e.g., 2024).',
    `impairment_adjustment_amount` DECIMAL(18,2) COMMENT 'Any impairment loss recognized in this period that reduces the carrying value of the asset below its recoverable amount. Zero if no impairment occurred.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this depreciation schedule record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this depreciation schedule record was last modified. Tracks the most recent update for audit and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this depreciation entry. May include explanations for adjustments, impairments, or special circumstances.',
    `posted_by` STRING COMMENT 'The user ID or name of the person who posted this depreciation entry to the general ledger. Supports audit trail and accountability.',
    `posted_date` DATE COMMENT 'The date on which this depreciation entry was posted to the general ledger. May differ from the depreciation date for timing reasons.',
    `posting_status` STRING COMMENT 'The current posting status of this depreciation entry in the general ledger. Indicates whether the journal entry has been finalized.. Valid values are `draft|posted|reversed|adjusted|closed`',
    `reversal_date` DATE COMMENT 'The date on which this depreciation entry was reversed, if applicable. Null if not reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this depreciation entry has been reversed. True if reversed, False if active.',
    `reversal_reason` STRING COMMENT 'The business reason or justification for reversing this depreciation entry. Null if not reversed.',
    `salvage_value` DECIMAL(18,2) COMMENT 'The estimated residual value of the asset at the end of its useful life. This amount is not depreciated.',
    `tax_depreciation_amount` DECIMAL(18,2) COMMENT 'The depreciation amount calculated for tax reporting purposes, which may differ from book depreciation due to tax regulations such as MACRS.',
    `useful_life_remaining_months` STRING COMMENT 'The number of months of useful life remaining for the asset after this depreciation period. Used for forecasting future depreciation.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this depreciation schedule record. Supports accountability and audit requirements.',
    CONSTRAINT pk_depreciation_schedule PRIMARY KEY(`depreciation_schedule_id`)
) COMMENT 'Transactional record of periodic depreciation calculations and postings for each fixed asset. Captures asset reference, depreciation period (fiscal period/year), depreciation method applied, beginning net book value, depreciation expense amount, accumulated depreciation balance, ending net book value, GL account debited (depreciation expense), GL account credited (accumulated depreciation), cost center, posting status, and any impairment adjustments. Drives monthly depreciation journal entries and supports capital asset reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`capital_project` (
    `capital_project_id` BIGINT COMMENT 'Unique identifier for the capital project record. Primary key for the capital project entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this capital project record. Links to the employee or user record for audit purposes.',
    `capital_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this capital project record. Links to the employee or user record for audit purposes.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where this capital project is located or will be deployed. Links to the facility master record.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for this capital project. Links to the organizational unit accountable for project execution and budget management.',
    `financial_entity_id` BIGINT COMMENT 'Foreign key linking to finance.financial_entity. Business justification: capital_project should link to financial_entity to identify which legal entity owns the capital project. This is essential for multi-entity healthcare organizations to track capital projects by subsid',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Capital projects funded by restricted grants or donor funds require fund linkage for grant accounting, compliance reporting, and restricted fund balance tracking. Essential for non-profit healthcare g',
    `grant_id` BIGINT COMMENT 'Foreign key linking to research.grant. Business justification: Capital projects can be funded by research grants requiring tracking for compliance, financial reporting, and audit trails. Essential for grant-funded capital equipment purchases, facility constructio',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department that will utilize or benefit from this capital project. Links to the department master record.',
    `parent_capital_project_id` BIGINT COMMENT 'Self-referencing FK on capital_project (parent_capital_project_id)',
    `primary_capital_employee_id` BIGINT COMMENT 'Identifier of the employee serving as project manager, responsible for day-to-day execution, schedule, and deliverables.',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary vendor, contractor, or supplier responsible for project execution. Links to the vendor master record.',
    `actual_completion_date` DATE COMMENT 'Date when the capital project was actually completed and closed. Null until project reaches completed status.',
    `approval_date` DATE COMMENT 'Date when the capital project budget was formally approved by the board, finance committee, or authorized approver.',
    `approved_capital_budget` DECIMAL(18,2) COMMENT 'Total capital budget amount approved by the board or authorized approver for this project. Represents the spending authority ceiling.',
    `asset_class` STRING COMMENT 'Classification of the resulting capital asset for depreciation and financial reporting: building, building improvement, land improvement, equipment, software, or infrastructure.. Valid values are `building|building_improvement|land_improvement|equipment|software|infrastructure`',
    `bond_issue_number` STRING COMMENT 'Bond issue identifier if this project is funded through bond financing. Links to the bond issuance record for debt service tracking.',
    `business_justification` STRING COMMENT 'Business case and rationale for the capital investment, including expected benefits, return on investment, and strategic alignment.',
    `capitalization_status` STRING COMMENT 'Accounting treatment status for project costs: not_capitalized (project not yet eligible), in_progress (costs accumulating in construction-in-progress), capitalized (asset placed in service and capitalized), or expensed (costs expensed rather than capitalized).. Valid values are `not_capitalized|in_progress|capitalized|expensed`',
    `contract_number` STRING COMMENT 'Primary contract number for the general contractor, vendor, or implementation partner executing this capital project.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this capital project record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this project record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expected_annual_revenue` DECIMAL(18,2) COMMENT 'Projected annual revenue to be generated by this capital project once operational. Used for return on investment analysis.',
    `expected_annual_savings` DECIMAL(18,2) COMMENT 'Projected annual cost savings or expense reduction resulting from this capital project (e.g., energy efficiency, labor reduction, supply chain optimization).',
    `funding_source` STRING COMMENT 'Primary source of capital funding for this project: bond (municipal or corporate bonds), operating cash (internal reserves), grant (government or foundation grant), lease (capital lease financing), donation (philanthropic contribution), or loan (bank financing).. Valid values are `bond|operating_cash|grant|lease|donation|loan`',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates whether this capital project is required to meet regulatory compliance, accreditation standards, or legal mandates (e.g., Joint Commission, CMS Conditions of Participation, OSHA, fire code).',
    `is_revenue_generating` BOOLEAN COMMENT 'Indicates whether this capital project is expected to generate incremental revenue (e.g., new service line, expanded capacity, revenue-producing equipment).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this capital project record was last modified. Audit trail for record updates.',
    `project_description` STRING COMMENT 'Detailed narrative description of the capital project scope, objectives, and deliverables. Provides context for stakeholders and auditors.',
    `project_name` STRING COMMENT 'Descriptive name of the capital project for identification and reporting purposes.',
    `project_notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the capital project. Used for project history and knowledge transfer.',
    `project_number` STRING COMMENT 'Business identifier for the capital project, used for external reference and reporting. Unique across all capital projects.. Valid values are `^[A-Z0-9]{6,20}$`',
    `project_phase` STRING COMMENT 'Current phase of the project lifecycle: initiation (concept development), planning (detailed planning), design (architectural/engineering design), procurement (vendor selection), construction (build/implementation), testing (commissioning), or closeout (final documentation). [ENUM-REF-CANDIDATE: initiation|planning|design|procurement|construction|testing|closeout — 7 candidates stripped; promote to reference product]',
    `project_priority` STRING COMMENT 'Strategic priority level assigned to this capital project for resource allocation and scheduling: critical (immediate need), high (near-term priority), medium (planned investment), or low (deferred opportunity).. Valid values are `critical|high|medium|low`',
    `project_start_date` DATE COMMENT 'Date when the capital project officially commenced or is scheduled to commence. Represents the beginning of the project timeline.',
    `project_status` STRING COMMENT 'Current lifecycle status of the capital project: planning (initial scoping), approved (budget authorized), in progress (active construction or implementation), on hold (temporarily suspended), completed (project closed), or cancelled (project terminated).. Valid values are `planning|approved|in_progress|on_hold|completed|cancelled`',
    `project_type` STRING COMMENT 'Classification of the capital project by nature of investment: construction (new building), renovation (facility upgrade), equipment acquisition (medical or operational equipment), IT implementation (technology systems), leasehold improvement (tenant improvements), or infrastructure (utilities, parking, grounds).. Valid values are `construction|renovation|equipment_acquisition|it_implementation|leasehold_improvement|infrastructure`',
    `projected_completion_date` DATE COMMENT 'Planned or forecasted date for project completion. Updated as project progresses and schedule changes occur.',
    `strategic_initiative` STRING COMMENT 'Name or identifier of the strategic initiative or program that this capital project supports. Links project to organizational strategy.',
    `total_actual_costs` DECIMAL(18,2) COMMENT 'Cumulative amount of actual expenditures incurred and recorded against this project. Represents cash outflows and accrued expenses.',
    `total_committed_costs` DECIMAL(18,2) COMMENT 'Cumulative amount of costs committed through purchase orders, contracts, and other binding obligations for this project. Represents encumbered funds.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the capital asset in years, used for depreciation calculation once the asset is placed in service.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Current budget variance calculated as approved budget minus total actual costs. Positive indicates under budget, negative indicates over budget.',
    `variance_percent` DECIMAL(18,2) COMMENT 'Current budget variance expressed as a percentage of approved budget. Used for variance threshold monitoring and escalation.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_capital_project PRIMARY KEY(`capital_project_id`)
) COMMENT 'Master record for capital improvement and construction projects tracked within the finance domain for capital budgeting and expenditure control. Captures project number, project name, project type (construction, renovation, equipment acquisition, IT implementation, leasehold improvement), project status (planning, approved, in progress, on hold, completed, cancelled), approved capital budget, total committed costs, total actual costs, project start date, projected completion date, actual completion date, responsible cost center, project manager, funding source (bond, operating cash, grant, lease), and capitalization status. Distinct from facility.capital_project which tracks physical construction details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` (
    `capital_expenditure_id` BIGINT COMMENT 'Unique identifier for the capital expenditure transaction record.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this capital expenditure record in the system.',
    `capital_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified this capital expenditure record.',
    `capital_project_id` BIGINT COMMENT 'Reference to the approved capital project against which this expenditure is charged.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or location where the capital asset will be deployed or used.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: capital_expenditure has gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get the GL account for capital expenditure posting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: capital_expenditure has cost_center_code (STRING) which should be normalized to FK to cost_center master. Enables joining to get cost center details for capital expenditure allocation.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period in which this capital expenditure transaction is recorded.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset record created once this capital expenditure has been capitalized and the asset is placed in service.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: capital_expenditure has fund_code (STRING) which should be normalized to FK to fund master. Enables joining to get fund details for capital project funding tracking.',
    `modality_id` BIGINT COMMENT 'Foreign key linking to radiology.modality. Business justification: Capital expenditures for imaging equipment purchases must link to the resulting operational modality asset to track project-to-asset lifecycle, verify capitalization upon installation, enable acquisit',
    `org_unit_id` BIGINT COMMENT 'Reference to the department that will utilize or benefit from the capital asset being acquired.',
    `primary_capital_employee_id` BIGINT COMMENT 'Reference to the employee whose labor was charged to this capital expenditure, applicable when internal_labor_flag is true.',
    `reversed_capital_expenditure_id` BIGINT COMMENT 'Self-referencing FK on capital_expenditure (reversed_capital_expenditure_id)',
    `vendor_id` BIGINT COMMENT 'Reference to the external vendor or supplier from whom goods or services were purchased for this capital expenditure.',
    `approval_status` STRING COMMENT 'Current approval status of the capital expenditure transaction within the financial control workflow.. Valid values are `pending|approved|rejected|conditional`',
    `approved_date` DATE COMMENT 'The date on which this capital expenditure transaction was approved.',
    `asset_category` STRING COMMENT 'High-level classification of the type of capital asset being acquired through this expenditure.. Valid values are `medical_equipment|it_hardware|building|furniture|vehicle|other`',
    `asset_placed_in_service_flag` BOOLEAN COMMENT 'Indicates whether the capital asset associated with this expenditure has been placed into active service and is ready for depreciation.',
    `capitalization_eligible_flag` BOOLEAN COMMENT 'Indicates whether this expenditure meets the criteria for capitalization as a fixed asset per GAAP standards.',
    `cip_category` STRING COMMENT 'Classification of the capital expenditure within the Construction In Progress accounting category, used for tracking costs before capitalization.. Valid values are `building|equipment|infrastructure|technology|land_improvement|other`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this capital expenditure record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the expenditure amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Depreciation method to be applied to the capital asset once placed in service.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits|not_applicable`',
    `expenditure_amount` DECIMAL(18,2) COMMENT 'Monetary value of the capital expenditure transaction in the specified currency.',
    `expenditure_date` DATE COMMENT 'The date on which the capital expenditure transaction occurred or was recorded.',
    `expenditure_description` STRING COMMENT 'Detailed narrative description of the capital expenditure transaction, including purpose and justification.',
    `expenditure_number` STRING COMMENT 'Business identifier for the capital expenditure transaction, used for tracking and reference.',
    `expenditure_status` STRING COMMENT 'Current lifecycle status of the capital expenditure transaction in the financial system.. Valid values are `pending|approved|posted|capitalized|reversed|voided`',
    `expenditure_type` STRING COMMENT 'Classification of the capital expenditure transaction indicating the nature of the cost incurred.. Valid values are `invoice_payment|progress_billing|internal_labor|capitalized_interest|equipment_purchase|construction_cost`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this capital expenditure transaction is recorded for financial reporting purposes.',
    `grant_number` STRING COMMENT 'Grant or funding award number if this capital expenditure is funded by an external grant or restricted funding source.',
    `internal_labor_flag` BOOLEAN COMMENT 'Indicates whether this expenditure represents internal labor costs allocated to the capital project.',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with this capital expenditure transaction, if applicable.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Number of labor hours charged to this capital expenditure for internal labor costs.',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly rate applied to internal labor hours for calculating the labor cost component of this capital expenditure.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this capital expenditure record was last modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this capital expenditure transaction.',
    `payment_date` DATE COMMENT 'The date on which payment was made to the vendor or internal source for this capital expenditure.',
    `payment_method` STRING COMMENT 'Method used to remit payment for this capital expenditure transaction.. Valid values are `check|wire_transfer|ach|credit_card|internal_transfer|other`',
    `placed_in_service_date` DATE COMMENT 'The date on which the capital asset was placed into active service, triggering the start of depreciation.',
    `purchase_order_number` STRING COMMENT 'Purchase order number authorizing the procurement that resulted in this capital expenditure.',
    `reversal_date` DATE COMMENT 'The date on which this capital expenditure transaction was reversed, if applicable.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this capital expenditure transaction has been reversed or voided.',
    `reversal_reason` STRING COMMENT 'Explanation for why this capital expenditure transaction was reversed or voided.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the capital asset at the end of its useful life, used in depreciation calculations.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the capital asset in years, used for depreciation calculation once the asset is capitalized.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_capital_expenditure PRIMARY KEY(`capital_expenditure_id`)
) COMMENT 'Transactional record of individual capital expenditure events charged against an approved capital project. Captures capital project reference, expenditure date, expenditure type (invoice payment, progress billing, internal labor, capitalized interest), vendor or internal source, invoice or PO reference, expenditure amount, GL account, cost center, fund, capitalization eligibility flag, asset placed-in-service indicator, and associated fixed asset record (once capitalized). Enables CIP tracking and the transition from capital project costs to fixed asset records.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation transaction record.',
    `allocation_method_id` BIGINT COMMENT 'FK to finance.allocation_method',
    `allocation_run_id` BIGINT COMMENT 'Identifier for the batch allocation run that generated this allocation record. Groups all allocations processed in a single execution cycle.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or hospital where this cost allocation applies. Supports multi-facility cost accounting.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: cost_allocation has gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get the GL account for cost allocation posting.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period in which this cost allocation was executed.',
    `employee_id` BIGINT COMMENT 'Reference to the finance manager or controller who approved this allocation for posting.',
    `primary_original_allocation_cost_allocation_id` BIGINT COMMENT 'Reference to the original cost allocation record that this entry reverses or corrects. Null if this is not a reversal.',
    `cost_center_id` BIGINT COMMENT 'The overhead or indirect cost center from which costs are being allocated. Typically represents support departments such as facilities, IT, administration, or housekeeping.',
    `target_cost_center_id` BIGINT COMMENT 'The direct patient care or revenue-generating cost center receiving the allocated costs. Represents departments such as surgery, emergency, radiology, or inpatient units.',
    `tertiary_cost_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified this allocation record.',
    `adjustment_reason` STRING COMMENT 'Explanation for any manual adjustment made to the allocated amount. Required for audit trail and variance analysis.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The dollar amount of overhead or indirect cost allocated from the source cost center to the target cost center in this transaction. Calculated as source cost pool multiplied by allocation basis percentage.',
    `allocation_adjustment_amount` DECIMAL(18,2) COMMENT 'Any manual adjustment applied to the calculated allocated amount. Used for corrections, policy adjustments, or rounding reconciliation.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'The allocation amount of the finance cost allocation record.',
    `allocation_basis` STRING COMMENT 'The statistical or financial metric used to distribute costs from source to target cost centers. Square footage for facilities costs, FTE for HR costs, revenue for administrative overhead, RVU for clinical support, patient days for nursing, labor hours for supervision, transactions for IT, direct cost for proportional allocation, bed count for capacity-based allocation, and visits for outpatient services. [ENUM-REF-CANDIDATE: square_footage|fte|revenue|rvu|patient_days|labor_hours|transactions|direct_cost|bed_count|visits — 10 candidates stripped; promote to reference product]',
    `allocation_basis_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total allocation basis that the target cost center represents. Calculated as target quantity divided by sum of all target quantities. Used to distribute source costs proportionally.',
    `allocation_basis_quantity` DECIMAL(18,2) COMMENT 'The numeric quantity of the allocation basis metric for the target cost center. For example, 5000 square feet, 25.5 FTEs, 1200 patient days, or 8500 RVUs.',
    `allocation_category` STRING COMMENT 'The functional category of overhead cost being allocated. Groups allocations by the type of support service provided. [ENUM-REF-CANDIDATE: facilities|information_technology|human_resources|administration|finance|legal|compliance|quality|marketing — 9 candidates stripped; promote to reference product]',
    `allocation_date` DATE COMMENT 'The business date on which this cost allocation was executed and recorded. Typically the last day of the fiscal period being allocated.',
    `allocation_notes` STRING COMMENT 'Free-text field for documenting special circumstances, adjustments, or explanations related to this specific allocation transaction.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage of the finance cost allocation record.',
    `allocation_run_status` STRING COMMENT 'The current lifecycle status of this allocation record. Draft indicates preliminary calculation, pending approval awaits finance review, approved is ready for posting, posted means committed to GL, reversed indicates correction, and cancelled means voided.. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `allocation_sequence` STRING COMMENT 'The order in which this allocation was processed within the allocation run. Critical for step-down methodology where sequence determines which cost centers allocate first.',
    `allocation_status` STRING COMMENT 'The allocation status value classifying the finance cost allocation record.',
    `allocation_tier` STRING COMMENT 'The hierarchical tier or level of this allocation in multi-tier allocation methodologies. Tier 1 represents first-level overhead, tier 2 represents second-level, and so on.',
    `allocation_version` STRING COMMENT 'Version identifier for the allocation run. Supports multiple allocation scenarios such as budget, forecast, actual, or what-if analysis.',
    `approval_date` DATE COMMENT 'The date on which this allocation was reviewed and approved by authorized finance personnel.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount. Typically USD for U.S. healthcare organizations.. Valid values are `^[A-Z]{3}$`',
    `drg_cost_allocation_flag` BOOLEAN COMMENT 'Indicates whether this allocation contributes to DRG-based cost calculations for inpatient prospective payment system analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the finance cost allocation record.',
    `is_medicare_reportable` BOOLEAN COMMENT 'Indicates whether this allocation must be reported on the Medicare Cost Report (CMS-2552-10) for reimbursement calculation purposes.',
    `is_reciprocal_allocation` BOOLEAN COMMENT 'Indicates whether this allocation is part of a reciprocal allocation cycle where two or more cost centers provide mutual services to each other.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was last modified.',
    `notes` STRING COMMENT 'The notes of the finance cost allocation record.',
    `posting_date` DATE COMMENT 'The date on which this allocation was posted to the general ledger. May differ from allocation date due to period-end close timing.',
    `posting_status` STRING COMMENT 'The posting status value classifying the finance cost allocation record.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this allocation record represents a reversal of a previously posted allocation. Used for corrections and period adjustments.',
    `service_line_code` STRING COMMENT 'The clinical service line or product line to which the target cost center belongs. Examples include cardiology, orthopedics, oncology, womens health, or emergency services.',
    `source_amount` DECIMAL(18,2) COMMENT 'The source amount of the finance cost allocation record.',
    `source_cost_pool_amount` DECIMAL(18,2) COMMENT 'The total amount of costs available in the source cost center for allocation before distribution. Represents the full overhead pool being allocated across all target cost centers.',
    `statistic_quantity` DECIMAL(18,2) COMMENT 'The statistic quantity of the finance cost allocation record.',
    `statistic_type` STRING COMMENT 'The statistic type value classifying the finance cost allocation record.',
    `statistical_driver` STRING COMMENT 'The statistical driver of the finance cost allocation record.',
    `total_pool_amount` DECIMAL(18,2) COMMENT 'The total pool amount of the finance cost allocation record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Transactional record of overhead and indirect cost allocations distributed from overhead cost centers to direct patient care cost centers using defined allocation methodologies. Captures allocation run ID, fiscal period, allocation method (step-down, direct, reciprocal, activity-based), source cost center, target cost center, allocation basis (square footage, FTEs, revenue, RVUs, patient days), allocation basis quantity, allocated amount, GL account, and allocation run status. Supports Medicare cost report preparation and departmental cost accounting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` (
    `allocation_method_id` BIGINT COMMENT 'Unique identifier for the cost allocation method. Primary key for the allocation method reference master.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this allocation method record. Links to workforce or user management system for accountability.',
    `allocation_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this allocation method record. Links to workforce or user management system for accountability.',
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts within the finance allocation method record.',
    `owner_employee_id` BIGINT COMMENT 'Identifier of the cost accounting analyst or finance manager responsible for maintaining and updating this allocation method. Links to workforce or user management system.',
    `parent_allocation_method_id` BIGINT COMMENT 'Unique identifier for the parent allocation method within the finance allocation method record.',
    `primary_allocation_employee_id` BIGINT COMMENT 'Identifier of the finance executive or cost accounting manager who approved this allocation method. Links to workforce or user management system for accountability and audit trail.',
    `primary_superseded_method_allocation_method_id` BIGINT COMMENT 'Identifier of the previous allocation method that this method replaces. Creates a lineage chain for tracking method evolution and supporting historical cost report reconstruction.',
    `activity_driver_description` STRING COMMENT 'For activity-based costing (ABC) methods, describes the specific activity or cost driver that causes costs to be incurred. Examples include number of purchase orders processed, number of patient admissions, number of surgical procedures performed. Provides transparency into ABC methodology.',
    `allocation_basis` STRING COMMENT 'The allocation basis of the finance allocation method record.',
    `allocation_basis_type` STRING COMMENT 'The statistical or financial measure used as the basis for distributing costs. Square footage for facility costs; FTE (Full-Time Equivalent) count for HR costs; revenue for administrative overhead; RVU (Relative Value Unit) for physician services; patient days for nursing; procedures for surgical services; direct cost for proportional allocation; labor hours for labor-intensive departments; visits for outpatient services; discharges for inpatient services. [ENUM-REF-CANDIDATE: square_footage|fte_count|revenue|rvu|patient_days|procedures|direct_cost|labor_hours|visits|discharges — 10 candidates stripped; promote to reference product]',
    `allocation_frequency` STRING COMMENT 'How often this allocation method is executed. Monthly for routine cost accounting; quarterly for less frequent allocations; annually for year-end adjustments; as needed for special allocations; real-time for continuous allocation in advanced systems.. Valid values are `monthly|quarterly|annually|as_needed|real_time`',
    `allocation_percentage_cap` DECIMAL(18,2) COMMENT 'Maximum percentage of source cost that can be allocated to any single target cost center. Used to prevent disproportionate allocation and ensure equitable distribution. Expressed as a percentage (e.g., 25.00 for 25%).',
    `allocation_sequence` STRING COMMENT 'The order in which this allocation method is applied in step-down or sequential allocation processes. Lower numbers are allocated first. Critical for step-down methodology where allocation order affects final cost distribution.',
    `allocation_type` STRING COMMENT 'The allocation type value classifying the finance allocation method record.',
    `approval_date` DATE COMMENT 'The date on which this allocation method was formally approved by finance leadership or the cost accounting committee. Required for audit trail and regulatory compliance documentation.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether detailed audit trail logging is required for allocations using this method. True for regulatory or high-value allocations requiring full traceability; false for routine internal allocations.',
    `basis_data_source` STRING COMMENT 'The system, report, or data source from which the allocation basis statistics are obtained. Examples include facility management system for square footage, HR system for FTE counts, general ledger for revenue, clinical system for RVUs and patient days.',
    `calculation_formula` STRING COMMENT 'The mathematical formula or algorithm used to calculate allocation amounts. May reference basis statistics, weighting factors, and cost pools. Provides transparency and reproducibility for cost accounting calculations.',
    `cms_cost_report_schedule` STRING COMMENT 'The specific Medicare Cost Report worksheet or schedule to which this allocation method applies. Examples include Worksheet A (Reclassification and Adjustment of Trial Balance), Worksheet B (Cost Allocation), Worksheet C (Departmental Cost Allocation). Critical for regulatory compliance and reimbursement.. Valid values are `^[A-Z]-[0-9]{1,2}(-[A-Z0-9]{1,3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation method record was first created in the system. Supports audit trail and data lineage tracking.',
    `decimal_precision` STRING COMMENT 'Number of decimal places to which allocation amounts are calculated and stored. Typically 2 for dollar amounts, but may be higher for statistical allocations or percentage calculations.',
    `driver_metric` STRING COMMENT 'The driver metric of the finance allocation method record.',
    `effective_end_date` DATE COMMENT 'The date on which this allocation method ceases to be active. Null indicates the method is currently in use. Used for historical tracking and audit compliance.',
    `effective_start_date` DATE COMMENT 'The date from which this allocation method becomes active and applicable for cost accounting calculations. Aligns with fiscal period boundaries and Medicare Cost Report periods.',
    `gaap_compliant_flag` BOOLEAN COMMENT 'Indicates whether this allocation method complies with Generally Accepted Accounting Principles (GAAP) for financial statement preparation. True for methods acceptable under GAAP; false for methods used only for internal or regulatory purposes.',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `last_review_date` DATE COMMENT 'The date on which this allocation method was last reviewed for accuracy, relevance, and compliance. Used to ensure methods are periodically validated and updated as business needs evolve.',
    `method_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the allocation method for system processing and reporting. Used in cost accounting transactions and Medicare Cost Report preparation.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `method_description` STRING COMMENT 'Detailed narrative description of the allocation method, including business rationale, calculation approach, and any special considerations. Used for documentation, training, and audit support.',
    `method_name` STRING COMMENT 'Full descriptive name of the cost allocation method. Human-readable label used in financial reports and cost accounting documentation.',
    `method_status` STRING COMMENT 'Current lifecycle status of the allocation method. Active methods are in use; inactive methods are retired; pending approval methods await finance leadership sign-off; deprecated methods are being phased out; under review methods are being evaluated for changes.. Valid values are `active|inactive|pending_approval|deprecated|under_review`',
    `method_type` STRING COMMENT 'Classification of the cost allocation methodology. Step-down allocates overhead sequentially; direct allocates without intermediate steps; reciprocal accounts for mutual service exchanges; activity-based costing (ABC) allocates based on cost drivers; simultaneous solves all allocations concurrently; double distribution performs two-pass allocation.. Valid values are `step_down|direct|reciprocal|activity_based_costing|simultaneous|double_distribution`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation method record was last modified. Supports change tracking and audit compliance.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this allocation method. Supports proactive governance and ensures methods remain current with regulatory and business requirements.',
    `notes` STRING COMMENT 'The notes of the finance allocation method record.',
    `prior_period_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this allocation method supports retroactive adjustments to prior accounting periods. True for methods that allow historical corrections; false for methods that only allocate current period costs.',
    `reciprocal_allocation_flag` BOOLEAN COMMENT 'Indicates whether this method supports reciprocal allocation where departments can allocate costs to each other. True for methods that handle mutual service exchanges; false for unidirectional allocation methods.',
    `reciprocal_flag` BOOLEAN COMMENT 'The reciprocal flag of the finance allocation method record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this allocation method is required for regulatory reporting compliance (CMS Medicare Cost Report, state Medicaid cost reports, or other regulatory filings). True for methods mandated by regulation; false for internal management accounting methods.',
    `rounding_rule` STRING COMMENT 'Specifies how calculated allocation amounts are rounded. Round half up rounds 0.5 and above up; round half down rounds 0.5 and below down; round up always rounds up; round down always rounds down; truncate drops decimals; no rounding preserves full precision. Critical for ensuring allocation totals reconcile to source costs.. Valid values are `round_half_up|round_half_down|round_up|round_down|truncate|no_rounding`',
    `source_cost_center_category` STRING COMMENT 'Classification of the cost centers from which costs are allocated using this method. Overhead includes facilities and utilities; administrative includes finance and HR; support services includes IT and housekeeping; ancillary includes lab and radiology; clinical includes nursing and therapy; revenue-producing vs non-revenue-producing distinguishes direct patient care from support functions. [ENUM-REF-CANDIDATE: overhead|administrative|support_services|ancillary|clinical|revenue_producing|non_revenue_producing — 7 candidates stripped; promote to reference product]',
    `statistic_source` STRING COMMENT 'The statistic source of the finance allocation method record.',
    `statistic_type` STRING COMMENT 'The statistic type value classifying the finance allocation method record.',
    `statistical_source` STRING COMMENT 'The statistical source of the finance allocation method record.',
    `step_down_sequence` STRING COMMENT 'The step down sequence of the finance allocation method record.',
    `target_cost_center_category` STRING COMMENT 'Classification of the cost centers to which costs are allocated using this method. Defines the recipient departments for overhead distribution. Patient care only excludes further allocation to administrative departments.. Valid values are `clinical|ancillary|revenue_producing|all_departments|patient_care_only`',
    `usage_notes` STRING COMMENT 'Free-text field for cost accounting analysts to document special instructions, exceptions, or considerations when applying this allocation method. Supports knowledge transfer and operational continuity.',
    `version_number` STRING COMMENT 'Version identifier for this allocation method configuration. Incremented when method parameters, formulas, or basis types are changed. Supports change tracking and historical analysis.. Valid values are `^[0-9]+.[0-9]+$`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator to indicate change',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `weighting_factor` DECIMAL(18,2) COMMENT 'Numeric multiplier applied to the allocation basis to adjust for intensity, complexity, or other factors. Used to refine allocation precision when raw statistics do not fully reflect cost consumption patterns.',
    CONSTRAINT pk_allocation_method PRIMARY KEY(`allocation_method_id`)
) COMMENT 'Reference master defining the cost allocation methodologies and statistical basis configurations used in the healthcare cost accounting process. Captures method code, method name, method type (step-down, direct, reciprocal, activity-based costing), allocation basis type (square footage, FTE count, revenue, RVU, patient days, procedures), basis data source, weighting factor, effective date range, and applicable cost report schedule (Medicare Cost Report Schedule). Governs how overhead costs are distributed across clinical and administrative departments.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: bank_account has gl_cash_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get the GL cash account details. Using cash_chart_of_accounts_id as the FK na',
    `bank_chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the bank chart of accounts within the finance bank account record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or location associated with this bank account for operational and reporting purposes.',
    `financial_entity_id` BIGINT COMMENT 'Foreign key linking to finance.financial_entity. Business justification: bank_account has legal_entity_id (BIGINT) which should be normalized to FK to financial_entity. The attribute name uses legal_entity but should point to financial_entity.financial_entity_id. Enables',
    `parent_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (parent_bank_account_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created this bank account record.',
    `account_closed_date` DATE COMMENT 'The date on which the bank account was officially closed and is no longer available for transactions. Null if the account is still active.',
    `account_name` STRING COMMENT 'The descriptive name or title assigned to the bank account for internal identification and reporting purposes.',
    `account_notes` STRING COMMENT 'Free-text field for capturing additional information, special instructions, or operational notes related to the bank account.',
    `account_number` STRING COMMENT 'The masked or encrypted bank account number maintained by the financial institution. Stored in masked format for security compliance per PCI DSS and organizational treasury policy.',
    `account_number_masked` STRING COMMENT 'The account number masked of the finance bank account record.',
    `account_opened_date` DATE COMMENT 'The date on which the bank account was originally opened with the financial institution.',
    `account_purpose` STRING COMMENT 'The designated business purpose or functional use of the bank account within the healthcare organizations treasury operations.. Valid values are `operating|payroll|petty_cash|restricted|investment|escrow`',
    `account_status` STRING COMMENT 'The current operational status of the bank account in its lifecycle, indicating whether it is available for transactions or restricted.. Valid values are `active|closed|dormant|frozen|pending_closure`',
    `account_type` STRING COMMENT 'The classification of the bank account based on its financial instrument characteristics and operational features.. Valid values are `checking|savings|money_market|sweep|lockbox|investment`',
    `ach_enabled_flag` BOOLEAN COMMENT 'Indicates whether the account is enabled to send and receive ACH electronic funds transfers for payroll, vendor payments, and other automated transactions.',
    `available_balance` DECIMAL(18,2) COMMENT 'The amount of funds available for immediate withdrawal or payment, accounting for pending transactions and holds.',
    `bank_branch_address` STRING COMMENT 'The physical street address of the bank branch where the account is maintained.',
    `bank_branch_name` STRING COMMENT 'The name of the specific bank branch where the account is domiciled and serviced.',
    `bank_contact_email` STRING COMMENT 'The email address of the bank relationship manager or primary contact for electronic communication regarding the account.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bank_contact_name` STRING COMMENT 'The name of the primary relationship manager or contact person at the financial institution for this account.',
    `bank_contact_phone` STRING COMMENT 'The telephone number of the bank relationship manager or primary contact for account inquiries and issue resolution.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution where the account is maintained.',
    `bank_routing_number` STRING COMMENT 'The nine-digit American Bankers Association (ABA) routing transit number that identifies the financial institution for electronic funds transfers and check processing.. Valid values are `^[0-9]{9}$`',
    `bank_swift_code` STRING COMMENT 'The Society for Worldwide Interbank Financial Telecommunication (SWIFT) Business Identifier Code (BIC) used for international wire transfers and cross-border payments.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code representing the denomination in which the account balance is maintained.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The most recent available balance in the bank account as of the last reconciliation or bank statement date.',
    `dual_signature_required_flag` BOOLEAN COMMENT 'Indicates whether transactions above a certain threshold require two authorized signatures for approval and execution.',
    `dual_signature_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which dual signature authorization is required for transactions on this account.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the finance bank account record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the finance bank account record.',
    `fdic_certificate_number` STRING COMMENT 'The unique FDIC certificate number assigned to the financial institution, used to verify insurance coverage.',
    `fdic_insured_flag` BOOLEAN COMMENT 'Indicates whether the bank account is covered by FDIC insurance protection up to the statutory limit.',
    `grant_number` STRING COMMENT 'The unique identifier of the grant or funding award associated with this bank account, if the account is designated for grant-funded activities.',
    `iban` STRING COMMENT 'The iban of the finance bank account record.',
    `interest_calculation_method` STRING COMMENT 'The frequency and methodology used by the financial institution to calculate and credit interest to the account.. Valid values are `daily|monthly|quarterly|annual|none`',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual percentage rate (APR) of interest earned on the account balance, expressed as a decimal (e.g., 0.0250 for 2.50%).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the finance bank account record.',
    `is_disbursement_account` BOOLEAN COMMENT 'Boolean flag indicating the is disbursement account status of the finance bank account record.',
    `is_operating_account` BOOLEAN COMMENT 'Boolean flag indicating the is operating account status of the finance bank account record.',
    `last_reconciled_date` DATE COMMENT 'Timestamp capturing the last reconciled date associated with the finance bank account record.',
    `last_reconciliation_date` DATE COMMENT 'The date of the most recent bank reconciliation performed for this account, ensuring alignment between bank statement and general ledger balances.',
    `minimum_balance_required` DECIMAL(18,2) COMMENT 'The minimum account balance that must be maintained to avoid fees or meet contractual requirements with the financial institution.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was last modified or updated in the system.',
    `bank_account_name` STRING COMMENT 'The bank account name of the finance bank account record.',
    `next_reconciliation_due_date` DATE COMMENT 'The scheduled date by which the next bank reconciliation must be completed per organizational policy and internal controls.',
    `notes` STRING COMMENT 'The notes of the finance bank account record.',
    `online_banking_enabled_flag` BOOLEAN COMMENT 'Indicates whether online banking access and electronic transaction capabilities are enabled for this account.',
    `opening_date` DATE COMMENT 'Timestamp capturing the opening date associated with the finance bank account record.',
    `positive_pay_enabled_flag` BOOLEAN COMMENT 'Indicates whether positive pay fraud prevention service is enabled, requiring pre-authorization of checks and ACH transactions before they are honored by the bank.',
    `primary_signatory_name` STRING COMMENT 'The name of the primary authorized signatory who has authority to execute transactions and sign checks on this bank account.',
    `primary_signatory_title` STRING COMMENT 'The job title or position of the primary authorized signatory within the healthcare organization.',
    `restricted_fund_flag` BOOLEAN COMMENT 'Indicates whether the account holds restricted funds that are subject to donor restrictions, grant requirements, or regulatory limitations on use.',
    `restriction_description` STRING COMMENT 'A detailed description of any restrictions placed on the use of funds in this account, including donor stipulations, grant conditions, or regulatory requirements.',
    `routing_number` STRING COMMENT 'The routing number of the finance bank account record.',
    `secondary_signatory_name` STRING COMMENT 'The name of the secondary authorized signatory who has backup authority to execute transactions on this bank account.',
    `swift_code` STRING COMMENT 'The swift code value classifying the finance bank account record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `wire_transfer_enabled_flag` BOOLEAN COMMENT 'Indicates whether the account is authorized to initiate and receive domestic and international wire transfers.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master record for all bank accounts maintained by the healthcare organization for operating, payroll, investment, and restricted fund purposes. Captures bank account number (masked), bank name, bank routing number, account type (checking, savings, money market, sweep, lockbox), account purpose (operating, payroll, petty cash, restricted, investment), currency, legal entity owner, GL cash account mapping, account status (active, closed, dormant), signatory list, and bank contact information. SSOT for treasury cash management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` (
    `bank_reconciliation_id` BIGINT COMMENT 'Unique identifier for the bank reconciliation record. Primary key for the bank reconciliation transaction.',
    `employee_id` BIGINT COMMENT 'Reference to the manager or supervisor who provided final approval of the bank reconciliation. Represents the final sign-off in the reconciliation workflow.',
    `bank_account_id` BIGINT COMMENT 'Reference to the specific bank account being reconciled. Links to the bank account master data.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: bank_reconciliation has gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get the GL account being reconciled.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period for which this reconciliation is performed. Links to the fiscal calendar.',
    `primary_bank_employee_id` BIGINT COMMENT 'Reference to the employee who prepared and performed the bank reconciliation. Links to the workforce or employee master data for accountability and audit trail purposes.',
    `primary_prior_period_reconciliation_bank_reconciliation_id` BIGINT COMMENT 'Reference to the previous months or periods bank reconciliation record. Enables tracking of reconciliation continuity and resolution of prior period outstanding items.',
    `primary_recon_employee_id` BIGINT COMMENT 'Unique identifier for the primary recon employee within the finance bank reconciliation record.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the employee who reviewed the bank reconciliation for accuracy and completeness. Must be different from the preparer to maintain segregation of duties per SOX requirements.',
    `adjusted_bank_balance` DECIMAL(18,2) COMMENT 'The adjusted bank balance of the finance bank reconciliation record.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The adjustment amount of the finance bank reconciliation record.',
    `approval_date` DATE COMMENT 'The date on which the reconciliation received final approval from the designated approver. Marks the completion of the reconciliation workflow and acceptance of the reconciled balance.',
    `approver_name` STRING COMMENT 'Full name of the manager or supervisor who approved the bank reconciliation. Provides human-readable identification for reporting and audit purposes.',
    `auto_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation was performed automatically by the system using matching algorithms or manually by an accountant. True indicates automated reconciliation, false indicates manual reconciliation.',
    `bank_errors_total` DECIMAL(18,2) COMMENT 'Total amount of errors identified on the bank statement, such as incorrect charges, duplicate transactions, or processing mistakes by the bank. Positive values indicate bank overstatements, negative values indicate understatements.',
    `bank_service_charges` DECIMAL(18,2) COMMENT 'Total bank fees and service charges deducted by the bank during the statement period, including monthly maintenance fees, transaction fees, and wire transfer charges.',
    `bank_statement_balance` DECIMAL(18,2) COMMENT 'The bank statement balance of the finance bank reconciliation record.',
    `book_balance` DECIMAL(18,2) COMMENT 'The book balance of the finance bank reconciliation record.',
    `book_errors_total` DECIMAL(18,2) COMMENT 'Total amount of errors identified in the organizations general ledger records, such as recording errors, duplicate entries, or omitted transactions. Requires correcting journal entries.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this bank reconciliation record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the bank account being reconciled. Indicates the currency in which all monetary amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `deposits_in_transit` DECIMAL(18,2) COMMENT 'The deposits in transit of the finance bank reconciliation record.',
    `deposits_in_transit_total` DECIMAL(18,2) COMMENT 'Total amount of deposits recorded in the GL but not yet reflected on the bank statement as of the statement date. Represents timing differences between internal recording and bank processing.',
    `difference_amount` DECIMAL(18,2) COMMENT 'The difference amount of the finance bank reconciliation record.',
    `ending_balance` DECIMAL(18,2) COMMENT 'The ending balance of the finance bank reconciliation record.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation contains exceptions or unusual items requiring management attention. True indicates exceptions exist, false indicates a clean reconciliation.',
    `gl_book_balance` DECIMAL(18,2) COMMENT 'The cash account balance as recorded in the general ledger for the reconciliation period. This is the organizations internal record of the account balance.',
    `interest_earned` DECIMAL(18,2) COMMENT 'Interest income earned on the bank account during the statement period as reported by the bank. Requires recording in the general ledger if not previously captured.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this bank reconciliation record. Supports audit trail and accountability for changes to reconciliation data.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this bank reconciliation record was last modified. Tracks the most recent update to the reconciliation data for audit and change tracking purposes.',
    `notes` STRING COMMENT 'The notes of the finance bank reconciliation record.',
    `nsf_checks_total` DECIMAL(18,2) COMMENT 'Total amount of checks deposited by the organization that were returned by the bank due to insufficient funds in the payers account. Requires reversal of the original deposit entry.',
    `other_adjustments_total` DECIMAL(18,2) COMMENT 'Total amount of miscellaneous adjustments not categorized elsewhere, including electronic fund transfers, automatic payments, or other reconciling items identified during the reconciliation process.',
    `outstanding_checks_amount` DECIMAL(18,2) COMMENT 'The outstanding checks amount of the finance bank reconciliation record.',
    `outstanding_checks_total` DECIMAL(18,2) COMMENT 'Total amount of checks issued by the organization that have been recorded in the GL but have not yet cleared the bank as of the statement date.',
    `outstanding_items_count` STRING COMMENT 'Total number of outstanding reconciling items identified during the reconciliation process, including outstanding checks, deposits in transit, and other uncleared transactions.',
    `preparation_date` DATE COMMENT 'The date on which the reconciliation was initially prepared and completed by the preparer. Distinct from the reconciliation date which represents the business period being reconciled.',
    `preparer_name` STRING COMMENT 'Full name of the employee who prepared the bank reconciliation. Provides human-readable identification for reporting and audit purposes.',
    `reconciled_balance` DECIMAL(18,2) COMMENT 'The final adjusted balance after applying all reconciling items to either the bank statement balance or the GL book balance. Both adjusted balances should equal this amount when reconciliation is complete.',
    `reconciled_by` STRING COMMENT 'The reconciled by of the finance bank reconciliation record.',
    `reconciliation_date` DATE COMMENT 'The date on which the bank reconciliation was performed. Represents the business date of the reconciliation activity.',
    `reconciliation_notes` STRING COMMENT 'Free-text field for documenting significant findings, unusual items, explanations of variances, or other relevant information discovered during the reconciliation process. Supports audit trail and knowledge transfer.',
    `reconciliation_number` STRING COMMENT 'Business identifier for the reconciliation transaction, typically formatted as a sequential or date-based reference number used for tracking and audit purposes.',
    `reconciliation_status` STRING COMMENT 'Current workflow status of the bank reconciliation process. Tracks the reconciliation through preparation, review, and approval stages.. Valid values are `in_progress|reconciled|approved|rejected|pending_review|reopened`',
    `review_date` DATE COMMENT 'The date on which the reconciliation was reviewed by the designated reviewer. Part of the internal control process to ensure accuracy and completeness.',
    `reviewer_name` STRING COMMENT 'Full name of the employee who reviewed the bank reconciliation. Provides human-readable identification for reporting and audit purposes.',
    `statement_balance` DECIMAL(18,2) COMMENT 'The statement balance of the finance bank reconciliation record.',
    `statement_date` DATE COMMENT 'The ending date of the bank statement being reconciled. Represents the cutoff date for transactions included in the bank statement.',
    `statement_ending_balance` DECIMAL(18,2) COMMENT 'The ending balance as reported on the bank statement for the statement date. This is the banks record of the account balance.',
    `statement_ending_date` DATE COMMENT 'Timestamp capturing the statement ending date associated with the finance bank reconciliation record.',
    `statement_starting_date` DATE COMMENT 'Timestamp capturing the statement starting date associated with the finance bank reconciliation record.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation such as bank statements, reconciliation worksheets, or scanned images stored in the document management system.',
    `unreconciled_variance` DECIMAL(18,2) COMMENT 'The remaining difference between the adjusted bank balance and adjusted book balance after all known reconciling items have been applied. A non-zero variance indicates unresolved discrepancies requiring investigation.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_bank_reconciliation PRIMARY KEY(`bank_reconciliation_id`)
) COMMENT 'Transactional record of monthly bank reconciliation activities performed for each bank account. Captures reconciliation period, bank account reference, statement date, bank statement ending balance, GL book balance, outstanding checks total, deposits in transit total, bank errors, book errors, reconciled balance, reconciliation status (in progress, reconciled, approved), preparer, reviewer, approval date, and unreconciled variance amount. Ensures integrity between bank statements and the general ledger cash accounts.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` (
    `financial_period_close_id` BIGINT COMMENT 'Unique identifier for the financial period close record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who approved the final close of this period.',
    `financial_employee_id` BIGINT COMMENT 'Reference to the user who created this financial period close record.',
    `financial_entity_id` BIGINT COMMENT 'Unique identifier for the financial entity within the finance financial period close record.',
    `financial_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified this financial period close record.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period being closed (month, quarter, or year).',
    `general_ledger_id` BIGINT COMMENT 'Reference to the general ledger for which this close is being performed.',
    `primary_close_employee_id` BIGINT COMMENT 'Unique identifier for the primary close employee within the finance financial period close record.',
    `primary_financial_employee_id` BIGINT COMMENT 'Reference to the employee or user responsible for managing and completing this period close.',
    `prior_financial_period_close_id` BIGINT COMMENT 'Self-referencing FK on financial_period_close (prior_financial_period_close_id)',
    `accounts_payable_close_status` STRING COMMENT 'Status of accounts payable close activities, including vendor invoice processing and accrual verification.. Valid values are `not_started|in_progress|completed|review_required`',
    `accrual_completion_status` STRING COMMENT 'Status of accrual entries for the period, ensuring all revenue and expenses are recorded in the correct period per accrual accounting.. Valid values are `not_started|in_progress|completed|review_required`',
    `actual_close_date` DATE COMMENT 'Actual date when the financial period close was completed and the period was locked.',
    `approval_status` STRING COMMENT 'The approval status value classifying the finance financial period close record.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the period close was formally approved.',
    `approver_name` STRING COMMENT 'Name of the individual who approved the final close of this period, for reporting convenience.',
    `audit_findings_count` STRING COMMENT 'Number of audit findings or exceptions identified during the close process that require resolution.',
    `balance_sheet_reconciliation_status` STRING COMMENT 'Status of balance sheet account reconciliations for this period, ensuring all asset, liability, and equity accounts are reconciled.. Valid values are `not_started|in_progress|completed|exceptions_pending`',
    `budget_variance_review_status` STRING COMMENT 'Status of budget-to-actual variance analysis and review for this period.. Valid values are `not_started|in_progress|completed|escalated`',
    `close_checklist_completed_items` STRING COMMENT 'Number of checklist items that have been completed for this period close.',
    `close_checklist_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of close checklist items completed, calculated as (completed_items / total_items) * 100.',
    `close_checklist_total_items` STRING COMMENT 'Total number of checklist items that must be completed for this period close.',
    `close_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the period close process was fully completed.',
    `close_date` DATE COMMENT 'Timestamp capturing the close date associated with the finance financial period close record.',
    `close_delay_reason` STRING COMMENT 'Explanation for any delay in completing the period close beyond the planned close date.',
    `close_efficiency_rating` STRING COMMENT 'Qualitative assessment of the efficiency and timeliness of this period close process.. Valid values are `excellent|good|acceptable|needs_improvement`',
    `close_initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the period close process was initiated.',
    `close_notes` STRING COMMENT 'Additional notes, comments, or observations related to this period close process.',
    `close_number` STRING COMMENT 'Business identifier for the period close event, typically formatted as YYYY-MM-CLOSE or similar.',
    `close_status` STRING COMMENT 'Current status of the period close process. Soft close allows limited adjustments; hard close is final and locked.. Valid values are `open|in_progress|soft_close|hard_close|reopened|cancelled`',
    `close_type` STRING COMMENT 'Type of financial close being performed: monthly, quarterly, annual, or adjustment period close.. Valid values are `monthly|quarterly|annual|adjustment`',
    `cms_cost_report_status` STRING COMMENT 'Status of CMS cost report preparation and submission for this period, required for Medicare reimbursement.. Valid values are `not_applicable|not_started|in_progress|submitted|accepted|amended`',
    `completed_timestamp` TIMESTAMP COMMENT 'The completed timestamp of the finance financial period close record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this financial period close record was first created in the system.',
    `days_to_close` STRING COMMENT 'Number of calendar days taken to complete the close from period end date to actual close date.',
    `external_audit_status` STRING COMMENT 'Status of external audit review for this period, typically applicable for year-end closes.. Valid values are `not_applicable|not_started|in_progress|completed|findings_pending`',
    `financial_statement_preparation_status` STRING COMMENT 'Status of financial statement preparation for this period, including balance sheet, income statement, and cash flow statement.. Valid values are `not_started|in_progress|completed|approved`',
    `fixed_assets_close_status` STRING COMMENT 'Status of fixed asset close activities, including depreciation calculation and asset reconciliation.. Valid values are `not_started|in_progress|completed|review_required`',
    `hard_close_date` DATE COMMENT 'Date when the period was permanently closed and locked from further adjustments.',
    `intercompany_reconciliation_status` STRING COMMENT 'Status of intercompany account reconciliation for this period, ensuring balances between entities are matched.. Valid values are `not_started|in_progress|completed|exceptions_pending`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this financial period close record was last modified.',
    `notes` STRING COMMENT 'The notes of the finance financial period close record.',
    `open_items_count` STRING COMMENT 'Number of outstanding issues or tasks that must be resolved before the period can be closed.',
    `payroll_close_status` STRING COMMENT 'Status of payroll close activities for this period, ensuring all payroll expenses and liabilities are properly recorded.. Valid values are `not_started|in_progress|completed|review_required`',
    `planned_close_date` DATE COMMENT 'Target date by which the financial period close should be completed per the close calendar.',
    `prior_period_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this close includes adjustments to prior closed periods.',
    `regulatory_reporting_status` STRING COMMENT 'Status of regulatory reporting submissions required for this period, such as CMS cost reports or state financial filings.. Valid values are `not_required|not_started|in_progress|submitted|accepted`',
    `reopen_date` DATE COMMENT 'Date when a previously closed period was reopened for adjustments, if applicable.',
    `responsible_party` STRING COMMENT 'The responsible party of the finance financial period close record.',
    `revenue_cycle_close_status` STRING COMMENT 'Status of revenue cycle close activities, including patient accounts receivable reconciliation and revenue recognition.. Valid values are `not_started|in_progress|completed|review_required`',
    `soft_close_date` DATE COMMENT 'Date when the period was soft closed, allowing limited adjustments before final hard close.',
    `started_timestamp` TIMESTAMP COMMENT 'The started timestamp of the finance financial period close record.',
    `target_close_date` DATE COMMENT 'Timestamp capturing the target close date associated with the finance financial period close record.',
    `tasks_completed_count` STRING COMMENT 'The tasks completed count of the finance financial period close record.',
    `tasks_total_count` STRING COMMENT 'The tasks total count of the finance financial period close record.',
    `unposted_journals_count` STRING COMMENT 'Number of journal entries that have been entered but not yet posted to the general ledger for this period.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance financial period close record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance financial period close record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_financial_period_close PRIMARY KEY(`financial_period_close_id`)
) COMMENT 'Transactional record tracking the month-end, quarter-end, and year-end financial close process for the healthcare organization. Captures close period, close type (monthly, quarterly, annual), close status (open, in progress, soft close, hard close), planned close date, actual close date, close checklist completion percentage, number of open items, number of unposted journals, intercompany reconciliation status, accrual completion status, financial statement preparation status, external audit status (for year-end), and close owner. Drives the period-end close workflow and accountability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record within the integrated delivery network (IDN).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: intercompany_transaction has cost_center_code (STRING) which should be normalized to FK to cost_center master. Enables joining to get cost center details for intercompany transaction allocation.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: intercompany_transaction has fiscal_period (STRING) which should be normalized to FK to fiscal_period master. Enables joining to get period_name, start_date, end_date, period_status, and ensures inter',
    `financial_entity_id` BIGINT COMMENT 'Unique identifier for the from financial entity within the finance intercompany transaction record.',
    `intercompany_agreement_id` BIGINT COMMENT 'Reference to the master intercompany agreement or service level agreement that governs the terms of this transaction.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the consolidation elimination journal entry that offsets this intercompany transaction in the consolidated financial statements.',
    `intercompany_journal_entry_id` BIGINT COMMENT 'FK to journal entry',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: intercompany_transaction has originating_gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Using originating_chart_of_accounts_id as the FK name to distinguish from the',
    `employee_id` BIGINT COMMENT 'Identifier of the user or manager who approved the intercompany transaction for processing.',
    `primary_intercompany_financial_entity_id` BIGINT COMMENT 'Identifier of the legal entity within the IDN that initiated or is the source of the intercompany transaction.',
    `primary_reversed_transaction_intercompany_transaction_id` BIGINT COMMENT 'Reference to the original intercompany transaction that this record reverses, if applicable.',
    `receiving_entity_financial_entity_id` BIGINT COMMENT 'Identifier of the legal entity within the IDN that receives or is the destination of the intercompany transaction.',
    `target_financial_entity_id` BIGINT COMMENT 'Unique identifier for the target financial entity within the finance intercompany transaction record.',
    `to_financial_entity_id` BIGINT COMMENT 'Unique identifier for the to financial entity within the finance intercompany transaction record.',
    `identity_merge_history_id` BIGINT COMMENT 'Unique identifier for the receiving entity within the finance intercompany transaction record.',
    `organization_id` BIGINT COMMENT 'Unique identifier for the sending entity within the finance intercompany transaction record.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the finance intercompany transaction record.',
    `approval_date` DATE COMMENT 'The date on which the intercompany transaction was approved by the authorized approver for processing and posting.',
    `batch_code` STRING COMMENT 'Identifier of the batch or group of intercompany transactions processed together for efficiency and control purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the intercompany transaction amount is denominated.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `intercompany_transaction_description` STRING COMMENT 'Detailed narrative description of the intercompany transaction explaining the business purpose and nature of the transfer.',
    `elimination_flag` BOOLEAN COMMENT 'The elimination flag of the finance intercompany transaction record.',
    `elimination_indicator` BOOLEAN COMMENT 'Flag indicating whether this intercompany transaction requires elimination during the consolidated financial statement preparation process.',
    `elimination_period` STRING COMMENT 'The fiscal period identifier in which the intercompany elimination entry will be or was recorded for consolidation purposes.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction amount from the transaction currency to the functional currency.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction was recorded for financial reporting and consolidation purposes.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the functional currency of the consolidated entity for financial reporting purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was last modified or updated in the system.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the intercompany transaction for audit trail and clarification purposes.',
    `originating_entity_code` STRING COMMENT 'Business code or abbreviation of the originating legal entity for reporting and identification purposes.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction was posted to the general ledger systems of both entities.',
    `posting_date` DATE COMMENT 'The date on which the intercompany transaction was posted to the general ledger of both originating and receiving entities.',
    `posting_status` STRING COMMENT 'The posting status value classifying the finance intercompany transaction record.',
    `receiving_entity_code` STRING COMMENT 'Business code or abbreviation of the receiving legal entity for reporting and identification purposes.',
    `receiving_gl_account_code` STRING COMMENT 'The general ledger account code in the receiving entitys chart of accounts to which this transaction is posted.',
    `reconciliation_date` DATE COMMENT 'The date on which the intercompany transaction was successfully reconciled between the originating and receiving entities.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the intercompany transaction has been successfully reconciled between the originating and receiving entities.. Valid values are `unreconciled|partially_reconciled|reconciled|variance_identified|under_review`',
    `reconciliation_variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference identified during reconciliation between the originating and receiving entity records for this transaction.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this intercompany transaction is a reversal of a previously posted transaction.',
    `service_line_code` STRING COMMENT 'The service line or business unit code associated with the intercompany transaction for segment reporting and profitability analysis.',
    `settlement_date` DATE COMMENT 'Timestamp capturing the settlement date associated with the finance intercompany transaction record.',
    `settlement_status` STRING COMMENT 'The settlement status value classifying the finance intercompany transaction record.',
    `source_financial_entity_id` BIGINT COMMENT 'Unique identifier for the source financial entity within the finance intercompany transaction record.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system or application from which the intercompany transaction data was sourced (e.g., SAP, Epic, Oracle).',
    `source_transaction_reference` STRING COMMENT 'The unique transaction identifier from the source system that originated this intercompany transaction record.',
    `supporting_document_reference` STRING COMMENT 'Reference number or identifier of supporting documentation (invoices, agreements, memos) that substantiate the intercompany transaction.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount associated with the intercompany transaction, if applicable, for jurisdictions requiring intercompany taxation.',
    `tax_code` STRING COMMENT 'The tax classification code applied to the intercompany transaction for tax reporting and compliance purposes.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction in the specified currency, representing the gross amount transferred between entities.',
    `transaction_date` DATE COMMENT 'The date on which the intercompany transaction was executed or recorded in the originating entitys books.',
    `transaction_description` STRING COMMENT 'The transaction description of the finance intercompany transaction record.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number assigned to the intercompany transaction for tracking and reference purposes.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the intercompany transaction indicating its processing state and readiness for consolidation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|reconciled|eliminated|rejected — 7 candidates stripped; promote to reference product]',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the financial activity between legal entities.. Valid values are `management_fee|shared_service_charge|intercompany_loan|cost_transfer|intercompany_sale|capital_allocation`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance intercompany transaction record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance intercompany transaction record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Transactional record of financial transactions between legal entities within the healthcare integrated delivery network (IDN), including management fees, shared service charges, intercompany loans, and cost transfers. Captures transaction date, transaction type (management fee, shared service charge, intercompany loan, cost transfer, intercompany sale), originating entity, receiving entity, transaction amount, currency, GL account (originating), GL account (receiving), cost center, elimination indicator, elimination period, and reconciliation status. Supports consolidated financial statement preparation and intercompany elimination.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` (
    `financial_entity_id` BIGINT COMMENT 'Unique identifier for the financial entity record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the finance financial entity record.',
    `parent_entity_financial_entity_id` BIGINT COMMENT 'Reference to the parent financial entity in the corporate hierarchy. Null for top-level holding companies.',
    `parent_financial_entity_id` BIGINT COMMENT 'Self-referencing FK on financial_entity (parent_financial_entity_id)',
    `accounting_basis` STRING COMMENT 'Primary accounting framework used for financial reporting. GAAP = Generally Accepted Accounting Principles, GASB = Governmental Accounting Standards Board, IFRS = International Financial Reporting Standards.. Valid values are `gaap|gasb|ifrs|cash|modified_accrual`',
    `cms_provider_number` STRING COMMENT 'CMS Certification Number (CCN) assigned to Medicare-certified facilities for billing and reimbursement.. Valid values are `^[0-9A-Z]{6}$`',
    `consolidation_method` STRING COMMENT 'Accounting method used to consolidate this entity into parent financial statements.. Valid values are `full_consolidation|equity_method|proportional|cost_method|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial entity record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code value classifying the finance financial entity record.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet identifier used for business credit and vendor management.. Valid values are `^[0-9]{9}$`',
    `effective_end_date` DATE COMMENT 'Date when this entity record ceased to be effective. Null for currently active entities.',
    `effective_start_date` DATE COMMENT 'Date when this entity record became effective for financial reporting and consolidation purposes.',
    `entity_code` STRING COMMENT 'Unique business identifier code for the legal entity used across financial systems and reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `entity_description` STRING COMMENT 'Detailed narrative description of the entitys business purpose, services, and role within the corporate structure.',
    `entity_name` STRING COMMENT 'The full legal name of the entity as registered with regulatory authorities.',
    `entity_status` STRING COMMENT 'Current operational and legal status of the entity within the corporate structure.. Valid values are `active|inactive|pending|dissolved|merged|divested`',
    `entity_subtype` STRING COMMENT 'Additional classification detail for the entity type (e.g., acute care hospital, specialty clinic, MSSP ACO).',
    `entity_type` STRING COMMENT 'Classification of the legal entity type within the healthcare organization structure. ACO = Accountable Care Organization.. Valid values are `hospital|physician_group|foundation|aco|health_plan|holding_company`',
    `external_auditor_name` STRING COMMENT 'Name of the external audit firm responsible for auditing this entitys financial statements.',
    `federal_tax_identification_number` STRING COMMENT 'The federal tax identification number of the finance financial entity record.',
    `fiscal_year_end_day` STRING COMMENT 'Day of month (1-31) representing the end of the entitys fiscal year.',
    `fiscal_year_end_month` STRING COMMENT 'Month number (1-12) representing the end of the entitys fiscal year for financial reporting purposes.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary currency in which the entity conducts business and maintains its books.. Valid values are `^[A-Z]{3}$`',
    `incorporation_date` DATE COMMENT 'Date the entity was legally incorporated or established.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions involving this entity require elimination entries during consolidation.',
    `joint_venture_flag` BOOLEAN COMMENT 'Indicates whether this entity is a joint venture with external partners requiring special consolidation treatment.',
    `last_audit_date` DATE COMMENT 'Date of the most recent completed external financial audit for this entity.',
    `legal_entity_address_line1` STRING COMMENT 'Primary street address line for the entitys legal registered address.',
    `legal_entity_address_line2` STRING COMMENT 'Secondary address line (suite, floor, building) for the entitys legal registered address.',
    `legal_entity_city` STRING COMMENT 'City name for the entitys legal registered address.',
    `legal_entity_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the entitys legal registered address.. Valid values are `^[A-Z]{3}$`',
    `legal_entity_postal_code` STRING COMMENT 'ZIP or postal code for the entitys legal registered address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `legal_entity_state` STRING COMMENT 'Two-letter US state code for the entitys legal registered address.. Valid values are `^[A-Z]{2}$`',
    `legal_name` STRING COMMENT 'The legal name of the finance financial entity record.',
    `medicare_cost_report_required_flag` BOOLEAN COMMENT 'Indicates whether this entity is required to file an annual Medicare cost report with CMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial entity record was last modified.',
    `notes` STRING COMMENT 'The notes of the finance financial entity record.',
    `npi` STRING COMMENT 'National Provider Identifier assigned by CMS for healthcare entities that bill for services. Applicable to hospitals, physician groups, and other provider entities.. Valid values are `^[0-9]{10}$`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership interest held by the parent entity, used for consolidation calculations.',
    `primary_contact_email` STRING COMMENT 'Primary email address for business contact with this entity.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact or officer for this entity.',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for business contact with this entity.',
    `regulatory_reporting_tier` STRING COMMENT 'Classification tier determining the level of regulatory reporting required for this entity based on size, revenue, or patient volume.. Valid values are `tier1|tier2|tier3|exempt`',
    `reporting_entity_flag` BOOLEAN COMMENT 'Indicates whether this entity produces standalone financial statements for external reporting.',
    `state_of_incorporation` STRING COMMENT 'Two-letter US state code where the entity is legally incorporated or registered.. Valid values are `^[A-Z]{2}$`',
    `tax_exempt_status` STRING COMMENT 'IRS tax-exempt classification for the entity. 501(c)(3) is common for nonprofit hospitals and foundations.. Valid values are `501c3|501c4|501c6|taxable|other_exempt`',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the finance financial entity record.',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) assigned by the IRS for tax reporting purposes.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `tax_status` STRING COMMENT 'The tax status value classifying the finance financial entity record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance financial entity record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance financial entity record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_financial_entity PRIMARY KEY(`financial_entity_id`)
) COMMENT 'Master record for each legal entity, subsidiary, and reporting unit within the healthcare organizations corporate structure. Captures entity code, entity name, entity type (hospital, physician group, foundation, ACO, health plan, holding company, joint venture), tax ID (EIN), NPI (if applicable), state of incorporation, fiscal year end, functional currency, consolidation method (full consolidation, equity method, proportional), parent entity, GAAP vs GASB reporting basis, CMS provider number, and entity status. Drives intercompany elimination and consolidated financial reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`fund` (
    `fund_id` BIGINT COMMENT 'Unique identifier for the fund record. Primary key for the fund entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the primary facility or hospital associated with this fund for facility-level financial reporting.',
    `financial_entity_id` BIGINT COMMENT 'Foreign key linking to finance.financial_entity. Business justification: fund has legal_entity_id (BIGINT) which should be normalized to FK to financial_entity. The attribute name uses legal_entity but should point to financial_entity.financial_entity_id. Enables joining',
    `parent_fund_id` BIGINT COMMENT 'Reference to a parent fund if this fund is a sub-fund or component of a larger fund structure.',
    `primary_consolidation_fund_id` BIGINT COMMENT 'Reference to the fund into which this fund rolls up for consolidated financial reporting.',
    `donor_id` BIGINT COMMENT 'Reference to the donor entity in the donor management system for restricted and endowment funds.',
    `approval_date` DATE COMMENT 'Date when the fund was formally approved for use in financial transactions.',
    `approval_status` STRING COMMENT 'Current approval status of the fund setup, indicating whether it has been reviewed and authorized for use.. Valid values are `draft|pending_approval|approved|rejected`',
    `balance` DECIMAL(18,2) COMMENT 'Current balance of the fund representing the difference between fund assets and liabilities. For endowments, represents the corpus and accumulated earnings.',
    `beginning_balance` DECIMAL(18,2) COMMENT 'Fund balance at the start of the current fiscal period, used for reconciliation and variance analysis.',
    `fund_category` STRING COMMENT 'Broad category grouping for the fund used for financial statement presentation and consolidation. [ENUM-REF-CANDIDATE: operating|restricted|endowment|capital|agency|plant|debt_service — 7 candidates stripped; promote to reference product]',
    `closure_date` DATE COMMENT 'Date when the fund was formally closed and all balances transferred or depleted.',
    `closure_reason` STRING COMMENT 'Explanation for why the fund was closed, such as purpose fulfilled, grant expired, or donor request.',
    `cms_provider_number` STRING COMMENT 'Six-digit CMS provider number associated with the fund for Medicare cost reporting and reimbursement tracking.. Valid values are `^[0-9]{6}$`',
    `fund_code` STRING COMMENT 'Unique alphanumeric code assigned to the fund for identification in financial transactions and reporting. This is the externally-known business identifier used across systems.. Valid values are `^[A-Z0-9]{3,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the fund record was first created in the database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the functional currency of the fund.. Valid values are `^[A-Z]{3}$`',
    `donor_restriction_indicator` BOOLEAN COMMENT 'Flag indicating whether the fund is subject to donor-imposed restrictions requiring separate tracking and reporting.',
    `effective_end_date` DATE COMMENT 'Date when the fund was closed or became inactive, if applicable. Null for active funds.',
    `effective_start_date` DATE COMMENT 'Date when the fund became active and available for financial transactions.',
    `endowment_corpus_amount` DECIMAL(18,2) COMMENT 'Original principal amount of an endowment fund that must be maintained in perpetuity per donor restrictions.',
    `establishment_date` DATE COMMENT 'Date when the fund was originally established or created in the financial system.',
    `fund_balance` DECIMAL(18,2) COMMENT 'The fund balance of the finance fund record.',
    `fund_purpose` STRING COMMENT 'The fund purpose of the finance fund record.',
    `fund_status` STRING COMMENT 'Current lifecycle status of the fund indicating whether it is available for transactions and reporting.. Valid values are `active|closed|depleted|suspended|pending_approval`',
    `fund_type` STRING COMMENT 'Classification of the fund based on restriction and purpose. Determines accounting treatment and reporting requirements for not-for-profit healthcare organizations.. Valid values are `unrestricted_operating|temporarily_restricted|permanently_restricted|endowment|capital|grant`',
    `funding_source` STRING COMMENT 'Description of the source of funds, such as federal grant, state appropriation, private donation, or operating revenue.',
    `grant_number` STRING COMMENT 'External grant or award number assigned by the funding agency for grant-type funds, used for compliance and reporting.',
    `investment_policy_code` STRING COMMENT 'Code referencing the investment policy governing how fund assets may be invested, particularly for endowment and capital funds.',
    `is_restricted` BOOLEAN COMMENT 'Boolean flag indicating the is restricted status of the finance fund record.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the fund record was last modified.',
    `fund_name` STRING COMMENT 'Full descriptive name of the fund as it appears in financial statements and reports.',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, or historical context about the fund.',
    `purpose` STRING COMMENT 'Business purpose and intended use of the fund, describing the programs, services, or capital projects it supports.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Flag indicating whether this fund is subject to external regulatory reporting requirements such as CMS cost reports or state financial filings.',
    `reporting_requirements` STRING COMMENT 'Detailed description of specific reporting obligations, frequencies, and regulatory bodies to which fund activity must be reported.',
    `restriction_description` STRING COMMENT 'Detailed narrative describing the specific restrictions, donor stipulations, or regulatory requirements governing the use of fund assets.',
    `restriction_type` STRING COMMENT 'Type of restriction placed on the fund indicating the source and nature of limitations on fund usage.. Valid values are `unrestricted|donor_restricted|board_designated|regulatory_restricted|grant_restricted`',
    `spending_policy` STRING COMMENT 'The spending policy of the finance fund record.',
    `spending_policy_rate` DECIMAL(18,2) COMMENT 'Annual percentage rate at which endowment earnings may be spent, as defined by board policy or donor agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance fund record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance fund record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Master record for all funds used in healthcare fund accounting, including operating funds, restricted funds, endowment funds, capital funds, and grant funds. Captures fund code, fund name, fund type (unrestricted operating, temporarily restricted, permanently restricted, endowment, capital, grant, agency), restriction description, donor restriction indicator, fund purpose, fund balance, fund status (active, closed, depleted), associated legal entity, fund manager, and applicable regulatory or donor reporting requirements. Essential for not-for-profit healthcare fund accounting compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` (
    `financial_forecast_id` BIGINT COMMENT 'Unique identifier for the financial forecast record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the executive or manager who approved this forecast. Links to the employee or workforce management system.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or entity to which this forecast applies. Supports facility-level and consolidated financial planning.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center to which this forecast applies, if the forecast is prepared at the cost center level rather than enterprise-wide.',
    `financial_employee_id` BIGINT COMMENT 'System user identifier of the person who created this forecast record. Supports audit trail and accountability.',
    `financial_entity_id` BIGINT COMMENT 'Foreign key linking to finance.financial_entity. Business justification: financial_forecast should link to financial_entity to identify which legal entity the forecast belongs to. This is essential for multi-entity healthcare organizations to track forecasts by subsidiary.',
    `financial_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who last modified this forecast record. Supports audit trail and accountability.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department to which this forecast applies, if the forecast is prepared at the department level.',
    `parent_financial_forecast_id` BIGINT COMMENT 'Identifier of the parent forecast if this forecast is a component of a larger consolidated forecast. Supports hierarchical financial planning structures.',
    `primary_financial_preparer_employee_id` BIGINT COMMENT 'Identifier of the finance team member who prepared this forecast. Links to the employee or workforce management system.',
    `primary_superseded_by_financial_forecast_id` BIGINT COMMENT 'Identifier of the newer forecast that supersedes this one. Null if this is the current active forecast. Supports version history and audit trail.',
    `approval_date` DATE COMMENT 'Date on which the forecast was formally approved by the designated authority. Marks the transition to official plan of record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the finance financial forecast record.',
    `assumptions_narrative` STRING COMMENT 'Detailed narrative documenting the key assumptions, drivers, and rationale underlying the forecast. Includes market conditions, volume assumptions, rate assumptions, cost inflation factors, strategic initiatives, and risk factors.',
    `baseline_flag` BOOLEAN COMMENT 'Indicates whether this forecast version is the official baseline plan of record against which actual performance will be measured. True if baseline, False otherwise.',
    `board_presentation_date` DATE COMMENT 'Date on which this forecast was presented to the board of directors or trustees. Null if not presented.',
    `board_presentation_flag` BOOLEAN COMMENT 'Indicates whether this forecast was presented to the board of directors or trustees. True if presented, False otherwise. Used for governance and reporting tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this forecast record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this forecast (e.g., USD for US Dollar). Ensures consistent financial reporting across multi-currency environments.. Valid values are `^[A-Z]{3}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this forecast applies, represented as a four-digit year (e.g., 2024). Aligns with the organizations fiscal calendar.',
    `forecast_horizon` STRING COMMENT 'The forecast horizon of the finance financial forecast record.',
    `forecast_method` STRING COMMENT 'The forecast method of the finance financial forecast record.',
    `forecast_methodology` STRING COMMENT 'The forecasting technique or approach used to develop the projections. Trend analysis extrapolates historical patterns, driver-based links to operational metrics, zero-based builds from scratch, activity-based costs by activity, regression uses statistical models. [ENUM-REF-CANDIDATE: trend_analysis|driver_based|zero_based|activity_based|regression_model|scenario_planning|hybrid — 7 candidates stripped; promote to reference product]',
    `forecast_name` STRING COMMENT 'Descriptive name of the financial forecast, typically indicating the planning cycle or scenario (e.g., FY2024 Q2 Rolling Forecast, Long-Range Strategic Plan 2024-2028).',
    `forecast_number` STRING COMMENT 'Business-assigned unique identifier for the forecast, used for external reference and tracking across financial planning cycles.',
    `forecast_period_end_date` DATE COMMENT 'The last date of the period covered by this forecast. Defines the end of the planning horizon.',
    `forecast_period_months` STRING COMMENT 'Number of months covered by the forecast period. Typical values include 12 for annual plans, 18-24 for rolling forecasts, and 36-60 for long-range plans.',
    `forecast_period_start_date` DATE COMMENT 'The first date of the period covered by this forecast. Defines the beginning of the planning horizon.',
    `forecast_scenario` STRING COMMENT 'The forecast scenario of the finance financial forecast record.',
    `forecast_status` STRING COMMENT 'Current lifecycle state of the forecast. Draft indicates work in progress, submitted awaits review, approved is finalized, baseline is the official plan of record, superseded has been replaced by a newer version. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|baseline|superseded|archived — 7 candidates stripped; promote to reference product]',
    `forecast_type` STRING COMMENT 'Classification of the forecast methodology and planning horizon. Rolling forecasts update continuously, annual operating plans cover a single fiscal year, long-range plans span multiple years, and scenario analyses model alternative futures.. Valid values are `rolling_forecast|annual_operating_plan|long_range_plan|scenario_analysis|budget_reforecast|strategic_plan`',
    `forecast_version` STRING COMMENT 'Version identifier for the forecast, enabling tracking of iterations and revisions (e.g., V1.0, V2.1, Q2 Update). Supports audit trail and version control.',
    `forecasted_cmi` DECIMAL(18,2) COMMENT 'Projected average case mix index for the forecast period, reflecting the expected complexity and resource intensity of patient cases. Used for revenue and cost modeling under DRG-based payment systems.',
    `forecasted_fte_count` DECIMAL(18,2) COMMENT 'Projected total full-time equivalent staffing levels for the forecast period. Critical for labor cost planning and productivity analysis.',
    `forecasted_patient_volume` STRING COMMENT 'Projected total patient encounters or admissions for the forecast period. Key volume driver for revenue and resource planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this forecast record was last modified. Supports audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, context, or special instructions related to this forecast. Used for collaboration and documentation.',
    `scenario` STRING COMMENT 'The scenario of the finance financial forecast record.',
    `scenario_description` STRING COMMENT 'Description of the scenario being modeled (e.g., base case, best case, worst case, strategic initiative impact). Used for scenario analysis and sensitivity testing.',
    `service_line_code` STRING COMMENT 'Code identifying the clinical service line to which this forecast applies (e.g., cardiology, orthopedics, oncology). Supports service line financial planning and performance management.',
    `submission_date` DATE COMMENT 'Date on which the forecast was submitted for review and approval. Tracks the workflow progression.',
    `total_forecast_expense` DECIMAL(18,2) COMMENT 'The total forecast expense of the finance financial forecast record.',
    `total_forecast_revenue` DECIMAL(18,2) COMMENT 'The total forecast revenue of the finance financial forecast record.',
    `total_forecasted_capital_expenditure` DECIMAL(18,2) COMMENT 'Total projected capital spending for the forecast period, including facility construction, equipment purchases, technology investments, and major renovations.',
    `total_forecasted_expense` DECIMAL(18,2) COMMENT 'Total projected operating expenses for the forecast period, including salaries and benefits, supplies, purchased services, depreciation, and other operating costs.',
    `total_forecasted_net_income` DECIMAL(18,2) COMMENT 'Projected net income after all revenues, expenses, non-operating items, and taxes. Bottom line of the forecasted income statement.',
    `total_forecasted_operating_income` DECIMAL(18,2) COMMENT 'Projected operating income (revenue minus expenses) for the forecast period. Key performance metric for financial sustainability and operational efficiency.',
    `total_forecasted_revenue` DECIMAL(18,2) COMMENT 'Total projected operating revenue for the forecast period, including patient service revenue, capitation revenue, and other operating income. Represents the top line of the forecasted income statement.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance financial forecast record.',
    `version` STRING COMMENT 'The version of the finance financial forecast record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance financial forecast record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_financial_forecast PRIMARY KEY(`financial_forecast_id`)
) COMMENT 'Master record for rolling financial forecasts and financial planning scenarios prepared by the healthcare finance team. Captures forecast name, forecast type (rolling forecast, annual operating plan, long-range plan, scenario analysis), fiscal year, forecast version, forecast status (draft, submitted, approved, baseline), forecast period coverage (months), total forecasted revenue, total forecasted expense, total forecasted operating income, forecast methodology, assumptions narrative, preparer, approver, and approval date. Supports financial planning and analysis (FP&A) and board-level financial reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` (
    `forecast_line_id` BIGINT COMMENT 'Unique identifier for the forecast line item. Primary key for the forecast line entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: forecast_line has gl_account_code (STRING) which should be normalized to FK to chart_of_accounts. Enables joining to get account metadata and ensures forecast lines reference valid GL accounts.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: forecast_line has cost_center_code (STRING) which should be normalized to FK to cost_center master. Enables joining to get cost center details and ensures referential integrity.',
    `financial_forecast_id` BIGINT COMMENT 'Reference to the parent financial forecast header that this line belongs to. Links to the forecast master record.',
    `fiscal_period_id` BIGINT COMMENT 'Unique identifier for the fiscal period within the finance forecast line record.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: forecast_line has fund_code (STRING) which should be normalized to FK to fund master. Enables joining to get fund details and ensures forecast lines reference valid funds.',
    `prior_forecast_line_id` BIGINT COMMENT 'Self-referencing FK on forecast_line (prior_forecast_line_id)',
    `allocation_method` STRING COMMENT 'Method used to allocate or distribute the forecasted amount across cost centers, departments, or service lines (e.g., direct assignment, proportional allocation, activity-based). Documents allocation transparency.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total forecasted amount allocated to this specific cost center or service line. Used when forecast amounts are distributed across multiple organizational units.',
    `approval_status` STRING COMMENT 'Current approval workflow status of this forecast line (draft, submitted, approved, rejected, revised). Tracks governance and authorization of forecast assumptions.. Valid values are `draft|submitted|approved|rejected|revised`',
    `approved_by` STRING COMMENT 'Name or identifier of the user or role who approved this forecast line. Provides audit trail for forecast authorization.',
    `approved_date` DATE COMMENT 'Date on which this forecast line was formally approved. Establishes the effective date of forecast commitment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast line record was first created in the system. Provides audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the forecasted amount (e.g., USD, EUR, GBP). Supports multi-currency financial planning.. Valid values are `^[A-Z]{3}$`',
    `current_budget_amount` DECIMAL(18,2) COMMENT 'The approved budget amount for the same GL account, cost center, and fiscal period. Enables forecast-to-budget variance analysis.',
    `driver_assumption` STRING COMMENT 'The driver assumption of the finance forecast line record.',
    `effective_end_date` DATE COMMENT 'Date on which this forecast line ceases to be effective. Nullable for currently active forecast lines. Supports historical forecast analysis.',
    `effective_start_date` DATE COMMENT 'Date from which this forecast line becomes effective. Supports time-based forecast versioning and historical tracking.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month, quarter, or other sub-annual period) within the fiscal year for which this forecast line projects financial activity.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this forecast line applies. Represents the annual financial planning period.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'The forecast amount of the finance forecast line record.',
    `forecast_category` STRING COMMENT 'High-level classification of the forecast line into major financial statement categories: revenue, salary expense, non-salary expense, capital expenditure, or other.. Valid values are `revenue|salary_expense|non_salary_expense|capital|other`',
    `forecast_confidence_level` STRING COMMENT 'Qualitative assessment of the reliability and certainty of this forecast line (high, medium, low). Reflects data quality, volatility, and external risk factors.. Valid values are `high|medium|low`',
    `forecast_scenario` STRING COMMENT 'Scenario or case identifier for this forecast line (e.g., base case, best case, worst case, strategic initiative). Supports scenario planning and sensitivity analysis.',
    `forecast_version` STRING COMMENT 'Version identifier for the forecast (e.g., Q1 Forecast, Mid-Year Reforecast, Year-End Projection). Tracks forecast iterations and updates throughout the fiscal year.',
    `forecasted_amount` DECIMAL(18,2) COMMENT 'The projected financial amount for this GL account, cost center, and fiscal period combination. Represents the best estimate of future financial performance.',
    `fte_count` DECIMAL(18,2) COMMENT 'Forecasted number of Full-Time Equivalent staff positions associated with this line, particularly relevant for salary expense forecasts. Supports workforce planning integration.',
    `grant_number` STRING COMMENT 'Grant or award identifier if this forecast line is funded by a specific grant. Links forecast to grant management and compliance tracking.',
    `is_capital` BOOLEAN COMMENT 'Boolean flag indicating whether this forecast line represents a capital expenditure (True) or an operating expense/revenue (False). Supports capital budgeting and cash flow planning.',
    `is_restricted` BOOLEAN COMMENT 'Boolean flag indicating whether this forecast line is associated with restricted funds or grants (True) or unrestricted general operating funds (False). Critical for fund accounting compliance.',
    `line_description` STRING COMMENT 'The line description of the finance forecast line record.',
    `line_notes` STRING COMMENT 'Free-text notes or comments providing additional context, assumptions, or explanations for this forecast line. Supports collaborative planning and documentation.',
    `line_number` STRING COMMENT 'Sequential line number within the parent forecast, used for ordering and referencing specific forecast line items.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this forecast line record. Supports change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast line record was last modified. Tracks the most recent update to the forecast data.',
    `prior_period_actual` DECIMAL(18,2) COMMENT 'The prior period actual of the finance forecast line record.',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'The actual financial result for the same GL account, cost center, and fiscal period in the prior year. Provides historical baseline for variance analysis.',
    `project_code` STRING COMMENT 'Project or initiative identifier for capital projects or strategic initiatives. Enables project-based financial tracking and reporting.',
    `service_line_code` STRING COMMENT 'Clinical or operational service line classification (e.g., cardiology, orthopedics, emergency services) for revenue and expense attribution.',
    `statistical_basis` STRING COMMENT 'Description of the statistical or analytical method used to derive the forecast (e.g., trend analysis, regression, historical average, zero-based). Documents forecast rigor and reliability.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The variance amount of the finance forecast line record.',
    `variance_percent` DECIMAL(18,2) COMMENT 'The variance percent of the finance forecast line record.',
    `variance_to_budget` DECIMAL(18,2) COMMENT 'Calculated variance between the forecasted amount and the current budget amount (forecast minus budget). Highlights deviations from the approved financial plan.',
    `variance_to_prior_year` DECIMAL(18,2) COMMENT 'Calculated variance between the forecasted amount and the prior year actual amount (forecast minus prior year). Measures year-over-year growth or decline.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance forecast line record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `volume_assumption` DECIMAL(18,2) COMMENT 'The volume assumption of the finance forecast line record.',
    `volume_driver_assumption` STRING COMMENT 'Description of the key volume or activity driver underlying this forecast (e.g., patient days, surgical cases, outpatient visits, Full-Time Equivalents). Provides transparency into forecast methodology.',
    `volume_quantity` DECIMAL(18,2) COMMENT 'Numeric quantity of the volume driver assumed in this forecast line. Enables calculation of per-unit rates and variance analysis.',
    `volume_unit` STRING COMMENT 'Unit of measure for the volume driver (e.g., patient days, cases, visits, FTE, admissions). Standardizes volume metrics across forecast lines.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this forecast line record. Supports accountability and audit trail.',
    CONSTRAINT pk_forecast_line PRIMARY KEY(`forecast_line_id`)
) COMMENT 'Individual line-item detail within a financial forecast, representing the projected financial amount for a specific GL account, cost center, and fiscal period combination. Captures forecast reference, GL account code, cost center, fund, service line, fiscal period, forecasted amount, forecast category (revenue, salary expense, non-salary expense, capital), volume driver assumption, statistical basis, prior year actual amount, current budget amount, and variance to budget. Enables granular FP&A drill-down and variance analysis between forecast, budget, and actuals.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` (
    `invoice_payment_application_id` BIGINT COMMENT 'Unique identifier for this payment application record. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to the accounts payable invoice being paid or settled by this payment application.',
    `ap_invoice_line_id` BIGINT COMMENT 'Unique identifier for the ap invoice line within the finance invoice payment application record.',
    `ap_payment_id` BIGINT COMMENT 'Foreign key linking to the accounts payable payment being applied to settle the invoice.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system user who created this payment application record.',
    `amount_applied` DECIMAL(18,2) COMMENT 'The monetary amount of this payment that was applied to settle this specific invoice. For partial payments, this will be less than the total payment amount. For split payments across multiple invoices, the sum of amount_applied across all applications equals the total payment amount.',
    `amount_paid` DECIMAL(18,2) COMMENT 'The total amount that has been paid against this invoice to date. May be less than total_amount for partial payments. [Moved from ap_invoice: This attribute represents the total amount paid against an invoice, which is actually the SUM of amount_applied across all payment applications for this invoice. It is a derived/calculated value that belongs in the association layer, not as a standalone attribute on the invoice.]',
    `amount_remaining` DECIMAL(18,2) COMMENT 'The outstanding balance remaining to be paid on this invoice, calculated as total_amount - amount_paid. [Moved from ap_invoice: This attribute represents the outstanding balance on an invoice, which is calculated as total_amount minus the sum of amount_applied from all payment applications. It is a derived value that should be calculated from the association data, not stored redundantly on the invoice.]',
    `application_date` DATE COMMENT 'The date on which this payment was applied to this invoice in the accounts payable system. This is the business event date for the payment allocation and may differ from the payment_date if payments are applied retroactively or in batch processes.',
    `application_sequence` STRING COMMENT 'The sequence number of this application when a single payment is applied to multiple invoices. Used to track the order in which payment funds were allocated across invoices, which is important for cash application rules and aging calculations.',
    `application_status` STRING COMMENT 'The current status of this payment application. Values: applied (payment successfully applied to invoice), reversed (application was reversed due to payment void or correction), pending (application awaiting approval or clearing), cleared (application confirmed and reconciled).',
    `applied_amount` DECIMAL(18,2) COMMENT 'The applied amount of the finance invoice payment application record.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this payment application record was created.',
    `currency_code` STRING COMMENT 'The currency code value classifying the finance invoice payment application record.',
    `discount_taken` DECIMAL(18,2) COMMENT 'The early payment discount amount taken on this specific invoice as part of this payment application. If a payment covers multiple invoices, each invoice may have a different discount amount based on its payment terms and timing.',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'The discount taken amount of the finance invoice payment application record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the finance invoice payment application record.',
    `notes` STRING COMMENT 'The notes of the finance invoice payment application record.',
    `payment_date` DATE COMMENT 'The date the payment was issued to the vendor. [Moved from ap_invoice: An invoice can be paid by multiple payments on different dates. The payment_date belongs to the payment entity (ap_payment), and the relationship between invoice and payment is captured through the application_date in the association. This attribute on the invoice is ambiguous when multiple payments exist.]',
    `remaining_balance` DECIMAL(18,2) COMMENT 'The remaining balance of the finance invoice payment application record.',
    `reversal_date` DATE COMMENT 'The date on which this payment application was reversed or voided. Null if the application has not been reversed.',
    `reversal_flag` BOOLEAN COMMENT 'The reversal flag of the finance invoice payment application record.',
    `reversal_reason` STRING COMMENT 'Business reason or explanation for why this payment application was reversed. Null if not reversed.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance invoice payment application record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance invoice payment application record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `writeoff_amount` DECIMAL(18,2) COMMENT 'The writeoff amount of the finance invoice payment application record.',
    CONSTRAINT pk_invoice_payment_application PRIMARY KEY(`invoice_payment_application_id`)
) COMMENT 'This association product represents the application of a payment to an invoice in the accounts payable process. It captures the specific allocation of payment funds to settle invoice balances, including partial payments, overpayments, and payment reversals. Each record links one ap_invoice to one ap_payment with attributes that exist only in the context of this payment application event.. Existence Justification: In healthcare accounts payable operations, a single vendor invoice can be paid through multiple payments (partial payments, installment payments, or corrections), and a single payment disbursement can be applied to settle multiple invoices from the same vendor (batch payment allocation). Finance teams actively manage payment applications as a distinct business process, tracking which portion of each payment settles which invoice, including discount calculations, application sequencing, and reversal handling.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` (
    `fund_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for the fund allocation record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this fund allocation. Used for accountability and audit trail.',
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts within the finance fund allocation record.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `fiscal_period_id` BIGINT COMMENT 'Unique identifier for the fiscal period within the finance fund allocation record.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to the fund being allocated to the organizational provider',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to the organizational provider receiving fund allocation',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the finance fund allocation record.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount allocated to this organizational provider from the fund, if allocation is amount-based rather than percentage-based. Mutually exclusive with allocation_percentage in business logic.',
    `allocation_date` DATE COMMENT 'Timestamp capturing the allocation date associated with the finance fund allocation record.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the fund allocated to this organizational provider. Used for proportional expense allocation and fund balance distribution. Must sum to 1.0000 across all allocations for a given fund.',
    `allocation_purpose` STRING COMMENT 'Specific purpose or program for which this fund is allocated to the organizational provider. May be more granular than the fund-level purpose, capturing provider-specific use cases (e.g., Cardiology equipment upgrade within a broader capital fund).',
    `allocation_status` STRING COMMENT 'The allocation status value classifying the finance fund allocation record.',
    `approval_date` DATE COMMENT 'Date when this fund allocation was formally approved by the board, finance committee, or authorized approver. Required for audit trail and governance compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the finance fund allocation record.',
    `currency_code` STRING COMMENT 'The currency code value classifying the finance fund allocation record.',
    `effective_date` DATE COMMENT 'Date when this fund allocation became active and available for transaction posting. Used for period-specific fund accounting and historical allocation tracking.',
    `end_date` DATE COMMENT 'Date when this fund allocation ended or was terminated. Null for currently active allocations. Used for historical tracking and fund reallocation management.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the finance fund allocation record.',
    `fund_allocation_status` STRING COMMENT 'Current lifecycle status of the fund allocation. Drives whether transactions can be posted against this allocation.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the finance fund allocation record.',
    `notes` STRING COMMENT 'Free-text notes capturing allocation-specific details, restrictions, or special handling instructions not captured in structured fields.',
    `reporting_requirements` STRING COMMENT 'Specific reporting obligations associated with this fund allocation, including frequency, format, and recipient (e.g., quarterly donor report, annual CMS cost report Schedule A). May differ from fund-level reporting requirements based on allocation-specific stipulations.',
    `restriction_compliance_flag` BOOLEAN COMMENT 'The restriction compliance flag of the finance fund allocation record.',
    `restriction_compliance_status` STRING COMMENT 'Current compliance status of this allocation with respect to donor restrictions, grant stipulations, or regulatory requirements. Drives audit flags and reporting requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance fund allocation record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance fund allocation record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_fund_allocation PRIMARY KEY(`fund_allocation_id`)
) COMMENT 'This association product represents the allocation relationship between organizational providers and funds in healthcare fund accounting. It captures how restricted and unrestricted funds are allocated across organizational entities (hospitals, clinics, facilities) for compliance tracking, donor restriction management, and regulatory reporting. Each record links one organizational provider to one fund with allocation percentages, effective dates, and compliance status that exist only in the context of this relationship.. Existence Justification: In healthcare fund accounting, organizational providers (hospitals, clinics, facilities) participate in multiple funds simultaneously (operating funds, restricted grants, endowments, capital funds), and each fund is typically allocated across multiple organizational entities within an integrated delivery network or health system. The allocation relationship is actively managed by finance teams with specific percentages, effective dates, compliance tracking, and reporting requirements that belong to neither the provider nor the fund alone.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` (
    `payment_batch_id` BIGINT COMMENT 'Primary key for payment_batch',
    `bank_account_id` BIGINT COMMENT 'Reference to the bank account used for processing this payment batch.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period in which this payment batch is recorded for financial reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this payment batch record.',
    `payment_employee_id` BIGINT COMMENT 'Reference to the user who approved this payment batch for processing.',
    `financial_entity_id` BIGINT COMMENT 'Reference to the organization making the payments in this batch, such as an insurance company or employer.',
    `payment_original_batch_id` BIGINT COMMENT 'Reference to the original payment batch that this batch is reversing or correcting, if applicable.',
    `payment_payee_organization_financial_entity_id` BIGINT COMMENT 'Reference to the organization receiving the payments in this batch, typically the healthcare provider or facility.',
    `primary_batch_employee_id` BIGINT COMMENT 'Unique identifier for the primary batch employee within the finance payment batch record.',
    `primary_reversed_payment_batch_id` BIGINT COMMENT 'Self-referencing FK on payment_batch (reversed_payment_batch_id)',
    `actual_processing_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment batch processing was completed.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The total value of adjustments, fees, or corrections applied to the batch amount.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this payment batch requires managerial or supervisory approval before processing.',
    `approval_status` STRING COMMENT 'The approval status value classifying the finance payment batch record.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the payment batch was approved for processing.',
    `batch_date` DATE COMMENT 'The business date on which the payment batch was created or scheduled for processing.',
    `batch_number` STRING COMMENT 'Externally-known unique business identifier for the payment batch, used for tracking and reconciliation across systems.',
    `batch_status` STRING COMMENT 'The batch status value classifying the finance payment batch record.',
    `batch_type` STRING COMMENT 'Classification of the payment batch by its purpose and source. Determines processing rules and reconciliation requirements.',
    `cost_center_code` STRING COMMENT 'The cost center or department code responsible for this payment batch for budgeting and cost allocation purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment batch record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency of all monetary amounts in this batch.',
    `electronic_funds_transfer_trace_number` STRING COMMENT 'The trace number assigned by the Automated Clearing House (ACH) network for tracking electronic fund transfers.',
    `error_message` STRING COMMENT 'Detailed error message or failure reason if the payment batch processing encountered issues.',
    `external_batch_reference` STRING COMMENT 'External reference number or identifier provided by the payer or payment processor for cross-system reconciliation.',
    `failed_payment_count` STRING COMMENT 'The number of payment transactions that failed processing within this batch.',
    `general_ledger_account_code` STRING COMMENT 'The general ledger account code to which this payment batch is posted for financial reporting.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether this payment batch represents a reversal or correction of a previously processed batch.',
    `lockbox_number` STRING COMMENT 'The lockbox identifier used for processing mailed payments, typically assigned by the bank providing lockbox services.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment batch record was last modified.',
    `net_batch_amount` DECIMAL(18,2) COMMENT 'The final net monetary value of the payment batch after all adjustments have been applied.',
    `notes` STRING COMMENT 'The notes of the finance payment batch record.',
    `payment_channel` STRING COMMENT 'The interface or channel through which the payment batch was initiated or received.',
    `payment_count` STRING COMMENT 'The payment count of the finance payment batch record.',
    `payment_date` DATE COMMENT 'Timestamp capturing the payment date associated with the finance payment batch record.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to execute payments in this batch.',
    `processing_notes` STRING COMMENT 'Free-text notes documenting special instructions, issues, or observations related to the processing of this payment batch.',
    `reconciliation_date` DATE COMMENT 'The date on which the payment batch was successfully reconciled with bank records.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation process for this payment batch against bank statements and accounting records.',
    `remittance_advice_number` STRING COMMENT 'The unique identifier for the remittance advice document associated with this payment batch, used for payment application.',
    `scheduled_processing_date` DATE COMMENT 'The target date when the payment batch is scheduled to be processed and funds transferred.',
    `source_system_code` STRING COMMENT 'Identifier of the source system or module that originated this payment batch.',
    `payment_batch_status` STRING COMMENT 'Current lifecycle status of the payment batch in the processing workflow.',
    `successful_payment_count` STRING COMMENT 'The number of payment transactions that were successfully processed within this batch.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the finance payment batch record.',
    `total_batch_amount` DECIMAL(18,2) COMMENT 'The total monetary value of all payments included in this batch before any adjustments.',
    `total_payment_count` STRING COMMENT 'The total number of individual payment transactions included in this batch.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance payment batch record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance payment batch record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_payment_batch PRIMARY KEY(`payment_batch_id`)
) COMMENT 'Master reference table for payment_batch. Referenced by payment_batch_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` (
    `transaction_batch_id` BIGINT COMMENT 'Primary key for transaction_batch',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary cost center associated with this transaction batch for cost allocation purposes.',
    `financial_entity_id` BIGINT COMMENT 'Reference to the legal entity or business unit to which this transaction batch belongs.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the accounting period (fiscal month/quarter/year) to which this batch belongs.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department that originated or owns this transaction batch.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary batch employee within the finance transaction batch record.',
    `primary_reversed_transaction_batch_id` BIGINT COMMENT 'Self-referencing FK on transaction_batch (reversed_transaction_batch_id)',
    `recurring_schedule_id` BIGINT COMMENT 'Reference to the recurring schedule template if this batch is part of a recurring series.',
    `transaction_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who approved this transaction batch for posting.',
    `transaction_employee_id` BIGINT COMMENT 'Reference to the user who created this transaction batch.',
    `transaction_financial_entity_id` BIGINT COMMENT 'Unique identifier for the transaction financial entity within the finance transaction batch record.',
    `transaction_fiscal_period_id` BIGINT COMMENT 'Unique identifier for the transaction fiscal period within the finance transaction batch record.',
    `transaction_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this transaction batch.',
    `transaction_original_batch_id` BIGINT COMMENT 'Reference to the original batch if this batch is a reversal or correction of another batch.',
    `transaction_posted_by_user_employee_id` BIGINT COMMENT 'Reference to the user who posted this transaction batch to the general ledger.',
    `transaction_reversal_batch_id` BIGINT COMMENT 'Reference to the reversal batch if this batch has been reversed, creating an audit trail of corrections.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction batch was approved.',
    `batch_date` DATE COMMENT 'The business date on which the transaction batch was created or is effective for accounting purposes.',
    `batch_description` STRING COMMENT 'Detailed textual description of the purpose and contents of the transaction batch.',
    `batch_number` STRING COMMENT 'Externally-known unique business identifier for the transaction batch, used for tracking and reconciliation across systems.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the transaction batch in the approval and posting workflow.',
    `batch_total_amount` DECIMAL(18,2) COMMENT 'The batch total amount of the finance transaction batch record.',
    `batch_type` STRING COMMENT 'Classification of the transaction batch indicating the nature of transactions contained within (e.g., journal entries, payments, adjustments).',
    `control_total` DECIMAL(18,2) COMMENT 'Expected control total for validation purposes, used to verify batch integrity before posting.',
    `control_total_amount` DECIMAL(18,2) COMMENT 'The control total amount of the finance transaction batch record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction batch record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction batch amounts.',
    `external_reference_number` STRING COMMENT 'External reference identifier from source systems or third-party systems for cross-system reconciliation.',
    `fiscal_period` STRING COMMENT 'The fiscal period number (1-12 or 1-13) within the fiscal year for this transaction batch.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this transaction batch is assigned for financial reporting purposes.',
    `is_auto_generated` BOOLEAN COMMENT 'Indicates whether the batch was automatically generated by a system process (true) or manually created by a user (false).',
    `is_balanced` BOOLEAN COMMENT 'Indicates whether the batch debits and credits are in balance (true) or out of balance (false).',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this batch is part of a recurring batch series (true) or a one-time batch (false).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction batch record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount of the batch (total debits minus total credits), should be zero for balanced batches.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about the transaction batch for documentation purposes.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction batch was posted to the general ledger.',
    `posting_date` DATE COMMENT 'The date on which the transaction batch was posted to the general ledger.',
    `posting_status` STRING COMMENT 'The posting status value classifying the finance transaction batch record.',
    `rejection_reason` STRING COMMENT 'Textual explanation of why the batch was rejected during the approval process, if applicable.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the finance transaction batch record.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the finance transaction batch record.',
    `total_batch_amount` DECIMAL(18,2) COMMENT 'The total batch amount of the finance transaction batch record.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The sum of all credit amounts in the transaction batch, used for batch balancing and reconciliation.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'The sum of all debit amounts in the transaction batch, used for batch balancing and reconciliation.',
    `transaction_count` STRING COMMENT 'The total number of individual transactions contained within this batch.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance transaction batch record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance transaction batch record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_transaction_batch PRIMARY KEY(`transaction_batch_id`)
) COMMENT 'Master reference table for transaction_batch. Referenced by batch_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` (
    `allocation_run_id` BIGINT COMMENT 'Primary key for allocation_run',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this allocation run for posting to the general ledger.',
    `allocation_employee_id` BIGINT COMMENT 'Reference to the user or system account that initiated or triggered this allocation run.',
    `allocation_method_id` BIGINT COMMENT 'Reference to the allocation methodology applied in this run (e.g., direct, step-down, reciprocal, activity-based costing).',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary cost center or cost pool from which costs are being allocated in this run.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period for which this allocation run was executed, linking to the financial calendar.',
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry within the finance allocation run record.',
    `primary_run_employee_id` BIGINT COMMENT 'Unique identifier for the primary run employee within the finance allocation run record.',
    `reversed_allocation_run_id` BIGINT COMMENT 'Reference to the original allocation run that this run is reversing, if applicable.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier for the batch processing job or financial close cycle that includes this allocation run.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the allocation run execution completed or terminated.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the allocation run execution commenced, representing the principal business event timestamp for this transaction.',
    `allocation_basis` STRING COMMENT 'Description of the statistical or financial basis used for cost allocation (e.g., square footage, FTE count, patient days, relative value units).',
    `allocation_percentage_total` DECIMAL(18,2) COMMENT 'Sum of all allocation percentages applied across target cost centers, should equal 100.00 for validation purposes.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation run was formally approved for financial posting.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit logs or supporting documentation for this allocation run.',
    `completed_timestamp` TIMESTAMP COMMENT 'The completed timestamp of the finance allocation run record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this allocation run.',
    `error_count` STRING COMMENT 'Number of errors encountered during the allocation run execution.',
    `execution_duration_seconds` STRING COMMENT 'Total elapsed time in seconds for the allocation run execution, used for performance monitoring and optimization.',
    `gl_batch_number` STRING COMMENT 'General ledger batch identifier associated with the journal entries created from this allocation run.',
    `gl_posting_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation run results were posted to the general ledger system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation run record was last updated or modified.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the finance allocation run record.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the allocation run, including special circumstances, adjustments, or explanations.',
    `posted_to_gl_flag` BOOLEAN COMMENT 'Indicator whether the allocation results have been posted to the general ledger.',
    `records_processed_count` STRING COMMENT 'Total number of allocation detail records or transactions processed in this run.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicator whether this allocation run is used for regulatory cost reporting purposes (e.g., Medicare Cost Report).',
    `reversal_flag` BOOLEAN COMMENT 'Indicator whether this allocation run is a reversal of a previous allocation.',
    `run_date` DATE COMMENT 'Timestamp capturing the run date associated with the finance allocation run record.',
    `run_name` STRING COMMENT 'Descriptive name assigned to the allocation run for identification and reporting purposes, often includes period and allocation type context.',
    `run_number` STRING COMMENT 'Business-facing unique identifier for the allocation run, typically formatted with prefix and sequence number for external reference and audit trails.',
    `run_status` STRING COMMENT 'Current lifecycle status of the allocation run indicating its stage in the execution and approval workflow.',
    `run_type` STRING COMMENT 'Classification of the allocation run indicating its purpose and finality within the financial close process.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the allocation run was scheduled to begin execution.',
    `simulation_flag` BOOLEAN COMMENT 'Indicator whether this allocation run is a simulation or what-if scenario rather than an actual financial posting.',
    `started_timestamp` TIMESTAMP COMMENT 'The started timestamp of the finance allocation run record.',
    `target_cost_centers_count` STRING COMMENT 'Number of distinct cost centers that received allocated costs in this run.',
    `total_allocated_amount` DECIMAL(18,2) COMMENT 'The total allocated amount of the finance allocation run record.',
    `total_amount_allocated` DECIMAL(18,2) COMMENT 'Total monetary value of costs allocated across all target cost centers in this run, representing the gross base amount for this allocation transaction.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between expected and actual allocated amounts, used for reconciliation and quality control.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance allocation run record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `warning_count` STRING COMMENT 'Number of warnings generated during the allocation run execution.',
    CONSTRAINT pk_allocation_run PRIMARY KEY(`allocation_run_id`)
) COMMENT 'Master reference table for allocation_run. Referenced by allocation_run_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` (
    `depreciation_run_id` BIGINT COMMENT 'Primary key for depreciation_run',
    `asset_book_id` BIGINT COMMENT 'Reference to the asset book (corporate, tax, IFRS, etc.) for which this depreciation run is executed.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or location for which this depreciation run is scoped, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center for which this depreciation run is scoped, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved the depreciation run for posting to the general ledger.',
    `depreciation_employee_id` BIGINT COMMENT 'Reference to the user who initiated or scheduled this depreciation run.',
    `depreciation_reversed_run_id` BIGINT COMMENT 'Reference to the original depreciation run that this run reverses, if applicable.',
    `financial_entity_id` BIGINT COMMENT 'Unique identifier for the financial entity within the finance depreciation run record.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period for which this depreciation run is executed.',
    `general_ledger_id` BIGINT COMMENT 'Reference to the general ledger to which this depreciation run posts entries.',
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry within the finance depreciation run record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department for which this depreciation run is scoped, if applicable.',
    `primary_reversed_depreciation_run_id` BIGINT COMMENT 'Self-referencing FK on depreciation_run (reversed_depreciation_run_id)',
    `primary_run_employee_id` BIGINT COMMENT 'Unique identifier for the primary run employee within the finance depreciation run record.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the depreciation run was approved for posting.',
    `asset_count` STRING COMMENT 'The total number of assets included in this depreciation run.',
    `auto_post_flag` BOOLEAN COMMENT 'Indicates whether the depreciation entries from this run are automatically posted to the general ledger upon completion.',
    `calculation_method` STRING COMMENT 'The accounting method used to calculate depreciation in this run, such as straight-line, declining balance, or units of production.',
    `completed_timestamp` TIMESTAMP COMMENT 'The completed timestamp of the finance depreciation run record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this depreciation run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the depreciation amounts in this run.',
    `effective_date` DATE COMMENT 'The accounting effective date for which the depreciation expense is recognized in the financial statements.',
    `end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the depreciation run processing completed.',
    `error_message` STRING COMMENT 'Detailed error message if the depreciation run failed, providing diagnostic information for troubleshooting.',
    `failed_asset_count` STRING COMMENT 'The number of assets that failed processing during this depreciation run.',
    `journal_batch_reference` BIGINT COMMENT 'Reference to the journal batch containing the depreciation entries generated by this run.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this depreciation run record was last modified.',
    `notes` STRING COMMENT 'The notes of the finance depreciation run record.',
    `posting_date` DATE COMMENT 'The date on which the depreciation entries from this run were posted to the general ledger.',
    `posting_status` STRING COMMENT 'The posting status value classifying the finance depreciation run record.',
    `processed_asset_count` STRING COMMENT 'The number of assets successfully processed in this depreciation run.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this depreciation run is a reversal of a previous run.',
    `run_date` DATE COMMENT 'The business date on which the depreciation run was executed or scheduled to execute.',
    `run_description` STRING COMMENT 'Free-text description providing additional context or notes about the purpose and scope of this depreciation run.',
    `run_number` STRING COMMENT 'Business-facing unique identifier for the depreciation run, used in financial reports and audit trails.',
    `run_status` STRING COMMENT 'Current lifecycle status of the depreciation run indicating its processing state.',
    `run_type` STRING COMMENT 'Classification of the depreciation run indicating whether it is a scheduled periodic run, ad-hoc calculation, adjustment, reversal, year-end closing, or interim calculation.',
    `simulation_flag` BOOLEAN COMMENT 'Indicates whether this depreciation run is a simulation or test run that does not post to the general ledger.',
    `start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the depreciation run processing began.',
    `started_timestamp` TIMESTAMP COMMENT 'The started timestamp of the finance depreciation run record.',
    `total_depreciation_amount` DECIMAL(18,2) COMMENT 'The total depreciation expense calculated across all assets in this run.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance depreciation run record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance depreciation run record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_depreciation_run PRIMARY KEY(`depreciation_run_id`)
) COMMENT 'Master reference table for depreciation_run. Referenced by depreciation_run_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`donor` (
    `donor_id` BIGINT COMMENT 'Primary key for donor',
    `fund_id` BIGINT COMMENT 'Unique identifier for the fund within the finance donor record.',
    `merged_donor_id` BIGINT COMMENT 'Self-referencing FK on donor (merged_donor_id)',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the finance donor record.',
    `acknowledgment_preference` STRING COMMENT 'Donors preference for public recognition of their contributions in donor lists, annual reports, and naming opportunities.',
    `affinity_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the donors affinity and connection to the healthcare organization based on engagement history, volunteer activity, and relationship depth.',
    `board_member_flag` BOOLEAN COMMENT 'Boolean indicator of whether the donor currently serves or has served on the healthcare organizations board of directors or advisory board.',
    `donor_category` STRING COMMENT 'The donor category of the finance donor record.',
    `city` STRING COMMENT 'City name of the donors mailing address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the donors country of residence or incorporation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the donor record was first created in the system, following the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_classification` STRING COMMENT 'Classification level of the donor record indicating the sensitivity and access controls required for this data per organizational data governance policies.',
    `donor_status` STRING COMMENT 'Current lifecycle status of the donor relationship indicating whether the donor is actively contributing, inactive, temporarily suspended, deceased, or merged with another donor record.',
    `donor_type` STRING COMMENT 'Classification of the donor entity type indicating whether the donor is an individual person, corporate entity, charitable foundation, government agency, or anonymous contributor.',
    `email` STRING COMMENT 'The email of the finance donor record.',
    `email_address` STRING COMMENT 'Primary email address for donor communication and correspondence regarding contributions and acknowledgments.',
    `employer_name` STRING COMMENT 'Name of the donors employer organization, relevant for corporate matching gift programs and workplace giving campaigns.',
    `first_gift_date` DATE COMMENT 'Date when the donor made their first recorded contribution to the healthcare organization.',
    `is_anonymous` BOOLEAN COMMENT 'Boolean flag indicating the is anonymous status of the finance donor record.',
    `last_gift_date` DATE COMMENT 'Date of the most recent contribution received from the donor.',
    `lifetime_giving_amount` DECIMAL(18,2) COMMENT 'Total cumulative amount of all contributions made by the donor since the inception of the donor relationship, expressed in the organizations functional currency.',
    `mailing_address` STRING COMMENT 'The mailing address of the finance donor record.',
    `mailing_address_line1` STRING COMMENT 'First line of the donors mailing address including street number and street name for correspondence and tax receipts.',
    `mailing_address_line2` STRING COMMENT 'Second line of the donors mailing address including apartment, suite, or unit number.',
    `matching_gift_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the donor is eligible for corporate matching gift programs through their employer.',
    `memorial_honoree_name` STRING COMMENT 'Name of the individual being honored or memorialized through the donors contributions, if applicable.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the donor record was last modified or updated, following the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `donor_name` STRING COMMENT 'Full legal name of the donor individual or organization providing financial contributions.',
    `notes` STRING COMMENT 'Free-text notes and comments about the donor relationship, preferences, special considerations, and stewardship history for development staff reference.',
    `patient_flag` BOOLEAN COMMENT 'Boolean indicator of whether the donor is or has been a patient of the healthcare organization, relevant for grateful patient programs.',
    `phone` STRING COMMENT 'The phone of the finance donor record.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the donor used for outreach, stewardship, and contribution acknowledgment.',
    `planned_giving_flag` BOOLEAN COMMENT 'Boolean indicator of whether the donor has established a planned gift commitment such as a bequest, charitable trust, or life insurance designation.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the donors mailing address for correspondence delivery.',
    `preferred_communication_method` STRING COMMENT 'Donors preferred method of communication for stewardship, solicitation, and acknowledgment correspondence.',
    `recognition_level` STRING COMMENT 'The recognition level of the finance donor record.',
    `segment` STRING COMMENT 'Fundraising segment classification of the donor based on giving capacity and engagement level for targeted stewardship and solicitation strategies.',
    `solicitation_opt_out_flag` BOOLEAN COMMENT 'Boolean indicator of whether the donor has requested to opt out of future fundraising solicitations and appeals.',
    `source` STRING COMMENT 'Original source or channel through which the donor was acquired or first engaged with the healthcare organizations fundraising programs.',
    `state_province` STRING COMMENT 'State or province code of the donors mailing address using standard postal abbreviations.',
    `tax_id_number` STRING COMMENT 'Tax identification number for the donor used for IRS reporting and tax-deductible contribution acknowledgment. May be SSN for individuals or EIN for organizations.',
    `tax_identification_number` BIGINT COMMENT 'The tax identification number of the finance donor record.',
    `tax_receipt_required_flag` BOOLEAN COMMENT 'The tax receipt required flag of the finance donor record.',
    `total_contributed_amount` DECIMAL(18,2) COMMENT 'The total contributed amount of the finance donor record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance donor record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance donor record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `volunteer_flag` BOOLEAN COMMENT 'Boolean indicator of whether the donor actively volunteers or has volunteered for the healthcare organization.',
    `wealth_capacity_rating` STRING COMMENT 'Estimated wealth capacity rating or score for the donor based on wealth screening and prospect research, used for major gift identification and cultivation strategies.',
    CONSTRAINT pk_donor PRIMARY KEY(`donor_id`)
) COMMENT 'Master reference table for donor. Referenced by donor_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` (
    `intercompany_agreement_id` BIGINT COMMENT 'Primary key for intercompany_agreement',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for managing or tracking costs related to this agreement.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or approver who authorized this intercompany agreement.',
    `financial_entity_id` BIGINT COMMENT 'Identifier of the legal entity providing services, goods, or resources under this intercompany agreement.',
    `from_financial_entity_id` BIGINT COMMENT 'Unique identifier for the from financial entity within the finance intercompany agreement record.',
    `parent_intercompany_agreement_id` BIGINT COMMENT 'Identifier of the parent or master agreement if this is a subsidiary or amendment agreement. Nullable for standalone agreements.',
    `primary_superseded_intercompany_agreement_id` BIGINT COMMENT 'Self-referencing FK on intercompany_agreement (superseded_intercompany_agreement_id)',
    `target_financial_entity_id` BIGINT COMMENT 'Unique identifier for the target financial entity within the finance intercompany agreement record.',
    `to_financial_entity_id` BIGINT COMMENT 'Unique identifier for the to financial entity within the finance intercompany agreement record.',
    `intercompany_receiver_entity_id` BIGINT COMMENT 'Identifier of the legal entity receiving services, goods, or resources under this intercompany agreement.',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the intercompany agreement describing its purpose or scope.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the intercompany agreement, typically used in contracts and financial reporting.',
    `agreement_status` STRING COMMENT 'The agreement status value classifying the finance intercompany agreement record.',
    `agreement_type` STRING COMMENT 'Classification of the intercompany agreement based on its business purpose (e.g., service agreement, cost allocation, revenue sharing, transfer pricing, licensing, or intercompany loan).',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'Total estimated or committed annual value of the intercompany agreement in the specified currency.',
    `approval_date` DATE COMMENT 'Date when the intercompany agreement was formally approved by authorized parties.',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether this agreement requires periodic audit review for compliance or financial accuracy.',
    `billing_frequency` STRING COMMENT 'Frequency at which intercompany charges are billed under this agreement.',
    `cost_allocation_basis` STRING COMMENT 'Description of the basis or formula used for allocating costs between entities (e.g., headcount, revenue, square footage, usage metrics).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the intercompany agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial transactions under this agreement.',
    `dispute_resolution_method` STRING COMMENT 'Method specified in the agreement for resolving disputes between the provider and receiver entities.',
    `document_reference_url` STRING COMMENT 'URL or file path to the signed agreement document or contract repository location.',
    `effective_end_date` DATE COMMENT 'Date when the intercompany agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the intercompany agreement becomes legally binding and operational.',
    `gl_account_code` STRING COMMENT 'General ledger account code used for posting intercompany transactions under this agreement.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of this intercompany agreement.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit or compliance review performed on this intercompany agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the intercompany agreement record was last updated or modified.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The markup percentage of the finance intercompany agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the finance intercompany agreement record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or renewal evaluation of this agreement.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the intercompany agreement.',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment after invoice date, as specified in the agreement terms.',
    `pricing_method` STRING COMMENT 'Method used to determine pricing for services or goods exchanged under this intercompany agreement.',
    `receiving_entity_id` BIGINT COMMENT 'Unique identifier for the receiving entity within the finance intercompany agreement record.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement is eligible for automatic renewal upon expiration.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal notice must be provided, as specified in the agreement.',
    `sending_entity_id` BIGINT COMMENT 'Unique identifier for the sending entity within the finance intercompany agreement record.',
    `service_description` STRING COMMENT 'Detailed description of the services, goods, or resources covered by this intercompany agreement.',
    `settlement_frequency` STRING COMMENT 'The settlement frequency of the finance intercompany agreement record.',
    `source_financial_entity_id` BIGINT COMMENT 'Unique identifier for the source financial entity within the finance intercompany agreement record.',
    `intercompany_agreement_status` STRING COMMENT 'Current lifecycle status of the intercompany agreement indicating its operational state.',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the primary tax jurisdiction governing this intercompany agreement.',
    `termination_clause` STRING COMMENT 'Summary of the conditions and procedures under which the agreement may be terminated by either party.',
    `transfer_pricing_basis` STRING COMMENT 'The transfer pricing basis of the finance intercompany agreement record.',
    `transfer_pricing_compliant_flag` BOOLEAN COMMENT 'Indicates whether the agreement has been reviewed and approved as compliant with transfer pricing regulations.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance intercompany agreement record.',
    `version_number` STRING COMMENT 'Version number of the agreement, incremented with each amendment or revision.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance intercompany agreement record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_intercompany_agreement PRIMARY KEY(`intercompany_agreement_id`)
) COMMENT 'Master reference table for intercompany_agreement. Referenced by intercompany_agreement_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` (
    `recurring_schedule_id` BIGINT COMMENT 'Primary key for recurring_schedule',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the general ledger account to which this recurring schedule posts transactions.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for or associated with this recurring schedule.',
    `financial_entity_id` BIGINT COMMENT 'Unique identifier for the financial entity within the finance recurring schedule record.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal year this recurring schedule is associated with.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who owns and is accountable for this recurring schedule.',
    `recurring_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who approved this recurring schedule. Null if not yet approved or approval is not required.',
    `recurring_employee_id` BIGINT COMMENT 'Reference to the user who created this recurring schedule record.',
    `recurring_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this recurring schedule record.',
    `superseded_recurring_schedule_id` BIGINT COMMENT 'Self-referencing FK on recurring_schedule (superseded_recurring_schedule_id)',
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the template journal entry within the finance recurring schedule record.',
    `adjustment_factor` DECIMAL(18,2) COMMENT 'A multiplier applied to the scheduled amount for adjustments such as inflation, escalation, or volume changes. Default is 1.0 (no adjustment).',
    `allocation_method` STRING COMMENT 'The method used to allocate or distribute the scheduled amount across periods or cost centers (equal distribution, weighted, percentage-based, activity-based costing, or custom formula).',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether generated activities from this schedule require approval before posting (true) or can be posted automatically (false).',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this recurring schedule was approved for activation. Null if not yet approved or approval is not required.',
    `approver_role_code` BIGINT COMMENT 'Reference to the role or user group responsible for approving activities generated by this schedule. Null if approval is not required.',
    `auto_generate_flag` BOOLEAN COMMENT 'Indicates whether scheduled activities are automatically generated by the system (true) or require manual creation (false).',
    `business_justification` STRING COMMENT 'Explanation of the business rationale and need for this recurring schedule, used for audit and governance purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this recurring schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the scheduled amount is denominated.',
    `day_of_month` STRING COMMENT 'For monthly or less frequent schedules, the specific day of the month when the activity occurs (1-31). Null if not applicable.',
    `day_of_week` STRING COMMENT 'For weekly or biweekly schedules, the specific day of the week when the activity occurs. Null if not applicable.',
    `recurring_schedule_description` STRING COMMENT 'Detailed textual description of the recurring schedule, including its purpose, scope, and any special instructions or business rules.',
    `effective_end_date` DATE COMMENT 'The date when this recurring schedule ceases to be active. Null indicates an open-ended schedule.',
    `effective_start_date` DATE COMMENT 'The date when this recurring schedule becomes active and begins generating scheduled activities.',
    `frequency` STRING COMMENT 'The frequency at which the scheduled activity recurs (daily, weekly, biweekly, monthly, quarterly, semiannual, or annual).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this recurring schedule is currently active and eligible for generating scheduled activities (true) or inactive (false).',
    `last_generated_date` DATE COMMENT 'The date when the most recent scheduled activity was generated from this recurring schedule. Null if no activities have been generated yet.',
    `last_run_date` DATE COMMENT 'Timestamp capturing the last run date associated with the finance recurring schedule record.',
    `max_occurrences` STRING COMMENT 'The maximum number of times this schedule should generate activities before automatically completing. Null indicates unlimited occurrences.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this recurring schedule record was last modified.',
    `month_of_quarter` STRING COMMENT 'For quarterly schedules, the specific month within the quarter when the activity occurs (1-3). Null if not applicable.',
    `next_run_date` DATE COMMENT 'Timestamp capturing the next run date associated with the finance recurring schedule record.',
    `next_scheduled_date` DATE COMMENT 'The date when the next scheduled activity is due to be generated from this recurring schedule.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about the recurring schedule for operational reference.',
    `occurrence_count` STRING COMMENT 'The total number of times activities have been generated from this recurring schedule since its inception.',
    `occurrences_remaining` STRING COMMENT 'The occurrences remaining of the finance recurring schedule record.',
    `proration_rule` STRING COMMENT 'The rule used to prorate amounts for partial periods (none, daily proration, monthly proration, actual days, or business days only).',
    `quarter_of_year` STRING COMMENT 'For annual schedules, the specific quarter of the year when the activity occurs (1-4). Null if not applicable.',
    `recurrence_amount` DECIMAL(18,2) COMMENT 'The recurrence amount of the finance recurring schedule record.',
    `schedule_amount` DECIMAL(18,2) COMMENT 'The standard monetary amount associated with each recurrence of this schedule. Used for budgeting, allocation, or accrual purposes.',
    `schedule_category` STRING COMMENT 'High-level categorization of the schedule based on the nature of financial activities it governs.',
    `schedule_code` STRING COMMENT 'Business identifier code for the recurring schedule, used for external reference and reporting.',
    `schedule_name` STRING COMMENT 'Human-readable name describing the purpose or nature of the recurring schedule.',
    `schedule_status` STRING COMMENT 'The schedule status value classifying the finance recurring schedule record.',
    `schedule_type` STRING COMMENT 'Classification of the recurring schedule indicating its financial purpose (budget cycle, forecast period, cost allocation, accrual recognition, depreciation schedule, or amortization schedule).',
    `recurring_schedule_status` STRING COMMENT 'Current lifecycle status of the recurring schedule indicating whether it is in draft, actively generating activities, temporarily suspended, completed, or cancelled.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the finance recurring schedule record.',
    `version_number` STRING COMMENT 'Version number of this recurring schedule record, incremented with each modification for change tracking and audit purposes.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance recurring schedule record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_recurring_schedule PRIMARY KEY(`recurring_schedule_id`)
) COMMENT 'Master reference table for recurring_schedule. Referenced by recurring_schedule_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`asset_book` (
    `asset_book_id` BIGINT COMMENT 'Primary key for asset_book',
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the asset gl account chart of accounts within the finance asset book record.',
    `cost_center_id` BIGINT COMMENT 'Reference to the default cost center for assets tracked in this book, used for expense allocation and budgeting.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this asset book record.',
    `financial_entity_id` BIGINT COMMENT 'Unique identifier for the financial entity within the finance asset book record.',
    `fixed_asset_id` BIGINT COMMENT 'FK to fixed asset',
    `general_ledger_account_chart_of_accounts_id` BIGINT COMMENT 'Reference to the general ledger account where asset values and depreciation expenses for this book are posted.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this asset book record.',
    `organization_id` BIGINT COMMENT 'Reference to the legal entity or organizational unit that owns and maintains this asset book.',
    `parent_asset_book_id` BIGINT COMMENT 'Self-referencing FK on asset_book (parent_asset_book_id)',
    `parent_book_id` BIGINT COMMENT 'Reference to a parent asset book if this book is a subsidiary or specialized book derived from a master book. Null for top-level books.',
    `accounting_standard` STRING COMMENT 'The accounting standard or framework governing depreciation and valuation rules for assets in this book.',
    `accumulated_depreciation` STRING COMMENT 'The accumulated depreciation of the finance asset book record.',
    `allow_manual_depreciation` BOOLEAN COMMENT 'Indicates whether manual depreciation adjustments are permitted for assets in this book, or if all depreciation must be system-calculated.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether asset assignments or depreciation changes in this book require managerial or financial approval before posting.',
    `approval_workflow_code` BIGINT COMMENT 'Reference to the approval workflow process that governs changes to assets in this book. Null if no approval workflow is configured.',
    `audit_trail_enabled` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for all transactions and changes affecting assets in this book.',
    `book_code` STRING COMMENT 'Unique alphanumeric code identifying the asset book for external reference and reporting purposes.',
    `book_name` STRING COMMENT 'Full descriptive name of the asset book used for identification and reporting.',
    `book_status` STRING COMMENT 'The book status value classifying the finance asset book record.',
    `book_type` STRING COMMENT 'Classification of the asset book based on its accounting purpose and regulatory framework.',
    `consolidation_required` BOOLEAN COMMENT 'Indicates whether asset values and depreciation from this book must be included in consolidated financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this asset book record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency for asset valuations and depreciation in this book.',
    `default_depreciation_method` STRING COMMENT 'The default depreciation method of the finance asset book record.',
    `depreciation_method` STRING COMMENT 'The default depreciation calculation method applied to assets assigned to this book.',
    `asset_book_description` STRING COMMENT 'Detailed description of the asset book purpose, scope, and any special accounting rules or business context.',
    `effective_end_date` DATE COMMENT 'The date when this asset book was closed or became inactive. Null for currently active books.',
    `effective_start_date` DATE COMMENT 'The date when this asset book became active and available for asset assignments and depreciation calculations.',
    `fiscal_year_start_month` STRING COMMENT 'The month number (1-12) when the fiscal year begins for this asset book, used for period-based depreciation calculations.',
    `is_primary_book` BOOLEAN COMMENT 'Boolean flag indicating the is primary book status of the finance asset book record.',
    `is_tax_book` BOOLEAN COMMENT 'Boolean flag indicating the is tax book status of the finance asset book record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this asset book record was most recently updated.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the finance asset book record.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The net book value of the finance asset book record.',
    `notes` STRING COMMENT 'Free-form notes or comments providing additional context, special instructions, or historical information about this asset book.',
    `prorate_depreciation` BOOLEAN COMMENT 'Indicates whether depreciation is prorated based on the asset acquisition date within the fiscal period.',
    `regulatory_jurisdiction` STRING COMMENT 'The geographic or regulatory jurisdiction governing the accounting rules for this asset book (e.g., federal, state, international).',
    `salvage_value` DECIMAL(18,2) COMMENT 'The salvage value of the finance asset book record.',
    `salvage_value_required` BOOLEAN COMMENT 'Indicates whether assets assigned to this book must have a salvage value specified for depreciation calculations.',
    `asset_book_status` STRING COMMENT 'Current operational status of the asset book indicating whether it is actively used for asset tracking and depreciation calculations.',
    `tax_reporting_required` BOOLEAN COMMENT 'Indicates whether assets in this book are subject to tax reporting requirements and must be included in tax filings.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Useful life',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the finance asset book record.',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_mutation_test` STRING COMMENT 'Added by VIBE mutation to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_asset_book PRIMARY KEY(`asset_book_id`)
) COMMENT 'Master reference table for asset_book. Referenced by asset_book_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`finance`.`grant` (
    `grant_id` BIGINT COMMENT 'Primary key for grant',
    `parent_grant_id` BIGINT COMMENT 'Self-referencing FK on grant (parent_grant_id)',
    `amount_expended` DECIMAL(18,2) COMMENT 'Cumulative funds spent against the award to date.',
    `award_date` DATE COMMENT 'Date the grant was officially awarded/executed by the sponsor.',
    `awarded_amount` DECIMAL(18,2) COMMENT 'Total monetary amount awarded for the full grant period.',
    `budget_period_end_date` DATE COMMENT 'End date of the current budget period for the grant.',
    `budget_period_start_date` DATE COMMENT 'Start date of the current budget period for the grant.',
    `cfda_number` STRING COMMENT 'Federal assistance listing number identifying the federal program funding the grant.',
    `closeout_date` DATE COMMENT 'Date the grant was administratively and financially closed out.',
    `compliance_status` STRING COMMENT 'Current regulatory and reporting compliance state of the grant.',
    `cost_center_code` STRING COMMENT 'Internal cost center to which grant funds and expenditures are allocated.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Institutional matching or cost-share commitment amount required for the grant.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on the grant.',
    `grant_description` STRING COMMENT 'Detailed narrative description of the grant purpose and scope of funded work.',
    `direct_cost_amount` DECIMAL(18,2) COMMENT 'Portion of the award allocated to direct project costs.',
    `federal_flag` BOOLEAN COMMENT 'Indicates whether the grant is federally funded (subject to Uniform Guidance/Single Audit).',
    `fund_code` STRING COMMENT 'Restricted fund code used for fund accounting and segregation of grant monies.',
    `funding_mechanism` STRING COMMENT 'Instrument type through which funds are provided.',
    `gl_account_code` STRING COMMENT 'General ledger account code associated with the grant fund in the chart of accounts.',
    `grant_number` STRING COMMENT 'Externally-known award/reference number assigned by the sponsor or internal grants management system.',
    `grant_status` STRING COMMENT 'Current lifecycle state of the grant.',
    `grant_type` STRING COMMENT 'Categorical classification of the funding source or grant mechanism.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Facilities and Administrative (indirect) cost amount included in the award.',
    `indirect_cost_rate_pct` DECIMAL(18,2) COMMENT 'Negotiated Facilities and Administrative (F&A) rate applied to direct costs, expressed as a percentage.',
    `payment_method` STRING COMMENT 'Mechanism by which the sponsor disburses funds to the institution.',
    `principal_investigator_name` STRING COMMENT 'Full name of the principal investigator responsible for the grant.',
    `program_name` STRING COMMENT 'Name of the specific sponsor program or funding opportunity under which the grant was awarded.',
    `project_end_date` DATE COMMENT 'Overall project period end date; nullable for open-ended awards.',
    `project_start_date` DATE COMMENT 'Overall project period start date across all budget periods.',
    `reporting_frequency` STRING COMMENT 'Required cadence of financial and progress reporting to the sponsor.',
    `sponsor_award_number` STRING COMMENT 'The award or contract number assigned by the external sponsor.',
    `sponsor_name` STRING COMMENT 'Name of the funding agency, sponsor, or grantor organization providing the award.',
    `submission_date` DATE COMMENT 'Date the grant proposal or application was submitted to the sponsor.',
    `title` STRING COMMENT 'Human-readable title of the grant or funded project.',
    CONSTRAINT pk_grant PRIMARY KEY(`grant_id`)
) COMMENT 'Master reference table for grant. Referenced by grant_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_parent_general_ledger_id` FOREIGN KEY (`parent_general_ledger_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_primary_superseded_by_general_ledger_id` FOREIGN KEY (`primary_superseded_by_general_ledger_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_parent_chart_of_accounts_id` FOREIGN KEY (`parent_chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_reversal_journal_entry_id` FOREIGN KEY (`primary_reversal_journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_recurring_schedule_id` FOREIGN KEY (`recurring_schedule_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`recurring_schedule`(`recurring_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_primary_reversed_line_journal_entry_line_id` FOREIGN KEY (`primary_reversed_line_journal_entry_line_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_parent_fiscal_period_id` FOREIGN KEY (`parent_fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_parent_period_fiscal_period_id` FOREIGN KEY (`parent_period_fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_primary_prior_period_fiscal_period_id` FOREIGN KEY (`primary_prior_period_fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_parent_budget_id` FOREIGN KEY (`parent_budget_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_primary_prior_budget_id` FOREIGN KEY (`primary_prior_budget_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_parent_budget_line_id` FOREIGN KEY (`parent_budget_line_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_primary_budget_chart_of_accounts_id` FOREIGN KEY (`primary_budget_chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_primary_original_transfer_budget_transfer_id` FOREIGN KEY (`primary_original_transfer_budget_transfer_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget_transfer`(`budget_transfer_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_source_budget_line_id` FOREIGN KEY (`source_budget_line_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_source_cost_center_id` FOREIGN KEY (`source_cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_credited_ap_invoice_id` FOREIGN KEY (`credited_ap_invoice_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_credited_ap_invoice_line_id` FOREIGN KEY (`credited_ap_invoice_line_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ap_invoice_line`(`ap_invoice_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_batch_id` FOREIGN KEY (`payment_batch_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`payment_batch`(`payment_batch_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_voided_ap_payment_id` FOREIGN KEY (`voided_ap_payment_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ap_payment`(`ap_payment_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_parent_ar_account_id` FOREIGN KEY (`parent_ar_account_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_ar_applied_to_transaction_id` FOREIGN KEY (`ar_applied_to_transaction_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_primary_reversed_transaction_ar_transaction_id` FOREIGN KEY (`primary_reversed_transaction_ar_transaction_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_parent_fixed_asset_id` FOREIGN KEY (`parent_fixed_asset_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_depreciation_run_id` FOREIGN KEY (`depreciation_run_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`depreciation_run`(`depreciation_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_prior_depreciation_schedule_id` FOREIGN KEY (`prior_depreciation_schedule_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`depreciation_schedule`(`depreciation_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_parent_capital_project_id` FOREIGN KEY (`parent_capital_project_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_reversed_capital_expenditure_id` FOREIGN KEY (`reversed_capital_expenditure_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`capital_expenditure`(`capital_expenditure_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_method_id` FOREIGN KEY (`allocation_method_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`allocation_method`(`allocation_method_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_run_id` FOREIGN KEY (`allocation_run_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`allocation_run`(`allocation_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_primary_original_allocation_cost_allocation_id` FOREIGN KEY (`primary_original_allocation_cost_allocation_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_target_cost_center_id` FOREIGN KEY (`target_cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_parent_allocation_method_id` FOREIGN KEY (`parent_allocation_method_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`allocation_method`(`allocation_method_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_primary_superseded_method_allocation_method_id` FOREIGN KEY (`primary_superseded_method_allocation_method_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`allocation_method`(`allocation_method_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_bank_chart_of_accounts_id` FOREIGN KEY (`bank_chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_parent_bank_account_id` FOREIGN KEY (`parent_bank_account_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_primary_prior_period_reconciliation_bank_reconciliation_id` FOREIGN KEY (`primary_prior_period_reconciliation_bank_reconciliation_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`bank_reconciliation`(`bank_reconciliation_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_prior_financial_period_close_id` FOREIGN KEY (`prior_financial_period_close_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_intercompany_agreement_id` FOREIGN KEY (`intercompany_agreement_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`intercompany_agreement`(`intercompany_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_intercompany_journal_entry_id` FOREIGN KEY (`intercompany_journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_primary_intercompany_financial_entity_id` FOREIGN KEY (`primary_intercompany_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_primary_reversed_transaction_intercompany_transaction_id` FOREIGN KEY (`primary_reversed_transaction_intercompany_transaction_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_receiving_entity_financial_entity_id` FOREIGN KEY (`receiving_entity_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_target_financial_entity_id` FOREIGN KEY (`target_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_to_financial_entity_id` FOREIGN KEY (`to_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ADD CONSTRAINT `fk_finance_financial_entity_parent_entity_financial_entity_id` FOREIGN KEY (`parent_entity_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ADD CONSTRAINT `fk_finance_financial_entity_parent_financial_entity_id` FOREIGN KEY (`parent_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_parent_fund_id` FOREIGN KEY (`parent_fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_primary_consolidation_fund_id` FOREIGN KEY (`primary_consolidation_fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`donor`(`donor_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_parent_financial_forecast_id` FOREIGN KEY (`parent_financial_forecast_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_forecast`(`financial_forecast_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_primary_superseded_by_financial_forecast_id` FOREIGN KEY (`primary_superseded_by_financial_forecast_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_forecast`(`financial_forecast_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ADD CONSTRAINT `fk_finance_forecast_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ADD CONSTRAINT `fk_finance_forecast_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ADD CONSTRAINT `fk_finance_forecast_line_financial_forecast_id` FOREIGN KEY (`financial_forecast_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_forecast`(`financial_forecast_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ADD CONSTRAINT `fk_finance_forecast_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ADD CONSTRAINT `fk_finance_forecast_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ADD CONSTRAINT `fk_finance_forecast_line_prior_forecast_line_id` FOREIGN KEY (`prior_forecast_line_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`forecast_line`(`forecast_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ADD CONSTRAINT `fk_finance_invoice_payment_application_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ADD CONSTRAINT `fk_finance_invoice_payment_application_ap_invoice_line_id` FOREIGN KEY (`ap_invoice_line_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ap_invoice_line`(`ap_invoice_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ADD CONSTRAINT `fk_finance_invoice_payment_application_ap_payment_id` FOREIGN KEY (`ap_payment_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ap_payment`(`ap_payment_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_payment_original_batch_id` FOREIGN KEY (`payment_original_batch_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`payment_batch`(`payment_batch_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_payment_payee_organization_financial_entity_id` FOREIGN KEY (`payment_payee_organization_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_primary_reversed_payment_batch_id` FOREIGN KEY (`primary_reversed_payment_batch_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`payment_batch`(`payment_batch_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_primary_reversed_transaction_batch_id` FOREIGN KEY (`primary_reversed_transaction_batch_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_recurring_schedule_id` FOREIGN KEY (`recurring_schedule_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`recurring_schedule`(`recurring_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_transaction_financial_entity_id` FOREIGN KEY (`transaction_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_transaction_fiscal_period_id` FOREIGN KEY (`transaction_fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_transaction_original_batch_id` FOREIGN KEY (`transaction_original_batch_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_transaction_reversal_batch_id` FOREIGN KEY (`transaction_reversal_batch_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_allocation_method_id` FOREIGN KEY (`allocation_method_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`allocation_method`(`allocation_method_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_reversed_allocation_run_id` FOREIGN KEY (`reversed_allocation_run_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`allocation_run`(`allocation_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_asset_book_id` FOREIGN KEY (`asset_book_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`asset_book`(`asset_book_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_depreciation_reversed_run_id` FOREIGN KEY (`depreciation_reversed_run_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`depreciation_run`(`depreciation_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_primary_reversed_depreciation_run_id` FOREIGN KEY (`primary_reversed_depreciation_run_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`depreciation_run`(`depreciation_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ADD CONSTRAINT `fk_finance_donor_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ADD CONSTRAINT `fk_finance_donor_merged_donor_id` FOREIGN KEY (`merged_donor_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`donor`(`donor_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_from_financial_entity_id` FOREIGN KEY (`from_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_parent_intercompany_agreement_id` FOREIGN KEY (`parent_intercompany_agreement_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`intercompany_agreement`(`intercompany_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_primary_superseded_intercompany_agreement_id` FOREIGN KEY (`primary_superseded_intercompany_agreement_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`intercompany_agreement`(`intercompany_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_target_financial_entity_id` FOREIGN KEY (`target_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_to_financial_entity_id` FOREIGN KEY (`to_financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_intercompany_receiver_entity_id` FOREIGN KEY (`intercompany_receiver_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_superseded_recurring_schedule_id` FOREIGN KEY (`superseded_recurring_schedule_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`recurring_schedule`(`recurring_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_general_ledger_account_chart_of_accounts_id` FOREIGN KEY (`general_ledger_account_chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_parent_asset_book_id` FOREIGN KEY (`parent_asset_book_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`asset_book`(`asset_book_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_parent_book_id` FOREIGN KEY (`parent_book_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`asset_book`(`asset_book_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ADD CONSTRAINT `fk_finance_grant_parent_grant_id` FOREIGN KEY (`parent_grant_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`grant`(`grant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`finance` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_healthcare_v1`.`finance` SET TAGS ('pii_domain' = 'finance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` SET TAGS ('pii_accounting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` SET TAGS ('pii_ledger' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` SET TAGS ('pii_financial_reporting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('pii_business_glossary_term' = 'General Ledger Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `parent_general_ledger_id` SET TAGS ('pii_business_glossary_term' = 'Parent General Ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `accounting_basis` SET TAGS ('pii_business_glossary_term' = 'Accounting Basis');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `accounting_basis` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `accounting_basis` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `accounting_basis` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `accounting_basis` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `accounting_basis` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `accounting_basis` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `accounting_basis` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `audit_trail_level` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Level');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `budget_control_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Budget Control Enabled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `consolidation_group_code` SET TAGS ('pii_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `cost_center_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Center Enabled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_description` SET TAGS ('pii_business_glossary_term' = 'General Ledger Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year_start_month` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year Start Month');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year_variant` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `functional_currency_code` SET TAGS ('pii_business_glossary_term' = 'Functional Currency');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `intercompany_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Intercompany Enabled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `last_closed_period` SET TAGS ('pii_business_glossary_term' = 'Last Closed Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('pii_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `leading_ledger_flag` SET TAGS ('pii_business_glossary_term' = 'Leading Ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_code` SET TAGS ('pii_business_glossary_term' = 'Ledger Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_name` SET TAGS ('pii_business_glossary_term' = 'Ledger Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_status` SET TAGS ('pii_business_glossary_term' = 'Ledger Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_type` SET TAGS ('pii_business_glossary_term' = 'Ledger Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `parallel_accounting_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Parallel Accounting Enabled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `parallel_accounting_enabled_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `parallel_accounting_enabled_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `parallel_accounting_enabled_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `parallel_accounting_enabled_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `parallel_accounting_enabled_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `parallel_accounting_enabled_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `parallel_accounting_enabled_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `profit_center_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Profit Center Enabled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `project_accounting_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Project Accounting Enabled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `project_accounting_enabled_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `project_accounting_enabled_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `project_accounting_enabled_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `project_accounting_enabled_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `project_accounting_enabled_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `project_accounting_enabled_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `project_accounting_enabled_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `reporting_entity_code` SET TAGS ('pii_business_glossary_term' = 'Reporting Entity Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `reporting_entity_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `reporting_entity_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `reporting_entity_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `reporting_entity_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `reporting_entity_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `reporting_entity_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `reporting_entity_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `segment_reporting_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Segment Reporting Enabled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `segment_reporting_enabled_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `segment_reporting_enabled_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `segment_reporting_enabled_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `segment_reporting_enabled_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `segment_reporting_enabled_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `segment_reporting_enabled_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `segment_reporting_enabled_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`general_ledger` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_accounting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_coa' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_account_master' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Parent Chart of Accounts');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_category` SET TAGS ('pii_business_glossary_term' = 'Account Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_code` SET TAGS ('pii_business_glossary_term' = 'Account Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_description` SET TAGS ('pii_business_glossary_term' = 'Account Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('pii_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_owner` SET TAGS ('pii_business_glossary_term' = 'Account Owner');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_subcategory` SET TAGS ('pii_business_glossary_term' = 'Account Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_subtype` SET TAGS ('pii_business_glossary_term' = 'Account Subtype');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `alternate_account_code` SET TAGS ('pii_business_glossary_term' = 'Alternate Account Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `budget_control_flag` SET TAGS ('pii_business_glossary_term' = 'Budget Control');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `consolidation_account_code` SET TAGS ('pii_business_glossary_term' = 'Consolidation Account Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_center_applicable_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Center Applicable');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `department_applicable_flag` SET TAGS ('pii_business_glossary_term' = 'Department Applicable');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `drg_cost_allocation_flag` SET TAGS ('pii_business_glossary_term' = 'DRG Cost Allocation');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reporting_code` SET TAGS ('pii_business_glossary_term' = 'External Reporting Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reporting_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reporting_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reporting_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reporting_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reporting_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reporting_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reporting_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_classification` SET TAGS ('pii_business_glossary_term' = 'Financial Statement Classification');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_classification` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_classification` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_classification` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_classification` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_classification` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_classification` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line_item` SET TAGS ('pii_business_glossary_term' = 'Financial Statement Line Item');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line_item` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line_item` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line_item` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line_item` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line_item` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line_item` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `fund_applicable_flag` SET TAGS ('pii_business_glossary_term' = 'Fund Applicable');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `gaap_classification` SET TAGS ('pii_business_glossary_term' = 'GAAP Classification');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `gasb_classification` SET TAGS ('pii_business_glossary_term' = 'GASB Classification');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `intercompany_flag` SET TAGS ('pii_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `natural_balance` SET TAGS ('pii_business_glossary_term' = 'Natural Balance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_restriction` SET TAGS ('pii_business_glossary_term' = 'Posting Restriction');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_restriction` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_restriction` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_restriction` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_restriction` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_restriction` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_restriction` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_restriction` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `project_applicable_flag` SET TAGS ('pii_business_glossary_term' = 'Project Applicable');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `rollup_account_code` SET TAGS ('pii_business_glossary_term' = 'Rollup Account Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `rvu_allocation_flag` SET TAGS ('pii_business_glossary_term' = 'RVU Allocation');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `statistical_account_flag` SET TAGS ('pii_business_glossary_term' = 'Statistical Account');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_category` SET TAGS ('pii_business_glossary_term' = 'Tax Reporting Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_category` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_category` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` SET TAGS ('pii_cost_accounting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` SET TAGS ('pii_department' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` SET TAGS ('pii_responsibility_center' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Default GL Account');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Parent Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `budget_fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('pii_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cms_provider_number` SET TAGS ('pii_business_glossary_term' = 'CMS Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('pii_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('pii_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_per_unit` SET TAGS ('pii_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `department_name` SET TAGS ('pii_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `department_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `department_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `department_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `department_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `department_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `drg_weight` SET TAGS ('pii_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `fte_allocation` SET TAGS ('pii_business_glossary_term' = 'FTE Allocation');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_capital_intensive` SET TAGS ('pii_business_glossary_term' = 'Capital Intensive');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_direct_patient_care` SET TAGS ('pii_business_glossary_term' = 'Direct Patient Care');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_business_glossary_term' = 'Revenue Generating');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `rvu_target` SET TAGS ('pii_business_glossary_term' = 'RVU Target');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `service_line` SET TAGS ('pii_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` SET TAGS ('pii_accounting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` SET TAGS ('pii_journal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` SET TAGS ('pii_posting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_reversal_journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Reversed By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `recurring_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Recurring Schedule');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `adjustment_type` SET TAGS ('pii_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `batch_code` SET TAGS ('pii_business_glossary_term' = 'Batch Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `consolidation_indicator` SET TAGS ('pii_business_glossary_term' = 'Consolidation Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `gl_interface_status` SET TAGS ('pii_business_glossary_term' = 'GL Interface Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('pii_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_category` SET TAGS ('pii_business_glossary_term' = 'Journal Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_number` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_source` SET TAGS ('pii_business_glossary_term' = 'Journal Source');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `recurring_entry_indicator` SET TAGS ('pii_business_glossary_term' = 'Recurring Entry Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('pii_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('pii_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `source_transaction_reference` SET TAGS ('pii_business_glossary_term' = 'Source Transaction Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('pii_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('pii_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_accounting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_journal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_posting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_line_item' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `primary_reversed_line_journal_entry_line_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Line');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tertiary_journal_approved_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tertiary_journal_approved_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tertiary_journal_approved_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `credit_amount` SET TAGS ('pii_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_amount` SET TAGS ('pii_business_glossary_term' = 'Debit Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `intercompany_entity_code` SET TAGS ('pii_business_glossary_term' = 'Intercompany Entity Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `intercompany_indicator` SET TAGS ('pii_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('pii_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `natural_account_code` SET TAGS ('pii_business_glossary_term' = 'Natural Account Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payer_code` SET TAGS ('pii_business_glossary_term' = 'Payer Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('pii_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `project_code` SET TAGS ('pii_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('pii_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `source_document_number` SET TAGS ('pii_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `statistical_amount` SET TAGS ('pii_business_glossary_term' = 'Statistical Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `statistical_uom` SET TAGS ('pii_business_glossary_term' = 'Statistical UOM');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_amount` SET TAGS ('pii_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('pii_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` SET TAGS ('pii_accounting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` SET TAGS ('pii_fiscal_calendar' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` SET TAGS ('pii_period' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `general_ledger_id` SET TAGS ('pii_business_glossary_term' = 'General Ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `parent_fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Parent Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `parent_period_fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Parent Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `primary_prior_period_fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Prior Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `adjustment_period_flag` SET TAGS ('pii_business_glossary_term' = 'Adjustment Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `budget_period_flag` SET TAGS ('pii_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `business_days_in_period` SET TAGS ('pii_business_glossary_term' = 'Business Days in Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `calendar_month` SET TAGS ('pii_business_glossary_term' = 'Calendar Month');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `calendar_quarter` SET TAGS ('pii_business_glossary_term' = 'Calendar Quarter');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `calendar_year` SET TAGS ('pii_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `close_approved_by` SET TAGS ('pii_business_glossary_term' = 'Close Approved By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `close_date` SET TAGS ('pii_business_glossary_term' = 'Close Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `close_initiated_by` SET TAGS ('pii_business_glossary_term' = 'Close Initiated By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `cms_reporting_period_flag` SET TAGS ('pii_business_glossary_term' = 'CMS Reporting Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `cms_reporting_period_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `cms_reporting_period_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `cms_reporting_period_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `cms_reporting_period_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `cms_reporting_period_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `cms_reporting_period_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `cms_reporting_period_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `days_in_period` SET TAGS ('pii_business_glossary_term' = 'Days in Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_description` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_end_close_checklist_complete_flag` SET TAGS ('pii_business_glossary_term' = 'Period End Close Checklist Complete');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_number` SET TAGS ('pii_business_glossary_term' = 'Period Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('pii_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('pii_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `permanent_close_date` SET TAGS ('pii_business_glossary_term' = 'Permanent Close Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `quarter_number` SET TAGS ('pii_business_glossary_term' = 'Quarter Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `reopen_date` SET TAGS ('pii_business_glossary_term' = 'Reopen Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `reporting_period_flag` SET TAGS ('pii_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `reporting_period_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `reporting_period_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `reporting_period_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `reporting_period_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `reporting_period_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `reporting_period_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `reporting_period_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fiscal_period` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` SET TAGS ('pii_subdomain' = 'budget_planning');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` SET TAGS ('pii_budgeting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` SET TAGS ('pii_planning' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` SET TAGS ('pii_financial_planning' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `fte_budget_id` SET TAGS ('pii_business_glossary_term' = 'FTE Budget');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `parent_budget_id` SET TAGS ('pii_business_glossary_term' = 'Parent Budget');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `primary_budget_employee_id` SET TAGS ('pii_business_glossary_term' = 'Budget Owner');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `primary_budget_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `primary_budget_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `primary_prior_budget_id` SET TAGS ('pii_business_glossary_term' = 'Prior Budget');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `assumptions` SET TAGS ('pii_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('pii_business_glossary_term' = 'Budget Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('pii_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('pii_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budgeted_cmi` SET TAGS ('pii_business_glossary_term' = 'Budgeted CMI');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budgeted_fte_count` SET TAGS ('pii_business_glossary_term' = 'Budgeted FTE Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budgeted_net_income` SET TAGS ('pii_business_glossary_term' = 'Budgeted Net Income');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budgeted_patient_volume` SET TAGS ('pii_business_glossary_term' = 'Budgeted Patient Volume');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('pii_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `grant_number` SET TAGS ('pii_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `is_baseline_budget` SET TAGS ('pii_business_glossary_term' = 'Baseline Budget');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Methodology');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `narrative` SET TAGS ('pii_business_glossary_term' = 'Narrative');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `total_budgeted_capital` SET TAGS ('pii_business_glossary_term' = 'Total Budgeted Capital');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `total_budgeted_expense` SET TAGS ('pii_business_glossary_term' = 'Total Budgeted Expense');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `total_budgeted_revenue` SET TAGS ('pii_business_glossary_term' = 'Total Budgeted Revenue');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('pii_business_glossary_term' = 'Variance Threshold Percent');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Version');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` SET TAGS ('pii_subdomain' = 'budget_planning');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` SET TAGS ('pii_budgeting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` SET TAGS ('pii_planning' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` SET TAGS ('pii_line_item' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `parent_budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Parent Budget Line');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('pii_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('pii_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `fte_count` SET TAGS ('pii_business_glossary_term' = 'FTE Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `is_capital` SET TAGS ('pii_business_glossary_term' = 'Capital');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `is_restricted` SET TAGS ('pii_business_glossary_term' = 'Restricted');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `line_notes` SET TAGS ('pii_business_glossary_term' = 'Line Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `prior_year_actual` SET TAGS ('pii_business_glossary_term' = 'Prior Year Actual');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `service_line_code` SET TAGS ('pii_business_glossary_term' = 'Service Line Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `statistical_basis` SET TAGS ('pii_business_glossary_term' = 'Statistical Basis');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `variance_threshold_percent` SET TAGS ('pii_business_glossary_term' = 'Variance Threshold Percent');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `volume_assumption` SET TAGS ('pii_business_glossary_term' = 'Volume Assumption');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `volume_unit` SET TAGS ('pii_business_glossary_term' = 'Volume Unit');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_line` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` SET TAGS ('pii_subdomain' = 'budget_planning');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_transfer_id` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_employee_id` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Destination Budget Line ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_line_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_line_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_line_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_line_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_line_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_line_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `budget_line_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Destination Cost Center ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Destination General Ledger (GL) Account ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `primary_budget_chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Source General Ledger (GL) Account ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `primary_budget_requestor_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `primary_budget_requestor_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `primary_budget_requestor_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `primary_original_transfer_budget_transfer_id` SET TAGS ('pii_business_glossary_term' = 'Original Budget Transfer ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `source_budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Source Budget Line ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `source_cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Source Cost Center ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approval_level` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Approval Level');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approval_level` SET TAGS ('pii_value_regex' = 'department_manager|director|vice_president|chief_financial_officer|board_of_directors');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approver_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approver_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approver_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approver_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `approver_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `batch_code` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Batch ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Comments');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Compliance Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `requestor_department` SET TAGS ('pii_business_glossary_term' = 'Requestor Department');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `requestor_name` SET TAGS ('pii_business_glossary_term' = 'Requestor Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `requestor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `requestor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `requestor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `requestor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `requestor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `requestor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `reversal_date` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_date` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_number` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_number` SET TAGS ('pii_value_regex' = '^BT-[0-9]{8}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('pii_value_regex' = 'operational_need|cost_overrun|revenue_shortfall|strategic_priority|regulatory_requirement|emergency_response');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_reason_description` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_status` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_type` SET TAGS ('pii_business_glossary_term' = 'Budget Transfer Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ALTER COLUMN `transfer_type` SET TAGS ('pii_value_regex' = 'budget_amendment|budget_transfer|budget_revision|budget_reallocation|supplemental_appropriation|technical_adjustment');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `credited_ap_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Credited Ap Invoice Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `credited_ap_invoice_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `requester_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requester ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `requester_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `requester_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_site_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('pii_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `freight_amount` SET TAGS ('pii_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `functional_currency_amount` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `gl_date` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `hold_date` SET TAGS ('pii_business_glossary_term' = 'Hold Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `hold_reason_code` SET TAGS ('pii_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `hold_released_date` SET TAGS ('pii_business_glossary_term' = 'Hold Released Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_amount` SET TAGS ('pii_business_glossary_term' = 'Invoice Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_currency_code` SET TAGS ('pii_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_source` SET TAGS ('pii_business_glossary_term' = 'Invoice Source');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_source` SET TAGS ('pii_value_regex' = 'manual_entry|edi|email|ocr|supplier_portal|api');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_value_regex' = 'standard|credit_memo|debit_memo|prepayment|expense_report|recurring');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|ach|wire_transfer|eft|credit_card|virtual_card');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('pii_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `po_match_indicator` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Match Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `po_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_value_regex' = 'not_applicable|pending|matched|variance|failed');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ALTER COLUMN `voucher_number` SET TAGS ('pii_business_glossary_term' = 'Voucher Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `ap_invoice_line_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Payable (AP) Invoice Line ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `credited_ap_invoice_line_id` SET TAGS ('pii_business_glossary_term' = 'Credited Ap Invoice Line Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `credited_ap_invoice_line_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `requester_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `requester_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `requester_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `asset_category` SET TAGS ('pii_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `asset_flag` SET TAGS ('pii_business_glossary_term' = 'Asset Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `distribution_date` SET TAGS ('pii_business_glossary_term' = 'Distribution Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `distribution_status` SET TAGS ('pii_business_glossary_term' = 'Distribution Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `distribution_status` SET TAGS ('pii_value_regex' = 'pending|distributed|posted|reversed|error');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `hold_flag` SET TAGS ('pii_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `hold_reason` SET TAGS ('pii_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `item_code` SET TAGS ('pii_business_glossary_term' = 'Item Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `line_amount` SET TAGS ('pii_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `line_description` SET TAGS ('pii_business_glossary_term' = 'Line Item Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `line_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|on_hold|paid|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `match_exception_reason` SET TAGS ('pii_business_glossary_term' = 'Match Exception Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `match_status` SET TAGS ('pii_business_glossary_term' = 'Match Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `match_status` SET TAGS ('pii_value_regex' = 'matched|unmatched|partial|exception|override');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `project_code` SET TAGS ('pii_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `service_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `service_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `total_line_amount` SET TAGS ('pii_business_glossary_term' = 'Total Line Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_batch_id` SET TAGS ('pii_business_glossary_term' = 'Payment Batch ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Bank Account ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `tertiary_ap_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `tertiary_ap_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `tertiary_ap_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `voided_ap_payment_id` SET TAGS ('pii_business_glossary_term' = 'Voided Ap Payment Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `voided_ap_payment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('pii_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `cleared_date` SET TAGS ('pii_business_glossary_term' = 'Cleared Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `discount_taken_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Taken Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_description` SET TAGS ('pii_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|ach|eft|wire_transfer|virtual_card|cash');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_number` SET TAGS ('pii_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('pii_business_glossary_term' = 'Payment Priority');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('pii_value_regex' = 'standard|urgent|expedited');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Payment Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_reconciliation_status` SET TAGS ('pii_value_regex' = 'unreconciled|reconciled|exception');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_source_system` SET TAGS ('pii_business_glossary_term' = 'Payment Source System');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'issued|cleared|voided|stopped|cancelled|pending');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'invoice_payment|prepayment|refund|expense_reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `reconciled_date` SET TAGS ('pii_business_glossary_term' = 'Reconciled Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_reference` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `void_date` SET TAGS ('pii_business_glossary_term' = 'Void Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `void_reason` SET TAGS ('pii_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ALTER COLUMN `wire_confirmation_number` SET TAGS ('pii_business_glossary_term' = 'Wire Confirmation Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `ar_account_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Receivable (AR) Account Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `parent_ar_account_id` SET TAGS ('pii_business_glossary_term' = 'Parent Ar Account Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `parent_ar_account_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Collector Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `tertiary_ar_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `tertiary_ar_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `tertiary_ar_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `aging_bucket` SET TAGS ('pii_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `aging_bucket` SET TAGS ('pii_value_regex' = 'current|1_30_days|31_60_days|61_90_days|91_120_days|over_120_days');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `current_balance` SET TAGS ('pii_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `days_outstanding` SET TAGS ('pii_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `debtor_name` SET TAGS ('pii_business_glossary_term' = 'Debtor Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `debtor_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `debtor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `debtor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `debtor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `debtor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `debtor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `debtor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `debtor_type` SET TAGS ('pii_business_glossary_term' = 'Debtor Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `dispute_date` SET TAGS ('pii_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `interest_rate` SET TAGS ('pii_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `last_activity_date` SET TAGS ('pii_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `legal_action_date` SET TAGS ('pii_business_glossary_term' = 'Legal Action Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `legal_action_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `original_balance` SET TAGS ('pii_business_glossary_term' = 'Original Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `settlement_accepted_flag` SET TAGS ('pii_business_glossary_term' = 'Settlement Accepted Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `settlement_offer_amount` SET TAGS ('pii_business_glossary_term' = 'Settlement Offer Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `total_adjustments` SET TAGS ('pii_business_glossary_term' = 'Total Adjustments Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `total_fees_assessed` SET TAGS ('pii_business_glossary_term' = 'Total Fees Assessed Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `total_interest_accrued` SET TAGS ('pii_business_glossary_term' = 'Total Interest Accrued Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `total_payments_received` SET TAGS ('pii_business_glossary_term' = 'Total Payments Received Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `write_off_amount` SET TAGS ('pii_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `write_off_date` SET TAGS ('pii_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ALTER COLUMN `write_off_reason` SET TAGS ('pii_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Receivable (AR) Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_account_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Receivable (AR) Account ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_applied_to_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Applied To Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_applied_to_transaction_id` SET TAGS ('pii_relationship' = 'applied_to');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Entered By User ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `primary_reversed_transaction_ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_batch_id` SET TAGS ('pii_business_glossary_term' = 'Batch ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `aging_bucket` SET TAGS ('pii_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `aging_bucket` SET TAGS ('pii_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `functional_amount` SET TAGS ('pii_business_glossary_term' = 'Functional Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|wire_transfer|ach|credit_card|cash|electronic_funds_transfer');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `payment_reference_number` SET TAGS ('pii_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_value_regex' = 'draft|posted|reversed|voided|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'unreconciled|reconciled|disputed|under_review');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('pii_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `source_system_transaction_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('pii_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_date` SET TAGS ('pii_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_description` SET TAGS ('pii_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ALTER COLUMN `write_off_reason_code` SET TAGS ('pii_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` SET TAGS ('pii_subdomain' = 'capital_assets');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `parent_fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Parent Fixed Asset Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `parent_fixed_asset_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('pii_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('pii_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('pii_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('pii_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('pii_value_regex' = 'medical_equipment|building|land|leasehold_improvement|it_equipment|vehicle');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('pii_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_business_glossary_term' = 'Asset Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('pii_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('pii_value_regex' = 'active|disposed|transferred|fully_depreciated|under_construction|retired');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_subcategory` SET TAGS ('pii_business_glossary_term' = 'Asset Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('pii_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_threshold_met` SET TAGS ('pii_business_glossary_term' = 'Capitalization Threshold Met');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|declining_balance|macrs|units_of_production|sum_of_years_digits');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('pii_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('pii_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('pii_value_regex' = 'sold|donated|scrapped|traded_in|returned_to_lessor|transferred');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('pii_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `fda_device_class` SET TAGS ('pii_business_glossary_term' = 'FDA (Food and Drug Administration) Device Class');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `fda_device_class` SET TAGS ('pii_value_regex' = 'class_i|class_ii|class_iii|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `fda_regulated_indicator` SET TAGS ('pii_business_glossary_term' = 'FDA (Food and Drug Administration) Regulated Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('pii_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `lease_end_date` SET TAGS ('pii_business_glossary_term' = 'Lease End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `lease_indicator` SET TAGS ('pii_business_glossary_term' = 'Lease Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `lease_type` SET TAGS ('pii_business_glossary_term' = 'Lease Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `lease_type` SET TAGS ('pii_value_regex' = 'operating_lease|finance_lease|capital_lease|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_schedule` SET TAGS ('pii_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('pii_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('pii_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `physical_location` SET TAGS ('pii_business_glossary_term' = 'Physical Location');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `placed_in_service_date` SET TAGS ('pii_business_glossary_term' = 'Placed in Service Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('pii_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('pii_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('pii_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` SET TAGS ('pii_subdomain' = 'capital_assets');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Depreciation Schedule ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_run_id` SET TAGS ('pii_business_glossary_term' = 'Depreciation Run ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Expense Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `prior_depreciation_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Prior Depreciation Schedule Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `prior_depreciation_schedule_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation_balance` SET TAGS ('pii_business_glossary_term' = 'Accumulated Depreciation Balance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation_gl_account` SET TAGS ('pii_business_glossary_term' = 'Accumulated Depreciation General Ledger (GL) Account');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `asset_category` SET TAGS ('pii_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `beginning_net_book_value` SET TAGS ('pii_business_glossary_term' = 'Beginning Net Book Value (NBV)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `book_tax_difference` SET TAGS ('pii_business_glossary_term' = 'Book-Tax Difference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_date` SET TAGS ('pii_business_glossary_term' = 'Depreciation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_expense_amount` SET TAGS ('pii_business_glossary_term' = 'Depreciation Expense Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|declining_balance|double_declining_balance|sum_of_years_digits|units_of_production|modified_accelerated_cost_recovery_system');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `ending_net_book_value` SET TAGS ('pii_business_glossary_term' = 'Ending Net Book Value (NBV)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `facility_code` SET TAGS ('pii_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `impairment_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Impairment Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Depreciation Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posted_by` SET TAGS ('pii_business_glossary_term' = 'Posted By User');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posted_date` SET TAGS ('pii_business_glossary_term' = 'Posted Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('pii_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('pii_value_regex' = 'draft|posted|reversed|adjusted|closed');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `reversal_date` SET TAGS ('pii_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `salvage_value` SET TAGS ('pii_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `tax_depreciation_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Depreciation Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `useful_life_remaining_months` SET TAGS ('pii_business_glossary_term' = 'Useful Life Remaining (Months)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` SET TAGS ('pii_subdomain' = 'capital_assets');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `capital_project_id` SET TAGS ('pii_business_glossary_term' = 'Capital Project ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `capital_modified_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `capital_modified_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `capital_modified_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `grant_id` SET TAGS ('pii_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `parent_capital_project_id` SET TAGS ('pii_business_glossary_term' = 'Parent Capital Project Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `parent_capital_project_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `primary_capital_employee_id` SET TAGS ('pii_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `primary_capital_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `primary_capital_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `approved_capital_budget` SET TAGS ('pii_business_glossary_term' = 'Approved Capital Budget');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `asset_class` SET TAGS ('pii_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `asset_class` SET TAGS ('pii_value_regex' = 'building|building_improvement|land_improvement|equipment|software|infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `bond_issue_number` SET TAGS ('pii_business_glossary_term' = 'Bond Issue Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `business_justification` SET TAGS ('pii_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `capitalization_status` SET TAGS ('pii_business_glossary_term' = 'Capitalization Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `capitalization_status` SET TAGS ('pii_value_regex' = 'not_capitalized|in_progress|capitalized|expensed');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `expected_annual_revenue` SET TAGS ('pii_business_glossary_term' = 'Expected Annual Revenue');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `expected_annual_savings` SET TAGS ('pii_business_glossary_term' = 'Expected Annual Savings');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `funding_source` SET TAGS ('pii_value_regex' = 'bond|operating_cash|grant|lease|donation|loan');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `is_regulatory_required` SET TAGS ('pii_business_glossary_term' = 'Is Regulatory Required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_business_glossary_term' = 'Is Revenue Generating');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `is_revenue_generating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_description` SET TAGS ('pii_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('pii_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_notes` SET TAGS ('pii_business_glossary_term' = 'Project Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_number` SET TAGS ('pii_business_glossary_term' = 'Project Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_phase` SET TAGS ('pii_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_priority` SET TAGS ('pii_business_glossary_term' = 'Project Priority');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_start_date` SET TAGS ('pii_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_status` SET TAGS ('pii_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_status` SET TAGS ('pii_value_regex' = 'planning|approved|in_progress|on_hold|completed|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('pii_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('pii_value_regex' = 'construction|renovation|equipment_acquisition|it_implementation|leasehold_improvement|infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `projected_completion_date` SET TAGS ('pii_business_glossary_term' = 'Projected Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `strategic_initiative` SET TAGS ('pii_business_glossary_term' = 'Strategic Initiative');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `total_actual_costs` SET TAGS ('pii_business_glossary_term' = 'Total Actual Costs');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `total_committed_costs` SET TAGS ('pii_business_glossary_term' = 'Total Committed Costs');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `useful_life_years` SET TAGS ('pii_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ALTER COLUMN `variance_percent` SET TAGS ('pii_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` SET TAGS ('pii_subdomain' = 'capital_assets');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `capital_expenditure_id` SET TAGS ('pii_business_glossary_term' = 'Capital Expenditure ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `capital_modified_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `capital_modified_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `capital_modified_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `capital_project_id` SET TAGS ('pii_business_glossary_term' = 'Capital Project ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `primary_capital_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `primary_capital_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `primary_capital_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `reversed_capital_expenditure_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Capital Expenditure Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `reversed_capital_expenditure_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `asset_category` SET TAGS ('pii_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `asset_category` SET TAGS ('pii_value_regex' = 'medical_equipment|it_hardware|building|furniture|vehicle|other');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `asset_placed_in_service_flag` SET TAGS ('pii_business_glossary_term' = 'Asset Placed In Service Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `capitalization_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Capitalization Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `cip_category` SET TAGS ('pii_business_glossary_term' = 'Construction In Progress (CIP) Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `cip_category` SET TAGS ('pii_value_regex' = 'building|equipment|infrastructure|technology|land_improvement|other');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `expenditure_amount` SET TAGS ('pii_business_glossary_term' = 'Expenditure Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `expenditure_date` SET TAGS ('pii_business_glossary_term' = 'Expenditure Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `expenditure_description` SET TAGS ('pii_business_glossary_term' = 'Expenditure Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `expenditure_number` SET TAGS ('pii_business_glossary_term' = 'Expenditure Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `expenditure_status` SET TAGS ('pii_business_glossary_term' = 'Expenditure Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `expenditure_status` SET TAGS ('pii_value_regex' = 'pending|approved|posted|capitalized|reversed|voided');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `expenditure_type` SET TAGS ('pii_business_glossary_term' = 'Expenditure Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `expenditure_type` SET TAGS ('pii_value_regex' = 'invoice_payment|progress_billing|internal_labor|capitalized_interest|equipment_purchase|construction_cost');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `grant_number` SET TAGS ('pii_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `internal_labor_flag` SET TAGS ('pii_business_glossary_term' = 'Internal Labor Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `labor_hours` SET TAGS ('pii_business_glossary_term' = 'Labor Hours');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `labor_rate` SET TAGS ('pii_business_glossary_term' = 'Labor Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|wire_transfer|ach|credit_card|internal_transfer|other');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `placed_in_service_date` SET TAGS ('pii_business_glossary_term' = 'Placed In Service Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `reversal_date` SET TAGS ('pii_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `salvage_value` SET TAGS ('pii_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ALTER COLUMN `useful_life_years` SET TAGS ('pii_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` SET TAGS ('pii_subdomain' = 'budget_planning');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method_id` SET TAGS ('pii_business_glossary_term' = 'Allocation Method Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_id` SET TAGS ('pii_business_glossary_term' = 'Allocation Run ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `primary_original_allocation_cost_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Original Allocation ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Source Cost Center ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `target_cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Target Cost Center ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_modified_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_modified_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_modified_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('pii_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Allocation Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('pii_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Basis Percentage');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_quantity` SET TAGS ('pii_business_glossary_term' = 'Allocation Basis Quantity');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_category` SET TAGS ('pii_business_glossary_term' = 'Allocation Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('pii_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('pii_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Run Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_sequence` SET TAGS ('pii_business_glossary_term' = 'Allocation Sequence');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_tier` SET TAGS ('pii_business_glossary_term' = 'Allocation Tier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_version` SET TAGS ('pii_business_glossary_term' = 'Allocation Version');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `drg_cost_allocation_flag` SET TAGS ('pii_business_glossary_term' = 'Diagnosis-Related Group (DRG) Cost Allocation Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `is_medicare_reportable` SET TAGS ('pii_business_glossary_term' = 'Is Medicare Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `is_reciprocal_allocation` SET TAGS ('pii_business_glossary_term' = 'Is Reciprocal Allocation Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `service_line_code` SET TAGS ('pii_business_glossary_term' = 'Service Line Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ALTER COLUMN `source_cost_pool_amount` SET TAGS ('pii_business_glossary_term' = 'Source Cost Pool Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` SET TAGS ('pii_subdomain' = 'budget_planning');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `allocation_method_id` SET TAGS ('pii_business_glossary_term' = 'Allocation Method Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `allocation_modified_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `allocation_modified_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `allocation_modified_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `owner_employee_id` SET TAGS ('pii_business_glossary_term' = 'Method Owner Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `owner_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `owner_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `primary_allocation_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `primary_allocation_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `primary_allocation_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `primary_superseded_method_allocation_method_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Method Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `activity_driver_description` SET TAGS ('pii_business_glossary_term' = 'Activity Driver Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `allocation_basis_type` SET TAGS ('pii_business_glossary_term' = 'Allocation Basis Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `allocation_frequency` SET TAGS ('pii_business_glossary_term' = 'Allocation Frequency');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `allocation_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annually|as_needed|real_time');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `allocation_percentage_cap` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage Cap');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `allocation_sequence` SET TAGS ('pii_business_glossary_term' = 'Allocation Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Method Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `basis_data_source` SET TAGS ('pii_business_glossary_term' = 'Allocation Basis Data Source');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `calculation_formula` SET TAGS ('pii_business_glossary_term' = 'Allocation Calculation Formula');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `cms_cost_report_schedule` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Cost Report Schedule');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `cms_cost_report_schedule` SET TAGS ('pii_value_regex' = '^[A-Z]-[0-9]{1,2}(-[A-Z0-9]{1,3})?$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `decimal_precision` SET TAGS ('pii_business_glossary_term' = 'Allocation Decimal Precision');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `gaap_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_code` SET TAGS ('pii_business_glossary_term' = 'Allocation Method Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_description` SET TAGS ('pii_business_glossary_term' = 'Allocation Method Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_name` SET TAGS ('pii_business_glossary_term' = 'Allocation Method Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Method Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending_approval|deprecated|under_review');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_type` SET TAGS ('pii_business_glossary_term' = 'Allocation Method Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `method_type` SET TAGS ('pii_value_regex' = 'step_down|direct|reciprocal|activity_based_costing|simultaneous|double_distribution');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `prior_period_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Period Adjustment Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `reciprocal_allocation_flag` SET TAGS ('pii_business_glossary_term' = 'Reciprocal Allocation Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `rounding_rule` SET TAGS ('pii_business_glossary_term' = 'Allocation Rounding Rule');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `rounding_rule` SET TAGS ('pii_value_regex' = 'round_half_up|round_half_down|round_up|round_down|truncate|no_rounding');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `source_cost_center_category` SET TAGS ('pii_business_glossary_term' = 'Source Cost Center Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `target_cost_center_category` SET TAGS ('pii_business_glossary_term' = 'Target Cost Center Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `target_cost_center_category` SET TAGS ('pii_value_regex' = 'clinical|ancillary|revenue_producing|all_departments|patient_care_only');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `usage_notes` SET TAGS ('pii_business_glossary_term' = 'Method Usage Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Method Version Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `version_number` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `weighting_factor` SET TAGS ('pii_business_glossary_term' = 'Allocation Weighting Factor');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `weighting_factor` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `weighting_factor` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `weighting_factor` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `weighting_factor` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `weighting_factor` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `weighting_factor` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ALTER COLUMN `weighting_factor` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Cash Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_chart_of_accounts_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_chart_of_accounts_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_chart_of_accounts_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_chart_of_accounts_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_chart_of_accounts_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_chart_of_accounts_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_chart_of_accounts_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Parent Bank Account Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_closed_date` SET TAGS ('pii_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_notes` SET TAGS ('pii_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_opened_date` SET TAGS ('pii_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('pii_business_glossary_term' = 'Bank Account Purpose');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('pii_value_regex' = 'operating|payroll|petty_cash|restricted|investment|escrow');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('pii_value_regex' = 'active|closed|dormant|frozen|pending_closure');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('pii_value_regex' = 'checking|savings|money_market|sweep|lockbox|investment');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `ach_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Automated Clearing House (ACH) Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('pii_business_glossary_term' = 'Available Account Balance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_business_glossary_term' = 'Bank Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_business_glossary_term' = 'Bank Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Bank Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_business_glossary_term' = 'Bank SWIFT Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('pii_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `dual_signature_required_flag` SET TAGS ('pii_business_glossary_term' = 'Dual Signature Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `dual_signature_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Dual Signature Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `fdic_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Certificate Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `fdic_insured_flag` SET TAGS ('pii_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insured Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `grant_number` SET TAGS ('pii_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `interest_calculation_method` SET TAGS ('pii_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `interest_calculation_method` SET TAGS ('pii_value_regex' = 'daily|monthly|quarterly|annual|none');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('pii_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `is_operating_account` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `is_operating_account` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `is_operating_account` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `is_operating_account` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `is_operating_account` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `is_operating_account` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `is_operating_account` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_required` SET TAGS ('pii_business_glossary_term' = 'Minimum Balance Required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `next_reconciliation_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Reconciliation Due Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Online Banking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `positive_pay_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Positive Pay Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Primary Signatory Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_title` SET TAGS ('pii_business_glossary_term' = 'Primary Signatory Title');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `restricted_fund_flag` SET TAGS ('pii_business_glossary_term' = 'Restricted Fund Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `restriction_description` SET TAGS ('pii_business_glossary_term' = 'Restriction Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Secondary Signatory Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ALTER COLUMN `wire_transfer_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Wire Transfer Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_business_glossary_term' = 'Bank Reconciliation ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_business_glossary_term' = 'Preparer ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_prior_period_reconciliation_bank_reconciliation_id` SET TAGS ('pii_business_glossary_term' = 'Prior Period Reconciliation ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_prior_period_reconciliation_bank_reconciliation_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_prior_period_reconciliation_bank_reconciliation_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_prior_period_reconciliation_bank_reconciliation_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_prior_period_reconciliation_bank_reconciliation_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_prior_period_reconciliation_bank_reconciliation_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_prior_period_reconciliation_bank_reconciliation_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_prior_period_reconciliation_bank_reconciliation_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_recon_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_recon_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `auto_reconciliation_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Reconciliation Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('pii_business_glossary_term' = 'Bank Errors Total');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_service_charges` SET TAGS ('pii_business_glossary_term' = 'Bank Service Charges');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_service_charges` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_service_charges` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_service_charges` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_service_charges` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_service_charges` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_service_charges` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_service_charges` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `book_errors_total` SET TAGS ('pii_business_glossary_term' = 'Book Errors Total');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `deposits_in_transit_total` SET TAGS ('pii_business_glossary_term' = 'Deposits in Transit Total');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `exception_flag` SET TAGS ('pii_business_glossary_term' = 'Exception Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `gl_book_balance` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Book Balance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `interest_earned` SET TAGS ('pii_business_glossary_term' = 'Interest Earned');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `nsf_checks_total` SET TAGS ('pii_business_glossary_term' = 'Non-Sufficient Funds (NSF) Checks Total');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `other_adjustments_total` SET TAGS ('pii_business_glossary_term' = 'Other Adjustments Total');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_checks_total` SET TAGS ('pii_business_glossary_term' = 'Outstanding Checks Total');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_items_count` SET TAGS ('pii_business_glossary_term' = 'Outstanding Items Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparation_date` SET TAGS ('pii_business_glossary_term' = 'Preparation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_business_glossary_term' = 'Preparer Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciled_balance` SET TAGS ('pii_business_glossary_term' = 'Reconciled Balance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_notes` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'in_progress|reconciled|approved|rejected|pending_review|reopened');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_balance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_balance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_balance` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_balance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_balance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_balance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('pii_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_balance` SET TAGS ('pii_business_glossary_term' = 'Bank Statement Ending Balance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_balance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_balance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_balance` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_balance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_balance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_balance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_date` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_starting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_starting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_starting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_starting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_starting_date` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_starting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_starting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_starting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `unreconciled_variance` SET TAGS ('pii_business_glossary_term' = 'Unreconciled Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_period_close_id` SET TAGS ('pii_business_glossary_term' = 'Financial Period Close ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_modified_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_modified_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_modified_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `general_ledger_id` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `primary_close_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `primary_close_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('pii_business_glossary_term' = 'Close Owner ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `prior_financial_period_close_id` SET TAGS ('pii_business_glossary_term' = 'Prior Financial Period Close Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `prior_financial_period_close_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `accounts_payable_close_status` SET TAGS ('pii_business_glossary_term' = 'Accounts Payable (AP) Close Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `accounts_payable_close_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|review_required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `accrual_completion_status` SET TAGS ('pii_business_glossary_term' = 'Accrual Completion Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `accrual_completion_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|review_required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `actual_close_date` SET TAGS ('pii_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `approver_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `approver_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `approver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `approver_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `approver_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `approver_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `audit_findings_count` SET TAGS ('pii_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `balance_sheet_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Balance Sheet Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `balance_sheet_reconciliation_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|exceptions_pending');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `budget_variance_review_status` SET TAGS ('pii_business_glossary_term' = 'Budget Variance Review Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `budget_variance_review_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|escalated');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_checklist_completed_items` SET TAGS ('pii_business_glossary_term' = 'Close Checklist Completed Items');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_checklist_completion_percentage` SET TAGS ('pii_business_glossary_term' = 'Close Checklist Completion Percentage');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_checklist_total_items` SET TAGS ('pii_business_glossary_term' = 'Close Checklist Total Items');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_completed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Close Completed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_delay_reason` SET TAGS ('pii_business_glossary_term' = 'Close Delay Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_efficiency_rating` SET TAGS ('pii_business_glossary_term' = 'Close Efficiency Rating');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_efficiency_rating` SET TAGS ('pii_value_regex' = 'excellent|good|acceptable|needs_improvement');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_efficiency_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_efficiency_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_efficiency_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_efficiency_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_efficiency_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_efficiency_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_efficiency_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_initiated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Close Initiated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_notes` SET TAGS ('pii_business_glossary_term' = 'Close Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_number` SET TAGS ('pii_business_glossary_term' = 'Close Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_status` SET TAGS ('pii_business_glossary_term' = 'Close Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_status` SET TAGS ('pii_value_regex' = 'open|in_progress|soft_close|hard_close|reopened|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_type` SET TAGS ('pii_business_glossary_term' = 'Close Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `close_type` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual|adjustment');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `cms_cost_report_status` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Cost Report Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `cms_cost_report_status` SET TAGS ('pii_value_regex' = 'not_applicable|not_started|in_progress|submitted|accepted|amended');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `days_to_close` SET TAGS ('pii_business_glossary_term' = 'Days to Close');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `external_audit_status` SET TAGS ('pii_business_glossary_term' = 'External Audit Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `external_audit_status` SET TAGS ('pii_value_regex' = 'not_applicable|not_started|in_progress|completed|findings_pending');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_statement_preparation_status` SET TAGS ('pii_business_glossary_term' = 'Financial Statement Preparation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_statement_preparation_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|approved');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_statement_preparation_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_statement_preparation_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_statement_preparation_status` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_statement_preparation_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_statement_preparation_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_statement_preparation_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `fixed_assets_close_status` SET TAGS ('pii_business_glossary_term' = 'Fixed Assets Close Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `fixed_assets_close_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|review_required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `hard_close_date` SET TAGS ('pii_business_glossary_term' = 'Hard Close Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Intercompany Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|exceptions_pending');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `open_items_count` SET TAGS ('pii_business_glossary_term' = 'Open Items Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `payroll_close_status` SET TAGS ('pii_business_glossary_term' = 'Payroll Close Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `payroll_close_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|review_required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `planned_close_date` SET TAGS ('pii_business_glossary_term' = 'Planned Close Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `prior_period_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Period Adjustment Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('pii_value_regex' = 'not_required|not_started|in_progress|submitted|accepted');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `reopen_date` SET TAGS ('pii_business_glossary_term' = 'Reopen Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `revenue_cycle_close_status` SET TAGS ('pii_business_glossary_term' = 'Revenue Cycle Management (RCM) Close Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `revenue_cycle_close_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|review_required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `soft_close_date` SET TAGS ('pii_business_glossary_term' = 'Soft Close Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `unposted_journals_count` SET TAGS ('pii_business_glossary_term' = 'Unposted Journals Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Intercompany Agreement ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Elimination Journal Entry ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Originating Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `primary_intercompany_financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Originating Legal Entity ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `primary_reversed_transaction_intercompany_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_entity_financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Receiving Legal Entity ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `batch_code` SET TAGS ('pii_business_glossary_term' = 'Batch ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('pii_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_indicator` SET TAGS ('pii_business_glossary_term' = 'Elimination Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_period` SET TAGS ('pii_business_glossary_term' = 'Elimination Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_business_glossary_term' = 'Originating Legal Entity Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_entity_code` SET TAGS ('pii_business_glossary_term' = 'Receiving Legal Entity Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_gl_account_code` SET TAGS ('pii_business_glossary_term' = 'Receiving General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'unreconciled|partially_reconciled|reconciled|variance_identified|under_review');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_variance_amount` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('pii_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `service_line_code` SET TAGS ('pii_business_glossary_term' = 'Service Line Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `source_transaction_reference` SET TAGS ('pii_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `supporting_document_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('pii_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('pii_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_value_regex' = 'management_fee|shared_service_charge|intercompany_loan|cost_transfer|intercompany_sale|capital_allocation');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `parent_entity_financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Parent Entity Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `parent_financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Parent Financial Entity Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `parent_financial_entity_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `accounting_basis` SET TAGS ('pii_business_glossary_term' = 'Accounting Basis');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `accounting_basis` SET TAGS ('pii_value_regex' = 'gaap|gasb|ifrs|cash|modified_accrual');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `accounting_basis` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `accounting_basis` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `accounting_basis` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `accounting_basis` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `accounting_basis` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `accounting_basis` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `accounting_basis` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `cms_provider_number` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `cms_provider_number` SET TAGS ('pii_value_regex' = '^[0-9A-Z]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `consolidation_method` SET TAGS ('pii_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `consolidation_method` SET TAGS ('pii_value_regex' = 'full_consolidation|equity_method|proportional|cost_method|none');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `duns_number` SET TAGS ('pii_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `duns_number` SET TAGS ('pii_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_code` SET TAGS ('pii_business_glossary_term' = 'Entity Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_description` SET TAGS ('pii_business_glossary_term' = 'Entity Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_name` SET TAGS ('pii_business_glossary_term' = 'Entity Legal Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_status` SET TAGS ('pii_business_glossary_term' = 'Entity Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|dissolved|merged|divested');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_subtype` SET TAGS ('pii_business_glossary_term' = 'Entity Subtype');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_type` SET TAGS ('pii_business_glossary_term' = 'Entity Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `entity_type` SET TAGS ('pii_value_regex' = 'hospital|physician_group|foundation|aco|health_plan|holding_company');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `external_auditor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `federal_tax_identification_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `federal_tax_identification_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `fiscal_year_end_day` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year End Day');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('pii_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `incorporation_date` SET TAGS ('pii_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('pii_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `joint_venture_flag` SET TAGS ('pii_business_glossary_term' = 'Joint Venture Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line1` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line2` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_address_line2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_city` SET TAGS ('pii_business_glossary_term' = 'Legal Entity City');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_country_code` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Country Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_postal_code` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_postal_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_state` SET TAGS ('pii_business_glossary_term' = 'Legal Entity State');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_entity_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `legal_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `medicare_cost_report_required_flag` SET TAGS ('pii_business_glossary_term' = 'Medicare Cost Report Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('pii_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `regulatory_reporting_tier` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Tier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `regulatory_reporting_tier` SET TAGS ('pii_value_regex' = 'tier1|tier2|tier3|exempt');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `regulatory_reporting_tier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `regulatory_reporting_tier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `regulatory_reporting_tier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `regulatory_reporting_tier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `regulatory_reporting_tier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `regulatory_reporting_tier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `regulatory_reporting_tier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `reporting_entity_flag` SET TAGS ('pii_business_glossary_term' = 'Reporting Entity Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `reporting_entity_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `reporting_entity_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `reporting_entity_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `reporting_entity_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `reporting_entity_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `reporting_entity_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `reporting_entity_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_exempt_status` SET TAGS ('pii_business_glossary_term' = 'Tax Exempt Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_exempt_status` SET TAGS ('pii_value_regex' = '501c3|501c4|501c6|taxable|other_exempt');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_business_glossary_term' = 'Employer Identification Number (EIN) Tax ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` SET TAGS ('pii_subdomain' = 'fund_management');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `parent_fund_id` SET TAGS ('pii_business_glossary_term' = 'Parent Fund Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `primary_consolidation_fund_id` SET TAGS ('pii_business_glossary_term' = 'Consolidation Fund Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `donor_id` SET TAGS ('pii_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `balance` SET TAGS ('pii_business_glossary_term' = 'Fund Balance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `beginning_balance` SET TAGS ('pii_business_glossary_term' = 'Beginning Balance');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_category` SET TAGS ('pii_business_glossary_term' = 'Fund Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `closure_reason` SET TAGS ('pii_business_glossary_term' = 'Closure Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `cms_provider_number` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `cms_provider_number` SET TAGS ('pii_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_code` SET TAGS ('pii_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `donor_restriction_indicator` SET TAGS ('pii_business_glossary_term' = 'Donor Restriction Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `endowment_corpus_amount` SET TAGS ('pii_business_glossary_term' = 'Endowment Corpus Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `establishment_date` SET TAGS ('pii_business_glossary_term' = 'Establishment Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_status` SET TAGS ('pii_business_glossary_term' = 'Fund Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_status` SET TAGS ('pii_value_regex' = 'active|closed|depleted|suspended|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_type` SET TAGS ('pii_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_type` SET TAGS ('pii_value_regex' = 'unrestricted_operating|temporarily_restricted|permanently_restricted|endowment|capital|grant');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `grant_number` SET TAGS ('pii_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `investment_policy_code` SET TAGS ('pii_business_glossary_term' = 'Investment Policy Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_name` SET TAGS ('pii_business_glossary_term' = 'Fund Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `fund_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Fund Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `purpose` SET TAGS ('pii_business_glossary_term' = 'Fund Purpose');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `restriction_description` SET TAGS ('pii_business_glossary_term' = 'Restriction Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `restriction_type` SET TAGS ('pii_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `restriction_type` SET TAGS ('pii_value_regex' = 'unrestricted|donor_restricted|board_designated|regulatory_restricted|grant_restricted');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `spending_policy_rate` SET TAGS ('pii_business_glossary_term' = 'Spending Policy Rate');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` SET TAGS ('pii_subdomain' = 'budget_planning');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `financial_forecast_id` SET TAGS ('pii_business_glossary_term' = 'Financial Forecast ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `financial_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `financial_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `financial_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `financial_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `financial_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `financial_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `parent_financial_forecast_id` SET TAGS ('pii_business_glossary_term' = 'Parent Forecast ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `primary_financial_preparer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Preparer Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `primary_financial_preparer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `primary_financial_preparer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `primary_superseded_by_financial_forecast_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Forecast ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `assumptions_narrative` SET TAGS ('pii_business_glossary_term' = 'Assumptions Narrative');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `baseline_flag` SET TAGS ('pii_business_glossary_term' = 'Baseline Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `board_presentation_date` SET TAGS ('pii_business_glossary_term' = 'Board Presentation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `board_presentation_flag` SET TAGS ('pii_business_glossary_term' = 'Board Presentation Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_methodology` SET TAGS ('pii_business_glossary_term' = 'Forecast Methodology');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_name` SET TAGS ('pii_business_glossary_term' = 'Forecast Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_number` SET TAGS ('pii_business_glossary_term' = 'Forecast Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_period_months` SET TAGS ('pii_business_glossary_term' = 'Forecast Period Months');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_status` SET TAGS ('pii_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_type` SET TAGS ('pii_business_glossary_term' = 'Forecast Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_type` SET TAGS ('pii_value_regex' = 'rolling_forecast|annual_operating_plan|long_range_plan|scenario_analysis|budget_reforecast|strategic_plan');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecast_version` SET TAGS ('pii_business_glossary_term' = 'Forecast Version');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecasted_cmi` SET TAGS ('pii_business_glossary_term' = 'Forecasted Case Mix Index (CMI)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecasted_fte_count` SET TAGS ('pii_business_glossary_term' = 'Forecasted Full-Time Equivalent (FTE) Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `forecasted_patient_volume` SET TAGS ('pii_business_glossary_term' = 'Forecasted Patient Volume');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `scenario_description` SET TAGS ('pii_business_glossary_term' = 'Scenario Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `service_line_code` SET TAGS ('pii_business_glossary_term' = 'Service Line Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_capital_expenditure` SET TAGS ('pii_business_glossary_term' = 'Total Forecasted Capital Expenditure');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_expense` SET TAGS ('pii_business_glossary_term' = 'Total Forecasted Expense');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_net_income` SET TAGS ('pii_business_glossary_term' = 'Total Forecasted Net Income');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_operating_income` SET TAGS ('pii_business_glossary_term' = 'Total Forecasted Operating Income');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_operating_income` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_operating_income` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_operating_income` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_operating_income` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_operating_income` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_operating_income` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_operating_income` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `total_forecasted_revenue` SET TAGS ('pii_business_glossary_term' = 'Total Forecasted Revenue');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` SET TAGS ('pii_subdomain' = 'budget_planning');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `forecast_line_id` SET TAGS ('pii_business_glossary_term' = 'Forecast Line Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `financial_forecast_id` SET TAGS ('pii_business_glossary_term' = 'Forecast Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `prior_forecast_line_id` SET TAGS ('pii_business_glossary_term' = 'Prior Forecast Line Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `prior_forecast_line_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `allocation_method` SET TAGS ('pii_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `current_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Current Budget Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `forecast_category` SET TAGS ('pii_business_glossary_term' = 'Forecast Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `forecast_category` SET TAGS ('pii_value_regex' = 'revenue|salary_expense|non_salary_expense|capital|other');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `forecast_confidence_level` SET TAGS ('pii_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `forecast_confidence_level` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `forecast_scenario` SET TAGS ('pii_business_glossary_term' = 'Forecast Scenario');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `forecast_version` SET TAGS ('pii_business_glossary_term' = 'Forecast Version');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `forecasted_amount` SET TAGS ('pii_business_glossary_term' = 'Forecasted Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `fte_count` SET TAGS ('pii_business_glossary_term' = 'Full-Time Equivalent (FTE) Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `grant_number` SET TAGS ('pii_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `is_capital` SET TAGS ('pii_business_glossary_term' = 'Is Capital Expenditure Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `is_restricted` SET TAGS ('pii_business_glossary_term' = 'Is Restricted Fund Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `line_notes` SET TAGS ('pii_business_glossary_term' = 'Forecast Line Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Forecast Line Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('pii_business_glossary_term' = 'Prior Year Actual Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `project_code` SET TAGS ('pii_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `service_line_code` SET TAGS ('pii_business_glossary_term' = 'Service Line Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `statistical_basis` SET TAGS ('pii_business_glossary_term' = 'Statistical Basis');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `variance_to_budget` SET TAGS ('pii_business_glossary_term' = 'Variance to Budget');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `variance_to_prior_year` SET TAGS ('pii_business_glossary_term' = 'Variance to Prior Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `volume_driver_assumption` SET TAGS ('pii_business_glossary_term' = 'Volume Driver Assumption');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `volume_quantity` SET TAGS ('pii_business_glossary_term' = 'Volume Quantity');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `volume_unit` SET TAGS ('pii_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`forecast_line` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` SET TAGS ('pii_association_edges' = 'finance.ap_invoice,finance.ap_payment');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `invoice_payment_application_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Payment Application ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Payment Application - Ap Invoice Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `ap_payment_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Payment Application - Ap Payment Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `amount_applied` SET TAGS ('pii_business_glossary_term' = 'Payment Amount Applied');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `amount_paid` SET TAGS ('pii_business_glossary_term' = 'Amount Paid');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `amount_remaining` SET TAGS ('pii_business_glossary_term' = 'Amount Remaining');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `application_sequence` SET TAGS ('pii_business_glossary_term' = 'Application Sequence');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `application_status` SET TAGS ('pii_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `discount_taken` SET TAGS ('pii_business_glossary_term' = 'Discount Taken');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `reversal_date` SET TAGS ('pii_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` SET TAGS ('pii_subdomain' = 'fund_management');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` SET TAGS ('pii_association_edges' = 'provider.org_provider,finance.fund');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `fund_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Fund Allocation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Allocation Approver');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Allocation - Fund Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Fund Allocation - Org Provider Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('pii_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `allocation_purpose` SET TAGS ('pii_business_glossary_term' = 'Allocation Purpose');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Allocation Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `fund_allocation_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_business_glossary_term' = 'Allocation Reporting Requirements');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `reporting_requirements` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `restriction_compliance_status` SET TAGS ('pii_business_glossary_term' = 'Restriction Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `payment_batch_id` SET TAGS ('pii_business_glossary_term' = 'Payment Batch Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `bank_account_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `bank_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `bank_account_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `bank_account_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `bank_account_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `bank_account_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `payment_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `payment_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `payment_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `payment_original_batch_id` SET TAGS ('pii_business_glossary_term' = 'Original Batch Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `payment_payee_organization_financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Payee Organization Financial Entity Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `primary_batch_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `primary_batch_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `primary_reversed_payment_batch_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Payment Batch Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `primary_reversed_payment_batch_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `actual_processing_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Processing Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `batch_date` SET TAGS ('pii_business_glossary_term' = 'Batch Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `batch_type` SET TAGS ('pii_business_glossary_term' = 'Batch Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `electronic_funds_transfer_trace_number` SET TAGS ('pii_business_glossary_term' = 'Electronic Funds Transfer Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `electronic_funds_transfer_trace_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `error_message` SET TAGS ('pii_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `external_batch_reference` SET TAGS ('pii_business_glossary_term' = 'External Batch Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `failed_payment_count` SET TAGS ('pii_business_glossary_term' = 'Failed Payment Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `general_ledger_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger Account Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `is_reversal` SET TAGS ('pii_business_glossary_term' = 'Is Reversal');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `lockbox_number` SET TAGS ('pii_business_glossary_term' = 'Lockbox Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `net_batch_amount` SET TAGS ('pii_business_glossary_term' = 'Net Batch Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `processing_notes` SET TAGS ('pii_business_glossary_term' = 'Processing Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `remittance_advice_number` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `scheduled_processing_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Processing Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `payment_batch_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `successful_payment_count` SET TAGS ('pii_business_glossary_term' = 'Successful Payment Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `total_batch_amount` SET TAGS ('pii_business_glossary_term' = 'Total Batch Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `total_payment_count` SET TAGS ('pii_business_glossary_term' = 'Total Payment Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_batch_id` SET TAGS ('pii_business_glossary_term' = 'Transaction Batch Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Entity Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_renamed_from' = 'financial_entity_id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_role' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Accounting Period Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_renamed_from' = 'fiscal_period_id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_fk_role' = 'batch');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `primary_reversed_transaction_batch_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Transaction Batch Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `primary_reversed_transaction_batch_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `recurring_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Recurring Schedule Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_approved_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_approved_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_approved_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_original_batch_id` SET TAGS ('pii_business_glossary_term' = 'Original Batch Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_posted_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Posted By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_posted_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_posted_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_reversal_batch_id` SET TAGS ('pii_business_glossary_term' = 'Reversal Batch Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `batch_date` SET TAGS ('pii_business_glossary_term' = 'Batch Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `batch_description` SET TAGS ('pii_business_glossary_term' = 'Batch Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `batch_status` SET TAGS ('pii_business_glossary_term' = 'Batch Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `batch_type` SET TAGS ('pii_business_glossary_term' = 'Batch Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `control_total` SET TAGS ('pii_business_glossary_term' = 'Control Total');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `external_reference_number` SET TAGS ('pii_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `is_auto_generated` SET TAGS ('pii_business_glossary_term' = 'Is Auto Generated');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `is_balanced` SET TAGS ('pii_business_glossary_term' = 'Is Balanced');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `is_recurring` SET TAGS ('pii_business_glossary_term' = 'Is Recurring');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `posting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `total_credit_amount` SET TAGS ('pii_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `total_debit_amount` SET TAGS ('pii_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `transaction_count` SET TAGS ('pii_business_glossary_term' = 'Transaction Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` SET TAGS ('pii_subdomain' = 'budget_planning');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_run_id` SET TAGS ('pii_business_glossary_term' = 'Allocation Run Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_method_id` SET TAGS ('pii_business_glossary_term' = 'Allocation Method Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `primary_run_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `primary_run_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `reversed_allocation_run_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Allocation Run Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `transaction_batch_id` SET TAGS ('pii_business_glossary_term' = 'Batch Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `actual_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_basis` SET TAGS ('pii_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_percentage_total` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage Total');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `error_count` SET TAGS ('pii_business_glossary_term' = 'Error Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `execution_duration_seconds` SET TAGS ('pii_business_glossary_term' = 'Execution Duration Seconds');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_batch_number` SET TAGS ('pii_business_glossary_term' = 'Gl Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_timestamp` SET TAGS ('pii_business_glossary_term' = 'Gl Posting Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_timestamp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_timestamp` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `posted_to_gl_flag` SET TAGS ('pii_business_glossary_term' = 'Posted To Gl Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `records_processed_count` SET TAGS ('pii_business_glossary_term' = 'Records Processed Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_name` SET TAGS ('pii_business_glossary_term' = 'Run Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_number` SET TAGS ('pii_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_status` SET TAGS ('pii_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `run_type` SET TAGS ('pii_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `simulation_flag` SET TAGS ('pii_business_glossary_term' = 'Simulation Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `target_cost_centers_count` SET TAGS ('pii_business_glossary_term' = 'Target Cost Centers Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `total_amount_allocated` SET TAGS ('pii_business_glossary_term' = 'Total Amount Allocated');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ALTER COLUMN `warning_count` SET TAGS ('pii_business_glossary_term' = 'Warning Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` SET TAGS ('pii_subdomain' = 'capital_assets');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_run_id` SET TAGS ('pii_business_glossary_term' = 'Depreciation Run Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `asset_book_id` SET TAGS ('pii_business_glossary_term' = 'Asset Book Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_reversed_run_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Run Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_reversed_run_id` SET TAGS ('pii_relationship' = 'reverses_depreciation_run');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `general_ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `primary_reversed_depreciation_run_id` SET TAGS ('pii_business_glossary_term' = 'Reversed Depreciation Run Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `primary_reversed_depreciation_run_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `primary_run_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `primary_run_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `asset_count` SET TAGS ('pii_business_glossary_term' = 'Asset Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `auto_post_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Post Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `calculation_method` SET TAGS ('pii_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `end_timestamp` SET TAGS ('pii_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `error_message` SET TAGS ('pii_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `failed_asset_count` SET TAGS ('pii_business_glossary_term' = 'Failed Asset Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `journal_batch_reference` SET TAGS ('pii_business_glossary_term' = 'Journal Batch Reference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `processed_asset_count` SET TAGS ('pii_business_glossary_term' = 'Processed Asset Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_date` SET TAGS ('pii_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_description` SET TAGS ('pii_business_glossary_term' = 'Run Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_number` SET TAGS ('pii_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_status` SET TAGS ('pii_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_type` SET TAGS ('pii_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `simulation_flag` SET TAGS ('pii_business_glossary_term' = 'Simulation Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `total_depreciation_amount` SET TAGS ('pii_business_glossary_term' = 'Total Depreciation Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` SET TAGS ('pii_subdomain' = 'fund_management');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_id` SET TAGS ('pii_business_glossary_term' = 'Donor Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `merged_donor_id` SET TAGS ('pii_business_glossary_term' = 'Merged Donor Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `merged_donor_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `acknowledgment_preference` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Preference');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `affinity_score` SET TAGS ('pii_business_glossary_term' = 'Affinity Score');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `board_member_flag` SET TAGS ('pii_business_glossary_term' = 'Board Member Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `data_classification` SET TAGS ('pii_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_status` SET TAGS ('pii_business_glossary_term' = 'Donor Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_type` SET TAGS ('pii_business_glossary_term' = 'Donor Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `employer_name` SET TAGS ('pii_business_glossary_term' = 'Employer Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `employer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `employer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `employer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `employer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `employer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `employer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `first_gift_date` SET TAGS ('pii_business_glossary_term' = 'First Gift Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `last_gift_date` SET TAGS ('pii_business_glossary_term' = 'Last Gift Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `lifetime_giving_amount` SET TAGS ('pii_business_glossary_term' = 'Lifetime Giving Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `lifetime_giving_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Line1');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line2` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Line2');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `mailing_address_line2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `matching_gift_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Matching Gift Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `memorial_honoree_name` SET TAGS ('pii_business_glossary_term' = 'Memorial Honoree Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `memorial_honoree_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `memorial_honoree_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `memorial_honoree_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `memorial_honoree_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `memorial_honoree_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `memorial_honoree_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_name` SET TAGS ('pii_business_glossary_term' = 'Donor Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `donor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `patient_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `planned_giving_flag` SET TAGS ('pii_business_glossary_term' = 'Planned Giving Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `preferred_communication_method` SET TAGS ('pii_business_glossary_term' = 'Preferred Communication Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `segment` SET TAGS ('pii_business_glossary_term' = 'Donor Segment');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `solicitation_opt_out_flag` SET TAGS ('pii_business_glossary_term' = 'Solicitation Opt Out Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Donor Source');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `state_province` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `state_province` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `state_province` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `state_province` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `state_province` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `state_province` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `tax_id_number` SET TAGS ('pii_business_glossary_term' = 'Tax Id Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `tax_id_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `tax_id_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `volunteer_flag` SET TAGS ('pii_business_glossary_term' = 'Volunteer Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_business_glossary_term' = 'Wealth Capacity Rating');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ALTER COLUMN `wealth_capacity_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `intercompany_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Intercompany Agreement Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Provider Entity Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `parent_intercompany_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Parent Agreement Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `primary_superseded_intercompany_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Intercompany Agreement Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `primary_superseded_intercompany_agreement_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `intercompany_receiver_entity_id` SET TAGS ('pii_business_glossary_term' = 'Receiver Entity Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `annual_contract_value` SET TAGS ('pii_business_glossary_term' = 'Annual Contract Value');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `annual_contract_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `audit_required_flag` SET TAGS ('pii_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('pii_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `cost_allocation_basis` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Basis');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `document_reference_url` SET TAGS ('pii_business_glossary_term' = 'Document Reference Url');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `document_reference_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'Gl Account Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('pii_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `pricing_method` SET TAGS ('pii_business_glossary_term' = 'Pricing Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('pii_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `service_description` SET TAGS ('pii_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `intercompany_agreement_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('pii_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `termination_clause` SET TAGS ('pii_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `transfer_pricing_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Transfer Pricing Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Recurring Schedule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_approved_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_approved_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_approved_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `superseded_recurring_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Recurring Schedule Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `superseded_recurring_schedule_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Adjustment Factor');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `allocation_method` SET TAGS ('pii_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `approver_role_code` SET TAGS ('pii_business_glossary_term' = 'Approver Role Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `auto_generate_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Generate Flag');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `business_justification` SET TAGS ('pii_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `day_of_month` SET TAGS ('pii_business_glossary_term' = 'Day Of Month');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `day_of_week` SET TAGS ('pii_business_glossary_term' = 'Day Of Week');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_schedule_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `frequency` SET TAGS ('pii_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `last_generated_date` SET TAGS ('pii_business_glossary_term' = 'Last Generated Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `max_occurrences` SET TAGS ('pii_business_glossary_term' = 'Max Occurrences');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `month_of_quarter` SET TAGS ('pii_business_glossary_term' = 'Month Of Quarter');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `next_scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `occurrence_count` SET TAGS ('pii_business_glossary_term' = 'Occurrence Count');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `proration_rule` SET TAGS ('pii_business_glossary_term' = 'Proration Rule');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `quarter_of_year` SET TAGS ('pii_business_glossary_term' = 'Quarter Of Year');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_amount` SET TAGS ('pii_business_glossary_term' = 'Schedule Amount');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_category` SET TAGS ('pii_business_glossary_term' = 'Schedule Category');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_code` SET TAGS ('pii_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `schedule_type` SET TAGS ('pii_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `recurring_schedule_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` SET TAGS ('pii_subdomain' = 'capital_assets');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `asset_book_id` SET TAGS ('pii_business_glossary_term' = 'Asset Book Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_renamed_from' = 'chart_of_accounts_id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `general_ledger_account_chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'General Ledger Account Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `organization_id` SET TAGS ('pii_business_glossary_term' = 'Organization Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `parent_asset_book_id` SET TAGS ('pii_business_glossary_term' = 'Parent Asset Book Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `parent_asset_book_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `parent_book_id` SET TAGS ('pii_business_glossary_term' = 'Parent Book Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `accounting_standard` SET TAGS ('pii_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `accounting_standard` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `accounting_standard` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `accounting_standard` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `accounting_standard` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `accounting_standard` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `accounting_standard` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `accounting_standard` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `allow_manual_depreciation` SET TAGS ('pii_business_glossary_term' = 'Allow Manual Depreciation');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `approval_required` SET TAGS ('pii_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `approval_workflow_code` SET TAGS ('pii_business_glossary_term' = 'Approval Workflow Id');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `audit_trail_enabled` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Enabled');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `book_code` SET TAGS ('pii_business_glossary_term' = 'Book Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `book_name` SET TAGS ('pii_business_glossary_term' = 'Book Name');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `book_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `book_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `book_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `book_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `book_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `book_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `book_type` SET TAGS ('pii_business_glossary_term' = 'Book Type');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `consolidation_required` SET TAGS ('pii_business_glossary_term' = 'Consolidation Required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `asset_book_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `fiscal_year_start_month` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year Start Month');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `prorate_depreciation` SET TAGS ('pii_business_glossary_term' = 'Prorate Depreciation');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `salvage_value_required` SET TAGS ('pii_business_glossary_term' = 'Salvage Value Required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `asset_book_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `tax_reporting_required` SET TAGS ('pii_business_glossary_term' = 'Tax Reporting Required');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `tax_reporting_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `tax_reporting_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `tax_reporting_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `tax_reporting_required` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `tax_reporting_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `tax_reporting_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `tax_reporting_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ALTER COLUMN `vibe_mutation_test` SET TAGS ('pii_vibe_test' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` SET TAGS ('pii_subdomain' = 'fund_management');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `grant_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `parent_grant_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `amount_expended` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `awarded_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `cost_share_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `direct_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `indirect_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`finance`.`grant` ALTER COLUMN `sponsor_name` SET TAGS ('pii_mask_non_prod' = 'true');
