-- Schema for Domain: billing | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`billing` COMMENT 'Billing and revenue domain serving as the SSOT for all customer invoices, billing cycles, payment processing, revenue recognition, credit management, collections, payment terms, accounts receivable, and billing dispute resolution across product sales, service contracts, and project-based engagements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Project financial reporting requires each invoice to be tied to the originating project header for profitability analysis.',
    `asset_plant_id` BIGINT COMMENT 'Foreign key linking to asset.asset_plant. Business justification: In manufacturing, the issuing plant determines the legal entity, VAT registration, and tax jurisdiction on an invoice. Plant-level invoice reporting (revenue by plant, intercompany billing reconciliat',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: An invoice is issued against a billing account — the billing_account is the SSOT for the financial relationship between the manufacturer and the customer in the billing domain. This FK establishes the',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Invoice billing address drives tax jurisdiction determination, VAT compliance, and regulatory reporting in manufacturing. Normalizing to customer.address eliminates denormalized address fields and ena',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: B2B manufacturing invoices are addressed to a specific AP contact at the customer for electronic invoice delivery (EDI, e-invoicing mandates). Linking invoice to customer_contact enables automated rou',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: Delivery-based billing is the standard manufacturing trigger: invoices are created after goods issue against a delivery document. AR teams reconcile invoices to deliveries for revenue recognition, dis',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Lease billing process requires each invoice to reference the leased equipment for revenue recognition and asset tracking.',
    `field_service_order_id` BIGINT COMMENT 'Foreign key linking to service.field_service_order. Business justification: Field service billing: after a field service order is completed (labor, travel, parts), an invoice is raised against it. Manufacturing service billing requires tracing each invoice to the originating ',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: REQUIRED: Invoice‑Generation process needs to trace each invoice to its originating sales order for order‑to‑invoice reconciliation and audit reporting.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Order‑to‑cash process maps each invoice to its originating order intake record for fulfillment and billing reconciliation.',
    `primary_credit_note_invoice_id` BIGINT COMMENT 'Identifier of the related credit note, if this invoice is a credit note.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: NRE (non-recurring engineering) and milestone billing: ETO manufacturers invoice customers directly against engineering projects for design, tooling, and qualification work. A billing domain expert ex',
    `rma_id` BIGINT COMMENT 'Foreign key linking to order.order_rma. Business justification: Credit memo invoices in manufacturing are issued against approved RMAs. Finance and AR teams must link the credit note invoice to the originating RMA for refund processing, customer account reconcilia',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Commission reports need each invoice linked to the sales rep who closed the deal; essential for performance and payout calculations.',
    `sla_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_agreement. Business justification: SLA-based billing in manufacturing generates periodic invoices (annual fees, service charges) tied to specific SLA agreements. Finance teams must trace each invoice back to the governing SLA contract ',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Warehouse of origin is required for logistics cost allocation, export reporting, and inventory valuation per invoice.',
    `warranty_id` BIGINT COMMENT 'Foreign key linking to service.service_warranty. Business justification: Warranty claim invoicing: in manufacturing, warranty repair work generates invoices (zero-value, credit, or cost-recovery) tied to the warranty record. Invoice-to-warranty traceability supports warran',
    `billing_period_end` DATE COMMENT 'End date of the billing period covered by the invoice.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period covered by the invoice.',
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
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: CAPA-driven supplier charge-back billing is a standard manufacturing process: when a CAPA identifies a supplier-caused defect, a debit/charge-back invoice line is raised against the CAPA record for co',
    `catalog_entry_id` BIGINT COMMENT 'Foreign key linking to product.catalog_entry. Business justification: Each invoice line in manufacturing billing must trace back to the catalog entry that governed its unit price, minimum order quantity, and price UOM. This supports line-level price variance analysis, c',
    `compliance_test_id` BIGINT COMMENT 'Foreign key linking to quality.compliance_test. Business justification: Compliance testing costs (third-party lab fees, regulatory certification tests) are invoiced to customers or charged internally in manufacturing. compliance_test carries test_cost_amount and test_cost',
    `delivery_item_id` BIGINT COMMENT 'Foreign key linking to order.delivery_item. Business justification: Invoice lines in manufacturing billing correspond to specific delivery items (billed quantity = delivered quantity per item). Revenue recognition, short-shipment disputes, and credit note processing a',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Customer-funded ECO billing: contract manufacturers charge customers for engineering change implementation. Invoice lines for ECO processing fees must reference the specific ECO. This is a standard bi',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Service‑charge line items must identify the exact equipment serviced to allocate costs and support maintenance cost analysis.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Inspection Service Billing – each inspection lot performed for a customer is charged as a line item on the invoice.',
    `invoice_id` BIGINT COMMENT 'Identifier of the parent invoice header to which this line belongs.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Manufacturing traceability requires linking each billed line item to the specific lot/batch shipped. Supports product recall management, ISO 9001 traceability reporting, and regulatory compliance (FDA',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Invoice line items need to reference the exact material being billed. Adding material_master_id (FK → inventory.material_master.material_master_id) creates a proper parent‑child relationship and remov',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: NCR Cost Recovery – non‑conformance handling costs are billed to the customer via a dedicated invoice line.',
    `order_confirmation_id` BIGINT COMMENT 'Foreign key linking to production.order_confirmation. Business justification: Confirmation-based billing: each invoice line for manufactured goods traces to the specific production order confirmation (yield_quantity, actual_cost_amount) that triggered it. Supports revenue recog',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: REQUIRED: Revenue recognition and audit trails require linking each invoice line to the specific order line it bills.',
    `original_invoice_line_id` BIGINT COMMENT 'Reference to the original invoice line that this credit memo line reverses.',
    `part_consumption_id` BIGINT COMMENT 'Foreign key linking to service.part_consumption. Business justification: Parts billing reconciliation: each invoice line for parts consumed during service must trace to the part_consumption record to validate quantities, unit prices, and warranty/contract coverage. Manufac',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.asset_pm_schedule. Business justification: Service contract billing in manufacturing ties each recurring invoice line to the PM schedule item being billed (scheduled maintenance event). This enables contract billing reconciliation — verifying ',
    `price_book_entry_id` BIGINT COMMENT 'Foreign key linking to sales.price_book_entry. Business justification: Manufacturing invoices must be auditable against the contracted price book entry for pricing compliance, revenue recognition, and customer dispute resolution. Tracing invoice_line to the price_book_en',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Milestone billing: individual invoice lines represent specific engineering project milestones (design review, prototype, PPAP). The existing project_milestone_code is a denormalized reference; a prope',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Manufacturing billing teams reconcile each invoice line against the originating quote line to verify unit price, discount, and committed delivery terms. This supports revenue recognition accuracy, pri',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Revenue recognition and product cost allocation require each invoice line to reference the sold SKU; this mapping is essential for financial reporting and compliance.',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to engineering.test_result. Business justification: Engineering test services billing: PPAP, FAI, DVP&R, and qualification testing are billed to customers as line items. The invoice line must reference the specific test_result record to support audit t',
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
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Payments are allocated to projects to track cash flow against project budgets and enable project‑level cash reconciliation.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Payments are received and processed against a billing account — the billing_account is the financial account entity in the billing domain. This FK links each payment to its owning billing account, ena',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Anti‑money‑laundering and financial‑regulation monitoring ties each payment to the relevant regulatory requirement.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: NRE milestone payment tracking: customers make staged payments against engineering projects (tooling deposits, prototype payments, PPAP completion). Linking payment to engineering_project enables proj',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Advance or partial payments are tied to a specific order intake for accurate order financing and tracking.',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to service.service_contract. Business justification: Service contract payment allocation: manufacturing customers make periodic payments against service contracts (annual maintenance fees). Payment-to-service-contract traceability is required for contra',
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
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Billing account address governs invoice delivery method, tax jurisdiction assignment, and dunning correspondence in manufacturing ERP. Normalizing to customer.address master eliminates denormalized fi',
    `customer_account_id` BIGINT COMMENT 'add column customer_account_id (BIGINT) with FK to customer.customer_account.customer_account_id - billing accounts must link to the customer they belong to for AR reconciliation',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: In manufacturing, billing accounts are owned by a key account sales rep for AR aging reports segmented by rep, commission reconciliation, and escalation routing. No existing FK links billing_account t',
    `account_name` STRING COMMENT 'Human‑readable name of the billing account (e.g., customer or partner name).',
    `account_number` STRING COMMENT 'External account number used in invoicing and payment processing.',
    `account_type` STRING COMMENT 'Classification of the account relationship (direct, distributor, OEM, end‑user).. Valid values are `direct|distributor|OEM|end_user`',
    `auto_payment_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment processing is active.',
    `billing_account_status` STRING COMMENT 'Current lifecycle status of the billing account.. Valid values are `active|blocked|dormant|closed`',
    `billing_frequency` STRING COMMENT 'How often invoices are generated for the account.. Valid values are `monthly|quarterly|annual|milestone|on_delivery`',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` (
    `credit_limit_id` BIGINT COMMENT 'System-generated unique identifier for the credit limit record.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Credit limits are managed at the billing account level in the billing domain. The credit_limit record defines the approved credit exposure for a billing account, and this FK establishes that in-domain',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: The billing-side credit limit record is derived from the CRM/customer-master credit profile assessment. AR teams trace which credit profile evaluation drove the current approved credit limit for audit',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` (
    `tax_determination_id` BIGINT COMMENT 'System-generated unique identifier for the tax determination record.',
    `invoice_id` BIGINT COMMENT 'Identifier of the billing document (invoice) to which this tax determination applies.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Tax determination records are calculated at the invoice line level — each tax_determination entry captures jurisdiction-specific tax for a specific line item. Currently tax_determination has invoice_i',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product or service line item that the tax is calculated for.',
    `supply_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plant. Business justification: Tax jurisdiction in manufacturing is determined by the ship-from plant location (country, state/region). Linking tax_determination to supply_plant enables automated derivation of tax_jurisdiction_coun',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` (
    `payment_application_id` BIGINT COMMENT 'Unique identifier for this payment application record',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to the invoice receiving payment allocation',
    `payment_id` BIGINT COMMENT 'Foreign key linking to the payment being applied',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The specific amount of the payment allocated to this invoice in this application record',
    `allocation_date` TIMESTAMP COMMENT 'Timestamp when this specific payment-to-invoice allocation was executed',
    `allocation_sequence` BIGINT COMMENT 'Sequential order in which this allocation was applied when a payment is split across multiple invoices',
    `allocation_status` STRING COMMENT 'Status of this specific payment-to-invoice allocation',
    `allocation_type` STRING COMMENT 'Nature of this allocation indicating whether it fully or partially satisfies the invoice',
    `clearing_status` STRING COMMENT 'Current clearing status of this specific payment-to-invoice allocation in the financial system',
    `discount_taken` DECIMAL(18,2) COMMENT 'Monetary discount amount applied in this specific payment-to-invoice allocation',
    `early_payment_discount_applied` BOOLEAN COMMENT 'Indicates whether an early-payment discount was applied to this specific allocation',
    CONSTRAINT pk_payment_application PRIMARY KEY(`payment_application_id`)
) COMMENT 'This association product represents the cash application event between payment and invoice. It captures the allocation of customer payment amounts to specific invoices in the accounts receivable process. Each record links one payment to one invoice with attributes that exist only in the context of this allocation relationship, supporting partial payments, split payments across multiple invoices, and on-account payments pending allocation.. Existence Justification: In manufacturing billing operations, payment application (cash application) is a recognized AR business process where customer payments are matched and allocated to invoices. In real operations, bulk remittance payments routinely cover multiple invoices (one payment → many invoices), and large project invoices frequently receive multiple installment payments over time (one invoice → many payments). The business actively manages payment applications as operational records with specific allocation amounts, dates, statuses, and clearing information.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_primary_credit_note_invoice_id` FOREIGN KEY (`primary_credit_note_invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_original_invoice_line_id` FOREIGN KEY (`original_invoice_line_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ADD CONSTRAINT `fk_billing_credit_limit_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ADD CONSTRAINT `fk_billing_tax_determination_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ADD CONSTRAINT `fk_billing_tax_determination_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment`(`payment_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `primary_credit_note_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Order Rma Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Agreement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Service Warranty Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date (BILL_PERIOD_END)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date (BILL_PERIOD_START)');
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
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `compliance_test_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Test Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `delivery_item_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Item Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `order_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmation Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `original_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `part_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Part Consumption Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'cash_application');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'customer_accounts');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'direct|distributor|OEM|end_user');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `auto_payment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Payment Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|dormant|closed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|milestone|on_delivery');
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
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` SET TAGS ('dbx_subdomain' = 'customer_accounts');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `tax_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Determination ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plant Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` SET TAGS ('dbx_subdomain' = 'cash_application');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` SET TAGS ('dbx_association_edges' = 'billing.payment,billing.invoice');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `payment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Application ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Application - Invoice Id');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Application - Payment Id');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `allocation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Allocation Sequence');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `discount_taken` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_application` ALTER COLUMN `early_payment_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Applied');
