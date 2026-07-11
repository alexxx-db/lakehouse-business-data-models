-- Schema for Domain: billing | Business: Health_Insurance | Version: v3_mvm
-- Generated on: 2026-07-10 22:45:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`billing` COMMENT 'Single source of truth for premium billing and revenue collection — group invoicing, individual premium statements, payment processing, grace periods, retroactive adjustments, premium reconciliation, refunds, and collections. Owns APR rate structures, PMPM calculations, subsidy and APTC tracking for ACA members, and accounts receivable. Supports CMS premium remittance and state DOI financial reporting. Source system: HealthEdge or custom billing platform.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` (
    `premium_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the premium invoice record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: A premium invoice is issued to a billing account — account is the master financial relationship entity in this domain. Every invoice must be traceable to its billing account for AR management, collect',
    `aptc_subsidy_id` BIGINT COMMENT 'Foreign key linking to billing.aptc_subsidy. Business justification: For ACA QHP invoices, the premium invoice is directly tied to an APTC/CSR subsidy record that defines the members authorized subsidy amounts. premium_invoice has is_eligible_for_subsidy, subsidy_amou',
    `broker_id` BIGINT COMMENT 'Foreign key linking to employer.broker. Business justification: Premium invoices for broker-sold groups must reference the broker of record for commission calculation, regulatory reporting (MLR), and broker performance tracking. Standard business process: monthly ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory filing of premium invoices required by state insurance premium reporting obligations.',
    `identity_id` BIGINT COMMENT 'Identifier of the individual member associated with the invoice, if applicable.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Premium invoices bill for specific plan elections. Every invoice must reference the coverage election being billed. Essential for premium calculation, billing accuracy, and member coverage verificatio',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: Premium invoices must track member enrollment in care management programs (disease management, wellness coaching, care coordination) for accurate premium calculation, risk adjustment reporting, and AC',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Required for premium invoicing: each invoice must reference the enrollment transaction that generated the premium, enabling audit, reporting, and reconciliation.',
    `billing_period_end` DATE COMMENT 'Last day of the coverage period for which the premium is billed.',
    `billing_period_start` DATE COMMENT 'First day of the coverage period for which the premium is billed.',
    `collection_status` STRING COMMENT 'Current state of the collection effort for the invoice.. Valid values are `not_started|in_process|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `delivery_method` STRING COMMENT 'Channel used to deliver the invoice to the recipient.. Valid values are `mail|email|portal`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount (e.g., early‑pay, promotional) applied to the invoice.',
    `due_date` DATE COMMENT 'Date by which payment must be received to avoid delinquency.',
    `grace_period_days` STRING COMMENT 'Number of days after due date before the invoice is considered delinquent.',
    `invoice_number` STRING COMMENT 'External invoice number assigned by the billing system, used for member and regulator reference.. Valid values are `^INV[0-9]{10}$`',
    `invoice_status` STRING COMMENT 'Current processing state of the invoice.. Valid values are `draft|issued|paid|partially_paid|void|delinquent`',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the recipient and billing arrangement.. Valid values are `group_list_bill|group_self_bill|individual_statement|cobra|government_remittance`',
    `is_eligible_for_subsidy` BOOLEAN COMMENT 'Flag indicating whether the member/group qualifies for a premium subsidy.',
    `issue_timestamp` TIMESTAMP COMMENT 'Exact time the invoice was generated and issued to the recipient.',
    `line_of_business` STRING COMMENT 'Business segment to which the invoice belongs.. Valid values are `medical|dental|vision|pharmacy|wellness`',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Final amount the recipient must pay after adjustments.',
    `notes` STRING COMMENT 'Optional comments or remarks added by billing staff.',
    `payment_channel` STRING COMMENT 'Interface through which the payment was made.. Valid values are `portal|mail|phone`',
    `payment_method` STRING COMMENT 'Primary instrument used to settle the invoice.. Valid values are `electronic|check|credit_card|direct_deposit`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount returned to the payer for over‑payment or claim reversal.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if the invoice must be reported to CMS or state DOI for compliance.',
    `retroactive_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment for prior‑period premium changes applied to the current invoice.',
    `source_system_invoice_reference` STRING COMMENT 'Original invoice identifier from the source billing system.',
    `statement_number` STRING COMMENT 'Unique identifier for an individual member statement when invoice_type is individual_statement.. Valid values are `^STMT[0-9]{8}$`',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Amount of premium assistance applied (e.g., APTC, state subsidy).',
    `subsidy_type` STRING COMMENT 'Classification of the subsidy applied to the premium.. Valid values are `aptc|state_subsidy|none`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the premium, if applicable.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Gross premium before any subsidies, taxes, or discounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the invoice record.',
    CONSTRAINT pk_premium_invoice PRIMARY KEY(`premium_invoice_id`)
) COMMENT 'Core billing document representing a premium invoice or statement issued to an employer group, individual member (IFP/ACA marketplace direct-pay), COBRA qualified beneficiary, or government sponsor for a specific billing period. Captures invoice number, billing period start/end, total premium due, subsidy/APTC amounts applied, net amount due, invoice status (draft, issued, paid, partially paid, void, delinquent), due date, document type (group list-bill invoice, group self-bill invoice, individual member statement, COBRA invoice, government remittance request), delivery method (mail, email, member portal), line-of-business (LOB), statement-specific fields for IFP direct-pay members (statement number, member reference, plan name, statement delivery preference), and source system reference from HealthEdge or custom billing platform. SSOT for ALL premium billing documents — both group invoices and individual member statements — in the billing domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'System-generated unique identifier for the invoice line record.',
    `aptc_subsidy_id` BIGINT COMMENT 'Foreign key linking to billing.aptc_subsidy. Business justification: invoice_line has aptc_subsidy_amount and csr_adjustment_amount fields representing line-level subsidy applications. Linking invoice_line to aptc_subsidy at the line level (per member/subscriber) enabl',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan or benefit design associated with the charge.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the covered member or subscriber for this premium charge.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Invoice line items detail premium charges for specific plan elections. Required for line-level premium reconciliation, coverage tier billing, and retroactive adjustment processing. Each line represent',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Invoice lines for care management fees, care coordination services, and value-based care arrangements must reference the specific care plan being billed. Essential for VBC contract billing, care manag',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the parent invoice header to which this line belongs.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: Invoice lines calculate premium amounts by applying specific rate tables based on member age, family tier, rating area, and coverage period. Rating is the core actuarial process that translates plan d',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Needed for line‑level reconciliation: each invoice line reflects a specific enrollment transaction (plan tier, coverage), supporting detailed financial reporting.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the business reason for a premium adjustment.. Valid values are `A|B|C|D|E|F`',
    `adjustment_reason_description` STRING COMMENT 'Human‑readable description of the adjustment reason.',
    `aptc_subsidy_amount` DECIMAL(18,2) COMMENT 'Advanced Premium Tax Credit amount applied to reduce the members premium.',
    `billing_period_end` DATE COMMENT 'End date of the billing period associated with this line.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period associated with this line.',
    `coverage_end_date` DATE COMMENT 'Last day of coverage for which the premium is billed (nullable for open‑ended coverage).',
    `coverage_start_date` DATE COMMENT 'First day of coverage for which the premium is billed.',
    `coverage_tier` STRING COMMENT 'Classification of the coverage level for the member (e.g., employee only, employee + spouse, employee + child, family).. Valid values are `EE|EE+SP|EE+CH|FAM`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the invoice line record was first created in the system.',
    `csr_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount of cost-sharing reduction (CSR) applied to the premium.',
    `employee_contribution` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employee (or subscriber).',
    `employer_contribution` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employer on behalf of the member.',
    `is_refund` BOOLEAN COMMENT 'True if this line represents a refund rather than a charge.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the invoice.',
    `payment_due_date` DATE COMMENT 'Date by which payment for this premium line is due.',
    `payment_status` STRING COMMENT 'Current payment status for the premium line.. Valid values are `due|paid|failed|waived`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Base premium amount before any contributions, subsidies, or adjustments.',
    `premium_currency` STRING COMMENT 'Three‑letter ISO currency code for the premium amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `premium_line_description` STRING COMMENT 'Free‑form description of the premium line (e.g., "Monthly medical premium for employee only").',
    `premium_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether the line has been reconciled to the general ledger.',
    `premium_source_system` STRING COMMENT 'Name of the source system that generated the premium line (e.g., HealthEdge, CustomBilling).',
    `premium_status` STRING COMMENT 'Current processing status of the premium line.. Valid values are `pending|posted|reversed|cancelled`',
    `rate_type` STRING COMMENT 'Type of premium rate applied to the line (standard, discount, subsidy, retroactive, or other adjustment).. Valid values are `standard|discount|subsidy|retroactive|adjustment`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the member or employer for this line (if applicable).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if this line must be included in regulatory reports (e.g., CMS, state DOI).',
    `retroactive_adjustment_flag` BOOLEAN COMMENT 'Flag indicating whether this line reflects a retroactive premium adjustment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the premium line, if applicable.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final amount after employer/employee contributions, subsidies, adjustments, and taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the invoice line record.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Line-item detail within a premium invoice, representing a single member or subscriber coverage charge for a billing period. Captures member/subscriber reference, plan code, coverage tier (EE, EE+SP, EE+CH, FAM), rate type, gross premium, employer contribution, employee contribution, APTC subsidy amount, CSR adjustment, retroactive adjustment indicator, and effective coverage dates. Supports PMPM-level billing reconciliation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` (
    `premium_payment_id` BIGINT COMMENT 'System-generated unique identifier for the premium payment record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: A premium payment is made against a billing account. The account is the master billing entity that owns the payment relationship. No existing FK from premium_payment to account exists. payer_account_n',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Premium payments need to track care program enrollment status to apply correct premium rates, care management fees, and value-based adjustments. Operational requirement for billing systems to validate',
    `identity_id` BIGINT COMMENT 'Identifier of the member associated with the premium payment.',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to billing.payment_method. Business justification: premium_payment has a STRING column payment_method (e.g., ACH, CHECK, CREDIT_CARD) which is a denormalized reference to the payment_method master record. payment_method is the authoritative ma',
    `policy_id` BIGINT COMMENT 'Identifier of the insurance policy to which the premium payment applies.',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the premium invoice that this payment is applied to.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Payments are applied to invoices tied to an enrollment transaction; linking allows tracking payment against the originating enrollment for compliance and financial analysis.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total of fees, discounts, or other adjustments applied to the gross amount.',
    `batch_number` STRING COMMENT 'Identifier of the processing batch that included this payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the payment.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any processing or service fees associated with the payment.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after adjustments, representing the amount applied to the invoice.',
    `nsf_indicator` BOOLEAN COMMENT 'True if the payment was returned due to non‑sufficient funds.',
    `payer_account_number` STRING COMMENT 'Account number or identifier used by the payer for the transaction.',
    `payer_name` STRING COMMENT 'Legal name of the entity making the payment.',
    `payer_type` STRING COMMENT 'Classification of the payer (e.g., employer, individual member, CMS, state Medicaid agency).. Valid values are `employer|member|cms|state_medicaid|other`',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total amount received before any adjustments.',
    `payment_channel` STRING COMMENT 'Interface through which the payment was submitted.. Valid values are `web|mobile|call_center|mail|batch|other`',
    `payment_description` STRING COMMENT 'Free‑form description or notes about the payment.',
    `payment_number` STRING COMMENT 'Unique payment reference number assigned by the billing system.',
    `payment_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was received.',
    `premium_payment_status` STRING COMMENT 'Current lifecycle state of the payment.. Valid values are `pending|posted|failed|cancelled`',
    `reconciliation_status` STRING COMMENT 'Status of the payment in the accounting reconciliation process.. Valid values are `pending|matched|unmatched|exception`',
    `resolution_date` DATE COMMENT 'Date the suspense item was resolved.',
    `resolution_due_date` DATE COMMENT 'Target date by which the suspense item should be resolved.',
    `resolution_outcome` STRING COMMENT 'Result of the suspense investigation.. Valid values are `applied|refunded|written_off|reversed`',
    `suspense_reason_code` STRING COMMENT 'Code indicating why the payment is in suspense (e.g., unidentified payer, amount mismatch).',
    `suspense_resolver` STRING COMMENT 'Name of the employee or system responsible for investigating the suspense item.',
    `suspense_status` STRING COMMENT 'Current status of the payment within the suspense workflow.. Valid values are `in_suspense|resolved|written_off`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the payment, if applicable.',
    `transaction_type` STRING COMMENT 'Classification of the payment transaction.. Valid values are `premium|adjustment|refund|reversal`',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of the payment that could not be matched to an invoice and is placed in suspense.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    CONSTRAINT pk_premium_payment PRIMARY KEY(`premium_payment_id`)
) COMMENT 'Records an actual payment received against a premium invoice, capturing payment date, payment amount, payment method (ACH, check, wire, credit card, EFT), payment reference number, payer type (employer group, individual member, CMS, state Medicaid agency), applied invoice reference, unapplied/suspense balance, NSF/return indicator, reconciliation status, and full suspense management lifecycle (suspense status, suspense reason code — unidentified payer, amount mismatch, duplicate payment, missing invoice reference — received amount, receipt date, payer name, payer account reference, assigned resolver, resolution due date, resolution outcome — applied to invoice, refunded, written off — resolution date). Payments in suspense status are tracked inline with complete resolution workflow rather than in a separate suspense entity. SSOT for all inbound premium cash receipts including suspense items, their investigation, and resolution lifecycle.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` (
    `payment_allocation_id` BIGINT COMMENT 'System-generated unique identifier for each payment allocation record.',
    `invoice_line_id` BIGINT COMMENT 'Identifier of the invoice line to which the payment amount is allocated.',
    `premium_payment_id` BIGINT COMMENT 'Identifier of the premium payment that is being allocated.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the premium that is allocated to the invoice line.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of premium units (e.g., member‑months) allocated to the invoice line.',
    `allocation_date` DATE COMMENT 'Calendar date on which the allocation was recorded.',
    `allocation_sequence` STRING COMMENT 'Sequential order of allocation lines within the same payment.',
    `allocation_status` STRING COMMENT 'Current processing status of the allocation record.. Valid values are `allocated|pending|rejected|adjusted|closed`',
    `allocation_type` STRING COMMENT 'Classification of the allocation purpose (e.g., standard payment, partial payment, over‑payment, suspense resolution, adjustment, refund).. Valid values are `standard|partial|overpayment|suspense_resolution|adjustment|refund`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the allocated amount.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount or credit applied to the allocated premium.',
    `effective_from` DATE COMMENT 'Date when the allocation becomes effective for accounting purposes.',
    `effective_until` DATE COMMENT 'Date when the allocation ceases to be effective (null if open‑ended).',
    `is_overpayment` BOOLEAN COMMENT 'Indicates whether the allocation represents an overpayment scenario.',
    `is_suspense_resolution` BOOLEAN COMMENT 'True when the allocation resolves a suspense balance.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the allocation.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was submitted.. Valid values are `web|mobile|call_center|in_person|batch|other`',
    `payment_method` STRING COMMENT 'Instrument used to make the premium payment.. Valid values are `credit_card|bank_transfer|cash|check|electronic|other`',
    `reconciliation_period` STRING COMMENT 'Period identifier (e.g., 2023-04) for the premium reconciliation cycle.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle state of the reconciliation record.. Valid values are `open|in_review|approved|closed|rejected`',
    `reconciliation_type` STRING COMMENT 'Frequency classification of the reconciliation (e.g., monthly, quarterly).. Valid values are `monthly|quarterly|annual|ad_hoc`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the allocated premium.',
    `total_adjustments` DECIMAL(18,2) COMMENT 'Aggregate of all adjustments (e.g., refunds, credits) applied during the period.',
    `total_billed` DECIMAL(18,2) COMMENT 'Sum of all invoice line amounts billed for the reconciliation period.',
    `total_collected` DECIMAL(18,2) COMMENT 'Sum of all payments collected for the reconciliation period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between total billed and total collected after adjustments.',
    `variance_reason` STRING COMMENT 'Explanation for any variance observed in the reconciliation.',
    CONSTRAINT pk_payment_allocation PRIMARY KEY(`payment_allocation_id`)
) COMMENT 'Association and reconciliation entity linking premium payments to invoice lines, tracking line-level allocation, and managing periodic premium reconciliation outcomes. For allocation: captures allocated amount, allocation date, allocation type (standard, partial, overpayment, suspense resolution), and line-level reconciliation status. Supports many-to-many payment-to-invoice matching and enables accurate accounts receivable aging. For periodic reconciliation: captures reconciliation period, total billed, total collected, total adjustments, variance amount, variance reason, reconciliation status (open, in review, approved, closed), approver reference, and reconciliation type (monthly, quarterly, annual). Supports MLR calculation inputs, financial close processes, CMS premium reconciliation, and end-to-end premium reconciliation from individual line-level allocation through period-level summary and variance analysis. SSOT for all payment allocation and premium reconciliation in the billing domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`account` (
    `account_id` BIGINT COMMENT 'System-generated unique identifier for the billing account.',
    `broker_id` BIGINT COMMENT 'Foreign key linking to employer.broker. Business justification: Billing accounts track broker of record for commission processing, 1099 reporting, and broker servicing rights. Real business need: accounts must maintain broker assignment history for commission disp',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Billing accounts are established at the facility level for hospital systems and outpatient facilities, enabling facility-level billing cycle management, capitation payment setup, and EFT disbursement.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.service_area. Business justification: Billing accounts (especially employer group accounts) must track their primary service area for network adequacy compliance, provider access validation, premium rating by geography, and regulatory rep',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Needed for Provider Payment Reconciliation report linking each provider to its billing account for electronic fund transfers and regulatory payment tracking.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Billing accounts must track governing regulatory obligations for compliance reporting, tax-exempt status validation, regulatory fee assessment, and jurisdiction-specific billing rules. Essential for r',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account.. Valid values are `active|suspended|closed|pending`',
    `account_type` STRING COMMENT 'Classification of the billing entity (e.g., employer group, individual subscriber, government program).. Valid values are `employer_group|individual|government|medicare|medicaid|chip`',
    `apr_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate the annual premium for the account.',
    `aptc_amount` DECIMAL(18,2) COMMENT 'Amount of ACA premium tax credit applied to the account.',
    `auto_pay_authorization_date` DATE COMMENT 'Date when the auto‑pay authorization was granted.',
    `auto_pay_authorization_flag` BOOLEAN COMMENT 'Indicates whether the account holder has authorized automatic payments.',
    `auto_pay_enrollment` BOOLEAN COMMENT 'Indicates whether the account is enrolled in automatic payment processing.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the account automatically renews at the end of its term.',
    `billing_calendar_reference` STRING COMMENT 'Identifier for the calendar configuration governing billing cycles.',
    `billing_cycle_type` STRING COMMENT 'Configuration of the recurring billing cycle for the account.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `billing_frequency` STRING COMMENT 'How often invoices are generated for this account.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `billing_method` STRING COMMENT 'Method used to deliver bills to the account holder.. Valid values are `self_bill|list_bill|direct_bill`',
    `collection_status` STRING COMMENT 'Current status of the collection effort for overdue balances.. Valid values are `not_started|in_progress|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount authorized for the billing entity.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts on the account.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `current_balance` DECIMAL(18,2) COMMENT 'Outstanding monetary balance on the account as of the latest reconciliation.',
    `effective_from` DATE COMMENT 'Date when the billing account became effective.',
    `effective_until` DATE COMMENT 'Date when the billing account is scheduled to terminate (null if open‑ended).',
    `grace_period_days` STRING COMMENT 'Number of days after the due date before the account is considered delinquent.',
    `invoice_generation_day` STRING COMMENT 'Day of month when the invoice is generated (1‑31).',
    `last_invoice_date` DATE COMMENT 'Date when the most recent invoice was generated.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the most recent payment.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received for the account.',
    `next_invoice_date` DATE COMMENT 'Scheduled date for the next invoice issuance.',
    `notes` STRING COMMENT 'Free‑form text field for internal comments or special instructions related to the account.',
    `number` STRING COMMENT 'External account number assigned to the billing entity for invoicing and payment processing.',
    `payment_due_amount` DECIMAL(18,2) COMMENT 'Total amount currently due on the account, including any pending charges.',
    `payment_due_day` STRING COMMENT 'Day of month by which payment must be received.',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due after invoice issuance.. Valid values are `net_30|net_45|net_60|due_on_receipt`',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'Rate used to calculate monthly charges on a per‑member basis.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the account is subject to special regulatory reporting (e.g., CMS, state DOI).',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Total subsidy applied to the account (e.g., employer or government subsidies).',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the account is exempt from sales or other applicable taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing account record.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master billing account representing the financial relationship between the health plan and a billing entity — employer group, individual subscriber, or government program (Medicare, Medicaid, CHIP). Captures account number, account type, billing frequency (monthly, quarterly, annual), billing method (self-bill, list-bill, direct-bill), payment terms, auto-pay enrollment, current balance, credit limit, account status, assigned billing representative, billing cycle configuration (cycle type — monthly/quarterly/semi-annual/annual, invoice generation date, payment due date, grace period days, next/last invoice dates, auto-renewal flag, billing calendar reference), and registered payment methods (payment method type — ACH/EFT, check, wire transfer, credit card, debit card, HSA/FSA — with masked/tokenized bank routing and account numbers, card last four digits, card expiration date, auto-pay authorization flag, authorization date and reference, active/inactive status per method, PCI-DSS compliant storage). SSOT for billing account identity, billing cycle configuration, and authorized payment methods.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` (
    `grace_period_id` BIGINT COMMENT 'System-generated unique identifier for the grace period record.',
    `account_id` BIGINT COMMENT 'Identifier of the billing account to which this grace period applies.',
    `identity_id` BIGINT COMMENT 'Identifier of the member associated with the account for this grace period.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Grace periods track non-payment risk for specific coverage elections. Required for termination processing, reinstatement eligibility, and regulatory reporting. Business must know which plan election i',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the invoice that triggered the grace period.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Grace periods are governed by specific state/federal regulations (ACA 90-day grace period rules, state-specific extensions). Linking enables compliance validation, termination decision support, and re',
    `premium_payment_id` BIGINT COMMENT 'Foreign key linking to billing.premium_payment. Business justification: A grace period is resolved (or terminated) when a premium payment is received. grace_period has payment_received_date (a date field) but no FK to the actual premium_payment record that resolved it. Ad',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grace period record was first created in the system.',
    `day_count` STRING COMMENT 'Number of days elapsed since the start of the grace period.',
    `grace_period_description` STRING COMMENT 'Free-text description providing additional context for the grace period.',
    `end_date` DATE COMMENT 'Date when the grace period is scheduled to end.',
    `extension_end_date` DATE COMMENT 'New end date if the grace period was extended.',
    `extension_flag` BOOLEAN COMMENT 'Indicates whether the original grace period was extended.',
    `grace_period_status` STRING COMMENT 'Current lifecycle status of the grace period.. Valid values are `active|expired|terminated|reinstated|paid`',
    `grace_period_type` STRING COMMENT 'Classification of the grace period based on product or regulatory rules.. Valid values are `standard|aca_aptc|group|individual`',
    `is_eligible_for_aptc` BOOLEAN COMMENT 'Indicates if the member is eligible for Advanced Premium Tax Credit during this grace period.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction applicable to the grace period.. Valid values are `federal|state`',
    `notes` STRING COMMENT 'Additional free-form notes captured by the billing team.',
    `number` STRING COMMENT 'External business identifier for the grace period, used in reporting and member communications.',
    `outcome` STRING COMMENT 'Result of the grace period after it ends.. Valid values are `paid|terminated|reinstated|none`',
    `payment_due_date` DATE COMMENT 'The date by which the premium payment was originally due before the grace period started.',
    `payment_received_date` DATE COMMENT 'Date on which the overdue payment was received, if applicable.',
    `reason_code` STRING COMMENT 'Code indicating why the grace period was initiated.. Valid values are `late_payment|non_payment|billing_error|other`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this grace period must be reported to CMS or state DOI.',
    `start_date` DATE COMMENT 'Date when the grace period began.',
    `state_code` STRING COMMENT 'Two-letter state abbreviation for jurisdictional reporting. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product]',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any subsidy applied during the grace period.',
    `termination_warning_issued` BOOLEAN COMMENT 'Indicates whether a termination warning has been sent to the member.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grace period record.',
    CONSTRAINT pk_grace_period PRIMARY KEY(`grace_period_id`)
) COMMENT 'Tracks the grace period status for a billing account or member when premium payment is overdue. Captures grace period start date, grace period end date (typically 30 days for individual/ACA, 31 days for group), grace period type (ACA APTC grace period is 90 days), triggering invoice reference, current grace period day count, termination warning issued flag, and resolution outcome (paid, terminated, reinstated). Required for ACA compliance and state DOI reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` (
    `aptc_subsidy_id` BIGINT COMMENT 'System-generated unique identifier for the APTC subsidy record.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member receiving the subsidy.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: APTC subsidies are calculated and applied to specific plan elections. Required for premium calculation, CMS reconciliation, and subsidy eligibility verification. Each subsidy record must reference the',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: APTC subsidies are governed by specific ACA regulations and IRS reconciliation requirements. Linking enables CMS reconciliation compliance tracking, regulatory reporting validation, and audit support ',
    `annual_aptc_cap` DECIMAL(18,2) COMMENT 'Maximum total APTC amount the member may receive in a calendar year.',
    `aptc_monthly_amount` DECIMAL(18,2) COMMENT 'Monthly amount of APTC applied to the members premium.',
    `aptc_subsidy_status` STRING COMMENT 'Overall lifecycle status of the subsidy record.. Valid values are `active|inactive|terminated|pending`',
    `cms_reconciliation_status` STRING COMMENT 'Current status of the subsidy record in CMS premium remittance reconciliation.. Valid values are `pending|reconciled|error`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subsidy record was first created in the system.',
    `csr_variant` STRING COMMENT 'CSR variant percentage (73%, 87%, or 94%) applicable to the member.. Valid values are `73|87|94`',
    `exchange_code` STRING COMMENT 'Identifier of the marketplace exchange where the member enrolled.',
    `qhp_plan_code` STRING COMMENT 'Code of the Qualified Health Plan associated with the subsidy.',
    `subsidy_effective_date` DATE COMMENT 'Date when the subsidy becomes effective.',
    `subsidy_number` STRING COMMENT 'External business identifier assigned to the subsidy agreement.',
    `subsidy_termination_date` DATE COMMENT 'Date when the subsidy ends or is terminated; null if still active.',
    `subsidy_type` STRING COMMENT 'Indicates whether the record is an Advance Premium Tax Credit (APTC) or Cost‑Sharing Reduction (CSR) subsidy.. Valid values are `APTC|CSR`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subsidy record.',
    `ytd_aptc_applied` DECIMAL(18,2) COMMENT 'Cumulative APTC amount applied to the members premiums to date.',
    CONSTRAINT pk_aptc_subsidy PRIMARY KEY(`aptc_subsidy_id`)
) COMMENT 'Tracks Advance Premium Tax Credit (APTC) and Cost-Sharing Reduction (CSR) subsidy amounts for ACA marketplace members. Captures member reference, QHP plan code, marketplace exchange ID, APTC monthly amount, CSR variant level (73%, 87%, 94%), annual APTC cap, year-to-date APTC applied, subsidy effective date, subsidy termination date, and CMS reconciliation status. Required for ACA Section 1401/1402 compliance and CMS premium remittance reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` (
    `cms_remittance_id` BIGINT COMMENT 'System-generated unique identifier for each CMS remittance record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: CMS remittance transactions represent payments from CMS to the health plans billing account for Medicare Advantage, Part D, and ACA QHP plans. Linking cms_remittance to the billing account enables ac',
    `broker_id` BIGINT COMMENT 'Foreign key linking to employer.broker. Business justification: CMS 820 remittances in marketplace/exchange scenarios include broker commission reconciliation data. Issuers must track which broker facilitated enrollment to calculate and report commissions. Real bu',
    `cms_submission_id` BIGINT COMMENT 'Foreign key linking to enrollment.cms_submission. Business justification: CMS remittances reconcile payments against specific enrollment submissions. Required for risk adjustment reconciliation, payment variance analysis, and regulatory audit trails. Each remittance must re',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: CMS remittance for facility-based services (UB-04/institutional claims) must reference the specific facility for reconciliation, audit, and regulatory reporting. Health plans receive separate CMS remi',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: CMS remittance for ACO shared savings, group capitation, and MSSP arrangements is issued at the group practice level, not individual provider level. Group-level CMS remittance reconciliation is a mand',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan or benefit package for which the remittance applies.',
    `hedis_measure_id` BIGINT COMMENT 'Foreign key linking to care.hedis_measure. Business justification: CMS remittances for quality bonus payments, star ratings incentives, and HEDIS performance-based payments must reference the specific HEDIS measures that triggered the payment. Required for quality pa',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the remittance.',
    `pbm_contract_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pbm_contract. Business justification: CMS Part D remittance payments are governed by PBM contract terms (rebate pass-through %, dispensing fee guarantees). Reconciling CMS remittances against the applicable PBM contract is a mandatory Par',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: CMS remittances for risk adjustment payments, MLR rebates, and reinsurance are calculated and reconciled at the provider network level for regulatory reporting to CMS. Network-level aggregation is req',
    `raps_submission_id` BIGINT COMMENT 'Foreign key linking to risk.raps_submission. Business justification: CMS risk adjustment remittances must reference the specific RAPS submission batch that triggered the payment. Critical for reconciling CMS payments to submitted diagnosis data and resolving payment di',
    `adjustment_reason` STRING COMMENT 'Free‑text description explaining any manual adjustments applied to the remittance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the remittance record was first loaded into the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the remittance amounts (e.g., USD).',
    `edi_820_reference` STRING COMMENT 'Reference number of the associated EDI 820 payment file.',
    `gross_payment_amount` DECIMAL(18,2) COMMENT 'Total amount paid by CMS before any adjustments or offsets.',
    `is_eligible` BOOLEAN COMMENT 'Indicates whether the member was eligible for the payment period.',
    `mlr_rebate_offset_amount` DECIMAL(18,2) COMMENT 'Medical Loss Ratio rebate offset applied to the gross payment.',
    `net_remittance_amount` DECIMAL(18,2) COMMENT 'Final amount after all adjustments, representing the amount to be credited to the insurer.',
    `payment_period_end` DATE COMMENT 'Last day of the payment period for which the remittance applies.',
    `payment_period_start` DATE COMMENT 'First day of the payment period for which the remittance applies.',
    `payment_type` STRING COMMENT 'Category of CMS payment such as capitation, risk corridor, reinsurance, or risk adjustment.. Valid values are `capitation|risk_corridor|reinsurance|risk_adjustment|other`',
    `reconciliation_status` STRING COMMENT 'Current status of the remittance reconciliation process.. Valid values are `pending|reconciled|exception|adjusted`',
    `remittance_number` STRING COMMENT 'External reference number assigned by CMS for the remittance transaction.',
    `remittance_status` STRING COMMENT 'Lifecycle state of the remittance record within the insurers system.. Valid values are `received|processed|posted|rejected`',
    `remittance_timestamp` TIMESTAMP COMMENT 'Date and time when the remittance was received from CMS.',
    `risk_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount related to risk adjustment transfers included in the remittance.',
    `submission_type` STRING COMMENT 'Method by which the remittance data was submitted to the insurer.. Valid values are `electronic|paper|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the remittance record.',
    CONSTRAINT pk_cms_remittance PRIMARY KEY(`cms_remittance_id`)
) COMMENT 'Records CMS premium remittance transactions for Medicare Advantage (MA), Part D, and ACA QHP plans. Captures CMS payment type (capitation, risk corridor, reinsurance, risk adjustment transfer), payment period, gross payment amount, risk adjustment amount, MLR rebate offset, net remittance amount, CMS transaction ID, 820 EDI transaction reference, and reconciliation status. SSOT for government premium remittance from CMS.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` (
    `payment_method_id` BIGINT COMMENT 'System-generated unique identifier for the payment method record.',
    `account_id` BIGINT COMMENT 'Identifier of the billing account to which this payment method is attached.',
    `identity_id` BIGINT COMMENT 'Identifier of the member (policyholder) who owns the payment method.',
    `authorization_date` DATE COMMENT 'Date the payment method was authorized for use.',
    `authorization_reference` STRING COMMENT 'External reference or token returned by the payment processor confirming authorization.',
    `bank_name` STRING COMMENT 'Name of the financial institution that holds the account.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address associated with the payment method.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (optional).',
    `billing_city` STRING COMMENT 'City component of the billing address.',
    `billing_country` STRING COMMENT 'Three‑letter ISO country code for the billing address.',
    `billing_postal_code` STRING COMMENT 'Postal/ZIP code of the billing address.',
    `billing_state` STRING COMMENT 'State/Province component of the billing address.',
    `card_expiration_date` DATE COMMENT 'Expiration date of the credit/debit card.',
    `card_last_four` STRING COMMENT 'Last four digits of the credit/debit card for display purposes.',
    `card_type` STRING COMMENT 'Network brand of the credit/debit card.. Valid values are `Visa|MasterCard|Amex|Discover|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment method record was first created in the system.',
    `effective_from` DATE COMMENT 'Date the payment method becomes effective for billing.',
    `effective_until` DATE COMMENT 'Date the payment method expires or is deactivated (null if open‑ended).',
    `holder_name` STRING COMMENT 'Legal name of the individual to whom the card is issued.',
    `is_auto_pay` BOOLEAN COMMENT 'Indicates whether the member has authorized automatic recurring payments using this method.',
    `masked_account_number` STRING COMMENT 'Bank account number with middle digits masked for PCI‑DSS compliance.',
    `masked_routing_number` STRING COMMENT 'Bank routing number with middle digits masked to meet PCI‑DSS requirements.',
    `method_type` STRING COMMENT 'Category of the payment instrument (e.g., ACH, Check, Wire, Credit Card, Debit Card, Health Savings Account).. Valid values are `ACH|Check|Wire|CreditCard|DebitCard|HSA`',
    `notes` STRING COMMENT 'Free‑form text for operational comments or special handling instructions.',
    `payment_method_status` STRING COMMENT 'Current lifecycle state of the payment method.. Valid values are `active|inactive|suspended|pending`',
    `pci_compliance_flag` BOOLEAN COMMENT 'Indicates whether the stored payment method meets PCI‑DSS compliance.',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by the payment processor (0.00‑99.99).',
    `tokenized_account_number` STRING COMMENT 'PCI‑token representing the full bank account number for secure storage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment method record.',
    `verification_status` STRING COMMENT 'Result of the payment method verification process.. Valid values are `verified|unverified|failed`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date‑time when verification was performed.',
    CONSTRAINT pk_payment_method PRIMARY KEY(`payment_method_id`)
) COMMENT 'Master record of authorized payment methods registered for a billing account, capturing payment method type (ACH/EFT, check, wire transfer, credit card, debit card, HSA/FSA), bank routing number (masked), bank account number (masked/tokenized), card last four digits, card expiration date, auto-pay authorization flag, authorization date, authorization reference, and active/inactive status. Supports PCI-DSS compliant payment processing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_aptc_subsidy_id` FOREIGN KEY (`aptc_subsidy_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`aptc_subsidy`(`aptc_subsidy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_aptc_subsidy_id` FOREIGN KEY (`aptc_subsidy_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`aptc_subsidy`(`aptc_subsidy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'Aptc Subsidy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_process|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|email|portal');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|paid|partially_paid|void|delinquent');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'group_list_bill|group_self_bill|individual_statement|cobra|government_remittance');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `is_eligible_for_subsidy` SET TAGS ('dbx_business_glossary_term' = 'Eligibility for Subsidy');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `net_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'portal|mail|phone');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'electronic|check|credit_card|direct_deposit');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `retroactive_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `source_system_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('dbx_value_regex' = '^STMT[0-9]{8}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount (APTC)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'aptc|state_subsidy|none');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'Aptc Subsidy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `aptc_subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'APTC Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'EE|EE+SP|EE+CH|FAM');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `csr_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'CSR Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `employer_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `is_refund` SET TAGS ('dbx_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'due|paid|failed|waived');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'standard|discount|subsidy|retroactive|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `nsf_indicator` SET TAGS ('dbx_business_glossary_term' = 'NSF Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_type` SET TAGS ('dbx_value_regex' = 'employer|member|cms|state_medicaid|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount (Gross)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|call_center|mail|batch|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|unmatched|exception');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_due_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'applied|refunded|written_off|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_resolver` SET TAGS ('dbx_business_glossary_term' = 'Suspense Resolver');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_resolver` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_resolver` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_status` SET TAGS ('dbx_business_glossary_term' = 'Suspense Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_status` SET TAGS ('dbx_value_regex' = 'in_suspense|resolved|written_off');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'premium|adjustment|refund|reversal');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Allocation Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'allocated|pending|rejected|adjusted|closed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'standard|partial|overpayment|suspense_resolution|adjustment|refund');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `is_overpayment` SET TAGS ('dbx_business_glossary_term' = 'Is Overpayment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `is_suspense_resolution` SET TAGS ('dbx_business_glossary_term' = 'Is Suspense Resolution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|call_center|in_person|batch|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|cash|check|electronic|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'open|in_review|approved|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `total_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustments Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `total_billed` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `total_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Collected Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (ACC_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type (ACC_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'employer_group|individual|government|medicare|medicaid|chip');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `apr_rate` SET TAGS ('dbx_business_glossary_term' = 'Annual Premium Rate (APR)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `aptc_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Premium Tax Credit (APTC) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `auto_pay_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Authorization Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `auto_pay_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Authorization Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `auto_pay_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Enrollment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_calendar_reference` SET TAGS ('dbx_business_glossary_term' = 'Billing Calendar Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Type (CYCLE_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency (BILL_FREQ)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Method (BILL_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_method` SET TAGS ('dbx_value_regex' = 'self_bill|list_bill|direct_bill');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CR_LIM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance (CUR_BAL)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (GRACE_DAYS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `invoice_generation_day` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generation Day');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `next_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Next Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (ACC_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_due_day` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Day');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|due_on_receipt');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `pmpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month Rate (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Resolving Premium Payment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `day_count` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Day Count');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_description` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_description` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `extension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `extension_flag` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Extension Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_value_regex' = 'active|expired|terminated|reinstated|paid');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('dbx_value_regex' = 'standard|aca_aptc|group|individual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `is_eligible_for_aptc` SET TAGS ('dbx_business_glossary_term' = 'ACA APTC Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `number` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'paid|terminated|reinstated|none');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'late_payment|non_payment|billing_error|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `termination_warning_issued` SET TAGS ('dbx_business_glossary_term' = 'Termination Warning Issued Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('dbx_subdomain' = 'subsidy_reconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'APTC Subsidy ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `annual_aptc_cap` SET TAGS ('dbx_business_glossary_term' = 'Annual APTC Cap');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `annual_aptc_cap` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `annual_aptc_cap` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_monthly_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Premium Tax Credit (APTC) Monthly Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_monthly_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_monthly_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_status` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `cms_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `cms_reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|error');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `csr_variant` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Sharing Reduction (CSR) Variant Level');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `csr_variant` SET TAGS ('dbx_value_regex' = '73|87|94');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Exchange Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `qhp_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Qualified Health Plan (QHP) Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_number` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Identifier (Subsidy Number)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type (APTC or CSR)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'APTC|CSR');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('dbx_business_glossary_term' = 'Year‑to‑Date APTC Applied');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('dbx_subdomain' = 'subsidy_reconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `cms_remittance_id` SET TAGS ('dbx_business_glossary_term' = 'CMS Remittance ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `cms_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Cms Submission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Hedis Measure Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `pbm_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pbm Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `raps_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Raps Submission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `edi_820_reference` SET TAGS ('dbx_business_glossary_term' = 'EDI 820 Transaction Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `gross_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `is_eligible` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `mlr_rebate_offset_amount` SET TAGS ('dbx_business_glossary_term' = 'MLR Rebate Offset Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `net_remittance_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Remittance Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `payment_period_end` SET TAGS ('dbx_business_glossary_term' = 'Payment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `payment_period_start` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type (CMS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'capitation|risk_corridor|reinsurance|risk_adjustment|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|exception|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `remittance_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Remittance Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `remittance_status` SET TAGS ('dbx_value_regex' = 'received|processed|posted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `remittance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remittance Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `risk_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'electronic|paper|manual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Card Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'Visa|MasterCard|Amex|Discover|Other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `is_auto_pay` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Authorization Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Routing Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `method_type` SET TAGS ('dbx_value_regex' = 'ACH|Check|Wire|CreditCard|DebitCard|HSA');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `pci_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `pci_compliance_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
