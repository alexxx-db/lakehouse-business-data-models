-- Schema for Domain: billing | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:59:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`billing` COMMENT 'Billing and revenue domain serving as the SSOT for all customer invoices, billing cycles, payment processing, revenue recognition, credit management, collections, payment terms, accounts receivable, and billing dispute resolution across product sales, service contracts, and project-based engagements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice record.',
    `compliance_product_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.product_certification. Business justification: Certification bodies charge fees; invoices must reference the product certification they cover for traceability.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost‑center assignment enables cost accounting and profitability analysis per invoice in manufacturing.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit: internal control requires recording which employee created each invoice for compliance and traceability.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer billed by this invoice.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Lease billing process requires each invoice to reference the leased equipment for revenue recognition and asset tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for General Ledger posting of invoice revenue; finance GL accounts aggregate revenue for financial statements.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Revenue recognition ties invoices back to the originating sales opportunity for financial reporting and pipeline analysis.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: REQUIRED: Invoice‑Generation process needs to trace each invoice to its originating sales order for order‑to‑invoice reconciliation and audit reporting.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Order‑to‑cash process maps each invoice to its originating order intake record for fulfillment and billing reconciliation.',
    `primary_credit_note_invoice_id` BIGINT COMMENT 'Identifier of the related credit note, if this invoice is a credit note.',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: Invoice Generation process requires linking each invoice to its originating production work order for financial reporting and cost allocation; production work order is the natural source of billing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Links invoice revenue to profit‑center for segment reporting required by internal management reports.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Project financial reporting requires each invoice to be tied to the originating project header for profitability analysis.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Audit trail requires linking each invoice to the quote that defined pricing and terms after quote acceptance.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Filing fees are billed; the invoice must point to the specific regulatory filing it settles.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Tax compliance reporting requires each invoice to reference the governing regulatory requirement for tax calculation.',
    `sales_contract_id` BIGINT COMMENT 'Identifier of the underlying sales or service contract.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Commission reports need each invoice linked to the sales rep who closed the deal; essential for performance and payout calculations.',
    `request_id` BIGINT COMMENT 'Foreign key linking to service.request. Business justification: Required for Service Billing Report linking each invoice to the originating service request, enabling revenue tracking per service activity.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Invoice generation for each shipment requires linking invoice to the shipped order for traceability in the Shipment Billing process.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Primary shipping location per invoice is needed for traceability, hazardous material compliance, and dock scheduling.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Warehouse of origin is required for logistics cost allocation, export reporting, and inventory valuation per invoice.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address, if applicable.',
    `billing_city` STRING COMMENT 'City component of the billing address.',
    `billing_country` STRING COMMENT 'Three‑letter country code of the billing address.',
    `billing_period_end` DATE COMMENT 'End date of the billing period covered by the invoice.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period covered by the invoice.',
    `billing_postal_code` STRING COMMENT 'Postal code of the billing address.',
    `billing_state` STRING COMMENT 'State or province component of the billing address.',
    `collection_status` STRING COMMENT 'Current status of the collection process for overdue invoices.. Valid values are `open|in_collection|closed|written_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the invoice.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Discount rate applied to the invoice before tax.',
    `due_date` DATE COMMENT 'Date by which payment is due.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and adjustments.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice.. Valid values are `draft|issued|paid|overdue|cancelled|disputed`',
    `invoice_type` STRING COMMENT 'Classification of the invoice document.. Valid values are `standard|credit_note|debit_note|proforma|self_billing`',
    `is_self_billing` BOOLEAN COMMENT 'True if the invoice is generated by the supplier on behalf of the customer (self‑billing).',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice was issued.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and discounts.',
    `number` STRING COMMENT 'Official invoice number assigned by the billing system.',
    `payment_method` STRING COMMENT 'Method used by the customer to settle the invoice.. Valid values are `credit_card|bank_transfer|cash|check|wire`',
    `payment_status` STRING COMMENT 'Current status of the payment for this invoice.. Valid values are `pending|paid|failed|partial|refunded`',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms applied to the invoice.',
    `po_number` STRING COMMENT 'Purchase order reference supplied by the customer.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the invoice.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the invoice is exempt from tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document representing a formal demand for payment issued to a customer for product sales, service contracts, or project-based engagements. Captures invoice number, issue date, due date, billing period, total amount, tax amount, discount amount, currency, invoice status (draft, issued, partially_paid, paid, overdue, cancelled, disputed, written_off), invoice type (standard, credit_note, debit_note, proforma, self_billing), payment terms code, billing address, PO reference, contract reference, and source transaction reference. Serves as the SSOT for credit notes (returns, pricing corrections, quality disputes, volume rebate settlements) and debit notes (price adjustments, surcharges, underbilling corrections) via the invoice_type discriminator. Also supports self-billing/evaluated receipt settlement (ERS) for consignment and VMI arrangements. Managed in SAP S/4HANA SD/FI billing document types (VF01/VF04).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique surrogate key for each invoice line record.',
    `asset_work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Detailed billing of labor/materials per work order requires line‑level association for cost allocation and reporting.',
    `billing_cycle_id` BIGINT COMMENT 'Identifier of the billing cycle to which this line belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line‑level cost‑center allocation needed for detailed cost accounting and variance analysis.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Required for equipment usage charge‑back report linking each billed line to the specific machine that generated the usage.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Service‑charge line items must identify the exact equipment serviced to allocate costs and support maintenance cost analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maps each line to the correct GL account for accurate revenue/expense posting.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Inspection Service Billing – each inspection lot performed for a customer is charged as a line item on the invoice.',
    `invoice_id` BIGINT COMMENT 'Identifier of the parent invoice header to which this line belongs.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: REQUIRED: Revenue recognition and audit trails require linking each invoice line to the specific order line it bills.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Invoice line items need to reference the exact material being billed. Adding material_master_id (FK → inventory.material_master.material_master_id) creates a proper parent‑child relationship and remov',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: NCR Cost Recovery – non‑conformance handling costs are billed to the customer via a dedicated invoice line.',
    `original_invoice_line_id` BIGINT COMMENT 'Reference to the original invoice line that this credit memo line reverses.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: When a bundle is sold, the invoice line must point to the bundle definition for bundle pricing, warranty, and regulatory compliance reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Supports profit‑center based margin reporting per invoice line, a standard manufacturing finance practice.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Revenue recognition and product cost allocation require each invoice line to reference the sold SKU; this mapping is essential for financial reporting and compliance.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated to the cost center (derived from allocation_percent).',
    `allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of the line amount allocated to the specified cost center.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice line record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values on this line.',
    `deferred_revenue_flag` BOOLEAN COMMENT 'Indicates whether the line amount is deferred revenue (true) or recognized immediately (false).',
    `invoice_line_description` STRING COMMENT 'Free‑text description of the product, service, or milestone billed.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied to this line.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the line gross amount.',
    `expense_account` STRING COMMENT 'GL account used for any expense component associated with this line.',
    `external_reference_code` STRING COMMENT 'Identifier from an external system (e.g., ERP, CRM) linked to this line.',
    `is_bundle_line` BOOLEAN COMMENT 'True if this line is part of a product bundle.',
    `is_credit_memo` BOOLEAN COMMENT 'True if this line represents a credit memo (negative amount).',
    `is_royalty_line` BOOLEAN COMMENT 'True if the line represents a royalty charge.',
    `is_tax_included` BOOLEAN COMMENT 'Indicates whether the unit price already includes tax.',
    `line_amount` DECIMAL(18,2) COMMENT 'Total amount for the line before tax and discount (quantity × unit_price).',
    `line_status` STRING COMMENT 'Current processing status of the invoice line.. Valid values are `open|posted|reversed|cancelled`',
    `line_type` STRING COMMENT 'Classification of the line content (product, service, project milestone, fee, or other charge).. Valid values are `product|service|project|fee|charge`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after tax and discount (line_amount + tax_amount – discount_amount).',
    `notes` STRING COMMENT 'Free‑form notes or comments entered by users for this line.',
    `payment_terms_code` STRING COMMENT 'Code defining the payment terms applicable to this line.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when the line was posted to the financial ledger.',
    `project_milestone_code` STRING COMMENT 'Identifier of the project milestone or phase associated with this line.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of the product or service delivered (units, hours, meters, etc.).',
    `revenue_account` STRING COMMENT 'GL account used for revenue posting of this line.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for this line, per accounting standards.. Valid values are `percentage_of_completion|completed_contract|point_in_time`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Royalty rate applied to the base amount, expressed as a percentage.',
    `service_end_date` DATE COMMENT 'End date of the service period covered by this line (if applicable).',
    `service_start_date` DATE COMMENT 'Start date of the service period covered by this line (if applicable).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for this line.',
    `tax_code` STRING COMMENT 'Code that determines the tax rate and rules applicable to this line.',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the line is exempt from tax, false otherwise.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per single unit of the product or service before taxes and discounts.',
    `uom` STRING COMMENT 'Unit of measure for the quantity (e.g., each, kilogram, liter, meter, hour).. Valid values are `EA|KG|L|M|HRS`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the invoice line.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line item on a customer invoice representing a specific product, service, or project milestone being billed. Captures line number, item description, SKU or service code, quantity, unit of measure, unit price, line amount, tax code, tax amount, discount percentage, discount amount, cost center, profit center, GL account, revenue recognition method, and deferred revenue flag. Supports detailed revenue allocation across product sales, service contracts, and project milestones per SAP S/4HANA CO-PA and revenue recognition standards.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'System-generated unique identifier for the payment transaction.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Bank reconciliation requires linking each payment to the corporate bank account record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who made the payment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Payment processing audit: regulatory and internal policies require tracking which employee processed each payment.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Payments are allocated to projects to track cash flow against project budgets and enable project‑level cash reconciliation.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Anti‑money‑laundering and financial‑regulation monitoring ties each payment to the relevant regulatory requirement.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Payments are recorded against the governing sales contract to monitor contract cash flow and compliance.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Advance or partial payments are tied to a specific order intake for accurate order financing and tracking.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Commission calculations need each payment linked to the responsible sales rep for payout and performance metrics.',
    `request_id` BIGINT COMMENT 'Foreign key linking to service.request. Business justification: Needed for cash application to specific service requests, supporting the Service Payment Reconciliation process.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Total amount of the payment that has been allocated to invoices.',
    `allocation_date` TIMESTAMP COMMENT 'Timestamp when the payment was allocated.',
    `allocation_status` STRING COMMENT 'Status of the payment allocation to invoices.. Valid values are `allocated|partial|unallocated|on_account`',
    `allocation_type` STRING COMMENT 'Nature of the allocation (full, partial, advance, on‑account).. Valid values are `full|partial|advance|on_account`',
    `amount_discount` DECIMAL(18,2) COMMENT 'Total discount applied to the payment.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount before any discounts, taxes, or fees.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after discounts, taxes, and fees.',
    `bank_name` STRING COMMENT 'Name of the bank handling the payment.',
    `bank_value_date` DATE COMMENT 'Date on which the bank considers the funds available.',
    `batch_code` BIGINT COMMENT 'Identifier of the batch that groups this payment with others for processing.',
    `channel` STRING COMMENT 'Channel through which the payment was submitted.. Valid values are `online|mobile|branch|mail|phone`',
    `clearing_document_number` STRING COMMENT 'Reference number of the clearing document generated for the payment.',
    `clearing_status` STRING COMMENT 'Current status of the payment clearing process.. Valid values are `cleared|pending|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the payment.',
    `payment_description` STRING COMMENT 'Free‑form description or notes about the payment.',
    `discount_taken` DECIMAL(18,2) COMMENT 'Monetary discount amount applied to the payment.',
    `due_date` DATE COMMENT 'Date by which the payment was expected according to invoice terms.',
    `early_payment_discount_applied` BOOLEAN COMMENT 'Indicates whether an early‑payment discount was applied.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if payment currency differs from company currency.',
    `external_reference` STRING COMMENT 'Reference identifier from external payment gateway or bank.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any processing fees associated with the payment.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the payment has been reconciled to invoices.',
    `method` STRING COMMENT 'Instrument used to make the payment.. Valid values are `wire_transfer|ach|check|credit_card|letter_of_credit|cash`',
    `notes` STRING COMMENT 'Additional internal notes regarding the payment.',
    `original_amount` DECIMAL(18,2) COMMENT 'Payment amount in the original currency before conversion.',
    `original_currency` STRING COMMENT 'Currency code of the original payment amount.',
    `payment_date` TIMESTAMP COMMENT 'Timestamp when the payment was received or recorded.',
    `payment_number` STRING COMMENT 'Business-visible reference number assigned to the payment.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment.. Valid values are `pending|processed|failed|reversed|cancelled`',
    `reconciliation_date` TIMESTAMP COMMENT 'Timestamp when the payment was reconciled.',
    `remittance_advice_reference` STRING COMMENT 'Reference to the remittance advice supplied by the payer.',
    `sequence` STRING COMMENT 'Sequence number for multiple payments within a batch or settlement.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current payment status.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the payment.',
    `term_code` STRING COMMENT 'Code representing the payment terms (e.g., NET30, EOM).',
    `transaction_type` STRING COMMENT 'Classification of the payment transaction.. Valid values are `invoice_payment|prepayment|deposit|refund`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a payment transaction received from a customer against one or more invoices, serving as the SSOT for all incoming customer payments, cash application, and payment-to-invoice allocation in SAP S/4HANA FI-AR. Captures payment reference number, payment date, amount, currency, exchange rate, payment method (wire transfer, ACH, check, credit card, letter of credit), bank account reference, clearing document number, payment status, remittance advice reference, and bank value date. Includes allocation details: per-invoice allocated amount, allocation date, allocation type (full, partial, advance, on_account), discount taken, early payment discount applied, clearing status, and allocation sequence. Supports partial payments, split payments across multiple invoices, and on-account payments pending allocation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'System-generated unique identifier for the billing account record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigning AR balances to cost centers supports internal cost‑allocation reporting.',
    `customer_account_id` BIGINT COMMENT 'add column customer_account_id (BIGINT) with FK to customer.customer_account.customer_account_id - billing accounts must link to the customer they belong to for AR reconciliation',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Account management: each billing account is assigned a responsible account‑manager employee for relationship management.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Billing accounts use a payment term; linking to the payment_term master eliminates the free‑text code and enforces referential integrity.',
    `account_name` STRING COMMENT 'Human‑readable name of the billing account (e.g., customer or partner name).',
    `account_number` STRING COMMENT 'External account number used in invoicing and payment processing.',
    `account_type` STRING COMMENT 'Classification of the account relationship (direct, distributor, OEM, end‑user).. Valid values are `direct|distributor|OEM|end_user`',
    `auto_payment_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment processing is active.',
    `billing_account_status` STRING COMMENT 'Current lifecycle status of the billing account.. Valid values are `active|blocked|dormant|closed`',
    `billing_address_line1` STRING COMMENT 'First line of the billing address.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (optional).',
    `billing_city` STRING COMMENT 'City component of the billing address.',
    `billing_country_code` STRING COMMENT 'Three‑letter ISO country code for the billing address.',
    `billing_frequency` STRING COMMENT 'How often invoices are generated for the account.. Valid values are `monthly|quarterly|annual|milestone|on_delivery`',
    `billing_postal_code` STRING COMMENT 'Postal/ZIP code of the billing address.',
    `billing_state` STRING COMMENT 'State or province component of the billing address.',
    `close_date` DATE COMMENT 'Date when the billing account was closed or deactivated (nullable).',
    `collection_stage` STRING COMMENT 'Current stage in the collections process for overdue balances.. Valid values are `early|mid|late|defaulted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account record was first created.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the account.',
    `credit_rating` STRING COMMENT 'Credit rating assigned to the account based on financial risk assessment.. Valid values are `AAA|AA|A|BBB|BB|B`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for billing.',
    `current_ar_balance` DECIMAL(18,2) COMMENT 'Outstanding accounts‑receivable balance for the account.',
    `billing_account_description` STRING COMMENT 'Free‑form notes or description about the billing account.',
    `dunning_procedure` STRING COMMENT 'Assigned dunning strategy for overdue payments.',
    `external_account_reference` STRING COMMENT 'Identifier of the account in an external system (e.g., ERP, CRM).',
    `invoice_delivery_method` STRING COMMENT 'Preferred channel for delivering invoices to the customer.. Valid values are `email|EDI|portal|paper`',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received.',
    `next_due_date` DATE COMMENT 'Scheduled date for the next invoice payment.',
    `open_date` DATE COMMENT 'Date when the billing account was created.',
    `payment_due_day_of_month` STRING COMMENT 'Numeric day of the month when payment is due (1‑31).',
    `payment_method` STRING COMMENT 'Method used for the most recent payment transaction.. Valid values are `credit_card|bank_transfer|check|cash|direct_debit`',
    `preferred_payment_method` STRING COMMENT 'Customer’s preferred method for settling invoices.. Valid values are `credit_card|bank_transfer|check|cash|direct_debit`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the account is exempt from tax.',
    `tax_exempt_reason` STRING COMMENT 'Reason for tax exemption (e.g., government entity, nonprofit).',
    `tax_region_code` STRING COMMENT 'Three‑letter country code defining the tax jurisdiction.',
    `tax_registration_number` STRING COMMENT 'Government‑issued tax registration identifier for the account holder.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing account record.',
    `vat_number` STRING COMMENT 'Value‑Added Tax identifier used for tax reporting.',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Billing-specific account master record representing the financial relationship between Manufacturing and a customer entity for invoicing, credit management, and collections purposes. Captures account number, account name, account type (direct, distributor, OEM, end_user), billing currency, credit limit reference, current AR balance, payment terms code, billing frequency (monthly, milestone, on_delivery), invoice delivery method (email, EDI, portal, paper), tax registration number, VAT ID, dunning procedure assignment, account status (active, blocked, dormant), and preferred payment method. Serves as the billing-domain anchor for all financial transactions — distinct from the customer master in the customer domain which owns identity and relationship data.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`dispute` (
    `dispute_id` BIGINT COMMENT 'System-generated unique identifier for the billing dispute record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer or external party that raised the dispute.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice that is the subject of the dispute.',
    `employee_id` BIGINT COMMENT 'Identifier of the accounts‑receivable analyst responsible for handling the dispute.',
    `order_header_id` BIGINT COMMENT 'Identifier of the sales order associated with the disputed invoice, if applicable.',
    `request_id` BIGINT COMMENT 'Foreign key linking to service.request. Business justification: Allows dispute management to reference the related service request, essential for the Service Dispute Resolution workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the disputed amount.',
    `dispute_date` TIMESTAMP COMMENT 'Date and time when the customer raised the billing dispute.',
    `dispute_number` STRING COMMENT 'External reference number assigned to the dispute for tracking in finance and customer service systems.',
    `dispute_status` STRING COMMENT 'Current processing state of the dispute.. Valid values are `open|under_review|resolved|escalated|closed`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary value of the charge being disputed.',
    `escalation_flag` BOOLEAN COMMENT 'True if the dispute has been escalated to senior management or a specialized team.',
    `priority` STRING COMMENT 'Business priority assigned to the dispute for handling urgency.. Valid values are `low|medium|high|critical`',
    `reason_category` STRING COMMENT 'Category describing why the dispute was raised. [ENUM-REF-CANDIDATE: pricing_error|quantity_discrepancy|quality_issue|delivery_shortfall|duplicate_invoice|contract_mismatch|tax_error — promote to reference product]',
    `reason_description` STRING COMMENT 'Detailed free‑text explanation of why the dispute was raised.',
    `resolution_date` TIMESTAMP COMMENT 'Date and time when the dispute was resolved.',
    `resolution_notes` STRING COMMENT 'Free‑form notes describing the outcome and any actions taken.',
    `resolution_type` STRING COMMENT 'Method used to resolve the dispute.. Valid values are `credit_issued|payment_confirmed|partial_adjustment|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the dispute record.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Formal record of a customer-raised dispute against an invoice or billing charge. Captures dispute case number, dispute date, disputed invoice reference, disputed amount, dispute reason category (pricing_error, quantity_discrepancy, quality_issue, delivery_shortfall, duplicate_invoice, contract_mismatch, tax_error), dispute status (open, under_review, resolved, escalated, closed), resolution type (credit_issued, payment_confirmed, partial_adjustment, rejected), resolution date, resolution notes, and responsible AR analyst. Supports CAPA-driven billing quality improvement.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`collections` (
    `collections_id` BIGINT COMMENT 'Primary key for collections',
    `billing_account_id` BIGINT COMMENT 'add column billing_account_id (BIGINT) with FK to billing.billing_account.billing_account_id - collections activities should reference the billing account being collected upon',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer (debtor) associated with the collections case.',
    `employee_id` BIGINT COMMENT 'Identifier of the collections agent responsible for the case.',
    `invoice_id` BIGINT COMMENT 'add column invoice_id (BIGINT) with FK to billing.invoice.invoice_id - collections are driven by specific unpaid invoices',
    `case_close_date` TIMESTAMP COMMENT 'Date and time when the collections case was closed or resolved.',
    `case_description` STRING COMMENT 'Free‑form text describing the context or notes for the collections case.',
    `case_number` STRING COMMENT 'External reference number assigned to the collections case, used in communications and reporting.',
    `case_open_date` TIMESTAMP COMMENT 'Date and time when the collections case was initially created in the system.',
    `case_status` STRING COMMENT 'Current lifecycle status of the collections case.. Valid values are `open|in_progress|escalated|resolved|closed`',
    `case_strategy` STRING COMMENT 'Strategic approach applied to the case (e.g., standard reminders, intensive follow‑up, legal action, or write‑off candidate).. Valid values are `standard|intensive|legal|write_off_candidate`',
    `collection_source_system` STRING COMMENT 'Name of the operational system of record that originated the dunning data (e.g., SAP S/4HANA FI‑AR).',
    `collection_stage` STRING COMMENT 'Current stage of the collections workflow.. Valid values are `detection|reminder|escalation|legal|write_off`',
    `communication_method` STRING COMMENT 'Channel used for the most recent dunning communication.. Valid values are `email|letter|phone|legal`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dunning notice record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values in the case.. Valid values are `^[A-Z]{3}$`',
    `customer_response_status` STRING COMMENT 'Indicator of whether the customer has responded to the latest communication.. Valid values are `responded|no_response|partial`',
    `dunning_charges` DECIMAL(18,2) COMMENT 'Fees applied as part of the dunning process for the case.',
    `dunning_date` DATE COMMENT 'Date when the most recent dunning notice was issued.',
    `dunning_level` STRING COMMENT 'Current escalation level of the dunning process (1‑4).',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the case has been escalated beyond standard reminders.',
    `external_reference_code` STRING COMMENT 'Identifier linking the dunning notice to the originating SAP document or external ledger entry.',
    `gross_exposure_amount` DECIMAL(18,2) COMMENT 'Total outstanding receivable amount before any adjustments or dunning charges.',
    `legal_action_flag` BOOLEAN COMMENT 'True if legal proceedings have been initiated for the case.',
    `net_exposure_amount` DECIMAL(18,2) COMMENT 'Outstanding amount after dunning charges are applied.',
    `next_action_date` DATE COMMENT 'Planned date for the next collection activity or follow‑up.',
    `notes` STRING COMMENT 'Supplementary remarks entered by the collections agent.',
    `payment_arrangement_flag` BOOLEAN COMMENT 'Indicates whether a formal payment arrangement is in place.',
    `payment_arrangement_type` STRING COMMENT 'Type of payment arrangement agreed with the customer.. Valid values are `installment|full|partial`',
    `promise_to_pay_date` DATE COMMENT 'Date promised by the customer for payment of the outstanding amount.',
    `promised_amount` DECIMAL(18,2) COMMENT 'Amount the customer committed to pay on the promise‑to‑pay date.',
    `response_date` DATE COMMENT 'Date when the customer provided a response to the dunning communication.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dunning notice record.',
    `write_off_candidate_flag` BOOLEAN COMMENT 'True if the case is identified as a potential write‑off.',
    CONSTRAINT pk_collections PRIMARY KEY(`collections_id`)
) COMMENT 'Collections management record serving as the unified SSOT for the full receivables collections lifecycle — from initial overdue detection through escalation to legal action or write-off referral. At the case level: captures collections case ID, collections strategy (standard, intensive, legal, write_off_candidate), assigned collections agent, customer promise-to-pay date, promised amount, case status (open, in_progress, escalated, resolved, closed), case open date, and total case exposure amount. At the communication level: captures dunning level (1=reminder through 4=legal_action), dunning date, total overdue amount, dunning charges, communication method (email, letter, phone, legal), customer response status, response date, and next action date. Tracks the full collections escalation lifecycle per SAP S/4HANA FI-AR dunning procedures (FBMP/F150) and supports structured collections management for industrial B2B receivables with typical 30-90 day payment cycles.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` (
    `revenue_recognition_event_id` BIGINT COMMENT 'System-generated unique identifier for the revenue recognition event.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Revenue audit: linking the creator employee to each recognition event satisfies SOX‑type controls and audit trails.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer or counterparty associated with the contract underlying the revenue event.',
    `invoice_id` BIGINT COMMENT 'Identifier of the billing document (invoice) linked to this revenue recognition event.',
    `obligation_id` BIGINT COMMENT 'Reference to the specific performance obligation within the contract that is being recognized.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Revenue recognition must comply with accounting standards (e.g., IFRS 15); each event references the governing regulatory requirement.',
    `adjustment_reason` STRING COMMENT 'Reason or description for any adjustment applied to the revenue event.',
    `cost_account_code` STRING COMMENT 'General ledger account code for the cost of goods sold.',
    `cost_of_goods_sold_amount` DECIMAL(18,2) COMMENT 'Cost associated with the goods or services recognized in this revenue event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revenue recognition event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'Monetary amount of revenue deferred (not yet recognized) associated with this event.',
    `revenue_recognition_event_description` STRING COMMENT 'Free-text description or notes about the revenue recognition event.',
    `effective_end_date` DATE COMMENT 'Date when the recognized revenue ceases to be effective, if applicable.',
    `effective_start_date` DATE COMMENT 'Date when the recognized revenue becomes effective for reporting.',
    `event_number` STRING COMMENT 'External business identifier or reference number for the revenue recognition event.',
    `is_adjusted` BOOLEAN COMMENT 'Indicates whether the revenue event includes an adjustment.',
    `recognition_status` STRING COMMENT 'Current processing status of the revenue recognition event.. Valid values are `pending|recognized|reversed|adjusted`',
    `recognition_timestamp` TIMESTAMP COMMENT 'Date and time when the revenue recognition event was triggered.',
    `recognition_type` STRING COMMENT 'Method used to recognize revenue: point in time, over time, milestone, or percentage of completion.. Valid values are `point_in_time|over_time|milestone|percentage_of_completion`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'Monetary amount of revenue that has been recognized in this event.',
    `revenue_account_code` STRING COMMENT 'General ledger account code to which recognized revenue is posted.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the contract portion covered by this revenue event (recognized + deferred).',
    `transaction_reference` STRING COMMENT 'External reference number linking to related transaction records (e.g., invoice number).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revenue recognition event record.',
    CONSTRAINT pk_revenue_recognition_event PRIMARY KEY(`revenue_recognition_event_id`)
) COMMENT 'Operational record capturing a revenue recognition event triggered by a contractual milestone, delivery confirmation, or service completion. Captures event ID, recognition date, recognition type (point_in_time, over_time, milestone, percentage_of_completion), recognized amount, deferred amount, contract performance obligation reference, billing document reference, revenue account, cost of goods sold amount, and recognition status (pending, recognized, reversed, adjusted). Supports IFRS 15 / ASC 606 compliance for revenue recognition across product sales, service contracts, and project engagements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` (
    `credit_limit_id` BIGINT COMMENT 'System-generated unique identifier for the credit limit record.',
    `customer_account_id` BIGINT COMMENT 'add column customer_account_id (BIGINT) with FK to customer.customer_account.customer_account_id - credit limits are meaningless without association to a specific customer account',
    `employee_id` BIGINT COMMENT 'Identifier of the analyst responsible for approving and maintaining the credit limit.',
    `approval_status` STRING COMMENT 'Current approval state of the credit limit.. Valid values are `approved|rejected|pending`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit limit was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit limit record was first created in the system.',
    `credit_block_flag` BOOLEAN COMMENT 'Indicates whether the credit limit is currently blocked from further usage.',
    `credit_check_method` STRING COMMENT 'Method used to assess creditworthiness for this limit.. Valid values are `automated|manual|external`',
    `credit_horizon_days` STRING COMMENT 'Number of days over which the credit exposure is evaluated.',
    `credit_limit_number` STRING COMMENT 'External business identifier for the credit limit, used in accounting and customer communications.',
    `credit_limit_status` STRING COMMENT 'Current lifecycle status of the credit limit record.. Valid values are `active|inactive|pending|blocked`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the credit limit is denominated.',
    `current_exposure` DECIMAL(18,2) COMMENT 'Current amount of credit already utilized by the customer against this limit.',
    `effective_from` DATE COMMENT 'Date on which the credit limit becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the credit limit expires; null for open‑ended limits.',
    `last_review_date` DATE COMMENT 'Date when the credit limit was last reviewed by the credit analyst.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum approved credit exposure amount for the account, expressed in the specified currency.',
    `limit_type` STRING COMMENT 'Classification of the credit limit as individual (per customer) or group (aggregated across a corporate group).. Valid values are `individual|group`',
    `next_review_date` DATE COMMENT 'Planned date for the next credit limit review.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or justification related to the credit limit.',
    `risk_category` STRING COMMENT 'Risk classification of the credit limit: A=low, B=medium, C=high, D=blocked.. Valid values are `A|B|C|D`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credit limit record.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the credit limit that is currently used (current_exposure / limit_amount * 100).',
    CONSTRAINT pk_credit_limit PRIMARY KEY(`credit_limit_id`)
) COMMENT 'Credit management record defining the approved credit exposure limit for a billing account, including current utilization and risk classification. Captures credit limit amount, currency, credit limit type (individual, group), credit exposure current value, credit utilization percentage, credit risk category (A=low, B=medium, C=high, D=blocked), credit check method, credit horizon days, last review date, next review date, credit analyst ID, approval status, and credit block flag. Managed in SAP S/4HANA FI-AR Credit Management (FD32).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` (
    `billing_schedule_id` BIGINT COMMENT 'Unique system-generated identifier for each billing schedule record.',
    `billing_account_id` BIGINT COMMENT 'add column billing_account_id (BIGINT) with FK to billing.billing_account.billing_account_id - billing schedules should reference the billing account for invoicing',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Schedule ownership: billing schedules are created by a specific employee; linking supports accountability and reporting.',
    `customer_account_id` BIGINT COMMENT 'add column customer_account_id (BIGINT) with FK to customer.customer_account.customer_account_id - billing schedules must identify which customer is being billed',
    `sales_contract_id` BIGINT COMMENT 'Identifier of the contract to which this billing schedule line belongs.',
    `wbs_element_id` BIGINT COMMENT 'Work Breakdown Structure element of the project linked to this billing milestone.',
    `actual_billed_amount` DECIMAL(18,2) COMMENT 'Monetary amount that was actually invoiced for this milestone.',
    `actual_billing_date` DATE COMMENT 'Date on which the billing was actually executed.',
    `billing_currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the planned billing amount.. Valid values are `^[A-Z]{3}$`',
    `billing_status` STRING COMMENT 'Current lifecycle status of the billing schedule line.. Valid values are `planned|ready_to_bill|billed|on_hold|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing schedule record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount subtracted from the planned billing amount, if any.',
    `is_retention_applicable` BOOLEAN COMMENT 'Indicates whether a retention amount is associated with this milestone.',
    `line_number` STRING COMMENT 'Sequential number of the schedule line within the contract billing schedule.',
    `milestone_description` STRING COMMENT 'Free‑text description of the billing milestone purpose or deliverable.',
    `milestone_type` STRING COMMENT 'Category of the billing milestone (e.g., advance payment, progress billing, final billing, retention release).. Valid values are `advance_payment|progress_billing|final_billing|retention_release`',
    `notes` STRING COMMENT 'Optional free‑text field for additional comments or special instructions.',
    `percentage_complete_trigger` DECIMAL(18,2) COMMENT 'Project completion percentage that triggers this billing milestone.',
    `planned_billing_amount` DECIMAL(18,2) COMMENT 'Monetary amount planned to be invoiced for this milestone.',
    `planned_billing_date` DATE COMMENT 'Date on which the billing amount is scheduled to be invoiced.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Monetary amount held as retention for this milestone, if applicable.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the planned billing amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing schedule record.',
    CONSTRAINT pk_billing_schedule PRIMARY KEY(`billing_schedule_id`)
) COMMENT 'Planned billing milestone schedule for project-based or contract-based engagements, defining when specific amounts are to be invoiced based on project progress, delivery milestones, or contractual dates. Captures schedule line number, planned billing date, planned billing amount, billing milestone description, milestone type (advance_payment, progress_billing, final_billing, retention_release), percentage complete trigger, actual billing date, actual billed amount, billing status (planned, ready_to_bill, billed, on_hold, cancelled), contract reference, and project WBS element reference. Supports project billing for industrial automation system installations (typically 12-36 month delivery cycles) and milestone-based revenue recognition per IFRS 15 variable consideration guidance.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` (
    `tax_determination_id` BIGINT COMMENT 'System-generated unique identifier for the tax determination record.',
    `invoice_id` BIGINT COMMENT 'Identifier of the billing document (invoice) to which this tax determination applies.',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product or service line item that the tax is calculated for.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the tax determination record was created.',
    `line_sequence` STRING COMMENT 'Ordinal position of the tax line within the invoice.',
    `reverse_charge_indicator` BOOLEAN COMMENT 'True if reverse charge mechanism applies for this tax line.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary amount of tax computed for this line.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'Monetary amount on which the tax rate is applied.',
    `tax_calculation_method` STRING COMMENT 'Method used to compute the tax (standard, manual entry, tax engine, rule‑based).. Valid values are `standard|manual|engine|rule_based`',
    `tax_code` STRING COMMENT 'Internal or regulatory tax code that identifies the specific tax rule applied.',
    `tax_currency_code` STRING COMMENT 'Three‑letter ISO currency code of the tax amount (e.g., USD, EUR).',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the transaction is exempt from tax (true = exempt).',
    `tax_exempt_reason` STRING COMMENT 'Reason or justification for tax exemption, if applicable.',
    `tax_jurisdiction_country` STRING COMMENT 'Three‑letter ISO country code of the tax jurisdiction (e.g., USA, DEU).',
    `tax_jurisdiction_region` STRING COMMENT 'Region, state, or province code within the country where tax is applied (e.g., CA for California).',
    `tax_line_description` STRING COMMENT 'Free‑text description of the tax line (e.g., "EU VAT 20% on machinery").',
    `tax_line_status` STRING COMMENT 'Current processing status of the tax line.. Valid values are `pending|applied|rejected|adjusted`',
    `tax_override_amount` DECIMAL(18,2) COMMENT 'Manually entered tax amount that overrides the calculated value.',
    `tax_override_flag` BOOLEAN COMMENT 'True if the tax amount has been manually overridden.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `tax_registration_number` STRING COMMENT 'Vendor or customer tax registration identifier (e.g., VAT number).',
    `tax_reporting_period` STRING COMMENT 'Fiscal period (e.g., 2023Q1) for which the tax is reported.',
    `tax_source_system` STRING COMMENT 'Source system that generated the tax determination (e.g., SAP Tax Service, Vertex).',
    `tax_type` STRING COMMENT 'Category of tax applied (e.g., VAT, GST, sales tax, withholding tax, excise duty).. Valid values are `VAT|GST|sales_tax|withholding_tax|excise_duty`',
    `tax_validated_flag` BOOLEAN COMMENT 'Indicates whether the tax calculation has been validated against regulatory rules.',
    `tax_validated_timestamp` TIMESTAMP COMMENT 'Date‑time when the tax validation was performed.',
    `taxable_quantity` DECIMAL(18,2) COMMENT 'Quantity of the product/service that is subject to tax calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the tax determination record.',
    CONSTRAINT pk_tax_determination PRIMARY KEY(`tax_determination_id`)
) COMMENT 'Tax calculation and compliance record for billing documents, capturing jurisdiction-specific tax codes, rates, exemptions, and computed tax amounts required for multi-country tax reporting. Captures tax country, tax region, tax code, tax type (VAT, GST, sales_tax, withholding_tax, excise_duty), tax base amount, tax rate percentage, tax amount, tax exempt flag, tax exempt reason, tax jurisdiction code, tax registration validation, reverse charge indicator, and tax reporting period. Supports cross-border industrial equipment sales requiring complex tax determination across EU VAT, US sales tax nexus, Indian GST, and withholding tax regimes. Essential for tax audit compliance and automated tax engine integration (Vertex, SAP Tax Service).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` (
    `advance_payment_id` BIGINT COMMENT 'System-generated unique identifier for the advance payment record.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the bank account where the advance payment was deposited.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice that clears (partially or fully) the advance payment.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who provided the advance payment.',
    `order_header_id` BIGINT COMMENT 'Reference to the sales order associated with the advance payment.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project or contract to which the advance payment is linked.',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to service.service_contract. Business justification: Captures advance payments against a service contract, required for contract financial tracking and cash forecasting.',
    `advance_payment_number` STRING COMMENT 'Business-visible identifier assigned to the advance payment (e.g., AP-2024-000123).',
    `advance_payment_status` STRING COMMENT 'Current lifecycle status of the advance payment.. Valid values are `open|partially_cleared|fully_cleared|cancelled`',
    `advance_type` STRING COMMENT 'Classification of the advance payment purpose.. Valid values are `down_payment|progress_payment|retention|security_deposit`',
    `amount` DECIMAL(18,2) COMMENT 'Gross amount of the advance payment received.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the advance payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the advance payment (e.g., EUR, USD).',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the advance payment.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert foreign currency amount to the company code currency, if applicable.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the advance payment amount is subject to tax.',
    `notes` STRING COMMENT 'Free‑form text for additional information or remarks about the advance payment.',
    `original_amount` DECIMAL(18,2) COMMENT 'Original amount received in the payments foreign currency before conversion.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was submitted.. Valid values are `online|offline|mobile|branch`',
    `payment_method` STRING COMMENT 'Instrument used to make the advance payment.. Valid values are `bank_transfer|credit_card|cash|check|wire`',
    `receipt_number` STRING COMMENT 'Document number of the payment receipt generated by the finance system.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the advance payment was received.',
    `request_number` STRING COMMENT 'Reference number of the request that initiated the advance payment.',
    `special_gl_flag` BOOLEAN COMMENT 'Flag indicating whether the payment is posted to a special general ledger account.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the advance payment, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the advance payment record.',
    CONSTRAINT pk_advance_payment PRIMARY KEY(`advance_payment_id`)
) COMMENT 'Record of advance or down payments received from customers prior to invoice issuance, typically for large capital equipment orders (>€100K), long-term project contracts, or custom automation system builds. Captures advance payment reference, receipt date, advance amount, currency, advance type (down_payment, progress_payment, retention, security_deposit), associated sales order or project reference, clearing status (open, partially_cleared, fully_cleared), clearing invoice reference, advance payment request reference, and special GL indicator. Distinct from the payment product which handles post-invoice cash application — advance_payment manages pre-invoice receipts requiring special GL treatment and progressive clearing as project milestones are invoiced. Managed in SAP S/4HANA FI-AR as special GL transactions (F-29/F-48).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'System-generated unique identifier for the write-off record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer whose receivable is being written off.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the write‑off.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Write‑off entries must be posted to a GL account for audit trails and financial statements.',
    `invoice_id` BIGINT COMMENT 'System identifier of the original invoice linked to this write‑off.',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary amount written off (before any recovery).',
    `approval_level` STRING COMMENT 'Organizational level that approved the write‑off.. Valid values are `manager|director|cfo|vp`',
    `comments` STRING COMMENT 'Free‑form notes or justification details for the write‑off.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the write‑off record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the write‑off amount.. Valid values are `[A-Z]{3}`',
    `reason` STRING COMMENT 'Reason why the receivable was written off (e.g., bankruptcy, dispute settled, aged debt, legal settlement, goodwill).. Valid values are `bankruptcy|dispute_settled|aged_debt|legal_settlement|goodwill`',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Monetary amount recovered after the write‑off was posted.',
    `recovery_date` DATE COMMENT 'Date on which the recovery amount was received.',
    `recovery_flag` BOOLEAN COMMENT 'Indicates whether any portion of the written‑off amount has been subsequently recovered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the write‑off record.',
    `write_off_number` STRING COMMENT 'External reference number assigned to the write‑off for tracking and audit purposes.',
    `write_off_status` STRING COMMENT 'Current processing state of the write‑off (e.g., pending approval, approved, rejected, closed).. Valid values are `pending|approved|rejected|closed`',
    `write_off_timestamp` TIMESTAMP COMMENT 'Date and time when the write‑off action was executed in the source system.',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Record of a bad debt write-off action taken against an uncollectable receivable balance. Captures write-off reference, write-off date, write-off amount, currency, original invoice references, write-off reason (bankruptcy, dispute_settled, aged_debt, legal_settlement, goodwill), approval level, approver ID, GL account for bad debt expense, recovery flag, recovery amount (if subsequently collected), and write-off status. Supports bad debt provisioning and financial reporting per IFRS/GAAP requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` (
    `intercompany_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the intercompany invoice record.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Intercompany invoices belong to a billing account; adding the FK creates the required parent‑child relationship and prevents the billing_account table from being isolated.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Intercompany invoicing requires linking to the underlying PO to reconcile internal procurement and billing transactions.',
    `company_code_id` BIGINT COMMENT 'add column receiving_company_code_id (BIGINT) with FK to finance.company_code.company_code_id - intercompany invoices need receiver legal entity',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Transfer‑pricing regulations require each intercompany invoice to be linked to the applicable regulatory requirement.',
    `sending_company_code_id` BIGINT COMMENT 'add column sending_company_code_id (BIGINT) with FK to finance.company_code.company_code_id - intercompany invoices need sender legal entity',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was approved for posting.',
    `billing_amount` DECIMAL(18,2) COMMENT 'Gross amount billed before taxes, discounts, or mark‑ups.',
    `comments` STRING COMMENT 'Free‑text field for additional notes or explanations.',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the intercompany transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the invoice amounts.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount granted on the invoice.',
    `due_date` DATE COMMENT 'Date by which payment must be received.',
    `elimination_flag` BOOLEAN COMMENT 'Indicates whether the invoice amount should be eliminated during group consolidation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate to the reporting currency at posting time.',
    `external_invoice_reference` STRING COMMENT 'Reference to the external (customer‑facing) invoice linked to this intercompany invoice.',
    `intercompany_markup_pct` DECIMAL(18,2) COMMENT 'Percentage markup applied to the transfer price for intercompany profit.',
    `invoice_date` TIMESTAMP COMMENT 'Timestamp when the intercompany invoice was created in the source system.',
    `invoice_number` STRING COMMENT 'External invoice number assigned by the issuing entity, used for legal and audit purposes.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the intercompany invoice.. Valid values are `draft|open|posted|closed|cancelled|reversed`',
    `issuing_company_code` STRING COMMENT 'Code of the legal entity that issues the intercompany invoice.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and discount, representing the amount payable.',
    `original_currency_amount` DECIMAL(18,2) COMMENT 'Invoice amount expressed in the original transaction currency before conversion.',
    `payment_terms` STRING COMMENT 'Standard payment terms governing when payment is due.. Valid values are `net_30|net_45|net_60|due_on_receipt`',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was posted to the general ledger.',
    `project_code` STRING COMMENT 'Project identifier if the invoice is linked to a specific internal project.',
    `receiving_company_code` STRING COMMENT 'Code of the legal entity that receives the intercompany invoice.',
    `reversal_indicator` BOOLEAN COMMENT 'True if the invoice represents a reversal/credit note.',
    `settlement_date` DATE COMMENT 'Date on which the invoice was settled.',
    `settlement_status` STRING COMMENT 'Current settlement state of the invoice.. Valid values are `unsettled|settled|partial|failed`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the invoice.',
    `tax_code` STRING COMMENT 'Tax jurisdiction code applied to the invoice.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the invoice.',
    `transaction_type` STRING COMMENT 'Category of the intercompany transaction driving the invoice.. Valid values are `goods_transfer|service_charge|cost_allocation|royalty|management_fee`',
    `transfer_price_basis` STRING COMMENT 'Basis used to calculate the transfer price (e.g., cost, market, list).. Valid values are `cost|market|list|custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record.',
    CONSTRAINT pk_intercompany_invoice PRIMARY KEY(`intercompany_invoice_id`)
) COMMENT 'Billing document issued between legal entities within the Manufacturing group for intercompany product transfers, shared services, or intragroup project charges. Captures intercompany invoice number, issuing company code, receiving company code, transaction type (goods_transfer, service_charge, cost_allocation, royalty, management_fee), billing amount, transfer price basis, currency, intercompany markup percentage, corresponding external invoice reference, elimination flag for consolidation, and posting status. Supports intercompany reconciliation and group financial consolidation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'System-generated unique identifier for the payment term record.',
    `base_payment_term_id` BIGINT COMMENT 'Self-referencing FK on payment_term (base_payment_term_id)',
    `allowed_payment_channel` STRING COMMENT 'Channels through which payment can be made (e.g., online portal, mobile app).. Valid values are `online|offline|mobile|mail|api`',
    `allowed_payment_method` STRING COMMENT 'Payment instruments permitted under this term.. Valid values are `credit_card|bank_transfer|cash|check|wire|direct_debit`',
    `applicable_invoice_type` STRING COMMENT 'Invoice categories to which this payment term can be applied.. Valid values are `standard|credit|debit|proforma|rebate`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment term record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency applicable to the payment term.. Valid values are `^[A-Z]{3}$`',
    `early_payment_discount_days` STRING COMMENT 'Number of days from invoice date during which the early‑payment discount is available.',
    `early_payment_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied when payment is made within the early‑payment window.',
    `effective_from` DATE COMMENT 'Date when the payment term becomes binding.',
    `effective_until` DATE COMMENT 'Date when the payment term expires; null for open‑ended terms.',
    `grace_period_days` STRING COMMENT 'Additional days after the net due date before penalties apply.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this term is the default for new customers or contracts.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether taxes are waived for transactions using this term.',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'Upper limit on the monetary value of any discount granted under this term.',
    `min_payment_amount` DECIMAL(18,2) COMMENT 'Minimum amount that must be paid per invoice under this term.',
    `net_days` STRING COMMENT 'Standard number of days after invoice date when payment is due (e.g., Net 30).',
    `notes` STRING COMMENT 'Free‑form comments or special conditions related to the payment term.',
    `payment_term_status` STRING COMMENT 'Current lifecycle state of the payment term.. Valid values are `active|inactive|expired|pending|suspended|terminated`',
    `penalty_rate_percent` DECIMAL(18,2) COMMENT 'Interest or fee percentage charged on overdue amounts.',
    `penalty_type` STRING COMMENT 'Method of applying the penalty (percentage of overdue amount or flat fee).. Valid values are `percentage|flat_fee`',
    `tax_exempt_reason` STRING COMMENT 'Explanation for tax exemption (e.g., government incentive, nonprofit status).',
    `term_code` STRING COMMENT 'Human‑readable code used to reference the payment term in contracts and invoices.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `term_type` STRING COMMENT 'Category of the payment term (e.g., Net, Discount, Milestone, Retention, Custom).. Valid values are `net|discount|milestone|retention|custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment term record.',
    `version_number` STRING COMMENT 'Sequential version of the payment term record for change tracking.',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Payment terms master defining standard and customer-specific payment conditions (Net 30, Net 60, 2/10 Net 30) applied to billing documents and customer accounts';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` (
    `billing_cycle_id` BIGINT COMMENT 'Primary key for billing_cycle',
    `previous_billing_cycle_id` BIGINT COMMENT 'Self-referencing FK on billing_cycle (previous_billing_cycle_id)',
    `billing_day_of_month` STRING COMMENT 'Day of month on which billing is generated (1‑31).',
    `billing_weekday` STRING COMMENT 'Weekday on which billing occurs for weekly cycles. [ENUM-REF-CANDIDATE: Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday — promote to reference product]',
    `cutoff_day` STRING COMMENT 'Day of month that defines the billing period cutoff.',
    `cycle_code` STRING COMMENT 'External code used to identify the billing cycle.',
    `cycle_name` STRING COMMENT 'Human‑readable name of the billing cycle.',
    `cycle_type` STRING COMMENT 'Category of the billing cycle indicating its recurrence pattern.',
    `default_currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code used for amounts in this cycle.',
    `billing_cycle_description` STRING COMMENT 'Detailed description of the billing cycle.',
    `effective_end_date` DATE COMMENT 'Date when the billing cycle ends; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the billing cycle becomes effective.',
    `fixed_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount charged each billing period when Fixed Amount Flag is true.',
    `grace_period_days` STRING COMMENT 'Number of days after the due date before a payment is considered overdue.',
    `interval_count` STRING COMMENT 'Number of intervals between billing occurrences.',
    `interval_unit` STRING COMMENT 'Time unit for the interval count.',
    `is_fixed_amount` BOOLEAN COMMENT 'True if the billing cycle uses a fixed amount for each period.',
    `is_prorated` BOOLEAN COMMENT 'Indicates whether the billing cycle supports prorated charges.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the billing cycle record was created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing cycle record.',
    `billing_cycle_status` STRING COMMENT 'Current lifecycle status of the billing cycle.',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether taxes are included in the billed amount.',
    CONSTRAINT pk_billing_cycle PRIMARY KEY(`billing_cycle_id`)
) COMMENT 'Master reference table for billing_cycle. Referenced by billing_cycle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_primary_credit_note_invoice_id` FOREIGN KEY (`primary_credit_note_invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_original_invoice_line_id` FOREIGN KEY (`original_invoice_line_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ADD CONSTRAINT `fk_billing_collections_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ADD CONSTRAINT `fk_billing_collections_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ADD CONSTRAINT `fk_billing_tax_determination_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ADD CONSTRAINT `fk_billing_intercompany_invoice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ADD CONSTRAINT `fk_billing_payment_term_base_payment_term_id` FOREIGN KEY (`base_payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ADD CONSTRAINT `fk_billing_billing_cycle_previous_billing_cycle_id` FOREIGN KEY (`previous_billing_cycle_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `compliance_product_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `primary_credit_note_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date (BILL_PERIOD_END)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date (BILL_PERIOD_START)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State/Province');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'open|in_collection|closed|written_off');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date (DUE_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount (GROSS_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status (INV_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|paid|overdue|cancelled|disputed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type (INV_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_note|debit_note|proforma|self_billing');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `is_self_billing` SET TAGS ('dbx_business_glossary_term' = 'Self‑Billing Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Timestamp (ISSUE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Net Amount (NET_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|cash|check|wire');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|failed|partial|refunded');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code (PAY_TERM_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `original_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bundle Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `deferred_revenue_flag` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `expense_account` SET TAGS ('dbx_business_glossary_term' = 'Expense Account');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `is_bundle_line` SET TAGS ('dbx_business_glossary_term' = 'Bundle Line Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `is_credit_memo` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `is_royalty_line` SET TAGS ('dbx_business_glossary_term' = 'Royalty Line Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|posted|reversed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'product|service|project|fee|charge');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Line Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `project_milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_account` SET TAGS ('dbx_business_glossary_term' = 'Revenue Account');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'percentage_of_completion|completed_contract|point_in_time');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|HRS');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'allocated|partial|unallocated|on_account');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'full|partial|advance|on_account');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `amount_discount` SET TAGS ('dbx_business_glossary_term' = 'Payment Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `bank_value_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Value Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `batch_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|mobile|branch|mail|phone');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `discount_taken` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `early_payment_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Applied');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|letter_of_credit|cash');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `original_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|reversed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `remittance_advice_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Reference');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Payment Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Status Reason');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'invoice_payment|prepayment|deposit|refund');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'account_scheduling');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'direct|distributor|OEM|end_user');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `auto_payment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Payment Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|dormant|closed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|milestone|on_delivery');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State/Province');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `collection_stage` SET TAGS ('dbx_business_glossary_term' = 'Collection Stage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `collection_stage` SET TAGS ('dbx_value_regex' = 'early|mid|late|defaulted');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_value_regex' = 'AAA|AA|A|BBB|BB|B');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `current_ar_balance` SET TAGS ('dbx_business_glossary_term' = 'Current AR Balance');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `dunning_procedure` SET TAGS ('dbx_business_glossary_term' = 'Dunning Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `external_account_reference` SET TAGS ('dbx_business_glossary_term' = 'External Account Reference');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|EDI|portal|paper');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `payment_due_day_of_month` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Day of Month');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|direct_debit');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|direct_debit');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_region_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Region Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'VAT Identification Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Dispute Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Disputing Party Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Invoice Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|resolved|escalated|closed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `reason_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Category');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'credit_issued|payment_confirmed|partial_adjustment|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `collections_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Agent Identifier (CAI)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `case_close_date` SET TAGS ('dbx_business_glossary_term' = 'Case Close Timestamp (CCT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description (CD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Collection Case Number (CCN)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `case_open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Timestamp (COT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Case Status (CCS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|escalated|resolved|closed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `case_strategy` SET TAGS ('dbx_business_glossary_term' = 'Collection Strategy (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `case_strategy` SET TAGS ('dbx_value_regex' = 'standard|intensive|legal|write_off_candidate');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `collection_source_system` SET TAGS ('dbx_business_glossary_term' = 'Collection Source System (CSS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `collection_stage` SET TAGS ('dbx_business_glossary_term' = 'Collection Stage (CSG)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `collection_stage` SET TAGS ('dbx_value_regex' = 'detection|reminder|escalation|legal|write_off');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `communication_method` SET TAGS ('dbx_business_glossary_term' = 'Communication Method (CM)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `communication_method` SET TAGS ('dbx_value_regex' = 'email|letter|phone|legal');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `customer_response_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Status (CRS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `customer_response_status` SET TAGS ('dbx_value_regex' = 'responded|no_response|partial');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `dunning_charges` SET TAGS ('dbx_business_glossary_term' = 'Dunning Charges (DC)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Dunning Date (DD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level (DL)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag (EF)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ERI)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `gross_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Exposure Amount (GEA)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `legal_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Flag (LAF)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `net_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Exposure Amount (NEA)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Date (NAD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `payment_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Flag (PAF)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `payment_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Type (PAT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `payment_arrangement_type` SET TAGS ('dbx_value_regex' = 'installment|full|partial');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `promise_to_pay_date` SET TAGS ('dbx_business_glossary_term' = 'Promise‑to‑Pay Date (PTPD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `promised_amount` SET TAGS ('dbx_business_glossary_term' = 'Promised Payment Amount (PPA)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date (RD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ALTER COLUMN `write_off_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Candidate Flag (WOCF)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party ID (Contract Party ID)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Document ID (Billing Document ID)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation ID (Performance Obligation ID)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (Adjustment Reason)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Code (Cost Account Code)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold Amount (COGS Amount)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Record Creation Timestamp)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (Currency Code)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Amount (Deferred Amount)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description (Event Description)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (Effective End Date)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (Effective Start Date)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `is_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Is Adjusted Flag (Is Adjusted Flag)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Recognition Status (Recognition Status)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'pending|recognized|reversed|adjusted');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recognition Timestamp (Recognition Timestamp)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_type` SET TAGS ('dbx_business_glossary_term' = 'Recognition Type (Recognition Type)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_type` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|milestone|percentage_of_completion');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Amount (Recognized Amount)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Account Code (Revenue Account Code)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Amount (Total Contract Amount)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference (Transaction Reference)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Record Update Timestamp)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` SET TAGS ('dbx_subdomain' = 'account_scheduling');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst ID (CAI)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Block Flag (CBF)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_check_method` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Method (CCM)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_check_method` SET TAGS ('dbx_value_regex' = 'automated|manual|external');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Credit Horizon (CH)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_limit_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Number (CLN)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Status (CLS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CCY)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `current_exposure` SET TAGS ('dbx_business_glossary_term' = 'Current Credit Exposure (CCE)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LRD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount (CLA)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Type (CLT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'individual|group');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NRD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Notes (CLN)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Category (CRC)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Percentage (CUP)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` SET TAGS ('dbx_subdomain' = 'account_scheduling');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Project WBS Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `actual_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Billed Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `actual_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Billing Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'planned|ready_to_bill|billed|on_hold|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `is_retention_applicable` SET TAGS ('dbx_business_glossary_term' = 'Retention Applicable Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Billing Milestone Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Milestone Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'advance_payment|progress_billing|final_billing|retention_release');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `percentage_complete_trigger` SET TAGS ('dbx_business_glossary_term' = 'Percentage Complete Trigger');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `planned_billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Billing Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `planned_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Billing Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Determination ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `reverse_charge_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reverse Charge Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_value_regex' = 'standard|manual|engine|rule_based');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_jurisdiction_country` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Country (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Region Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_line_description` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_line_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_line_status` SET TAGS ('dbx_value_regex' = 'pending|applied|rejected|adjusted');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_override_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Override Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Override Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_source_system` SET TAGS ('dbx_business_glossary_term' = 'Tax Source System');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'VAT|GST|sales_tax|withholding_tax|excise_duty');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Validated Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Validated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `taxable_quantity` SET TAGS ('dbx_business_glossary_term' = 'Taxable Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `advance_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `advance_payment_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `advance_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `advance_payment_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|fully_cleared|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `advance_type` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `advance_type` SET TAGS ('dbx_value_regex' = 'down_payment|progress_payment|retention|security_deposit');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount (Foreign Currency)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online|offline|mobile|branch');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|credit_card|cash|check|wire');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Request Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `special_gl_flag` SET TAGS ('dbx_business_glossary_term' = 'Special GL Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'manager|director|cfo|vp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Comments');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `reason` SET TAGS ('dbx_value_regex' = 'bankruptcy|dispute_settled|aged_debt|legal_settlement|goodwill');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `recovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|closed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ALTER COLUMN `write_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `intercompany_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `external_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'External Invoice Reference');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `intercompany_markup_pct` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Markup Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Invoice Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|open|posted|closed|cancelled|reversed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `issuing_company_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `original_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|due_on_receipt');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Posted Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'unsettled|settled|partial|failed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'goods_transfer|service_charge|cost_allocation|royalty|management_fee');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `transfer_price_basis` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Basis');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `transfer_price_basis` SET TAGS ('dbx_value_regex' = 'cost|market|list|custom');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `base_payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Base Payment Term Id');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `base_payment_term_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `allowed_payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Allowed Payment Channel');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `allowed_payment_channel` SET TAGS ('dbx_value_regex' = 'online|offline|mobile|mail|api');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `allowed_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Allowed Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `allowed_payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|cash|check|wire|direct_debit');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `applicable_invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Invoice Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `applicable_invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit|debit|proforma|rebate');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `early_payment_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Days');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `early_payment_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percent');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Term Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `max_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `min_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `net_days` SET TAGS ('dbx_business_glossary_term' = 'Net Days');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending|suspended|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `penalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Penalty Rate Percent');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'percentage|flat_fee');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'net|discount|milestone|retention|custom');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` SET TAGS ('dbx_subdomain' = 'account_scheduling');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `previous_billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Billing Cycle Id');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `previous_billing_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_day_of_month` SET TAGS ('dbx_business_glossary_term' = 'Billing Day Of Month');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_weekday` SET TAGS ('dbx_business_glossary_term' = 'Billing Weekday');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `cutoff_day` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Day');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `default_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Default Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `interval_count` SET TAGS ('dbx_business_glossary_term' = 'Interval Count');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Interval Unit');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `is_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Is Fixed Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_cycle` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
