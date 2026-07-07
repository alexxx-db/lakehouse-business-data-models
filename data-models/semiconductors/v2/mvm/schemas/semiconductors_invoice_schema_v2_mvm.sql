-- Schema for Domain: invoice | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:14:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`invoice` COMMENT 'Billing, invoicing, payment processing, and revenue collection. SSOT for customer invoices, NRE billing milestones, credit memos, payment terms, credit management, accounts receivable, pricing models including volume discounts, royalty billing for IP licensing, and revenue recognition.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique system-generated identifier for the invoice record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer billed on the invoice.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Links invoice to a normalized address record for tax jurisdiction and export‑control validation; required by regulatory reporting.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Required for Accounts Receivable to send invoice notices to the designated billing contact; standard practice in semiconductor B2B invoicing.',
    `customer_contract_id` BIGINT COMMENT 'Identifier of the underlying contract or agreement (e.g., NRE milestone, royalty agreement).',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: REQUIRED: Opportunity‑to‑revenue attribution; enables pipeline performance reporting that ties closed opportunities to actual invoiced revenue.',
    `assembly_order_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_order. Business justification: Required for the Packaging Service Billing Report, which matches each invoice to the underlying assembly order that generated the packaged product.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Semiconductor invoices are generated against negotiated price agreements (volume tiers, NRE pricing, design-win discounts). Revenue audit, price compliance verification, and dispute resolution all req',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: Invoices reference a payment‑term master; adding payment_term_id FK normalizes payment terms and removes the redundant free‑text payment_terms column.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Regional revenue reporting in semiconductor sales requires invoices to be attributed to the canonical sales territory for quota attainment, commission calculation, and geographic revenue analysis. The',
    `to_payment_term_id` BIGINT COMMENT 'FK to invoice.payment_term.payment_term_id — Every invoice must reference its applicable payment terms to calculate due date and discount eligibility. Required for AR aging and cash forecasting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was approved for posting.',
    `ar_invoice_status` STRING COMMENT 'Current lifecycle state of the invoice.. Valid values are `draft|open|posted|paid|cancelled|disputed`',
    `auditor_notes` STRING COMMENT 'Comments added by internal auditors during review.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was cancelled, if applicable.',
    `collection_status` STRING COMMENT 'Current state of the collections process for the invoice.. Valid values are `not_started|in_progress|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency used for the invoice.',
    `customer_name` STRING COMMENT 'Legal name of the invoicing customer.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the invoice (e.g., early‑payment or volume discount).',
    `document_type` STRING COMMENT 'Classification of the invoice (commercial sale, pro‑forma for customs, or inter‑company transfer).. Valid values are `commercial|proforma|intercompany`',
    `due_date` DATE COMMENT 'Date by which payment is expected according to payment terms.',
    `early_payment_discount` DECIMAL(18,2) COMMENT 'Percentage discount offered for early settlement, if applicable.',
    `ecn_classification` STRING COMMENT 'Classification used for export control compliance.. Valid values are `^[A-E]d{4}$`',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether the invoice is subject to export control regulations.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and adjustments.',
    `hs_code` STRING COMMENT 'Customs classification code for the shipped product.. Valid values are `^d{6,10}$`',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities.. Valid values are `EXW|FOB|CIF|DDP`',
    `invoice_date` DATE COMMENT 'Date the invoice was generated and sent to the customer.',
    `invoice_number` STRING COMMENT 'External business identifier assigned to the invoice by the billing system.',
    `is_credit_memo` BOOLEAN COMMENT 'True if the document is a credit memo rather than a standard invoice.',
    `is_proforma` BOOLEAN COMMENT 'True if the document is a pro‑forma invoice used for customs or advance payment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the ar invoice record in the invoice domain.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Penalty amount applied when payment is received after the due date.',
    `line_item_count` STRING COMMENT 'Number of line items included on the invoice.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the ar invoice record in the invoice domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and discounts.',
    `payment_method` STRING COMMENT 'Means by which the customer intends to settle the invoice.. Valid values are `wire|credit_card|check|paypal|bank_transfer`',
    `payment_status` STRING COMMENT 'Current status of payment collection for the invoice.. Valid values are `unpaid|partial|paid|overdue|refunded`',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was posted to the general ledger.',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger.',
    `remarks` STRING COMMENT 'Free‑form notes entered by billing staff.',
    `shipping_address` STRING COMMENT 'Delivery location for the goods or services covered by the invoice.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the invoice.',
    `tax_code` STRING COMMENT 'Code that determines tax rate and calculation rules for the invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the invoice record.',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Authoritative accounts receivable invoice record for all customer billing transactions in the semiconductor business. Captures the full invoice lifecycle from draft through posted, sent, disputed, and paid states. Covers commercial product shipment invoices, NRE milestone billing, IP royalty invoices, service invoices, and pro-forma documents for customs/LC/advance payment purposes. Includes document_type classification (commercial, proforma, intercompany) with proforma-specific attributes for HS/HTS codes, ECCN classification, incoterms, and export control documentation. Sourced from SAP S/4HANA SD and FI modules. SSOT for all customer-facing billing documents.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'System-generated unique identifier for each invoice line item.',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Supports lot‑based invoicing; each line item must reference the specific assembly lot shipped, enabling the Lot Shipment Billing report.',
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Bin-based pricing is standard in semiconductor sales — speed/power bins command different unit prices. Invoice lines for binned devices must reference the bin_definition to support bin-grade pricing v',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Booking-to-invoice-line traceability supports backlog-to-billing reconciliation and line-level revenue recognition in semiconductor manufacturing. Each invoice line must reference the booking event th',
    `customer_contract_id` BIGINT COMMENT 'Reference to a contract (e.g., NRE or royalty agreement) governing this line.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Customer billing per tool usage is recorded on invoice lines; linking to fab_tool provides detailed cost allocation and OEE reporting.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Final Test Run Billing Reconciliation – each invoice line for test services must reference the specific final_test_run to match revenue with test yield and satisfy audit requirements.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the invoice line invoice entity.',
    `ip_core_id` BIGINT COMMENT 'Identifier of the IP core associated with a royalty line.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Semiconductor equipment service contracts bill customers for specific maintenance events (corrective repairs, upgrades). The invoice line for a maintenance service charge must reference the triggering',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: Credit memo and quality-adjustment invoice lines in semiconductor billing must reference the NCR that triggered the adjustment. ASC 606 revenue adjustment reporting and customer debit/credit reconcili',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Invoice lines are generated from order lines; linking enables traceability for revenue recognition, audit, and dispute resolution.',
    `package_qualification_id` BIGINT COMMENT 'Foreign key linking to packaging.package_qualification. Business justification: NRE (Non-Recurring Engineering) invoice lines for package qualification services are standard in semiconductor OSAT billing. The invoice line must reference the package_qualification record to support',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Ensures invoice line package type references the master package_type table for compliance and cost reporting, replacing the free-text packaging_type field.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: invoice_line currently stores payment_terms as a free-text STRING column, which is a denormalization of the payment_term master reference table. In semiconductor contracts, individual line items can c',
    `photomask_id` BIGINT COMMENT 'Foreign key linking to fabrication.photomask. Business justification: Photomasks are NRE (Non-Recurring Engineering) assets billed as separate line items in semiconductor foundry invoicing. An invoice_line for mask NRE charges must reference the specific photomask procu',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Multi-product semiconductor invoices can have different price agreements per line (e.g., different IC families under separate pricing contracts). Line-level price_agreement linkage enables granular pr',
    `ar_invoice_id` BIGINT COMMENT 'Identifier of the parent invoice to which this line belongs.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Quote-to-invoice line traceability is required for pricing audit, dispute resolution, and revenue reconciliation in semiconductor order-to-cash. A domain expert expects invoice lines to reference the ',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to equipment.spare_part. Business justification: Spare parts are sold or billed to customers under equipment service contracts and spare parts sales programs. An invoice line for a spare part charge must reference the spare_part record to support pa',
    `to_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Fundamental header-to-line relationship. Every invoice line must reference its parent invoice. Without this FK, the domain cannot function — you cannot construct an invoice document.',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: NRE (Non-Recurring Engineering) fees for tool qualification runs are standard semiconductor billing items. An invoice line for a qualification service charge must reference the specific tool_qualifica',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Wafer probe services are billed per run in foundry/OSAT operations. Invoice lines for wafer-level test services must reference the specific wafer_probe_run to support billing reconciliation, yield-bas',
    `wafer_start_id` BIGINT COMMENT 'Foreign key linking to fabrication.wafer_start. Business justification: Wafer start authorization fees and prototype/engineering lot start charges are billed as invoice line items in semiconductor foundry operations. Linking invoice_line to wafer_start enables billing tea',
    `billing_period_end` DATE COMMENT 'End date of the billing period covered by this line.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period covered by this line.',
    `charge_type` STRING COMMENT 'Category of the charge (e.g., product sale, service, NRE milestone, royalty, wafer lot, packaging).. Valid values are `product|service|nre|royalty|wafer_lot|packaging`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the amounts.',
    `invoice_line_description` STRING COMMENT 'The description of the invoice line record in the invoice domain.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to this line.',
    `effective_date` DATE COMMENT 'Date when the line becomes effective for accounting purposes.',
    `extended_amount` DECIMAL(18,2) COMMENT 'The extended amount of the invoice line record in the invoice domain.',
    `external_reference` STRING COMMENT 'Identifier from an external system (e.g., ERP or billing platform) for traceability.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before discounts and taxes (quantity × unit_price).',
    `is_discount_applied` BOOLEAN COMMENT 'True if a discount was applied to this line.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether tax is exempt for this line.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the invoice line record in the invoice domain.',
    `line_description` STRING COMMENT 'Free‑form description of the billed item or service.',
    `line_number` STRING COMMENT 'The line number of the invoice line record in the invoice domain.',
    `line_status` STRING COMMENT 'Current processing status of the line item.. Valid values are `open|posted|cancelled|adjusted`',
    `model_lineage_source` STRING COMMENT 'Indicates this product is a referrer in SSOT resolution; authoritative data lives in the owner product',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after discounts and taxes.',
    `notes` STRING COMMENT 'Additional free‑form comments or internal notes for the line.',
    `product_name` STRING COMMENT 'Human‑readable name of the product or service.',
    `product_sku` STRING COMMENT 'Manufacturer-assigned SKU for the billed product.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units billed on this line.',
    `revenue_recognition_category` STRING COMMENT 'Accounting treatment for revenue timing.. Valid values are `upfront|milestone|periodic|upon_delivery`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied for royalty‑based charges.',
    `sales_channel` STRING COMMENT 'Channel through which the sale was made.. Valid values are `direct|distributor|online|partner`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the line.',
    `sequence` STRING COMMENT 'Sequential order of the line within the invoice.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax calculated for this line based on tax_code.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., pieces, sets, kilograms).. Valid values are `pcs|sets|kg|mm|inch`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit before discounts and taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line items on a customer invoice, each representing a distinct billable element such as a specific IC product SKU shipment, an NRE milestone charge, an IP royalty fee, a wafer lot charge, or a packaging service fee. Captures quantity, unit price, extended amount, tax code, revenue recognition category, and product/service reference. Supports multi-line invoices with mixed billing types.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` (
    `payment_receipt_id` BIGINT COMMENT 'System-generated unique identifier for the payment receipt record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who made the payment.',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: Semiconductor LTSAs include volume commitments and milestone payment schedules. Linking payment receipts to the governing customer contract enables contract-level cash collection tracking, volume comm',
    `ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Payment receipts must reference the invoices they clear. This is the core cash application relationship enabling AR aging accuracy and payment reconciliation.',
    `reversal_reference_payment_receipt_id` BIGINT COMMENT 'Reference to the original payment receipt being reversed.',
    `to_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Payments must be applied against invoices for AR clearing. This is the fundamental cash application link. After merge with payment_allocation, this becomes the primary clearing relationship.',
    `allocated_amount_total` DECIMAL(18,2) COMMENT 'Sum of amounts allocated to invoices from this payment.',
    `amount_received` DECIMAL(18,2) COMMENT 'The amount received of the payment receipt record in the invoice domain.',
    `bank_reference` STRING COMMENT 'Reference number provided by the bank for the transaction.',
    `compliance_check_status` STRING COMMENT 'Result of compliance checks (e.g., sanctions, AML) for the payment.. Valid values are `passed|failed|pending`',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Timestamp when compliance check was performed.',
    `created_by_user` STRING COMMENT 'User ID of the person who created the receipt record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the payment receipt record in the invoice domain.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code of the payment.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount taken on the payment, e.g., early payment discount.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if payment currency differs from functional currency.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the companys functional currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the payment receipt record in the invoice domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the payment receipt record in the invoice domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and discount.',
    `number_of_allocations` STRING COMMENT 'Count of invoice allocations linked to this payment receipt.',
    `on_account_payment_flag` BOOLEAN COMMENT 'True if the payment is recorded as an on-account credit not yet allocated to specific invoices.',
    `overpayment_flag` BOOLEAN COMMENT 'Indicates if the payment amount exceeds the total invoiced amount.',
    `partial_payment_flag` BOOLEAN COMMENT 'Indicates if the payment only partially covers the invoiced amount.',
    `payer_account_number` STRING COMMENT 'Bank account number of the payer.',
    `payer_bank_code` STRING COMMENT 'Identifier (e.g., SWIFT/BIC) of the payers bank.',
    `payer_name` STRING COMMENT 'Legal name of the entity making the payment.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The payment amount of the payment receipt record in the invoice domain.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was processed.. Valid values are `online|batch|manual|api`',
    `payment_date` DATE COMMENT 'Date the payment was received.',
    `payment_method` STRING COMMENT 'Method used to make the payment.. Valid values are `wire|ach|check|letter_of_credit|cash`',
    `payment_status` STRING COMMENT 'Current processing status of the payment.. Valid values are `pending|cleared|reconciled|reversed|failed`',
    `payment_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the payment was recorded in the system.',
    `payment_type` STRING COMMENT 'Indicates whether the payment is domestic or international.. Valid values are `domestic|international`',
    `receipt_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the receipt record was created in the system.',
    `receipt_date` DATE COMMENT 'The receipt date associated with the payment receipt invoice record.',
    `receipt_number` STRING COMMENT 'External receipt number assigned by the finance system.',
    `receipt_status` STRING COMMENT 'The receipt status of the payment receipt record in the invoice domain.',
    `receipt_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the receipt record.',
    `remittance_advice` STRING COMMENT 'Textual remittance information supplied by the payer.',
    `residual_open_amount` DECIMAL(18,2) COMMENT 'Remaining unallocated amount after allocations.',
    `reversal_indicator` BOOLEAN COMMENT 'True if this receipt represents a reversal of a previously posted payment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the payment, if applicable.',
    `to_ar_invoice` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Payment receipts must link to the invoices they clear. Required for cash application, AR aging, and bank reconciliation.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross amount received before any deductions.',
    `updated_by_user` STRING COMMENT 'User ID of the person who last updated the receipt record.',
    CONSTRAINT pk_payment_receipt PRIMARY KEY(`payment_receipt_id`)
) COMMENT 'Records of customer payments received, their line-level allocation against outstanding invoices, and cash application status. Captures payment header (date, method — wire/ACH/check/LC, amount, currency, bank reference, remittance advice) and line-level allocation details (allocated amount per invoice, allocation date, clearing document reference, partial payment flag, discount taken, residual open amount). Supports partial payments, overpayments, multi-invoice payment runs, on-account payments, payment reversals, and complex allocation scenarios. Enables accurate AR aging, cash application tracking, and bank reconciliation. SSOT for all customer payment receipts, their invoice clearing allocations, and cash application — subsumes all payment_allocation concepts.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'System-generated unique identifier for the payment term record.',
    `applicable_to_customer_type` STRING COMMENT 'Customer segment(s) to which this payment term applies.. Valid values are `new|existing|vip|all`',
    `approved_by_user` STRING COMMENT 'User identifier who approved the payment term.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment term was approved for use.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) that this payment term must satisfy.. Valid values are `SOX|ITAR|EAR|RoHS|REACH|GDPR`',
    `created_by_user` STRING COMMENT 'User identifier who created the payment term record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment term record was first created.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed under this payment term.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code applicable to the term.. Valid values are `[A-Z]{3}`',
    `payment_term_description` STRING COMMENT 'Free‑form description of the payment term and its business rationale.',
    `discount_days` STRING COMMENT 'The discount days of the payment term record in the invoice domain.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The discount percent of the payment term record in the invoice domain.',
    `early_payment_discount_days` STRING COMMENT 'Number of days within which the early payment discount applies.',
    `early_payment_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount offered for early payment.',
    `effective_from` DATE COMMENT 'Date when the payment term becomes binding.',
    `effective_until` DATE COMMENT 'Date when the payment term expires; null for open‑ended terms.',
    `grace_period_days` STRING COMMENT 'Additional days after due date before penalties commence.',
    `is_active` BOOLEAN COMMENT 'The is active of the payment term record in the invoice domain.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this term is the default for new customers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the payment term record in the invoice domain.',
    `late_payment_penalty_days` STRING COMMENT 'Number of days after due date when the penalty starts to accrue.',
    `late_payment_penalty_percent` DECIMAL(18,2) COMMENT 'Percentage penalty applied after the due date.',
    `legal_reference` STRING COMMENT 'Reference to the legal document governing the payment term.',
    `letter_of_credit_required` BOOLEAN COMMENT 'Indicates whether a letter of credit is mandatory for this term.',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'Cap on the monetary value of early payment discounts.',
    `max_penalty_amount` DECIMAL(18,2) COMMENT 'Cap on the monetary value of late payment penalties.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the payment term record in the invoice domain.',
    `net_days` STRING COMMENT 'Number of days after invoice date when payment is due (e.g., 30 for Net 30).',
    `notes` STRING COMMENT 'Supplementary free‑text notes or remarks.',
    `payment_method_allowed` STRING COMMENT 'Payment instruments permitted for this term.. Valid values are `wire|ach|credit_card|paypal|check|other`',
    `payment_term_status` STRING COMMENT 'Current lifecycle status of the payment term.. Valid values are `active|inactive|pending|retired`',
    `tax_inclusive` BOOLEAN COMMENT 'Specifies whether the amounts are tax‑inclusive.',
    `term_code` STRING COMMENT 'External code used to reference the payment term (e.g., NET30, 2/10NET30).. Valid values are `[A-Z0-9]+(/[A-Z0-9]+)?`',
    `term_name` STRING COMMENT 'Human‑readable name of the payment term.',
    `term_type` STRING COMMENT 'Category of the payment term indicating its structure (net, discount, cash, etc.).. Valid values are `net|discount|cash|letter_of_credit|custom`',
    `updated_by_user` STRING COMMENT 'User identifier who last modified the payment term record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment term record.',
    `version_number` STRING COMMENT 'Version of the payment term for change management.',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Master reference for customer payment terms governing invoice due dates, early payment discount structures, and late payment penalty rules. Defines net payment days (e.g., Net 30, Net 60, Net 90), cash discount percentages and qualifying windows (e.g., 2/10 Net 30), letter of credit requirements, and currency-specific term variants. Assigned at customer account level with order-level override capability.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` (
    `customer_credit_limit_id` BIGINT COMMENT 'System-generated surrogate key uniquely identifying each credit limit record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer to whom the credit limit applies.',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: The operational credit_limit is derived from the analytical credit_profile (ratings, DSO, risk category). Linking these enables credit review workflows where finance teams validate that the enforced l',
    `available_credit` DECIMAL(18,2) COMMENT 'The available credit of the customer credit limit record in the invoice domain.',
    `business_unit` STRING COMMENT 'Organizational unit responsible for the customer relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the customer credit limit record in the invoice domain.',
    `credit_available_amount` DECIMAL(18,2) COMMENT 'The credit available amount of the customer credit limit record in the invoice domain.',
    `credit_currency` STRING COMMENT 'Three‑letter ISO currency code of the credit limit amount.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether the customers credit is currently on hold.',
    `credit_hold_reason` STRING COMMENT 'Free‑text explanation for why a credit hold has been applied.',
    `credit_insurance_coverage` STRING COMMENT 'Level of insurance protection covering the credit exposure.. Valid values are `none|partial|full`',
    `credit_insurance_provider` STRING COMMENT 'Name of the insurer providing credit insurance, if any.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts‑receivable exposure permitted for the customer, expressed in credit_currency.',
    `credit_limit_created` TIMESTAMP COMMENT 'Timestamp when the credit limit record was first created in the system.',
    `credit_limit_last_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the credit limit record.',
    `credit_limit_number` STRING COMMENT 'Business identifier for the credit limit agreement, used in external communications and reporting.',
    `credit_limit_status` STRING COMMENT 'Current lifecycle status of the credit limit record.. Valid values are `active|inactive|on_hold|suspended|closed`',
    `credit_limit_type` STRING COMMENT 'Classification of the credit limit (e.g., standard, NRE milestone, royalty, project‑based).. Valid values are `standard|nre_milestone|royalty|project_based`',
    `credit_rating` STRING COMMENT 'Credit rating from an external agency (e.g., Moodys, S&P).',
    `credit_review_date` DATE COMMENT 'Scheduled date for the next formal credit risk review.',
    `credit_risk_classification` STRING COMMENT 'Internal risk grade assigned to the customer based on financial health and payment history.. Valid values are `A|B|C|D|E|F`',
    `credit_used_amount` DECIMAL(18,2) COMMENT 'The credit used amount of the customer credit limit record in the invoice domain.',
    `credit_utilization_amount` DECIMAL(18,2) COMMENT 'Current total of outstanding receivables against the credit limit.',
    `credit_utilization_pct` DECIMAL(18,2) COMMENT 'Utilization expressed as a percentage of the total credit limit.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the customer credit limit invoice record.',
    `effective_date` DATE COMMENT 'The effective date associated with the customer credit limit invoice record.',
    `effective_from` DATE COMMENT 'Date on which the credit limit becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the credit limit expires or is superseded; null for open‑ended limits.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the customer credit limit record in the invoice domain.',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity within the corporate structure that owns the credit agreement.',
    `limit_adjustment_reason` STRING COMMENT 'Reason code or description for the most recent credit limit change.',
    `limit_adjustment_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent credit limit adjustment was applied.',
    `limit_status` STRING COMMENT 'The limit status of the customer credit limit record in the invoice domain.',
    `max_overdue_days` STRING COMMENT 'Maximum number of days any invoice has been overdue for this customer.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the customer credit limit record in the invoice domain.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the credit limit.',
    `overdue_amount` DECIMAL(18,2) COMMENT 'Total monetary value of invoices currently past due.',
    `payment_history_score` STRING COMMENT 'Aggregated score reflecting the customers historical payment performance.. Valid values are `excellent|good|fair|poor`',
    `region_code` STRING COMMENT 'Three‑letter country/region code where the customer is primarily located.',
    `review_date` DATE COMMENT 'The review date associated with the customer credit limit invoice record.',
    CONSTRAINT pk_customer_credit_limit PRIMARY KEY(`customer_credit_limit_id`)
) COMMENT 'Credit limit master records for each customer account defining the maximum outstanding AR exposure permitted. Captures approved credit limit amount, credit currency, credit risk classification, credit review date, credit hold status, credit insurance coverage details, and credit analyst assignment. Supports dynamic credit limit adjustments based on payment history and financial health reviews. SSOT for credit management decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` (
    `credit_hold_id` BIGINT COMMENT 'System-generated unique identifier for the credit hold record.',
    `ar_invoice_id` BIGINT COMMENT 'Identifier of the invoice that triggered the credit hold due to non‑payment.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Credit holds in semiconductor order management are placed against specific bookings when a customer exceeds their credit limit. Linking credit_hold directly to booking enables the credit team to block',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Credit holds in semiconductors require notifying a specific customer contact (finance/AP contact) for resolution. Linking credit_hold to the customer contact enables automated hold notification workfl',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Credit hold placement is directly triggered by the customers credit_profile evaluation (rating, score, analyst notes). Credit analysts must trace each hold back to the credit_profile record that just',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: credit_hold stores payment_terms as a free-text STRING, which is a denormalization. Credit holds in semiconductor AR are often associated with specific payment term violations (e.g., a customer on net',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer to whom the credit hold applies.',
    `customer_credit_limit_id` BIGINT COMMENT 'FK to invoice.customer_credit_limit.customer_credit_limit_id — Credit holds are triggered by credit limit breaches. The hold must reference the credit limit record that was exceeded for analyst review and release decisions.',
    `order_id` BIGINT COMMENT 'Unique identifier for the sales order record within the credit hold invoice entity.',
    `block_level` STRING COMMENT 'Scope of the hold: order creation, delivery release, or billing.. Valid values are `order|delivery|billing`',
    `comments` STRING COMMENT 'Free‑form notes entered by the analyst regarding the hold.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit hold record was first created in the system.',
    `credit_hold_status` STRING COMMENT 'Current lifecycle state of the credit hold.. Valid values are `active|released|cancelled|pending|expired|on_hold`',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the customer.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the hold amount.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `expiration_date` DATE COMMENT 'Optional date when the hold automatically expires if not released.',
    `hold_amount` DECIMAL(18,2) COMMENT 'Monetary amount that is blocked due to the credit hold.',
    `hold_category` STRING COMMENT 'Classification of the hold based on its origin or purpose.. Valid values are `credit_limit|overdue|risk|manual`',
    `hold_number` STRING COMMENT 'Business-visible alphanumeric identifier assigned to the credit hold event.',
    `hold_placed_timestamp` TIMESTAMP COMMENT 'Exact date and time when the credit hold was placed.',
    `hold_reason` STRING COMMENT 'Business reason why the credit hold was placed (e.g., overdue invoice, exceeded limit).',
    `hold_reason_code` STRING COMMENT 'Coded value representing the hold reason code of the credit hold invoice record.',
    `hold_reason_description` STRING COMMENT 'The hold reason description of the credit hold record in the invoice domain.',
    `hold_release_date` DATE COMMENT 'The hold release date associated with the credit hold invoice record.',
    `hold_start_date` DATE COMMENT 'The hold start date associated with the credit hold invoice record.',
    `hold_status` STRING COMMENT 'The hold status of the credit hold record in the invoice domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the credit hold record in the invoice domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the credit hold record in the invoice domain.',
    `notification_date` DATE COMMENT 'Date on which the customer was notified about the credit hold.',
    `notification_status` STRING COMMENT 'Indicates whether the customer has been notified of the hold.. Valid values are `notified|not_notified`',
    `overdue_amount` DECIMAL(18,2) COMMENT 'Outstanding amount of the overdue invoice.',
    `placed_date` DATE COMMENT 'The placed date associated with the credit hold invoice record.',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the credit hold was lifted.',
    `released_by` STRING COMMENT 'The released by of the credit hold record in the invoice domain.',
    `released_date` DATE COMMENT 'The released date associated with the credit hold invoice record.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score used to assess the customers creditworthiness at hold time.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the credit hold record.',
    CONSTRAINT pk_credit_hold PRIMARY KEY(`credit_hold_id`)
) COMMENT 'Records of credit hold events placed on customer accounts due to overdue invoices, exceeded credit limits, or financial risk triggers. Captures hold placement date, hold reason, blocking level (order block, delivery block, billing block), responsible credit analyst, customer notification status, and hold release date with authorization. Directly impacts order fulfillment and shipment release workflows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` (
    `dispute_id` BIGINT COMMENT 'System-generated unique identifier for each invoice dispute record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who raised the dispute.',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier of the original invoice linked to the dispute.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Invoice disputes in semiconductors are raised by and assigned to a specific customer contact (AP manager, procurement lead). Linking dispute to the customer contact who initiated or owns the dispute i',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to invoice.invoice_line. Business justification: Customer disputes in semiconductor billing are frequently raised against specific line items (e.g., disputing a unit price on a wafer lot line, or an NRE milestone charge) rather than the entire invoi',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Customer disputes in semiconductor foundry are frequently raised against specific wafer lots (yield shortfall, quality rejection, quantity discrepancy). A direct dispute → fabrication_wafer_lot link e',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Customer disputes in semiconductor billing frequently arise from test yield disagreements or incoming inspection failures. Linking dispute directly to final_test_run enables quality and finance teams ',
    `lot_hold_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_lot_hold. Business justification: Customer disputes are frequently initiated because a fabrication lot hold delayed delivery or caused quality failures. Linking dispute directly to fabrication_lot_hold enables dispute resolution teams',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: In semiconductors, invoice disputes are frequently triggered by quality nonconformance events (rejected lots, out-of-spec shipments). Dispute resolution teams must reference the NCR that caused the bi',
    `actual_settlement_date` DATE COMMENT 'Date on which the settlement amount was actually paid.',
    `attached_documents_flag` BOOLEAN COMMENT 'True if supporting documents are attached to the dispute record.',
    `channel` STRING COMMENT 'Communication channel used to submit the dispute.. Valid values are `email|phone|portal|mail|in_person`',
    `close_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was closed in the system.',
    `corrective_action_plan` STRING COMMENT 'Planned actions to prevent recurrence of the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the disputed amount.',
    `dispute_status` STRING COMMENT 'Current lifecycle state of the dispute.. Valid values are `open|in_review|resolved|rejected|closed`',
    `dispute_type` STRING COMMENT 'Category describing the nature of the dispute.. Valid values are `pricing_error|quantity_discrepancy|quality_claim|duplicate_billing|delivery_shortfall|other`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total monetary amount being contested in the dispute.',
    `escalation_level` STRING COMMENT 'Numeric level indicating how many times the dispute has been escalated.',
    `expected_settlement_date` DATE COMMENT 'Target date for completing the settlement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the dispute record in the invoice domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the dispute record in the invoice domain.',
    `notes` STRING COMMENT 'Free‑form text for additional details, comments, or observations.',
    `number` STRING COMMENT 'External reference number assigned to the dispute for tracking and communication.',
    `open_timestamp` TIMESTAMP COMMENT 'Date and time when the dispute was initially recorded.',
    `opened_date` DATE COMMENT 'The opened date associated with the dispute invoice record.',
    `original_invoice_number` STRING COMMENT 'External invoice number from the source billing system.',
    `priority` STRING COMMENT 'Business priority assigned to the dispute.. Valid values are `low|medium|high|critical`',
    `reason` STRING COMMENT 'The reason of the dispute record in the invoice domain.',
    `reason_code` STRING COMMENT 'Coded value representing the reason code of the dispute invoice record.',
    `reason_description` STRING COMMENT 'Narrative description of why the dispute was raised.',
    `resolution_date` DATE COMMENT 'The resolution date associated with the dispute invoice record.',
    `resolution_notes` STRING COMMENT 'The resolution notes of the dispute record in the invoice domain.',
    `resolution_status` STRING COMMENT 'Outcome of the dispute after processing.. Valid values are `settled|partial|rejected|withdrawn`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the dispute was resolved.',
    `resolved_date` DATE COMMENT 'The resolved date associated with the dispute invoice record.',
    `root_cause_category` STRING COMMENT 'High‑level classification of the underlying cause identified during investigation.. Valid values are `process_error|data_error|supplier_issue|customer_error|other`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final monetary amount agreed upon to resolve the dispute.',
    `settlement_currency` STRING COMMENT 'Currency used for the settlement amount.',
    `source` STRING COMMENT 'Origin of the dispute entry within the organization.. Valid values are `customer|sales|accounting|audit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the dispute record.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Customer invoice dispute records tracking formal challenges raised against billed amounts, pricing, quantities, or delivery conditions. Captures dispute type (pricing error, quantity discrepancy, quality claim, duplicate billing, delivery shortfall), disputed amount, dispute open date, responsible owner, resolution status, and final settlement amount. Supports dispute workflow management and root cause tracking for billing quality improvement.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` (
    `revenue_recognition_event_id` BIGINT COMMENT 'System-generated unique identifier for the revenue recognition event record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer associated with the underlying billing transaction.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: ASC 606 / IFRS 15 revenue recognition in semiconductor manufacturing requires tracing each recognition event to the originating booking (the performance obligation trigger). This link enables booking-',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Under ASC 606, revenue recognition in semiconductor sales is triggered by test completion as a delivery milestone. The revenue_recognition_event must reference the final_test_run that satisfied the pe',
    `ar_invoice_id` BIGINT COMMENT 'Identifier of the invoice that generated this revenue recognition event.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to order.shipment. Business justification: ASC 606 / IFRS 15 revenue recognition in semiconductors is triggered by shipment delivery. Rev rec events must trace to the triggering shipment for audit and compliance reporting. revenue_recognition_',
    `source_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Revenue recognition events are triggered by billing events (invoices). The link to the source invoice is mandatory for ASC 606 compliance and audit.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to invoice.invoice_line. Business justification: Revenue recognition under ASC 606 must be tracked at the performance obligation level, which maps to individual invoice line items in semiconductor billing (product shipments, NRE milestones, royalty ',
    `accounting_period` STRING COMMENT 'Fiscal period (e.g., FY2023Q2) to which the recognized revenue is booked.',
    `cost_of_goods_sold_amount` DECIMAL(18,2) COMMENT 'Direct cost attributable to the recognized revenue for this event.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the revenue recognition event record in the invoice domain.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'Portion of the invoice amount that remains deferred after this recognition event.',
    `event_number` STRING COMMENT 'Business-visible identifier assigned to the revenue recognition event (e.g., RRE-2023-000123).',
    `event_status` STRING COMMENT 'The event status of the revenue recognition event record in the invoice domain.',
    `event_type` STRING COMMENT 'The event type of the revenue recognition event record in the invoice domain.',
    `is_reversed` BOOLEAN COMMENT 'Indicates whether the revenue recognition event has been reversed (true) or not (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the revenue recognition event record in the invoice domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the revenue recognition event record in the invoice domain.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or explanations about the revenue recognition event.',
    `period_end_date` DATE COMMENT 'End date of the period over which revenue is recognized for this event.',
    `period_start_date` DATE COMMENT 'Start date of the period over which revenue is recognized for this event.',
    `profit_amount` DECIMAL(18,2) COMMENT 'Gross profit derived from the recognized revenue (revenue minus COGS).',
    `recognition_date` DATE COMMENT 'The recognition date associated with the revenue recognition event invoice record.',
    `recognition_method` STRING COMMENT 'Method used to recognize revenue: point‑in‑time or over‑time.. Valid values are `point_in_time|over_time`',
    `recognition_timestamp` TIMESTAMP COMMENT 'Date and time when the revenue was recognized according to the schedule.',
    `recognized_amount` DECIMAL(18,2) COMMENT 'The recognized amount of the revenue recognition event record in the invoice domain.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revenue recognition event record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revenue recognition event record.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Monetary amount of revenue recognized in this event.',
    `revenue_category` STRING COMMENT 'Business category of the revenue (e.g., product sale, service, IP licensing, royalty, maintenance).. Valid values are `product|service|ip_licensing|royalty|maintenance`',
    `revenue_recognition_event_status` STRING COMMENT 'Current lifecycle status of the revenue recognition event.. Valid values are `pending|recognized|reversed|cancelled`',
    `revenue_rev_rec_event_to_ar_invoice` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Revenue recognition events must reference the billing document (invoice) that triggered recognition. Required for ASC 606/IFRS 15 compliance audit.',
    `source_record_key` STRING COMMENT 'Unique key of the source record in the originating system.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the recognized revenue.',
    CONSTRAINT pk_revenue_recognition_event PRIMARY KEY(`revenue_recognition_event_id`)
) COMMENT 'Revenue recognition event records capturing when and how revenue from customer invoices is recognized under applicable accounting standards (ASC 606 / IFRS 15). Each record links a billing event (invoice, NRE milestone, royalty) to its revenue recognition schedule, performance obligation, recognition method (point-in-time vs. over-time), recognized amount, deferred revenue amount, and accounting period. SSOT for revenue recognition compliance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` (
    `tax_determination_id` BIGINT COMMENT 'System‑generated unique identifier for each tax determination record.',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: Semiconductor cross-border transactions require tax determination to reference the governing customer contract for jurisdiction, exemption certificates, and PCN/export control clauses. This link suppo',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product or service that the tax is applied to.',
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line record within the tax determination invoice entity.',
    `ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Tax determination records are calculated per invoice. The FK links tax computation results to the billing document for tax reporting and audit.',
    `to_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Tax determination records must link to the invoice they apply to. Tax is calculated per invoice and must be traceable for tax authority audits.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the tax determination record in the invoice domain.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the tax determination invoice record.',
    `is_tax_exempt` BOOLEAN COMMENT 'The is tax exempt of the tax determination record in the invoice domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the tax determination record in the invoice domain.',
    `line_number` STRING COMMENT 'Ordinal position of the tax line within the invoice.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tax determination record in the invoice domain.',
    `reverse_charge_mechanism` STRING COMMENT 'Description of the reverse charge method used.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount for the line.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'Monetary amount on which the tax rate is applied.',
    `tax_calculation_method` STRING COMMENT 'Method used to compute the tax amount.. Valid values are `percentage|fixed|tiered`',
    `tax_category` STRING COMMENT 'Classification of tax (standard, reduced, zero).. Valid values are `standard|reduced|zero`',
    `tax_code` STRING COMMENT 'Internal code used to identify the specific tax rule applied.',
    `tax_credit_amount` DECIMAL(18,2) COMMENT 'Monetary value of the tax credit, if applicable.',
    `tax_credit_eligible` BOOLEAN COMMENT 'True if the line qualifies for a tax credit.',
    `tax_currency` STRING COMMENT 'Three‑letter ISO currency code of the tax amount.',
    `tax_document_number` STRING COMMENT 'Reference number of supporting tax document (e.g., certificate, exemption letter).',
    `tax_document_type` STRING COMMENT 'Type of supporting tax document.. Valid values are `certificate|exemption|nil`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the transaction line is tax‑exempt.',
    `tax_exempt_reason` STRING COMMENT 'Reason or code for tax exemption, if applicable.',
    `tax_is_reverse_charge` BOOLEAN COMMENT 'True if reverse charge mechanism applies.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction of the tax determination record in the invoice domain.',
    `tax_jurisdiction_code` STRING COMMENT 'Standard code representing the tax jurisdiction (e.g., ISO‑3166‑2 country‑state code).',
    `tax_jurisdiction_name` STRING COMMENT 'Human‑readable name of the tax jurisdiction.',
    `tax_jurisdiction_type` STRING COMMENT 'Level of the jurisdiction that the tax applies to.. Valid values are `country|state|city|custom`',
    `tax_liability_party` STRING COMMENT 'Entity responsible for remitting the tax.. Valid values are `seller|buyer|third_party`',
    `tax_line_description` STRING COMMENT 'Free‑form description of the tax line.',
    `tax_line_status` STRING COMMENT 'Current processing status of the tax line.. Valid values are `pending|applied|reversed|error`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `tax_rate_effective_date` DATE COMMENT 'Date from which the tax rate is applicable.',
    `tax_rate_expiration_date` DATE COMMENT 'Date after which the tax rate is no longer valid.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percent of the tax determination record in the invoice domain.',
    `tax_record_created` TIMESTAMP COMMENT 'Date‑time when the tax determination record was created.',
    `tax_record_updated` TIMESTAMP COMMENT 'Date‑time of the most recent update to the tax record.',
    `tax_region_code` STRING COMMENT 'Code representing the tax region within the jurisdiction.',
    `tax_reporting_period` DATE COMMENT 'Fiscal period for which the tax is reported.',
    `tax_source_system` STRING COMMENT 'Originating ERP or tax engine that generated the record.. Valid values are `SAP|Oracle|Custom`',
    `tax_source_system_code` STRING COMMENT 'Unique identifier of the tax record in the source system.',
    `tax_type` STRING COMMENT 'Category of tax applied to the transaction line.. Valid values are `VAT|GST|Sales|Use|Withholding|Customs`',
    `tax_withholding_flag` BOOLEAN COMMENT 'Indicates whether withholding tax applies to this line.',
    `taxable_amount` DECIMAL(18,2) COMMENT 'The taxable amount of the tax determination record in the invoice domain.',
    `taxable_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or services subject to tax.',
    `to_ar_invoice` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Tax determination records must link to the invoice they apply to. Required for tax reporting, audit, and VAT/GST reconciliation.',
    `withholding_amount` DECIMAL(18,2) COMMENT 'Calculated withholding tax amount.',
    `withholding_rate` DECIMAL(18,2) COMMENT 'Withholding tax rate expressed as a percentage.',
    CONSTRAINT pk_tax_determination PRIMARY KEY(`tax_determination_id`)
) COMMENT 'Tax determination records for each invoice capturing applicable tax codes, jurisdictions, rates, and calculated tax amounts for semiconductor product sales across global markets. Covers VAT, GST, sales/use tax, withholding tax, and customs duty components. Captures determination inputs (ship-from/ship-to jurisdiction, product tax classification, customer tax status, free trade zone applicability, bonded warehouse status) and resulting tax line amounts. Supports withholding tax certificate tracking for Asian semiconductor markets (Taiwan, Korea, China, India) where WHT documentation is required for payment release.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_to_payment_term_id` FOREIGN KEY (`to_payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_to_ar_invoice_id` FOREIGN KEY (`to_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_reversal_reference_payment_receipt_id` FOREIGN KEY (`reversal_reference_payment_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_receipt`(`payment_receipt_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_to_ar_invoice_id` FOREIGN KEY (`to_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_customer_credit_limit_id` FOREIGN KEY (`customer_credit_limit_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit`(`customer_credit_limit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_source_ar_invoice_id` FOREIGN KEY (`source_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_to_ar_invoice_id` FOREIGN KEY (`to_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`invoice` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`invoice` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Invoice ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Pkg Assembly Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `to_payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'To Payment Term Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `ar_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `ar_invoice_status` SET TAGS ('dbx_value_regex' = 'draft|open|posted|paid|cancelled|disputed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `auditor_notes` SET TAGS ('dbx_business_glossary_term' = 'Auditor Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Full Name');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Document Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'commercial|proforma|intercompany');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `early_payment_discount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount (%)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `ecn_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `ecn_classification` SET TAGS ('dbx_value_regex' = '^[A-E]d{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^d{6,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `is_credit_memo` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `is_proforma` SET TAGS ('dbx_business_glossary_term' = 'Pro‑Forma Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Net Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire|credit_card|check|paypal|bank_transfer');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partial|paid|overdue|refunded');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Invoice Remarks');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `shipping_address` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `shipping_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `shipping_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'IP Core Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `package_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Package Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Line Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Photomask Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `to_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `wafer_start_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'product|service|nre|royalty|wafer_lot|packaging');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `invoice_line_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `is_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Discount Applied Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Item Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|posted|cancelled|adjusted');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'upfront|milestone|periodic|upon_delivery');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|online|partner');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'pcs|sets|kg|mm|inch');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `reversal_reference_payment_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reference ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `to_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `allocated_amount_total` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount Total');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `amount_received` SET TAGS ('dbx_business_glossary_term' = 'Amount Received');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `bank_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `number_of_allocations` SET TAGS ('dbx_business_glossary_term' = 'Number of Allocations');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `on_account_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Account Payment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `overpayment_flag` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `partial_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Bank Account Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payer_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Payer Bank Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name (Full)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online|batch|manual|api');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire|ach|check|letter_of_credit|cash');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|reconciled|reversed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'domestic|international');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `receipt_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `receipt_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `remittance_advice` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `residual_open_amount` SET TAGS ('dbx_business_glossary_term' = 'Residual Open Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `to_ar_invoice` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `applicable_to_customer_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `applicable_to_customer_type` SET TAGS ('dbx_value_regex' = 'new|existing|vip|all');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'SOX|ITAR|EAR|RoHS|REACH|GDPR');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `payment_term_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `discount_days` SET TAGS ('dbx_business_glossary_term' = 'Discount Days');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `early_payment_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Days');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `early_payment_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Term Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `late_payment_penalty_days` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Days');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `late_payment_penalty_percent` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Percent');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `legal_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Reference Document');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `letter_of_credit_required` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `max_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `max_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `net_days` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Days');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `payment_method_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Payment Methods');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `payment_method_allowed` SET TAGS ('dbx_value_regex' = 'wire|ach|credit_card|paypal|check|other');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `tax_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '[A-Z0-9]+(/[A-Z0-9]+)?');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `term_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Name');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'net|discount|cash|letter_of_credit|custom');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `customer_credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Credit Limit ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `available_credit` SET TAGS ('dbx_business_glossary_term' = 'Available Credit');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_available_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Available Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Currency (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_insurance_coverage` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Coverage');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_insurance_coverage` SET TAGS ('dbx_value_regex' = 'none|partial|full');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Provider');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_limit_created` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_limit_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_limit_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Number (CLN)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_hold|suspended|closed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_limit_type` SET TAGS ('dbx_value_regex' = 'standard|nre_milestone|royalty|project_based');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Classification');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_risk_classification` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_used_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Used Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `credit_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `limit_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Limit Adjustment Reason');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `limit_adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Limit Adjustment Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_business_glossary_term' = 'Limit Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `max_overdue_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Overdue Days');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `payment_history_score` SET TAGS ('dbx_business_glossary_term' = 'Payment History Score');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `payment_history_score` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `credit_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Identifier (CHID)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Overdue Invoice Identifier (OII)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `customer_credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Customer Credit Limit Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `block_level` SET TAGS ('dbx_business_glossary_term' = 'Blocking Level (BL)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `block_level` SET TAGS ('dbx_value_regex' = 'order|delivery|billing');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Comments (CHC)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `credit_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Status (CHS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `credit_hold_status` SET TAGS ('dbx_value_regex' = 'active|released|cancelled|pending|expired|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Customer Credit Limit (CCL)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Expiration Date (CHD)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Amount (CHA)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_category` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Category (CHC)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_category` SET TAGS ('dbx_value_regex' = 'credit_limit|overdue|risk|manual');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Number (CHN)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Placement Timestamp (CHPT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason (CHR)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date (CND)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Status (CNS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'notified|not_notified');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Invoice Amount (OIA)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `placed_date` SET TAGS ('dbx_business_glossary_term' = 'Placed Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Release Timestamp (CHRT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `released_by` SET TAGS ('dbx_business_glossary_term' = 'Released By');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `released_date` SET TAGS ('dbx_business_glossary_term' = 'Released Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Score (CRS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Lot Hold Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `actual_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `attached_documents_flag` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Dispute Channel');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|phone|portal|mail|in_person');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Close Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|in_review|resolved|rejected|closed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'pricing_error|quantity_discrepancy|quality_claim|duplicate_billing|delivery_shortfall|other');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `expected_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Settlement Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Open Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `original_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Reason');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'settled|partial|rejected|withdrawn');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Resolved Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process_error|data_error|supplier_issue|customer_error|other');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Dispute Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'customer|sales|accounting|audit');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `source_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Source Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `is_reversed` SET TAGS ('dbx_business_glossary_term' = 'Is Reversed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `profit_amount` SET TAGS ('dbx_business_glossary_term' = 'Profit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Recognition Method');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `recognition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recognition Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'product|service|ip_licensing|royalty|maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_status` SET TAGS ('dbx_value_regex' = 'pending|recognized|reversed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `revenue_rev_rec_event_to_ar_invoice` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rev Rec Event To Ar Invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `source_record_key` SET TAGS ('dbx_business_glossary_term' = 'Source Record Key');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Determination ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `to_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Exempt');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `reverse_charge_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Reverse Charge Mechanism');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Method');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_value_regex' = 'percentage|fixed|tiered');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'standard|reduced|zero');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Eligible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_currency` SET TAGS ('dbx_business_glossary_term' = 'Tax Currency (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_document_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_document_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_document_type` SET TAGS ('dbx_value_regex' = 'certificate|exemption|nil');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Reason');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_is_reverse_charge` SET TAGS ('dbx_business_glossary_term' = 'Reverse Charge Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Name');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_jurisdiction_type` SET TAGS ('dbx_value_regex' = 'country|state|city|custom');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_liability_party` SET TAGS ('dbx_business_glossary_term' = 'Tax Liability Party');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_liability_party` SET TAGS ('dbx_value_regex' = 'seller|buyer|third_party');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_line_description` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_line_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_line_status` SET TAGS ('dbx_value_regex' = 'pending|applied|reversed|error');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_rate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_record_created` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_record_updated` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_region_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Region Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_source_system` SET TAGS ('dbx_business_glossary_term' = 'Tax Source System');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Custom');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Source System Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type (VAT/GST/Sales/Use/Withholding/Customs)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'VAT|GST|Sales|Use|Withholding|Customs');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_withholding_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `taxable_quantity` SET TAGS ('dbx_business_glossary_term' = 'Taxable Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `to_ar_invoice` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate (Percent)');
