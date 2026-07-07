-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`finance` COMMENT 'Authoritative domain for general ledger (GL), accounts payable (AP), accounts receivable (AR), fixed assets (FA), cost center management, budgeting, P&L reporting, EBITDA tracking, CapEx/OpEx classification, revenue management, royalty income accounting, and multi-entity consolidation via SAP S/4HANA. GAAP/IFRS compliant financial statements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Primary key',
    `chart_of_accounts_id` BIGINT COMMENT 'FK to chart of accounts',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `parent_account_gl_account_id` BIGINT COMMENT 'Self-referencing FK to parent account',
    `account_currency` STRING COMMENT 'Currency code for the account',
    `account_description` STRING COMMENT 'Detailed description of the account',
    `account_group` STRING COMMENT 'Grouping classification for the account',
    `account_name` STRING COMMENT 'Display name of the GL account',
    `account_number` STRING COMMENT 'Account number identifier',
    `account_status` STRING COMMENT 'Active/inactive/blocked status',
    `account_type` STRING COMMENT 'Asset, liability, equity, revenue, expense',
    `alternate_account_number` STRING COMMENT 'Alternate numbering for reporting',
    `balance_sheet_classification` STRING COMMENT 'Balance sheet line classification',
    `cash_flow_classification` STRING COMMENT 'Cash flow statement classification',
    `consolidation_account_number` STRING COMMENT 'Account number used in consolidation',
    `cost_element_category` STRING COMMENT 'Cost element category for controlling',
    `cost_element_indicator` BOOLEAN COMMENT 'Whether account is a cost element',
    `created_by_user` STRING COMMENT 'User who created the record',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `field_status_group` STRING COMMENT 'Field status group for posting control',
    `financial_statement_category` STRING COMMENT 'Financial statement line item category',
    `functional_area` STRING COMMENT 'Functional area assignment',
    `gaap_account_indicator` BOOLEAN COMMENT 'Whether account is GAAP relevant',
    `ifrs_account_indicator` BOOLEAN COMMENT 'Whether account is IFRS relevant',
    `intercompany_indicator` BOOLEAN COMMENT 'Whether account is used for intercompany',
    `last_modified_by_user` STRING COMMENT 'User who last modified',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `line_item_display_indicator` BOOLEAN COMMENT 'Whether line items are displayed',
    `notes` STRING COMMENT 'Free-text notes',
    `open_item_management_indicator` BOOLEAN COMMENT 'Whether open item management is active',
    `planning_level` STRING COMMENT 'Planning level for budgeting',
    `posting_allowed_indicator` BOOLEAN COMMENT 'Whether direct posting is allowed',
    `profit_loss_classification` STRING COMMENT 'P&L line classification',
    `reconciliation_account_indicator` BOOLEAN COMMENT 'Whether account is a reconciliation account',
    `segment_reporting_indicator` BOOLEAN COMMENT 'Whether used in segment reporting',
    `sort_key` STRING COMMENT 'Sort key for display ordering',
    `statistical_account_indicator` BOOLEAN COMMENT 'Whether account is statistical only',
    `tax_category` STRING COMMENT 'Tax category assignment',
    `valid_from_date` DATE COMMENT 'Validity start date',
    `valid_to_date` DATE COMMENT 'Validity end date',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger account master record defining the chart of accounts structure for financial reporting and posting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Primary key',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee',
    `hierarchy_node_id` BIGINT COMMENT 'FK to hierarchy node',
    `site_id` BIGINT COMMENT 'FK to real estate site',
    `territory_id` BIGINT COMMENT 'FK to franchise territory',
    `brand_code` STRING COMMENT 'Brand identifier',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget amount',
    `budget_year` STRING COMMENT 'Budget fiscal year',
    `business_area_code` STRING COMMENT 'A standardized code representing the business area classification for this cost center',
    `capex_eligible_flag` BOOLEAN COMMENT 'Whether eligible for capex',
    `cost_center_category` STRING COMMENT 'Category classification',
    `cost_center_code` STRING COMMENT 'Cost center code identifier',
    `cogs_percent_target` DECIMAL(18,2) COMMENT 'Target COGS percentage',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this cost center',
    `controlling_area_code` STRING COMMENT 'Controlling area',
    `cost_center_status` STRING COMMENT 'Active/inactive status',
    `cost_center_type` STRING COMMENT 'Type classification',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this cost center',
    `created_by_user` STRING COMMENT 'The created by user attribute value for this cost center record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this cost center',
    `cost_center_description` STRING COMMENT 'Detailed description',
    `drive_thru_lanes` STRING COMMENT 'Number of drive-thru lanes',
    `format_code` STRING COMMENT 'Restaurant format code',
    `franchise_flag` BOOLEAN COMMENT 'Whether franchised location',
    `functional_area_code` STRING COMMENT 'A standardized code representing the functional area classification for this cost center',
    `labor_percent_target` DECIMAL(18,2) COMMENT 'Target labor percentage',
    `last_modified_by_user` STRING COMMENT 'The last modified by user attribute value for this cost center record in the finance domain',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `cost_center_name` STRING COMMENT 'Display name',
    `notes` STRING COMMENT 'Free-text notes',
    `opex_allocation_method` STRING COMMENT 'Operating expense allocation method',
    `parent_cost_center_code` STRING COMMENT 'A standardized code representing the parent cost center classification for this cost center',
    `profit_center_code` STRING COMMENT 'Associated profit center code',
    `region_code` STRING COMMENT 'A standardized code representing the region classification for this cost center',
    `seating_capacity` STRING COMMENT 'Restaurant seating capacity',
    `square_footage` STRING COMMENT 'Restaurant square footage',
    `valid_from_date` DATE COMMENT 'Validity start date',
    `valid_to_date` DATE COMMENT 'Validity end date',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Cost center master data representing organizational units that incur costs, mapped to restaurant locations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Primary key',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee',
    `hierarchy_node_id` BIGINT COMMENT 'FK to hierarchy node',
    `parent_profit_center_id` BIGINT COMMENT 'Self-referencing FK to parent',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `aov_target_amount` DECIMAL(18,2) COMMENT 'Average order value target',
    `brand_code` STRING COMMENT 'A standardized code representing the brand classification for this profit center',
    `business_area_code` STRING COMMENT 'A standardized code representing the business area classification for this profit center',
    `profit_center_category` STRING COMMENT 'Category classification',
    `closure_date` DATE COMMENT 'Closure date if applicable',
    `closure_reason` STRING COMMENT 'Reason for closure',
    `profit_center_code` STRING COMMENT 'Profit center code identifier',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this profit center',
    `consolidation_unit_code` STRING COMMENT 'A standardized code representing the consolidation unit classification for this profit center',
    `controlling_area_code` STRING COMMENT 'A standardized code representing the controlling area classification for this profit center',
    `cost_center_group_code` STRING COMMENT 'A standardized code representing the cost center group classification for this profit center',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this profit center',
    `ebitda_target_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for ebitda target in this profit center',
    `geographic_region_code` STRING COMMENT 'A standardized code representing the geographic region classification for this profit center',
    `last_modified_by_user` STRING COMMENT 'The last modified by user attribute value for this profit center record in the finance domain',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `lock_indicator` BOOLEAN COMMENT 'Whether profit center is locked',
    `marketing_fund_rate_percent` DECIMAL(18,2) COMMENT 'Marketing fund contribution rate',
    `profit_center_name` STRING COMMENT 'Display name',
    `notes` STRING COMMENT 'Free-text notes',
    `opening_date` DATE COMMENT 'The date and time when the opening event occurred for this profit center',
    `ownership_model` STRING COMMENT 'Franchise/corporate ownership model',
    `profit_center_status` STRING COMMENT 'Active/inactive status',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Royalty rate percentage',
    `segment_reporting_flag` BOOLEAN COMMENT 'Whether used in segment reporting',
    `segment_type` STRING COMMENT 'The classification type for segment in this profit center',
    `short_name` STRING COMMENT 'Short display name',
    `sss_eligible_flag` BOOLEAN COMMENT 'Same-store-sales eligible flag',
    `tax_jurisdiction_code` STRING COMMENT 'A standardized code representing the tax jurisdiction classification for this profit center',
    `valid_from_date` DATE COMMENT 'Validity start date',
    `valid_to_date` DATE COMMENT 'Validity end date',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Profit center master data representing organizational units responsible for revenue and profit, typically mapped to restaurant units.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key',
    `chart_of_accounts_id` BIGINT COMMENT 'FK to chart of accounts',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'FK to parent entity',
    `primary_ultimate_parent_entity_legal_entity_id` BIGINT COMMENT 'FK to ultimate parent',
    `accounting_standard` STRING COMMENT 'GAAP/IFRS accounting standard',
    `address_line_1` STRING COMMENT 'The address line 1 attribute value for this legal entity record in the finance domain',
    `address_line_2` STRING COMMENT 'The address line 2 attribute value for this legal entity record in the finance domain',
    `city` STRING COMMENT 'The city attribute value for this legal entity record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this legal entity',
    `consolidation_group_code` STRING COMMENT 'A standardized code representing the consolidation group classification for this legal entity',
    `consolidation_method` STRING COMMENT 'The consolidation method attribute value for this legal entity record in the finance domain',
    `controlling_area` STRING COMMENT 'The controlling area attribute value for this legal entity record in the finance domain',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this legal entity',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `credit_control_area` STRING COMMENT 'The credit control area attribute value for this legal entity record in the finance domain',
    `dissolution_date` DATE COMMENT 'The date and time when the dissolution event occurred for this legal entity',
    `duns_number` STRING COMMENT 'The duns number attribute value for this legal entity record in the finance domain',
    `effective_from_date` DATE COMMENT 'The date and time when the effective from event occurred for this legal entity',
    `effective_to_date` DATE COMMENT 'The date and time when the effective to event occurred for this legal entity',
    `entity_status` STRING COMMENT 'Active/inactive/dissolved status',
    `entity_type` STRING COMMENT 'Corporation/LLC/partnership type',
    `fiscal_year_end_month` STRING COMMENT 'The fiscal year end month attribute value for this legal entity record in the finance domain',
    `fiscal_year_variant` STRING COMMENT 'The fiscal year variant attribute value for this legal entity record in the finance domain',
    `incorporation_date` DECIMAL(18,2) COMMENT 'Date of incorporation',
    `intercompany_clearing_flag` BOOLEAN COMMENT 'Whether intercompany clearing is enabled',
    `jurisdiction_country` STRING COMMENT 'The jurisdiction country attribute value for this legal entity record in the finance domain',
    `jurisdiction_state_province` STRING COMMENT 'Jurisdiction state/province',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `legal_name` STRING COMMENT 'Legal entity name',
    `lei_code` STRING COMMENT 'Legal Entity Identifier code',
    `local_currency_code` STRING COMMENT 'A standardized code representing the local currency classification for this legal entity',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The ownership percentage attribute value for this legal entity record in the finance domain',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification for this legal entity',
    `primary_contact_email` STRING COMMENT 'The primary contact email attribute value for this legal entity record in the finance domain',
    `primary_contact_name` STRING COMMENT 'The display name or label for the primary contact in this legal entity',
    `primary_contact_phone` STRING COMMENT 'The primary contact phone attribute value for this legal entity record in the finance domain',
    `profit_center_required_flag` BOOLEAN COMMENT 'Whether profit center is required',
    `registration_number` DECIMAL(18,2) COMMENT 'The registration number attribute value for this legal entity record in the finance domain',
    `reporting_currency_code` STRING COMMENT 'A standardized code representing the reporting currency classification for this legal entity',
    `segment_reporting_required_flag` BOOLEAN COMMENT 'Whether segment reporting is required',
    `short_name` STRING COMMENT 'The display name or label for the short in this legal entity',
    `state_province` STRING COMMENT 'State/province',
    `tax_identification_number` STRING COMMENT 'The tax identification number attribute value for this legal entity record in the finance domain',
    `vat_registration_number` DECIMAL(18,2) COMMENT 'The vat registration number attribute value for this legal entity record in the finance domain',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Legal entity master data representing corporate entities for financial consolidation and regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the approver employee associated with this journal entry record',
    `approver_user_employee_id` BIGINT COMMENT 'FK to approver employee',
    `financial_period_id` BIGINT COMMENT 'FK to financial period',
    `journal_employee_id` BIGINT COMMENT 'Unique identifier referencing the journal employee associated with this journal entry record',
    `journal_last_modified_user_employee_id` BIGINT COMMENT 'Unique identifier referencing the journal last modified user employee associated with this journal entry record',
    `ledger_id` BIGINT COMMENT 'FK to ledger',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `primary_journal_employee_id` BIGINT COMMENT 'Unique identifier referencing the primary journal employee associated with this journal entry record',
    `adjustment_period_indicator` BOOLEAN COMMENT 'Whether this is an adjustment period entry',
    `approval_timestamp` TIMESTAMP COMMENT 'The approval timestamp attribute value for this journal entry record in the finance domain',
    `audit_class` STRING COMMENT 'Audit classification',
    `baseline_payment_date` DATE COMMENT 'The date and time when the baseline payment event occurred for this journal entry',
    `batch_input_session` STRING COMMENT 'Batch input session reference',
    `clearing_date` DATE COMMENT 'The date and time when the clearing event occurred for this journal entry',
    `clearing_document_number` STRING COMMENT 'The clearing document number attribute value for this journal entry record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this journal entry',
    `consolidation_transaction_type` STRING COMMENT 'The classification type for consolidation transaction in this journal entry',
    `currency_code` STRING COMMENT 'Document currency code',
    `document_date` DATE COMMENT 'The date and time when the document event occurred for this journal entry',
    `document_header_text` STRING COMMENT 'The document header text attribute value for this journal entry record in the finance domain',
    `document_number` STRING COMMENT 'The document number attribute value for this journal entry record in the finance domain',
    `document_type` STRING COMMENT 'Document type code',
    `entry_date` DATE COMMENT 'The date and time when the entry event occurred for this journal entry',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate attribute value for this journal entry record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this journal entry record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this journal entry record in the finance domain',
    `intercompany_indicator` BOOLEAN COMMENT 'Whether intercompany transaction',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `ledger_group` STRING COMMENT 'The ledger group attribute value for this journal entry record in the finance domain',
    `line_item_count` STRING COMMENT 'Number of line items',
    `local_currency_code` STRING COMMENT 'A standardized code representing the local currency classification for this journal entry',
    `net_due_date` DATE COMMENT 'The date and time when the net due event occurred for this journal entry',
    `parked_indicator` BOOLEAN COMMENT 'Whether document is parked',
    `payment_terms_code` STRING COMMENT 'A standardized code representing the payment terms classification for this journal entry',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this journal entry',
    `posting_key` STRING COMMENT 'The posting key attribute value for this journal entry record in the finance domain',
    `posting_timestamp` TIMESTAMP COMMENT 'The posting timestamp attribute value for this journal entry record in the finance domain',
    `reference_document_number` STRING COMMENT 'The reference document number attribute value for this journal entry record in the finance domain',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this is a reversal',
    `reversal_reason_code` STRING COMMENT 'A standardized code representing the reversal reason classification for this journal entry',
    `reversed_document_number` STRING COMMENT 'The reversed document number attribute value for this journal entry record in the finance domain',
    `source_system_code` STRING COMMENT 'A standardized code representing the source system classification for this journal entry',
    `tax_reporting_date` DATE COMMENT 'The date and time when the tax reporting event occurred for this journal entry',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for total credit in this journal entry',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for total debit in this journal entry',
    `trading_partner_company_code` STRING COMMENT 'A standardized code representing the trading partner company classification for this journal entry',
    `transaction_code` STRING COMMENT 'A standardized code representing the transaction classification for this journal entry',
    `workflow_status` STRING COMMENT 'The current status of the workflow for this journal entry',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Journal entry header representing a complete accounting document posted to the general ledger.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `fixed_asset_id` BIGINT COMMENT 'FK to fixed asset',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `profile_id` BIGINT COMMENT 'Unique identifier for the journal customer profile associated with this journal entry line',
    `journal_entry_id` BIGINT COMMENT 'FK to journal entry header',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `journal_vendor_procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the journal vendor procurement supplier associated with this journal entry line',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `amount_document_currency` DECIMAL(18,2) COMMENT 'Amount in document currency',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Amount in local currency',
    `assignment_field` STRING COMMENT 'The assignment field attribute value for this journal entry line record in the finance domain',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms',
    `business_area_code` STRING COMMENT 'A standardized code representing the business area classification for this journal entry line',
    `clearing_date` DATE COMMENT 'The date and time when the clearing event occurred for this journal entry line',
    `clearing_document_number` STRING COMMENT 'The clearing document number attribute value for this journal entry line record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this journal entry line',
    `debit_credit_indicator` STRING COMMENT 'Debit or credit indicator',
    `document_currency_code` STRING COMMENT 'A standardized code representing the document currency classification for this journal entry line',
    `document_date` DATE COMMENT 'The date and time when the document event occurred for this journal entry line',
    `due_date` DATE COMMENT 'The date and time when the due event occurred for this journal entry line',
    `entry_date` DATE COMMENT 'The date and time when the entry event occurred for this journal entry line',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate attribute value for this journal entry line record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this journal entry line record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this journal entry line record in the finance domain',
    `functional_area_code` STRING COMMENT 'A standardized code representing the functional area classification for this journal entry line',
    `line_item_text` STRING COMMENT 'The line item text attribute value for this journal entry line record in the finance domain',
    `line_number` STRING COMMENT 'The line number attribute value for this journal entry line record in the finance domain',
    `local_currency_code` STRING COMMENT 'A standardized code representing the local currency classification for this journal entry line',
    `payment_terms_code` STRING COMMENT 'A standardized code representing the payment terms classification for this journal entry line',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this journal entry line',
    `posting_key` STRING COMMENT 'The posting key attribute value for this journal entry line record in the finance domain',
    `reference_document_number` STRING COMMENT 'The reference document number attribute value for this journal entry line record in the finance domain',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this is a reversal line',
    `reversed_document_number` STRING COMMENT 'The reversed document number attribute value for this journal entry line record in the finance domain',
    `special_gl_indicator` STRING COMMENT 'The special gl indicator attribute value for this journal entry line record in the finance domain',
    `tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for tax in this journal entry line',
    `tax_code` STRING COMMENT 'A standardized code representing the tax classification for this journal entry line',
    `trading_partner_code` STRING COMMENT 'A standardized code representing the trading partner classification for this journal entry line',
    `transaction_code` STRING COMMENT 'A standardized code representing the transaction classification for this journal entry line',
    `user_name` STRING COMMENT 'The display name or label for the user in this journal entry line',
    `value_date` DATE COMMENT 'The date and time when the value event occurred for this journal entry line',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual line item within a journal entry representing a debit or credit posting to a GL account.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the ap created by user employee associated with this ap invoice record',
    `ap_employee_id` BIGINT COMMENT 'Unique identifier referencing the ap employee associated with this ap invoice record',
    `ap_modified_by_user_employee_id` BIGINT COMMENT 'Unique identifier referencing the ap modified by user employee associated with this ap invoice record',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `unit_id` BIGINT COMMENT 'Unique identifier for the ap restaurant location unit associated with this ap invoice',
    `ap_unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `ap_vendor_procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the ap vendor procurement supplier associated with this ap invoice',
    `approver_employee_id` BIGINT COMMENT 'FK to approver',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign associated with this ap invoice',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `approval_date` DATE COMMENT 'The date and time when the approval event occurred for this ap invoice',
    `approval_status` STRING COMMENT 'The current status of the approval for this ap invoice',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this ap invoice',
    `cost_center_code` STRING COMMENT 'A standardized code representing the cost center classification for this ap invoice',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this ap invoice',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount in this ap invoice',
    `due_date` DATE COMMENT 'Payment due date',
    `dunning_level` STRING COMMENT 'The dunning level attribute value for this ap invoice record in the finance domain',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate attribute value for this ap invoice record in the finance domain',
    `expense_category` STRING COMMENT 'The expense category attribute value for this ap invoice record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this ap invoice record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this ap invoice record in the finance domain',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification for this ap invoice',
    `goods_receipt_number` STRING COMMENT 'The goods receipt number attribute value for this ap invoice record in the finance domain',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross invoice amount',
    `invoice_date` DATE COMMENT 'The date and time when the invoice event occurred for this ap invoice',
    `invoice_description` STRING COMMENT 'The invoice description attribute value for this ap invoice record in the finance domain',
    `invoice_number` STRING COMMENT 'The invoice number attribute value for this ap invoice record in the finance domain',
    `invoice_status` STRING COMMENT 'The current status of the invoice for this ap invoice',
    `invoice_type` STRING COMMENT 'The classification type for invoice in this ap invoice',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Amount in local currency',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `net_amount` DECIMAL(18,2) COMMENT 'Net invoice amount',
    `payment_block_indicator` BOOLEAN COMMENT 'Whether payment is blocked',
    `payment_date` DATE COMMENT 'The date and time when the payment event occurred for this ap invoice',
    `payment_method` STRING COMMENT 'The payment method attribute value for this ap invoice record in the finance domain',
    `payment_reference_number` STRING COMMENT 'The payment reference number attribute value for this ap invoice record in the finance domain',
    `payment_terms_code` STRING COMMENT 'A standardized code representing the payment terms classification for this ap invoice',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this ap invoice',
    `purchase_order_number` STRING COMMENT 'The purchase order number attribute value for this ap invoice record in the finance domain',
    `reference_document_number` STRING COMMENT 'The reference document number attribute value for this ap invoice record in the finance domain',
    `tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for tax in this ap invoice',
    `three_way_match_status` STRING COMMENT 'Three-way match status',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for withholding tax in this ap invoice',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable invoice header representing vendor invoices received for goods and services.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` (
    `ap_invoice_line_id` BIGINT COMMENT 'Primary key',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `ap_unit_id` BIGINT COMMENT 'Unique identifier for the ap unit associated with this ap invoice line',
    `contract_id` BIGINT COMMENT 'Unique identifier for the contract associated with this ap invoice line',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the employee associated with this ap invoice line record',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt associated with this ap invoice line',
    `ingredient_id` BIGINT COMMENT 'FK to ingredient',
    `ap_invoice_id` BIGINT COMMENT 'FK to AP invoice header',
    `procurement_purchase_order_id` BIGINT COMMENT 'Unique identifier for the procurement purchase order associated with this ap invoice line',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the procurement supplier associated with this ap invoice line',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `stock_item_id` BIGINT COMMENT 'Unique identifier for the stock item associated with this ap invoice line',
    `approval_status` STRING COMMENT 'The current status of the approval for this ap invoice line',
    `approved_timestamp` TIMESTAMP COMMENT 'The approved timestamp attribute value for this ap invoice line record in the finance domain',
    `asset_number` STRING COMMENT 'The asset number attribute value for this ap invoice line record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this ap invoice line',
    `delivery_date` DATE COMMENT 'The date and time when the delivery event occurred for this ap invoice line',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount in this ap invoice line',
    `expense_category` STRING COMMENT 'The expense category attribute value for this ap invoice line record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this ap invoice line record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this ap invoice line record in the finance domain',
    `goods_receipt_line_number` STRING COMMENT 'The goods receipt line number attribute value for this ap invoice line record in the finance domain',
    `internal_order_number` STRING COMMENT 'The internal order number attribute value for this ap invoice line record in the finance domain',
    `invoice_date` DATE COMMENT 'The date and time when the invoice event occurred for this ap invoice line',
    `is_capex` BOOLEAN COMMENT 'Whether capital expenditure',
    `is_cogs` BOOLEAN COMMENT 'Whether cost of goods sold',
    `line_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for line in this ap invoice line',
    `line_number` STRING COMMENT 'The line number attribute value for this ap invoice line record in the finance domain',
    `line_type` STRING COMMENT 'The classification type for line in this ap invoice line',
    `match_status` STRING COMMENT 'The current status of the match for this ap invoice line',
    `material_code` STRING COMMENT 'A standardized code representing the material classification for this ap invoice line',
    `material_description` STRING COMMENT 'The material description attribute value for this ap invoice line record in the finance domain',
    `modified_by` STRING COMMENT 'The modified by attribute value for this ap invoice line record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this ap invoice line',
    `payment_terms` STRING COMMENT 'The payment terms attribute value for this ap invoice line record in the finance domain',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this ap invoice line',
    `purchase_order_line_number` STRING COMMENT 'The purchase order line number attribute value for this ap invoice line record in the finance domain',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity attribute value for this ap invoice line record in the finance domain',
    `tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for tax in this ap invoice line',
    `tax_code` STRING COMMENT 'A standardized code representing the tax classification for this ap invoice line',
    `total_line_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for total line in this ap invoice line',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute value for this ap invoice line record in the finance domain',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price attribute value for this ap invoice line record in the finance domain',
    `variance_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for variance in this ap invoice line',
    `variance_reason` STRING COMMENT 'The variance reason attribute value for this ap invoice line record in the finance domain',
    `wbs_element` STRING COMMENT 'The wbs element attribute value for this ap invoice line record in the finance domain',
    `created_by` STRING COMMENT 'The created by attribute value for this ap invoice line record in the finance domain',
    CONSTRAINT pk_ap_invoice_line PRIMARY KEY(`ap_invoice_line_id`)
) COMMENT 'Line item detail for accounts payable invoices specifying individual charges, quantities, and account assignments.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Primary key',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the employee associated with this ap payment record',
    `payment_run_id` BIGINT COMMENT 'FK to payment run',
    `bank_name` STRING COMMENT 'The display name or label for the bank in this ap payment',
    `business_area` STRING COMMENT 'The business area attribute value for this ap payment record in the finance domain',
    `clearing_date` DATE COMMENT 'The date and time when the clearing event occurred for this ap payment',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this ap payment',
    `cost_center` STRING COMMENT 'The cost center attribute value for this ap payment record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount taken in this ap payment',
    `document_currency` STRING COMMENT 'The document currency attribute value for this ap payment record in the finance domain',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate attribute value for this ap payment record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this ap payment record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this ap payment record in the finance domain',
    `gl_account` STRING COMMENT 'The gl account attribute value for this ap payment record in the finance domain',
    `invoice_count` STRING COMMENT 'Number of invoices paid',
    `local_currency` STRING COMMENT 'The local currency attribute value for this ap payment record in the finance domain',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Amount in local currency',
    `modified_by` STRING COMMENT 'The modified by attribute value for this ap payment record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `payment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for payment in this ap payment',
    `payment_block_reason` STRING COMMENT 'The payment block reason attribute value for this ap payment record in the finance domain',
    `payment_date` DATE COMMENT 'The date and time when the payment event occurred for this ap payment',
    `payment_description` STRING COMMENT 'The payment description attribute value for this ap payment record in the finance domain',
    `payment_document_number` STRING COMMENT 'The payment document number attribute value for this ap payment record in the finance domain',
    `payment_method` STRING COMMENT 'The payment method attribute value for this ap payment record in the finance domain',
    `payment_priority` STRING COMMENT 'The payment priority attribute value for this ap payment record in the finance domain',
    `payment_processor` STRING COMMENT 'The payment processor attribute value for this ap payment record in the finance domain',
    `payment_reference_number` STRING COMMENT 'The payment reference number attribute value for this ap payment record in the finance domain',
    `payment_status` STRING COMMENT 'The current status of the payment for this ap payment',
    `payment_terms` STRING COMMENT 'The payment terms attribute value for this ap payment record in the finance domain',
    `payment_type` STRING COMMENT 'The classification type for payment in this ap payment',
    `profit_center` STRING COMMENT 'The profit center attribute value for this ap payment record in the finance domain',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation for this ap payment',
    `remittance_email` STRING COMMENT 'Remittance email address',
    `value_date` DATE COMMENT 'The date and time when the value event occurred for this ap payment',
    `vendor_account_number` STRING COMMENT 'The vendor account number attribute value for this ap payment record in the finance domain',
    `vendor_name` STRING COMMENT 'The display name or label for the vendor in this ap payment',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for withholding tax in this ap payment',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment record representing disbursements to vendors/suppliers.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'Unique identifier for the ar customer profile associated with this ar invoice',
    `unit_id` BIGINT COMMENT 'Unique identifier for the ar location unit associated with this ar invoice',
    `ar_profile_id` BIGINT COMMENT 'Unique identifier for the ar profile associated with this ar invoice',
    `ar_unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for adjustment in this ar invoice',
    `billing_address_line1` STRING COMMENT 'The billing address line1 attribute value for this ar invoice record in the finance domain',
    `billing_address_line2` STRING COMMENT 'The billing address line2 attribute value for this ar invoice record in the finance domain',
    `billing_city` STRING COMMENT 'The billing city attribute value for this ar invoice record in the finance domain',
    `billing_contact_name` STRING COMMENT 'The display name or label for the billing contact in this ar invoice',
    `billing_country_code` STRING COMMENT 'A standardized code representing the billing country classification for this ar invoice',
    `billing_email` STRING COMMENT 'The billing email attribute value for this ar invoice record in the finance domain',
    `billing_period_end_date` DATE COMMENT 'The date and time when the billing period end event occurred for this ar invoice',
    `billing_period_start_date` DATE COMMENT 'The date and time when the billing period start event occurred for this ar invoice',
    `billing_postal_code` STRING COMMENT 'A standardized code representing the billing postal classification for this ar invoice',
    `billing_state_province` STRING COMMENT 'The billing state province attribute value for this ar invoice record in the finance domain',
    `business_area` STRING COMMENT 'The business area attribute value for this ar invoice record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this ar invoice',
    `created_by_user` STRING COMMENT 'The created by user attribute value for this ar invoice record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this ar invoice',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount in this ar invoice',
    `due_date` DATE COMMENT 'The date and time when the due event occurred for this ar invoice',
    `dunning_level` STRING COMMENT 'The dunning level attribute value for this ar invoice record in the finance domain',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate attribute value for this ar invoice record in the finance domain',
    `gross_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for gross in this ar invoice',
    `invoice_date` DATE COMMENT 'The date and time when the invoice event occurred for this ar invoice',
    `invoice_number` STRING COMMENT 'The invoice number attribute value for this ar invoice record in the finance domain',
    `invoice_status` STRING COMMENT 'The current status of the invoice for this ar invoice',
    `invoice_type` STRING COMMENT 'The classification type for invoice in this ar invoice',
    `last_dunning_date` DATE COMMENT 'The date and time when the last dunning event occurred for this ar invoice',
    `modified_by_user` STRING COMMENT 'The modified by user attribute value for this ar invoice record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `net_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for net in this ar invoice',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this ar invoice',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'The outstanding balance attribute value for this ar invoice record in the finance domain',
    `payment_method` STRING COMMENT 'The payment method attribute value for this ar invoice record in the finance domain',
    `payment_reference` STRING COMMENT 'The payment reference attribute value for this ar invoice record in the finance domain',
    `payment_terms_code` STRING COMMENT 'A standardized code representing the payment terms classification for this ar invoice',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this ar invoice',
    `revenue_recognition_date` DATE COMMENT 'The date and time when the revenue recognition event occurred for this ar invoice',
    `tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for tax in this ar invoice',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable invoice representing amounts owed by franchisees or customers to the organization.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` (
    `ar_payment_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `profile_id` BIGINT COMMENT 'Unique identifier for the customer profile associated with this ar payment',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `ach_trace_number` STRING COMMENT 'The ach trace number attribute value for this ar payment record in the finance domain',
    `applied_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for applied in this ar payment',
    `check_number` STRING COMMENT 'The check number attribute value for this ar payment record in the finance domain',
    `clearing_date` DATE COMMENT 'The date and time when the clearing event occurred for this ar payment',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this ar payment',
    `created_by_user` STRING COMMENT 'The created by user attribute value for this ar payment record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this ar payment',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount taken in this ar payment',
    `dso_impact_days` STRING COMMENT 'The dso impact days attribute value for this ar payment record in the finance domain',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate attribute value for this ar payment record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this ar payment record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this ar payment record in the finance domain',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for functional currency in this ar payment',
    `modified_by_user` STRING COMMENT 'The modified by user attribute value for this ar payment record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this ar payment',
    `payment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for payment in this ar payment',
    `payment_document_number` STRING COMMENT 'The payment document number attribute value for this ar payment record in the finance domain',
    `payment_method` STRING COMMENT 'The payment method attribute value for this ar payment record in the finance domain',
    `payment_processor` STRING COMMENT 'The payment processor attribute value for this ar payment record in the finance domain',
    `payment_status` STRING COMMENT 'The current status of the payment for this ar payment',
    `payment_type` STRING COMMENT 'The classification type for payment in this ar payment',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this ar payment',
    `receipt_date` DATE COMMENT 'The date and time when the receipt event occurred for this ar payment',
    `reference_number` STRING COMMENT 'The reference number attribute value for this ar payment record in the finance domain',
    `reversal_date` DATE COMMENT 'The date and time when the reversal event occurred for this ar payment',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this is a reversal',
    `reversal_reason_code` STRING COMMENT 'A standardized code representing the reversal reason classification for this ar payment',
    `transaction_reference` STRING COMMENT 'The transaction reference attribute value for this ar payment record in the finance domain',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for unapplied in this ar payment',
    `wire_confirmation_number` STRING COMMENT 'The wire confirmation number attribute value for this ar payment record in the finance domain',
    CONSTRAINT pk_ar_payment PRIMARY KEY(`ar_payment_id`)
) COMMENT 'Accounts receivable payment record representing cash receipts from franchisees or customers.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Primary key',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The accumulated depreciation attribute value for this fixed asset record in the finance domain',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'The acquisition cost attribute value for this fixed asset record in the finance domain',
    `acquisition_date` DATE COMMENT 'The date and time when the acquisition event occurred for this fixed asset',
    `asset_class` STRING COMMENT 'The asset class attribute value for this fixed asset record in the finance domain',
    `asset_description` STRING COMMENT 'The asset description attribute value for this fixed asset record in the finance domain',
    `asset_number` STRING COMMENT 'The asset number attribute value for this fixed asset record in the finance domain',
    `asset_status` STRING COMMENT 'The current status of the asset for this fixed asset',
    `asset_subclass` STRING COMMENT 'The asset subclass attribute value for this fixed asset record in the finance domain',
    `capex_project_code` STRING COMMENT 'A standardized code representing the capex project classification for this fixed asset',
    `cost_center_code` STRING COMMENT 'A standardized code representing the cost center classification for this fixed asset',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this fixed asset',
    `depreciation_method` STRING COMMENT 'The depreciation method attribute value for this fixed asset record in the finance domain',
    `disposal_date` DATE COMMENT 'The date and time when the disposal event occurred for this fixed asset',
    `disposal_method` STRING COMMENT 'The disposal method attribute value for this fixed asset record in the finance domain',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'The disposal proceeds attribute value for this fixed asset record in the finance domain',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification for this fixed asset',
    `impairment_indicator` BOOLEAN COMMENT 'Whether impaired',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Impairment loss amount',
    `insurance_policy_number` STRING COMMENT 'The insurance policy number attribute value for this fixed asset record in the finance domain',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `last_physical_inventory_date` DATE COMMENT 'The date and time when the last physical inventory event occurred for this fixed asset',
    `lease_indicator` BOOLEAN COMMENT 'Whether leased asset',
    `manufacturer_name` STRING COMMENT 'The display name or label for the manufacturer in this fixed asset',
    `model_number` STRING COMMENT 'The model number attribute value for this fixed asset record in the finance domain',
    `net_book_value` DECIMAL(18,2) COMMENT 'The net book value attribute value for this fixed asset record in the finance domain',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this fixed asset',
    `purchase_order_number` STRING COMMENT 'The purchase order number attribute value for this fixed asset record in the finance domain',
    `salvage_value` DECIMAL(18,2) COMMENT 'The salvage value attribute value for this fixed asset record in the finance domain',
    `serial_number` STRING COMMENT 'The serial number attribute value for this fixed asset record in the finance domain',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Useful life in years',
    `warranty_expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the warranty expiration event occurred for this fixed asset',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master record representing capitalized equipment, furniture, and improvements at restaurant locations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` (
    `asset_depreciation_id` BIGINT COMMENT 'Primary key',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `fixed_asset_id` BIGINT COMMENT 'FK to fixed asset',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The accumulated depreciation attribute value for this asset depreciation record in the finance domain',
    `acquisition_value` DECIMAL(18,2) COMMENT 'The acquisition value attribute value for this asset depreciation record in the finance domain',
    `asset_acquisition_date` DATE COMMENT 'The date and time when the asset acquisition event occurred for this asset depreciation',
    `asset_class` STRING COMMENT 'The asset class attribute value for this asset depreciation record in the finance domain',
    `asset_description` STRING COMMENT 'The asset description attribute value for this asset depreciation record in the finance domain',
    `asset_retirement_date` DATE COMMENT 'The date and time when the asset retirement event occurred for this asset depreciation',
    `asset_serial_number` STRING COMMENT 'The asset serial number attribute value for this asset depreciation record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this asset depreciation',
    `cost_center` STRING COMMENT 'The cost center attribute value for this asset depreciation record in the finance domain',
    `created_by_user` STRING COMMENT 'The created by user attribute value for this asset depreciation record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this asset depreciation',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Depreciation amount for period',
    `depreciation_area` STRING COMMENT 'The depreciation area attribute value for this asset depreciation record in the finance domain',
    `depreciation_key` STRING COMMENT 'The depreciation key attribute value for this asset depreciation record in the finance domain',
    `depreciation_method` STRING COMMENT 'The depreciation method attribute value for this asset depreciation record in the finance domain',
    `depreciation_run_date` DATE COMMENT 'The date and time when the depreciation run event occurred for this asset depreciation',
    `depreciation_status` STRING COMMENT 'The current status of the depreciation for this asset depreciation',
    `document_number` STRING COMMENT 'The document number attribute value for this asset depreciation record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this asset depreciation record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this asset depreciation record in the finance domain',
    `gl_account_accumulated_depreciation` STRING COMMENT 'GL account for accumulated depreciation',
    `gl_account_depreciation_expense` DECIMAL(18,2) COMMENT 'GL account depreciation expense amount',
    `impairment_indicator` BOOLEAN COMMENT 'Whether impairment recorded',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for impairment loss in this asset depreciation',
    `modified_by_user` STRING COMMENT 'The modified by user attribute value for this asset depreciation record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `net_book_value` DECIMAL(18,2) COMMENT 'The net book value attribute value for this asset depreciation record in the finance domain',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this asset depreciation',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Remaining useful life in years',
    `reversal_document_number` STRING COMMENT 'The reversal document number attribute value for this asset depreciation record in the finance domain',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this is a reversal',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Total useful life in years',
    CONSTRAINT pk_asset_depreciation PRIMARY KEY(`asset_depreciation_id`)
) COMMENT 'Periodic depreciation calculation and posting record for fixed assets.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Primary key',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `budget_unit_id` BIGINT COMMENT 'Unique identifier for the budget unit associated with this budget',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign associated with this budget',
    `employee_id` BIGINT COMMENT 'FK to budget owner employee',
    `amount` DECIMAL(18,2) COMMENT 'Total budget amount',
    `approval_date` DATE COMMENT 'The date and time when the approval event occurred for this budget',
    `approving_authority` STRING COMMENT 'The approving authority attribute value for this budget record in the finance domain',
    `baseline_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for baseline in this budget',
    `brand_code` STRING COMMENT 'A standardized code representing the brand classification for this budget',
    `budget_status` STRING COMMENT 'The current status of the budget for this budget',
    `budget_type` STRING COMMENT 'The classification type for budget in this budget',
    `budget_category` STRING COMMENT 'The budget category attribute value for this budget record in the finance domain',
    `consolidation_entity` STRING COMMENT 'The consolidation entity attribute value for this budget record in the finance domain',
    `cost_center_code` STRING COMMENT 'A standardized code representing the cost center classification for this budget',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this budget',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this budget',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this budget',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this budget record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this budget record in the finance domain',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification for this budget',
    `modified_by` STRING COMMENT 'The modified by attribute value for this budget record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this budget',
    `nro_flag` BOOLEAN COMMENT 'Boolean indicator flag for nro flag status in this budget',
    `nro_project_code` STRING COMMENT 'A standardized code representing the nro project classification for this budget',
    `ownership_type` STRING COMMENT 'The classification type for ownership in this budget',
    `profit_center_code` STRING COMMENT 'A standardized code representing the profit center classification for this budget',
    `region_code` STRING COMMENT 'A standardized code representing the region classification for this budget',
    `subcategory` STRING COMMENT 'The subcategory attribute value for this budget record in the finance domain',
    `variance_threshold_pct` DECIMAL(18,2) COMMENT 'Variance threshold percentage',
    `version_code` STRING COMMENT 'A standardized code representing the version classification for this budget',
    `created_by` STRING COMMENT 'The created by attribute value for this budget record in the finance domain',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Budget header representing an approved financial plan for a specific period, unit, or cost center.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Primary key',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `budget_unit_id` BIGINT COMMENT 'Unique identifier for the budget unit associated with this budget line',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign associated with this budget line',
    `contract_line_id` BIGINT COMMENT 'Unique identifier for the contract line associated with this budget line',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the employee associated with this budget line record',
    `budget_id` BIGINT COMMENT 'FK to budget header',
    `allocation_driver` STRING COMMENT 'The allocation driver attribute value for this budget line record in the finance domain',
    `allocation_method` STRING COMMENT 'The allocation method attribute value for this budget line record in the finance domain',
    `approved_timestamp` TIMESTAMP COMMENT 'The approved timestamp attribute value for this budget line record in the finance domain',
    `baseline_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for baseline in this budget line',
    `budget_category` STRING COMMENT 'The budget category attribute value for this budget line record in the finance domain',
    `budget_percentage_target` DECIMAL(18,2) COMMENT 'The budget percentage target attribute value for this budget line record in the finance domain',
    `budget_status` STRING COMMENT 'The current status of the budget for this budget line',
    `budget_subcategory` STRING COMMENT 'The budget subcategory attribute value for this budget line record in the finance domain',
    `budget_version` STRING COMMENT 'The budget version attribute value for this budget line record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this budget line',
    `cost_center` STRING COMMENT 'The cost center attribute value for this budget line record in the finance domain',
    `created_by_user` STRING COMMENT 'The created by user attribute value for this budget line record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this budget line',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this budget line',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this budget line',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this budget line',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this budget line record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this budget line record in the finance domain',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification for this budget line',
    `modified_by_user` STRING COMMENT 'The modified by user attribute value for this budget line record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this budget line',
    `planned_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for planned in this budget line',
    `profit_center` STRING COMMENT 'Profit center code',
    `quantity_target` DECIMAL(18,2) COMMENT 'The quantity target attribute value for this budget line record in the finance domain',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute value for this budget line record in the finance domain',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for variance threshold in this budget line',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'The variance threshold percentage attribute value for this budget line record in the finance domain',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Budget line item representing a specific allocation within a budget for a GL account, period, or category.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` (
    `royalty_accrual_id` BIGINT COMMENT 'Primary key',
    `agreement_id` BIGINT COMMENT 'FK to franchise agreement',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee',
    `original_accrual_royalty_accrual_id` BIGINT COMMENT 'Unique identifier for the original accrual royalty accrual associated with this royalty accrual',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `gl_account_id` BIGINT COMMENT 'FK to GL account for royalty revenue',
    `accrual_period_end_date` DATE COMMENT 'The date and time when the accrual period end event occurred for this royalty accrual',
    `accrual_period_start_date` DATE COMMENT 'The date and time when the accrual period start event occurred for this royalty accrual',
    `accrued_royalty_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for accrued royalty in this royalty accrual',
    `adjustment_indicator` BOOLEAN COMMENT 'Whether this is an adjustment',
    `adjustment_reason` STRING COMMENT 'The adjustment reason attribute value for this royalty accrual record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this royalty accrual',
    `cost_center` STRING COMMENT 'The cost center attribute value for this royalty accrual record in the finance domain',
    `created_by_user` STRING COMMENT 'The created by user attribute value for this royalty accrual record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this royalty accrual',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this royalty accrual record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this royalty accrual record in the finance domain',
    `franconnect_calculation_reference` STRING COMMENT 'The franconnect calculation reference attribute value for this royalty accrual record in the finance domain',
    `gl_document_number` STRING COMMENT 'The gl document number attribute value for this royalty accrual record in the finance domain',
    `gl_posting_date` DATE COMMENT 'The date and time when the gl posting event occurred for this royalty accrual',
    `marketing_fund_contribution` DECIMAL(18,2) COMMENT 'Marketing fund contribution amount',
    `marketing_fund_rate_percent` DECIMAL(18,2) COMMENT 'The marketing fund rate percent attribute value for this royalty accrual record in the finance domain',
    `modified_by_user` STRING COMMENT 'The modified by user attribute value for this royalty accrual record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this royalty accrual',
    `profit_center` STRING COMMENT 'The profit center attribute value for this royalty accrual record in the finance domain',
    `recognition_date` DATE COMMENT 'The date and time when the recognition event occurred for this royalty accrual',
    `recognition_status` STRING COMMENT 'The current status of the recognition for this royalty accrual',
    `reversal_date` DATE COMMENT 'The date and time when the reversal event occurred for this royalty accrual',
    `reversal_document_number` STRING COMMENT 'The reversal document number attribute value for this royalty accrual record in the finance domain',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this is a reversal',
    `royalty_base_net_sales` DECIMAL(18,2) COMMENT 'The royalty base net sales attribute value for this royalty accrual record in the finance domain',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The royalty rate percent attribute value for this royalty accrual record in the finance domain',
    `technology_fee` DECIMAL(18,2) COMMENT 'Technology fee amount',
    `technology_fee_rate_percent` DECIMAL(18,2) COMMENT 'The technology fee rate percent attribute value for this royalty accrual record in the finance domain',
    `total_accrued_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for total accrued in this royalty accrual',
    CONSTRAINT pk_royalty_accrual PRIMARY KEY(`royalty_accrual_id`)
) COMMENT 'Royalty accrual record representing periodic royalty revenue recognition from franchisees.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Primary key',
    `legal_entity_id` BIGINT COMMENT 'FK to receiving legal entity',
    `gl_account_id` BIGINT COMMENT 'FK to sending GL account',
    `sending_legal_entity_id` BIGINT COMMENT 'FK to sending legal entity',
    `cost_center_code` STRING COMMENT 'A standardized code representing the cost center classification for this intercompany transaction',
    `created_by_user` STRING COMMENT 'The created by user attribute value for this intercompany transaction record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `document_date` DATE COMMENT 'The date and time when the document event occurred for this intercompany transaction',
    `document_number` STRING COMMENT 'The document number attribute value for this intercompany transaction record in the finance domain',
    `due_date` DATE COMMENT 'The date and time when the due event occurred for this intercompany transaction',
    `elimination_date` DATE COMMENT 'The date and time when the elimination event occurred for this intercompany transaction',
    `elimination_flag` BOOLEAN COMMENT 'Whether eliminated',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate attribute value for this intercompany transaction record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this intercompany transaction record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this intercompany transaction record in the finance domain',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'Amount in group currency',
    `group_currency_code` STRING COMMENT 'A standardized code representing the group currency classification for this intercompany transaction',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Amount in local currency',
    `local_currency_code` STRING COMMENT 'A standardized code representing the local currency classification for this intercompany transaction',
    `modified_by_user` STRING COMMENT 'The modified by user attribute value for this intercompany transaction record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `netting_indicator` BOOLEAN COMMENT 'Whether netting applies',
    `payment_terms` STRING COMMENT 'The payment terms attribute value for this intercompany transaction record in the finance domain',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this intercompany transaction',
    `profit_center_code` STRING COMMENT 'A standardized code representing the profit center classification for this intercompany transaction',
    `reconciliation_period` STRING COMMENT 'The reconciliation period attribute value for this intercompany transaction record in the finance domain',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation for this intercompany transaction',
    `reference_document_number` STRING COMMENT 'The reference document number attribute value for this intercompany transaction record in the finance domain',
    `reversal_document_number` STRING COMMENT 'The reversal document number attribute value for this intercompany transaction record in the finance domain',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this is a reversal',
    `reversal_reason_code` STRING COMMENT 'A standardized code representing the reversal reason classification for this intercompany transaction',
    `settlement_date` DATE COMMENT 'The date and time when the settlement event occurred for this intercompany transaction',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for transaction in this intercompany transaction',
    `transaction_currency_code` STRING COMMENT 'A standardized code representing the transaction currency classification for this intercompany transaction',
    `transaction_description` STRING COMMENT 'The transaction description attribute value for this intercompany transaction record in the finance domain',
    `transaction_status` STRING COMMENT 'The current status of the transaction for this intercompany transaction',
    `transaction_type` STRING COMMENT 'The classification type for transaction in this intercompany transaction',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany transaction record for transactions between legal entities requiring elimination in consolidation.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` (
    `tax_posting_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `franchisee_id` BIGINT COMMENT 'Unique identifier for the franchisee associated with this tax posting',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the tax procurement supplier associated with this tax posting',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `tax_unit_id` BIGINT COMMENT 'Unique identifier for the tax unit associated with this tax posting',
    `tax_vendor_procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the tax vendor procurement supplier associated with this tax posting',
    `adjustment_reason` STRING COMMENT 'The adjustment reason attribute value for this tax posting record in the finance domain',
    `audit_flag` BOOLEAN COMMENT 'Whether flagged for audit',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this tax posting',
    `created_by_user` STRING COMMENT 'The created by user attribute value for this tax posting record in the finance domain',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this tax posting',
    `document_date` DATE COMMENT 'The date and time when the document event occurred for this tax posting',
    `document_line_item` STRING COMMENT 'The document line item attribute value for this tax posting record in the finance domain',
    `document_number` STRING COMMENT 'The document number attribute value for this tax posting record in the finance domain',
    `exemption_certificate_number` STRING COMMENT 'The exemption certificate number attribute value for this tax posting record in the finance domain',
    `exemption_reason` STRING COMMENT 'The exemption reason attribute value for this tax posting record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this tax posting record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this tax posting record in the finance domain',
    `invoice_number` STRING COMMENT 'The invoice number attribute value for this tax posting record in the finance domain',
    `modified_by_user` STRING COMMENT 'The modified by user attribute value for this tax posting record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this tax posting',
    `payment_date` DATE COMMENT 'The date and time when the payment event occurred for this tax posting',
    `payment_reference_number` STRING COMMENT 'The payment reference number attribute value for this tax posting record in the finance domain',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this tax posting',
    `purchase_order_number` STRING COMMENT 'The purchase order number attribute value for this tax posting record in the finance domain',
    `reporting_period` STRING COMMENT 'The reporting period attribute value for this tax posting record in the finance domain',
    `reversal_document_number` STRING COMMENT 'The reversal document number attribute value for this tax posting record in the finance domain',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this is a reversal',
    `tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for tax in this tax posting',
    `tax_authority_name` STRING COMMENT 'The display name or label for the tax authority in this tax posting',
    `tax_code` STRING COMMENT 'A standardized code representing the tax classification for this tax posting',
    `tax_direction` STRING COMMENT 'Input/output tax direction',
    `tax_filing_status` STRING COMMENT 'The current status of the tax filing for this tax posting',
    `tax_jurisdiction_code` STRING COMMENT 'A standardized code representing the tax jurisdiction classification for this tax posting',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percent attribute value for this tax posting record in the finance domain',
    `tax_type` STRING COMMENT 'The classification type for tax in this tax posting',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for taxable base in this tax posting',
    CONSTRAINT pk_tax_posting PRIMARY KEY(`tax_posting_id`)
) COMMENT 'Tax posting record representing sales tax, use tax, or VAT postings associated with transactions.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`period_close` (
    `period_close_id` BIGINT COMMENT 'Primary key',
    `financial_period_id` BIGINT COMMENT 'FK to financial period',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `period_sign_off_user_employee_id` BIGINT COMMENT 'Unique identifier referencing the period sign off user employee associated with this period close record',
    `accrual_posting_status` STRING COMMENT 'The current status of the accrual posting for this period close',
    `actual_close_date` DATE COMMENT 'The date and time when the actual close event occurred for this period close',
    `adjustment_entry_count` STRING COMMENT 'The count or quantity of adjustment entry items in this period close',
    `ap_reconciliation_status` STRING COMMENT 'The current status of the ap reconciliation for this period close',
    `ar_reconciliation_status` STRING COMMENT 'The current status of the ar reconciliation for this period close',
    `audit_readiness_flag` BOOLEAN COMMENT 'Boolean indicator flag for audit readiness flag status in this period close',
    `bank_reconciliation_status` STRING COMMENT 'The current status of the bank reconciliation for this period close',
    `close_completed_timestamp` TIMESTAMP COMMENT 'The close completed timestamp attribute value for this period close record in the finance domain',
    `close_duration_hours` DECIMAL(18,2) COMMENT 'Close duration in hours',
    `close_initiated_timestamp` TIMESTAMP COMMENT 'The close initiated timestamp attribute value for this period close record in the finance domain',
    `close_phase` STRING COMMENT 'Current close phase',
    `close_status` STRING COMMENT 'The current status of the close for this period close',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this period close',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `depreciation_run_date` DATE COMMENT 'The date and time when the depreciation run event occurred for this period close',
    `depreciation_run_status` STRING COMMENT 'The current status of the depreciation run for this period close',
    `exception_count` STRING COMMENT 'Number of exceptions',
    `financial_statement_status` STRING COMMENT 'The current status of the financial statement for this period close',
    `gl_account_reconciliation_status` STRING COMMENT 'The current status of the gl account reconciliation for this period close',
    `intercompany_reconciliation_status` STRING COMMENT 'The current status of the intercompany reconciliation for this period close',
    `inventory_valuation_status` STRING COMMENT 'The current status of the inventory valuation for this period close',
    `marketing_fund_accrual_status` STRING COMMENT 'The current status of the marketing fund accrual for this period close',
    `modified_by_user` STRING COMMENT 'The modified by user attribute value for this period close record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this period close',
    `period_type` STRING COMMENT 'Period type (monthly, quarterly, annual)',
    `reopen_authorized_by` STRING COMMENT 'The reopen authorized by attribute value for this period close record in the finance domain',
    `reopen_reason` STRING COMMENT 'The reopen reason attribute value for this period close record in the finance domain',
    `reopen_timestamp` TIMESTAMP COMMENT 'The reopen timestamp attribute value for this period close record in the finance domain',
    `responsible_controller_email` STRING COMMENT 'The responsible controller email attribute value for this period close record in the finance domain',
    CONSTRAINT pk_period_close PRIMARY KEY(`period_close_id`)
) COMMENT 'Period close record tracking the financial close process for each accounting period.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Primary key',
    `allocation_rule_id` BIGINT COMMENT 'FK to allocation rule',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the primary receiver cost center associated with this cost allocation',
    `source_cost_center_id` BIGINT COMMENT 'FK to source cost center',
    `target_cost_center_id` BIGINT COMMENT 'FK to target cost center',
    `allocation_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for allocation in this cost allocation',
    `allocation_basis` STRING COMMENT 'Allocation basis (revenue, headcount, sqft)',
    `allocation_date` DATE COMMENT 'The date and time when the allocation event occurred for this cost allocation',
    `allocation_method` STRING COMMENT 'The allocation method attribute value for this cost allocation record in the finance domain',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage attribute value for this cost allocation record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this cost allocation',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this cost allocation',
    `cycle_name` STRING COMMENT 'The display name or label for the cycle in this cost allocation',
    `document_number` STRING COMMENT 'The document number attribute value for this cost allocation record in the finance domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this cost allocation record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this cost allocation record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this cost allocation',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this cost allocation',
    `reversal_indicator` BOOLEAN COMMENT 'Whether this is a reversal',
    `sender_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for sender in this cost allocation',
    `statistical_key_figure` STRING COMMENT 'The statistical key figure attribute value for this cost allocation record in the finance domain',
    `cost_allocation_status` STRING COMMENT 'Allocation status',
    `total_receiver_units` DECIMAL(18,2) COMMENT 'The total receiver units attribute value for this cost allocation record in the finance domain',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Cost allocation record representing the distribution of shared costs across cost centers or profit centers.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`capex_project` (
    `capex_project_id` BIGINT COMMENT 'Primary key',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `capex_unit_id` BIGINT COMMENT 'Unique identifier for the capex unit associated with this capex project',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `employee_id` BIGINT COMMENT 'FK to project manager',
    `actual_completion_date` DATE COMMENT 'The date and time when the actual completion event occurred for this capex project',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cost attribute value for this capex project record in the finance domain',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for actual spend in this capex project',
    `approval_date` DATE COMMENT 'The date and time when the approval event occurred for this capex project',
    `approved_budget` DECIMAL(18,2) COMMENT 'The approved budget attribute value for this capex project record in the finance domain',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for approved budget in this capex project',
    `budget_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for budget in this capex project',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this capex project',
    `completion_date` DATE COMMENT 'The date and time when the completion event occurred for this capex project',
    `cost_center_code` STRING COMMENT 'A standardized code representing the cost center classification for this capex project',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this capex project',
    `expected_roi_percent` DECIMAL(18,2) COMMENT 'The expected roi percent attribute value for this capex project record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this capex project',
    `payback_period_months` STRING COMMENT 'The payback period months attribute value for this capex project record in the finance domain',
    `planned_completion_date` DATE COMMENT 'The date and time when the planned completion event occurred for this capex project',
    `planned_start_date` DATE COMMENT 'The date and time when the planned start event occurred for this capex project',
    `project_category` STRING COMMENT 'The project category attribute value for this capex project record in the finance domain',
    `project_code` STRING COMMENT 'A standardized code representing the project classification for this capex project',
    `project_description` STRING COMMENT 'The project description attribute value for this capex project record in the finance domain',
    `project_name` STRING COMMENT 'The display name or label for the project in this capex project',
    `project_status` STRING COMMENT 'The current status of the project for this capex project',
    `project_type` STRING COMMENT 'Project type (NRO, remodel, equipment)',
    `roi_percent` DECIMAL(18,2) COMMENT 'Return on investment percent',
    `start_date` DATE COMMENT 'The date and time when the start event occurred for this capex project',
    `variance_amount` DECIMAL(18,2) COMMENT 'Budget variance amount',
    `wbs_element` STRING COMMENT 'The wbs element attribute value for this capex project record in the finance domain',
    CONSTRAINT pk_capex_project PRIMARY KEY(`capex_project_id`)
) COMMENT 'Capital expenditure project tracking investments in new restaurant builds, remodels, and equipment.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Primary key',
    `house_bank_id` BIGINT COMMENT 'FK to house bank',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `account_holder_name` STRING COMMENT 'The display name or label for the account holder in this bank account',
    `account_number` STRING COMMENT 'Bank account number',
    `account_status` STRING COMMENT 'The current status of the account for this bank account',
    `account_type` STRING COMMENT 'The classification type for account in this bank account',
    `bank_name` STRING COMMENT 'The display name or label for the bank in this bank account',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this bank account',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this bank account',
    `current_balance` DECIMAL(18,2) COMMENT 'The current balance attribute value for this bank account record in the finance domain',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification for this bank account',
    `iban` STRING COMMENT 'The iban attribute value for this bank account record in the finance domain',
    `last_reconciled_date` DATE COMMENT 'The date and time when the last reconciled event occurred for this bank account',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `bank_account_name` STRING COMMENT 'The display name or label for the bank account in this bank account',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this bank account',
    `opening_date` DATE COMMENT 'Account opening date',
    `purpose` STRING COMMENT 'The purpose attribute value for this bank account record in the finance domain',
    `routing_number` STRING COMMENT 'The routing number attribute value for this bank account record in the finance domain',
    `swift_code` STRING COMMENT 'A standardized code representing the swift classification for this bank account',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Bank account master data representing corporate bank accounts used for payments and receipts.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` (
    `bank_statement_line_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `bank_statement_id` BIGINT COMMENT 'FK to bank statement',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the gl account associated with this bank statement line',
    `pos_settlement_batch_id` BIGINT COMMENT 'Unique identifier for the pos settlement batch associated with this bank statement line',
    `amount` DECIMAL(18,2) COMMENT 'Transaction amount',
    `bank_reference` STRING COMMENT 'The bank reference attribute value for this bank statement line record in the finance domain',
    `business_transaction_code` STRING COMMENT 'A standardized code representing the business transaction classification for this bank statement line',
    `counterparty_account` STRING COMMENT 'The counterparty account attribute value for this bank statement line record in the finance domain',
    `counterparty_name` STRING COMMENT 'The display name or label for the counterparty in this bank statement line',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `credit_debit_indicator` STRING COMMENT 'The credit debit indicator attribute value for this bank statement line record in the finance domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this bank statement line',
    `debit_credit_indicator` STRING COMMENT 'Debit or credit',
    `bank_statement_line_description` STRING COMMENT 'The bank statement line description attribute value for this bank statement line record in the finance domain',
    `line_number` STRING COMMENT 'The line number attribute value for this bank statement line record in the finance domain',
    `matched_document_number` STRING COMMENT 'The matched document number attribute value for this bank statement line record in the finance domain',
    `matched_flag` BOOLEAN COMMENT 'Whether matched to GL',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this bank statement line',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation for this bank statement line',
    `reference_number` STRING COMMENT 'The reference number attribute value for this bank statement line record in the finance domain',
    `transaction_code` STRING COMMENT 'A standardized code representing the transaction classification for this bank statement line',
    `transaction_date` DATE COMMENT 'The date and time when the transaction event occurred for this bank statement line',
    `transaction_description` STRING COMMENT 'The transaction description attribute value for this bank statement line record in the finance domain',
    `value_date` DATE COMMENT 'The date and time when the value event occurred for this bank statement line',
    CONSTRAINT pk_bank_statement_line PRIMARY KEY(`bank_statement_line_id`)
) COMMENT 'Individual line item on a bank statement representing a single transaction.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` (
    `lease_liability_id` BIGINT COMMENT 'Primary key',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `lease_id` BIGINT COMMENT 'FK to real estate lease',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `lease_unit_id` BIGINT COMMENT 'Unique identifier for the lease unit associated with this lease liability',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `renewed_lease_liability_id` BIGINT COMMENT 'Unique identifier for the renewed lease liability associated with this lease liability',
    `accounting_standard` STRING COMMENT 'The accounting standard attribute value for this lease liability record in the finance domain',
    `amortization_schedule_code` STRING COMMENT 'A standardized code representing the amortization schedule classification for this lease liability',
    `closing_liability_balance` DECIMAL(18,2) COMMENT 'The closing liability balance attribute value for this lease liability record in the finance domain',
    `commencement_date` DATE COMMENT 'Lease commencement date',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this lease liability',
    `created_at` TIMESTAMP COMMENT 'The date and time when the created event occurred for this lease liability',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency` STRING COMMENT 'The currency attribute value for this lease liability record in the finance domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this lease liability',
    `current_liability_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for current liability in this lease liability',
    `current_liability_balance` DECIMAL(18,2) COMMENT 'The current liability balance attribute value for this lease liability record in the finance domain',
    `current_portion` DECIMAL(18,2) COMMENT 'The current portion attribute value for this lease liability record in the finance domain',
    `current_portion_amount` DECIMAL(18,2) COMMENT 'Current portion of lease liability',
    `discount_rate` DECIMAL(18,2) COMMENT 'The discount rate attribute value for this lease liability record in the finance domain',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'The discount rate pct attribute value for this lease liability record in the finance domain',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'Incremental borrowing rate / discount rate',
    `end_date` DATE COMMENT 'The date and time when the end event occurred for this lease liability',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this lease liability',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this lease liability record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this lease liability record in the finance domain',
    `incremental_borrowing_rate_percent` DECIMAL(18,2) COMMENT 'The incremental borrowing rate percent attribute value for this lease liability record in the finance domain',
    `initial_liability_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for initial liability in this lease liability',
    `initial_measurement_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for initial measurement in this lease liability',
    `interest_expense` DECIMAL(18,2) COMMENT 'The interest expense attribute value for this lease liability record in the finance domain',
    `interest_expense_amount` DECIMAL(18,2) COMMENT 'Interest expense for period',
    `lease_classification` STRING COMMENT 'Operating or finance lease classification',
    `lease_end_date` DATE COMMENT 'The date and time when the lease end event occurred for this lease liability',
    `lease_term_months` STRING COMMENT 'Lease term in months',
    `liability_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for liability in this lease liability',
    `maturity_date` DATE COMMENT 'Lease maturity date',
    `measurement_date` DATE COMMENT 'The date and time when the measurement event occurred for this lease liability',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `monthly_payment` STRING COMMENT 'The monthly payment attribute value for this lease liability record in the finance domain',
    `monthly_payment_amount` DECIMAL(18,2) COMMENT 'Monthly lease payment amount',
    `non_current_portion` DECIMAL(18,2) COMMENT 'The non current portion attribute value for this lease liability record in the finance domain',
    `noncurrent_liability_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for noncurrent liability in this lease liability',
    `noncurrent_portion` DECIMAL(18,2) COMMENT 'The noncurrent portion attribute value for this lease liability record in the finance domain',
    `noncurrent_portion_amount` DECIMAL(18,2) COMMENT 'Non-current portion of lease liability',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this lease liability',
    `opening_liability_balance` DECIMAL(18,2) COMMENT 'The opening liability balance attribute value for this lease liability record in the finance domain',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Outstanding lease liability balance',
    `payment_frequency` STRING COMMENT 'The payment frequency attribute value for this lease liability record in the finance domain',
    `present_value` DECIMAL(18,2) COMMENT 'The present value attribute value for this lease liability record in the finance domain',
    `principal_payment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for principal payment in this lease liability',
    `reassessment_date` DATE COMMENT 'Last reassessment date',
    `recognition_date` DATE COMMENT 'The date and time when the recognition event occurred for this lease liability',
    `remaining_term_months` STRING COMMENT 'Remaining lease term in months',
    `remeasurement_date` DATE COMMENT 'The date and time when the remeasurement event occurred for this lease liability',
    `remeasurement_indicator` BOOLEAN COMMENT 'The remeasurement indicator attribute value for this lease liability record in the finance domain',
    `renewal_option_flag` BOOLEAN COMMENT 'Whether renewal option exists',
    `right_of_use_asset_amount` DECIMAL(18,2) COMMENT 'Right-of-use asset amount',
    `lease_liability_status` STRING COMMENT 'The current status of the lease liability for this lease liability',
    `total_lease_payments` DECIMAL(18,2) COMMENT 'Total undiscounted lease payments',
    `updated_at` TIMESTAMP COMMENT 'The date and time when the updated event occurred for this lease liability',
    CONSTRAINT pk_lease_liability PRIMARY KEY(`lease_liability_id`)
) COMMENT 'Lease liability record per ASC 842/IFRS 16 representing the present value of future lease payments for restaurant locations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`financial_period` (
    `financial_period_id` BIGINT COMMENT 'Primary key',
    `ledger_id` BIGINT COMMENT 'Unique identifier for the ledger associated with this financial period',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `close_status` STRING COMMENT 'Period close status',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this financial period',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this financial period record in the finance domain',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter attribute value for this financial period record in the finance domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this financial period record in the finance domain',
    `fiscal_year_variant` STRING COMMENT 'The fiscal year variant attribute value for this financial period record in the finance domain',
    `is_adjustment_period` BOOLEAN COMMENT 'Whether adjustment period',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this financial period record in the finance domain',
    `period_close_status` STRING COMMENT 'The current status of the period close for this financial period',
    `period_end_date` DATE COMMENT 'The date and time when the period end event occurred for this financial period',
    `period_name` STRING COMMENT 'The display name or label for the period in this financial period',
    `period_number` STRING COMMENT 'The period number attribute value for this financial period record in the finance domain',
    `period_start_date` DATE COMMENT 'The date and time when the period start event occurred for this financial period',
    `period_status` STRING COMMENT 'The current status of the period for this financial period',
    `period_type` STRING COMMENT 'Period type (month, quarter, year)',
    `posting_allowed_flag` BOOLEAN COMMENT 'Whether posting is allowed',
    `posting_period_open_flag` BOOLEAN COMMENT 'Boolean indicator flag for posting period open flag status in this financial period',
    `special_period_flag` BOOLEAN COMMENT 'Boolean indicator flag for special period flag status in this financial period',
    CONSTRAINT pk_financial_period PRIMARY KEY(`financial_period_id`)
) COMMENT 'Financial period definition representing accounting periods (months, quarters, years) for the fiscal calendar.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the initiated by employee associated with this payment run record',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this payment run',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this payment run',
    `execution_date` DATE COMMENT 'The date and time when the execution event occurred for this payment run',
    `execution_timestamp` TIMESTAMP COMMENT 'The execution timestamp attribute value for this payment run record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `next_payment_date` DATE COMMENT 'The date and time when the next payment event occurred for this payment run',
    `payment_count` STRING COMMENT 'Number of payments in run',
    `payment_method` STRING COMMENT 'The payment method attribute value for this payment run record in the finance domain',
    `payment_run_date` DATE COMMENT 'The date and time when the payment run event occurred for this payment run',
    `payment_run_status` STRING COMMENT 'The current status of the payment run for this payment run',
    `posting_date` DATE COMMENT 'The date and time when the posting event occurred for this payment run',
    `run_identification` STRING COMMENT 'The run identification attribute value for this payment run record in the finance domain',
    `run_status` STRING COMMENT 'The current status of the run for this payment run',
    `run_type` STRING COMMENT 'The classification type for run in this payment run',
    `total_amount` DECIMAL(18,2) COMMENT 'Total payment amount',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for total payment in this payment run',
    `vendor_count` STRING COMMENT 'Number of vendors paid',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Payment run batch record representing a scheduled execution of vendor payments.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`house_bank` (
    `house_bank_id` BIGINT COMMENT 'Primary key',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `bank_city` STRING COMMENT 'The bank city attribute value for this house bank record in the finance domain',
    `bank_country_code` STRING COMMENT 'A standardized code representing the bank country classification for this house bank',
    `bank_key` STRING COMMENT 'Bank key identifier',
    `bank_name` STRING COMMENT 'The display name or label for the bank in this house bank',
    `house_bank_code` STRING COMMENT 'A standardized code representing the house bank classification for this house bank',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this house bank',
    `contact_name` STRING COMMENT 'The display name or label for the contact in this house bank',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `is_active` BOOLEAN COMMENT 'Whether active',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this house bank',
    `routing_number` STRING COMMENT 'Bank routing number',
    `house_bank_status` STRING COMMENT 'The current status of the house bank for this house bank',
    `swift_code` STRING COMMENT 'A standardized code representing the swift classification for this house bank',
    CONSTRAINT pk_house_bank PRIMARY KEY(`house_bank_id`)
) COMMENT 'House bank master data representing banking relationships and routing information.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` (
    `bank_statement_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `house_bank_id` BIGINT COMMENT 'Unique identifier for the house bank associated with this bank statement',
    `closing_balance` DECIMAL(18,2) COMMENT 'The closing balance attribute value for this bank statement record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this bank statement',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this bank statement',
    `import_status` STRING COMMENT 'The current status of the import for this bank statement',
    `import_timestamp` TIMESTAMP COMMENT 'The import timestamp attribute value for this bank statement record in the finance domain',
    `line_count` STRING COMMENT 'Number of lines',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this bank statement record in the finance domain',
    `opening_balance` DECIMAL(18,2) COMMENT 'The opening balance attribute value for this bank statement record in the finance domain',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation for this bank statement',
    `statement_date` DATE COMMENT 'The date and time when the statement event occurred for this bank statement',
    `statement_number` STRING COMMENT 'The statement number attribute value for this bank statement record in the finance domain',
    `statement_period_end_date` DATE COMMENT 'The date and time when the statement period end event occurred for this bank statement',
    `statement_period_start_date` DATE COMMENT 'The date and time when the statement period start event occurred for this bank statement',
    `total_credits` DECIMAL(18,2) COMMENT 'The total credits attribute value for this bank statement record in the finance domain',
    `total_debits` DECIMAL(18,2) COMMENT 'The total debits attribute value for this bank statement record in the finance domain',
    CONSTRAINT pk_bank_statement PRIMARY KEY(`bank_statement_id`)
) COMMENT 'Bank statement header representing a periodic statement from a banking institution.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` (
    `pos_settlement_batch_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the gl account associated with this pos settlement batch',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `pos_unit_id` BIGINT COMMENT 'Unique identifier for the pos unit associated with this pos settlement batch',
    `batch_date` DATE COMMENT 'The date and time when the batch event occurred for this pos settlement batch',
    `batch_number` STRING COMMENT 'The batch number attribute value for this pos settlement batch record in the finance domain',
    `batch_status` STRING COMMENT 'The current status of the batch for this pos settlement batch',
    `card_brand` STRING COMMENT 'The card brand attribute value for this pos settlement batch record in the finance domain',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this pos settlement batch',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this pos settlement batch',
    `deposit_date` DATE COMMENT 'The date and time when the deposit event occurred for this pos settlement batch',
    `fee_amount` DECIMAL(18,2) COMMENT 'Processing fee amount',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross settlement amount',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for gross sales in this pos settlement batch',
    `interchange_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for interchange fee in this pos settlement batch',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this pos settlement batch record in the finance domain',
    `net_amount` DECIMAL(18,2) COMMENT 'Net settlement amount',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for net settlement in this pos settlement batch',
    `payment_processor` STRING COMMENT 'Payment processor name',
    `processor_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for processor fee in this pos settlement batch',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation for this pos settlement batch',
    `refund_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for refund in this pos settlement batch',
    `settlement_date` DATE COMMENT 'The date and time when the settlement event occurred for this pos settlement batch',
    `tip_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for tip in this pos settlement batch',
    `transaction_count` STRING COMMENT 'Number of transactions',
    CONSTRAINT pk_pos_settlement_batch PRIMARY KEY(`pos_settlement_batch_id`)
) COMMENT 'POS settlement batch representing daily credit card and payment processor settlement for restaurant units.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` (
    `allocation_rule_id` BIGINT COMMENT 'Primary key',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity associated with this allocation rule',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the sender gl account associated with this allocation rule',
    `allocation_basis` STRING COMMENT 'Allocation basis (revenue, headcount, sqft)',
    `allocation_method` STRING COMMENT 'The allocation method attribute value for this allocation rule record in the finance domain',
    `allocation_type` STRING COMMENT 'The classification type for allocation in this allocation rule',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this allocation rule',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `cycle_name` STRING COMMENT 'The display name or label for the cycle in this allocation rule',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this allocation rule',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this allocation rule',
    `execution_frequency` STRING COMMENT 'The execution frequency attribute value for this allocation rule record in the finance domain',
    `is_active` BOOLEAN COMMENT 'Whether rule is active',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this allocation rule',
    `receiver_tracing_factor` DECIMAL(18,2) COMMENT 'The receiver tracing factor attribute value for this allocation rule record in the finance domain',
    `rule_code` STRING COMMENT 'A standardized code representing the rule classification for this allocation rule',
    `rule_description` STRING COMMENT 'The rule description attribute value for this allocation rule record in the finance domain',
    `rule_name` STRING COMMENT 'The display name or label for the rule in this allocation rule',
    `rule_status` STRING COMMENT 'The current status of the rule for this allocation rule',
    `rule_type` STRING COMMENT 'The classification type for rule in this allocation rule',
    `segment_name` STRING COMMENT 'The display name or label for the segment in this allocation rule',
    `statistical_key_figure` STRING COMMENT 'The statistical key figure attribute value for this allocation rule record in the finance domain',
    CONSTRAINT pk_allocation_rule PRIMARY KEY(`allocation_rule_id`)
) COMMENT 'Allocation rule definition specifying how shared costs are distributed across organizational units.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` (
    `hierarchy_node_id` BIGINT COMMENT 'Primary key',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity associated with this hierarchy node',
    `parent_hierarchy_node_id` BIGINT COMMENT 'Self-referencing FK to parent node',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this hierarchy node',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this hierarchy node',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this hierarchy node',
    `hierarchy_level` STRING COMMENT 'The hierarchy level attribute value for this hierarchy node record in the finance domain',
    `hierarchy_name` STRING COMMENT 'The display name or label for the hierarchy in this hierarchy node',
    `hierarchy_type` STRING COMMENT 'Hierarchy type (cost center, profit center, GL)',
    `is_leaf_node` BOOLEAN COMMENT 'Whether this is a leaf node',
    `level_number` STRING COMMENT 'Level number in hierarchy',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `node_code` STRING COMMENT 'A standardized code representing the node classification for this hierarchy node',
    `node_description` STRING COMMENT 'The node description attribute value for this hierarchy node record in the finance domain',
    `node_name` STRING COMMENT 'The display name or label for the node in this hierarchy node',
    `node_status` STRING COMMENT 'The current status of the node for this hierarchy node',
    `node_type` STRING COMMENT 'The classification type for node in this hierarchy node',
    `sort_order` STRING COMMENT 'The sort order attribute value for this hierarchy node record in the finance domain',
    `valid_from_date` DATE COMMENT 'Validity start date',
    `valid_to_date` DATE COMMENT 'Validity end date',
    CONSTRAINT pk_hierarchy_node PRIMARY KEY(`hierarchy_node_id`)
) COMMENT 'Hierarchy node representing a position in the organizational or financial reporting hierarchy.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Primary key',
    `chart_of_accounts_id` BIGINT COMMENT 'FK to chart of accounts',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity associated with this ledger',
    `accounting_principle` STRING COMMENT 'The accounting principle attribute value for this ledger record in the finance domain',
    `accounting_standard` STRING COMMENT 'Accounting standard (GAAP, IFRS)',
    `ledger_code` STRING COMMENT 'A standardized code representing the ledger classification for this ledger',
    `company_code` STRING COMMENT 'A standardized code representing the company classification for this ledger',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'Ledger currency',
    `ledger_description` STRING COMMENT 'The ledger description attribute value for this ledger record in the finance domain',
    `fiscal_year_variant` STRING COMMENT 'The fiscal year variant attribute value for this ledger record in the finance domain',
    `is_leading_ledger` BOOLEAN COMMENT 'Whether this is the leading ledger',
    `ledger_type` STRING COMMENT 'The classification type for ledger in this ledger',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `ledger_name` STRING COMMENT 'The display name or label for the ledger in this ledger',
    `posting_period_variant` STRING COMMENT 'The posting period variant attribute value for this ledger record in the finance domain',
    `ledger_status` STRING COMMENT 'The current status of the ledger for this ledger',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'Ledger master data representing different accounting ledgers (leading, non-leading, extension) for parallel accounting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Primary key',
    `account_count` STRING COMMENT 'The count or quantity of account items in this chart of accounts',
    `account_length` STRING COMMENT 'Account number length',
    `chart_code` STRING COMMENT 'Chart of accounts code',
    `chart_description` STRING COMMENT 'The chart description attribute value for this chart of accounts record in the finance domain',
    `chart_name` STRING COMMENT 'The display name or label for the chart in this chart of accounts',
    `chart_status` STRING COMMENT 'The current status of the chart for this chart of accounts',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this chart of accounts',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `group_chart_indicator` BOOLEAN COMMENT 'The group chart indicator attribute value for this chart of accounts record in the finance domain',
    `is_active` BOOLEAN COMMENT 'Whether active',
    `language_code` STRING COMMENT 'A standardized code representing the language classification for this chart of accounts',
    `length_of_account_number` STRING COMMENT 'The length of account number attribute value for this chart of accounts record in the finance domain',
    `maintenance_language` STRING COMMENT 'The maintenance language attribute value for this chart of accounts record in the finance domain',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `operational_chart_indicator` DECIMAL(18,2) COMMENT 'The operational chart indicator attribute value for this chart of accounts record in the finance domain',
    `owner_organization` STRING COMMENT 'The owner organization attribute value for this chart of accounts record in the finance domain',
    `version` STRING COMMENT 'The version attribute value for this chart of accounts record in the finance domain',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Chart of accounts master representing the complete account structure for a legal entity or group.';

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
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
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
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_sending_legal_entity_id` FOREIGN KEY (`sending_legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_source_cost_center_id` FOREIGN KEY (`source_cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_target_cost_center_id` FOREIGN KEY (`target_cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_house_bank_id` FOREIGN KEY (`house_bank_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_bank_statement_id` FOREIGN KEY (`bank_statement_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_statement`(`bank_statement_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_pos_settlement_batch_id` FOREIGN KEY (`pos_settlement_batch_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`pos_settlement_batch`(`pos_settlement_batch_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_renewed_lease_liability_id` FOREIGN KEY (`renewed_lease_liability_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`lease_liability`(`lease_liability_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ADD CONSTRAINT `fk_finance_house_bank_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_house_bank_id` FOREIGN KEY (`house_bank_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ADD CONSTRAINT `fk_finance_pos_settlement_batch_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ADD CONSTRAINT `fk_finance_pos_settlement_batch_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ADD CONSTRAINT `fk_finance_hierarchy_node_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ADD CONSTRAINT `fk_finance_hierarchy_node_parent_hierarchy_node_id` FOREIGN KEY (`parent_hierarchy_node_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_restaurants_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'ledger_structure');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `alternate_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `alternate_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'ledger_structure');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'ledger_structure');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'ledger_structure');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'journal_posting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `approver_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `approver_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_last_modified_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_last_modified_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'journal_posting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ALTER COLUMN `user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_capital');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` SET TAGS ('dbx_subdomain' = 'asset_capital');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` SET TAGS ('dbx_subdomain' = 'journal_posting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'journal_posting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` SET TAGS ('dbx_subdomain' = 'journal_posting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` SET TAGS ('dbx_subdomain' = 'journal_posting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `period_sign_off_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `period_sign_off_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `responsible_controller_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ALTER COLUMN `responsible_controller_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'journal_posting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_allocation` ALTER COLUMN `cycle_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` SET TAGS ('dbx_subdomain' = 'asset_capital');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ALTER COLUMN `project_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'banking_treasury');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` SET TAGS ('dbx_subdomain' = 'banking_treasury');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_account` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_account` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` SET TAGS ('dbx_subdomain' = 'asset_capital');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` SET TAGS ('dbx_subdomain' = 'ledger_structure');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`financial_period` ALTER COLUMN `period_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` SET TAGS ('dbx_subdomain' = 'banking_treasury');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `bank_city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`house_bank` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` SET TAGS ('dbx_subdomain' = 'banking_treasury');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`bank_statement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` SET TAGS ('dbx_subdomain' = 'journal_posting');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `cycle_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`allocation_rule` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` SET TAGS ('dbx_subdomain' = 'ledger_structure');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `hierarchy_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`hierarchy_node` ALTER COLUMN `node_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'ledger_structure');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ledger` ALTER COLUMN `ledger_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'ledger_structure');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `length_of_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `length_of_account_number` SET TAGS ('dbx_pii_financial' = 'true');
