-- Schema for Domain: billing | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`billing` COMMENT 'Revenue cycle management including consumption-based billing, rate structures, invoice generation, payment processing, payment plans, collections, delinquency management, billing adjustments, dispute resolution, and revenue recognition. SSOT for all financial transactions with customers including water, wastewater, stormwater, and other utility charges.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system-generated identifier for the invoice record. Primary key for the invoice entity. Ref: Oracle CC&B.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Invoices must link directly to customer accounts for customer service operations, billing inquiries, dispute resolution, and account history reporting. Customer service representatives need direct acc. Ref: Oracle CC&B.',
    `rate_schedule_id` DECIMAL(18,2) COMMENT 'Foreign key linking to billing.billing_rate_schedule. Business justification: invoice.rate_schedule_code is a denormalized STRING reference to the billing_rate_schedule table, which has its own rate_schedule_code attribute. Adding a proper FK billing_rate_schedule_id normalizes',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Invoices are generated per service agreement in water utility billing. The service agreement governs rate schedule, service type, and billing terms. Direct FK enables invoice-to-agreement reporting, r',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: LCRR compliance billing requires direct service line material reference on invoices for lead service line notices, leak adjustment workflows need service line condition metadata, and high-bill investi',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustment amount applied to the invoice, including credits for billing errors, leak adjustments, service quality issues, or promotional discounts. Positive values increase invoice total; negative values decrease it. Ref: Oracle CC&B.',
    `balance_due_usd` DECIMAL(18,2) COMMENT 'The balance due usd value recorded for each invoice in the billing domain.',
    `billing_period_end_date` DATE COMMENT 'Last day of the consumption period covered by this invoice. Typically aligns with the current meter read date or service period end. Ref: Oracle CC&B.',
    `billing_period_start_date` DATE COMMENT 'First day of the consumption period covered by this invoice. Typically aligns with the prior meter read date or service period start. Ref: Oracle CC&B.',
    `ccr_included` BOOLEAN COMMENT 'Boolean flag indicating whether the annual Consumer Confidence Report (water quality report) was included with this invoice mailing. Required annually under Safe Drinking Water Act (SDWA). Ref: Oracle CC&B.',
    `conservation_message` STRING COMMENT 'Optional water conservation message or tip printed on the invoice to encourage efficient water use. May vary seasonally or based on drought conditions. Ref: Oracle CC&B.',
    `created_by_user` STRING COMMENT 'User ID or system process name that created this invoice record. For automated cycle billing, typically a batch process identifier; for manual invoices, the billing staff user ID. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was first created in the billing system. Used for audit trail and data lineage. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the invoice was delivered to the customer. Options include postal mail (paper bill), email (electronic bill), customer web portal, or SMS notification with portal link. Ref: Oracle CC&B.. Valid values are `postal_mail|email|customer_portal|sms`',
    `disconnection_date` DATE COMMENT 'Date on which service may be disconnected if payment is not received. Typically set 10-15 days after due date, subject to regulatory notice requirements and customer protections. Ref: Oracle CC&B.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has formally disputed charges on this invoice. Triggers dispute resolution workflow and may suspend collection activities. Ref: Oracle CC&B.',
    `due_date` DATE COMMENT 'Date by which payment must be received to avoid late fees or service disconnection. Calculated based on invoice date plus payment terms (typically 15-30 days). Ref: Oracle CC&B.',
    `generation_method` STRING COMMENT 'Method by which the invoice was generated. Automated cycle invoices are produced by scheduled batch billing runs; manual invoices are created by billing staff; off-cycle invoices are generated outside normal schedules; estimated invoices use projected consumption; corrected invoices replace prior errors. Ref: Oracle CC&B.. Valid values are `automated_cycle|manual|off_cycle|estimated|corrected`',
    `invoice_date` DATE COMMENT 'Date the invoice was generated and issued to the customer. This is the official invoice date printed on the bill and used for aging calculations. Ref: Oracle CC&B.',
    `invoice_number` STRING COMMENT 'Externally visible, human-readable invoice number printed on customer bills and used for customer service inquiries. Must be unique across all invoices. Ref: Oracle CC&B.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle state of the invoice. Draft invoices are pending finalization; issued invoices have been sent to customers; paid invoices are fully settled; partial_paid invoices have received some payment; overdue invoices are past due date; cancelled invoices are nullified before payment; void invoices are nullified after issuance. [ENUM-REF-CANDIDATE: draft|issued|paid|partial_paid|overdue|cancelled|void — 7 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on billing circumstances. Regular cycle invoices are standard periodic bills; final invoices are issued upon service termination; estimated invoices use projected consumption when actual reads are unavailable; corrected invoices replace erroneous prior bills; off-cycle invoices are generated outside normal billing cycles; adjustment invoices correct prior billing errors. Ref: Oracle CC&B.. Valid values are `regular_cycle|final|estimated|corrected|off_cycle|adjustment`',
    `is_estimated` BOOLEAN COMMENT 'Boolean flag indicating whether consumption values on this invoice are estimated rather than based on actual meter readings. True when meter is inaccessible or malfunctioning. Ref: Oracle CC&B.',
    `is_final` BOOLEAN COMMENT 'Boolean flag indicating whether this is a final invoice issued upon service termination or account closure. Final invoices settle all outstanding charges and close the billing relationship. Ref: Oracle CC&B.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Late payment penalty assessed if payment is not received by due date. Calculated as a percentage of outstanding balance or flat fee per utility policy and regulatory limits. Ref: Oracle CC&B.',
    `modified_by_user` STRING COMMENT 'User ID or system process name that last modified this invoice record. Used for audit trail and accountability. Ref: Oracle CC&B.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was last modified. Updated whenever invoice status, amounts, or other attributes change. Ref: Oracle CC&B.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date until payment is due. Standard terms are typically 15, 21, or 30 days depending on utility policy and customer class. Ref: Oracle CC&B.',
    `period_end_date` DATE COMMENT 'The period end date associated with each invoice record in the billing domain.',
    `period_start_date` DATE COMMENT 'The period start date associated with each invoice record in the billing domain.',
    `previous_balance_amount` DECIMAL(18,2) COMMENT 'Outstanding balance carried forward from prior billing periods. Represents unpaid or partially paid amounts from previous invoices. Ref: Oracle CC&B.',
    `print_date` DATE COMMENT 'Date the invoice was physically printed or electronically rendered for delivery to the customer. May differ from invoice date for batch processing. Ref: Oracle CC&B.',
    `stormwater_area` DECIMAL(18,2) COMMENT 'Total impervious surface area (in square feet or square meters) used to calculate stormwater management fees. Applicable for properties subject to stormwater utility charges. Ref: Oracle CC&B.',
    `stormwater_charge_amount` DECIMAL(18,2) COMMENT 'Charges for stormwater management services, typically calculated based on impervious surface area. Supports stormwater infrastructure maintenance and regulatory compliance. Ref: Oracle CC&B.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charges applied to the invoice, including sales tax, utility tax, franchise fees, or other regulatory taxes as required by jurisdiction. Ref: Oracle CC&B.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Total amount the customer must pay, calculated as sum of current period charges (water, wastewater, stormwater, other), taxes, adjustments, and previous balance. This is the headline amount printed on the invoice. Ref: Oracle CC&B.',
    `total_amount_usd` DECIMAL(18,2) COMMENT 'The total amount usd value recorded for each invoice in the billing domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each invoice record in the billing domain.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: Oracle CC&B.',
    `wastewater_charge_amount` DECIMAL(18,2) COMMENT 'Total charges for wastewater collection and treatment services during the billing period. May include volumetric charges, fixed fees, and strength-of-waste surcharges for industrial users. Ref: Oracle CC&B.',
    `wastewater_volume` DECIMAL(18,2) COMMENT 'Volume of wastewater discharged during the billing period, typically calculated as a percentage of water consumption or measured separately for industrial customers. Measured in same unit as water consumption. Ref: Oracle CC&B.',
    `water_charge_amount` DECIMAL(18,2) COMMENT 'Total charges for potable water service during the billing period, including volumetric consumption charges and fixed service fees. Calculated based on applicable rate schedule and tier structure. Ref: Oracle CC&B.',
    `water_consumption_uom` STRING COMMENT 'Unit of measure for water consumption volume. Common units include gallons, cubic meters (m³), hundred cubic feet (CCF), or thousand gallons (kgal). Ref: Oracle CC&B.. Valid values are `gallons|cubic_meters|ccf|kgal`',
    `water_consumption_volume` DECIMAL(18,2) COMMENT 'Total volume of potable water consumed during the billing period, measured in gallons or cubic meters depending on utility standard. Derived from meter readings or estimated when actual reads unavailable. Ref: Oracle CC&B.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document representing a periodic, on-demand, or final statement of charges issued to a customer billing account for water, wastewater, stormwater, and other utility services. Captures billing period, due date, total amount due, invoice status (draft, issued, paid, overdue, cancelled), bill type (regular cycle, final, estimated, corrected, off-cycle), generation method, closing meter read reference (for final bills), deposit application amount, and forwarding address (for final bill refunds). SSOT for all customer-facing billing documents including final bills upon service termination.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for the invoice line product. Ref: Oracle CC&B.',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header that contains this line item. Links the line to the billing document. Ref: Oracle CC&B.',
    `rate_component_id` BIGINT COMMENT 'Foreign key linking to billing.rate_component. Business justification: Each invoice_line represents a discrete billable component (base charge, volumetric tier, stormwater fee, etc.) that is generated by a specific rate_component within the billing_rate_schedule. invoice',
    `rate_schedule_id` DECIMAL(18,2) COMMENT 'Reference to the rate schedule applied to calculate this charge. Determines pricing structure and rate components. Ref: Oracle CC&B.',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Water consumption line items are directly attributable to the service line delivery point. LCRR surcharges, leak adjustment line items, and service line replacement cost recovery charges all reference',
    `sewer_service_connection_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_service_connection. Business justification: Itemized sewer billing requires each wastewater charge line to reference the specific sewer service connection generating the charge. Wastewater revenue reporting and connection-level billing audits d',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for billing adjustments, credits, or special charges. Used for adjustment and dispute tracking. [ENUM-REF-CANDIDATE: BILLING_ERROR|METER_MALFUNCTION|LEAK_ADJUSTMENT|CUSTOMER_DISPUTE|RATE_CHANGE|PRORATION|CREDIT_MEMO|WRITE_OFF|GOODWILL|OTHER — 10 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `adjustment_reference_number` STRING COMMENT 'Reference number linking this line to an adjustment request, dispute case, or credit memo. Provides audit trail for non-standard charges. Ref: Oracle CC&B.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each invoice line in the billing domain.',
    `billing_determinant` STRING COMMENT 'The basis or method used to calculate this charge. Identifies whether charge is based on metered usage, property characteristics, flat rate, or other factors. [ENUM-REF-CANDIDATE: METERED_CONSUMPTION|ESTIMATED_CONSUMPTION|FLAT_RATE|METER_SIZE|PROPERTY_SIZE|IMPERVIOUS_AREA|FIXTURE_COUNT|CONNECTION_SIZE|CUSTOMER_CLASS|OTHER — 10 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period for which this charge applies. Defines the conclusion of the service period being billed. Ref: Oracle CC&B.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period for which this charge applies. Defines the beginning of the service period being billed. Ref: Oracle CC&B.',
    `charge_description` STRING COMMENT 'Detailed textual description of the charge as it appears on the customer invoice. Provides human-readable explanation of the line item. Ref: Oracle CC&B.',
    `charge_type` STRING COMMENT 'The charge type value recorded for each invoice line in the billing domain.',
    `charge_type_code` STRING COMMENT 'Classification of the charge line item by billing component type. Distinguishes between consumption charges, fixed fees, taxes, adjustments, and other billing elements. [ENUM-REF-CANDIDATE: WATER_CONSUMPTION|WASTEWATER_SERVICE|STORMWATER_FEE|BASE_SERVICE|METER_CHARGE|CONNECTION_FEE|LATE_FEE|ADJUSTMENT|TAX|SURCHARGE|PENALTY|CREDIT|REBATE|DEPOSIT|OTHER — 15 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `created_by_user` STRING COMMENT 'User identifier or system process that created this invoice line record. Supports audit and accountability requirements. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was first created in the billing system. Audit trail for record creation. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Typically USD for US-based water utilities.. Valid values are `USD|CAD|EUR|GBP|AUD|MXN`',
    `invoice_line_description` STRING COMMENT 'The invoice line description value recorded for each invoice line in the billing domain.',
    `is_disputed` BOOLEAN COMMENT 'Indicates whether this charge is currently under customer dispute. True if disputed, false otherwise. Used for dispute tracking and collections management. Ref: Oracle CC&B.',
    `is_prorated` BOOLEAN COMMENT 'Indicates whether this charge has been prorated due to partial billing period, service start/stop, or rate change. True if prorated, false otherwise. Ref: Oracle CC&B.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this line item is subject to taxation. True if taxable, false if tax-exempt. Ref: Oracle CC&B.',
    `last_modified_by_user` STRING COMMENT 'User identifier or system process that last modified this invoice line record. Supports audit and accountability requirements. Ref: Oracle CC&B.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was last updated. Audit trail for record modifications. Ref: Oracle CC&B.',
    `line_amount` DECIMAL(18,2) COMMENT 'Calculated charge amount for this line item before taxes and adjustments. Typically consumption_quantity multiplied by unit_rate for consumption charges, or fixed amount for service fees. Ref: Oracle CC&B.',
    `line_number` STRING COMMENT 'The line number value recorded for each invoice line in the billing domain.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of line items within the parent invoice. Determines display order on customer bill. Ref: Oracle CC&B.',
    `line_status` STRING COMMENT 'Current status of the invoice line item in the billing lifecycle. Tracks whether the charge is active, has been adjusted, disputed, or reversed. Ref: Oracle CC&B.. Valid values are `ACTIVE|CANCELLED|ADJUSTED|DISPUTED|WRITTEN_OFF|REVERSED`',
    `print_sequence` STRING COMMENT 'Display order for this line item on printed or electronic invoices. Controls the presentation sequence for customer-facing billing documents. Ref: Oracle CC&B.',
    `proration_factor` DECIMAL(18,2) COMMENT 'Decimal factor applied for prorated charges. Represents the portion of the full billing period or rate being charged (e.g., 0.5000 for half period). Ref: Oracle CC&B.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each invoice line in the billing domain.',
    `rate_usd` DECIMAL(18,2) COMMENT 'The rate usd value recorded for each invoice line in the billing domain.',
    `revenue_class` STRING COMMENT 'Classification of revenue type for financial reporting and regulatory compliance. Distinguishes between operating revenue, capital contributions, and other revenue categories. Ref: Oracle CC&B.. Valid values are `OPERATING_REVENUE|NON_OPERATING_REVENUE|CAPITAL_CONTRIBUTION|DEFERRED_REVENUE|OTHER`',
    `service_days` STRING COMMENT 'Number of days in the billing period for this charge. Used for proration calculations and billing cycle analysis. Ref: Oracle CC&B.',
    `service_type` STRING COMMENT 'Type of utility service being billed on this line. Distinguishes between water, wastewater, stormwater, and other utility services. [ENUM-REF-CANDIDATE: WATER|WASTEWATER|STORMWATER|RECLAIMED_WATER|BULK_WATER|FIRE_PROTECTION|IRRIGATION|INDUSTRIAL|COMMERCIAL|RESIDENTIAL — 10 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to this line item. Includes sales tax, utility tax, or other applicable taxes based on jurisdiction. Ref: Oracle CC&B.',
    `tax_amount_usd` DECIMAL(18,2) COMMENT 'The tax amount usd value recorded for each invoice line in the billing domain.',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Tax rate percentage applied to calculate the tax amount. Expressed as decimal (e.g., 0.0825 for 8.25% tax rate). Ref: Oracle CC&B.',
    `total_line_amount` DECIMAL(18,2) COMMENT 'Total amount for this line item including taxes and adjustments. Sum of line_amount and tax_amount. Contributes to invoice total. Ref: Oracle CC&B.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each invoice line in the billing domain.',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per unit of consumption or service. The rate applied to calculate the line charge amount. Expressed in currency per consumption_unit_of_measure. Ref: Oracle CC&B.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual charge line item on a utility invoice, representing any discrete billable component including water consumption charges, wastewater service charges, stormwater fees, base/fixed service charges, taxes, surcharges, late payment penalties, reconnection fees, meter test fees, industrial surcharges, and billing adjustments. Captures charge type, charge source (consumption-based, service order, penalty, surcharge), rate component reference, quantity, unit rate, calculated amount, billing determinant, applicable rate tier, and originating service order reference (if field-generated). SSOT for all individual charges appearing on customer invoices.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment record. Ref: Oracle CC&B.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Payments must link to customer accounts for payment history inquiries, customer service operations, and account reconciliation. This enables customer-centric payment reporting and supports customer se. Ref: Oracle CC&B.',
    `invoice_id` BIGINT COMMENT 'Reference to the specific bill or invoice that this payment is intended to satisfy. May be null for advance payments or account credits. Ref: Oracle CC&B.',
    `payment_invoice_id` BIGINT COMMENT 'Reference to the specific bill or invoice that this payment is intended to satisfy. May be null for advance payments or account credits. Ref: Oracle CC&B.',
    `payment_plan_id` BIGINT COMMENT 'Reference to the payment plan or payment arrangement under which this payment was made. Null for non-plan payments. Ref: Oracle CC&B.',
    `reversed_by_payment_id` BIGINT COMMENT 'Reference to the reversal payment transaction that cancelled or reversed this payment. Null for non-reversed payments. Ref: Oracle CC&B.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount of the payment received from the customer, in the utilitys base currency. Ref: Oracle CC&B.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each payment in the billing domain.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been applied to outstanding account balances. May differ from payment_amount if payment is partially applied or held as credit. Ref: Oracle CC&B.',
    `authorization_code` STRING COMMENT 'Authorization or approval code returned by the payment processor for credit card or ACH transactions. Ref: Oracle CC&B.',
    `bank_account_last_four` STRING COMMENT 'Last four digits of the bank account number used for ACH or electronic payments. Used for customer verification without exposing full account number. Ref: Oracle CC&B.. Valid values are `^[0-9]{4}$`',
    `batch_number` STRING COMMENT 'Identifier for the payment batch or deposit group in which this payment was processed, used for reconciliation and audit purposes. Ref: Oracle CC&B.',
    `card_last_four` STRING COMMENT 'Last four digits of the credit or debit card number used for card payments. Used for customer verification without exposing full card number. Ref: Oracle CC&B.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'The credit or debit card brand for card payments (e.g., Visa, MasterCard, American Express, Discover). Null for non-card payments. Ref: Oracle CC&B.. Valid values are `visa|mastercard|amex|discover`',
    `channel` STRING COMMENT 'The customer interface or channel through which the payment was submitted (e.g., walk-in office, mail, web portal, mobile app, IVR phone system, bank lockbox, automatic payment). [ENUM-REF-CANDIDATE: walk_in|mail|web_portal|mobile_app|ivr|lockbox|auto_pay — 7 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `check_number` STRING COMMENT 'The check number for check payments. Null for non-check payment methods. Ref: Oracle CC&B.',
    `cleared_date` DATE COMMENT 'The date on which the payment cleared the bank or financial institution, confirming funds availability. Null for cash payments. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment record was first created in the system. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `is_auto_pay` BOOLEAN COMMENT 'Boolean flag indicating whether this payment was processed automatically through an auto-pay enrollment (True) or was a manual customer-initiated payment (False). Ref: Oracle CC&B.',
    `is_recurring` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is part of a recurring payment plan or schedule (True) or a one-time payment (False). Ref: Oracle CC&B.',
    `location_code` STRING COMMENT 'Code identifying the physical location or office where the payment was received (e.g., branch office, payment center). Null for remote payments. Ref: Oracle CC&B.',
    `lockbox_number` STRING COMMENT 'Bank lockbox number or identifier for payments received through lockbox processing services. Null for non-lockbox payments. Ref: Oracle CC&B.',
    `method` STRING COMMENT 'The financial instrument or tender type used to make the payment (e.g., check, ACH bank draft, credit card, debit card, cash, money order). Ref: Oracle CC&B.. Valid values are `check|ach|credit_card|debit_card|cash|money_order`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment record was last modified or updated. Ref: Oracle CC&B.',
    `notes` STRING COMMENT 'Free-text notes or comments about the payment transaction, including customer instructions, special handling notes, or dispute information. Ref: Oracle CC&B.',
    `nsf_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged to the customer account for a returned NSF payment. Null if no NSF occurred or no fee was assessed. Ref: Oracle CC&B.',
    `nsf_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this payment was returned due to non-sufficient funds (True) or processed successfully (False). Ref: Oracle CC&B.',
    `payment_date` DATE COMMENT 'The date on which the payment was received or processed by the utility. This is the business event date for revenue recognition. Ref: Oracle CC&B.',
    `payment_number` STRING COMMENT 'Business-facing unique reference number for the payment transaction, used for customer inquiries and reconciliation. Ref: Oracle CC&B.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction indicating whether it has been posted to the account, cleared by the bank, or reversed. Ref: Oracle CC&B.. Valid values are `pending|posted|cleared|reversed|cancelled|failed`',
    `payment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the payment transaction was received or recorded in the system. Ref: Oracle CC&B.',
    `payment_type` STRING COMMENT 'Classification of the payment purpose (e.g., regular bill payment, advance payment, deposit, refund, billing adjustment). Ref: Oracle CC&B.. Valid values are `regular|advance|deposit|refund|adjustment`',
    `posting_date` DATE COMMENT 'The date on which the payment was posted to the customer account and applied against outstanding balances. Ref: Oracle CC&B.',
    `processor_name` STRING COMMENT 'Name of the third-party payment processor or gateway that handled the electronic payment transaction (e.g., Stripe, PayPal, bank lockbox service). Ref: Oracle CC&B.',
    `reference_number` STRING COMMENT 'External reference number from the payment source (e.g., check number, ACH trace number, credit card authorization code, lockbox batch number). Ref: Oracle CC&B.',
    `reversal_reason` STRING COMMENT 'Explanation or reason code for why the payment was reversed or cancelled. Null for non-reversed payments. Ref: Oracle CC&B.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that remains unapplied and is held as account credit or pending allocation. Ref: Oracle CC&B.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each payment record in the billing domain.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: Oracle CC&B.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a financial payment transaction for a customer utility account, covering the full payment lifecycle including receipt, posting, return, and re-presentment. Captures payment date, amount, payment method (check, ACH, credit card, cash, online portal, IVR, auto-pay), source channel (walk-in, mail, web, mobile, lockbox, bank draft), posting status, return status, return reason code (NSF, account closed, stop payment), re-presentment attempts, and NSF fee assessed. SSOT for all customer payment transactions including returned/rejected payments. Sourced from Oracle CC&B and Tyler Munis payment processing.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` (
    `payment_application_id` BIGINT COMMENT 'Unique identifier for the payment application record. Primary key. Ref: Oracle CC&B.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer account for which this payment application is recorded. Ref: Oracle CC&B.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice to which this payment is being applied. Ref: Oracle CC&B.',
    `payment_id` BIGINT COMMENT 'Reference to the payment transaction being applied to outstanding charges. Ref: Oracle CC&B.',
    `payment_plan_id` BIGINT COMMENT 'Reference to the payment plan or payment arrangement if this application is part of a structured payment agreement. Ref: Oracle CC&B.',
    `invoice_line_id` BIGINT COMMENT 'Reference to the specific invoice line item to which this payment is applied. Enables line-level payment allocation. Ref: Oracle CC&B.',
    `adjustment_date` DATE COMMENT 'The date on which an adjustment was made to this payment application. Null if no adjustment occurred. Ref: Oracle CC&B.',
    `adjustment_indicator` BOOLEAN COMMENT 'Flag indicating whether this payment application was adjusted after initial processing due to billing correction or dispute resolution. Ref: Oracle CC&B.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for adjusting the payment application (e.g., billing error, dispute resolution, rate correction). Ref: Oracle CC&B.',
    `allocation_method` STRING COMMENT 'The method or rule used to allocate the payment across outstanding charges (e.g., FIFO, oldest invoice first, pro-rata across all balances). [ENUM-REF-CANDIDATE: fifo|lifo|oldest_first|highest_balance|pro_rata|manual|system_default — 7 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `application_date` DATE COMMENT 'The business date on which the payment was applied to the invoice or account balance. This is the effective date for accounts receivable (AR) reconciliation. Ref: Oracle CC&B.',
    `application_number` STRING COMMENT 'Business-readable unique identifier for the payment application transaction, used for tracking and reconciliation. Ref: Oracle CC&B.',
    `application_sequence` STRING COMMENT 'Sequential order in which this application was processed for a given payment. Supports scenarios where a single payment is split across multiple invoices. Ref: Oracle CC&B.',
    `application_source` STRING COMMENT 'Source or channel through which the payment application was initiated (e.g., automated system rule, manual CSR entry, batch process, customer self-service portal). [ENUM-REF-CANDIDATE: automated|manual|batch|api|customer_portal|ivr|mobile_app — 7 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `application_status` STRING COMMENT 'Current lifecycle status of the payment application indicating whether funds have been successfully applied, are pending, or have been reversed. Ref: Oracle CC&B.. Valid values are `applied|pending|reversed|cancelled|frozen|adjusted`',
    `application_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment application transaction was processed in the billing system. Ref: Oracle CC&B.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment that was applied to this specific invoice or line item. Supports partial payment scenarios. Ref: Oracle CC&B.',
    `applied_amount_usd` DECIMAL(18,2) COMMENT 'The applied amount usd value recorded for each payment application in the billing domain.',
    `ar_reconciliation_status` STRING COMMENT 'Status indicating whether this payment application has been successfully reconciled in the accounts receivable ledger. Ref: Oracle CC&B.. Valid values are `reconciled|pending|exception|under_review`',
    `balance_bucket_code` STRING COMMENT 'Code identifying the account balance bucket or aging category to which the payment was applied (e.g., current, 30-day, 60-day, 90-day past due). Ref: Oracle CC&B.',
    `charge_type` STRING COMMENT 'Category of charge to which the payment was applied, distinguishing between water, wastewater, stormwater, penalties, and other utility charges. [ENUM-REF-CANDIDATE: water|wastewater|stormwater|penalty|interest|reconnection|late_fee|service_charge|other — 9 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment application record was first created in the system. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the applied payment amount. Typically USD for U.S. water utilities.. Valid values are `USD|CAD|EUR|GBP|AUD|MXN`',
    `dispute_indicator` BOOLEAN COMMENT 'Flag indicating whether this payment application is associated with a billing dispute or customer challenge. Ref: Oracle CC&B.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this payment application is posted for financial accounting and revenue recognition. Ref: Oracle CC&B.',
    `is_overpayment` BOOLEAN COMMENT 'Flag indicating whether this payment application resulted in an overpayment or credit balance on the account. Ref: Oracle CC&B.',
    `is_prepayment` BOOLEAN COMMENT 'Flag indicating whether this payment application represents a prepayment applied to future charges rather than outstanding invoices. Ref: Oracle CC&B.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment application record was last updated or modified. Ref: Oracle CC&B.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment application, capturing special instructions, exceptions, or context for manual review. Ref: Oracle CC&B.',
    `overpayment_handling` STRING COMMENT 'Indicates how overpayment or excess credit is handled: refunded to customer, held as credit, transferred to another account, or held pending customer instruction. Ref: Oracle CC&B.. Valid values are `refund|credit|transfer|hold`',
    `revenue_recognition_date` DATE COMMENT 'The date on which the applied payment amount is recognized as revenue in the general ledger, per GASB revenue recognition standards. Ref: Oracle CC&B.',
    `reversal_date` DATE COMMENT 'The date on which this payment application was reversed. Null if not reversed. Ref: Oracle CC&B.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this payment application has been reversed due to payment failure, dispute, or correction. Ref: Oracle CC&B.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing the payment application (e.g., NSF, dispute, system error, customer request). Ref: Oracle CC&B.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The remaining payment amount that has not yet been applied to any invoice or charge. Represents available credit or prepayment balance. Ref: Oracle CC&B.',
    CONSTRAINT pk_payment_application PRIMARY KEY(`payment_application_id`)
) COMMENT 'Association record linking a payment to one or more invoice lines or account balance buckets, capturing how payment funds are allocated across outstanding charges per the utilitys payment application hierarchy (oldest debt first, or by charge priority). Tracks applied amount per invoice line, application sequence, application date, unapplied/overpayment balance, credit memo generation, and reversal status. Enables precise accounts receivable reconciliation and supports partial payments, prepayments, overpayment refunds, and credit applications.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique identifier for the billing account. Primary key for the billing account entity representing the financial relationship between the utility and a customer service account. Ref: Oracle CC&B.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the canonical customer account referenced by each billing account record in the billing domain.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Industrial customer permit billing: commercial/industrial billing accounts subject to discharge or pretreatment permits require direct linkage to their compliance permit for billing permit fees, surch',
    `account_number` STRING COMMENT 'Externally-visible unique account number used for customer communication, billing statements, and payment processing. This is the business identifier displayed on bills and correspondence. Ref: Oracle CC&B.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account indicating whether it is actively billing, suspended due to non-payment, closed, or in another state within the revenue cycle. Ref: Oracle CC&B.. Valid values are `active|inactive|suspended|closed|pending_activation|delinquent`',
    `account_type` STRING COMMENT 'Classification of the billing account based on customer segment and rate structure applicability. Determines which rate schedules and service classes apply. Ref: Oracle CC&B.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `aging_30_days` DECIMAL(18,2) COMMENT 'Portion of the account balance that is 1-30 days past due. Used for delinquency tracking and collections workflow triggers. Ref: Oracle CC&B.',
    `aging_60_days` DECIMAL(18,2) COMMENT 'Portion of the account balance that is 31-60 days past due. Indicates escalating delinquency requiring more aggressive collection actions. Ref: Oracle CC&B.',
    `aging_90_days` DECIMAL(18,2) COMMENT 'Portion of the account balance that is 61-90 days past due. Typically triggers final notice and service disconnection warnings. Ref: Oracle CC&B.',
    `aging_current` DECIMAL(18,2) COMMENT 'Portion of the account balance that is current and not yet past due. Part of the aging analysis for accounts receivable management. Ref: Oracle CC&B.',
    `aging_over_90_days` DECIMAL(18,2) COMMENT 'Portion of the account balance that is more than 90 days past due. Highest risk category for write-off and may result in service termination or legal action. Ref: Oracle CC&B.',
    `autopay_enrolled` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in automatic payment processing where bills are automatically paid from a bank account or credit card on the due date. Ref: Oracle CC&B.',
    `autopay_enrolled_flag` BOOLEAN COMMENT 'The autopay enrolled flag value recorded for each billing account in the billing domain.',
    `autopay_method` STRING COMMENT 'Payment instrument used for automatic payment processing if autopay is enabled. Specifies whether payments are drawn from bank account or charged to card. Ref: Oracle CC&B.. Valid values are `bank_account|credit_card|debit_card|not_enrolled`',
    `balance_forward` DECIMAL(18,2) COMMENT 'Previous balance carried forward from the prior billing cycle before current period charges are applied. Used for aging analysis and delinquency tracking. Ref: Oracle CC&B.',
    `billing_frequency` STRING COMMENT 'Frequency at which bills are generated and issued for this account. Aligns with meter reading schedules and rate structure requirements. Ref: Oracle CC&B.. Valid values are `monthly|bi_monthly|quarterly|annual`',
    `budget_billing_amount` DECIMAL(18,2) COMMENT 'Fixed monthly amount charged under budget billing program. Calculated based on historical consumption patterns and reconciled annually. Ref: Oracle CC&B.',
    `budget_billing_enrolled` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in budget billing program where monthly bills are averaged to provide consistent payment amounts throughout the year. Ref: Oracle CC&B.',
    `close_date` DATE COMMENT 'The close date associated with each billing account record in the billing domain.',
    `closed_date` DATE COMMENT 'Date when the billing account was closed and final bill was issued. Null for active accounts. Ref: Oracle CC&B.',
    `collection_status` STRING COMMENT 'Current stage in the collections workflow for delinquent accounts. Indicates escalation level and next collection action required. Ref: Oracle CC&B.. Valid values are `current|reminder_sent|final_notice|disconnection_pending|legal_action|write_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was first created in the system. Used for audit trail and data lineage tracking. Ref: Oracle CC&B.',
    `credit_balance_amount` DECIMAL(18,2) COMMENT 'The credit balance amount value recorded for each billing account in the billing domain.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed before service restrictions or additional deposits are required. Based on credit rating and payment history. Ref: Oracle CC&B.',
    `credit_rating` STRING COMMENT 'Internal credit assessment of the customer based on payment history, delinquency patterns, and account behavior. Influences deposit requirements and collection strategies. Ref: Oracle CC&B.. Valid values are `excellent|good|fair|poor|no_rating`',
    `current_balance` DECIMAL(18,2) COMMENT 'Total outstanding balance on the billing account including all charges, fees, adjustments, and payments. Positive values indicate amounts owed by the customer; negative values indicate credit balances. Ref: Oracle CC&B.',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'The current balance amount value recorded for each billing account in the billing domain.',
    `current_charges` DECIMAL(18,2) COMMENT 'Total charges for the current billing period including water consumption, wastewater service, stormwater fees, and other utility charges before adjustments. Ref: Oracle CC&B.',
    `customer_account_ref_code` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Billing accounts must reference their originating customer account for customer service inquiries, account consolidation, customer history tracking, and cross-system reconciliation. This is the founda. Ref: Oracle CC&B.',
    `deposit_on_file` DECIMAL(18,2) COMMENT 'Security deposit amount held by the utility to mitigate credit risk. May be applied to final bill or returned to customer upon account closure with good payment history. Ref: Oracle CC&B.',
    `disconnection_date` DATE COMMENT 'Date when service was disconnected due to non-payment or other account issues. Null if service is currently active. Ref: Oracle CC&B.',
    `final_bill_issued` BOOLEAN COMMENT 'Indicates whether a final bill has been generated for this account upon closure. Used to ensure proper account settlement and deposit refund processing. Ref: Oracle CC&B.',
    `last_bill_date` DATE COMMENT 'Date when the most recent bill was generated for this account. Used to calculate next billing cycle and track billing cadence. Ref: Oracle CC&B.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received. Used for payment pattern analysis and customer service inquiries. Ref: Oracle CC&B.',
    `last_payment_date` DECIMAL(18,2) COMMENT 'Date when the most recent payment was received and posted to this account. Used for payment history analysis and delinquency assessment. Ref: Oracle CC&B.',
    `late_fee_assessed` DECIMAL(18,2) COMMENT 'Total late payment fees assessed on this account for the current billing period. Applied when payment is not received by due date. Ref: Oracle CC&B.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was last updated. Used for change tracking and audit compliance. Ref: Oracle CC&B.',
    `next_bill_date` DATE COMMENT 'Scheduled date for the next bill generation based on billing cycle and frequency. Used for billing run planning and customer communication. Ref: Oracle CC&B.',
    `open_date` DATE COMMENT 'The open date associated with each billing account record in the billing domain.',
    `opened_date` DATE COMMENT 'Date when the billing account was first established. Used for customer tenure analysis and lifecycle reporting. Ref: Oracle CC&B.',
    `paperless_billing` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic bill delivery instead of printed paper bills. Reduces mailing costs and supports environmental sustainability. Ref: Oracle CC&B.',
    `paperless_billing_flag` BOOLEAN COMMENT 'The paperless billing flag value recorded for each billing account in the billing domain.',
    `past_due_amount` DECIMAL(18,2) COMMENT 'Total amount that is overdue and unpaid beyond the payment due date. Used for collections prioritization and service restriction decisions. Ref: Oracle CC&B.',
    `payment_plan_active` BOOLEAN COMMENT 'Indicates whether the customer is currently on a payment plan to pay down past due balances in installments. Used to prevent service disconnection during plan compliance. Ref: Oracle CC&B.',
    `payment_plan_balance` DECIMAL(18,2) COMMENT 'Remaining balance to be paid under the active payment plan. Tracks progress toward full payment of delinquent amounts. Ref: Oracle CC&B.',
    `payment_terms` STRING COMMENT 'Standard payment terms for this billing account specifying the number of days from invoice date until payment is due. Ref: Oracle CC&B.. Valid values are `net_15|net_30|net_45|due_on_receipt|installment`',
    `reconnection_fee` DECIMAL(18,2) COMMENT 'Fee charged to restore service after disconnection. Must be paid along with outstanding balance before service is restored. Ref: Oracle CC&B.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each billing account in the billing domain.',
    `ssot_role` STRING COMMENT 'The ssot role value recorded for each billing account in the billing domain.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each billing account record in the billing domain.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether this account is exempt from utility taxes and fees. Typically applies to government entities, non-profits, or other qualifying organizations. Ref: Oracle CC&B.',
    `tax_exempt_certificate` STRING COMMENT 'Certificate or permit number documenting the tax exemption status. Required for audit compliance and revenue reporting. Ref: Oracle CC&B.. Valid values are `^[A-Z0-9-]{0,30}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each billing account record in the billing domain.',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Financial account entity representing the billing and collections relationship between the utility and a customer at a service point. Owns the financial ledger position including current balance, security deposit amount held, credit classification, autopay enrollment status, paperless billing preference, budget billing enrollment flag, account aging buckets (current, 30/60/90/120+ days), payment history score, cash-only restriction flag, and account status (active, final-billed, closed, collections). SSOT for the financial state of a utility customer account within the revenue cycle. Links to customer domain for demographic and contact information. [SSOT: Domain-specific view; canonical source is customer.customer_account.] Differentiated: customer.customer_account is master; this is billing-specific view referencing it.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` (
    `rate_schedule_id` DECIMAL(18,2) COMMENT 'Unique identifier for the rate schedule. Primary key. Inferred role: MASTER_RESOURCE (tariff definition governing billing calculations). Ref: Oracle CC&B.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory-driven rate setting: water utility rate schedules are created or modified in direct response to regulatory mandates (EPA rules, state conservation pricing requirements, infrastructure surch',
    `superseded_by_rate_schedule_billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'Foreign key reference to the rate schedule that supersedes this one. Nullable if this rate schedule is current or retired without replacement. Ref: Oracle CC&B.',
    `base_charge_amount` DECIMAL(18,2) COMMENT 'Fixed monthly or periodic base charge (service charge) applied to customers under this rate schedule, regardless of consumption. Expressed in local currency. Ref: Oracle CC&B.',
    `base_charge_usd` DECIMAL(18,2) COMMENT 'The base charge usd value recorded for each billing rate schedule in the billing domain.',
    `billing_frequency` STRING COMMENT 'Frequency at which customers under this rate schedule are billed (e.g., monthly, bimonthly, quarterly, annual). Ref: Oracle CC&B.. Valid values are `monthly|bimonthly|quarterly|annual`',
    `billing_rate_schedule_description` DECIMAL(18,2) COMMENT 'Detailed description of the rate schedule, including its purpose, applicability, and any special conditions or notes. Ref: Oracle CC&B.',
    `billing_rate_schedule_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the rate schedule (draft, pending approval, active, superseded, retired). Lifecycle status of the tariff. Ref: Oracle CC&B.',
    `rate_schedule_code` STRING COMMENT 'Externally-known unique code identifying the rate schedule (tariff). Used on bills, regulatory filings, and customer communications. Business identifier for the tariff. Ref: Oracle CC&B.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `conservation_rate_indicator` DECIMAL(18,2) COMMENT 'Indicates whether this rate schedule is designed to promote water conservation through inclining block or penalty pricing (true) or not (false). Ref: Oracle CC&B.',
    `consumption_unit_of_measure` STRING COMMENT 'Unit of measure for consumption used in this rate schedule (e.g., gallons, cubic feet, cubic meters, kiloliters, hundred cubic feet (CCF)). Ref: Oracle CC&B.. Valid values are `gallons|cubic_feet|cubic_meters|kiloliters|hundred_cubic_feet`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this rate schedule record. Record audit field. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was first created in the system. Record audit field. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate schedule (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `customer_class` STRING COMMENT 'Customer class or segment this rate schedule applies to (e.g., residential, commercial, industrial, irrigation, municipal, institutional). Classification of the tariff by customer segment. Ref: Oracle CC&B.. Valid values are `residential|commercial|industrial|irrigation|municipal|institutional`',
    `deprecated_flag` BOOLEAN COMMENT 'The deprecated flag value recorded for each billing rate schedule in the billing domain.',
    `drought_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a drought surcharge or emergency rate adjustment can be applied under this rate schedule (true) or not (false). Ref: Oracle CC&B.',
    `effective_date` DATE COMMENT 'The effective date associated with each billing rate schedule record in the billing domain.',
    `effective_end_date` DATE COMMENT 'Date when this rate schedule is no longer effective and should not be applied to new billing cycles. Nullable for open-ended tariffs. Effective-until date for the tariff. Ref: Oracle CC&B.',
    `effective_start_date` DATE COMMENT 'Date when this rate schedule becomes effective and can be applied to customer billing. Effective-from date for the tariff. Ref: Oracle CC&B.',
    `expiration_date` DATE COMMENT 'The expiration date associated with each billing rate schedule record in the billing domain.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the billing rate schedule record.',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction where this rate schedule applies (e.g., city, county, state, service territory name). Defines the geographic scope of the tariff. Ref: Oracle CC&B.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this rate schedule record. Record audit field. Ref: Oracle CC&B.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was last modified. Record audit field. Ref: Oracle CC&B.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum total charge amount per billing period under this rate schedule (cap). Nullable if no maximum applies. Ref: Oracle CC&B.',
    `meter_size_applicability` STRING COMMENT 'Meter size(s) or range this rate schedule applies to (e.g., 5/8 inch, 1 inch, 2 inch and above). Nullable if not meter-size-specific. Ref: Oracle CC&B.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum total charge amount per billing period under this rate schedule, regardless of consumption. Nullable if no minimum applies. Ref: Oracle CC&B.',
    `rate_schedule_name` STRING COMMENT 'Human-readable name of the rate schedule (e.g., Residential Tiered Water Rate, Commercial Flat Wastewater Rate). Identity label for the tariff. Ref: Oracle CC&B.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this rate schedule (e.g., temporary adjustments, pilot program details). Ref: Oracle CC&B.',
    `rate_structure_type` STRING COMMENT 'Type of rate structure used for billing calculations (e.g., flat, tiered/inclining block, seasonal, time-of-use, budget-based, uniform, declining block). Defines the pricing methodology. [ENUM-REF-CANDIDATE: flat|tiered|seasonal|time_of_use|budget_based|uniform|declining_block — 7 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `regulatory_approval_date` DATE COMMENT 'Date when the regulatory body (e.g., Public Utilities Commission) approved this rate schedule. Ref: Oracle CC&B.',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier for the regulatory approval (e.g., Public Utilities Commission (PUC) order number, resolution number) authorizing this rate schedule. Ref: Oracle CC&B.',
    `schedule_code` STRING COMMENT 'The schedule code value recorded for each billing rate schedule in the billing domain.',
    `schedule_name` STRING COMMENT 'The schedule name used to identify each billing rate schedule record in the billing domain.',
    `seasonal_indicator` BOOLEAN COMMENT 'Indicates whether this rate schedule has seasonal rate variations (true) or is uniform year-round (false). Ref: Oracle CC&B.',
    `service_class` STRING COMMENT 'The service class value recorded for each billing rate schedule in the billing domain.',
    `service_type` STRING COMMENT 'Type of utility service this rate schedule applies to. Classification of the tariff by service line. Ref: Oracle CC&B.. Valid values are `water|wastewater|stormwater|recycled_water|combined`',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each billing rate schedule in the billing domain.',
    `ssot_role` STRING COMMENT 'The ssot role value recorded for each billing rate schedule in the billing domain.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each billing rate schedule record in the billing domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each billing rate schedule record in the billing domain.',
    `volumetric_rate_usd` DECIMAL(18,2) COMMENT 'The volumetric rate usd value recorded for each billing rate schedule in the billing domain.',
    CONSTRAINT pk_rate_schedule PRIMARY KEY(`rate_schedule_id`)
) COMMENT 'Master definition of a utility rate schedule (tariff) governing how consumption and service charges are calculated for a customer class. Captures rate schedule code, name, effective date range, service type (water, wastewater, stormwater, recycled water), customer class (residential, commercial, industrial, irrigation, municipal), rate structure type (flat, tiered/inclining block, seasonal, time-of-use, budget-based), regulatory approval reference, and jurisdiction. Approved by the Public Utilities Commission. SSOT for all tariff definitions. [SSOT: Domain-specific view; canonical source is service.service_rate_schedule.] Consolidated: service.service_rate_schedule is SSOT; this table references it.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` (
    `rate_component_id` BIGINT COMMENT 'Unique identifier for the rate component. Primary key for the rate component entity. Ref: Oracle CC&B.',
    `rate_schedule_id` DECIMAL(18,2) COMMENT 'Reference to the parent rate schedule that contains this component. Links the component to its governing rate structure. Ref: Oracle CC&B.',
    `approval_authority` STRING COMMENT 'Name of the regulatory body or internal authority that approved this rate component. Examples: State Public Utilities Commission, City Council, Utility Board of Directors. Ref: Oracle CC&B.',
    `approval_date` DATE COMMENT 'Date when the rate component was approved by the governing regulatory authority or utility board. Required for regulatory compliance and audit trails. Ref: Oracle CC&B.',
    `bill_print_label` STRING COMMENT 'Customer-facing label text displayed on the bill for this component. Should be clear and understandable to customers. Examples: Monthly Service Charge, Water Usage - First 5 CCF, Stormwater Fee. Ref: Oracle CC&B.',
    `calculation_formula` STRING COMMENT 'Custom calculation expression for formula-based components. Contains the algorithmic logic used to compute the charge amount, referencing other rate components, usage data, or account attributes. Null for standard calculation methods. Ref: Oracle CC&B.',
    `calculation_method` STRING COMMENT 'Algorithm used to calculate the charge amount. Flat amount applies a fixed charge regardless of usage, per-unit multiplies usage by unit rate, tiered block applies different rates to usage ranges, percentage applies a rate to another charge, and formula uses a custom calculation expression. Ref: Oracle CC&B.. Valid values are `flat_amount|per_unit|tiered_block|percentage|formula`',
    `component_code` STRING COMMENT 'Business identifier code for the rate component used in billing systems and rate books. Examples: BASE_CHG, TIER1_VOL, DEMAND_CHG, STORMWATER_FEE. Ref: Oracle CC&B.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `component_name` STRING COMMENT 'Human-readable name of the rate component. Examples: Base Service Charge, First Tier Volumetric Charge, Peak Demand Charge, Stormwater Management Fee. Ref: Oracle CC&B.',
    `component_type` STRING COMMENT 'Classification of the rate component defining its billing purpose. Base charges are fixed monthly fees, volumetric charges are consumption-based, demand charges are based on peak usage, tier charges apply to usage blocks, surcharges are additional fees, taxes are regulatory levies, fees are service-specific charges, adjustments modify base amounts, and credits reduce charges. [ENUM-REF-CANDIDATE: base_charge|volumetric_charge|demand_charge|tier_charge|surcharge|tax|fee|adjustment|credit — 9 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `conservation_tier_flag` BOOLEAN COMMENT 'Indicates whether this component is part of a conservation-oriented inclining block rate structure designed to discourage excessive water use. True for higher-tier volumetric charges that increase with consumption. Ref: Oracle CC&B.',
    `cost_center` STRING COMMENT 'Cost center code for internal cost allocation and profitability analysis. Links revenue to the organizational unit or service line responsible for the charge. Ref: Oracle CC&B.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate component record was first created in the system. Used for audit trails and data lineage tracking. Ref: Oracle CC&B.',
    `rate_component_description` STRING COMMENT 'Detailed business description of the rate component, its purpose, and how it is applied. Provides context for billing staff, customer service representatives, and customers reviewing their bills. Ref: Oracle CC&B.',
    `effective_date` DATE COMMENT 'The effective date associated with each rate component record in the billing domain.',
    `effective_end_date` DATE COMMENT 'Date when this rate component ceases to be active. Null indicates the component is currently active with no planned end date. Used for rate schedule versioning and historical rate reconstruction. Ref: Oracle CC&B.',
    `effective_start_date` DATE COMMENT 'Date when this rate component becomes active and applicable to billing. Supports rate change management and regulatory compliance with rate case approval timelines. Ref: Oracle CC&B.',
    `expiration_date` DATE COMMENT 'The expiration date associated with each rate component record in the billing domain.',
    `flat_amount` DECIMAL(18,2) COMMENT 'Fixed charge amount for flat-rate components such as base service charges, connection fees, or fixed surcharges. Null for volumetric or percentage-based components. Ref: Oracle CC&B.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which revenue from this component is posted. Links billing transactions to the financial accounting system for revenue recognition and reporting. Ref: Oracle CC&B.. Valid values are `^[0-9]{4,10}$`',
    `is_prorated` BOOLEAN COMMENT 'Indicates whether the component should be prorated for partial billing periods. True if the charge should be adjusted proportionally when service starts or ends mid-cycle. False if the full charge applies regardless of billing period length. Ref: Oracle CC&B.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this component is subject to sales tax or other tax levies. True if the component amount should be included in the taxable base for tax calculation. False if exempt from taxation. Ref: Oracle CC&B.',
    `is_volumetric` BOOLEAN COMMENT 'Indicates whether the component is consumption-based (volumetric) or fixed. True for components that vary with usage (per-unit, tiered block). False for fixed charges (base charges, flat fees). Used to distinguish variable from fixed revenue components. Ref: Oracle CC&B.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate component record was last updated. Used for change tracking and audit compliance. Ref: Oracle CC&B.',
    `meter_size_applicability` STRING COMMENT 'Meter size or size range to which this component applies. Used for meter-size-based base charges. Examples: 5/8 inch, 1 inch, 2 inch, 3 inch and larger. Null if component applies to all meter sizes. Ref: Oracle CC&B.',
    `percentage_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied for percentage-based components such as taxes, surcharges, or adjustments. Expressed as a decimal (e.g., 0.0825 for 8.25% sales tax). Null for non-percentage components. Ref: Oracle CC&B.',
    `print_on_bill_flag` BOOLEAN COMMENT 'Indicates whether this component should be displayed as a separate line item on customer bills. True for components that require transparency and customer visibility. False for internal calculation components. Ref: Oracle CC&B.',
    `rate_case_number` STRING COMMENT 'Regulatory rate case docket number or internal rate change request identifier associated with this component. Links the component to the formal rate approval process. Ref: Oracle CC&B.',
    `rate_component_status` STRING COMMENT 'Current lifecycle status of the rate component. Active components are in use for billing. Inactive components are temporarily disabled. Pending approval components await regulatory approval. Superseded components have been replaced by newer versions. Retired components are no longer used and retained for historical reference only. Ref: Oracle CC&B.. Valid values are `active|inactive|pending_approval|superseded|retired`',
    `rate_usd` DECIMAL(18,2) COMMENT 'The rate usd value recorded for each rate component in the billing domain.',
    `regulatory_reporting_category` STRING COMMENT 'Classification code for regulatory financial reporting and rate case filings. Maps the component to standardized reporting categories required by state public utilities commissions. Ref: Oracle CC&B.',
    `revenue_class` STRING COMMENT 'Classification of revenue type for financial reporting and cost allocation. Water revenue is from potable water service, wastewater from sewer service, stormwater from drainage fees, reclaimed from recycled water, bulk from wholesale sales, and other for miscellaneous charges. Ref: Oracle CC&B.. Valid values are `water|wastewater|stormwater|reclaimed|bulk|other`',
    `seasonal_indicator` STRING COMMENT 'Seasonal applicability of the rate component. Supports seasonal rate structures for water conservation. Year-round applies all year, summer/winter/spring/fall apply to specific seasons, peak/off-peak apply to demand periods. [ENUM-REF-CANDIDATE: year_round|summer|winter|spring|fall|peak|off_peak — 7 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `sequence_number` STRING COMMENT 'Ordering sequence for component calculation and display within the rate schedule. Lower numbers are calculated and displayed first. Critical for components with dependencies (e.g., base charge calculated before percentage surcharge). Ref: Oracle CC&B.',
    `service_type` STRING COMMENT 'Customer service class to which this component applies. Supports differential pricing by customer segment. Residential serves households, commercial serves businesses, industrial serves manufacturing, institutional serves government and non-profits, agricultural serves farms, and wholesale serves other utilities. Ref: Oracle CC&B.. Valid values are `residential|commercial|industrial|institutional|agricultural|wholesale`',
    `tier_high_threshold` DECIMAL(18,2) COMMENT 'Upper bound of the usage quantity range for tiered block rate components. Defines the maximum consumption level (inclusive) to which this tier rate applies. Measured in the components unit of measure. Null indicates no upper limit (open-ended tier). Null for non-tiered components. Ref: Oracle CC&B.',
    `tier_low_threshold` DECIMAL(18,2) COMMENT 'Lower bound of the usage quantity range for tiered block rate components. Defines the minimum consumption level (inclusive) to which this tier rate applies. Measured in the components unit of measure. Null for non-tiered components. Ref: Oracle CC&B.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for volumetric or demand-based components. CCF (hundred cubic feet) is the standard water billing unit in North America. Gallons, kgal (thousand gallons), mgal (million gallons), and cubic meters are alternative volume units. Each applies to count-based charges. kWh and therm apply to energy-related charges. NA indicates non-volumetric components like flat fees. [ENUM-REF-CANDIDATE: CCF|gallon|kgal|mgal|cubic_meter|each|kWh|therm|NA — 9 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate applied per unit of measure for volumetric or demand-based components. For per-unit calculation methods, this is the price per CCF, gallon, or other unit. For tiered blocks, this is the rate for the specific tier. Null for flat amount components. Ref: Oracle CC&B.',
    CONSTRAINT pk_rate_component PRIMARY KEY(`rate_component_id`)
) COMMENT 'Individual pricing component within a rate schedule defining a specific charge element such as a commodity charge tier, base/fixed service charge, demand charge, surcharge, or tax. Captures component type, calculation algorithm (flat amount, per-unit, tiered block), unit of measure (CCF, gallons, kW), tier thresholds (low/high quantity bounds), unit rate, effective date range, and whether the component is volumetric or fixed. Supports complex inclining block rate structures common in water conservation pricing.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the billing adjustment record. Primary key. Ref: Oracle CC&B.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Adjustments must link to customer accounts for customer service inquiries, adjustment history tracking, and audit trails. Customer service representatives need to view all adjustments applied to a cus. Ref: Oracle CC&B.',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice being adjusted, if applicable. Null for account-level adjustments not tied to a specific invoice. Ref: Oracle CC&B.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: adjustment already has invoice_id linking to the invoice header, but adjustments in water utility billing are frequently applied at the line-item level (e.g., correcting a specific volumetric charge t',
    `original_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment record being reversed, if this is a reversal entry. Null if this is not a reversal. Ref: Oracle CC&B.',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Adjustments can be applied to payment plan balances (e.g., reducing the enrolled balance due to a billing error correction, or adjusting installment amounts). Each adjustment that affects a payment pl. Ref: Oracle CC&B.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Billing adjustments (leak allowances, rate corrections) apply to a specific service agreement. Customers with multiple service agreements require service-agreement-level adjustment tracking for leak a',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Leak adjustments (leak_allowance_flag) require service line inspection records as justification, high-bill adjustments reference service line condition and age, and LCRR compliance adjustments tie to ',
    `sewer_service_connection_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_service_connection. Business justification: Wastewater billing adjustments (e.g., SSO-related credits, sewer lateral leak allowances) must reference the specific sewer connection. Regulatory audit trails and customer dispute resolution for wast',
    `adjustment_date` DATE COMMENT 'The adjustment date associated with each adjustment record in the billing domain.',
    `adjustment_number` STRING COMMENT 'Externally visible unique adjustment reference number used for customer communication and audit trails. Ref: Oracle CC&B.. Valid values are `^ADJ-[0-9]{8,12}$`',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment: pending (awaiting approval), approved (authorized but not yet applied), rejected (denied), applied (posted to account), reversed (undone), cancelled (voided before application). Ref: Oracle CC&B.. Valid values are `pending|approved|rejected|applied|reversed|cancelled`',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment indicating the nature of the correction: credit (reduces balance), debit (increases balance), write-off (uncollectible), leak_adjustment (leak allowance), rate_correction (tariff error), estimated_to_actual (true-up from estimated to actual meter reading), courtesy_credit (goodwill), penalty_reversal (late fee removal). [ENUM-REF-CANDIDATE: credit|debit|write-off|leak_adjustment|rate_correction|estimated_to_actual|courtesy_credit|penalty_reversal — 8 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the adjustment in the billing currency. Positive values represent credits (reducing customer balance), negative values represent debits (increasing customer balance). Ref: Oracle CC&B.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each adjustment in the billing domain.',
    `applied_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was actually posted to the customer account and reflected in the account balance. Null if not yet applied. Ref: Oracle CC&B.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether supervisory approval is required for this adjustment based on amount thresholds or adjustment type. True if approval is required, False if auto-approved.',
    `approval_status` STRING COMMENT 'The approval status value recorded for each adjustment in the billing domain.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which supervisory approval is required for this adjustment type. Null if no threshold applies.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was approved by the supervisor. Null if not yet approved.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period to which this adjustment applies. Used for period-specific corrections and true-ups. Ref: Oracle CC&B.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period to which this adjustment applies. Used for period-specific corrections and true-ups. Ref: Oracle CC&B.',
    `charge_category` STRING COMMENT 'The billing charge category being adjusted: consumption (usage-based charges), base_charge (fixed monthly fee), connection_fee (new service fees), late_fee (delinquency charges), penalty (violation fines), surcharge (special assessments), tax (sales or utility tax), other (miscellaneous). [ENUM-REF-CANDIDATE: consumption|base_charge|connection_fee|late_fee|penalty|surcharge|tax|other — 8 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `consumption_unit_of_measure` STRING COMMENT 'Unit of measure for the consumption volume adjusted: gallons, cubic_meters (m³), cubic_feet (ft³), liters, ccf (hundred cubic feet), kgal (thousand gallons). Ref: Oracle CC&B.. Valid values are `gallons|cubic_meters|cubic_feet|liters|ccf|kgal`',
    `consumption_volume_adjusted` DECIMAL(18,2) COMMENT 'The volume of water or wastewater consumption being adjusted, measured in the utilitys standard unit (typically gallons or cubic meters). Null if adjustment is not consumption-related. Ref: Oracle CC&B.',
    `cost_center_code` STRING COMMENT 'Cost center or department code responsible for this adjustment, used for internal cost allocation and management reporting. Ref: Oracle CC&B.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment record was first created in the system. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the adjustment amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified of this adjustment via bill message, email, or letter. True if notification sent, False otherwise. Ref: Oracle CC&B.',
    `dispute_reference_number` STRING COMMENT 'Reference number of the customer billing dispute or complaint that triggered this adjustment. Null if not dispute-related. Ref: Oracle CC&B.. Valid values are `^DISP-[0-9]{6,10}$`',
    `effective_date` DATE COMMENT 'The business date on which the adjustment becomes effective and is applied to the customer account balance. May differ from creation or approval dates for backdated corrections. Ref: Oracle CC&B.',
    `external_reference_number` STRING COMMENT 'External reference number from third-party systems (e.g., payment processor, collection agency, regulatory agency) related to this adjustment. Null if no external reference. Ref: Oracle CC&B.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this adjustment is posted for financial reporting and reconciliation purposes. Ref: Oracle CC&B.. Valid values are `^[0-9]{4,10}$`',
    `is_reversal` BOOLEAN COMMENT 'Boolean flag indicating whether the is reversal condition applies to the adjustment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment record was last updated or modified. Ref: Oracle CC&B.',
    `leak_allowance_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is a leak allowance credit granted to the customer for documented plumbing leaks. True if leak allowance, False otherwise. Ref: Oracle CC&B.',
    `leak_verification_date` DATE COMMENT 'Date when the plumbing leak was verified by utility staff or licensed plumber, supporting the leak allowance adjustment. Null if not a leak adjustment. Ref: Oracle CC&B.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the adjustment for internal use, audit trails, and customer service reference. Ref: Oracle CC&B.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when customer notification of the adjustment was sent. Null if notification not yet sent. Ref: Oracle CC&B.',
    `rate_case_reference` STRING COMMENT 'Reference number of the regulatory rate case or tariff filing that mandated this adjustment. Null if not rate-case-related. Ref: Oracle CC&B.. Valid values are `^RC-[0-9]{4}-[0-9]{3,6}$`',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific business reason for the adjustment (e.g., BILLING_ERROR, METER_MALFUNCTION, LEAK_ALLOWANCE, CUSTOMER_DISPUTE, RATE_CHANGE, GOODWILL, REGULATORY_COMPLIANCE). Maps to internal reason code table. Ref: Oracle CC&B.. Valid values are `^[A-Z0-9]{2,10}$`',
    `reason_description` STRING COMMENT 'Detailed free-text explanation of the reason for the adjustment, providing context for audit and customer service purposes. Ref: Oracle CC&B.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this adjustment was made to comply with regulatory requirements or rate case orders. True if regulatory-driven, False otherwise. Ref: Oracle CC&B.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is a reversal of a previous adjustment. True if this is a reversal entry, False otherwise. Ref: Oracle CC&B.',
    `reversal_reason` STRING COMMENT 'Free-text explanation of why the original adjustment was reversed. Null if this is not a reversal. Ref: Oracle CC&B.',
    `service_type` STRING COMMENT 'The type of utility service to which this adjustment applies: water (potable water supply), wastewater (sewage collection and treatment), stormwater (drainage fees), reclaimed_water (recycled water), bulk_water (wholesale water sales), other (miscellaneous charges). Ref: Oracle CC&B.. Valid values are `water|wastewater|stormwater|reclaimed_water|bulk_water|other`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is exempt from sales tax or utility tax. True if tax-exempt, False if taxable. Ref: Oracle CC&B.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each adjustment record in the billing domain.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Financial adjustment applied to a customer billing account to correct billing errors, apply credits, process leak allowances, issue courtesy credits, or reverse charges. Captures adjustment type (credit, debit, write-off, leak adjustment, rate correction, estimated-to-actual true-up), adjustment reason code, amount, approval status, approving supervisor, reference invoice, and effective date. Supports regulatory requirements for documented billing corrections and customer dispute resolution.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan arrangement. Primary key. Ref: Oracle CC&B.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer account enrolled in this payment plan. Ref: Oracle CC&B.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Payment plans in water utilities are negotiated for a specific delinquent service agreement. LIHEAP and low-income assistance payment plans are tracked at service-agreement level for regulatory report',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan was approved by the utility, marking the transition from pending to active status. Ref: Oracle CC&B.',
    `broken_date` DATE COMMENT 'Date when the payment plan was marked as broken due to missed payment or violation of terms. Nullable if plan has never been broken. Ref: Oracle CC&B.',
    `broken_reason` STRING COMMENT 'Reason the payment plan was marked as broken: missed installment (customer failed to pay on time), late payment (payment received after grace period), new charges unpaid (customer failed to pay current charges while on plan), customer request (customer asked to cancel), or administrative (utility-initiated termination). Ref: Oracle CC&B.. Valid values are `missed_installment|late_payment|new_charges_unpaid|customer_request|administrative`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the payment plan was cancelled, capturing business context for audit and reporting purposes. Ref: Oracle CC&B.',
    `cancelled_date` DATE COMMENT 'Date when the payment plan was cancelled by the utility or customer before completion. Nullable if plan was not cancelled. Ref: Oracle CC&B.',
    `completed_date` DATE COMMENT 'Date when the payment plan was successfully completed with all installments paid in full. Nullable if plan is not yet completed. Ref: Oracle CC&B.',
    `completed_installments` STRING COMMENT 'Number of installment payments successfully made by the customer to date. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan record was first created in the system. Ref: Oracle CC&B.',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'Remaining balance amount still owed under the payment plan after applying all installment payments to date. Ref: Oracle CC&B.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial down payment amount required to establish the payment plan, paid at enrollment. Nullable if no down payment was required. Ref: Oracle CC&B.',
    `down_payment_received_date` DECIMAL(18,2) COMMENT 'Date when the down payment was received and the payment plan was activated. Nullable if no down payment was required. Ref: Oracle CC&B.',
    `end_date` DATE COMMENT 'The end date associated with each payment plan record in the billing domain.',
    `enrolled_balance_amount` DECIMAL(18,2) COMMENT 'Total delinquent balance amount enrolled in the payment plan at the time of plan establishment. Represents the arrears being repaid through installments. Ref: Oracle CC&B.',
    `grace_period_days` STRING COMMENT 'Number of days after the installment due date during which a late payment is accepted without breaking the plan. Ref: Oracle CC&B.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Fixed amount the customer is required to pay per installment period to satisfy the payment plan terms. Ref: Oracle CC&B.',
    `installment_amount_usd` DECIMAL(18,2) COMMENT 'The installment amount usd value recorded for each payment plan in the billing domain.',
    `installment_frequency` STRING COMMENT 'Frequency at which installment payments are due: weekly, biweekly, monthly, or quarterly. Ref: Oracle CC&B.. Valid values are `weekly|biweekly|monthly|quarterly`',
    `liheap_eligible` BOOLEAN COMMENT 'Indicates whether the customer on this payment plan is eligible for LIHEAP or similar low-income energy assistance coordination. True if eligible; false otherwise. Ref: Oracle CC&B.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan record was last modified, capturing any updates to plan terms, status, or attributes. Ref: Oracle CC&B.',
    `next_installment_due_date` DATE COMMENT 'Date when the next installment payment is due from the customer. Ref: Oracle CC&B.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special terms, customer circumstances, or administrative remarks related to the payment plan. Ref: Oracle CC&B.',
    `number_of_installments` STRING COMMENT 'The number of installments value recorded for each payment plan in the billing domain.',
    `plan_end_date` DATE COMMENT 'Scheduled date when the payment plan is expected to be completed if all installments are paid on time. Nullable for open-ended plans. Ref: Oracle CC&B.',
    `plan_number` STRING COMMENT 'Externally visible unique business identifier for the payment plan, formatted as PP-XXXXXXXX. Ref: Oracle CC&B.. Valid values are `^PP-[0-9]{8}$`',
    `plan_start_date` DATE COMMENT 'Date when the payment plan becomes effective and the first installment is due. Ref: Oracle CC&B.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the payment plan: active (customer is making payments on schedule), broken (customer missed payment and violated terms), completed (all installments paid), cancelled (plan terminated by utility or customer), suspended (temporarily paused), or pending approval (awaiting credit review). Ref: Oracle CC&B.. Valid values are `active|broken|completed|cancelled|suspended|pending_approval`',
    `plan_type` STRING COMMENT 'Classification of the payment plan arrangement: budget billing (level monthly payments), deferred payment agreement (short-term installment), low-income assistance (subsidized plan), arrearage management (long-term debt forgiveness plan), seasonal payment (adjusted for seasonal usage), or extended payment (custom extended terms). Ref: Oracle CC&B.. Valid values are `budget_billing|deferred_payment_agreement|low_income_assistance|arrearage_management|seasonal_payment|extended_payment`',
    `requires_current_charges_paid` DECIMAL(18,2) COMMENT 'Indicates whether the customer must pay all new current charges in addition to installment payments to remain in good standing on the plan. True if current charges must be paid; false if only installments are required. Ref: Oracle CC&B.',
    `start_date` DATE COMMENT 'The start date associated with each payment plan record in the billing domain.',
    `total_amount_usd` DECIMAL(18,2) COMMENT 'The total amount usd value recorded for each payment plan in the billing domain.',
    `total_installments` STRING COMMENT 'Total number of scheduled installment payments required to complete the payment plan. Ref: Oracle CC&B.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each payment plan record in the billing domain.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Structured payment arrangement for customers, covering delinquent balance repayment plans, budget billing (levelized payment) programs, and utility assistance installment plans. For deferred payment agreements: captures enrolled delinquent balance, installment amount/frequency, plan status, and break conditions. For budget billing: captures monthly budget amount, true-up month, cumulative actual vs billed variance, and annual reconciliation. Supports LIHEAP coordination, low-income assistance plans, and service disconnection avoidance. SSOT for all structured payment arrangements on a billing account.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` (
    `collection_notice_id` BIGINT COMMENT 'Primary key for collection_notice. Ref: Oracle CC&B.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Collection notices are issued to delinquent billing accounts as part of the collections workflow. Each notice must reference the account it was issued to. This is a missing critical FK - collection_no. Ref: Oracle CC&B.',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Collection notices need to reference any active payment plan on the account to determine appropriate collection actions. Accounts with active payment plans in good standing should not receive aggressi. Ref: Oracle CC&B.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Shutoff notices must be checked against premise life-support equipment flags before execution. Regulatory requirement in water utilities: premise_id on collection_notice enables automated life-support',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory-compliant shutoff notice issuance: collection notices must comply with specific regulatory requirements governing shutoff protections (low-income rules, winter moratoriums, medical holds). ',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Shutoff and collection notices are issued per service agreement, not just per account. A customer with water and sewer service agreements may receive a shutoff notice on one only. Regulatory shutoff p',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Collection notices trigger physical shutoff orders executed at the service line. Field crews and SCADA dispatch require the specific service_line_id to locate the curb stop or meter for disconnection.',
    `amount_due` DECIMAL(18,2) COMMENT 'Total amount due on notice. Ref: Oracle CC&B.',
    `amount_due_usd` DECIMAL(18,2) COMMENT 'The amount due usd value recorded for each collection notice in the billing domain.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each collection notice in the billing domain.',
    `collection_notice_category` STRING COMMENT 'The collection notice category value recorded for each collection notice in the billing domain.',
    `classification` STRING COMMENT 'The classification value recorded for each collection notice in the billing domain.',
    `collection_notice_code` STRING COMMENT 'The collection notice code value recorded for each collection notice in the billing domain.',
    `collection_notice_number` STRING COMMENT 'The collection notice number value recorded for each collection notice in the billing domain.',
    `collection_notice_status` STRING COMMENT 'Lifecycle status of the record. Ref: Oracle CC&B.',
    `collection_notice_type` STRING COMMENT 'The collection notice type value recorded for each collection notice in the billing domain.',
    `comments` STRING COMMENT 'The comments value recorded for each collection notice in the billing domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each collection notice in the billing domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'The currency code value recorded for each collection notice in the billing domain.',
    `current_charges` DECIMAL(18,2) COMMENT 'Current charges portion. Ref: Oracle CC&B.',
    `customer_response_date` TIMESTAMP COMMENT 'Date customer responded to the notice. Ref: Oracle CC&B.',
    `customer_response_type` STRING COMMENT 'Payment, payment plan, dispute, no response. Ref: Oracle CC&B.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each collection notice in the billing domain.',
    `days_delinquent` STRING COMMENT 'Number of days the account has been delinquent at time of notice generation. Ref: Oracle CC&B.',
    `days_past_due` STRING COMMENT 'Number of days past due. Ref: Oracle CC&B.',
    `delinquency_days` STRING COMMENT 'The delinquency days value recorded for each collection notice in the billing domain.',
    `delivery_address` STRING COMMENT 'Address notice was delivered to. Ref: Oracle CC&B.',
    `delivery_confirmed` BOOLEAN COMMENT 'Whether delivery was confirmed. Ref: Oracle CC&B.',
    `delivery_date` DATE COMMENT 'Date notice was delivered. Ref: Oracle CC&B.',
    `delivery_method` STRING COMMENT 'Delivery method (mail, email, door_hanger, phone). Ref: Oracle CC&B.',
    `delivery_status` STRING COMMENT 'The delivery status value recorded for each collection notice in the billing domain.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The delivery timestamp associated with each collection notice record in the billing domain.',
    `collection_notice_description` STRING COMMENT 'The collection notice description value recorded for each collection notice in the billing domain.',
    `disconnection_date` TIMESTAMP COMMENT 'Scheduled disconnection date if payment is not received. Ref: Oracle CC&B.',
    `disconnection_scheduled_date` TIMESTAMP COMMENT 'The disconnection scheduled date associated with each collection notice record in the billing domain.',
    `disconnection_scheduled_flag` BOOLEAN COMMENT 'The disconnection scheduled flag value recorded for each collection notice in the billing domain.',
    `due_date` TIMESTAMP COMMENT 'Payment due date on notice. Ref: Oracle CC&B.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each collection notice record in the billing domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Oracle CC&B.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Oracle CC&B.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each collection notice record in the billing domain.',
    `escalation_level` STRING COMMENT 'Escalation level: 1=first notice, 2=final, 3=shutoff. Ref: Oracle CC&B.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each collection notice record in the billing domain.',
    `hold_reason` STRING COMMENT 'Reason for shutoff hold: medical, winter moratorium, etc. Ref: Oracle CC&B.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: Oracle CC&B.',
    `is_low_income_protected` BOOLEAN COMMENT 'Indicates whether the account is protected from disconnection under low-income assistance rules. Ref: Oracle CC&B.',
    `is_medical_hold` BOOLEAN COMMENT 'Flag indicating a medical hold prevents disconnection. Ref: Oracle CC&B.',
    `is_shutoff_hold` BOOLEAN COMMENT 'Whether a shutoff hold is in place. Ref: Oracle CC&B.',
    `is_shutoff_protected` BOOLEAN COMMENT 'Whether account is protected from shutoff (medical, weather). Ref: Oracle CC&B.',
    `is_winter_moratorium` BOOLEAN COMMENT 'Flag indicating a winter moratorium prevents disconnection. Ref: Oracle CC&B.',
    `issue_date` TIMESTAMP COMMENT 'Date notice was issued. Ref: Oracle CC&B.',
    `issued_date` TIMESTAMP COMMENT 'The issued date associated with each collection notice record in the billing domain.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Late fee assessed with this notice. Ref: Oracle CC&B.',
    `late_fee_usd` DECIMAL(18,2) COMMENT 'The late fee usd value recorded for each collection notice in the billing domain.',
    `minimum_payment_amount` DECIMAL(18,2) COMMENT 'Minimum payment to avoid shutoff. Ref: Oracle CC&B.',
    `minimum_payment_required` DECIMAL(18,2) COMMENT 'Minimum payment required to avoid disconnection. Ref: Oracle CC&B.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each collection notice record in the billing domain.',
    `collection_notice_name` STRING COMMENT 'The collection notice name used to identify each collection notice record in the billing domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: Oracle CC&B.',
    `notice_date` TIMESTAMP COMMENT 'The notice date associated with each collection notice record in the billing domain.',
    `notice_number` STRING COMMENT 'Unique collection notice number. Ref: Oracle CC&B.',
    `notice_status` STRING COMMENT 'Status (generated, sent, acknowledged, resolved, escalated). Ref: Oracle CC&B.',
    `notice_type` STRING COMMENT 'Type of notice (reminder, warning, final, shutoff). Ref: Oracle CC&B.',
    `past_due_amount` DECIMAL(18,2) COMMENT 'Past due portion of amount. Ref: Oracle CC&B.',
    `payment_received_date` TIMESTAMP COMMENT 'The payment received date associated with each collection notice record in the billing domain.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each collection notice in the billing domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each collection notice in the billing domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each collection notice in the billing domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Oracle CC&B.',
    `record_status` STRING COMMENT 'The record status value recorded for each collection notice in the billing domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each collection notice in the billing domain.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Whether notice meets regulatory notice requirements. Ref: Oracle CC&B.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each collection notice in the billing domain.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each collection notice record in the billing domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each collection notice in the billing domain.',
    `resolution_type` STRING COMMENT 'Paid, Payment Plan, Assistance, Cancelled, Shutoff. Ref: Oracle CC&B.',
    `resolved_date` TIMESTAMP COMMENT 'Date notice was resolved. Ref: Oracle CC&B.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each collection notice in the billing domain.',
    `response_date` TIMESTAMP COMMENT 'Date the customer responded to the notice. Ref: Oracle CC&B.',
    `response_deadline_date` TIMESTAMP COMMENT 'Deadline for customer response. Ref: Oracle CC&B.',
    `response_received` BOOLEAN COMMENT 'Flag indicating a customer response was received. Ref: Oracle CC&B.',
    `response_received_date` DATE COMMENT 'Date customer responded. Ref: Oracle CC&B.',
    `shutoff_date` DATE COMMENT 'Scheduled service shutoff date if applicable. Ref: Oracle CC&B.',
    `shutoff_scheduled_flag` BOOLEAN COMMENT 'The shutoff scheduled flag value recorded for each collection notice in the billing domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each collection notice record in the billing domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each collection notice in the billing domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: Oracle CC&B.',
    CONSTRAINT pk_collection_notice PRIMARY KEY(`collection_notice_id`)
) COMMENT 'Formal delinquency notification issued to a customer account as part of the collections workflow, including past-due notices, shut-off warnings, and final disconnection notices. Captures notice type (first notice, final notice, shut-off warning, lien notice), issue date, past-due amount at time of notice, minimum payment required to avoid disconnection, response deadline, delivery method (mail, email, door hanger), and notice status. Tracks the collections escalation ladder per utility tariff and state regulatory requirements.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_component_id` FOREIGN KEY (`rate_component_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`rate_component`(`rate_component_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_invoice_id` FOREIGN KEY (`payment_invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_reversed_by_payment_id` FOREIGN KEY (`reversed_by_payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_superseded_by_rate_schedule_billing_rate_schedule_id` FOREIGN KEY (`superseded_by_rate_schedule_billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_original_adjustment_id` FOREIGN KEY (`original_adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_water_utilities_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `ccr_included` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `conservation_message` SET TAGS ('dbx_business_glossary_term' = 'Conservation Message Text');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'postal_mail|email|customer_portal|sms');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `disconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Service Disconnection Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `generation_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generation Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `generation_method` SET TAGS ('dbx_value_regex' = 'automated_cycle|manual|off_cycle|estimated|corrected');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'regular_cycle|final|estimated|corrected|off_cycle|adjustment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Invoice Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `is_final` SET TAGS ('dbx_business_glossary_term' = 'Is Final Invoice Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `previous_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `print_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Print Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `stormwater_area` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Impervious Area');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `stormwater_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Management Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `wastewater_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Service Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `wastewater_volume` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Volume');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `water_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Water Service Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `water_consumption_uom` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `water_consumption_uom` SET TAGS ('dbx_value_regex' = 'gallons|cubic_meters|ccf|kgal');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `water_consumption_volume` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption Volume');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `sewer_service_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Service Connection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_determinant` SET TAGS ('dbx_business_glossary_term' = 'Billing Determinant');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `charge_type_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Type Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|AUD|MXN');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Is Disputed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|CANCELLED|ADJUSTED|DISPUTED|WRITTEN_OFF|REVERSED');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `print_sequence` SET TAGS ('dbx_business_glossary_term' = 'Print Sequence');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `proration_factor` SET TAGS ('dbx_business_glossary_term' = 'Proration Factor');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_class` SET TAGS ('dbx_value_regex' = 'OPERATING_REVENUE|NON_OPERATING_REVENUE|CAPITAL_CONTRIBUTION|DEFERRED_REVENUE|OTHER');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `service_days` SET TAGS ('dbx_business_glossary_term' = 'Service Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `total_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Line Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `reversed_by_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed By Payment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `is_auto_pay` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Payment Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `lockbox_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'check|ach|credit_card|debit_card|cash|money_order');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `nsf_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `nsf_indicator` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|cleared|reversed|cancelled|failed');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'regular|advance|deposit|refund|adjustment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `processor_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `adjustment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_sequence` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Sequence');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_source` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Source');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'applied|pending|reversed|cancelled|frozen|adjusted');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `ar_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Reconciliation Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `ar_reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|exception|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `balance_bucket_code` SET TAGS ('dbx_business_glossary_term' = 'Balance Bucket Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|AUD|MXN');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `dispute_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dispute Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `is_overpayment` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `is_prepayment` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `overpayment_handling` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Handling Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `overpayment_handling` SET TAGS ('dbx_value_regex' = 'refund|credit|transfer|hold');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_ssot_canonical_ref' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_resolution' = 'CREATE_VIEW');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_activation|delinquent');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural|institutional');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_30_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket - 30 Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_60_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket - 60 Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_90_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket - 90 Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_current` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket - Current');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_over_90_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket - Over 90 Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `autopay_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enrollment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `autopay_method` SET TAGS ('dbx_business_glossary_term' = 'Autopay Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `autopay_method` SET TAGS ('dbx_value_regex' = 'bank_account|credit_card|debit_card|not_enrolled');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `balance_forward` SET TAGS ('dbx_business_glossary_term' = 'Balance Forward Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_monthly|quarterly|annual');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `budget_billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `budget_billing_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Enrollment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'current|reminder_sent|final_notice|disconnection_pending|legal_action|write_off');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Limit');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Credit Rating');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|no_rating');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `current_charges` SET TAGS ('dbx_business_glossary_term' = 'Current Period Charges');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `customer_account_ref_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `customer_account_ref_code` SET TAGS ('dbx_business_role' = 'customer_account_reference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `deposit_on_file` SET TAGS ('dbx_business_glossary_term' = 'Customer Deposit on File');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `disconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Service Disconnection Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `final_bill_issued` SET TAGS ('dbx_business_glossary_term' = 'Final Bill Issued Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `last_bill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bill Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `late_fee_assessed` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Assessed');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `next_bill_date` SET TAGS ('dbx_business_glossary_term' = 'Next Bill Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `paperless_billing` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Preference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `past_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Past Due Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `payment_plan_active` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `payment_plan_balance` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Balance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|due_on_receipt|installment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `reconnection_fee` SET TAGS ('dbx_business_glossary_term' = 'Service Reconnection Fee');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'customer.customer_account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_certificate` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_certificate` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{0,30}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` SET TAGS ('dbx_subdomain' = 'rate_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `superseded_by_rate_schedule_billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `base_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|annual');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `billing_rate_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `billing_rate_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `conservation_rate_indicator` SET TAGS ('dbx_business_glossary_term' = 'Conservation Rate Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `consumption_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Consumption Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `consumption_unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|kiloliters|hundred_cubic_feet');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|irrigation|municipal|institutional');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `drought_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Drought Surcharge Applicable');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `meter_size_applicability` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Applicability');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `seasonal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'water|wastewater|stormwater|recycled_water|combined');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'service.service_rate_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` SET TAGS ('dbx_subdomain' = 'rate_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `bill_print_label` SET TAGS ('dbx_business_glossary_term' = 'Bill Print Label');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat_amount|per_unit|tiered_block|percentage|formula');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `conservation_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Conservation Tier Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_component_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `flat_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `is_volumetric` SET TAGS ('dbx_business_glossary_term' = 'Is Volumetric Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `meter_size_applicability` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Applicability');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `percentage_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `print_on_bill_flag` SET TAGS ('dbx_business_glossary_term' = 'Print on Bill Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_case_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_component_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_component_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|superseded|retired');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `revenue_class` SET TAGS ('dbx_value_regex' = 'water|wastewater|stormwater|reclaimed|bulk|other');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `seasonal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|institutional|agricultural|wholesale');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `tier_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier High Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `tier_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier Low Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Adjustment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `sewer_service_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Service Connection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{8,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|applied|reversed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Applied Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `consumption_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Consumption Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `consumption_unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|cubic_meters|cubic_feet|liters|ccf|kgal');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `consumption_volume_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Consumption Volume Adjusted');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `dispute_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `dispute_reference_number` SET TAGS ('dbx_value_regex' = '^DISP-[0-9]{6,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `leak_allowance_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Allowance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `leak_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Leak Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `rate_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Reference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `rate_case_reference` SET TAGS ('dbx_value_regex' = '^RC-[0-9]{4}-[0-9]{3,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'water|wastewater|stormwater|reclaimed_water|bulk_water|other');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `broken_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Broken Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `broken_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Broken Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `broken_reason` SET TAGS ('dbx_value_regex' = 'missed_installment|late_payment|new_charges_unpaid|customer_request|administrative');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Cancellation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Cancelled Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `completed_installments` SET TAGS ('dbx_business_glossary_term' = 'Completed Installments Count');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `down_payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `enrolled_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Installment Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Payment Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `liheap_eligible` SET TAGS ('dbx_business_glossary_term' = 'Low Income Home Energy Assistance Program (LIHEAP) Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `next_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Installment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^PP-[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|broken|completed|cancelled|suspended|pending_approval');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'budget_billing|deferred_payment_agreement|low_income_assistance|arrearage_management|seasonal_payment|extended_payment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `requires_current_charges_paid` SET TAGS ('dbx_business_glossary_term' = 'Requires Current Charges Paid Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `total_installments` SET TAGS ('dbx_business_glossary_term' = 'Total Number of Installments');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `collection_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Notice Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `amount_due_usd` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `current_charges` SET TAGS ('dbx_business_glossary_term' = 'Current Charges');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `days_delinquent` SET TAGS ('dbx_business_glossary_term' = 'Days Delinquent');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `delivery_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmed');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `disconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `is_low_income_protected` SET TAGS ('dbx_business_glossary_term' = 'Low Income Protected');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `is_medical_hold` SET TAGS ('dbx_business_glossary_term' = 'Is Medical Hold');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `is_medical_hold` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `is_medical_hold` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `is_winter_moratorium` SET TAGS ('dbx_business_glossary_term' = 'Is Winter Moratorium');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `minimum_payment_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Required');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Resolved Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `response_received` SET TAGS ('dbx_business_glossary_term' = 'Response Received');
