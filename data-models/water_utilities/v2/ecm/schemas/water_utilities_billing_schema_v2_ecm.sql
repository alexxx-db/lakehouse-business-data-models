-- Schema for Domain: billing | Business: Water_Utilities | Version: v2_ecm
-- Generated on: 2026-07-10 18:43:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`billing` COMMENT 'Revenue cycle management including consumption-based billing, rate structures, invoice generation, payment processing, payment plans, collections, delinquency management, billing adjustments, dispute resolution, and revenue recognition. SSOT for all financial transactions with customers including water, wastewater, stormwater, and other utility charges.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system-generated identifier for the invoice record. Primary key for the invoice entity.',
    `billing_cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: Invoice belongs to a billing cycle; adding billing_cycle_id FK eliminates the redundant billing_cycle_code column and enables proper cycle lookup.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Capital projects generate invoices for construction work, design services, and developer-funded infrastructure. Essential for project cost recovery billing and capital accounting. Water utilities rout',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Invoices must link directly to customer accounts for customer service operations, billing inquiries, dispute resolution, and account history reporting. Customer service representatives need direct acc',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Invoices are issued against specific funds (water enterprise fund, wastewater fund, stormwater fund). Fund accounting and GASB reporting require tracking invoice-to-fund attribution for revenue recogn',
    `point_id` BIGINT COMMENT 'Reference to the physical service point (meter location) associated with this invoice. May be null for account-level charges not tied to a specific service point.',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: LCRR compliance billing requires direct service line material reference on invoices for lead service line notices, leak adjustment workflows need service line condition metadata, and high-bill investi',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Water quality events (boil water advisories, contamination, taste/odor issues) trigger billing adjustments and credits. Utilities must link invoices to the specific sample event that justified the bil',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Invoices must reference source treatment facility for cost-of-service allocation, rate case analysis, and facility-specific revenue tracking. Essential for regulatory rate design and capital cost reco',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustment amount applied to the invoice, including credits for billing errors, leak adjustments, service quality issues, or promotional discounts. Positive values increase invoice total; negative values decrease it.',
    `billing_period_end_date` DATE COMMENT 'Last day of the consumption period covered by this invoice. Typically aligns with the current meter read date or service period end.',
    `billing_period_start_date` DATE COMMENT 'First day of the consumption period covered by this invoice. Typically aligns with the prior meter read date or service period start.',
    `ccr_included` BOOLEAN COMMENT 'Boolean flag indicating whether the annual Consumer Confidence Report (water quality report) was included with this invoice mailing. Required annually under Safe Drinking Water Act (SDWA).',
    `conservation_message` STRING COMMENT 'Optional water conservation message or tip printed on the invoice to encourage efficient water use. May vary seasonally or based on drought conditions.',
    `created_by_user` STRING COMMENT 'User ID or system process name that created this invoice record. For automated cycle billing, typically a batch process identifier; for manual invoices, the billing staff user ID.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was first created in the billing system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the invoice was delivered to the customer. Options include postal mail (paper bill), email (electronic bill), customer web portal, or SMS notification with portal link.. Valid values are `postal_mail|email|customer_portal|sms`',
    `disconnection_date` DATE COMMENT 'Date on which service may be disconnected if payment is not received. Typically set 10-15 days after due date, subject to regulatory notice requirements and customer protections.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has formally disputed charges on this invoice. Triggers dispute resolution workflow and may suspend collection activities.',
    `due_date` DATE COMMENT 'Date by which payment must be received to avoid late fees or service disconnection. Calculated based on invoice date plus payment terms (typically 15-30 days).',
    `generation_method` STRING COMMENT 'Method by which the invoice was generated. Automated cycle invoices are produced by scheduled batch billing runs; manual invoices are created by billing staff; off-cycle invoices are generated outside normal schedules; estimated invoices use projected consumption; corrected invoices replace prior errors.. Valid values are `automated_cycle|manual|off_cycle|estimated|corrected`',
    `invoice_date` DATE COMMENT 'Date the invoice was generated and issued to the customer. This is the official invoice date printed on the bill and used for aging calculations.',
    `invoice_number` STRING COMMENT 'Externally visible, human-readable invoice number printed on customer bills and used for customer service inquiries. Must be unique across all invoices.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle state of the invoice. Draft invoices are pending finalization; issued invoices have been sent to customers; paid invoices are fully settled; partial_paid invoices have received some payment; overdue invoices are past due date; cancelled invoices are nullified before payment; void invoices are nullified after issuance. [ENUM-REF-CANDIDATE: draft|issued|paid|partial_paid|overdue|cancelled|void — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on billing circumstances. Regular cycle invoices are standard periodic bills; final invoices are issued upon service termination; estimated invoices use projected consumption when actual reads are unavailable; corrected invoices replace erroneous prior bills; off-cycle invoices are generated outside normal billing cycles; adjustment invoices correct prior billing errors.. Valid values are `regular_cycle|final|estimated|corrected|off_cycle|adjustment`',
    `is_estimated` BOOLEAN COMMENT 'Boolean flag indicating whether consumption values on this invoice are estimated rather than based on actual meter readings. True when meter is inaccessible or malfunctioning.',
    `is_final` BOOLEAN COMMENT 'Boolean flag indicating whether this is a final invoice issued upon service termination or account closure. Final invoices settle all outstanding charges and close the billing relationship.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Late payment penalty assessed if payment is not received by due date. Calculated as a percentage of outstanding balance or flat fee per utility policy and regulatory limits.',
    `modified_by_user` STRING COMMENT 'User ID or system process name that last modified this invoice record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was last modified. Updated whenever invoice status, amounts, or other attributes change.',
    `other_charges_amount` DECIMAL(18,2) COMMENT 'Miscellaneous charges not categorized as water, wastewater, or stormwater services. May include meter reading fees, service connection charges, late fees, returned payment fees, or special assessments.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date until payment is due. Standard terms are typically 15, 21, or 30 days depending on utility policy and customer class.',
    `previous_balance_amount` DECIMAL(18,2) COMMENT 'Outstanding balance carried forward from prior billing periods. Represents unpaid or partially paid amounts from previous invoices.',
    `print_date` DATE COMMENT 'Date the invoice was physically printed or electronically rendered for delivery to the customer. May differ from invoice date for batch processing.',
    `rate_schedule_code` STRING COMMENT 'Code identifying the tariff rate schedule applied to calculate charges on this invoice. Rate schedules vary by customer class (residential, commercial, industrial) and service type.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `stormwater_area` DECIMAL(18,2) COMMENT 'Total impervious surface area (in square feet or square meters) used to calculate stormwater management fees. Applicable for properties subject to stormwater utility charges.',
    `stormwater_charge_amount` DECIMAL(18,2) COMMENT 'Charges for stormwater management services, typically calculated based on impervious surface area. Supports stormwater infrastructure maintenance and regulatory compliance.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charges applied to the invoice, including sales tax, utility tax, franchise fees, or other regulatory taxes as required by jurisdiction.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Total amount the customer must pay, calculated as sum of current period charges (water, wastewater, stormwater, other), taxes, adjustments, and previous balance. This is the headline amount printed on the invoice.',
    `wastewater_charge_amount` DECIMAL(18,2) COMMENT 'Total charges for wastewater collection and treatment services during the billing period. May include volumetric charges, fixed fees, and strength-of-waste surcharges for industrial users.',
    `wastewater_volume` DECIMAL(18,2) COMMENT 'Volume of wastewater discharged during the billing period, typically calculated as a percentage of water consumption or measured separately for industrial customers. Measured in same unit as water consumption.',
    `water_charge_amount` DECIMAL(18,2) COMMENT 'Total charges for potable water service during the billing period, including volumetric consumption charges and fixed service fees. Calculated based on applicable rate schedule and tier structure.',
    `water_consumption_uom` STRING COMMENT 'Unit of measure for water consumption volume. Common units include gallons, cubic meters (m³), hundred cubic feet (CCF), or thousand gallons (kgal).. Valid values are `gallons|cubic_meters|ccf|kgal`',
    `water_consumption_volume` DECIMAL(18,2) COMMENT 'Total volume of potable water consumed during the billing period, measured in gallons or cubic meters depending on utility standard. Derived from meter readings or estimated when actual reads unavailable.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document representing a periodic, on-demand, or final statement of charges issued to a customer billing account for water, wastewater, stormwater, and other utility services. Captures billing period, due date, total amount due, invoice status (draft, issued, paid, overdue, cancelled), bill type (regular cycle, final, estimated, corrected, off-cycle), generation method, closing meter read reference (for final bills), deposit application amount, and forwarding address (for final bill refunds). SSOT for all customer-facing billing documents including final bills upon service termination.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for the invoice line product.',
    `agreement_id` BIGINT COMMENT 'Reference to the service agreement under which this charge is billed. Links charges to contractual terms.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Reference to the rate schedule applied to calculate this charge. Determines pricing structure and rate components.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Individual invoice line items must reference specific CIP projects for detailed cost allocation, project accounting, and grant/bond compliance reporting. Required for tracking which project costs are',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Invoice lines post to specific GL accounts based on charge type (water, wastewater, stormwater). Revenue reporting, rate case cost-of-service analysis, and regulatory compliance require GL account att',
    `interval_consumption_id` BIGINT COMMENT 'Foreign key linking to metering.interval_consumption. Business justification: Invoice line items representing consumption charges should reference the authoritative rated_consumption record as their source data. This establishes traceability from billed charges back to the mete',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header that contains this line item. Links the line to the billing document.',
    `point_id` BIGINT COMMENT 'Reference to the service point (meter location) associated with this charge. Links consumption-based charges to physical delivery point.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Industrial and commercial customers may have quality-based rate structures or surcharges tied to specific sampling points. Invoice lines need to reference the monitoring location for rate justificatio',
    `rate_tier_id` BIGINT COMMENT 'Reference to the specific rate tier applied for tiered or block rate structures. Identifies which consumption block or tier this charge falls into.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Individual line items tie to specific assets for meter reading charges, infrastructure access fees, asset-specific surcharges, and lead service line replacement charges. Required for granular asset co',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Water consumption line items are directly attributable to the service line delivery point. LCRR surcharges, leak adjustment line items, and service line replacement cost recovery charges all reference',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for billing adjustments, credits, or special charges. Used for adjustment and dispute tracking. [ENUM-REF-CANDIDATE: BILLING_ERROR|METER_MALFUNCTION|LEAK_ADJUSTMENT|CUSTOMER_DISPUTE|RATE_CHANGE|PRORATION|CREDIT_MEMO|WRITE_OFF|GOODWILL|OTHER — 10 candidates stripped; promote to reference product]',
    `adjustment_reference_number` STRING COMMENT 'Reference number linking this line to an adjustment request, dispute case, or credit memo. Provides audit trail for non-standard charges.',
    `billing_determinant` STRING COMMENT 'The basis or method used to calculate this charge. Identifies whether charge is based on metered usage, property characteristics, flat rate, or other factors. [ENUM-REF-CANDIDATE: METERED_CONSUMPTION|ESTIMATED_CONSUMPTION|FLAT_RATE|METER_SIZE|PROPERTY_SIZE|IMPERVIOUS_AREA|FIXTURE_COUNT|CONNECTION_SIZE|CUSTOMER_CLASS|OTHER — 10 candidates stripped; promote to reference product]',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period for which this charge applies. Defines the conclusion of the service period being billed.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period for which this charge applies. Defines the beginning of the service period being billed.',
    `charge_description` STRING COMMENT 'Detailed textual description of the charge as it appears on the customer invoice. Provides human-readable explanation of the line item.',
    `charge_type_code` STRING COMMENT 'Classification of the charge line item by billing component type. Distinguishes between consumption charges, fixed fees, taxes, adjustments, and other billing elements. [ENUM-REF-CANDIDATE: WATER_CONSUMPTION|WASTEWATER_SERVICE|STORMWATER_FEE|BASE_SERVICE|METER_CHARGE|CONNECTION_FEE|LATE_FEE|ADJUSTMENT|TAX|SURCHARGE|PENALTY|CREDIT|REBATE|DEPOSIT|OTHER — 15 candidates stripped; promote to reference product]',
    `created_by_user` STRING COMMENT 'User identifier or system process that created this invoice line record. Supports audit and accountability requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was first created in the billing system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Typically USD for US-based water utilities.. Valid values are `USD|CAD|EUR|GBP|AUD|MXN`',
    `is_disputed` BOOLEAN COMMENT 'Indicates whether this charge is currently under customer dispute. True if disputed, false otherwise. Used for dispute tracking and collections management.',
    `is_prorated` BOOLEAN COMMENT 'Indicates whether this charge has been prorated due to partial billing period, service start/stop, or rate change. True if prorated, false otherwise.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this line item is subject to taxation. True if taxable, false if tax-exempt.',
    `last_modified_by_user` STRING COMMENT 'User identifier or system process that last modified this invoice line record. Supports audit and accountability requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was last updated. Audit trail for record modifications.',
    `line_amount` DECIMAL(18,2) COMMENT 'Calculated charge amount for this line item before taxes and adjustments. Typically consumption_quantity multiplied by unit_rate for consumption charges, or fixed amount for service fees.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of line items within the parent invoice. Determines display order on customer bill.',
    `line_status` STRING COMMENT 'Current status of the invoice line item in the billing lifecycle. Tracks whether the charge is active, has been adjusted, disputed, or reversed.. Valid values are `ACTIVE|CANCELLED|ADJUSTED|DISPUTED|WRITTEN_OFF|REVERSED`',
    `print_sequence` STRING COMMENT 'Display order for this line item on printed or electronic invoices. Controls the presentation sequence for customer-facing billing documents.',
    `proration_factor` DECIMAL(18,2) COMMENT 'Decimal factor applied for prorated charges. Represents the portion of the full billing period or rate being charged (e.g., 0.5000 for half period).',
    `revenue_class` STRING COMMENT 'Classification of revenue type for financial reporting and regulatory compliance. Distinguishes between operating revenue, capital contributions, and other revenue categories.. Valid values are `OPERATING_REVENUE|NON_OPERATING_REVENUE|CAPITAL_CONTRIBUTION|DEFERRED_REVENUE|OTHER`',
    `service_days` STRING COMMENT 'Number of days in the billing period for this charge. Used for proration calculations and billing cycle analysis.',
    `service_type` STRING COMMENT 'Type of utility service being billed on this line. Distinguishes between water, wastewater, stormwater, and other utility services. [ENUM-REF-CANDIDATE: WATER|WASTEWATER|STORMWATER|RECLAIMED_WATER|BULK_WATER|FIRE_PROTECTION|IRRIGATION|INDUSTRIAL|COMMERCIAL|RESIDENTIAL — 10 candidates stripped; promote to reference product]',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to this line item. Includes sales tax, utility tax, or other applicable taxes based on jurisdiction.',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Tax rate percentage applied to calculate the tax amount. Expressed as decimal (e.g., 0.0825 for 8.25% tax rate).',
    `total_line_amount` DECIMAL(18,2) COMMENT 'Total amount for this line item including taxes and adjustments. Sum of line_amount and tax_amount. Contributes to invoice total.',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per unit of consumption or service. The rate applied to calculate the line charge amount. Expressed in currency per consumption_unit_of_measure.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual charge line item on a utility invoice, representing any discrete billable component including water consumption charges, wastewater service charges, stormwater fees, base/fixed service charges, taxes, surcharges, late payment penalties, reconnection fees, meter test fees, industrial surcharges, and billing adjustments. Captures charge type, charge source (consumption-based, service order, penalty, surcharge), rate component reference, quantity, unit rate, calculated amount, billing determinant, applicable rate tier, and originating service order reference (if field-generated). SSOT for all individual charges appearing on customer invoices.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment record.',
    `ar_transaction_id` BIGINT COMMENT 'Unique transaction identifier from the payment gateway or processor, used for reconciliation and dispute resolution.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Payments are deposited to specific bank accounts. Treasury operations, bank reconciliation, and cash management require tracking which bank account received each payment for daily cash positioning and',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Payments for project-related invoices (developer contributions, interagency reimbursements, capacity charges) must be tracked to specific projects for capital accounting, funding source reconciliation',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Payments must link to customer accounts for payment history inquiries, customer service operations, and account reconciliation. This enables customer-centric payment reporting and supports customer se',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Payments generate journal entries (debit cash/bank account, credit AR). Cash management, bank reconciliation, and financial close require linking payments to GL postings for cash receipt accounting an',
    `invoice_id` BIGINT COMMENT 'Reference to the specific bill or invoice that this payment is intended to satisfy. May be null for advance payments or account credits.',
    `employee_id` BIGINT COMMENT 'Identifier of the customer service representative or system user who received or processed the payment. Null for automated payments.',
    `payment_invoice_id` BIGINT COMMENT 'Reference to the specific bill or invoice that this payment is intended to satisfy. May be null for advance payments or account credits.',
    `payment_plan_id` BIGINT COMMENT 'Reference to the payment plan or payment arrangement under which this payment was made. Null for non-plan payments.',
    `payment_received_by_user_employee_id` BIGINT COMMENT 'Identifier of the customer service representative or system user who received or processed the payment. Null for automated payments.',
    `reversed_by_payment_id` BIGINT COMMENT 'Reference to the reversal payment transaction that cancelled or reversed this payment. Null for non-reversed payments.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount of the payment received from the customer, in the utilitys base currency.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been applied to outstanding account balances. May differ from payment_amount if payment is partially applied or held as credit.',
    `authorization_code` STRING COMMENT 'Authorization or approval code returned by the payment processor for credit card or ACH transactions.',
    `bank_account_last_four` STRING COMMENT 'Last four digits of the bank account number used for ACH or electronic payments. Used for customer verification without exposing full account number.. Valid values are `^[0-9]{4}$`',
    `batch_number` STRING COMMENT 'Identifier for the payment batch or deposit group in which this payment was processed, used for reconciliation and audit purposes.',
    `card_last_four` STRING COMMENT 'Last four digits of the credit or debit card number used for card payments. Used for customer verification without exposing full card number.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'The credit or debit card brand for card payments (e.g., Visa, MasterCard, American Express, Discover). Null for non-card payments.. Valid values are `visa|mastercard|amex|discover`',
    `channel` STRING COMMENT 'The customer interface or channel through which the payment was submitted (e.g., walk-in office, mail, web portal, mobile app, IVR phone system, bank lockbox, automatic payment). [ENUM-REF-CANDIDATE: walk_in|mail|web_portal|mobile_app|ivr|lockbox|auto_pay — 7 candidates stripped; promote to reference product]',
    `check_number` STRING COMMENT 'The check number for check payments. Null for non-check payment methods.',
    `cleared_date` DATE COMMENT 'The date on which the payment cleared the bank or financial institution, confirming funds availability. Null for cash payments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `is_auto_pay` BOOLEAN COMMENT 'Boolean flag indicating whether this payment was processed automatically through an auto-pay enrollment (True) or was a manual customer-initiated payment (False).',
    `is_recurring` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is part of a recurring payment plan or schedule (True) or a one-time payment (False).',
    `location_code` STRING COMMENT 'Code identifying the physical location or office where the payment was received (e.g., branch office, payment center). Null for remote payments.',
    `lockbox_number` STRING COMMENT 'Bank lockbox number or identifier for payments received through lockbox processing services. Null for non-lockbox payments.',
    `method` STRING COMMENT 'The financial instrument or tender type used to make the payment (e.g., check, ACH bank draft, credit card, debit card, cash, money order).. Valid values are `check|ach|credit_card|debit_card|cash|money_order`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about the payment transaction, including customer instructions, special handling notes, or dispute information.',
    `nsf_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged to the customer account for a returned NSF payment. Null if no NSF occurred or no fee was assessed.',
    `nsf_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this payment was returned due to non-sufficient funds (True) or processed successfully (False).',
    `payment_date` DATE COMMENT 'The date on which the payment was received or processed by the utility. This is the business event date for revenue recognition.',
    `payment_number` STRING COMMENT 'Business-facing unique reference number for the payment transaction, used for customer inquiries and reconciliation.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction indicating whether it has been posted to the account, cleared by the bank, or reversed.. Valid values are `pending|posted|cleared|reversed|cancelled|failed`',
    `payment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the payment transaction was received or recorded in the system.',
    `payment_type` STRING COMMENT 'Classification of the payment purpose (e.g., regular bill payment, advance payment, deposit, refund, billing adjustment).. Valid values are `regular|advance|deposit|refund|adjustment`',
    `posting_date` DATE COMMENT 'The date on which the payment was posted to the customer account and applied against outstanding balances.',
    `processor_name` STRING COMMENT 'Name of the third-party payment processor or gateway that handled the electronic payment transaction (e.g., Stripe, PayPal, bank lockbox service).',
    `reference_number` STRING COMMENT 'External reference number from the payment source (e.g., check number, ACH trace number, credit card authorization code, lockbox batch number).',
    `reversal_reason` STRING COMMENT 'Explanation or reason code for why the payment was reversed or cancelled. Null for non-reversed payments.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that remains unapplied and is held as account credit or pending allocation.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a financial payment transaction for a customer utility account, covering the full payment lifecycle including receipt, posting, return, and re-presentment. Captures payment date, amount, payment method (check, ACH, credit card, cash, online portal, IVR, auto-pay), source channel (walk-in, mail, web, mobile, lockbox, bank draft), posting status, return status, return reason code (NSF, account closed, stop payment), re-presentment attempts, and NSF fee assessed. SSOT for all customer payment transactions including returned/rejected payments. Sourced from Oracle CC&B and Tyler Munis payment processing.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` (
    `payment_application_id` BIGINT COMMENT 'Unique identifier for the payment application record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer account for which this payment application is recorded.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: When payments are applied to project-related invoices, project-level tracking is required for capital accounting, funding source reconciliation, and grant compliance. Essential for tracking which proj',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice to which this payment is being applied.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that applied the payment. Supports audit trail and manual vs. automated application tracking.',
    `dispute_id` BIGINT COMMENT 'Reference to the dispute case record if this payment application is part of a dispute resolution process.',
    `payment_dispute_id` BIGINT COMMENT 'Reference to the dispute case record if this payment application is part of a dispute resolution process.',
    `payment_employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that applied the payment. Supports audit trail and manual vs. automated application tracking.',
    `payment_id` BIGINT COMMENT 'Reference to the payment transaction being applied to outstanding charges.',
    `invoice_line_id` BIGINT COMMENT 'Reference to the specific invoice line item to which this payment is applied. Enables line-level payment allocation.',
    `payment_invoice_line_item_invoice_line_id` BIGINT COMMENT 'Reference to the specific invoice line item to which this payment is applied. Enables line-level payment allocation.',
    `payment_plan_id` BIGINT COMMENT 'Reference to the payment plan or payment arrangement if this application is part of a structured payment agreement.',
    `adjustment_date` DATE COMMENT 'The date on which an adjustment was made to this payment application. Null if no adjustment occurred.',
    `adjustment_indicator` BOOLEAN COMMENT 'Flag indicating whether this payment application was adjusted after initial processing due to billing correction or dispute resolution.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for adjusting the payment application (e.g., billing error, dispute resolution, rate correction).',
    `allocation_method` STRING COMMENT 'The method or rule used to allocate the payment across outstanding charges (e.g., FIFO, oldest invoice first, pro-rata across all balances). [ENUM-REF-CANDIDATE: fifo|lifo|oldest_first|highest_balance|pro_rata|manual|system_default — 7 candidates stripped; promote to reference product]',
    `application_date` DATE COMMENT 'The business date on which the payment was applied to the invoice or account balance. This is the effective date for accounts receivable (AR) reconciliation.',
    `application_number` STRING COMMENT 'Business-readable unique identifier for the payment application transaction, used for tracking and reconciliation.',
    `application_sequence` STRING COMMENT 'Sequential order in which this application was processed for a given payment. Supports scenarios where a single payment is split across multiple invoices.',
    `application_source` STRING COMMENT 'Source or channel through which the payment application was initiated (e.g., automated system rule, manual CSR entry, batch process, customer self-service portal). [ENUM-REF-CANDIDATE: automated|manual|batch|api|customer_portal|ivr|mobile_app — 7 candidates stripped; promote to reference product]',
    `application_status` STRING COMMENT 'Current lifecycle status of the payment application indicating whether funds have been successfully applied, are pending, or have been reversed.. Valid values are `applied|pending|reversed|cancelled|frozen|adjusted`',
    `application_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment application transaction was processed in the billing system.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment that was applied to this specific invoice or line item. Supports partial payment scenarios.',
    `ar_reconciliation_status` STRING COMMENT 'Status indicating whether this payment application has been successfully reconciled in the accounts receivable ledger.. Valid values are `reconciled|pending|exception|under_review`',
    `balance_bucket_code` STRING COMMENT 'Code identifying the account balance bucket or aging category to which the payment was applied (e.g., current, 30-day, 60-day, 90-day past due).',
    `charge_type` STRING COMMENT 'Category of charge to which the payment was applied, distinguishing between water, wastewater, stormwater, penalties, and other utility charges. [ENUM-REF-CANDIDATE: water|wastewater|stormwater|penalty|interest|reconnection|late_fee|service_charge|other — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment application record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the applied payment amount. Typically USD for U.S. water utilities.. Valid values are `USD|CAD|EUR|GBP|AUD|MXN`',
    `dispute_indicator` BOOLEAN COMMENT 'Flag indicating whether this payment application is associated with a billing dispute or customer challenge.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this payment application is posted for financial accounting and revenue recognition.',
    `is_overpayment` BOOLEAN COMMENT 'Flag indicating whether this payment application resulted in an overpayment or credit balance on the account.',
    `is_prepayment` BOOLEAN COMMENT 'Flag indicating whether this payment application represents a prepayment applied to future charges rather than outstanding invoices.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment application record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment application, capturing special instructions, exceptions, or context for manual review.',
    `overpayment_handling` STRING COMMENT 'Indicates how overpayment or excess credit is handled: refunded to customer, held as credit, transferred to another account, or held pending customer instruction.. Valid values are `refund|credit|transfer|hold`',
    `revenue_recognition_date` DATE COMMENT 'The date on which the applied payment amount is recognized as revenue in the general ledger, per GASB revenue recognition standards.',
    `reversal_date` DATE COMMENT 'The date on which this payment application was reversed. Null if not reversed.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this payment application has been reversed due to payment failure, dispute, or correction.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing the payment application (e.g., NSF, dispute, system error, customer request).',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The remaining payment amount that has not yet been applied to any invoice or charge. Represents available credit or prepayment balance.',
    CONSTRAINT pk_payment_application PRIMARY KEY(`payment_application_id`)
) COMMENT 'Association record linking a payment to one or more invoice lines or account balance buckets, capturing how payment funds are allocated across outstanding charges per the utilitys payment application hierarchy (oldest debt first, or by charge priority). Tracks applied amount per invoice line, application sequence, application date, unapplied/overpayment balance, credit memo generation, and reversal status. Enables precise accounts receivable reconciliation and supports partial payments, prepayments, overpayment refunds, and credit applications.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique identifier for the billing account. Primary key for the billing account entity representing the financial relationship between the utility and a customer service account.',
    `agreement_id` BIGINT COMMENT 'Reference to the service agreement that this billing account is associated with. Links the financial account to the service delivery contract.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Developer-funded CIP projects and special assessment districts require direct association between billing accounts and projects for cost recovery. Real business process: developer agreement billing wh',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Billing accounts must reference their originating customer account for customer service inquiries, account consolidation, customer history tracking, and cross-system reconciliation. This is the founda',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Accounts should reference primary supply facility for capital cost recovery tracking, facility-specific rate design, and cost allocation. Core requirement for multi-facility utilities managing separat',
    `account_number` STRING COMMENT 'Externally-visible unique account number used for customer communication, billing statements, and payment processing. This is the business identifier displayed on bills and correspondence.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account indicating whether it is actively billing, suspended due to non-payment, closed, or in another state within the revenue cycle.. Valid values are `active|inactive|suspended|closed|pending_activation|delinquent`',
    `account_type` STRING COMMENT 'Classification of the billing account based on customer segment and rate structure applicability. Determines which rate schedules and service classes apply.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `aging_30_days` DECIMAL(18,2) COMMENT 'Portion of the account balance that is 1-30 days past due. Used for delinquency tracking and collections workflow triggers.',
    `aging_60_days` DECIMAL(18,2) COMMENT 'Portion of the account balance that is 31-60 days past due. Indicates escalating delinquency requiring more aggressive collection actions.',
    `aging_90_days` DECIMAL(18,2) COMMENT 'Portion of the account balance that is 61-90 days past due. Typically triggers final notice and service disconnection warnings.',
    `aging_current` DECIMAL(18,2) COMMENT 'Portion of the account balance that is current and not yet past due. Part of the aging analysis for accounts receivable management.',
    `aging_over_90_days` DECIMAL(18,2) COMMENT 'Portion of the account balance that is more than 90 days past due. Highest risk category for write-off and may result in service termination or legal action.',
    `autopay_enrolled` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in automatic payment processing where bills are automatically paid from a bank account or credit card on the due date.',
    `autopay_method` STRING COMMENT 'Payment instrument used for automatic payment processing if autopay is enabled. Specifies whether payments are drawn from bank account or charged to card.. Valid values are `bank_account|credit_card|debit_card|not_enrolled`',
    `balance_forward` DECIMAL(18,2) COMMENT 'Previous balance carried forward from the prior billing cycle before current period charges are applied. Used for aging analysis and delinquency tracking.',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle schedule for this account (e.g., monthly, bi-monthly, quarterly). Determines when meter reads are taken and bills are generated.. Valid values are `^[A-Z0-9]{2,10}$`',
    `billing_frequency` STRING COMMENT 'Frequency at which bills are generated and issued for this account. Aligns with meter reading schedules and rate structure requirements.. Valid values are `monthly|bi_monthly|quarterly|annual`',
    `budget_billing_amount` DECIMAL(18,2) COMMENT 'Fixed monthly amount charged under budget billing program. Calculated based on historical consumption patterns and reconciled annually.',
    `budget_billing_enrolled` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in budget billing program where monthly bills are averaged to provide consistent payment amounts throughout the year.',
    `closed_date` DATE COMMENT 'Date when the billing account was closed and final bill was issued. Null for active accounts.',
    `collection_status` STRING COMMENT 'Current stage in the collections workflow for delinquent accounts. Indicates escalation level and next collection action required.. Valid values are `current|reminder_sent|final_notice|disconnection_pending|legal_action|write_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed before service restrictions or additional deposits are required. Based on credit rating and payment history.',
    `credit_rating` STRING COMMENT 'Internal credit assessment of the customer based on payment history, delinquency patterns, and account behavior. Influences deposit requirements and collection strategies.. Valid values are `excellent|good|fair|poor|no_rating`',
    `current_balance` DECIMAL(18,2) COMMENT 'Total outstanding balance on the billing account including all charges, fees, adjustments, and payments. Positive values indicate amounts owed by the customer; negative values indicate credit balances.',
    `current_charges` DECIMAL(18,2) COMMENT 'Total charges for the current billing period including water consumption, wastewater service, stormwater fees, and other utility charges before adjustments.',
    `deposit_on_file` DECIMAL(18,2) COMMENT 'Security deposit amount held by the utility to mitigate credit risk. May be applied to final bill or returned to customer upon account closure with good payment history.',
    `disconnection_date` DATE COMMENT 'Date when service was disconnected due to non-payment or other account issues. Null if service is currently active.',
    `final_bill_issued` BOOLEAN COMMENT 'Indicates whether a final bill has been generated for this account upon closure. Used to ensure proper account settlement and deposit refund processing.',
    `last_bill_date` DATE COMMENT 'Date when the most recent bill was generated for this account. Used to calculate next billing cycle and track billing cadence.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received. Used for payment pattern analysis and customer service inquiries.',
    `last_payment_date` DATE COMMENT 'Date when the most recent payment was received and posted to this account. Used for payment history analysis and delinquency assessment.',
    `late_fee_assessed` DECIMAL(18,2) COMMENT 'Total late payment fees assessed on this account for the current billing period. Applied when payment is not received by due date.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was last updated. Used for change tracking and audit compliance.',
    `next_bill_date` DATE COMMENT 'Scheduled date for the next bill generation based on billing cycle and frequency. Used for billing run planning and customer communication.',
    `opened_date` DATE COMMENT 'Date when the billing account was first established. Used for customer tenure analysis and lifecycle reporting.',
    `paperless_billing` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic bill delivery instead of printed paper bills. Reduces mailing costs and supports environmental sustainability.',
    `past_due_amount` DECIMAL(18,2) COMMENT 'Total amount that is overdue and unpaid beyond the payment due date. Used for collections prioritization and service restriction decisions.',
    `payment_plan_active` BOOLEAN COMMENT 'Indicates whether the customer is currently on a payment plan to pay down past due balances in installments. Used to prevent service disconnection during plan compliance.',
    `payment_plan_balance` DECIMAL(18,2) COMMENT 'Remaining balance to be paid under the active payment plan. Tracks progress toward full payment of delinquent amounts.',
    `payment_terms` STRING COMMENT 'Standard payment terms for this billing account specifying the number of days from invoice date until payment is due.. Valid values are `net_15|net_30|net_45|due_on_receipt|installment`',
    `reconnection_fee` DECIMAL(18,2) COMMENT 'Fee charged to restore service after disconnection. Must be paid along with outstanding balance before service is restored.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether this account is exempt from utility taxes and fees. Typically applies to government entities, non-profits, or other qualifying organizations.',
    `tax_exempt_certificate` STRING COMMENT 'Certificate or permit number documenting the tax exemption status. Required for audit compliance and revenue reporting.. Valid values are `^[A-Z0-9-]{0,30}$`',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Financial account entity representing the billing and collections relationship between the utility and a customer at a service point. Owns the financial ledger position including current balance, security deposit amount held, credit classification, autopay enrollment status, paperless billing preference, budget billing enrollment flag, account aging buckets (current, 30/60/90/120+ days), payment history score, cash-only restriction flag, and account status (active, final-billed, closed, collections). SSOT for the financial state of a utility customer account within the revenue cycle. Links to customer domain for demographic and contact information.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` (
    `billing_rate_schedule_id` BIGINT COMMENT 'Unique identifier for the rate schedule. Primary key. Inferred role: MASTER_RESOURCE (tariff definition governing billing calculations).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory rate schedules require documented approval authority for PUC compliance. Water utilities must track which employee approved each rate schedule for audit trails and regulatory filings. Essen',
    `finance_rate_case_id` BIGINT COMMENT 'Foreign key reference to the rate case (regulatory proceeding) that established or modified this rate schedule. Links to the rate_case product.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Rate schedules implement the pricing structure for service offerings (residential water, commercial wastewater, irrigation). Tariff administration and rate case filings require linking approved rate s',
    `superseded_by_billing_rate_schedule_id` BIGINT COMMENT 'Foreign key reference to the rate schedule that supersedes this one. Nullable if this rate schedule is current or retired without replacement.',
    `base_charge_amount` DECIMAL(18,2) COMMENT 'Fixed monthly or periodic base charge (service charge) applied to customers under this rate schedule, regardless of consumption. Expressed in local currency.',
    `billing_frequency` STRING COMMENT 'Frequency at which customers under this rate schedule are billed (e.g., monthly, bimonthly, quarterly, annual).. Valid values are `monthly|bimonthly|quarterly|annual`',
    `billing_rate_schedule_status` STRING COMMENT 'Current lifecycle status of the rate schedule (draft, pending approval, active, superseded, retired). Lifecycle status of the tariff.. Valid values are `draft|pending_approval|active|superseded|retired`',
    `conservation_rate_indicator` BOOLEAN COMMENT 'Indicates whether this rate schedule is designed to promote water conservation through inclining block or penalty pricing (true) or not (false).',
    `consumption_unit_of_measure` STRING COMMENT 'Unit of measure for consumption used in this rate schedule (e.g., gallons, cubic feet, cubic meters, kiloliters, hundred cubic feet (CCF)).. Valid values are `gallons|cubic_feet|cubic_meters|kiloliters|hundred_cubic_feet`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this rate schedule record. Record audit field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was first created in the system. Record audit field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate schedule (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `customer_class` STRING COMMENT 'Customer class or segment this rate schedule applies to (e.g., residential, commercial, industrial, irrigation, municipal, institutional). Classification of the tariff by customer segment.. Valid values are `residential|commercial|industrial|irrigation|municipal|institutional`',
    `billing_rate_schedule_description` STRING COMMENT 'Detailed description of the rate schedule, including its purpose, applicability, and any special conditions or notes.',
    `drought_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a drought surcharge or emergency rate adjustment can be applied under this rate schedule (true) or not (false).',
    `effective_end_date` DATE COMMENT 'Date when this rate schedule is no longer effective and should not be applied to new billing cycles. Nullable for open-ended tariffs. Effective-until date for the tariff.',
    `effective_start_date` DATE COMMENT 'Date when this rate schedule becomes effective and can be applied to customer billing. Effective-from date for the tariff.',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction where this rate schedule applies (e.g., city, county, state, service territory name). Defines the geographic scope of the tariff.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this rate schedule record. Record audit field.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was last modified. Record audit field.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum total charge amount per billing period under this rate schedule (cap). Nullable if no maximum applies.',
    `meter_size_applicability` STRING COMMENT 'Meter size(s) or range this rate schedule applies to (e.g., 5/8 inch, 1 inch, 2 inch and above). Nullable if not meter-size-specific.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum total charge amount per billing period under this rate schedule, regardless of consumption. Nullable if no minimum applies.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this rate schedule (e.g., temporary adjustments, pilot program details).',
    `rate_schedule_code` STRING COMMENT 'Externally-known unique code identifying the rate schedule (tariff). Used on bills, regulatory filings, and customer communications. Business identifier for the tariff.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rate_schedule_name` STRING COMMENT 'Human-readable name of the rate schedule (e.g., Residential Tiered Water Rate, Commercial Flat Wastewater Rate). Identity label for the tariff.',
    `rate_structure_type` STRING COMMENT 'Type of rate structure used for billing calculations (e.g., flat, tiered/inclining block, seasonal, time-of-use, budget-based, uniform, declining block). Defines the pricing methodology. [ENUM-REF-CANDIDATE: flat|tiered|seasonal|time_of_use|budget_based|uniform|declining_block — 7 candidates stripped; promote to reference product]',
    `regulatory_approval_date` DATE COMMENT 'Date when the regulatory body (e.g., Public Utilities Commission) approved this rate schedule.',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier for the regulatory approval (e.g., Public Utilities Commission (PUC) order number, resolution number) authorizing this rate schedule.',
    `seasonal_indicator` BOOLEAN COMMENT 'Indicates whether this rate schedule has seasonal rate variations (true) or is uniform year-round (false).',
    `service_type` STRING COMMENT 'Type of utility service this rate schedule applies to. Classification of the tariff by service line.. Valid values are `water|wastewater|stormwater|recycled_water|combined`',
    CONSTRAINT pk_billing_rate_schedule PRIMARY KEY(`billing_rate_schedule_id`)
) COMMENT 'Master definition of a utility rate schedule (tariff) governing how consumption and service charges are calculated for a customer class. Captures rate schedule code, name, effective date range, service type (water, wastewater, stormwater, recycled water), customer class (residential, commercial, industrial, irrigation, municipal), rate structure type (flat, tiered/inclining block, seasonal, time-of-use, budget-based), regulatory approval reference, and jurisdiction. Approved by the Public Utilities Commission. SSOT for all tariff definitions.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` (
    `rate_component_id` BIGINT COMMENT 'Unique identifier for the rate component. Primary key for the rate component entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rate components require approval tracking for regulatory compliance. Water utilities must document which employee approved each rate component for PUC audits and rate case proceedings. Critical for re',
    `billing_rate_schedule_id` BIGINT COMMENT 'Reference to the parent rate schedule that contains this component. Links the component to its governing rate structure.',
    `approval_authority` STRING COMMENT 'Name of the regulatory body or internal authority that approved this rate component. Examples: State Public Utilities Commission, City Council, Utility Board of Directors.',
    `approval_date` DATE COMMENT 'Date when the rate component was approved by the governing regulatory authority or utility board. Required for regulatory compliance and audit trails.',
    `bill_print_label` STRING COMMENT 'Customer-facing label text displayed on the bill for this component. Should be clear and understandable to customers. Examples: Monthly Service Charge, Water Usage - First 5 CCF, Stormwater Fee.',
    `calculation_formula` STRING COMMENT 'Custom calculation expression for formula-based components. Contains the algorithmic logic used to compute the charge amount, referencing other rate components, usage data, or account attributes. Null for standard calculation methods.',
    `calculation_method` STRING COMMENT 'Algorithm used to calculate the charge amount. Flat amount applies a fixed charge regardless of usage, per-unit multiplies usage by unit rate, tiered block applies different rates to usage ranges, percentage applies a rate to another charge, and formula uses a custom calculation expression.. Valid values are `flat_amount|per_unit|tiered_block|percentage|formula`',
    `component_code` STRING COMMENT 'Business identifier code for the rate component used in billing systems and rate books. Examples: BASE_CHG, TIER1_VOL, DEMAND_CHG, STORMWATER_FEE.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `component_name` STRING COMMENT 'Human-readable name of the rate component. Examples: Base Service Charge, First Tier Volumetric Charge, Peak Demand Charge, Stormwater Management Fee.',
    `component_type` STRING COMMENT 'Classification of the rate component defining its billing purpose. Base charges are fixed monthly fees, volumetric charges are consumption-based, demand charges are based on peak usage, tier charges apply to usage blocks, surcharges are additional fees, taxes are regulatory levies, fees are service-specific charges, adjustments modify base amounts, and credits reduce charges. [ENUM-REF-CANDIDATE: base_charge|volumetric_charge|demand_charge|tier_charge|surcharge|tax|fee|adjustment|credit — 9 candidates stripped; promote to reference product]',
    `conservation_tier_flag` BOOLEAN COMMENT 'Indicates whether this component is part of a conservation-oriented inclining block rate structure designed to discourage excessive water use. True for higher-tier volumetric charges that increase with consumption.',
    `cost_center` STRING COMMENT 'Cost center code for internal cost allocation and profitability analysis. Links revenue to the organizational unit or service line responsible for the charge.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate component record was first created in the system. Used for audit trails and data lineage tracking.',
    `rate_component_description` STRING COMMENT 'Detailed business description of the rate component, its purpose, and how it is applied. Provides context for billing staff, customer service representatives, and customers reviewing their bills.',
    `effective_end_date` DATE COMMENT 'Date when this rate component ceases to be active. Null indicates the component is currently active with no planned end date. Used for rate schedule versioning and historical rate reconstruction.',
    `effective_start_date` DATE COMMENT 'Date when this rate component becomes active and applicable to billing. Supports rate change management and regulatory compliance with rate case approval timelines.',
    `flat_amount` DECIMAL(18,2) COMMENT 'Fixed charge amount for flat-rate components such as base service charges, connection fees, or fixed surcharges. Null for volumetric or percentage-based components.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which revenue from this component is posted. Links billing transactions to the financial accounting system for revenue recognition and reporting.. Valid values are `^[0-9]{4,10}$`',
    `is_prorated` BOOLEAN COMMENT 'Indicates whether the component should be prorated for partial billing periods. True if the charge should be adjusted proportionally when service starts or ends mid-cycle. False if the full charge applies regardless of billing period length.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this component is subject to sales tax or other tax levies. True if the component amount should be included in the taxable base for tax calculation. False if exempt from taxation.',
    `is_volumetric` BOOLEAN COMMENT 'Indicates whether the component is consumption-based (volumetric) or fixed. True for components that vary with usage (per-unit, tiered block). False for fixed charges (base charges, flat fees). Used to distinguish variable from fixed revenue components.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate component record was last updated. Used for change tracking and audit compliance.',
    `meter_size_applicability` STRING COMMENT 'Meter size or size range to which this component applies. Used for meter-size-based base charges. Examples: 5/8 inch, 1 inch, 2 inch, 3 inch and larger. Null if component applies to all meter sizes.',
    `percentage_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied for percentage-based components such as taxes, surcharges, or adjustments. Expressed as a decimal (e.g., 0.0825 for 8.25% sales tax). Null for non-percentage components.',
    `print_on_bill_flag` BOOLEAN COMMENT 'Indicates whether this component should be displayed as a separate line item on customer bills. True for components that require transparency and customer visibility. False for internal calculation components.',
    `rate_case_number` STRING COMMENT 'Regulatory rate case docket number or internal rate change request identifier associated with this component. Links the component to the formal rate approval process.',
    `rate_component_status` STRING COMMENT 'Current lifecycle status of the rate component. Active components are in use for billing. Inactive components are temporarily disabled. Pending approval components await regulatory approval. Superseded components have been replaced by newer versions. Retired components are no longer used and retained for historical reference only.. Valid values are `active|inactive|pending_approval|superseded|retired`',
    `regulatory_reporting_category` STRING COMMENT 'Classification code for regulatory financial reporting and rate case filings. Maps the component to standardized reporting categories required by state public utilities commissions.',
    `revenue_class` STRING COMMENT 'Classification of revenue type for financial reporting and cost allocation. Water revenue is from potable water service, wastewater from sewer service, stormwater from drainage fees, reclaimed from recycled water, bulk from wholesale sales, and other for miscellaneous charges.. Valid values are `water|wastewater|stormwater|reclaimed|bulk|other`',
    `seasonal_indicator` STRING COMMENT 'Seasonal applicability of the rate component. Supports seasonal rate structures for water conservation. Year-round applies all year, summer/winter/spring/fall apply to specific seasons, peak/off-peak apply to demand periods. [ENUM-REF-CANDIDATE: year_round|summer|winter|spring|fall|peak|off_peak — 7 candidates stripped; promote to reference product]',
    `sequence_number` STRING COMMENT 'Ordering sequence for component calculation and display within the rate schedule. Lower numbers are calculated and displayed first. Critical for components with dependencies (e.g., base charge calculated before percentage surcharge).',
    `service_type` STRING COMMENT 'Customer service class to which this component applies. Supports differential pricing by customer segment. Residential serves households, commercial serves businesses, industrial serves manufacturing, institutional serves government and non-profits, agricultural serves farms, and wholesale serves other utilities.. Valid values are `residential|commercial|industrial|institutional|agricultural|wholesale`',
    `tier_high_threshold` DECIMAL(18,2) COMMENT 'Upper bound of the usage quantity range for tiered block rate components. Defines the maximum consumption level (inclusive) to which this tier rate applies. Measured in the components unit of measure. Null indicates no upper limit (open-ended tier). Null for non-tiered components.',
    `tier_low_threshold` DECIMAL(18,2) COMMENT 'Lower bound of the usage quantity range for tiered block rate components. Defines the minimum consumption level (inclusive) to which this tier rate applies. Measured in the components unit of measure. Null for non-tiered components.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for volumetric or demand-based components. CCF (hundred cubic feet) is the standard water billing unit in North America. Gallons, kgal (thousand gallons), mgal (million gallons), and cubic meters are alternative volume units. Each applies to count-based charges. kWh and therm apply to energy-related charges. NA indicates non-volumetric components like flat fees. [ENUM-REF-CANDIDATE: CCF|gallon|kgal|mgal|cubic_meter|each|kWh|therm|NA — 9 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate applied per unit of measure for volumetric or demand-based components. For per-unit calculation methods, this is the price per CCF, gallon, or other unit. For tiered blocks, this is the rate for the specific tier. Null for flat amount components.',
    CONSTRAINT pk_rate_component PRIMARY KEY(`rate_component_id`)
) COMMENT 'Individual pricing component within a rate schedule defining a specific charge element such as a commodity charge tier, base/fixed service charge, demand charge, surcharge, or tax. Captures component type, calculation algorithm (flat amount, per-unit, tiered block), unit of measure (CCF, gallons, kW), tier thresholds (low/high quantity bounds), unit rate, effective date range, and whether the component is volumetric or fixed. Supports complex inclining block rate structures common in water conservation pricing.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the billing adjustment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the supervisor or manager who approved this adjustment. Null if not yet approved or if auto-approved.',
    `adjustment_initiated_by_user_employee_id` BIGINT COMMENT 'Reference to the customer service representative or system user who initiated the adjustment request.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Billing adjustments may relate to project costs (correcting project-related charges, developer credits, capacity charge adjustments). Required for project financial reconciliation and ensuring accurat',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Adjustments must link to customer accounts for customer service inquiries, adjustment history tracking, and audit trails. Customer service representatives need to view all adjustments applied to a cus',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice being adjusted, if applicable. Null for account-level adjustments not tied to a specific invoice.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Billing adjustments generate GL journal entries to record revenue impacts. Auditors and financial controllers need to trace adjustments to their accounting postings for financial statement preparation',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Leak adjustments and water quality adjustments require lab verification (non-potable water during main breaks, contamination events). Adjustment approval workflows and audits require linking to the su',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Main break events trigger billing adjustments for affected customers (service interruption credits, water quality credits post-break). Adjustment records cite the main break event as justification for',
    `network_isolation_event_id` BIGINT COMMENT 'Foreign key linking to distribution.network_isolation_event. Business justification: Planned network isolation events (maintenance shutdowns) trigger service interruption credits for affected customers. Adjustment records must cite the isolation event for audit trails, regulatory repo',
    `original_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment record being reversed, if this is a reversal entry. Null if this is not a reversal.',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Adjustments can be applied to payment plan balances (e.g., reducing the enrolled balance due to a billing error correction, or adjusting installment amounts). Each adjustment that affects a payment pl',
    `primary_adjustment_employee_id` BIGINT COMMENT 'Reference to the supervisor or manager who approved this adjustment. Null if not yet approved or if auto-approved.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Billing adjustments frequently result from asset issues: meter malfunction, leak on utility-owned infrastructure, asset failure causing service interruption. Required for leak adjustment tracking by a',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Leak adjustments (leak_allowance_flag) require service line inspection records as justification, high-bill adjustments reference service line condition and age, and LCRR compliance adjustments tie to',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Quality-based adjustments (contamination, non-potable events) require specific test results showing exceedances or failures. Regulatory compliance and audit requirements mandate linking adjustments to',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Billing adjustments for water quality issues (contamination events, boil water orders, discoloration complaints) must reference the lab sample that documented the problem. Required for regulatory audi',
    `adjustment_number` STRING COMMENT 'Externally visible unique adjustment reference number used for customer communication and audit trails.. Valid values are `^ADJ-[0-9]{8,12}$`',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment: pending (awaiting approval), approved (authorized but not yet applied), rejected (denied), applied (posted to account), reversed (undone), cancelled (voided before application).. Valid values are `pending|approved|rejected|applied|reversed|cancelled`',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment indicating the nature of the correction: credit (reduces balance), debit (increases balance), write-off (uncollectible), leak_adjustment (leak allowance), rate_correction (tariff error), estimated_to_actual (true-up from estimated to actual meter reading), courtesy_credit (goodwill), penalty_reversal (late fee removal). [ENUM-REF-CANDIDATE: credit|debit|write-off|leak_adjustment|rate_correction|estimated_to_actual|courtesy_credit|penalty_reversal — 8 candidates stripped; promote to reference product]',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the adjustment in the billing currency. Positive values represent credits (reducing customer balance), negative values represent debits (increasing customer balance).',
    `applied_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was actually posted to the customer account and reflected in the account balance. Null if not yet applied.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether supervisory approval is required for this adjustment based on amount thresholds or adjustment type. True if approval is required, False if auto-approved.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which supervisory approval is required for this adjustment type. Null if no threshold applies.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was approved by the supervisor. Null if not yet approved.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period to which this adjustment applies. Used for period-specific corrections and true-ups.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period to which this adjustment applies. Used for period-specific corrections and true-ups.',
    `charge_category` STRING COMMENT 'The billing charge category being adjusted: consumption (usage-based charges), base_charge (fixed monthly fee), connection_fee (new service fees), late_fee (delinquency charges), penalty (violation fines), surcharge (special assessments), tax (sales or utility tax), other (miscellaneous). [ENUM-REF-CANDIDATE: consumption|base_charge|connection_fee|late_fee|penalty|surcharge|tax|other — 8 candidates stripped; promote to reference product]',
    `consumption_unit_of_measure` STRING COMMENT 'Unit of measure for the consumption volume adjusted: gallons, cubic_meters (m³), cubic_feet (ft³), liters, ccf (hundred cubic feet), kgal (thousand gallons).. Valid values are `gallons|cubic_meters|cubic_feet|liters|ccf|kgal`',
    `consumption_volume_adjusted` DECIMAL(18,2) COMMENT 'The volume of water or wastewater consumption being adjusted, measured in the utilitys standard unit (typically gallons or cubic meters). Null if adjustment is not consumption-related.',
    `cost_center_code` STRING COMMENT 'Cost center or department code responsible for this adjustment, used for internal cost allocation and management reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the adjustment amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified of this adjustment via bill message, email, or letter. True if notification sent, False otherwise.',
    `dispute_reference_number` STRING COMMENT 'Reference number of the customer billing dispute or complaint that triggered this adjustment. Null if not dispute-related.. Valid values are `^DISP-[0-9]{6,10}$`',
    `effective_date` DATE COMMENT 'The business date on which the adjustment becomes effective and is applied to the customer account balance. May differ from creation or approval dates for backdated corrections.',
    `external_reference_number` STRING COMMENT 'External reference number from third-party systems (e.g., payment processor, collection agency, regulatory agency) related to this adjustment. Null if no external reference.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this adjustment is posted for financial reporting and reconciliation purposes.. Valid values are `^[0-9]{4,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment record was last updated or modified.',
    `leak_allowance_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is a leak allowance credit granted to the customer for documented plumbing leaks. True if leak allowance, False otherwise.',
    `leak_verification_date` DATE COMMENT 'Date when the plumbing leak was verified by utility staff or licensed plumber, supporting the leak allowance adjustment. Null if not a leak adjustment.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the adjustment for internal use, audit trails, and customer service reference.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when customer notification of the adjustment was sent. Null if notification not yet sent.',
    `rate_case_reference` STRING COMMENT 'Reference number of the regulatory rate case or tariff filing that mandated this adjustment. Null if not rate-case-related.. Valid values are `^RC-[0-9]{4}-[0-9]{3,6}$`',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific business reason for the adjustment (e.g., BILLING_ERROR, METER_MALFUNCTION, LEAK_ALLOWANCE, CUSTOMER_DISPUTE, RATE_CHANGE, GOODWILL, REGULATORY_COMPLIANCE). Maps to internal reason code table.. Valid values are `^[A-Z0-9]{2,10}$`',
    `reason_description` STRING COMMENT 'Detailed free-text explanation of the reason for the adjustment, providing context for audit and customer service purposes.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this adjustment was made to comply with regulatory requirements or rate case orders. True if regulatory-driven, False otherwise.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is a reversal of a previous adjustment. True if this is a reversal entry, False otherwise.',
    `reversal_reason` STRING COMMENT 'Free-text explanation of why the original adjustment was reversed. Null if this is not a reversal.',
    `service_type` STRING COMMENT 'The type of utility service to which this adjustment applies: water (potable water supply), wastewater (sewage collection and treatment), stormwater (drainage fees), reclaimed_water (recycled water), bulk_water (wholesale water sales), other (miscellaneous charges).. Valid values are `water|wastewater|stormwater|reclaimed_water|bulk_water|other`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is exempt from sales tax or utility tax. True if tax-exempt, False if taxable.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Financial adjustment applied to a customer billing account to correct billing errors, apply credits, process leak allowances, issue courtesy credits, or reverse charges. Captures adjustment type (credit, debit, write-off, leak adjustment, rate correction, estimated-to-actual true-up), adjustment reason code, amount, approval status, approving supervisor, reference invoice, and effective date. Supports regulatory requirements for documented billing corrections and customer dispute resolution.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan arrangement. Primary key.',
    `assistance_program_id` BIGINT COMMENT 'Reference to the utility assistance program (such as Low Income Home Energy Assistance Program - LIHEAP, or local affordability program) associated with this payment plan. Nullable if plan is not tied to an assistance program.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer account enrolled in this payment plan.',
    `employee_id` BIGINT COMMENT 'Reference to the utility employee or system user who approved the payment plan establishment. Nullable if approval was automated or not tracked.',
    `payment_employee_id` BIGINT COMMENT 'Reference to the utility employee or system user who approved the payment plan establishment. Nullable if approval was automated or not tracked.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan was approved by the utility, marking the transition from pending to active status.',
    `broken_date` DATE COMMENT 'Date when the payment plan was marked as broken due to missed payment or violation of terms. Nullable if plan has never been broken.',
    `broken_reason` STRING COMMENT 'Reason the payment plan was marked as broken: missed installment (customer failed to pay on time), late payment (payment received after grace period), new charges unpaid (customer failed to pay current charges while on plan), customer request (customer asked to cancel), or administrative (utility-initiated termination).. Valid values are `missed_installment|late_payment|new_charges_unpaid|customer_request|administrative`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the payment plan was cancelled, capturing business context for audit and reporting purposes.',
    `cancelled_date` DATE COMMENT 'Date when the payment plan was cancelled by the utility or customer before completion. Nullable if plan was not cancelled.',
    `completed_date` DATE COMMENT 'Date when the payment plan was successfully completed with all installments paid in full. Nullable if plan is not yet completed.',
    `completed_installments` STRING COMMENT 'Number of installment payments successfully made by the customer to date.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan record was first created in the system.',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'Remaining balance amount still owed under the payment plan after applying all installment payments to date.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial down payment amount required to establish the payment plan, paid at enrollment. Nullable if no down payment was required.',
    `down_payment_received_date` DATE COMMENT 'Date when the down payment was received and the payment plan was activated. Nullable if no down payment was required.',
    `enrolled_balance_amount` DECIMAL(18,2) COMMENT 'Total delinquent balance amount enrolled in the payment plan at the time of plan establishment. Represents the arrears being repaid through installments.',
    `grace_period_days` STRING COMMENT 'Number of days after the installment due date during which a late payment is accepted without breaking the plan.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Fixed amount the customer is required to pay per installment period to satisfy the payment plan terms.',
    `installment_frequency` STRING COMMENT 'Frequency at which installment payments are due: weekly, biweekly, monthly, or quarterly.. Valid values are `weekly|biweekly|monthly|quarterly`',
    `liheap_eligible` BOOLEAN COMMENT 'Indicates whether the customer on this payment plan is eligible for LIHEAP or similar low-income energy assistance coordination. True if eligible; false otherwise.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan record was last modified, capturing any updates to plan terms, status, or attributes.',
    `next_installment_due_date` DATE COMMENT 'Date when the next installment payment is due from the customer.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special terms, customer circumstances, or administrative remarks related to the payment plan.',
    `plan_end_date` DATE COMMENT 'Scheduled date when the payment plan is expected to be completed if all installments are paid on time. Nullable for open-ended plans.',
    `plan_number` STRING COMMENT 'Externally visible unique business identifier for the payment plan, formatted as PP-XXXXXXXX.. Valid values are `^PP-[0-9]{8}$`',
    `plan_start_date` DATE COMMENT 'Date when the payment plan becomes effective and the first installment is due.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the payment plan: active (customer is making payments on schedule), broken (customer missed payment and violated terms), completed (all installments paid), cancelled (plan terminated by utility or customer), suspended (temporarily paused), or pending approval (awaiting credit review).. Valid values are `active|broken|completed|cancelled|suspended|pending_approval`',
    `plan_type` STRING COMMENT 'Classification of the payment plan arrangement: budget billing (level monthly payments), deferred payment agreement (short-term installment), low-income assistance (subsidized plan), arrearage management (long-term debt forgiveness plan), seasonal payment (adjusted for seasonal usage), or extended payment (custom extended terms).. Valid values are `budget_billing|deferred_payment_agreement|low_income_assistance|arrearage_management|seasonal_payment|extended_payment`',
    `requires_current_charges_paid` BOOLEAN COMMENT 'Indicates whether the customer must pay all new current charges in addition to installment payments to remain in good standing on the plan. True if current charges must be paid; false if only installments are required.',
    `total_installments` STRING COMMENT 'Total number of scheduled installment payments required to complete the payment plan.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Structured payment arrangement for customers, covering delinquent balance repayment plans, budget billing (levelized payment) programs, and utility assistance installment plans. For deferred payment agreements: captures enrolled delinquent balance, installment amount/frequency, plan status, and break conditions. For budget billing: captures monthly budget amount, true-up month, cumulative actual vs billed variance, and annual reconciliation. Supports LIHEAP coordination, low-income assistance plans, and service disconnection avoidance. SSOT for all structured payment arrangements on a billing account.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` (
    `collection_notice_id` BIGINT COMMENT 'Primary key for collection_notice',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Collection notices are issued to delinquent billing accounts as part of the collections workflow. Each notice must reference the account it was issued to. This is a missing critical FK - collection_no',
    `order_id` BIGINT COMMENT 'Foreign key linking to service.service_order. Business justification: Collection notices for non-payment trigger disconnection service orders when payment is not received by due date. Collections workflow requires linking the delinquency notice to the scheduled disconne',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Collection notices require employee accountability tracking for customer service quality assurance and dispute resolution. Water utilities need to identify which employee generated each notice for aud',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Collection notices need to reference any active payment plan on the account to determine appropriate collection actions. Accounts with active payment plans in good standing should not receive aggressi',
    CONSTRAINT pk_collection_notice PRIMARY KEY(`collection_notice_id`)
) COMMENT 'Formal delinquency notification issued to a customer account as part of the collections workflow, including past-due notices, shut-off warnings, and final disconnection notices. Captures notice type (first notice, final notice, shut-off warning, lien notice), issue date, past-due amount at time of notice, minimum payment required to avoid disconnection, response deadline, delivery method (mail, email, door hanger), and notice status. Tracks the collections escalation ladder per utility tariff and state regulatory requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` (
    `billing_assistance_enrollment_id` BIGINT COMMENT 'Unique identifier for the assistance_enrollment data product (auto-inserted pre-linking).',
    `assistance_program_id` BIGINT COMMENT 'Reference to the specific utility assistance or low-income rate program in which the customer is enrolled. Links to the program definition including eligibility criteria and benefit structure.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account enrolled in the assistance program. Links to the customer billing account receiving affordability benefits.',
    `employee_id` BIGINT COMMENT 'System user identifier of the staff member who approved the assistance program application. Supports audit trail and quality assurance review.',
    `billing_employee_id` BIGINT COMMENT 'System user identifier of the staff member who approved the assistance program application. Supports audit trail and quality assurance review.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.billing_rate_schedule. Business justification: Assistance program enrollments typically have associated discounted or subsidized rate schedules that define the benefit structure. Each enrollment should reference the specific rate schedule that app',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Customer assistance programs are often grant-funded (LIHEAP, state low-income programs). Grant compliance reporting requires tracking which enrollments and benefit amounts are funded by which grants f',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Assistance program enrollments often include payment plan arrangements for delinquent balances (e.g., arrearage forgiveness programs that combine rate discounts with payment plans for past-due amounts',
    `annual_benefit_cap` DECIMAL(18,2) COMMENT 'Maximum dollar value of benefits the customer may receive in a single calendar year. Null if no annual cap applies. Expressed in USD. Benefits suspend when current_year_benefit_amount reaches this value.',
    `annual_household_income` DECIMAL(18,2) COMMENT 'Total annual gross income for the customer household in USD. Used to calculate percentage of Federal Poverty Level (FPL) for eligibility determination. Confidential financial information.',
    `application_date` DATE COMMENT 'Date the customer submitted their initial assistance program application. May precede enrollment_date if application review and approval took time.',
    `approval_date` DATE COMMENT 'Date the assistance program application was approved by the utility. Typically precedes or equals enrollment_date.',
    `arrearage_forgiveness_balance` DECIMAL(18,2) COMMENT 'Remaining balance of past-due charges eligible for forgiveness under the assistance program. Decreases as customer makes on-time payments per arrearage management plan. Expressed in USD.',
    `arrearage_forgiveness_rate` DECIMAL(18,2) COMMENT 'Percentage of on-time payment amount that is applied to arrearage forgiveness (e.g., 1:1 match means 100.00). Used in arrearage management programs where consistent payment earns debt reduction.',
    `auto_recertification_eligible` BOOLEAN COMMENT 'Indicates whether the customer is eligible for automatic recertification without submitting new documentation. True if categorical eligibility or data-sharing agreement allows automated reverification.',
    `benefit_type` STRING COMMENT 'Type of financial benefit provided by the assistance program. Percentage_discount applies a percentage reduction to charges; fixed_credit applies a monthly dollar credit; tiered_rate applies a reduced rate schedule; usage_allowance provides free baseline usage; arrearage_forgiveness reduces past-due balances; combined indicates multiple benefit types.. Valid values are `percentage_discount|fixed_credit|tiered_rate|usage_allowance|arrearage_forgiveness|combined`',
    `categorical_program_name` STRING COMMENT 'Name of the external assistance program used for categorical eligibility verification (e.g., SNAP, Medicaid, SSI, LIHEAP, WIC). Populated when eligibility_basis is categorical_eligibility.',
    `certification_period_months` STRING COMMENT 'Duration in months for which the customers eligibility certification is valid before recertification is required. Typically 12 months per regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this enrollment record was first created in the database. Supports audit trail and data lineage tracking.',
    `cumulative_benefit_amount` DECIMAL(18,2) COMMENT 'Total dollar value of all assistance benefits applied to the customer account since enrollment_date. Expressed in USD. Used for program cost tracking and regulatory reporting.',
    `current_year_benefit_amount` DECIMAL(18,2) COMMENT 'Total dollar value of assistance benefits applied during the current calendar year. Expressed in USD. Reset to zero on January 1st. Used for annual program cap enforcement and reporting.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to eligible charges when benefit_type is percentage_discount. Expressed as a decimal (e.g., 15.00 for 15% discount). Null for other benefit types.',
    `effective_end_date` DATE COMMENT 'Date on which the assistance program benefits cease to apply. Null for active enrollments with no predetermined end date. Populated upon expiration, termination, or program exit.',
    `effective_start_date` DATE COMMENT 'Date from which the assistance program benefits begin to apply to customer bills. May differ from enrollment_date if retroactive benefits are granted.',
    `eligibility_basis` STRING COMMENT 'Primary basis for program eligibility determination. Income_qualified indicates FPL-based qualification; categorical_eligibility indicates participation in other assistance programs (SNAP, Medicaid, SSI); other values indicate special eligibility categories per program rules. [ENUM-REF-CANDIDATE: income_qualified|categorical_eligibility|senior_citizen|disability|veteran|medical_baseline|other — 7 candidates stripped; promote to reference product]',
    `enrollment_channel` STRING COMMENT 'Channel through which the customer submitted their assistance program application. Used to track enrollment source effectiveness and optimize outreach strategies. [ENUM-REF-CANDIDATE: online_portal|phone|in_person|mail|community_partner|auto_enrollment|other — 7 candidates stripped; promote to reference product]',
    `enrollment_date` DATE COMMENT 'Date the customer was officially enrolled in the assistance program and benefits became effective. Used as the start of the certification period.',
    `enrollment_notes` STRING COMMENT 'Free-text field for case-specific notes, special circumstances, or additional context related to the enrollment. Used by customer service representatives for case management.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment identifier used for customer communication, case tracking, and external reporting. Format typically includes program prefix and sequential number.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the assistance enrollment. Active indicates benefits are being applied; pending indicates application under review; suspended indicates temporary hold; expired indicates certification period ended; terminated indicates voluntary or involuntary exit; pending_recertification indicates annual renewal in progress.. Valid values are `active|pending|suspended|expired|terminated|pending_recertification`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the enrollment record was created in the system. Supports audit trail and regulatory reporting requirements.',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'Customer household income expressed as a percentage of the Federal Poverty Level (FPL) for their household size. Used to determine program tier eligibility (e.g., 0-50% FPL, 51-100% FPL, 101-200% FPL).',
    `household_size` STRING COMMENT 'Number of individuals in the customer household. Used in conjunction with household income to determine eligibility based on Federal Poverty Level (FPL) thresholds.',
    `income_verification_date` DATE COMMENT 'Date on which income documentation was verified and approved. Used to determine when reverification is required per program rules.',
    `income_verification_status` STRING COMMENT 'Status of income documentation verification for eligibility determination. Verified indicates documentation approved; pending indicates under review; not_required indicates categorical eligibility; failed indicates documentation rejected; expired indicates reverification needed.. Valid values are `verified|pending|not_required|failed|expired`',
    `language_preference` STRING COMMENT 'Customers preferred language for assistance program communications. Three-letter ISO 639-2 language code. Used to ensure culturally and linguistically appropriate outreach. [ENUM-REF-CANDIDATE: ENG|SPA|CHI|VIE|KOR|RUS|TGL|FRE|other — 9 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this enrollment record was most recently updated. Supports audit trail and change tracking for regulatory compliance.',
    `last_recertification_date` DATE COMMENT 'Date of the most recent successful recertification event. Null for initial enrollments that have not yet recertified. Used to track compliance with annual recertification requirements.',
    `lifetime_benefit_cap` DECIMAL(18,2) COMMENT 'Maximum total dollar value of benefits the customer may receive over the lifetime of their enrollment. Null if no lifetime cap applies. Expressed in USD. Enrollment terminates when cumulative_benefit_amount reaches this value.',
    `monthly_credit_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount credited to the customer account each billing cycle when benefit_type is fixed_credit. Expressed in USD. Null for other benefit types.',
    `notification_sent_date` DATE COMMENT 'Date the most recent enrollment-related notification was sent to the customer (e.g., recertification reminder, approval notice, termination notice). Used to track customer communication compliance.',
    `notification_type` STRING COMMENT 'Type of the most recent notification sent to the customer. Used in conjunction with notification_sent_date to track communication history.. Valid values are `approval|recertification_reminder|expiration_warning|termination|benefit_change|other`',
    `recertification_due_date` DATE COMMENT 'Date by which the customer must complete annual recertification to maintain enrollment. Calculated as enrollment_date plus certification_period_months. Triggers customer notification workflow.',
    `special_needs_indicator` BOOLEAN COMMENT 'Indicates whether the customer has documented special needs (medical baseline, life support equipment, disability) that may qualify for enhanced program benefits or protections. Confidential information.',
    `termination_date` DATE COMMENT 'Date the enrollment was terminated. Null for active enrollments. Populated when enrollment_status changes to terminated or expired.',
    `termination_reason` STRING COMMENT 'Reason for enrollment termination. Used for program retention analysis and regulatory reporting. Null for active enrollments. [ENUM-REF-CANDIDATE: customer_request|income_ineligible|failed_recertification|moved_out_of_service_area|account_closed|program_ended|fraud|other — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_billing_assistance_enrollment PRIMARY KEY(`billing_assistance_enrollment_id`)
) COMMENT 'Customer enrollment record in a utility assistance or low-income rate program. Captures enrolled billing account, assistance program, enrollment date, expiration date, annual recertification date, income verification status, benefit amount applied, cumulative benefit received, enrollment status (active, expired, pending recertification, terminated), and enrollment channel. Tracks the full lifecycle of customer participation in affordability programs and supports regulatory reporting on program utilization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`dispute` (
    `dispute_id` BIGINT COMMENT 'Unique identifier for the billing dispute record. Primary key.',
    `adjustment_id` BIGINT COMMENT 'Reference to the billing adjustment transaction created as a result of the dispute resolution.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: Disputes often reference specific contaminant results (lead exceedances, DBP levels, copper). Linking to the exact analytical result provides precise documentation for dispute resolution, regulatory r',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer account that initiated the dispute.',
    `collection_notice_id` BIGINT COMMENT 'Foreign key linking to billing.collection_notice. Business justification: Disputes are often triggered by collection notices - customers receive a notice and contest the charges. Each dispute should optionally reference the collection notice that triggered it for workflow t',
    `person_id` BIGINT COMMENT 'Reference to the specific person associated with the account who initiated or is the primary contact for the dispute.',
    `employee_id` BIGINT COMMENT 'Reference to the customer service representative or case worker assigned to investigate and resolve the dispute.',
    `dispute_employee_id` BIGINT COMMENT 'Reference to the customer service representative or case worker assigned to investigate and resolve the dispute.',
    `order_id` BIGINT COMMENT 'Foreign key linking to service.service_order. Business justification: Billing disputes often trigger investigation service orders (meter accuracy tests, leak inspections, pressure checks). Dispute resolution workflow requires linking the dispute case to the field servic',
    `invoice_id` BIGINT COMMENT 'Reference to the specific invoice being disputed by the customer.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Water quality disputes (lead, taste/odor, contamination) trigger verification sampling. Dispute resolution requires linking to the lab sample that confirmed or refuted the customers claim. Essential',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Customers dispute charges during service outages caused by main breaks. Dispute resolution requires verifying the customer was affected by the break (address/pressure zone match, outage duration). Dis',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Customer disputes often involve specific assets: meter accuracy challenges, service line responsibility questions, infrastructure failure impacts. Required for meter test request tracking, asset-relat',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: High-bill disputes trigger service line investigations (meter_test_requested_flag, leak verification, material testing). Dispute resolution workflows require direct reference to the service line under',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Quality-based disputes require specific test results (lead levels, chlorine residual, contaminants) to validate claims and determine credit eligibility. Critical for regulatory compliance, customer se',
    `treatment_violation_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_violation. Business justification: Customer disputes about water quality, taste, or odor issues must reference treatment violations when applicable for proper investigation, regulatory compliance tracking, and public notification coord',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Customer disputes about water quality (taste, odor, discoloration, health concerns) require linking to the specific sample collected at their location. Standard dispute resolution process requires lab',
    `channel` STRING COMMENT 'Communication channel through which the customer submitted the dispute. [ENUM-REF-CANDIDATE: phone|email|web_portal|mobile_app|in_person|mail|social_media — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the dispute record was first created in the database.',
    `credit_issued_amount` DECIMAL(18,2) COMMENT 'Dollar amount of credit or adjustment applied to the customer account as a result of the dispute resolution.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `customer_satisfaction_rating` STRING COMMENT 'Customer-provided satisfaction score for the dispute resolution process, typically on a scale of 1-5 or 1-10.',
    `dispute_date` DATE COMMENT 'Date when the customer formally initiated the dispute or inquiry.',
    `dispute_number` STRING COMMENT 'Human-readable unique dispute case number assigned for tracking and customer reference. Format: DSP-YYYYNNNN.. Valid values are `^DSP-[0-9]{8}$`',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute case in the resolution workflow. [ENUM-REF-CANDIDATE: open|under_investigation|pending_customer_response|resolved|closed|escalated|withdrawn — 7 candidates stripped; promote to reference product]',
    `dispute_timestamp` TIMESTAMP COMMENT 'Precise date and time when the dispute was logged in the system.',
    `dispute_type` STRING COMMENT 'Classification of the dispute based on the nature of the customer complaint or inquiry. [ENUM-REF-CANDIDATE: high_bill_complaint|estimated_bill_dispute|rate_classification_dispute|leak_adjustment_request|meter_accuracy_dispute|billing_error|service_quality_complaint|unauthorized_charges — 8 candidates stripped; promote to reference product]',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total dollar amount being contested by the customer on the invoice.',
    `escalation_date` DATE COMMENT 'Date when the dispute was escalated to a higher authority or regulatory body.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up action or customer contact related to the dispute.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicator of whether additional follow-up action is required after initial resolution.',
    `investigation_notes` STRING COMMENT 'Internal notes and findings documented by the investigator during the dispute resolution process.',
    `investigation_start_date` DATE COMMENT 'Date when formal investigation of the dispute began.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the dispute record was last updated or modified.',
    `leak_adjustment_approved_flag` BOOLEAN COMMENT 'Indicator of whether a leak adjustment was approved and applied to the customer account.',
    `leak_adjustment_gallons` DECIMAL(18,2) COMMENT 'Volume of water in gallons for which a leak adjustment credit was applied.',
    `meter_test_requested_flag` BOOLEAN COMMENT 'Indicator of whether the customer requested a meter accuracy test as part of the dispute investigation.',
    `meter_test_result` STRING COMMENT 'Outcome of the meter accuracy test if one was conducted as part of the dispute investigation.. Valid values are `passed|failed|not_tested|pending`',
    `priority_level` STRING COMMENT 'Priority classification assigned to the dispute based on severity, customer segment, or regulatory requirements.. Valid values are `low|medium|high|urgent`',
    `puc_complaint_number` STRING COMMENT 'Official complaint case number assigned by the Public Utilities Commission if the dispute was escalated to the regulatory authority.',
    `reason` STRING COMMENT 'Detailed explanation provided by the customer describing why they are disputing the charges.',
    `regulatory_escalation_flag` BOOLEAN COMMENT 'Indicator of whether the dispute was escalated to a regulatory body such as the Public Utilities Commission (PUC).',
    `resolution_date` DATE COMMENT 'Date when the dispute was formally resolved or closed.',
    `resolution_notes` STRING COMMENT 'Detailed explanation of how the dispute was resolved and the rationale for the decision.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the dispute resolution was completed and recorded.',
    `resolution_type` STRING COMMENT 'Classification of the action taken to resolve the dispute. [ENUM-REF-CANDIDATE: credit_issued|bill_corrected|no_adjustment|payment_plan_offered|meter_test_scheduled|rate_reclassification|customer_education|partial_credit — 8 candidates stripped; promote to reference product]',
    `sla_actual_resolution_hours` STRING COMMENT 'Actual number of hours taken to resolve the dispute, measured from dispute initiation to resolution.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether the dispute resolution exceeded the SLA target timeframe.',
    `sla_target_resolution_hours` STRING COMMENT 'Target number of hours within which the dispute should be resolved according to the applicable Service Level Agreement.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Formal billing dispute or inquiry record initiated by a customer contesting charges on their utility account. Captures dispute type (high bill complaint, estimated bill dispute, rate classification dispute, leak adjustment request, meter accuracy dispute), dispute date, disputed invoice reference, disputed amount, dispute status (open, under investigation, resolved, escalated), resolution type, resolution date, credit issued, and regulatory escalation flag (PUC complaint). Supports customer service workflows in Microsoft Dynamics 365 and Oracle CC&B.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique identifier for the write-off record. Primary key for the write-off transaction.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer account from which the balance is being written off.',
    `collection_notice_id` BIGINT COMMENT 'Foreign key linking to billing.collection_notice. Business justification: Write-offs are the final step in the collections workflow after collection notices fail to generate payment. Each write-off should reference the final collection notice issued before the write-off dec',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Write-offs create journal entries to remove uncollectible AR from books. GASB compliance and financial reporting require tracing write-offs to GL postings for bad debt expense recognition and AR valua',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Write-offs often occur after payment plan failure (customer breaks the plan and remaining balance becomes uncollectible). Each write-off should optionally reference the failed payment plan for collect',
    `employee_id` BIGINT COMMENT 'System user identifier of the person who approved the write-off transaction.',
    `write_created_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who initiated the write-off transaction.',
    `write_employee_id` BIGINT COMMENT 'System user identifier of the person who approved the write-off transaction.',
    `approval_authority` STRING COMMENT 'Name or identifier of the authorized person or role who approved the write-off transaction. Typically requires manager or director level approval based on dollar threshold.',
    `approval_date` DATE COMMENT 'Date on which the write-off was formally approved by authorized personnel.',
    `batch_number` STRING COMMENT 'Identifier for the batch processing run in which this write-off was included, used for grouping and reconciliation of multiple write-offs processed together.',
    `collection_agency_name` STRING COMMENT 'Name of the external collection agency to which the account was referred, if applicable.',
    `collection_agency_referral_indicator` BOOLEAN COMMENT 'Flag indicating whether the account was referred to an external collection agency prior to write-off. True indicates referral occurred, False indicates no external collection effort.',
    `collection_referral_date` DATE COMMENT 'Date on which the account was referred to external collections, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the write-off record was first created in the system, used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the write-off amount. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `days_outstanding` STRING COMMENT 'Number of days between the original invoice date and the write-off date, indicating how long the balance remained uncollected.',
    `fee_charge_amount` DECIMAL(18,2) COMMENT 'Portion of the write-off amount attributable to service fees, connection fees, meter fees, and other non-consumption charges.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the write-off was recorded, typically 1-12.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the write-off was recorded, used for annual financial reporting and bad debt expense trending.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the bad debt expense is posted. Typically maps to a bad debt expense account in the chart of accounts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the write-off record was last updated, used for tracking changes and audit trail.',
    `notes` STRING COMMENT 'Additional free-form notes or comments regarding the write-off transaction, including case history, collection attempts, or special circumstances.',
    `original_invoice_date` DATE COMMENT 'Date of the oldest invoice included in the write-off amount, used to calculate aging and statute of limitations.',
    `other_charge_amount` DECIMAL(18,2) COMMENT 'Portion of the write-off amount attributable to miscellaneous charges not classified in standard categories.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Portion of the write-off amount attributable to late payment penalties and interest charges.',
    `reason_code` STRING COMMENT 'Standardized code indicating the primary reason for writing off the account balance. Bankruptcy indicates customer filed for bankruptcy protection, deceased indicates customer passed away with no estate recovery, skip indicates customer moved with no forwarding address, hardship indicates financial hardship or assistance program, statute_limitation indicates debt exceeded legal collection period, uncollectible indicates exhausted all collection efforts.. Valid values are `bankruptcy|deceased|skip|hardship|statute_limitation|uncollectible`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances leading to the write-off decision, including any supporting documentation references or case notes.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Dollar amount subsequently recovered after the write-off was posted. Applies when a previously written-off balance is collected through bankruptcy proceedings, estate settlement, or renewed collection efforts.',
    `recovery_date` DATE COMMENT 'Date on which a recovery payment was received for a previously written-off balance.',
    `revenue_class` STRING COMMENT 'Revenue classification code for financial reporting segmentation, such as residential, commercial, industrial, or governmental.',
    `reversal_date` DATE COMMENT 'Date on which the write-off transaction was reversed, if applicable.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether the write-off has been reversed. True indicates the write-off was reversed due to error correction or subsequent recovery, False indicates the write-off remains in effect.',
    `reversal_reason` STRING COMMENT 'Explanation of why the write-off was reversed, such as error correction, customer payment received, or bankruptcy discharge denied.',
    `service_address` STRING COMMENT 'Physical service address associated with the written-off account, used for geographic analysis of write-off patterns and collection effectiveness.',
    `stormwater_charge_amount` DECIMAL(18,2) COMMENT 'Portion of the write-off amount attributable to stormwater management fees.',
    `total_write_off_amount` DECIMAL(18,2) COMMENT 'Total dollar amount written off across all charge categories. Sum of water, wastewater, stormwater, fees, penalties, and other charges being removed from accounts receivable.',
    `wastewater_charge_amount` DECIMAL(18,2) COMMENT 'Portion of the write-off amount attributable to wastewater treatment and collection charges.',
    `water_charge_amount` DECIMAL(18,2) COMMENT 'Portion of the write-off amount attributable to water consumption charges. Supports revenue class segmentation for financial reporting.',
    `write_off_date` DATE COMMENT 'The date on which the uncollectible balance was officially written off from accounts receivable. This is the business event date for revenue recognition and bad debt expense reporting.',
    `write_off_number` STRING COMMENT 'Business-facing unique identifier for the write-off transaction, typically formatted as WO-YYYY-NNNNNN for external reference and audit trail.',
    `write_off_status` STRING COMMENT 'Current lifecycle status of the write-off transaction. Pending indicates awaiting approval, approved indicates authorized but not yet posted to GL, posted indicates completed and reflected in financial statements, reversed indicates subsequently recovered or corrected, cancelled indicates voided before posting.. Valid values are `pending|approved|posted|reversed|cancelled`',
    `write_off_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the write-off transaction was recorded in the system, including time zone information.',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Record of an uncollectible account balance written off from the utilitys accounts receivable. Captures write-off date, write-off amount by charge category (water, wastewater, stormwater, fees), write-off reason (bankruptcy, skip, hardship, statute of limitations), approval authority, collection agency referral status, recovery amount if subsequently collected, and write-off reversal status. Supports GAAP/GASB revenue recognition and bad debt expense reporting for municipal utility financial statements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`lien` (
    `lien_id` BIGINT COMMENT 'Unique identifier for the property lien record. Primary key for the lien entity.',
    `billing_account_id` BIGINT COMMENT 'Reference to the delinquent customer account for which the lien was filed. Links to the customer account that accumulated unpaid utility charges.',
    `delinquency_notice_id` BIGINT COMMENT 'Reference to the final delinquency notice or demand letter that preceded the lien filing. Links to the collections notice chain.',
    `employee_id` BIGINT COMMENT 'Identifier of the utility staff member or system user who initiated and filed the lien. Used for audit and accountability.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Lien filings generate journal entries for legal costs, filing fees, or receivable reclassification to secured status. Finance teams track lien-related accounting impacts for cost recovery and financia',
    `lien_released_by_user_employee_id` BIGINT COMMENT 'Identifier of the utility staff member or system user who processed the lien release. Null if lien remains active.',
    `parcel_id` BIGINT COMMENT 'County assessor parcel number or tax parcel identifier for the real property against which the lien is filed. Used for legal property identification.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.service_point. Business justification: Liens are filed against properties for delinquent water/wastewater charges at specific service locations. Property lien administration requires linking the lien to the service point where unpaid servi',
    `primary_lien_employee_id` BIGINT COMMENT 'Identifier of the utility staff member or system user who initiated and filed the lien. Used for audit and accountability.',
    `premise_id` BIGINT COMMENT 'County assessor parcel number or tax parcel identifier for the real property against which the lien is filed. Used for legal property identification.',
    `sewer_service_connection_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_service_connection. Business justification: Liens filed for delinquent wastewater charges must reference the specific sewer service connection to establish legal basis for debt. Required for lien filing documentation, property title searches, l',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Liens may be placed on utility-owned assets or reference infrastructure serving the property (distinct from premise_id for property). Required for utility asset encumbrance tracking, infrastructure li',
    `administrative_fee_amount` DECIMAL(18,2) COMMENT 'Administrative costs and filing fees associated with preparing and recording the lien, recoverable from the property owner.',
    `amount` DECIMAL(18,2) COMMENT 'Total dollar amount of unpaid utility charges, penalties, interest, and administrative fees for which the lien is filed. Represents the principal claim against the property.',
    `billing_period_end_date` DATE COMMENT 'End date of the most recent billing period included in the unpaid charges covered by this lien.',
    `billing_period_start_date` DATE COMMENT 'Start date of the earliest billing period included in the unpaid charges covered by this lien.',
    `county_code` STRING COMMENT 'Code or identifier for the county where the lien was filed. Supports multi-county utility service territories.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lien record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `effective_date` DATE COMMENT 'Date from which the lien becomes legally enforceable and attaches to the property. Determines priority relative to other encumbrances.',
    `expiration_date` DATE COMMENT 'Date the lien expires if not renewed or enforced, per statutory limitations. Null for liens with indefinite duration under state law.',
    `filing_date` DATE COMMENT 'Date the lien was officially filed with the county recorder or appropriate legal authority. Establishes lien priority and legal enforceability.',
    `foreclosure_case_number` STRING COMMENT 'Court case number or legal proceeding identifier for foreclosure action related to this lien. Null if no foreclosure filed.',
    `foreclosure_date` DATE COMMENT 'Date foreclosure proceedings were initiated or completed on the property to satisfy the lien. Null if no foreclosure action taken.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Accrued interest on the delinquent balance calculated per statutory or ordinance-defined interest rate.',
    `is_super_priority` BOOLEAN COMMENT 'Indicates whether this lien has super-priority status under state law, meaning it takes precedence over mortgage liens and other senior encumbrances. True if super-priority applies.',
    `jurisdiction_code` STRING COMMENT 'Code identifying the legal jurisdiction or municipality under whose authority the lien was filed. Determines applicable statutes and procedures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lien record was last updated. Used for audit trail and change tracking.',
    `legal_description` STRING COMMENT 'Full legal description of the property as recorded in the deed, including lot, block, subdivision, metes and bounds, or other legal land description. Required for lien enforceability.',
    `lien_number` STRING COMMENT 'Externally-visible unique business identifier for the lien, used in legal filings and correspondence. May follow municipal or county recorder numbering conventions.',
    `lien_status` STRING COMMENT 'Current lifecycle status of the lien. Tracks progression from initial filing through resolution or foreclosure. [ENUM-REF-CANDIDATE: pending|filed|recorded|released|satisfied|foreclosed|withdrawn — 7 candidates stripped; promote to reference product]',
    `lien_type` STRING COMMENT 'Classification of the lien based on the type of utility service charges that are unpaid. Determines legal authority and priority under state statute.. Valid values are `water_lien|wastewater_lien|utility_lien|stormwater_lien|combined_utility_lien|special_assessment_lien`',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the lien, including special circumstances, payment arrangements, legal actions, or other relevant information.',
    `notice_method` STRING COMMENT 'Method by which the lien notice was delivered to the property owner. Must comply with statutory notice requirements.. Valid values are `certified_mail|first_class_mail|personal_service|publication|electronic`',
    `notice_sent_date` DATE COMMENT 'Date the notice of intent to file lien was sent to the property owner. Required pre-filing notice period per state statute.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Late payment penalties and delinquency fees assessed on the unpaid balance prior to lien filing.',
    `principal_amount` DECIMAL(18,2) COMMENT 'Original unpaid utility charges amount excluding penalties, interest, and fees. Base delinquent balance that triggered the lien.',
    `priority_rank` STRING COMMENT 'Legal priority ranking of this lien relative to other encumbrances on the property. Lower numbers indicate higher priority. Determined by state statute and recording date.',
    `property_address` STRING COMMENT 'Full street address of the property subject to the lien. Used for legal notice and property identification.',
    `property_owner_name` STRING COMMENT 'Legal name of the property owner as recorded on the deed or county assessor records at the time of lien filing.',
    `recorder_book_number` STRING COMMENT 'Book number in the county recorders lien index where the lien is recorded. Legacy identifier in jurisdictions using book-and-page indexing.',
    `recorder_page_number` STRING COMMENT 'Page number in the county recorders lien index where the lien is recorded. Legacy identifier in jurisdictions using book-and-page indexing.',
    `recorder_reference_number` STRING COMMENT 'Official document number or instrument number assigned by the county recorder when the lien was recorded. Used for legal lookup and verification.',
    `recording_date` DATE COMMENT 'Date the lien was officially recorded in the county land records system. May differ from filing date depending on recorder processing time.',
    `release_amount` DECIMAL(18,2) COMMENT 'Total amount paid or settled to release the lien. May differ from original lien amount if partial settlement or additional interest accrued.',
    `release_date` DATE COMMENT 'Date the lien was released or satisfied, typically after full payment of the delinquent balance. Null if lien remains active.',
    `release_reason_code` STRING COMMENT 'Code indicating the reason the lien was released. Null if lien remains active.. Valid values are `paid_in_full|payment_plan_satisfied|bankruptcy_discharge|property_sold|administrative_error|statute_expired`',
    CONSTRAINT pk_lien PRIMARY KEY(`lien_id`)
) COMMENT 'Property lien record filed against a parcel for unpaid utility charges, used as a collections enforcement mechanism for delinquent accounts. Captures lien filing date, lien amount, lien type (water lien, utility lien), property parcel ID, county recorder reference number, lien status (filed, released, foreclosed), release date, and associated delinquency notice chain. Supports municipal utility authority to place liens on real property for unpaid water and wastewater charges per state statute.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` (
    `revenue_recognition_event_id` BIGINT COMMENT 'Unique identifier for the revenue recognition event record. Primary key.',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.adjustment. Business justification: Billing adjustments are revenue-impacting transactions that trigger revenue recognition events (credits reduce revenue, debits increase revenue). Each revenue recognition event triggered by an adjustm',
    `agreement_id` BIGINT COMMENT 'Reference to the service agreement associated with this revenue recognition event.',
    `ar_transaction_id` BIGINT COMMENT 'Unique identifier of the transaction in the source system that triggered this revenue recognition event.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account for which revenue is being recognized.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Reference to the rate schedule used to calculate the revenue amount for this event.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Capital project revenues (connection fees, capacity charges, developer contributions, system development charges) must be recognized and tracked to specific projects for regulatory compliance, capital',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Revenue is recognized to specific funds (water enterprise, wastewater, stormwater). Fund accounting and GASB reporting require tracking which fund receives each revenue transaction for proper fund bal',
    `invoice_id` BIGINT COMMENT 'Reference to the source invoice that triggered this revenue recognition event.',
    `invoice_line_id` BIGINT COMMENT 'Reference to the specific invoice line item for which revenue is being recognized.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Revenue recognition events generate journal entries for GL posting. Financial close process requires linking revenue events to journal entries for revenue reconciliation, accrual validation, and GASB',
    `payment_id` BIGINT COMMENT 'Reference to the payment transaction associated with this revenue recognition event, if applicable.',
    `employee_id` BIGINT COMMENT 'User ID of the person or system account that posted this revenue recognition event to the general ledger.',
    `primary_reversal_revenue_recognition_event_id` BIGINT COMMENT 'Self-referencing FK on revenue_recognition_event (reversal_revenue_recognition_event_id)',
    `revenue_employee_id` BIGINT COMMENT 'Reference to the user who approved this revenue recognition event, if approval is required.',
    `revenue_original_event_id` BIGINT COMMENT 'Reference to the original revenue recognition event that is being reversed, if this is a reversal event.',
    `revenue_reversed_event_id` BIGINT COMMENT 'Reference to the original revenue recognition event that this event reverses, if applicable.',
    `write_off_id` BIGINT COMMENT 'Foreign key linking to billing.write_off. Business justification: Write-offs are revenue-impacting transactions that trigger revenue recognition events (bad debt expense recognition). Each revenue recognition event triggered by a write-off should reference the sourc',
    `accounting_period` STRING COMMENT 'Fiscal period to which this revenue recognition event is assigned, typically in YYYY-MM or YYYYPP format.',
    `accrued_revenue_amount` DECIMAL(18,2) COMMENT 'Amount of revenue accrued for services rendered but not yet invoiced or collected.',
    `adjustment_indicator` BOOLEAN COMMENT 'Flag indicating whether this revenue recognition event is an adjustment to previously recognized revenue.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for adjusting previously recognized revenue.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition event requires supervisory approval before posting to the general ledger.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this revenue recognition event was approved for posting.',
    `batch_number` STRING COMMENT 'Identifier of the batch process that created or posted this revenue recognition event, if processed in batch mode.',
    `charge_type` STRING COMMENT 'Type of charge for which revenue is being recognized, such as consumption, base, surcharge, or fee.',
    `consumption_uom` STRING COMMENT 'Unit of measure for the consumption volume.. Valid values are `gallons|cubic_feet|cubic_meters|liters`',
    `consumption_volume` DECIMAL(18,2) COMMENT 'Volume of water or wastewater consumed during the service period for which revenue is recognized.',
    `cost_center` STRING COMMENT 'Cost center or organizational unit responsible for the revenue, used for internal management accounting.',
    `cost_center_code` STRING COMMENT 'Cost center code for internal financial tracking and allocation of revenue.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this revenue recognition event record was first created in the data warehouse.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'Amount of revenue deferred to future periods, representing unearned revenue at the recognition date.',
    `document_type` STRING COMMENT 'Type of financial document in the ERP system (e.g., invoice document, payment document, adjustment document).',
    `event_number` STRING COMMENT 'Business-readable unique identifier for the revenue recognition event, typically system-generated.',
    `event_status` STRING COMMENT 'Current lifecycle status of the revenue recognition event in the financial system.. Valid values are `pending|posted|reconciled|reversed|error`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the revenue recognition event occurred in the source system (Oracle CC&B or payment processor).',
    `event_type` STRING COMMENT 'Type of accounting event that triggered revenue recognition: invoice posted, payment received, adjustment applied, write-off recorded, reversal posted, or accrual recorded.. Valid values are `invoice_posted|payment_received|adjustment_applied|write_off_recorded|reversal_posted|accrual_recorded`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year in which the revenue is recognized.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this revenue recognition event belongs.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the revenue is posted in SAP FI/CO or Tyler Munis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this revenue recognition event record was last updated in the data warehouse.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this revenue recognition event, typically used for exceptions or special handling.',
    `posting_date` DATE COMMENT 'Date when the revenue recognition event was posted to the general ledger in SAP FI/CO or Tyler Munis.',
    `recognition_date` DATE COMMENT 'The date on which revenue is recognized for accounting purposes, following GASB revenue recognition principles.',
    `recognition_status` STRING COMMENT 'Current lifecycle status of the revenue recognition event in the accounting workflow.. Valid values are `pending|recognized|posted|reversed|cancelled`',
    `recognition_timestamp` TIMESTAMP COMMENT 'Precise date and time when the revenue recognition event was recorded in the system.',
    `recognized_revenue_amount` DECIMAL(18,2) COMMENT 'Actual revenue amount recognized in the general ledger for this event, after any allocations or adjustments.',
    `reconciliation_date` DATE COMMENT 'Date when the revenue recognition event was successfully reconciled between billing and financial systems.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between the billing system (Oracle CC&B) and the financial system (SAP/Munis) for this revenue event.. Valid values are `pending|reconciled|variance|exception`',
    `regulatory_reporting_category` STRING COMMENT 'Category used for regulatory reporting and compliance with state and federal requirements.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Total amount of revenue recognized in this event before any adjustments or allocations.',
    `revenue_class` STRING COMMENT 'Classification of revenue type for regulatory and financial reporting (e.g., water sales, wastewater service, stormwater fees, connection fees).',
    `reversal_date` DATE COMMENT 'Date on which the revenue recognition event was reversed.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this revenue recognition event is a reversal of a previously posted event.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing a revenue recognition event (e.g., billing error, payment reversal, adjustment).',
    `service_period_end_date` DATE COMMENT 'Ending date of the service period for which revenue is being recognized.',
    `service_period_start_date` DATE COMMENT 'Beginning date of the service period for which revenue is being recognized.',
    `service_type` STRING COMMENT 'Type of utility service for which revenue is being recognized. [ENUM-REF-CANDIDATE: water|wastewater|stormwater|reclaimed_water|bulk_water|connection|other — 7 candidates stripped; promote to reference product]',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the revenue recognition event before any adjustments or allocations.',
    `unbilled_revenue_amount` DECIMAL(18,2) COMMENT 'Amount of revenue recognized for services provided but not yet billed to the customer.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between expected and actual revenue amounts during reconciliation, if any variance exists.',
    CONSTRAINT pk_revenue_recognition_event PRIMARY KEY(`revenue_recognition_event_id`)
) COMMENT 'Master reference table for revenue_recognition_event. ';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` (
    `rate_tier_id` BIGINT COMMENT 'Primary key for rate_tier',
    `billing_rate_schedule_id` BIGINT COMMENT 'add column billing_rate_schedule_id (BIGINT) with FK to billing.billing_rate_schedule.billing_rate_schedule_id - rate tiers belong to a specific rate schedule and cannot exist independently',
    `preceding_rate_tier_id` BIGINT COMMENT 'Self-referencing FK on rate_tier (preceding_rate_tier_id)',
    `consumption_max` DECIMAL(18,2) COMMENT 'Upper bound of consumption for which this tier applies; null for no upper limit.',
    `consumption_min` DECIMAL(18,2) COMMENT 'Lower bound of consumption (in unit_of_measure) for which this tier applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tier record was first created in the system.',
    `rate_tier_description` STRING COMMENT 'Detailed description of the tier, including any special conditions.',
    `effective_from` DATE COMMENT 'Date when the tier becomes effective for billing.',
    `effective_until` DATE COMMENT 'Date when the tier expires; null if open‑ended.',
    `fixed_charge` DECIMAL(18,2) COMMENT 'Flat fee applied for this tier regardless of consumption.',
    `rate_per_unit` DECIMAL(18,2) COMMENT 'Price charged per unit of consumption within this tier (currency per unit).',
    `rate_tier_status` STRING COMMENT 'Current lifecycle status of the tier.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Amount of surcharge applied when surcharge_applicable is true.',
    `surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a surcharge is applied to this tier.',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the tier is exempt from sales tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the tier when not tax‑exempt.',
    `tier_code` STRING COMMENT 'Short alphanumeric code used to identify the tier in billing systems.',
    `tier_name` STRING COMMENT 'Human‑readable name of the rate tier (e.g., "Residential Tier 1").',
    `tier_type` STRING COMMENT 'Category of customers or service that the tier applies to.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for consumption thresholds and rates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tier record.',
    `variable_charge` DECIMAL(18,2) COMMENT 'Additional variable component (e.g., service fee) applied per billing period.',
    CONSTRAINT pk_rate_tier PRIMARY KEY(`rate_tier_id`)
) COMMENT 'Master reference table for rate_tier. Referenced by rate_tier_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` (
    `delinquency_notice_id` BIGINT COMMENT 'Primary key for delinquency_notice',
    `billing_account_id` BIGINT COMMENT 'Identifier of the utility account associated with the delinquent balance.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer to whom the delinquency notice is addressed.',
    `employee_id` BIGINT COMMENT 'System user identifier of the employee or process that generated the notice.',
    `payment_plan_id` BIGINT COMMENT 'Identifier of an agreed payment schedule linked to this notice, if any.',
    `prior_delinquency_notice_id` BIGINT COMMENT 'Self-referencing FK on delinquency_notice (prior_delinquency_notice_id)',
    `amount_due` DECIMAL(18,2) COMMENT 'Original delinquent balance before penalties or adjustments.',
    `collection_agency_flag` BOOLEAN COMMENT 'True if the delinquent account has been forwarded to a third‑party collection agency.',
    `collection_agency_name` STRING COMMENT 'Name of the external agency handling the collection for this notice.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delinquency notice record was first inserted into the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency for the amounts on the notice.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has formally disputed the notice.',
    `dispute_reason` STRING COMMENT 'Narrative provided by the customer explaining the basis of the dispute.',
    `due_date` DATE COMMENT 'Calendar date by which the outstanding amount must be paid to avoid further action.',
    `escalation_level` STRING COMMENT 'Numeric indicator of how many escalation steps have been applied to the delinquency.',
    `generated_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the notice was created in the system.',
    `legal_action_date` DATE COMMENT 'Date on which legal action was formally started against the customer.',
    `legal_action_flag` BOOLEAN COMMENT 'Indicates whether legal proceedings have been initiated for the delinquent balance.',
    `notes` STRING COMMENT 'Optional textual comments added by the billing team for context or special handling.',
    `notice_last_sent_date` DATE COMMENT 'Date of the most recent re‑send of the notice after the initial send.',
    `notice_number` STRING COMMENT 'External reference number assigned to the notice for customer communication and tracking.',
    `notice_sent_date` DATE COMMENT 'Date the notice was first mailed or emailed to the customer.',
    `notice_type` STRING COMMENT 'Category of the notice indicating its purpose and severity.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Additional charge applied for late payment, interest, or service fees.',
    `delinquency_notice_status` STRING COMMENT 'Current processing state of the notice within the revenue cycle.',
    `total_due` DECIMAL(18,2) COMMENT 'Sum of principal and penalties representing the amount the customer must pay.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the notice record.',
    CONSTRAINT pk_delinquency_notice PRIMARY KEY(`delinquency_notice_id`)
) COMMENT 'Master reference table for delinquency_notice. Referenced by delinquency_notice_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` (
    `billing_cycle_id` BIGINT COMMENT 'Primary key for billing_cycle',
    `previous_billing_cycle_id` BIGINT COMMENT 'Self-referencing FK on billing_cycle (previous_billing_cycle_id)',
    `territory_id` BIGINT COMMENT 'add column territory_id (BIGINT) with FK to service.territory.territory_id - billing cycles are organized by service territory/route',
    `billing_frequency` STRING COMMENT 'How often billing occurs for this cycle.',
    `billing_period_end` DATE COMMENT 'Last calendar day covered by the billing cycle.',
    `billing_period_start` DATE COMMENT 'First calendar day covered by the billing cycle.',
    `collection_status` STRING COMMENT 'Status of the collection effort for overdue balances.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing cycle record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the amounts.',
    `cycle_code` STRING COMMENT 'External reference code used in invoices and statements to identify the billing cycle.',
    `cycle_type` STRING COMMENT 'Classification of the billing cycle based on its recurrence pattern.',
    `billing_cycle_description` STRING COMMENT 'Free‑form text describing the purpose or special conditions of the billing cycle.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount granted for the billing cycle.',
    `due_date` DATE COMMENT 'Date by which payment for the cycle must be received.',
    `effective_from` DATE COMMENT 'Date when the billing cycle becomes effective.',
    `effective_until` DATE COMMENT 'Date when the billing cycle ends; null for open‑ended cycles.',
    `last_processed_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing cycle was last processed for invoicing or payment.',
    `late_fee_applied` BOOLEAN COMMENT 'Indicates whether a late fee has been assessed for this cycle.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and discounts.',
    `notes` STRING COMMENT 'Supplementary remarks or internal comments related to the billing cycle.',
    `payment_status` STRING COMMENT 'Current payment settlement state for the cycle.',
    `billing_cycle_status` STRING COMMENT 'Current lifecycle status of the billing cycle.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the billing cycle.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross amount billed before taxes, discounts, or adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing cycle record.',
    CONSTRAINT pk_billing_cycle PRIMARY KEY(`billing_cycle_id`)
) COMMENT 'Master reference table for billing_cycle. Referenced by billing_cycle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_tier_id` FOREIGN KEY (`rate_tier_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`rate_tier`(`rate_tier_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_invoice_id` FOREIGN KEY (`payment_invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_reversed_by_payment_id` FOREIGN KEY (`reversed_by_payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_dispute_id` FOREIGN KEY (`payment_dispute_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_invoice_line_item_invoice_line_id` FOREIGN KEY (`payment_invoice_line_item_invoice_line_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_superseded_by_billing_rate_schedule_id` FOREIGN KEY (`superseded_by_billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_original_adjustment_id` FOREIGN KEY (`original_adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_collection_notice_id` FOREIGN KEY (`collection_notice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`collection_notice`(`collection_notice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_collection_notice_id` FOREIGN KEY (`collection_notice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`collection_notice`(`collection_notice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_delinquency_notice_id` FOREIGN KEY (`delinquency_notice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`delinquency_notice`(`delinquency_notice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_primary_reversal_revenue_recognition_event_id` FOREIGN KEY (`primary_reversal_revenue_recognition_event_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_revenue_original_event_id` FOREIGN KEY (`revenue_original_event_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_revenue_reversed_event_id` FOREIGN KEY (`revenue_reversed_event_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_write_off_id` FOREIGN KEY (`write_off_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`write_off`(`write_off_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ADD CONSTRAINT `fk_billing_rate_tier_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ADD CONSTRAINT `fk_billing_rate_tier_preceding_rate_tier_id` FOREIGN KEY (`preceding_rate_tier_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`rate_tier`(`rate_tier_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ADD CONSTRAINT `fk_billing_delinquency_notice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ADD CONSTRAINT `fk_billing_delinquency_notice_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ADD CONSTRAINT `fk_billing_delinquency_notice_prior_delinquency_notice_id` FOREIGN KEY (`prior_delinquency_notice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`delinquency_notice`(`delinquency_notice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ADD CONSTRAINT `fk_billing_billing_cycle_previous_billing_cycle_id` FOREIGN KEY (`previous_billing_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_water_utilities_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `other_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Charges Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `previous_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `print_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Print Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `interval_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Rated Consumption Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_received_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_received_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_received_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `processor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applied By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applied By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_invoice_line_item_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_certificate` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_certificate` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{0,30}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_subdomain' = 'rate_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `superseded_by_billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `base_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|annual');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|superseded|retired');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `conservation_rate_indicator` SET TAGS ('dbx_business_glossary_term' = 'Conservation Rate Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `consumption_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Consumption Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `consumption_unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|kiloliters|hundred_cubic_feet');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|irrigation|municipal|institutional');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `drought_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Drought Surcharge Applicable');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `meter_size_applicability` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Applicability');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `seasonal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'water|wastewater|stormwater|recycled_water|combined');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` SET TAGS ('dbx_subdomain' = 'rate_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `bill_print_label` SET TAGS ('dbx_business_glossary_term' = 'Bill Print Label');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat_amount|per_unit|tiered_block|percentage|formula');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'revenue_adjustments');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Supervisor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_initiated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_initiated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_initiated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `network_isolation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Network Isolation Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Adjustment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `primary_adjustment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Supervisor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `primary_adjustment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `primary_adjustment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `assistance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Assistance Program Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Service Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Generated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` SET TAGS ('dbx_subdomain' = 'rate_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `assistance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Assistance Program Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `annual_benefit_cap` SET TAGS ('dbx_business_glossary_term' = 'Annual Benefit Cap');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `annual_household_income` SET TAGS ('dbx_business_glossary_term' = 'Annual Household Income');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `annual_household_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `annual_household_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `arrearage_forgiveness_balance` SET TAGS ('dbx_business_glossary_term' = 'Arrearage Forgiveness Balance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `arrearage_forgiveness_rate` SET TAGS ('dbx_business_glossary_term' = 'Arrearage Forgiveness Rate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `auto_recertification_eligible` SET TAGS ('dbx_business_glossary_term' = 'Auto-Recertification Eligible Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `benefit_type` SET TAGS ('dbx_value_regex' = 'percentage_discount|fixed_credit|tiered_rate|usage_allowance|arrearage_forgiveness|combined');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `categorical_program_name` SET TAGS ('dbx_business_glossary_term' = 'Categorical Program Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `categorical_program_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `certification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Certification Period in Months');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `cumulative_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Benefit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `current_year_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Year Benefit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `eligibility_basis` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Basis');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|expired|terminated|pending_recertification');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `household_size` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `income_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `income_verification_date` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|not_required|failed|expired');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `last_recertification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recertification Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `lifetime_benefit_cap` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Benefit Cap');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `monthly_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Credit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'approval|recertification_reminder|expiration_warning|termination|benefit_change|other');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `special_needs_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Needs Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `special_needs_indicator` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` SET TAGS ('dbx_subdomain' = 'revenue_adjustments');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `collection_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Notice Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Service Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Dispute Channel');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `credit_issued_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Issued Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `leak_adjustment_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Adjustment Approved Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `leak_adjustment_gallons` SET TAGS ('dbx_business_glossary_term' = 'Leak Adjustment Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `meter_test_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Meter Test Requested Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `meter_test_result` SET TAGS ('dbx_business_glossary_term' = 'Meter Test Result');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `meter_test_result` SET TAGS ('dbx_value_regex' = 'passed|failed|not_tested|pending');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `puc_complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Public Utilities Commission (PUC) Complaint Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `regulatory_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Escalation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `sla_actual_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Resolution Hours');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `sla_target_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Hours');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `collection_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Notice Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `collection_agency_referral_indicator` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Referral Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `collection_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Referral Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `fee_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `original_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `other_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'bankruptcy|deceased|skip|hardship|statute_limitation|uncollectible');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `service_address` SET TAGS ('dbx_business_glossary_term' = 'Service Address');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `service_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `service_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `stormwater_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `total_write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Write-Off Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `wastewater_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `water_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Water Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'pending|approved|posted|reversed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ALTER COLUMN `write_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `lien_id` SET TAGS ('dbx_business_glossary_term' = 'Lien Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `delinquency_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Notice Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Filed By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `lien_released_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Released By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `lien_released_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `lien_released_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Property Parcel Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `primary_lien_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Filed By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `primary_lien_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `primary_lien_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Property Parcel Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `sewer_service_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Service Connection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Utility Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `administrative_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Administrative Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Lien Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `county_code` SET TAGS ('dbx_business_glossary_term' = 'County Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Lien Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lien Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Lien Filing Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `foreclosure_case_number` SET TAGS ('dbx_business_glossary_term' = 'Foreclosure Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `foreclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Foreclosure Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `is_super_priority` SET TAGS ('dbx_business_glossary_term' = 'Super Priority Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Property Legal Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `lien_number` SET TAGS ('dbx_business_glossary_term' = 'Lien Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `lien_status` SET TAGS ('dbx_business_glossary_term' = 'Lien Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `lien_type` SET TAGS ('dbx_business_glossary_term' = 'Lien Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `lien_type` SET TAGS ('dbx_value_regex' = 'water_lien|wastewater_lien|utility_lien|stormwater_lien|combined_utility_lien|special_assessment_lien');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lien Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `notice_method` SET TAGS ('dbx_business_glossary_term' = 'Notice Delivery Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `notice_method` SET TAGS ('dbx_value_regex' = 'certified_mail|first_class_mail|personal_service|publication|electronic');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Lien Notice Sent Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Lien Priority Rank');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `property_address` SET TAGS ('dbx_business_glossary_term' = 'Property Address');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `property_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `property_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Property Owner Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `recorder_book_number` SET TAGS ('dbx_business_glossary_term' = 'Recorder Book Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `recorder_page_number` SET TAGS ('dbx_business_glossary_term' = 'Recorder Page Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `recorder_reference_number` SET TAGS ('dbx_business_glossary_term' = 'County Recorder Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Lien Recording Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `release_amount` SET TAGS ('dbx_business_glossary_term' = 'Lien Release Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Lien Release Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `release_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Lien Release Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ALTER COLUMN `release_reason_code` SET TAGS ('dbx_value_regex' = 'paid_in_full|payment_plan_satisfied|bankruptcy_discharge|property_sold|administrative_error|statute_expired');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'revenue_adjustments');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `primary_reversal_revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Revenue Recognition Event Id');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `primary_reversal_revenue_recognition_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_original_event_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_reversed_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Revenue Recognition Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write Off Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `accrued_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Revenue Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `adjustment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `consumption_uom` SET TAGS ('dbx_business_glossary_term' = 'Consumption Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `consumption_uom` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|liters');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `consumption_volume` SET TAGS ('dbx_business_glossary_term' = 'Consumption Volume');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reconciled|reversed|error');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'invoice_posted|payment_received|adjustment_applied|write_off_recorded|reversal_posted|accrual_recorded');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'pending|recognized|posted|reversed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognized_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Reconciliation Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|variance|exception');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `unbilled_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Unbilled Revenue Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` SET TAGS ('dbx_subdomain' = 'rate_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `preceding_rate_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Preceding Rate Tier Id');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `preceding_rate_tier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `consumption_max` SET TAGS ('dbx_business_glossary_term' = 'Consumption Max');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `consumption_min` SET TAGS ('dbx_business_glossary_term' = 'Consumption Min');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `fixed_charge` SET TAGS ('dbx_business_glossary_term' = 'Fixed Charge');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Unit');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Applicable');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `variable_charge` SET TAGS ('dbx_business_glossary_term' = 'Variable Charge');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `delinquency_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Notice Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `prior_delinquency_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Delinquency Notice Id');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `prior_delinquency_notice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `amount_due` SET TAGS ('dbx_business_glossary_term' = 'Amount Due');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `collection_agency_flag` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Generated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `legal_action_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `legal_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `notice_last_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Last Sent Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_business_glossary_term' = 'Notice Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Sent Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_business_glossary_term' = 'Notice Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `delinquency_notice_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `total_due` SET TAGS ('dbx_business_glossary_term' = 'Total Due');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `previous_billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Billing Cycle Id');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `previous_billing_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `last_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Processed Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `late_fee_applied` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Applied');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
