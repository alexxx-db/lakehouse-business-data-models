-- Schema for Domain: invoice | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`invoice` COMMENT 'Billing, invoicing, payment processing, and revenue collection. SSOT for customer invoices, NRE billing milestones, credit memos, payment terms, credit management, accounts receivable, pricing models including volume discounts, royalty billing for IP licensing, and revenue recognition.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique system-generated identifier for the invoice record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer billed on the invoice.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Invoice approval workflow requires an accounting employee to approve; each invoice has one approver, many invoices per employee.',
    `payment_term_id` BIGINT COMMENT 'FK to invoice.payment_term.payment_term_id — Every invoice must reference its applicable payment terms to calculate due dates, discount windows, and penalty triggers.',
    `pricing_agreement_id` BIGINT COMMENT 'Unique identifier for the ar pricing agreement record within the ar invoice invoice entity.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Links invoice to a normalized address record for tax jurisdiction and export‑control validation; required by regulatory reporting.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Required for Accounts Receivable to send invoice notices to the designated billing contact; standard practice in semiconductor B2B invoicing.',
    `customer_contract_id` BIGINT COMMENT 'Identifier of the underlying contract or agreement (e.g., NRE milestone, royalty agreement).',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export compliance requires each invoice to reference the export license authorizing the shipment for customs reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for General Ledger posting of each invoice to the appropriate GL account for revenue and receivables reporting.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: EXPORT COMPLIANCE: Invoices must be validated against the products ITAR/EAR classification (ic_catalog.it ar_controlled, ear_eccn_code). Linking ar_invoice to ic_catalog enables automated export‑cont',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Final invoices for a design project must be associated with that project for accounting, revenue recognition, and project performance reporting.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: REQUIRED: Opportunity‑to‑revenue attribution; enables pipeline performance reporting that ties closed opportunities to actual invoiced revenue.',
    `assembly_order_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_order. Business justification: Required for the Packaging Service Billing Report, which matches each invoice to the underlying assembly order that generated the packaged product.',
    `primary_ar_payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: Invoices reference a payment‑term master; adding payment_term_id FK normalizes payment terms and removes the redundant free‑text payment_terms column.',
    `primary_ar_pricing_agreement_id` BIGINT COMMENT 'FK to invoice.pricing_agreement.pricing_agreement_id — Invoices generated under negotiated pricing must reference the governing pricing agreement for price validation and audit.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Three-way match process requires linking each customer invoice to the originating purchase order for audit, payment, and compliance.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: REQUIRED: Quote‑to‑cash audit; linking the original sales quote to the resulting invoice supports commission calculations and compliance reporting.',
    `order_id` BIGINT COMMENT 'Identifier of the sales order that generated the invoice.',
    `shipment_id` BIGINT COMMENT 'add column shipment_id (BIGINT) with FK to order.shipment.shipment_id - invoices are generated from shipments',
    `to_payment_term_id` BIGINT COMMENT 'FK to invoice.payment_term.payment_term_id — Every invoice must reference its applicable payment terms to calculate due date and discount eligibility. Required for AR aging and cash forecasting.',
    `to_pricing_agreement_id` BIGINT COMMENT 'FK to invoice.pricing_agreement.pricing_agreement_id — Invoices generated under negotiated pricing or rebate agreements must reference the governing agreement for price validation and rebate accrual.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Enables line‑level cost allocation to a cost center, essential for internal cost tracking and profitability analysis.',
    `customer_contract_id` BIGINT COMMENT 'Reference to a contract (e.g., NRE or royalty agreement) governing this line.',
    `design_ip_core_id` BIGINT COMMENT 'Identifier of the IP core associated with a royalty line.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Customs filing mandates linking each line item to its ECCN classification record for export‑control documentation.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Customer billing per tool usage is recorded on invoice lines; linking to fab_tool provides detailed cost allocation and OEE reporting.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Needed for the Invoice Line Item for Wafer Lot process, linking each line to the specific wafer lot for traceability and warranty claims.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Final Test Run Billing Reconciliation – each invoice line for test services must reference the specific final_test_run to match revenue with test yield and satisfy audit requirements.',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the gl account record within the invoice line invoice entity.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Invoice verification against goods receipt ensures received quantity matches billed amount, required for compliance and financial reconciliation.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the invoice line invoice entity.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Inspection Result Posting requires each invoice line to reference the Inspection Lot that validated the wafer lot before billing.',
    `mpw_shuttle_id` BIGINT COMMENT 'Foreign key linking to design.mpw_shuttle. Business justification: MPW shuttle services are billed as line items; the FK provides traceability of shuttle usage and cost allocation.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Ensures invoice line package type references the master package_type table for compliance and cost reporting, replacing the free-text packaging_type field.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: Three-way match ties each invoice line to its specific purchase order line to validate quantities, pricing, and delivery dates.',
    `ar_invoice_id` BIGINT COMMENT 'Identifier of the parent invoice to which this line belongs.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Supports profit‑center attribution per invoice line, required for segment profitability reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sales order lines are assigned to a sales representative employee for commission tracking and performance reporting.',
    `sku_id` BIGINT COMMENT 'Identifier of the product or service billed on this line.',
    `to_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Fundamental header-to-line relationship. Every invoice line must reference its parent invoice. Without this FK, the domain cannot function — you cannot construct an invoice document.',
    `authoritative_order_line_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Invoice lines are generated from order lines; linking enables traceability for revenue recognition, audit, and dispute resolution.',
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
    `payment_terms` STRING COMMENT 'Standard payment terms applied to this line.. Valid values are `net30|net45|net60|due_on_receipt`',
    `product_name` STRING COMMENT 'Human‑readable name of the product or service.',
    `product_sku` STRING COMMENT 'Manufacturer-assigned SKU for the billed product.',
    `project_code` STRING COMMENT 'Internal project or NRE code associated with the line.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` (
    `nre_billing_milestone_id` BIGINT COMMENT 'System-generated unique identifier for each NRE billing milestone record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer being billed.',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the secondary ar invoice record within the nre billing milestone invoice entity.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: NRE billing milestones are generated per design project; linking enables project‑level cost tracking and profitability analysis.',
    `primary_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — When an NRE milestone triggers billing, the resulting invoice must be linked back to the milestone for revenue recognition and project accounting.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the milestone billing.',
    `project_id` BIGINT COMMENT 'Identifier of the IC design project associated with the milestone.',
    `sales_nre_agreement_id` BIGINT COMMENT 'Unique identifier for the sales nre agreement record within the nre billing milestone invoice entity.',
    `test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: NRE Milestone Billing – NRE milestones for test program development are billed; linking to test_program enables tracking milestone costs against the program.',
    `actual_date` DATE COMMENT 'Date the milestone was actually billed.',
    `billing_formula` STRING COMMENT 'Expression or rule used to calculate the milestone amount (e.g., fixed fee, percentage of NRE total).',
    `billing_trigger_type` STRING COMMENT 'Mechanism that initiates the billing event.. Valid values are `milestone|schedule|shipment|subscription`',
    `compliance_regulation` STRING COMMENT 'Regulatory framework that governs the billing (e.g., export control, environmental).. Valid values are `ITAR|EAR|RoHS|REACH|ISO9001`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the billing amounts.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Date by which payment for the milestone must be received.',
    `evidence_document_url` STRING COMMENT 'Link to supporting documentation (e.g., sign‑off report, test results).',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, or adjustments.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether the billing milestone repeats on a schedule.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the nre billing milestone record in the invoice domain.',
    `milestone_amount` DECIMAL(18,2) COMMENT 'The milestone amount of the nre billing milestone record in the invoice domain.',
    `milestone_code` STRING COMMENT 'External code or number used to reference the billing milestone in contracts and invoices.',
    `milestone_name` STRING COMMENT 'Human‑readable name of the billing milestone (e.g., "RTL Freeze", "GDS Tapeout").',
    `milestone_sequence` STRING COMMENT 'Ordinal position of the milestone within the project billing schedule.',
    `milestone_status` STRING COMMENT 'The milestone status of the nre billing milestone record in the invoice domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the nre billing milestone record in the invoice domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after tax and any adjustments.',
    `notes` STRING COMMENT 'Additional comments or remarks about the billing milestone.',
    `nre_billing_milestone_status` STRING COMMENT 'Current lifecycle state of the billing milestone.. Valid values are `planned|in_progress|completed|cancelled|rejected`',
    `payment_terms` STRING COMMENT 'Contractual payment condition associated with the milestone.. Valid values are `net30|net45|net60|upon_receipt|custom`',
    `planned_date` DATE COMMENT 'Date the milestone is scheduled to be billed.',
    `recurring_interval` STRING COMMENT 'Time interval for recurring billing when is_recurring is true.. Valid values are `monthly|quarterly|yearly`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the gross amount.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction or rule applied.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the milestone record.',
    CONSTRAINT pk_nre_billing_milestone PRIMARY KEY(`nre_billing_milestone_id`)
) COMMENT 'Non-Recurring Engineering (NRE) billing milestone and planned billing schedule records for semiconductor IC design, tapeout, IP licensing, and long-term supply agreement projects. Each record represents a contractually defined billing event — either milestone-based (RTL freeze, GDS tapeout, first silicon, qualification sign-off) or schedule-based (calendar-periodic, shipment-triggered, subscription). Captures milestone/schedule name, sequence, planned and actual dates, billing amount or formula, billing trigger type, invoice linkage, approval status, and completion evidence. SSOT for all planned, milestone-driven, and schedule-based billing events including NRE project billing plans, IP licensing periodic billing, recurring supply agreement billing cadences, and subscription billing schedules. Subsumes all billing_schedule concepts.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` (
    `adjustment_memo_id` BIGINT COMMENT 'Primary key for adjustment_memo',
    `account_id` BIGINT COMMENT 'Unique identifier for the account record within the adjustment memo invoice entity.',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the adjustment ar invoice record within the adjustment memo invoice entity.',
    `employee_id` BIGINT COMMENT 'System identifier of the user who approved or rejected the memo.',
    `approver_employee_id` BIGINT COMMENT 'Unique identifier for the approver employee record within the adjustment memo invoice entity.',
    `audit_event_id` BIGINT COMMENT 'Reference to an immutable audit log entry capturing the full change history.',
    `journal_entry_id` BIGINT COMMENT 'Link to the general ledger entry generated for this adjustment.',
    `primary_adjustment_ar_invoice_id` BIGINT COMMENT 'Identifier of the invoice that this adjustment memo references.',
    `customer_contract_id` BIGINT COMMENT 'Identifier of the contract or agreement underlying the original invoice.',
    `order_id` BIGINT COMMENT 'Identifier of the sales order associated with the original invoice, if any.',
    `tertiary_adjustment_applied_to_invoice_ar_invoice_id` BIGINT COMMENT 'Identifier of the open receivable invoice to which this adjustment was applied.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The adjustment amount of the adjustment memo record in the invoice domain.',
    `adjustment_category` STRING COMMENT 'High‑level category such as price_adjustment, return, overbilling_correction, yield_concession.',
    `adjustment_memo_status` STRING COMMENT 'Current workflow state of the adjustment memo.. Valid values are `draft|pending|approved|rejected|posted|cancelled`',
    `adjustment_number` STRING COMMENT 'External business number assigned to the adjustment memo for tracking and reference.',
    `adjustment_subtype` STRING COMMENT 'More granular subtype within the adjustment category, if applicable.',
    `adjustment_type` STRING COMMENT 'Indicates whether the memo reduces (credit), increases (debit), or formally corrects an invoice.. Valid values are `credit|debit|correction`',
    `applied_amount` DECIMAL(18,2) COMMENT 'Portion of the adjustment amount that has been applied to the target invoice.',
    `approval_status` STRING COMMENT 'Result of the approval workflow for the adjustment memo.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approval decision was recorded.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Monetary amount approved for the adjustment before tax or other charges.',
    `audit_user_created` BIGINT COMMENT 'System user who originally created the adjustment memo record.',
    `audit_user_updated` BIGINT COMMENT 'System user who performed the most recent update.',
    `comments` STRING COMMENT 'Additional free‑form notes entered by the creator or approver.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment memo record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the adjustment amounts.',
    `effective_date` DATE COMMENT 'The date on which the adjustment becomes financially effective.',
    `external_reference` STRING COMMENT 'Reference to external systems (e.g., ERP, CRM) or partner identifiers.',
    `is_manual` BOOLEAN COMMENT 'True if the adjustment memo was entered manually rather than generated by an automated process.',
    `is_tax_included` BOOLEAN COMMENT 'Indicates whether tax is already included in the approved amount.',
    `issuing_authority` STRING COMMENT 'Organizational unit or role that issued the adjustment memo (e.g., Finance, Sales).',
    `last_modified_by` BIGINT COMMENT 'User who performed the most recent modification to the memo.',
    `last_modified_reason` STRING COMMENT 'Reason text explaining why the memo was last modified.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the adjustment memo record in the invoice domain.',
    `memo_date` DATE COMMENT 'The memo date associated with the adjustment memo invoice record.',
    `memo_number` STRING COMMENT 'The memo number of the adjustment memo record in the invoice domain.',
    `memo_status` STRING COMMENT 'The memo status of the adjustment memo record in the invoice domain.',
    `memo_type` STRING COMMENT 'The memo type of the adjustment memo record in the invoice domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the adjustment memo record in the invoice domain.',
    `original_invoice_number` STRING COMMENT 'Customer‑visible invoice number that is being adjusted.',
    `posting_date` DATE COMMENT 'Date the adjustment memo is posted to the general ledger.',
    `reason_code` STRING COMMENT 'Standardized code representing the business reason for the adjustment.',
    `reason_description` STRING COMMENT 'Free‑text description of why the adjustment memo was issued.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Outstanding balance on the original invoice after applying this adjustment.',
    `settlement_date` DATE COMMENT 'Date on which the adjustment was settled.',
    `settlement_status` STRING COMMENT 'Indicates whether the adjustment has been settled against receivables.. Valid values are `unsettled|settled|partial`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the adjustment, if applicable.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (percentage) used to calculate tax_amount.',
    `total_amount` DECIMAL(18,2) COMMENT 'Net financial impact of the adjustment (approved amount plus/minus tax).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the adjustment memo.',
    CONSTRAINT pk_adjustment_memo PRIMARY KEY(`adjustment_memo_id`)
) COMMENT 'Adjustment memo records (credit, debit, and correction) issued to customers to modify outstanding invoice balances. Credit memos reduce balances for price adjustments, RMA returns, overbilling corrections, yield-related concessions, and quality claim settlements. Debit memos increase balances for underbilling corrections, retroactive price adjustments, and expedite fees. Corrections cover formal invoice amendments requiring accounting reversal and reissuance. Captures original invoice reference, adjustment direction (credit/debit/correction), reason code, approved amount, corrected line items, net financial impact, issuing authority, approval workflow status, replacement invoice linkage, and application status against open receivables. SSOT for all post-invoice billing adjustments — subsumes all debit_memo and invoice_correction concepts.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` (
    `payment_receipt_id` BIGINT COMMENT 'System-generated unique identifier for the payment receipt record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who made the payment.',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the secondary ar invoice record within the payment receipt invoice entity.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Cash receipt must be posted to a journal entry for cash accounting and audit trail.',
    `primary_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Payment receipts must reference the invoices they clear. This is the core cash application relationship enabling AR aging accuracy and payment reconciliation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Payment receipt processing is performed by a treasury employee; audit logs require linking receipt to processing employee.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` (
    `royalty_billing_id` BIGINT COMMENT 'System-generated unique identifier for the royalty billing record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer or partner receiving the royalty bill.',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the secondary ar invoice record within the royalty billing invoice entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Royalty expense is charged to a cost center for internal expense tracking and budgeting.',
    `design_ip_core_id` BIGINT COMMENT 'Identifier of the licensed IP core (e.g., processor, PHY) for which royalties are calculated.',
    `license_agreement_id` BIGINT COMMENT 'Unique identifier for the license agreement record within the royalty billing invoice entity.',
    `pricing_agreement_id` BIGINT COMMENT 'Reference to the master licensing agreement governing the royalty terms.',
    `primary_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Royalty billing records generate invoices. The linkage enables tracking from IP license royalty calculation to the customer-facing billing document.',
    `product_ip_core_id` BIGINT COMMENT 'Unique identifier for the product ip core record within the royalty billing invoice entity.',
    `to_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Royalty billing calculations must link to the generated invoice for payment tracking and audit trail.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of discounts, credits, or penalties applied to the gross royalty.',
    `audit_report_reference` BIGINT COMMENT 'Reference to the detailed audit report document.',
    `audit_status` STRING COMMENT 'Status of the royalty audit performed on the reported figures.. Valid values are `pending|completed|failed`',
    `billing_date` DATE COMMENT 'Date the royalty invoice was issued to the licensee.',
    `billing_number` STRING COMMENT 'Business identifier for the royalty invoice, e.g., RB-20230101.. Valid values are `^RB-d{8}$`',
    `billing_period` STRING COMMENT 'The billing period of the royalty billing record in the invoice domain.',
    `billing_period_end` DATE COMMENT 'The billing period end of the royalty billing record in the invoice domain.',
    `billing_period_start` DATE COMMENT 'The billing period start of the royalty billing record in the invoice domain.',
    `billing_status` STRING COMMENT 'Current lifecycle state of the royalty invoice.. Valid values are `draft|issued|paid|overdue|disputed|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the royalty billing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the royalty amounts.',
    `dispute_flag` BOOLEAN COMMENT 'True if the royalty invoice is under dispute.',
    `dispute_reason` STRING COMMENT 'Free‑text description of the reason for the royalty dispute.',
    `due_date` DATE COMMENT 'Date by which the royalty payment must be received.',
    `exchange_rate_to_usd` DECIMAL(18,2) COMMENT 'Conversion rate from the invoice currency to US dollars for reporting.',
    `is_royalty_exempt` BOOLEAN COMMENT 'True if the licensee is exempt from royalty for this period (e.g., promotional waiver).',
    `last_audit_date` DATE COMMENT 'Date of the most recent royalty audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the royalty billing record in the invoice domain.',
    `minimum_commitment_amount` DECIMAL(18,2) COMMENT 'Contractual minimum royalty amount the licensee must pay for the period.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the royalty billing record in the invoice domain.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the royalty billing.',
    `payment_method` STRING COMMENT 'Means by which the royalty payment was made.. Valid values are `wire|ach|check|credit_card`',
    `payment_received_date` DATE COMMENT 'Date the royalty payment was actually received.',
    `payment_reference` STRING COMMENT 'Reference number or code provided by the payer for the royalty payment.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the royalty billing has been reconciled with payments.. Valid values are `pending|reconciled|exception`',
    `region_code` STRING COMMENT 'Three‑letter ISO country code of the licensees primary operating region.. Valid values are `^[A-Z]{3}$`',
    `royalty_amount` DECIMAL(18,2) COMMENT 'The royalty amount of the royalty billing record in the invoice domain.',
    `royalty_amount_gross` DECIMAL(18,2) COMMENT 'Total royalty calculated before any discounts, taxes, or adjustments.',
    `royalty_amount_net` DECIMAL(18,2) COMMENT 'Final royalty amount after adjustments, before tax.',
    `royalty_billing_status` STRING COMMENT 'The status of the royalty billing record in the invoice domain.',
    `royalty_calculation_method` STRING COMMENT 'Method used to derive the royalty amount.. Valid values are `self_report|audit|estimated`',
    `royalty_period_end` DATE COMMENT 'Last calendar date of the royalty reporting period.',
    `royalty_period_start` DATE COMMENT 'First calendar date of the royalty reporting period.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Rate applied to calculate royalty – either a per‑unit amount or a percentage (expressed as a decimal).',
    `royalty_rate_usd` DECIMAL(18,2) COMMENT 'The royalty rate usd of the royalty billing record in the invoice domain.',
    `royalty_type` STRING COMMENT 'Indicates whether the royalty is calculated per shipped unit or as a percentage of revenue.. Valid values are `per_unit|percentage_of_revenue`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the royalty invoice, if applicable.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction or rule applied.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `tier_level` STRING COMMENT 'Tier classification that determines the royalty rate based on volume or other criteria.. Valid values are `tier1|tier2|tier3|tier4`',
    `to_ar_invoice` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Royalty billing records must link to the invoice issued for the royalty period. Required for IP licensing revenue tracking and licensee reconciliation.',
    `unit_shipment_volume` BIGINT COMMENT 'Number of licensed units (e.g., chips, dies) reported by the licensee for the period.',
    `units_shipped` BIGINT COMMENT 'The units shipped of the royalty billing record in the invoice domain.',
    `units_sold` BIGINT COMMENT 'The units sold of the royalty billing record in the invoice domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the royalty billing record.',
    CONSTRAINT pk_royalty_billing PRIMARY KEY(`royalty_billing_id`)
) COMMENT 'IP licensing royalty billing records for semiconductor IP cores (processor IP, PHY IP, memory controllers, SerDes, etc.) licensed to fabless customers, design houses, and foundry partners. Captures royalty period, licensed IP reference, unit shipment volume reported by licensee, royalty rate tier, calculated royalty amount, minimum royalty commitment tracking, audit status, licensee self-report reconciliation, and invoice linkage. Supports volume-tiered royalty structures, per-unit and percentage-of-revenue models, and royalty audit dispute resolution.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'System-generated unique identifier for the payment term record.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id',
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
    `employee_id` BIGINT COMMENT 'Unique identifier for the approver employee record within the customer credit limit invoice entity.',
    `customer_employee_id` BIGINT COMMENT 'Identifier of the analyst responsible for managing this credit limit.',
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
    `account_id` BIGINT COMMENT 'Unique identifier for the credit account record within the credit hold invoice entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the credit placed by employee record within the credit hold invoice entity.',
    `primary_credit_customer_account_id` BIGINT COMMENT 'Unique identifier of the customer to whom the credit hold applies.',
    `primary_credit_employee_id` BIGINT COMMENT 'Identifier of the credit analyst who authorized the hold.',
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
    `payment_terms` STRING COMMENT 'Standard payment terms associated with the customer account.. Valid values are `net30|net45|net60|due_on_receipt`',
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
    `employee_id` BIGINT COMMENT 'Identifier of the internal owner handling the dispute.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the dispute invoice entity.',
    `actual_settlement_date` DATE COMMENT 'Date on which the settlement amount was actually paid.',
    `attached_documents_flag` BOOLEAN COMMENT 'True if supporting documents are attached to the dispute record.',
    `channel` STRING COMMENT 'Communication channel used to submit the dispute.. Valid values are `email|phone|portal|mail|in_person`',
    `close_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was closed in the system.',
    `corrective_action_plan` STRING COMMENT 'Planned actions to prevent recurrence of the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the disputed amount.',
    `dispute_number` STRING COMMENT 'External reference number assigned to the dispute for tracking and communication.',
    `dispute_status` STRING COMMENT 'Current lifecycle state of the dispute.. Valid values are `open|in_review|resolved|rejected|closed`',
    `dispute_type` STRING COMMENT 'Category describing the nature of the dispute.. Valid values are `pricing_error|quantity_discrepancy|quality_claim|duplicate_billing|delivery_shortfall|other`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total monetary amount being contested in the dispute.',
    `escalation_level` STRING COMMENT 'Numeric level indicating how many times the dispute has been escalated.',
    `expected_settlement_date` DATE COMMENT 'Target date for completing the settlement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the dispute record in the invoice domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the dispute record in the invoice domain.',
    `notes` STRING COMMENT 'Free‑form text for additional details, comments, or observations.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Revenue recognition events are reviewed/approved by an accounting employee; required for SOX audit trails.',
    `ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Revenue recognition events are triggered by billing events (invoices). The link to the source invoice is mandatory for ASC 606 compliance and audit.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition events post amounts to a GL account, required for ASC 606 compliance.',
    `performance_obligation_id` BIGINT COMMENT 'Identifier of the performance obligation to which this revenue recognition event is linked.',
    `primary_revenue_ar_invoice_id` BIGINT COMMENT 'Identifier of the invoice that generated this revenue recognition event.',
    `recognition_schedule_id` BIGINT COMMENT 'Identifier of the schedule that defines how revenue is spread over time.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` (
    `pricing_agreement_id` BIGINT COMMENT 'System-generated unique identifier for each pricing agreement.',
    `account_id` BIGINT COMMENT 'Reference to the customer that the pricing agreement applies to.',
    `customer_contract_id` BIGINT COMMENT 'Unique identifier for the customer contract record within the pricing agreement invoice entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the pricing agreement invoice entity.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product or product line covered by the agreement.',
    `accrual_method` STRING COMMENT 'Financial treatment of rebates – either cash settlement or accrual accounting.. Valid values are `cash|accrual`',
    `agreement_name` STRING COMMENT 'The agreement name of the pricing agreement record in the invoice domain.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the pricing agreement, used in contracts and invoicing.',
    `agreement_status` STRING COMMENT 'The agreement status of the pricing agreement record in the invoice domain.',
    `agreement_type` STRING COMMENT 'Category of the pricing agreement, e.g., forward supply, rebate program, spot sale, design‑win, or volume discount.. Valid values are `forward|rebate|spot|design_win|volume_discount`',
    `approval_authority` STRING COMMENT 'Role or group that granted final approval for the agreement.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the agreement received formal approval.',
    `compliance_requirements` STRING COMMENT 'Text describing any regulatory, export‑control, or industry‑specific compliance obligations attached to the agreement.',
    `contract_owner` STRING COMMENT 'Name or identifier of the internal employee responsible for the agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the pricing agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency used for pricing and rebate amounts.',
    `pricing_agreement_description` STRING COMMENT 'Narrative description providing context and purpose of the agreement.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied on top of the base price before rebate calculations.',
    `effective_end_date` DATE COMMENT 'Date on which the pricing agreement terminates; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date on which the pricing agreement becomes binding.',
    `is_confidential` BOOLEAN COMMENT 'True if the agreement terms are marked confidential for internal handling.',
    `is_exclusive` BOOLEAN COMMENT 'True if the pricing agreement provides exclusive supply rights to the customer.',
    `jurisdiction` STRING COMMENT 'ISO‑3 country code indicating the legal jurisdiction for the agreement. [ENUM-REF-CANDIDATE: USA|CAN|MEX|CHN|JPN|KOR|DEU|GBR|FRA|TWN — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the pricing agreement record in the invoice domain.',
    `last_settlement_date` DATE COMMENT 'Date on which the last rebate payment was settled.',
    `maximum_commitment_amount` DECIMAL(18,2) COMMENT 'Upper bound on total spend covered by the agreement.',
    `minimum_commitment_amount` DECIMAL(18,2) COMMENT 'Lowest total spend the customer must achieve to keep the agreement active.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the pricing agreement record in the invoice domain.',
    `next_settlement_date` DATE COMMENT 'Planned date for the upcoming rebate settlement.',
    `notes` STRING COMMENT 'Supplementary remarks, comments, or special conditions.',
    `payment_terms` STRING COMMENT 'Credit terms governing invoice payment, e.g., Net 30 days.. Valid values are `net_30|net_60|net_90`',
    `price_amount` DECIMAL(18,2) COMMENT 'Monetary amount defining the base price per unit or per metric as stipulated in the agreement.',
    `price_unit_of_measure` STRING COMMENT 'Metric that the base price applies to, such as per die, per watt, or per unit.. Valid values are `per_die|per_watt|per_unit`',
    `pricing_agreement_status` STRING COMMENT 'Lifecycle state of the agreement indicating whether it is in draft, active, suspended, terminated, or expired.. Valid values are `draft|active|suspended|terminated|expired`',
    `pricing_model` STRING COMMENT 'The pricing model of the pricing agreement record in the invoice domain.',
    `rebate_accrued_amount` DECIMAL(18,2) COMMENT 'Total rebate amount that has been accrued but not yet paid.',
    `rebate_rate` DECIMAL(18,2) COMMENT 'Percentage of rebate applied to qualifying purchases under the agreement.',
    `rebate_settled_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of rebate that has been paid to the customer.',
    `rebate_type` STRING COMMENT 'Category of rebate, such as volume‑based, growth‑based, design‑win, or market development fund.. Valid values are `volume|growth|design_win|mdf`',
    `settlement_frequency` STRING COMMENT 'How often accrued rebates are settled with the customer.. Valid values are `monthly|quarterly|annually`',
    `tax_included` BOOLEAN COMMENT 'True if the base price already incorporates applicable taxes.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Statutory tax rate applied to the pricing agreement, expressed as a percent.',
    `tier_end_quantity` DECIMAL(18,2) COMMENT 'Upper bound quantity for a specific price tier.',
    `tier_price` DECIMAL(18,2) COMMENT 'Monetary price applied to quantities falling within the tier range.',
    `tier_start_quantity` DECIMAL(18,2) COMMENT 'Lower bound quantity for a specific price tier within the agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the agreement record.',
    `version` STRING COMMENT 'Incremental version used to track amendments to the agreement.',
    `volume_threshold` DECIMAL(18,2) COMMENT 'Quantity level at which the agreements pricing or rebate conditions change.',
    `volume_threshold_unit` STRING COMMENT 'Measurement unit for the volume threshold, e.g., dies, units, or watt.. Valid values are `dies|units|watt`',
    CONSTRAINT pk_pricing_agreement PRIMARY KEY(`pricing_agreement_id`)
) COMMENT 'Customer-specific pricing and rebate agreement master records defining negotiated commercial terms for semiconductor products and services. Covers forward pricing (long-term supply agreements, design-win pricing, distributor pricing, spot pricing) and retrospective rebate programs (volume rebates, growth rebates, design-win rebates, market development funds). Captures agreement type, effective date range, product scope, volume commitment thresholds, price break tiers, rebate rate schedules, accrual basis, settlement frequency, minimum thresholds, payment method, and approval authority. Tracks accrued rebate liability and settlement status for retrospective programs. SSOT for all customer pricing validation, rebate accrual, and rebate settlement — subsumes all rebate_agreement concepts.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` (
    `dunning_notice_id` BIGINT COMMENT 'System-generated unique identifier for the dunning notice record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer to whom the overdue invoice belongs.',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the secondary ar invoice record within the dunning notice invoice entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Dunning notices are issued by a collection agent employee; needed for collection performance metrics and compliance reporting.',
    `primary_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Dunning notices reference specific overdue invoices. The collections process requires traceability from notice to outstanding billing documents.',
    `to_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Dunning notices reference the overdue invoices driving the collection action. Required for collections workflow and customer communication.',
    `collection_agency_code` BIGINT COMMENT 'Identifier of the external collection agency handling the case, if any.',
    `collection_agency_email` STRING COMMENT 'Email address of the collection agency contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `collection_agency_phone` STRING COMMENT 'Phone number of the collection agency contact.',
    `contact_address` STRING COMMENT 'Mailing address used when the delivery method is postal.',
    `contact_email` STRING COMMENT 'Email address of the customer contact point for this notice.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number of the customer contact point for this notice.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dunning notice record was first created in the system.',
    `credit_hold_flag` BOOLEAN COMMENT 'True if the customers credit is suspended because of overdue balances.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `days_overdue` STRING COMMENT 'Number of days the invoice has been past its due date at the time of the notice.',
    `delivery_method` STRING COMMENT 'Channel used to deliver the dunning notice to the customer.. Valid values are `email|postal|edi`',
    `dunning_charge` DECIMAL(18,2) COMMENT 'Fee applied for issuing the dunning notice, per collection policy.',
    `dunning_fee_applied` BOOLEAN COMMENT 'Indicates whether a dunning fee has been applied to this notice.',
    `dunning_level` STRING COMMENT 'Escalation stage of the notice, indicating how far the collection process has progressed.. Valid values are `first|second|final|legal|collection`',
    `dunning_notice_status` STRING COMMENT 'Current lifecycle status of the dunning notice.. Valid values are `draft|sent|responded|escalated|closed`',
    `escalation_threshold_exceeded` BOOLEAN COMMENT 'Indicates whether the overdue amount or days overdue have crossed a predefined escalation threshold.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Interest accrued on the overdue amount as of the notice date.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'Annualized interest rate applied to the overdue amount, expressed as a percentage.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the dunning notice record in the invoice domain.',
    `legal_hold_flag` BOOLEAN COMMENT 'True if the account is placed on legal hold due to collection actions.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the dunning notice record in the invoice domain.',
    `next_action_date` DATE COMMENT 'Planned date for the next collection activity (e.g., phone call, legal notice).',
    `notes` STRING COMMENT 'Free‑form text for internal comments or special instructions related to the notice.',
    `notice_date` TIMESTAMP COMMENT 'Timestamp when the dunning notice was generated and sent to the customer.',
    `notice_number` STRING COMMENT 'Business identifier assigned to the dunning notice, used for tracking and communication with the customer.',
    `notice_status` STRING COMMENT 'The notice status of the dunning notice record in the invoice domain.',
    `original_due_date` DATE COMMENT 'The payment due date originally agreed for the invoice.',
    `overdue_amount` DECIMAL(18,2) COMMENT 'Original invoice amount that remains unpaid at the time of the notice.',
    `payment_terms_code` STRING COMMENT 'Standard payment term code associated with the invoice (e.g., NET30).. Valid values are `NET30|NET45|NET60`',
    `response_date` DATE COMMENT 'Date on which the customer provided a response to the dunning notice.',
    `response_status` STRING COMMENT 'Indicates whether the customer has responded to the notice.. Valid values are `responded|no_response|disputed`',
    `total_due` DECIMAL(18,2) COMMENT 'Sum of overdue principal, dunning charge, and interest, representing the total amount the customer must pay.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dunning notice record.',
    CONSTRAINT pk_dunning_notice PRIMARY KEY(`dunning_notice_id`)
) COMMENT 'Dunning notice records generated for overdue customer invoices as part of the structured collections process. Captures dunning level (first reminder, second reminder, final notice, legal referral, collection agency handoff), dunning date, overdue invoice references, total overdue amount, dunning charges and late payment interest applied, customer contact details, delivery method (email, postal, EDI), and customer response status. Supports escalating collections workflow management and integrates with credit hold triggers when dunning thresholds are breached.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` (
    `tax_determination_id` BIGINT COMMENT 'System‑generated unique identifier for each tax determination record.',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the secondary ar invoice record within the tax determination invoice entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Tax liability lines are posted to specific GL accounts for tax reporting and reconciliation.',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product or service that the tax is applied to.',
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line record within the tax determination invoice entity.',
    `primary_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Tax determination records are calculated per invoice. The FK links tax computation results to the billing document for tax reporting and audit.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tax determination records must be signed off by a tax officer employee for regulatory compliance.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` (
    `write_off_id` BIGINT COMMENT 'System-generated unique identifier for the write‑off record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer whose invoice is being written off.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the approver employee record within the write off invoice entity.',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the primary ar invoice record within the write off invoice entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Write‑off transactions must be recorded against a GL account for financial statements compliance.',
    `journal_entry_id` BIGINT COMMENT 'Link to the corresponding general‑ledger entry generated for the write‑off.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department owning the write‑off transaction.',
    `primary_write_ar_invoice_id` BIGINT COMMENT 'Identifier of the invoice that is the subject of the write‑off.',
    `primary_write_employee_id` BIGINT COMMENT 'Identifier of the employee or manager who approved the write‑off.',
    `tertiary_write_updated_by_user_employee_id` BIGINT COMMENT 'User who performed the most recent update to the write‑off record.',
    `to_ar_invoice_id` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Write-offs must reference the specific invoices being written off for accounting accuracy and potential recovery tracking.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the write off record in the invoice domain.',
    `amount_adjustment` DECIMAL(18,2) COMMENT 'Sum of tax, fees, or discounts applied to the write‑off.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Original invoice amount before any adjustments.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount written off after adjustments; the amount removed from accounts receivable.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the write‑off received formal approval.',
    `approved_by` STRING COMMENT 'The approved by of the write off record in the invoice domain.',
    `bad_debt_expense_account` STRING COMMENT 'General Ledger account used to record the bad‑debt expense.. Valid values are `^[0-9]{4,6}$`',
    `batch_reference` BIGINT COMMENT 'Identifier of the processing batch in which this write‑off was loaded.',
    `write_off_category` STRING COMMENT 'High‑level business domain that triggered the write‑off.. Valid values are `financial|legal|operational`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the write‑off is subject to regulatory compliance review.',
    `cost_center_code` STRING COMMENT 'Internal cost center responsible for the write‑off expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the write‑off record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the write‑off amount.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Accounting period start date for the write‑off entry.',
    `external_reference` STRING COMMENT 'Identifier used by an external ERP or legacy system to reference this write‑off.',
    `financial_period` STRING COMMENT 'Fiscal period (year and quarter) to which the write‑off is allocated.. Valid values are `FY[0-9]{4}Q[1-4]`',
    `is_reversed` BOOLEAN COMMENT 'True if the write‑off has been reversed after posting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the write off record in the invoice domain.',
    `method` STRING COMMENT 'Indicates whether the write‑off was entered manually or generated by an automated rule.. Valid values are `manual|automatic`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the write off record in the invoice domain.',
    `notes` STRING COMMENT 'Free‑form comments or justification details entered by the approver.',
    `reason` STRING COMMENT 'Standardized reason why the invoice balance is being written off.. Valid values are `bankruptcy|dispute|statute_of_limitations|uncollectible|customer_request|other`',
    `reason_code` STRING COMMENT 'Coded value representing the reason code of the write off invoice record.',
    `recovery_attempts` STRING COMMENT 'Number of collection attempts made after the write‑off was posted.',
    `recovery_flag` BOOLEAN COMMENT 'Indicates whether the write‑off will be monitored for possible future recovery.',
    `recovery_status` STRING COMMENT 'Current status of any post‑write‑off recovery effort.. Valid values are `not_started|in_progress|recovered|written_off`',
    `region_code` STRING COMMENT 'Three‑letter code of the geographic region associated with the write‑off.. Valid values are `^[A-Z]{3}$`',
    `regulatory_reporting_code` STRING COMMENT 'Code used for statutory reporting (e.g., SEC, SOX, CHIPS Act).',
    `reversal_date` DATE COMMENT 'Date on which the write‑off reversal was recorded.',
    `sequence` STRING COMMENT 'Sequential number of the write‑off within its processing batch.',
    `tax_effect_amount` DECIMAL(18,2) COMMENT 'Tax component of the write‑off amount, if applicable.',
    `to_ar_invoice` BIGINT COMMENT 'FK to invoice.ar_invoice.ar_invoice_id — Write-off records must reference the specific invoices being written off. Required for bad debt accounting and recovery tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the write‑off record.',
    `write_off_date` DATE COMMENT 'Date on which the write‑off was executed in the accounting system.',
    `write_off_number` STRING COMMENT 'External reference number assigned to the write‑off transaction for tracking and audit.',
    `write_off_reason` STRING COMMENT 'The write off reason of the write off record in the invoice domain.',
    `write_off_status` STRING COMMENT 'Current processing state of the write‑off record.. Valid values are `pending|approved|rejected|closed`',
    `write_off_type` STRING COMMENT 'Classification of the write‑off based on its financial nature.. Valid values are `bad_debt|discount|adjustment|write_down`',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Bad debt write-off records for uncollectable customer invoice balances that have been approved for removal from accounts receivable. Captures write-off date, written-off invoice references, write-off amount, write-off reason (customer bankruptcy, unresolvable dispute, statute of limitations), approval authority, bad debt expense account, and recovery tracking flag for subsequent collections efforts.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Primary key for performance_obligation',
    `account_id` BIGINT COMMENT 'Identifier of the customer to whom the performance obligation applies.',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the ar invoice record within the performance obligation invoice entity.',
    `customer_contract_id` BIGINT COMMENT 'Reference to the parent contract that contains this performance obligation.',
    `parent_performance_obligation_id` BIGINT COMMENT 'Self-referencing FK on performance_obligation (parent_performance_obligation_id)',
    `performance_customer_contract_id` BIGINT COMMENT 'Unique identifier for the performance customer contract record within the performance obligation invoice entity.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Quantity actually delivered or consumed against the target.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the performance obligation record in the invoice domain.',
    `billing_end_date` DATE COMMENT 'Date of the final billing occurrence; null if billing continues until obligation end.',
    `billing_frequency` STRING COMMENT 'How often billing events are generated for the obligation.',
    `billing_start_date` DATE COMMENT 'Date of the first billing occurrence for the obligation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.',
    `performance_obligation_description` STRING COMMENT 'Free‑form text describing the purpose and scope of the performance obligation.',
    `effective_end_date` DATE COMMENT 'Date when the performance obligation terminates or expires; null for open‑ended obligations.',
    `effective_start_date` DATE COMMENT 'Date when the performance obligation becomes binding.',
    `end_date` DATE COMMENT 'The end date associated with the performance obligation invoice record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the performance obligation record in the invoice domain.',
    `measurement_unit` STRING COMMENT 'Unit of measure for target and actual quantities.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the performance obligation record in the invoice domain.',
    `notes` STRING COMMENT 'Additional remarks or comments entered by users regarding the performance obligation.',
    `obligation_code` STRING COMMENT 'Coded value representing the obligation code of the performance obligation invoice record.',
    `obligation_description` STRING COMMENT 'The obligation description of the performance obligation record in the invoice domain.',
    `obligation_number` STRING COMMENT 'External business identifier assigned to the performance obligation, used in contracts and invoicing.',
    `obligation_status` STRING COMMENT 'The obligation status of the performance obligation record in the invoice domain.',
    `obligation_type` STRING COMMENT 'Category of the performance obligation defining the nature of the deliverable.',
    `performance_metric` STRING COMMENT 'Metric used to measure fulfillment of the obligation (e.g., units delivered, usage hours).',
    `performance_obligation_status` STRING COMMENT 'Current lifecycle state of the performance obligation.',
    `recognition_end_date` DATE COMMENT 'Date when revenue recognition ends for the obligation.',
    `recognition_start_date` DATE COMMENT 'Date when revenue recognition begins for the obligation.',
    `recognized_amount` DECIMAL(18,2) COMMENT 'Cumulative revenue amount that has been recognized to date for this obligation.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for the obligation.',
    `satisfaction_method` STRING COMMENT 'The satisfaction method of the performance obligation record in the invoice domain.',
    `start_date` DATE COMMENT 'The start date associated with the performance obligation invoice record.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Quantitative target that must be achieved to satisfy the obligation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the obligations monetary amounts.',
    `tax_code` STRING COMMENT 'Code indicating the tax regime applicable to the obligation.',
    `total_amount` DECIMAL(18,2) COMMENT 'Contractual monetary amount to be recognized for the obligation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance obligation record.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Master reference table for performance_obligation. Referenced by performance_obligation_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` (
    `recognition_schedule_id` BIGINT COMMENT 'Primary key for recognition_schedule',
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the ar invoice record within the recognition schedule invoice entity.',
    `performance_obligation_id` BIGINT COMMENT 'Unique identifier for the performance obligation record within the recognition schedule invoice entity.',
    `revenue_recognition_event_id` BIGINT COMMENT 'Unique identifier for the revenue recognition event record within the recognition schedule invoice entity.',
    `revised_recognition_schedule_id` BIGINT COMMENT 'Self-referencing FK on recognition_schedule (revised_recognition_schedule_id)',
    `amount_per_period` DECIMAL(18,2) COMMENT 'Revenue amount allocated to each recognition period.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the schedule record was initially inserted.',
    `currency_code` STRING COMMENT 'ISO 4217 currency identifier for monetary amounts.',
    `recognition_schedule_description` STRING COMMENT 'Narrative explaining the business purpose and rules of the schedule.',
    `effective_from` DATE COMMENT 'First date on which the schedule may be applied to revenue.',
    `effective_until` DATE COMMENT 'Last date on which the schedule is valid; null if open‑ended.',
    `frequency` STRING COMMENT 'Interval at which revenue is recognized (e.g., monthly).',
    `is_prorated` BOOLEAN COMMENT 'True if the schedule allows prorated revenue for partial periods.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the recognition schedule record in the invoice domain.',
    `last_review_date` DATE COMMENT 'Most recent date on which the schedule was reviewed for compliance or accuracy.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the recognition schedule record in the invoice domain.',
    `period_count` STRING COMMENT 'Total count of recognition periods defined by the schedule.',
    `recognition_method` STRING COMMENT 'The recognition method of the recognition schedule record in the invoice domain.',
    `recognition_schedule_status` STRING COMMENT 'Indicates whether the schedule is currently in use, pending, or retired.',
    `recognized_flag` BOOLEAN COMMENT 'The recognized flag of the recognition schedule record in the invoice domain.',
    `schedule_code` STRING COMMENT 'Unique business code that identifies the schedule across systems.',
    `schedule_line_number` STRING COMMENT 'The schedule line number of the recognition schedule record in the invoice domain.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the revenue recognition schedule.',
    `schedule_period` STRING COMMENT 'The schedule period of the recognition schedule record in the invoice domain.',
    `schedule_status` STRING COMMENT 'The schedule status of the recognition schedule record in the invoice domain.',
    `schedule_type` STRING COMMENT 'Method used to allocate revenue over time (e.g., straight‑line, milestone, percentage‑of‑completion, custom).',
    `scheduled_amount` DECIMAL(18,2) COMMENT 'The scheduled amount of the recognition schedule record in the invoice domain.',
    `scheduled_date` DATE COMMENT 'The scheduled date associated with the recognition schedule invoice record.',
    `total_amount` DECIMAL(18,2) COMMENT 'Aggregate revenue amount that the schedule will recognize over its lifetime.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the last modification to the schedule record.',
    `version_number` STRING COMMENT 'Incremental version identifier used for change management.',
    CONSTRAINT pk_recognition_schedule PRIMARY KEY(`recognition_schedule_id`)
) COMMENT 'Master reference table for recognition_schedule. Referenced by recognition_schedule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_primary_ar_payment_term_id` FOREIGN KEY (`primary_ar_payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_primary_ar_pricing_agreement_id` FOREIGN KEY (`primary_ar_pricing_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_to_payment_term_id` FOREIGN KEY (`to_payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_to_pricing_agreement_id` FOREIGN KEY (`to_pricing_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_to_ar_invoice_id` FOREIGN KEY (`to_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ADD CONSTRAINT `fk_invoice_nre_billing_milestone_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ADD CONSTRAINT `fk_invoice_nre_billing_milestone_primary_ar_invoice_id` FOREIGN KEY (`primary_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_primary_adjustment_ar_invoice_id` FOREIGN KEY (`primary_adjustment_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_tertiary_adjustment_applied_to_invoice_ar_invoice_id` FOREIGN KEY (`tertiary_adjustment_applied_to_invoice_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_primary_ar_invoice_id` FOREIGN KEY (`primary_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_reversal_reference_payment_receipt_id` FOREIGN KEY (`reversal_reference_payment_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_receipt`(`payment_receipt_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_to_ar_invoice_id` FOREIGN KEY (`to_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ADD CONSTRAINT `fk_invoice_royalty_billing_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ADD CONSTRAINT `fk_invoice_royalty_billing_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ADD CONSTRAINT `fk_invoice_royalty_billing_primary_ar_invoice_id` FOREIGN KEY (`primary_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ADD CONSTRAINT `fk_invoice_royalty_billing_to_ar_invoice_id` FOREIGN KEY (`to_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_customer_credit_limit_id` FOREIGN KEY (`customer_credit_limit_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit`(`customer_credit_limit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_primary_revenue_ar_invoice_id` FOREIGN KEY (`primary_revenue_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_recognition_schedule_id` FOREIGN KEY (`recognition_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`recognition_schedule`(`recognition_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ADD CONSTRAINT `fk_invoice_dunning_notice_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ADD CONSTRAINT `fk_invoice_dunning_notice_primary_ar_invoice_id` FOREIGN KEY (`primary_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ADD CONSTRAINT `fk_invoice_dunning_notice_to_ar_invoice_id` FOREIGN KEY (`to_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_primary_ar_invoice_id` FOREIGN KEY (`primary_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_to_ar_invoice_id` FOREIGN KEY (`to_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_primary_write_ar_invoice_id` FOREIGN KEY (`primary_write_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_to_ar_invoice_id` FOREIGN KEY (`to_ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ADD CONSTRAINT `fk_invoice_performance_obligation_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ADD CONSTRAINT `fk_invoice_performance_obligation_parent_performance_obligation_id` FOREIGN KEY (`parent_performance_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ADD CONSTRAINT `fk_invoice_recognition_schedule_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ADD CONSTRAINT `fk_invoice_recognition_schedule_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ADD CONSTRAINT `fk_invoice_recognition_schedule_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ADD CONSTRAINT `fk_invoice_recognition_schedule_revised_recognition_schedule_id` FOREIGN KEY (`revised_recognition_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`recognition_schedule`(`recognition_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`invoice` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`invoice` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` SET TAGS ('dbx_category' = 'transaction');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Invoice ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Pkg Assembly Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `primary_ar_payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `primary_ar_pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Pricing Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `to_payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'To Payment Term Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ALTER COLUMN `to_pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'To Pricing Agreement Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` SET TAGS ('dbx_ssot_owner' = 'order.order_line');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'IP Core Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Mpw Shuttle Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `to_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `authoritative_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|due_on_receipt');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` SET TAGS ('dbx_category' = 'transaction');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `nre_billing_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'NRE Billing Milestone ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `primary_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Project ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `sales_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Nre Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Billing Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `billing_formula` SET TAGS ('dbx_business_glossary_term' = 'Billing Formula');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `billing_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Trigger Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `billing_trigger_type` SET TAGS ('dbx_value_regex' = 'milestone|schedule|shipment|subscription');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'ITAR|EAR|RoHS|REACH|ISO9001');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document URL');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Billing Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Billing Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `nre_billing_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `nre_billing_milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|upon_receipt|custom');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Billing Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `recurring_interval` SET TAGS ('dbx_business_glossary_term' = 'Recurring Interval');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `recurring_interval` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|yearly');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` SET TAGS ('dbx_category' = 'transaction');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `adjustment_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Memo Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Entry Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `primary_adjustment_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Related Contract Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `tertiary_adjustment_applied_to_invoice_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Applied To Invoice Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `adjustment_category` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Category');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `adjustment_memo_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Memo Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `adjustment_memo_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|posted|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Memo Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `adjustment_subtype` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Subtype');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type (Credit/Debit/Correction)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'credit|debit|correction');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Adjustment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Adjustment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `audit_user_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creator User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `audit_user_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modifier User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Comments');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `last_modified_reason` SET TAGS ('dbx_business_glossary_term' = 'Last Modification Reason');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `memo_date` SET TAGS ('dbx_business_glossary_term' = 'Memo Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `memo_number` SET TAGS ('dbx_business_glossary_term' = 'Memo Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `memo_status` SET TAGS ('dbx_business_glossary_term' = 'Memo Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `memo_type` SET TAGS ('dbx_business_glossary_term' = 'Memo Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `original_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance After Adjustment');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'unsettled|settled|partial');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Adjustment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` SET TAGS ('dbx_category' = 'transaction');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `payment_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `primary_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` SET TAGS ('dbx_category' = 'transaction');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Billing ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'IP Core ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `primary_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `product_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Product Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `to_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (AA)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Date (BD)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `billing_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Number (BN)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `billing_number` SET TAGS ('dbx_value_regex' = '^RB-d{8}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `billing_period` SET TAGS ('dbx_business_glossary_term' = 'Billing Period');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status (BS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'draft|issued|paid|overdue|disputed|closed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag (DF)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason (DR)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date (PDD)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `exchange_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to USD (ER)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `is_royalty_exempt` SET TAGS ('dbx_business_glossary_term' = 'Royalty Exempt Flag (REF)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date (LAD)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `minimum_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Amount (MCA)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PM)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire|ach|check|credit_card');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date (PRD)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference (PR)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status (RS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|exception');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (RC)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Royalty Amount (GRA)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Amount (NRA)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_billing_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Billing Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Method (RCM)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_value_regex' = 'self_report|audit|estimated');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_period_end` SET TAGS ('dbx_business_glossary_term' = 'Royalty Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_period_start` SET TAGS ('dbx_business_glossary_term' = 'Royalty Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate (RR)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Usd');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type (RT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'per_unit|percentage_of_revenue');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TA)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TC)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TR)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Royalty Tier Level (TTL)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `tier_level` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `to_ar_invoice` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `unit_shipment_volume` SET TAGS ('dbx_business_glossary_term' = 'Unit Shipment Volume (USV)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `units_shipped` SET TAGS ('dbx_business_glossary_term' = 'Units Shipped');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` SET TAGS ('dbx_subdomain' = 'commercial_terms');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` SET TAGS ('dbx_category' = 'reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` SET TAGS ('dbx_category' = 'reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `customer_credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Credit Limit ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `customer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `customer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ALTER COLUMN `customer_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` SET TAGS ('dbx_category' = 'event');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `credit_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Identifier (CHID)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Overdue Invoice Identifier (OII)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Placed By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `primary_credit_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `primary_credit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst Identifier (CAI)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `primary_credit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `primary_credit_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|due_on_receipt');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `placed_date` SET TAGS ('dbx_business_glossary_term' = 'Placed Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Release Timestamp (CHRT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `released_by` SET TAGS ('dbx_business_glossary_term' = 'Released By');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `released_date` SET TAGS ('dbx_business_glossary_term' = 'Released Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Score (CRS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` SET TAGS ('dbx_category' = 'event');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `actual_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `attached_documents_flag` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Dispute Channel');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|phone|portal|mail|in_person');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Close Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` SET TAGS ('dbx_category' = 'event');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `primary_revenue_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ALTER COLUMN `recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Schedule ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` SET TAGS ('dbx_subdomain' = 'commercial_terms');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` SET TAGS ('dbx_category' = 'reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Identifier (PRICING_AGREEMENT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PRODUCT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method (ACCRUAL_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'cash|accrual');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number (AGMT_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type (AGMT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'forward|rebate|spot|design_win|volume_discount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority (APPROVAL_AUTH)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp (APPROVED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMPLIANCE_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner (CONTRACT_OWNER)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `pricing_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description (AGMT_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (DISCOUNT_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Agreement Flag (CONF_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `is_confidential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Agreement Flag (EXCL_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURIS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `last_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Settlement Date (LAST_SETTLE_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `maximum_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Commitment Amount (MAX_COMMIT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `minimum_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Amount (MIN_COMMIT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `next_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Settlement Date (NEXT_SETTLE_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes (AGMT_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Price Amount (BASE_PRICE)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (PRICE_UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_value_regex' = 'per_die|per_watt|per_unit');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `pricing_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status (AGMT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `pricing_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `rebate_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Accrued Amount (REBATE_ACCRUED)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate (REBATE_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `rebate_settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settled Amount (REBATE_SETTLED)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `rebate_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Type (REBATE_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `rebate_type` SET TAGS ('dbx_value_regex' = 'volume|growth|design_win|mdf');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency (SETTLE_FREQ)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `tax_included` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag (TAX_INCL)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `tier_end_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier End Quantity (TIER_END_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `tier_price` SET TAGS ('dbx_business_glossary_term' = 'Tier Price (TIER_PRICE)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `tier_start_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier Start Quantity (TIER_START_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version (AGMT_VER)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `volume_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold (VOL_THRESHOLD)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `volume_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Unit (VOL_UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ALTER COLUMN `volume_threshold_unit` SET TAGS ('dbx_value_regex' = 'dies|units|watt');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` SET TAGS ('dbx_category' = 'event');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `dunning_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Agent Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `primary_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `to_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `collection_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `collection_agency_email` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Email');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `collection_agency_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `collection_agency_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `collection_agency_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `collection_agency_phone` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Phone');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `collection_agency_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `collection_agency_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Postal Address');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal|edi');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `dunning_charge` SET TAGS ('dbx_business_glossary_term' = 'Dunning Charge Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `dunning_fee_applied` SET TAGS ('dbx_business_glossary_term' = 'Dunning Fee Applied Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_value_regex' = 'first|second|final|legal|collection');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `dunning_notice_status` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `dunning_notice_status` SET TAGS ('dbx_value_regex' = 'draft|sent|responded|escalated|closed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `escalation_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Exceeded Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Interest Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `notice_status` SET TAGS ('dbx_business_glossary_term' = 'Notice Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `original_due_date` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Principal Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = 'NET30|NET45|NET60');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'responded|no_response|disputed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `total_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` SET TAGS ('dbx_category' = 'reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `tax_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Determination ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `primary_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` SET TAGS ('dbx_category' = 'event');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Entry Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `primary_write_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `primary_write_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `primary_write_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `primary_write_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `tertiary_write_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Updater User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `tertiary_write_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `tertiary_write_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `to_ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `amount_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Adjustment Amount (WRITEOFF_AMT_ADJ)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Write‑Off Amount (WRITEOFF_AMT_GROSS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Write‑Off Amount (WRITEOFF_AMT_NET)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `bad_debt_expense_account` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Expense GL Account (GL_ACC_BAD_DEBT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `bad_debt_expense_account` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Batch Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_category` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Category (WRITEOFF_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_category` SET TAGS ('dbx_value_regex' = 'financial|legal|operational');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `financial_period` SET TAGS ('dbx_business_glossary_term' = 'Financial Period (FYQ)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `financial_period` SET TAGS ('dbx_value_regex' = 'FY[0-9]{4}Q[1-4]');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `is_reversed` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Method (WRITEOFF_MTH)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'manual|automatic');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Reason (WRITEOFF_RSN)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `reason` SET TAGS ('dbx_value_regex' = 'bankruptcy|dispute|statute_of_limitations|uncollectible|customer_request|other');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `recovery_attempts` SET TAGS ('dbx_business_glossary_term' = 'Recovery Attempt Count');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `recovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Tracking Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status (RECOVERY_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `recovery_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|recovered|written_off');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑3)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `tax_effect_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Effect Amount (TAX_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `to_ar_invoice` SET TAGS ('dbx_business_glossary_term' = 'To Ar Invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date (WRITEOFF_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Number (WRITEOFF_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write Off Reason');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status (WRITEOFF_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|closed');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Type (WRITEOFF_TYP)');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_value_regex' = 'bad_debt|discount|adjustment|write_down');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` SET TAGS ('dbx_category' = 'reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `parent_performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Performance Obligation Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `parent_performance_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `performance_customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `billing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing End Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `billing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `performance_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `recognition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition End Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `recognition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `satisfaction_method` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Method');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` SET TAGS ('dbx_domain' = 'invoice');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` SET TAGS ('dbx_category' = 'reference');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Schedule Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `revised_recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Recognition Schedule Id');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `revised_recognition_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `amount_per_period` SET TAGS ('dbx_business_glossary_term' = 'Amount Per Period');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `recognition_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `period_count` SET TAGS ('dbx_business_glossary_term' = 'Period Count');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Recognition Method');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `recognition_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `recognized_flag` SET TAGS ('dbx_business_glossary_term' = 'Recognized Flag');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `schedule_period` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `scheduled_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`recognition_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
