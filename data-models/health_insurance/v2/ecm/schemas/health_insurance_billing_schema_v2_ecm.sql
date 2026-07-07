-- Schema for Domain: billing | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`billing` COMMENT 'Single source of truth for premium billing and revenue collection — group invoicing, individual premium statements, payment processing, grace periods, retroactive adjustments, premium reconciliation, refunds, and collections. Owns APR rate structures, PMPM calculations, subsidy and APTC tracking for ACA members, and accounts receivable. Supports CMS premium remittance and state DOI financial reporting. Source system: HealthEdge or custom billing platform.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` (
    `premium_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the premium invoice record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Invoice creation is performed by a billing clerk; required for internal audit and workload tracking.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory filing of premium invoices required by state insurance premium reporting obligations.',
    `application_id` BIGINT COMMENT 'Foreign key linking to credential.application. Business justification: Required for the Credentialing Application Fee Invoicing process, linking each premium invoice to the specific credentialing application it charges, enabling audit and regulatory reconciliation.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group billed for group coverage.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan or benefit design underlying the premium.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: General Ledger posting of premium invoices for revenue recognition required for financial statements.',
    `identity_id` BIGINT COMMENT 'Identifier of the individual member associated with the invoice, if applicable.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Required for CMS risk‑adjusted premium reporting linking each invoice to the members risk score at billing time.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Required for premium invoicing: each invoice must reference the enrollment transaction that generated the premium, enabling audit, reporting, and reconciliation.',
    `billing_period_end` DATE COMMENT 'Last day of the coverage period for which the premium is billed.',
    `billing_period_start` DATE COMMENT 'First day of the coverage period for which the premium is billed.',
    `collection_status` STRING COMMENT 'Current state of the collection effort for the invoice.. Valid values are `not_started|in_process|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_method` STRING COMMENT 'Channel used to deliver the invoice to the recipient.. Valid values are `mail|email|portal`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount (e.g., early‑pay, promotional) applied to the invoice.',
    `due_date` DATE COMMENT 'Date by which payment must be received to avoid delinquency.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Invoice)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grace_period_days` STRING COMMENT 'Number of days after due date before the invoice is considered delinquent.',
    `invoice_number` STRING COMMENT 'External invoice number assigned by the billing system, used for member and regulator reference.. Valid values are `^INV[0-9]{10}$`',
    `invoice_status` STRING COMMENT 'Current processing state of the invoice.. Valid values are `draft|issued|paid|partially_paid|void|delinquent`',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the recipient and billing arrangement.. Valid values are `group_list_bill|group_self_bill|individual_statement|cobra|government_remittance`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_eligible_for_subsidy` BOOLEAN COMMENT 'Flag indicating whether the member/group qualifies for a premium subsidy.',
    `issue_timestamp` TIMESTAMP COMMENT 'Exact time the invoice was generated and issued to the recipient.',
    `line_of_business` STRING COMMENT 'Business segment to which the invoice belongs.. Valid values are `medical|dental|vision|pharmacy|wellness`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Final amount the recipient must pay after adjustments.',
    `notes` STRING COMMENT 'Optional comments or remarks added by billing staff.',
    `payment_channel` STRING COMMENT 'Interface through which the payment was made.. Valid values are `portal|mail|phone`',
    `payment_method` STRING COMMENT 'Primary instrument used to settle the invoice.. Valid values are `electronic|check|credit_card|direct_deposit`',
    `plan_name` STRING COMMENT 'Human‑readable name of the health plan.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
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
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan or benefit design associated with the charge.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Each invoice line is posted to the appropriate revenue ledger account for detailed revenue accounting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the covered member or subscriber for this premium charge.',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the parent invoice header to which this line belongs.',
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
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `employee_contribution` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employee (or subscriber).',
    `employer_contribution` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employer on behalf of the member.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim.item)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_refund` BOOLEAN COMMENT 'True if this line represents a refund rather than a charge.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the invoice.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payment_due_date` DATE COMMENT 'Date by which payment for this premium line is due.',
    `payment_status` STRING COMMENT 'Current payment status for the premium line.. Valid values are `due|paid|failed|waived`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Base premium amount before any contributions, subsidies, or adjustments.',
    `premium_currency` STRING COMMENT 'Three‑letter ISO currency code for the premium amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `premium_line_description` STRING COMMENT 'Free‑form description of the premium line (e.g., "Monthly medical premium for employee only").',
    `premium_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether the line has been reconciled to the general ledger.',
    `premium_source_system` STRING COMMENT 'Name of the source system that generated the premium line (e.g., HealthEdge, CustomBilling).',
    `premium_status` STRING COMMENT 'Current processing status of the premium line.. Valid values are `pending|posted|reversed|cancelled`',
    `rate_type` STRING COMMENT 'Type of premium rate applied to the line (standard, discount, subsidy, retroactive, or other adjustment).. Valid values are `standard|discount|subsidy|retroactive|adjustment`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost center allocation of premium payments enables budgeting and expense tracking per business unit.',
    `application_id` BIGINT COMMENT 'Foreign key linking to credential.application. Business justification: Needed to record payments made for credentialing application fees, supporting financial tracking and compliance reporting.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group responsible for the payment, when applicable.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Cash receipt accounting posts each premium payment to the cash ledger for accurate cash balance reporting.',
    `identity_id` BIGINT COMMENT 'Identifier of the member associated with the premium payment.',
    `policy_id` BIGINT COMMENT 'Identifier of the insurance policy to which the premium payment applies.',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the premium invoice that this payment is applied to.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Payment processing is performed by finance staff; linking enables reconciliation and performance metrics.',
    `adjustment_payment_id` BIGINT COMMENT 'Foreign key linking to risk.adjustment_payment. Business justification: Supports risk‑adjustment payment reconciliation linking each premium payment to its corresponding risk adjustment transaction.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Payments are applied to invoices tied to an enrollment transaction; linking allows tracking payment against the originating enrollment for compliance and financial analysis.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total of fees, discounts, or other adjustments applied to the gross amount.',
    `batch_number` STRING COMMENT 'Identifier of the processing batch that included this payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the payment.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any processing or service fees associated with the payment.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PaymentReconciliation)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after adjustments, representing the amount applied to the invoice.',
    `nsf_indicator` BOOLEAN COMMENT 'True if the payment was returned due to non‑sufficient funds.',
    `payer_account_number` STRING COMMENT 'Account number or identifier used by the payer for the transaction.',
    `payer_name` STRING COMMENT 'Legal name of the entity making the payment.',
    `payer_type` STRING COMMENT 'Classification of the payer (e.g., employer, individual member, CMS, state Medicaid agency).. Valid values are `employer|member|cms|state_medicaid|other`',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total amount received before any adjustments.',
    `payment_channel` STRING COMMENT 'Interface through which the payment was submitted.. Valid values are `web|mobile|call_center|mail|batch|other`',
    `payment_description` STRING COMMENT 'Free‑form description or notes about the payment.',
    `payment_method` STRING COMMENT 'Instrument used to make the payment.. Valid values are `ach|check|wire|credit_card|eft|other`',
    `payment_number` STRING COMMENT 'Unique payment reference number assigned by the billing system.',
    `payment_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was received.',
    `premium_payment_status` STRING COMMENT 'Current lifecycle state of the payment.. Valid values are `pending|posted|failed|cancelled`',
    `reconciliation_status` STRING COMMENT 'Status of the payment in the accounting reconciliation process.. Valid values are `pending|matched|unmatched|exception`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the reconciliation.',
    `invoice_line_id` BIGINT COMMENT 'Identifier of the invoice line to which the payment amount is allocated.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Payment allocation entries are posted to the ledger to reconcile allocated amounts with cash receipts.',
    `premium_payment_id` BIGINT COMMENT 'Identifier of the premium payment that is being allocated.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the premium that is allocated to the invoice line.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of premium units (e.g., member‑months) allocated to the invoice line.',
    `allocation_date` DATE COMMENT 'Calendar date on which the allocation was recorded.',
    `allocation_sequence` STRING COMMENT 'Sequential order of allocation lines within the same payment.',
    `allocation_status` STRING COMMENT 'Current processing status of the allocation record.. Valid values are `allocated|pending|rejected|adjusted|closed`',
    `allocation_type` STRING COMMENT 'Classification of the allocation purpose (e.g., standard payment, partial payment, over‑payment, suspense resolution, adjustment, refund).. Valid values are `standard|partial|overpayment|suspense_resolution|adjustment|refund`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the allocated amount.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount or credit applied to the allocated premium.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the allocation becomes effective for accounting purposes.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the allocation ceases to be effective (null if open‑ended).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Location)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_overpayment` BOOLEAN COMMENT 'Indicates whether the allocation represents an overpayment scenario.',
    `is_suspense_resolution` BOOLEAN COMMENT 'True when the allocation resolves a suspense balance.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the allocation.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was submitted.. Valid values are `web|mobile|call_center|in_person|batch|other`',
    `payment_method` STRING COMMENT 'Instrument used to make the premium payment.. Valid values are `credit_card|bank_transfer|cash|check|electronic|other`',
    `reconciliation_period` STRING COMMENT 'Period identifier (e.g., 2023-04) for the premium reconciliation cycle.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle state of the reconciliation record.. Valid values are `open|in_review|approved|closed|rejected`',
    `reconciliation_type` STRING COMMENT 'Frequency classification of the reconciliation (e.g., monthly, quarterly).. Valid values are `monthly|quarterly|annual|ad_hoc`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assign billing accounts to cost centers for consolidated financial reporting of account balances.',
    `employee_id` BIGINT COMMENT 'Name of the internal representative responsible for the account.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for Employer Billing Account Management report linking each billing account to its employer group for contribution tracking and regulatory reporting.',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Group practices receive consolidated reimbursements; the link enables the Group Practice Billing Summary and CMS reporting of provider‑level payments.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Needed for Provider Payment Reconciliation report linking each provider to its billing account for electronic fund transfers and regulatory payment tracking.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network contract billing – each billing account is tied to a provider network contract for negotiated rates and regulatory reporting.',
    `account_number` STRING COMMENT 'External account number assigned to the billing entity for invoicing and payment processing.',
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
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the billing account became effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the billing account is scheduled to terminate (null if open‑ended).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Account)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grace_period_days` STRING COMMENT 'Number of days after the due date before the account is considered delinquent.',
    `invoice_generation_day` STRING COMMENT 'Day of month when the invoice is generated (1‑31).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_invoice_date` DATE COMMENT 'Date when the most recent invoice was generated.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the most recent payment.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received for the account.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_invoice_date` DATE COMMENT 'Scheduled date for the next invoice issuance.',
    `notes` STRING COMMENT 'Free‑form text field for internal comments or special instructions related to the account.',
    `payment_due_amount` DECIMAL(18,2) COMMENT 'Total amount currently due on the account, including any pending charges.',
    `payment_due_day` STRING COMMENT 'Day of month by which payment must be received.',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due after invoice issuance.. Valid values are `net_30|net_45|net_60|due_on_receipt`',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'Rate used to calculate monthly charges on a per‑member basis.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the account is subject to special regulatory reporting (e.g., CMS, state DOI).',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Total subsidy applied to the account (e.g., employer or government subsidies).',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the account is exempt from sales or other applicable taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing account record.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master billing account representing the financial relationship between the health plan and a billing entity — employer group, individual subscriber, or government program (Medicare, Medicaid, CHIP). Captures account number, account type, billing frequency (monthly, quarterly, annual), billing method (self-bill, list-bill, direct-bill), payment terms, auto-pay enrollment, current balance, credit limit, account status, assigned billing representative, billing cycle configuration (cycle type — monthly/quarterly/semi-annual/annual, invoice generation date, payment due date, grace period days, next/last invoice dates, auto-renewal flag, billing calendar reference), and registered payment methods (payment method type — ACH/EFT, check, wire transfer, credit card, debit card, HSA/FSA — with masked/tokenized bank routing and account numbers, card last four digits, card expiration date, auto-pay authorization flag, authorization date and reference, active/inactive status per method, PCI-DSS compliant storage). SSOT for billing account identity, billing cycle configuration, and authorized payment methods.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` (
    `premium_rate_id` BIGINT COMMENT 'System-generated unique identifier for each premium rate record.',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - premium rates are per plan (currently only links to rate_schedule)',
    `rate_schedule_id` BIGINT COMMENT 'FK to billing.rate_schedule',
    `age_band` STRING COMMENT 'Age band classification for age‑rated plans (e.g., 0‑20, 21‑30).',
    `aptc_amount` DECIMAL(18,2) COMMENT 'Amount of APTC applied to the premium for ACA‑eligible members.',
    `cobra_rate` DECIMAL(18,2) COMMENT 'Rate applied to COBRA participants (active employee rate plus 2 % administrative fee).',
    `coverage_tier` STRING COMMENT 'Tier of coverage (e.g., individual, employee + spouse, family) that the rate applies to.. Valid values are `individual|employee_spouse|family|dual`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the premium rate record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the premium rate becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `employee_contribution_rate` DECIMAL(18,2) COMMENT 'Portion of the premium (as a percentage) that the employee contributes.',
    `employer_contribution_rate` DECIMAL(18,2) COMMENT 'Portion of the premium (as a percentage) that the employer contributes.',
    `expiration_date` DATE COMMENT 'Date on which the premium rate expires; null if open‑ended.',
    `family_tier_structure` STRING COMMENT 'Definition of how family members are tiered for premium calculation (e.g., adult, child, infant).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.plan.specificCost)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `market_segment` STRING COMMENT 'Business segment to which the rate applies (individual, group, small group, large group).. Valid values are `individual|group|small_group|large_group`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `plan_code` STRING COMMENT 'External identifier for the health insurance plan to which the rate belongs.',
    `premium_rate_status` STRING COMMENT 'Current lifecycle status of the premium rate record.. Valid values are `active|inactive|pending|retired`',
    `premium_type` STRING COMMENT 'Indicates whether the rate is an Annual Premium Rate (APR) or Per Member Per Month (PMPM) rate.. Valid values are `APR|PMPM`',
    `rate_amount` DECIMAL(18,2) COMMENT 'Base monetary amount (per member per month) before adjustments.',
    `rating_area` STRING COMMENT 'Geographic rating area code used for regional premium variations.',
    `rating_area_reference` STRING COMMENT 'External reference linking the rate to a specific rating‑area master record.',
    `rating_method` STRING COMMENT 'Method used to calculate premiums (e.g., community rated, age‑rated, composite rated, experience rated).. Valid values are `community|age|composite|experience`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_filing_metadata` STRING COMMENT 'Free‑text field capturing additional regulatory filing details (e.g., submission dates, approval status).',
    `state_doi_filing_number` STRING COMMENT 'Reference number for the rate filing submitted to the State Department of Insurance.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Dollar amount of any subsidy applied to the premium (e.g., employer or government subsidy).',
    `tobacco_surcharge_rate` DECIMAL(18,2) COMMENT 'Additional percentage surcharge applied to members who use tobacco.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the premium rate record.',
    `wellness_discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied for members meeting wellness program criteria.',
    CONSTRAINT pk_premium_rate PRIMARY KEY(`premium_rate_id`)
) COMMENT 'Defines the APR (Annual Premium Rate) and PMPM rate structures for a plan, coverage tier, rating area, and effective date range, including the parent rate schedule configuration that governs how rates are structured and applied. Captures rate schedule name, rating method (community rated, age-rated, composite rated, experience rated), market segment, plan code, coverage tier, rating area, age band (for ACA age-rated plans), tobacco surcharge rate and rules, wellness discount rate and rules, employer contribution rate, employee contribution rate, COBRA rate (active employee rate + 2% admin fee), family tier structure, rate effective/expiration dates, state DOI rate filing reference number, rating area reference, and regulatory filing metadata. SSOT for all premium calculation inputs, rate schedule configurations, rate filing metadata, and rate structure definitions used in invoice generation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` (
    `grace_period_id` BIGINT COMMENT 'System-generated unique identifier for the grace period record.',
    `account_id` BIGINT COMMENT 'Identifier of the billing account to which this grace period applies.',
    `identity_id` BIGINT COMMENT 'Identifier of the member associated with the account for this grace period.',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the invoice that triggered the grace period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grace period record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `day_count` STRING COMMENT 'Number of days elapsed since the start of the grace period.',
    `grace_period_description` STRING COMMENT 'Free-text description providing additional context for the grace period.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'Date when the grace period is scheduled to end.',
    `extension_end_date` DATE COMMENT 'New end date if the grace period was extended.',
    `extension_flag` BOOLEAN COMMENT 'Indicates whether the original grace period was extended.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grace_period_number` STRING COMMENT 'External business identifier for the grace period, used in reporting and member communications.',
    `grace_period_status` STRING COMMENT 'Current lifecycle status of the grace period.. Valid values are `active|expired|terminated|reinstated|paid`',
    `grace_period_type` STRING COMMENT 'Classification of the grace period based on product or regulatory rules.. Valid values are `standard|aca_aptc|group|individual`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_eligible_for_aptc` BOOLEAN COMMENT 'Indicates if the member is eligible for Advanced Premium Tax Credit during this grace period.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction applicable to the grace period.. Valid values are `federal|state`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional free-form notes captured by the billing team.',
    `outcome` STRING COMMENT 'Result of the grace period after it ends.. Valid values are `paid|terminated|reinstated|none`',
    `payment_due_date` DATE COMMENT 'The date by which the premium payment was originally due before the grace period started.',
    `payment_received_date` DATE COMMENT 'Date on which the overdue payment was received, if applicable.',
    `reason_code` STRING COMMENT 'Code indicating why the grace period was initiated.. Valid values are `late_payment|non_payment|billing_error|other`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this grace period must be reported to CMS or state DOI.',
    `start_date` DATE COMMENT 'Date when the grace period began.',
    `state_code` STRING COMMENT 'Two-letter state abbreviation for jurisdictional reporting. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product]',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any subsidy applied during the grace period.',
    `termination_warning_issued` BOOLEAN COMMENT 'Indicates whether a termination warning has been sent to the member.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grace period record.',
    CONSTRAINT pk_grace_period PRIMARY KEY(`grace_period_id`)
) COMMENT 'Tracks the grace period status for a billing account or member when premium payment is overdue. Captures grace period start date, grace period end date (typically 30 days for individual/ACA, 31 days for group), grace period type (ACA APTC grace period is 90 days), triggering invoice reference, current grace period day count, termination warning issued flag, and resolution outcome (paid, terminated, reinstated). Required for ACA compliance and state DOI reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` (
    `retro_adjustment_id` BIGINT COMMENT 'System-generated unique identifier for the retroactive billing adjustment record.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the adjustment applies.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the adjustment; positive for additional charge, negative for credit.',
    `adjustment_number` STRING COMMENT 'External reference number for the adjustment as used in communications and audit.',
    `adjustment_status` STRING COMMENT 'Current processing status of the adjustment.. Valid values are `pending|approved|rejected|posted|cancelled`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was recorded in the system.',
    `adjustment_type` STRING COMMENT 'Category of the retroactive adjustment indicating the nature of the change.. Valid values are `add|termination|rate_change|tier_change|dispute_credit|dispute_correction`',
    `authorization_reference` STRING COMMENT 'Reference to any prior authorization supporting the adjustment.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credit_memo_reference` STRING COMMENT 'Identifier of the credit memo generated as a result of the adjustment.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the adjustment amount.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispute_open_date` DATE COMMENT 'Date when the dispute was initially opened.',
    `dispute_status` STRING COMMENT 'Current status of the dispute lifecycle.. Valid values are `open|under_review|resolved|escalated`',
    `dispute_type` STRING COMMENT 'Classification of the dispute prompting the adjustment.. Valid values are `invoice_amount|payment_misapplication|rate_error|retro_adjustment|aptc_discrepancy`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Amount that is under dispute.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `invoice_reference` STRING COMMENT 'Identifier of the invoice impacted by the adjustment.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `original_billing_period_end` DATE COMMENT 'End date of the billing period to which the original charge applied.',
    `original_billing_period_start` DATE COMMENT 'Start date of the billing period to which the original charge applied.',
    `reason_code` STRING COMMENT 'Standardized code describing the business reason for the adjustment.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adjustment record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resolution_date` DATE COMMENT 'Date when the dispute was resolved.',
    `resolution_notes` STRING COMMENT 'Free-text notes describing the resolution details.',
    `resolution_type` STRING COMMENT 'Outcome of the dispute resolution process.. Valid values are `credit_issued|invoice_corrected|upheld`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_retro_adjustment PRIMARY KEY(`retro_adjustment_id`)
) COMMENT 'Captures retroactive premium adjustments and billing disputes resulting from enrollment changes, eligibility corrections, rate corrections, COB updates, or contested billing amounts applied to prior billing periods. Records adjustment type (add, term, rate change, tier change, dispute credit, dispute correction), original billing period, adjustment amount (positive or negative), reason code, dispute tracking fields (dispute type — invoice amount, payment misapplication, rate error, retro adjustment, APTC discrepancy — disputed amount, dispute open date, dispute status — open, under review, resolved, escalated — resolution type — credit issued, invoice corrected, upheld — resolution date, resolution notes), authorization reference, and resulting invoice or credit memo reference. SSOT for all retroactive billing adjustments and billing dispute resolution in the billing domain. Critical for accurate premium reconciliation, dispute lifecycle management, and financial reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` (
    `premium_refund_id` BIGINT COMMENT 'System-generated unique identifier for the premium refund record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Refunds must be reported to regulators for premium refund compliance.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group associated with the refund, if applicable.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member receiving the refund.',
    `policy_id` BIGINT COMMENT 'Identifier of the insurance policy linked to the refund.',
    `premium_payment_id` BIGINT COMMENT 'Identifier of the original premium payment that is being refunded.',
    `employee_id` BIGINT COMMENT 'System user who created the refund record.',
    `header_id` BIGINT COMMENT 'Identifier of a claim associated with the refund, if applicable.',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of an invoice linked to the refund transaction.',
    `approval_status` STRING COMMENT 'Approval outcome for the refund request.. Valid values are `pending|approved|rejected`',
    `cleared_timestamp` TIMESTAMP COMMENT 'Date and time when the refund cleared the financial system.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_partial_refund` BOOLEAN COMMENT 'Flag indicating whether the refund covers only part of the original payment.',
    `is_tax_refund` BOOLEAN COMMENT 'Flag indicating whether the refund includes a tax component.',
    `issued_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was issued to the payee.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the refund transaction.. Valid values are `draft|submitted|approved|processed|cancelled|reversed`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `original_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the original premium payment before refund.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the refund record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the refund record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total monetary amount refunded to the member, employer, or government program.',
    `refund_batch_number` STRING COMMENT 'Batch identifier for grouping multiple refunds processed together.',
    `refund_currency` STRING COMMENT 'Three-letter ISO currency code for the refund amount (e.g., USD).',
    `refund_method` STRING COMMENT 'Method used to return the refund to the payee.. Valid values are `ACH|check|credit_to_account|wire|online|other`',
    `refund_notes` STRING COMMENT 'Internal notes or comments related to the refund.',
    `refund_number` STRING COMMENT 'External business identifier assigned to the refund transaction.',
    `refund_processing_fee` DECIMAL(18,2) COMMENT 'Any fee charged for processing the refund.',
    `refund_reason_code` STRING COMMENT 'Standardized code representing the business reason for the refund.',
    `refund_reason_description` STRING COMMENT 'Free-text description of why the refund was issued.',
    `refund_type` STRING COMMENT 'Categorization of the refund based on business cause.. Valid values are `overpayment|termination|rate_correction|plan_cancellation|adjustment|other`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if the refund must be reported to regulatory bodies (e.g., CMS, DOI).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Amount of tax returned as part of the refund.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_premium_refund PRIMARY KEY(`premium_refund_id`)
) COMMENT 'Records premium refunds issued to employer groups, individual members, or government programs due to overpayment, retroactive termination, rate correction, or plan cancellation. Captures refund amount, refund method (ACH, check, credit to account), original payment reference, refund reason code, approval status, issued date, and cleared date. Supports accounts payable integration with Oracle Financials.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` (
    `aptc_subsidy_id` BIGINT COMMENT 'System-generated unique identifier for the APTC subsidy record.',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - APTC is computed per QHP',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member receiving the subsidy.',
    `premium_invoice_id` BIGINT COMMENT 'add column premium_invoice_id (BIGINT) with FK to billing.premium_invoice.premium_invoice_id - subsidies offset specific invoices',
    `annual_aptc_cap` DECIMAL(18,2) COMMENT 'Maximum total APTC amount the member may receive in a calendar year.',
    `aptc_monthly_amount` DECIMAL(18,2) COMMENT 'Monthly amount of APTC applied to the members premium.',
    `aptc_subsidy_status` STRING COMMENT 'Overall lifecycle status of the subsidy record.. Valid values are `active|inactive|terminated|pending`',
    `cms_reconciliation_status` STRING COMMENT 'Current status of the subsidy record in CMS premium remittance reconciliation.. Valid values are `pending|reconciled|error`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subsidy record was first created in the system.',
    `csr_variant` STRING COMMENT 'CSR variant percentage (73%, 87%, or 94%) applicable to the member.. Valid values are `73|87|94`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exchange_code` STRING COMMENT 'Identifier of the marketplace exchange where the member enrolled.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `qhp_plan_code` STRING COMMENT 'Code of the Qualified Health Plan associated with the subsidy.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
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
    `transaction_id` BIGINT COMMENT 'Unique identifier for the transaction as assigned by CMS.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: CMS remittance submissions are tied to specific CMS regulatory obligations.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan or benefit package for which the remittance applies.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the remittance.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider (if applicable) linked to the remittance.',
    `adjustment_reason` STRING COMMENT 'Free‑text description explaining any manual adjustments applied to the remittance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the remittance record was first loaded into the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the remittance amounts (e.g., USD).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `edi_820_reference` STRING COMMENT 'Reference number of the associated EDI 820 payment file.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gross_payment_amount` DECIMAL(18,2) COMMENT 'Total amount paid by CMS before any adjustments or offsets.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_eligible` BOOLEAN COMMENT 'Indicates whether the member was eligible for the payment period.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mlr_rebate_offset_amount` DECIMAL(18,2) COMMENT 'Medical Loss Ratio rebate offset applied to the gross payment.',
    `net_remittance_amount` DECIMAL(18,2) COMMENT 'Final amount after all adjustments, representing the amount to be credited to the insurer.',
    `payment_period_end` DATE COMMENT 'Last day of the payment period for which the remittance applies.',
    `payment_period_start` DATE COMMENT 'First day of the payment period for which the remittance applies.',
    `payment_type` STRING COMMENT 'Category of CMS payment such as capitation, risk corridor, reinsurance, or risk adjustment.. Valid values are `capitation|risk_corridor|reinsurance|risk_adjustment|other`',
    `reconciliation_status` STRING COMMENT 'Current status of the remittance reconciliation process.. Valid values are `pending|reconciled|exception|adjusted`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `remittance_number` STRING COMMENT 'External reference number assigned by CMS for the remittance transaction.',
    `remittance_status` STRING COMMENT 'Lifecycle state of the remittance record within the insurers system.. Valid values are `received|processed|posted|rejected`',
    `remittance_timestamp` TIMESTAMP COMMENT 'Date and time when the remittance was received from CMS.',
    `risk_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount related to risk adjustment transfers included in the remittance.',
    `submission_type` STRING COMMENT 'Method by which the remittance data was submitted to the insurer.. Valid values are `electronic|paper|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the remittance record.',
    CONSTRAINT pk_cms_remittance PRIMARY KEY(`cms_remittance_id`)
) COMMENT 'Records CMS premium remittance transactions for Medicare Advantage (MA), Part D, and ACA QHP plans. Captures CMS payment type (capitation, risk corridor, reinsurance, risk adjustment transfer), payment period, gross payment amount, risk adjustment amount, MLR rebate offset, net remittance amount, CMS transaction ID, 820 EDI transaction reference, and reconciliation status. SSOT for government premium remittance from CMS.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`cycle` (
    `cycle_id` BIGINT COMMENT 'Unique system-generated identifier for the billing cycle configuration.',
    `account_id` BIGINT COMMENT 'Identifier of the member or group account to which this cycle applies.',
    `billing_calendar_id` BIGINT COMMENT 'Reference to the calendar that defines holidays and non‑billing days.',
    `renewal_cycle_id` BIGINT COMMENT 'Identifier of the next billing cycle that follows this one upon renewal.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the billing cycle automatically renews at the end of its term.',
    `billing_frequency_months` STRING COMMENT 'Number of months that define one billing period (e.g., 1 for monthly, 3 for quarterly).',
    `billing_method` STRING COMMENT 'Method used to deliver the invoice to the member or group.. Valid values are `electronic|paper|direct_debit|credit_card`',
    `cycle_code` STRING COMMENT 'Business-visible code that uniquely identifies the billing cycle configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing cycle record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the billing cycle.. Valid values are `active|inactive|suspended|pending|closed`',
    `cycle_type` STRING COMMENT 'Classification of the billing cycle frequency.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `default_premium_amount` DECIMAL(18,2) COMMENT 'Standard premium amount before any adjustments.',
    `cycle_description` STRING COMMENT 'Free‑form text describing special rules or notes for the cycle.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the default premium.',
    `effective_end_date` DATE COMMENT 'Date when the billing cycle ends; null for open‑ended cycles.',
    `effective_start_date` DATE COMMENT 'Date when the billing cycle becomes effective.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grace_period_days` STRING COMMENT 'Number of days after the due date before the account is considered delinquent.',
    `invoice_day_of_month` STRING COMMENT 'Calendar day of the month when the invoice is generated (1‑28).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_pro_rata` BOOLEAN COMMENT 'Indicates whether the cycle amount is prorated based on start/stop dates.',
    `last_invoice_date` DATE COMMENT 'Date when the most recent invoice was generated.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Premium amount after discounts but before taxes.',
    `next_invoice_date` DATE COMMENT 'Scheduled date for the next invoice generation.',
    `payment_due_day_offset` STRING COMMENT 'Number of days after the invoice date that payment is due.',
    `prorated_amount` DECIMAL(18,2) COMMENT 'Calculated amount when the cycle is prorated.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component added to the net premium.',
    `total_amount` DECIMAL(18,2) COMMENT 'Sum of net premium, tax, and any other charges.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing cycle record.',
    CONSTRAINT pk_cycle PRIMARY KEY(`cycle_id`)
) COMMENT 'Defines the billing cycle configuration for a billing account or group, specifying billing frequency, invoice generation date, payment due date, grace period days, billing method, and cycle status. Captures cycle type (monthly, quarterly, semi-annual, annual), next invoice date, last invoice date, auto-renewal flag, and billing calendar reference. Drives the automated invoice generation schedule in HealthEdge.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` (
    `collection_case_id` BIGINT COMMENT 'System-generated unique identifier for the collection case.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Collection cases identified as audit findings require linkage for regulatory monitoring.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Collections team assigns a case owner; linking supports case management dashboards and compliance.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member whose premium is in delinquency.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external collection agency assigned to the case.',
    `action_count` STRING COMMENT 'Total number of collection actions recorded for the case.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustments (fees, penalties, interest) applied to the delinquent amount.',
    `case_closed_timestamp` TIMESTAMP COMMENT 'Date and time when the collection case reached a terminal state (resolved, written off, or closed).',
    `case_number` STRING COMMENT 'External case number used in communications and reporting.',
    `case_open_timestamp` TIMESTAMP COMMENT 'Date and time when the collection case was initially opened.',
    `collection_case_status` STRING COMMENT 'Current lifecycle status of the collection case (e.g., pre-collection, first notice, second notice, active collection, agency referral, legal, written off, resolved).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collection case record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delinquency_age_days` STRING COMMENT 'Number of days the premium has been delinquent.',
    `delinquent_amount` DECIMAL(18,2) COMMENT 'Total premium amount that is past due at the time the case is created.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `final_resolution` STRING COMMENT 'Outcome of the collection case after closure.. Valid values are `paid_in_full|partial_payment|written_off|bankruptcy|plan_termination`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_action_date` DATE COMMENT 'Date when the most recent collection action occurred.',
    `last_action_type` STRING COMMENT 'Type of the most recent collection action taken.. Valid values are `notice_sent|payment_arranged|legal_action|write_off|reinstated`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Net amount owed after adjustments, before any payments.',
    `notes` STRING COMMENT 'Free‑form notes entered by collection agents or supervisors.',
    `payment_plan_arrangement_details` STRING COMMENT 'Details of any payment plan agreed with the member (installments, amounts, schedule).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `referral_date` DATE COMMENT 'Date the case was referred to a collection agency.',
    `reinstatement_conditions` STRING COMMENT 'Textual description of conditions required for reinstatement (e.g., payment of past due plus fees).',
    `reinstatement_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the member is eligible for policy reinstatement after collection.',
    `termination_notice_issued_date` DATE COMMENT 'Date a termination notice was sent to the member.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the collection case record.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount of the delinquent balance that has been written off as bad debt.',
    `write_off_approval_reference` STRING COMMENT 'Reference number or note indicating approval authority for the write‑off.',
    CONSTRAINT pk_collection_case PRIMARY KEY(`collection_case_id`)
) COMMENT 'Tracks premium collection activities for delinquent billing accounts from initial delinquency through final resolution. Captures collection status (pre-collection, first notice, second notice, active collection, agency referral, legal, written off, resolved), delinquency amount, delinquency age in days, collection agency assignment and referral date, collection action history with dated entries and action types, termination notice issued date, reinstatement eligibility flag and conditions, write-off amount and approval reference, payment plan arrangement details, and final resolution (paid in full, partial payment accepted, written off, bankruptcy, plan termination). Supports collections workflow, bad debt management, state DOI delinquency reporting, and financial write-off reporting to Oracle Financials.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` (
    `premium_reconciliation_id` BIGINT COMMENT 'System-generated unique identifier for each premium reconciliation record.',
    `cms_remittance_id` BIGINT COMMENT 'Identifier linking to the CMS remittance record associated with this reconciliation.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Reconciliation reports are filed to satisfy premium accounting regulatory obligations.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the reconciliation.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group associated with the member.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the premium is billed.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Premium reconciliation generates journal entries to reflect net premium earned and adjustments in the accounting system.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member whose premium is being reconciled.',
    `transaction_id` BIGINT COMMENT 'Identifier of the enrollment record that drives expected premium calculations.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the reconciliation was formally approved.',
    `apr_rate` DECIMAL(18,2) COMMENT 'Rate used to calculate monthly premium based on member coverage.',
    `aptc_subsidy_amount` DECIMAL(18,2) COMMENT 'Subsidy amount applied to the members premium under ACA marketplace rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_finalized` BOOLEAN COMMENT 'True when the reconciliation has been closed and no further changes are allowed.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mlr_input_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation record is included in MLR calculations.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Net premium after subtracting adjustments from the total billed amount.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by the reconciler.',
    `period_end_date` DATE COMMENT 'Last calendar date of the premium reconciliation period.',
    `period_start_date` DATE COMMENT 'First calendar date of the premium reconciliation period.',
    `pm_amount` DECIMAL(18,2) COMMENT 'Standardized premium amount calculated on a per‑member‑per‑month basis.',
    `premium_reconciliation_status` STRING COMMENT 'Current lifecycle state of the reconciliation record.. Valid values are `open|in_review|approved|closed`',
    `reconciliation_number` STRING COMMENT 'External reference number assigned to the reconciliation process for tracking and audit.',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the reconciliation was executed.',
    `reconciliation_type` STRING COMMENT 'Frequency classification of the reconciliation (monthly, quarterly, or annual).. Valid values are `monthly|quarterly|annual`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation is included in statutory reporting (e.g., CMS, DOI).',
    `state_code` STRING COMMENT 'Two‑letter US state code for state‑level reporting and regulatory filing.',
    `total_adjustments_amount` DECIMAL(18,2) COMMENT 'Aggregate of all adjustments (credits, refunds, write‑offs) applied during reconciliation.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Sum of all premium amounts billed for the period before any payments or adjustments.',
    `total_collected_amount` DECIMAL(18,2) COMMENT 'Sum of all premium payments received for the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the reconciliation record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between expected premium (based on enrollment) and net premium collected.',
    `variance_reason` STRING COMMENT 'Narrative explanation for any premium variance identified.',
    CONSTRAINT pk_premium_reconciliation PRIMARY KEY(`premium_reconciliation_id`)
) COMMENT 'Captures the monthly or periodic premium reconciliation process between billed premium, received payments, enrollment-based expected premium, and CMS/state remittances. Records reconciliation period, total billed, total collected, total adjustments, variance amount, variance reason, reconciliation status (open, in review, approved, closed), and approver reference. Supports MLR calculation inputs and financial close processes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` (
    `cobra_billing_id` BIGINT COMMENT 'System-generated unique identifier for the COBRA billing record.',
    `cobra_election_id` BIGINT COMMENT 'add column cobra_election_id (BIGINT) with FK to enrollment.cobra_election.cobra_election_id - COBRA billing aligns to election',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: COBRA billing must comply with ERISA/DOL regulatory obligations and be reported.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group from which the original coverage originated.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with the COBRA coverage.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the qualified beneficiary who elected COBRA coverage.',
    `admin_fee_amount` DECIMAL(18,2) COMMENT 'Additional 2% administrative fee applied to the base premium for COBRA.',
    `billing_cycle_month` STRING COMMENT 'Year‑month (YYYYMM) representing the billing cycle for the premium.',
    `billing_issue_timestamp` TIMESTAMP COMMENT 'Date‑time when the COBRA invoice was generated.',
    `billing_number` STRING COMMENT 'External billing reference number assigned to the COBRA invoice.',
    `cobra_status` STRING COMMENT 'Lifecycle state of the COBRA coverage for the beneficiary.. Valid values are `elected|active|lapsed|exhausted|terminated`',
    `compliance_flag_dol` BOOLEAN COMMENT 'Indicates whether the billing record meets Department of Labor regulatory requirements.',
    `compliance_flag_erisa` BOOLEAN COMMENT 'Indicates whether the billing record complies with ERISA regulations.',
    `coverage_end_date` DATE COMMENT 'Last day of COBRA coverage eligibility (or expected termination).',
    `coverage_start_date` DATE COMMENT 'First day of COBRA coverage eligibility.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COBRA billing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the premium amounts (e.g., USD).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `election_reference` STRING COMMENT 'Reference code linking to the members COBRA election election record.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `initial_grace_period_days` STRING COMMENT 'Number of days (typically 45) after the due date during which payment is still accepted without penalty.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_deleted` BOOLEAN COMMENT 'Logical delete flag indicating the record has been soft‑deleted.',
    `last_payment_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent payment received for this COBRA billing.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special handling instructions.',
    `ongoing_grace_period_days` STRING COMMENT 'Number of days (typically 30) after each subsequent due date during which payment is accepted.',
    `payment_due_date` DATE COMMENT 'Date by which the first COBRA premium payment must be received.',
    `payment_method` STRING COMMENT 'Method used for the premium payment.. Valid values are `check|credit_card|direct_debit|online|other`',
    `payment_reference` STRING COMMENT 'Reference identifier for the payment transaction (e.g., check number, transaction ID).',
    `payment_status` STRING COMMENT 'Current status of the COBRA premium payment.. Valid values are `pending|paid|failed|cancelled`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount based on the active employee rate before administrative fees.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Indicates whether the record is currently active in the system.. Valid values are `active|inactive`',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the beneficiary for over‑payment or termination.',
    `retroactive_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any retroactive premium adjustment.',
    `retroactive_adjustment_flag` BOOLEAN COMMENT 'Indicates whether a retroactive premium adjustment has been applied.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Sum of base premium and administrative fee for the billing period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COBRA billing record.',
    CONSTRAINT pk_cobra_billing PRIMARY KEY(`cobra_billing_id`)
) COMMENT 'Manages COBRA premium billing for qualified beneficiaries who have lost employer-sponsored coverage. Captures COBRA election reference, qualified beneficiary identity, COBRA coverage period, applicable premium (active employee rate + 2% administrative fee), payment due dates, 45-day initial payment grace period, 30-day ongoing grace period, COBRA status (elected, active, lapsed, exhausted), and DOL/ERISA compliance flags. Distinct from standard group billing due to COBRA-specific regulatory requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` (
    `edi_820_id` BIGINT COMMENT 'Unique surrogate key for the EDI 820 transaction record.',
    `identity_id` BIGINT COMMENT 'Member who is the recipient of the premium payment.',
    `provider_id` BIGINT COMMENT 'Provider (or other payee) associated with the payment.',
    `batch_number` STRING COMMENT 'Batch identifier grouping multiple EDI 820 transactions processed together.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment event occurred in the business process.',
    `business_identifier` STRING COMMENT 'Unique business reference number for the EDI 820 transaction (e.g., remittance advice number).',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `direction` STRING COMMENT 'Indicates whether the EDI 820 transaction was received from a payer (inbound) or sent to a payer (outbound).. Valid values are `inbound|outbound`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `error_code` STRING COMMENT 'Error or rejection code returned by the clearinghouse if processing failed.',
    `error_description` STRING COMMENT 'Human readable description of the error code.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `invoice_reference` STRING COMMENT 'Reference number of the invoice or premium bill associated with the payment.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_reconciled` BOOLEAN COMMENT 'Flag indicating whether the payment has been reconciled to the corresponding invoice.',
    `isa_receiver_qualifier_code` STRING COMMENT 'Interchange Receiver ID (ISA08) identifying the receiving trading partner.',
    `isa_sender_qualifier_code` STRING COMMENT 'Interchange Sender ID (ISA06) identifying the sending trading partner.',
    `lifecycle_status` STRING COMMENT 'Current processing status of the transaction.. Valid values are `received|validated|applied|rejected`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payee_npi` STRING COMMENT 'National Provider Identifier (NPI) of the payee (member or provider) receiving the payment.',
    `payer_npi` STRING COMMENT 'National Provider Identifier (NPI) of the payer entity.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the payment.',
    `payment_date` DATE COMMENT 'Date the payment was made or is scheduled.',
    `payment_method_code` STRING COMMENT 'Code representing the payment instrument used.. Valid values are `ACH|Check|CreditCard|Wire`',
    `payment_type` STRING COMMENT 'Indicates the nature of the payment.. Valid values are `Premium|Refund|Adjustment`',
    `processing_notes` STRING COMMENT 'Free-text notes captured during processing.',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Timestamp when reconciliation was completed.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the transaction record was first captured in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `remittance_advice_number` STRING COMMENT 'Remittance advice number assigned by the payer.',
    `settlement_date` DATE COMMENT 'Date on which the payment is settled in the financial system.',
    `transaction_set_control_number` STRING COMMENT 'EDI transaction set identifier for payment order/remittance advice (always 820).. Valid values are `820`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_edi_820 PRIMARY KEY(`edi_820_id`)
) COMMENT 'Stores inbound and outbound EDI 820 (Premium Payment Order/Remittance Advice) transaction records processed through the Availity or Change Healthcare clearinghouse. Captures transaction set ID, sender/receiver ISA identifiers, transaction direction (inbound/outbound), payer/payee NPI or TIN, payment amount, payment date, payment method code, associated invoice references, processing status (received, validated, applied, rejected), and error codes. SSOT for EDI premium payment transactions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` (
    `suspense_account_id` BIGINT COMMENT 'System-generated unique identifier for the suspense account record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or team member assigned to resolve the suspense item.',
    `payer_billing_role_id` BIGINT COMMENT 'Internal identifier of the entity that made the payment (member, employer, or other).',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount received for the unidentified payment.',
    `batch_number` STRING COMMENT 'Identifier of the batch or file in which the payment was received.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the suspense account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the payment amount.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Account)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_amount_mismatch` BOOLEAN COMMENT 'Indicates whether the payment amount does not match any outstanding invoice.',
    `is_duplicate` BOOLEAN COMMENT 'Indicates whether the payment appears to be a duplicate of another received payment.',
    `is_overpayment` BOOLEAN COMMENT 'Indicates whether the received amount exceeds the expected invoice amount.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes documenting details, comments, or actions related to the suspense item.',
    `payer_account_reference` STRING COMMENT 'Reference number or identifier of the payers account when known.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was submitted.. Valid values are `web|mobile|call_center|mail|in_person`',
    `payment_method` STRING COMMENT 'Instrument used to make the payment.. Valid values are `check|cash|credit_card|debit_card|electronic_transfer|online_payment`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the unidentified payment was received.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resolution_due_date` DATE COMMENT 'Date by which the suspense item should be resolved.',
    `resolution_outcome` STRING COMMENT 'Result of the resolution process for the suspense payment.. Valid values are `applied|refunded|written_off|pending|rejected`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the resolution action was performed.',
    `suspense_account_status` STRING COMMENT 'Current lifecycle status of the suspense account record.. Valid values are `open|in_process|resolved|closed|cancelled`',
    `suspense_number` STRING COMMENT 'Business identifier assigned to the suspense account for tracking and reconciliation.',
    `suspense_reason` STRING COMMENT 'Reason why the payment was placed in suspense.. Valid values are `unidentified_payer|amount_mismatch|duplicate_payment|missing_invoice|other`',
    `transaction_reference` STRING COMMENT 'Reference number from the original payment transaction (e.g., check number, EFT reference).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the suspense account record.',
    CONSTRAINT pk_suspense_account PRIMARY KEY(`suspense_account_id`)
) COMMENT 'Tracks unidentified or unallocated premium payments held in suspense pending resolution. Captures received amount, receipt date, payer name, payer account reference (if known), payment method, suspense reason (unidentified payer, amount mismatch, duplicate payment, missing invoice reference), assigned resolver, resolution due date, and resolution outcome (applied, refunded, written off). Supports cash management and AR reconciliation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` (
    `mlr_rebate_id` BIGINT COMMENT 'System-generated unique identifier for the MLR rebate record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: MLR rebate calculations are reported under specific MLR regulatory obligations.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which the rebate applies.',
    `calculation_method` STRING COMMENT 'Methodology used to compute the rebate (standard CMS formula or custom adjustment).. Valid values are `standard|custom`',
    `calculation_timestamp` TIMESTAMP COMMENT 'Timestamp when the MLR rebate amount was calculated.',
    `cms_filing_reference` STRING COMMENT 'Identifier of the CMS filing that includes this rebate information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rebate record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disbursement_date` DATE COMMENT 'Date on which the rebate was paid or applied.',
    `disbursement_method` STRING COMMENT 'Method used to deliver the rebate (check, premium credit, or enrollment reduction).. Valid values are `check|premium_credit|enrollment_reduction`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Start date of the period for which the rebate calculation is valid.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'End date of the period for which the rebate calculation is valid (null if open‑ended).',
    `eligibility_flag` BOOLEAN COMMENT 'Indicates whether the rebate meets all eligibility criteria for payment.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hhs_submission_status` STRING COMMENT 'Status of the annual MLR reporting submission to HHS.. Valid values are `submitted|pending|rejected`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Business line (e.g., individual, group, Medicare, Medicaid) associated with the rebate.',
    `market_segment` STRING COMMENT 'Segment of the market the rebate applies to (individual, small group, or large group).. Valid values are `individual|small_group|large_group`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mlr_percentage` DECIMAL(18,2) COMMENT 'Calculated MLR ratio (claims + QI expenses) divided by earned premium, expressed as a percent.',
    `mlr_rebate_status` STRING COMMENT 'Current lifecycle status of the rebate record.. Valid values are `pending|approved|rejected|paid`',
    `notes` STRING COMMENT 'Free‑form text for any additional comments or explanations about the rebate.',
    `quality_improvement_expenses` DECIMAL(18,2) COMMENT 'Qualified expenses that improve quality of care, counted toward the MLR numerator.',
    `rebate_amount_due` DECIMAL(18,2) COMMENT 'Dollar amount of rebate owed to the member or group after MLR calculation.',
    `rebate_number` STRING COMMENT 'External reference number assigned to the rebate calculation.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reporting_year` STRING COMMENT 'Calendar year for which the MLR rebate is calculated.',
    `state_code` STRING COMMENT 'Two‑letter US state abbreviation where the rebate is reported.. Valid values are `^[A-Z]{2}$`',
    `total_incurred_claims` DECIMAL(18,2) COMMENT 'Sum of claim payments incurred during the reporting period.',
    `total_premium_earned` DECIMAL(18,2) COMMENT 'Aggregate premium dollars earned for the reporting period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rebate record.',
    CONSTRAINT pk_mlr_rebate PRIMARY KEY(`mlr_rebate_id`)
) COMMENT 'Captures Medical Loss Ratio (MLR) rebate calculations and disbursements required under ACA Section 2718. Records market segment (individual, small group, large group), state, LOB, reporting year, total premium earned, total incurred claims, quality improvement expenses, MLR percentage, rebate amount due, rebate disbursement method (check, premium credit, enrollment reduction), disbursement date, CMS filing reference, and HHS annual MLR reporting submission status. Owned by billing as the premium revenue source system that feeds MLR numerator/denominator calculations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` (
    `payment_method_id` BIGINT COMMENT 'System-generated unique identifier for the payment method record.',
    `account_id` BIGINT COMMENT 'Identifier of the billing account to which this payment method is attached.',
    `bank_account_id` BIGINT COMMENT 'add column bank_account_id (BIGINT) with FK to finance.bank_account.bank_account_id - payment methods reference bank accounts for ACH',
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
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date the payment method becomes effective for billing.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date the payment method expires or is deactivated (null if open‑ended).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PaymentReconciliation)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `holder_name` STRING COMMENT 'Legal name of the individual to whom the card is issued.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_auto_pay` BOOLEAN COMMENT 'Indicates whether the member has authorized automatic recurring payments using this method.',
    `masked_account_number` STRING COMMENT 'Bank account number with middle digits masked for PCI‑DSS compliance.',
    `masked_routing_number` STRING COMMENT 'Bank routing number with middle digits masked to meet PCI‑DSS requirements.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `method_type` STRING COMMENT 'Category of the payment instrument (e.g., ACH, Check, Wire, Credit Card, Debit Card, Health Savings Account).. Valid values are `ACH|Check|Wire|CreditCard|DebitCard|HSA`',
    `notes` STRING COMMENT 'Free‑form text for operational comments or special handling instructions.',
    `payment_method_status` STRING COMMENT 'Current lifecycle state of the payment method.. Valid values are `active|inactive|suspended|pending`',
    `pci_compliance_flag` BOOLEAN COMMENT 'Indicates whether the stored payment method meets PCI‑DSS compliance.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by the payment processor (0.00‑99.99).',
    `tokenized_account_number` STRING COMMENT 'PCI‑token representing the full bank account number for secure storage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment method record.',
    `verification_status` STRING COMMENT 'Result of the payment method verification process.. Valid values are `verified|unverified|failed`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date‑time when verification was performed.',
    CONSTRAINT pk_payment_method PRIMARY KEY(`payment_method_id`)
) COMMENT 'Master record of authorized payment methods registered for a billing account, capturing payment method type (ACH/EFT, check, wire transfer, credit card, debit card, HSA/FSA), bank routing number (masked), bank account number (masked/tokenized), card last four digits, card expiration date, auto-pay authorization flag, authorization date, authorization reference, and active/inactive status. Supports PCI-DSS compliant payment processing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` (
    `premium_statement_id` BIGINT COMMENT 'System-generated unique identifier for the premium statement record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier of the health insurance plan associated with the statement.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the premium statement is issued.',
    `employee_id` BIGINT COMMENT 'System user identifier who last modified the premium statement record.',
    `premium_rate_id` BIGINT COMMENT 'Reference to the premium rate schedule used to calculate the gross premium.',
    `premium_statement_generator_employee_id` BIGINT COMMENT 'System user identifier who created the premium statement record.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for any manual adjustment to the statement.',
    `aptc_amount` DECIMAL(18,2) COMMENT 'Amount of APTC subsidy applied to reduce the members premium.',
    `billing_cycle` STRING COMMENT 'Identifier for the billing cycle (e.g., 2024-01, 2024-Q1).',
    `coverage_end_date` DATE COMMENT 'Last day of the coverage period for which the premium is billed.',
    `coverage_start_date` DATE COMMENT 'First day of the coverage period for which the premium is billed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the premium statement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_method` STRING COMMENT 'Channel used to deliver the premium statement to the member.. Valid values are `mail|email|portal`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to the premium before tax calculation.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gross_premium_amount` DECIMAL(18,2) COMMENT 'Total premium before any subsidies, discounts, or adjustments.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_eligible_for_subsidy` BOOLEAN COMMENT 'Indicates whether the member qualifies for APTC or other subsidies.',
    `is_late_payment_flag` BOOLEAN COMMENT 'Flag indicating whether the payment is past the due date.',
    `is_refund` BOOLEAN COMMENT 'Indicates whether the statement represents a refund rather than a charge.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Additional fee assessed for late payment, if applicable.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_premium_due` DECIMAL(18,2) COMMENT 'Final premium amount the member must pay after subsidies and adjustments.',
    `notes` STRING COMMENT 'Free‑form text field for internal comments or member communications.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was received.. Valid values are `web|mobile|call_center|mail|portal`',
    `payment_due_date` DATE COMMENT 'Date by which the member must remit payment to avoid late fees.',
    `payment_method` STRING COMMENT 'Instrument used by the member to remit payment.. Valid values are `credit_card|bank_transfer|check|cash|online|other`',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Rebate or discount applied to the premium after statement issuance.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the member if the statement is a refund.',
    `statement_date` DATE COMMENT 'Date the premium statement was generated and issued to the member.',
    `statement_number` STRING COMMENT 'Business identifier assigned to the premium statement, used for member communication and accounting.',
    `statement_pdf_url` STRING COMMENT 'Link to the generated PDF version of the premium statement.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the premium statement.. Valid values are `draft|issued|sent|paid|cancelled|void`',
    `statement_type` STRING COMMENT 'Classification of the statement based on enrollment type.. Valid values are `individual|family|group`',
    `statement_version` STRING COMMENT 'Version number of the statement for revisions or re‑issuances.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Total subsidy amount applied to this statement (including APTC).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the premium, if applicable.',
    `total_payments_applied` DECIMAL(18,2) COMMENT 'Sum of all payments that have been allocated to this statement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the premium statement record.',
    CONSTRAINT pk_premium_statement PRIMARY KEY(`premium_statement_id`)
) COMMENT 'Individual member premium statement (distinct from group invoice) generated for direct-pay individual and family plan (IFP) members. Captures statement number, statement date, member reference, plan name, coverage period, gross premium, APTC applied, net premium due, payment due date, statement delivery method (mail, email, portal), and statement status. Supports member self-service portal and ACA marketplace member communications.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` (
    `rate_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the rate schedule configuration.',
    `rate_health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - rate schedules must be associated with the health plan they price',
    `rate_plan_health_plan_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
    `health_plan_id` BIGINT COMMENT '',
    `applicable_year` STRING COMMENT 'Plan year to which the rate schedule applies.',
    `aptc_amount` DECIMAL(18,2) COMMENT 'Advance Premium Tax Credit amount applied to the premium.',
    `cobra_rate` DECIMAL(18,2) COMMENT 'Premium rate applied to COBRA continuation coverage participants.',
    `coverage_type` STRING COMMENT 'Type of coverage the schedule governs (medical, dental, vision, pharmacy).. Valid values are `medical|dental|vision|rx`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate schedule record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `rate_schedule_description` STRING COMMENT 'Free‑form description providing additional context or notes about the schedule.',
    `effective_date` DATE COMMENT 'Date on which the rate schedule becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `employee_contribution_rate` DECIMAL(18,2) COMMENT 'Rate at which the employee contributes toward the premium.',
    `employer_contribution_rate` DECIMAL(18,2) COMMENT 'Rate at which an employer contributes toward the members premium.',
    `expiration_date` DATE COMMENT 'Date on which the rate schedule expires or is superseded.',
    `family_tier_structure` STRING COMMENT 'Definition of family tier tiers (e.g., employee only, employee+spouse, employee+children) and associated premium multipliers.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.plan.specificCost)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_date` DATE COMMENT 'Date the filing was submitted to the state regulator.',
    `filing_status` STRING COMMENT 'Current status of the regulatory filing with the state DOI.. Valid values are `filed|pending|rejected`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_default_schedule` BOOLEAN COMMENT 'Indicates whether this schedule is the default for its plan and market segment.',
    `last_review_date` DATE COMMENT 'Date when the schedule was last reviewed for compliance or rate updates.',
    `market_segment` STRING COMMENT 'Segment of the market the schedule applies to (individual, group, etc.).. Valid values are `individual|group|small_group|large_group`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `plan_code` STRING COMMENT 'Identifier of the health insurance plan to which the rate schedule is attached.',
    `premium_type` STRING COMMENT 'Classification of the premium component (base premium, supplemental coverage, discount).. Valid values are `base|supplemental|discount`',
    `rate_amount` DECIMAL(18,2) COMMENT 'Base monetary amount used as the starting point for premium calculations.',
    `rate_schedule_status` STRING COMMENT 'Current lifecycle status of the rate schedule.. Valid values are `active|inactive|pending|retired`',
    `rating_area` STRING COMMENT 'Geographic rating area code used for premium calculations.',
    `rating_method` STRING COMMENT 'Method used to calculate premiums (e.g., community‑rated, age‑rated, composite‑rated, experience‑rated).. Valid values are `community|age|composite|experience`',
    `rating_methodology_details` STRING COMMENT 'Narrative description of the rating methodology and any special rules.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_county` STRING COMMENT 'County name or code associated with the state filing, if required.',
    `regulatory_filing_metadata` STRING COMMENT 'Additional metadata about the state filing (e.g., filing version, submission channel).',
    `regulatory_state` STRING COMMENT 'Two‑letter state code where the schedule is filed.',
    `review_status` STRING COMMENT 'Outcome of the most recent compliance or actuarial review.. Valid values are `pending|approved|rejected`',
    `schedule_name` STRING COMMENT 'Human‑readable name given to the rate schedule for reporting and UI display.',
    `state_doi_filing_number` STRING COMMENT 'Regulatory filing identifier assigned by the State Department of Insurance.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any subsidy applied to the premium under this schedule.',
    `tobacco_surcharge_flag` BOOLEAN COMMENT 'Indicates whether a tobacco surcharge is applicable for this schedule.',
    `tobacco_surcharge_rate` DECIMAL(18,2) COMMENT 'Percentage surcharge applied to members who use tobacco, expressed as a decimal (e.g., 0.1500 for 15%).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate schedule record.',
    `version_number` STRING COMMENT 'Sequential version identifier for changes to the rate schedule.',
    `wellness_discount_flag` BOOLEAN COMMENT 'Indicates whether a wellness discount is offered under this schedule.',
    `wellness_discount_rate` DECIMAL(18,2) COMMENT 'Discount percentage applied for members meeting wellness criteria.',
    CONSTRAINT pk_rate_schedule PRIMARY KEY(`rate_schedule_id`)
) COMMENT 'Defines the rate schedule configuration governing how premium rates are structured and applied for a plan year, market segment, and rating methodology. Captures rate schedule name, rating method (community rated, age-rated, composite rated, experience rated), effective date, expiration date, rating area reference, tobacco surcharge rules, wellness discount rules, family tier structure, and regulatory filing reference (state DOI rate filing number). Parent configuration for premium_rate records.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` (
    `billing_calendar_id` BIGINT COMMENT 'Primary key for billing_calendar',
    `parent_billing_calendar_id` BIGINT COMMENT 'Self-referencing FK on billing_calendar (parent_billing_calendar_id)',
    `calendar_approval_by` STRING COMMENT 'Identifier of the user who approved the calendar.',
    `calendar_approval_comments` STRING COMMENT 'Comments provided during approval.',
    `calendar_approval_date` DATE COMMENT 'Date when the calendar was approved.',
    `calendar_approval_status` STRING COMMENT 'Current approval status of the calendar.',
    `calendar_code` STRING COMMENT 'Alphanumeric code identifying the billing calendar.',
    `calendar_created_at` TIMESTAMP COMMENT 'Timestamp when the calendar record was created.',
    `calendar_cycle_description` STRING COMMENT 'Description of the billing cycle.',
    `calendar_cycle_frequency` STRING COMMENT 'Numeric frequency of the billing cycle unit.',
    `calendar_cycle_name` STRING COMMENT 'Name of the billing cycle (e.g., January, Q1).',
    `calendar_cycle_unit` STRING COMMENT 'Unit of the billing cycle frequency (e.g., month, quarter, year).',
    `calendar_description` STRING COMMENT 'Detailed description of the billing calendar.',
    `calendar_effective_date` DATE COMMENT 'Date when the billing calendar becomes effective.',
    `calendar_end_date` DATE COMMENT 'End date of the billing calendar period.',
    `calendar_expiration_date` DATE COMMENT 'Date when the billing calendar expires.',
    `calendar_frequency` STRING COMMENT 'Frequency of billing cycles within the calendar (e.g., 1, 3, 12).',
    `calendar_is_active` BOOLEAN COMMENT 'Flag indicating if the calendar is currently active.',
    `calendar_is_approved` BOOLEAN COMMENT 'Flag indicating if the calendar has been approved by governance.',
    `calendar_is_current` BOOLEAN COMMENT 'Flag indicating if the calendar is the current version.',
    `calendar_is_default` BOOLEAN COMMENT 'Flag indicating if this calendar is the default for new contracts.',
    `calendar_is_legacy` BOOLEAN COMMENT 'Flag indicating if the calendar is legacy.',
    `calendar_is_public` BOOLEAN COMMENT 'Flag indicating if the calendar is publicly available.',
    `calendar_is_restricted` BOOLEAN COMMENT 'Flag indicating if the calendar contains restricted data.',
    `calendar_is_supplemental` BOOLEAN COMMENT 'Flag indicating if the calendar is supplemental to a primary calendar.',
    `calendar_name` STRING COMMENT 'Human-readable name of the billing calendar.',
    `calendar_notes` STRING COMMENT 'Additional notes about the calendar.',
    `calendar_start_date` DATE COMMENT 'Start date of the billing calendar period.',
    `calendar_status` STRING COMMENT 'Current status of the billing calendar.',
    `calendar_type` STRING COMMENT 'Category of the billing calendar (e.g., monthly, quarterly, annual).',
    `calendar_type_description` STRING COMMENT 'Human-readable description of the calendar type.',
    `calendar_updated_at` TIMESTAMP COMMENT 'Timestamp when the calendar record was last updated.',
    `calendar_version` STRING COMMENT 'Version identifier of the calendar record.',
    `calendar_version_created_at` TIMESTAMP COMMENT 'Timestamp when the calendar version was created.',
    `calendar_version_created_by` STRING COMMENT 'Identifier of the user who created the calendar version.',
    `calendar_version_number` STRING COMMENT 'Numeric version number of the calendar record.',
    `calendar_version_updated_at` TIMESTAMP COMMENT 'Timestamp when the calendar version was last updated.',
    `calendar_version_updated_by` STRING COMMENT 'Identifier of the user who last updated the calendar version.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fiscal_day` STRING COMMENT 'Fiscal day within the fiscal year.',
    `fiscal_month` STRING COMMENT 'Fiscal month within the fiscal year.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the fiscal year.',
    `fiscal_week` STRING COMMENT 'Fiscal week within the fiscal year.',
    `fiscal_year` STRING COMMENT 'Fiscal year associated with the billing calendar.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_billing_calendar PRIMARY KEY(`billing_calendar_id`)
) COMMENT 'Master reference table for billing_calendar. Referenced by billing_calendar_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`dispute` (
    `dispute_id` BIGINT COMMENT 'System-generated unique identifier for the billing dispute record.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Audit findings often trigger billing disputes; linking enables compliance tracking of dispute resolution.',
    `contract_dispute_id` BIGINT COMMENT 'SSOT reference to canonical dispute master contract.contract_dispute',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the invoice that is the subject of the dispute.',
    `premium_payment_id` BIGINT COMMENT 'Identifier of the payment that is associated with the disputed invoice, if applicable.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the party that initiated the dispute.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Needed to associate disputes with the responsible vendor (e.g., third‑party claim processor) for dispute resolution workflow and regulatory reporting.',
    `dispute_category` STRING COMMENT 'Category describing the nature of the billing dispute.. Valid values are `invoice_amount|payment_misapplication|rate_error|retro_adjustment|aptc_discrepancy`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the disputed amount.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispute_number` STRING COMMENT 'External reference number assigned to the dispute for tracking and communication.',
    `dispute_status` STRING COMMENT 'Current processing status of the dispute.. Valid values are `open|under_review|resolved|escalated|closed`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary amount being contested in the dispute.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `initiator_type` STRING COMMENT 'Type of party that raised the dispute (member, employer group, or provider).. Valid values are `member|employer|provider`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `open_timestamp` TIMESTAMP COMMENT 'Date and time when the dispute was first opened.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the dispute must be reported to regulatory bodies (e.g., CMS, state DOI).',
    `resolution_notes` STRING COMMENT 'Free‑form notes describing the outcome and any actions taken.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the dispute was resolved.',
    `resolution_type` STRING COMMENT 'Method used to resolve the dispute.. Valid values are `credit_issued|invoice_corrected|upheld|partial_credit`',
    `ssot_dispute_ref_code` BIGINT COMMENT 'SSOT reference to canonical dispute in contract.contract_dispute',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dispute record.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Tracks billing disputes raised by employer groups or individual members contesting invoice amounts, payment applications, rate calculations, or retroactive adjustments. Captures dispute type (invoice amount, payment misapplication, rate error, retro adjustment, APTC discrepancy), disputed amount, dispute open date, dispute status (open, under review, resolved, escalated), resolution type (credit issued, invoice corrected, upheld), resolution date, and resolution notes. Distinct from clinical appeals managed in the appeal domain. [SSOT Master for dispute concept across domains]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` (
    `payer_billing_role_id` BIGINT COMMENT 'Primary key for payer',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the payer organization.',
    `parent_payer_id` BIGINT COMMENT 'Self-referencing FK on payer (parent_payer_id)',
    `address_line1` STRING COMMENT 'First line of the payers mailing address.',
    `address_line2` STRING COMMENT 'Second line of the payers mailing address (optional).',
    `balance_due` DECIMAL(18,2) COMMENT 'Outstanding balance owed by the payer.',
    `balance_outstanding` DECIMAL(18,2) COMMENT 'Current outstanding balance after payments.',
    `balance_paid` DECIMAL(18,2) COMMENT 'Total amount paid by the payer to date.',
    `city` STRING COMMENT 'City component of the payers address.',
    `communication_contact_preference` STRING COMMENT 'Indicates if the payer prefers to be contacted by the designated contact person.',
    `communication_language` STRING COMMENT 'Preferred language for electronic communications.',
    `communication_method` STRING COMMENT 'Preferred method of communication for the payer.',
    `communication_preference` STRING COMMENT 'Indicates whether the payer prefers electronic communication.',
    `communication_time_zone` STRING COMMENT 'Time zone for scheduling electronic communications.',
    `contact_email` STRING COMMENT 'Email address of the payers contact person.',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the payer.',
    `contact_phone` STRING COMMENT 'Phone number of the payers contact person.',
    `contact_role` STRING COMMENT 'Role of the contact person (e.g., billing, legal, executive).',
    `country` STRING COMMENT 'Three‑letter ISO country code of the payers address.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the payer record was first created.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount extended to the payer.',
    `currency` STRING COMMENT 'Currency used for payer transactions.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `ein` STRING COMMENT 'Employer Identification Number for the payer.',
    `email` STRING COMMENT 'Primary email address for the payer.',
    `fax` STRING COMMENT 'Fax number for the payer.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language` STRING COMMENT 'Preferred language for communication with the payer.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from the payer.',
    `last_payment_method` STRING COMMENT 'Method used for the most recent payment.',
    `last_payment_status` STRING COMMENT 'Status of the most recent payment transaction.',
    `legal_name` STRING COMMENT 'Legally registered name of the payer.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payer_name` STRING COMMENT 'Human-readable name of the payer entity.',
    `payer_role_code` STRING COMMENT '',
    `payer_status` STRING COMMENT 'Current lifecycle status of the payer.',
    `payer_type` STRING COMMENT 'Category of the payer (e.g., insurer, employer, government, third‑party administrator).',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the payer.',
    `phone` STRING COMMENT 'Primary phone number for the payer.',
    `postal_code` STRING COMMENT 'ZIP or postal code of the payers address.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `state` STRING COMMENT 'Two‑letter state code of the payers address.',
    `tax_number` STRING COMMENT '9‑digit tax identification number assigned to the payer.',
    `time_zone` STRING COMMENT 'Time zone of the payers primary location.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payer record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `website` STRING COMMENT 'Official website URL of the payer.',
    CONSTRAINT pk_payer_billing_role PRIMARY KEY(`payer_billing_role_id`)
) COMMENT 'Receiving payer for premium billing; distinct from claim.payer which represents external other-carrier payers for COB.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ADD CONSTRAINT `fk_billing_premium_refund_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ADD CONSTRAINT `fk_billing_premium_refund_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_billing_calendar_id` FOREIGN KEY (`billing_calendar_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`billing_calendar`(`billing_calendar_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_renewal_cycle_id` FOREIGN KEY (`renewal_cycle_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ADD CONSTRAINT `fk_billing_premium_reconciliation_cms_remittance_id` FOREIGN KEY (`cms_remittance_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`cms_remittance`(`cms_remittance_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_payer_billing_role_id` FOREIGN KEY (`payer_billing_role_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`payer_billing_role`(`payer_billing_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ADD CONSTRAINT `fk_billing_premium_statement_premium_rate_id` FOREIGN KEY (`premium_rate_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_rate`(`premium_rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ADD CONSTRAINT `fk_billing_billing_calendar_parent_billing_calendar_id` FOREIGN KEY (`parent_billing_calendar_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`billing_calendar`(`billing_calendar_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ADD CONSTRAINT `fk_billing_payer_billing_role_parent_payer_id` FOREIGN KEY (`parent_payer_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`payer_billing_role`(`payer_billing_role_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`billing` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`billing` SET TAGS ('pii_domain' = 'billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('pii_fhir_resource' = 'Invoice');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `premium_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Premium Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `premium_invoice_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Billing Clerk Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `application_id` SET TAGS ('pii_business_glossary_term' = 'Credentialing Application Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `member_risk_score_id` SET TAGS ('pii_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `billing_period_end` SET TAGS ('pii_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `billing_period_start` SET TAGS ('pii_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `collection_status` SET TAGS ('pii_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `collection_status` SET TAGS ('pii_value_regex' = 'not_started|in_process|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'mail|email|portal');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `grace_period_days` SET TAGS ('pii_business_glossary_term' = 'Grace Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `grace_period_days` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `grace_period_days` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number (INV)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_value_regex' = '^INV[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_status` SET TAGS ('pii_value_regex' = 'draft|issued|paid|partially_paid|void|delinquent');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_value_regex' = 'group_list_bill|group_self_bill|individual_statement|cobra|government_remittance');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `is_eligible_for_subsidy` SET TAGS ('pii_business_glossary_term' = 'Eligibility for Subsidy');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `issue_timestamp` SET TAGS ('pii_business_glossary_term' = 'Invoice Issue Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'medical|dental|vision|pharmacy|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `net_amount_due` SET TAGS ('pii_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_channel` SET TAGS ('pii_value_regex' = 'portal|mail|phone');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'electronic|check|credit_card|direct_deposit');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `refund_amount` SET TAGS ('pii_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `retroactive_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Retroactive Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `source_system_invoice_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('pii_business_glossary_term' = 'Statement Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('pii_value_regex' = '^STMT[0-9]{8}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount (APTC)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_type` SET TAGS ('pii_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_type` SET TAGS ('pii_value_regex' = 'aptc|state_subsidy|none');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `total_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('pii_fhir_resource' = 'Claim.item');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_description` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `aptc_subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'APTC Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_end` SET TAGS ('pii_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_start` SET TAGS ('pii_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_tier` SET TAGS ('pii_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_tier` SET TAGS ('pii_value_regex' = 'EE|EE+SP|EE+CH|FAM');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `csr_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'CSR Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `employee_contribution` SET TAGS ('pii_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `employer_contribution` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `is_refund` SET TAGS ('pii_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'due|paid|failed|waived');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_currency` SET TAGS ('pii_business_glossary_term' = 'Premium Currency');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_currency` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_line_description` SET TAGS ('pii_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_reconciliation_flag` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_source_system` SET TAGS ('pii_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_status` SET TAGS ('pii_business_glossary_term' = 'Premium Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_status` SET TAGS ('pii_value_regex' = 'pending|posted|reversed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_type` SET TAGS ('pii_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_type` SET TAGS ('pii_value_regex' = 'standard|discount|subsidy|retroactive|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `refund_amount` SET TAGS ('pii_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Retroactive Adjustment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('pii_fhir_resource' = 'PaymentReconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_id` SET TAGS ('pii_business_glossary_term' = 'Premium Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `application_id` SET TAGS ('pii_business_glossary_term' = 'Credentialing Application Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `adjustment_payment_id` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Payment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fee_amount` SET TAGS ('pii_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `nsf_indicator` SET TAGS ('pii_business_glossary_term' = 'NSF Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('pii_business_glossary_term' = 'Payer Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('pii_business_glossary_term' = 'Payer Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_type` SET TAGS ('pii_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_type` SET TAGS ('pii_value_regex' = 'employer|member|cms|state_medicaid|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount (Gross)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_channel` SET TAGS ('pii_value_regex' = 'web|mobile|call_center|mail|batch|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_description` SET TAGS ('pii_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'ach|check|wire|credit_card|eft|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_number` SET TAGS ('pii_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_status` SET TAGS ('pii_value_regex' = 'pending|posted|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|matched|unmatched|exception');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_due_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_value_regex' = 'applied|refunded|written_off|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_reason_code` SET TAGS ('pii_business_glossary_term' = 'Suspense Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_resolver` SET TAGS ('pii_business_glossary_term' = 'Suspense Resolver');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_resolver` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_resolver` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_status` SET TAGS ('pii_business_glossary_term' = 'Suspense Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_status` SET TAGS ('pii_value_regex' = 'in_suspense|resolved|written_off');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `transaction_type` SET TAGS ('pii_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `transaction_type` SET TAGS ('pii_value_regex' = 'premium|adjustment|refund|reversal');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('pii_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('pii_fhir_resource' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Payment Allocation ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `invoice_line_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `premium_payment_id` SET TAGS ('pii_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('pii_business_glossary_term' = 'Allocated Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('pii_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_date` SET TAGS ('pii_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_sequence` SET TAGS ('pii_business_glossary_term' = 'Allocation Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('pii_value_regex' = 'allocated|pending|rejected|adjusted|closed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('pii_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('pii_value_regex' = 'standard|partial|overpayment|suspense_resolution|adjustment|refund');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `is_overpayment` SET TAGS ('pii_business_glossary_term' = 'Is Overpayment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `is_suspense_resolution` SET TAGS ('pii_business_glossary_term' = 'Is Suspense Resolution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_channel` SET TAGS ('pii_value_regex' = 'web|mobile|call_center|in_person|batch|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'credit_card|bank_transfer|cash|check|electronic|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_period` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'open|in_review|approved|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_type` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_type` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `total_adjustments` SET TAGS ('pii_business_glossary_term' = 'Total Adjustments Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `total_billed` SET TAGS ('pii_business_glossary_term' = 'Total Billed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `total_collected` SET TAGS ('pii_business_glossary_term' = 'Total Collected Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `variance_reason` SET TAGS ('pii_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('pii_fhir_resource' = 'Account');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Billing Representative');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `group_practice_id` SET TAGS ('pii_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Account Number (ACC_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'Account Status (ACC_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_status` SET TAGS ('pii_value_regex' = 'active|suspended|closed|pending');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Account Type (ACC_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_type` SET TAGS ('pii_value_regex' = 'employer_group|individual|government|medicare|medicaid|chip');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `apr_rate` SET TAGS ('pii_business_glossary_term' = 'Annual Premium Rate (APR)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `aptc_amount` SET TAGS ('pii_business_glossary_term' = 'Advance Premium Tax Credit (APTC) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `auto_pay_authorization_date` SET TAGS ('pii_business_glossary_term' = 'Auto‑Pay Authorization Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `auto_pay_authorization_flag` SET TAGS ('pii_business_glossary_term' = 'Auto‑Pay Authorization Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `auto_pay_enrollment` SET TAGS ('pii_business_glossary_term' = 'Auto‑Pay Enrollment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_calendar_reference` SET TAGS ('pii_business_glossary_term' = 'Billing Calendar Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_cycle_type` SET TAGS ('pii_business_glossary_term' = 'Billing Cycle Type (CYCLE_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_cycle_type` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_frequency` SET TAGS ('pii_business_glossary_term' = 'Billing Frequency (BILL_FREQ)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_method` SET TAGS ('pii_business_glossary_term' = 'Billing Method (BILL_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `billing_method` SET TAGS ('pii_value_regex' = 'self_bill|list_bill|direct_bill');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `collection_status` SET TAGS ('pii_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `collection_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `credit_limit` SET TAGS ('pii_business_glossary_term' = 'Credit Limit (CR_LIM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `current_balance` SET TAGS ('pii_business_glossary_term' = 'Current Account Balance (CUR_BAL)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `grace_period_days` SET TAGS ('pii_business_glossary_term' = 'Grace Period (GRACE_DAYS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `grace_period_days` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `grace_period_days` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `invoice_generation_day` SET TAGS ('pii_business_glossary_term' = 'Invoice Generation Day');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `last_invoice_date` SET TAGS ('pii_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `next_invoice_date` SET TAGS ('pii_business_glossary_term' = 'Next Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_due_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Due Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_due_day` SET TAGS ('pii_business_glossary_term' = 'Payment Due Day');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_terms` SET TAGS ('pii_value_regex' = 'net_30|net_45|net_60|due_on_receipt');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `pmpm_rate` SET TAGS ('pii_business_glossary_term' = 'Per Member Per Month Rate (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('pii_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.plan.specificCost');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_rate_id` SET TAGS ('pii_business_glossary_term' = 'Premium Rate ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rate_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Rate Schedule Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rate_schedule_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `age_band` SET TAGS ('pii_business_glossary_term' = 'Age Band');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `aptc_amount` SET TAGS ('pii_business_glossary_term' = 'Advanced Premium Tax Credit (APTC) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `cobra_rate` SET TAGS ('pii_business_glossary_term' = 'COBRA Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `coverage_tier` SET TAGS ('pii_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `coverage_tier` SET TAGS ('pii_value_regex' = 'individual|employee_spouse|family|dual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `employee_contribution_rate` SET TAGS ('pii_business_glossary_term' = 'Employee Contribution Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `employer_contribution_rate` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `family_tier_structure` SET TAGS ('pii_business_glossary_term' = 'Family Tier Structure');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'individual|group|small_group|large_group');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `plan_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_rate_status` SET TAGS ('pii_business_glossary_term' = 'Premium Rate Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_rate_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_type` SET TAGS ('pii_business_glossary_term' = 'Premium Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_type` SET TAGS ('pii_value_regex' = 'APR|PMPM');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rate_amount` SET TAGS ('pii_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rating_area` SET TAGS ('pii_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rating_area_reference` SET TAGS ('pii_business_glossary_term' = 'Rating Area Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rating_method` SET TAGS ('pii_business_glossary_term' = 'Rating Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rating_method` SET TAGS ('pii_value_regex' = 'community|age|composite|experience');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `regulatory_filing_metadata` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Metadata');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `state_doi_filing_number` SET TAGS ('pii_business_glossary_term' = 'State DOI Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `state_doi_filing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `tobacco_surcharge_rate` SET TAGS ('pii_business_glossary_term' = 'Tobacco Surcharge Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `wellness_discount_rate` SET TAGS ('pii_business_glossary_term' = 'Wellness Discount Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_id` SET TAGS ('pii_business_glossary_term' = 'Grace Period Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `premium_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Grace Period Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `day_count` SET TAGS ('pii_business_glossary_term' = 'Grace Period Day Count');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_description` SET TAGS ('pii_business_glossary_term' = 'Grace Period Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `extension_end_date` SET TAGS ('pii_business_glossary_term' = 'Extended Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `extension_flag` SET TAGS ('pii_business_glossary_term' = 'Grace Period Extension Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_number` SET TAGS ('pii_business_glossary_term' = 'Grace Period Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('pii_business_glossary_term' = 'Grace Period Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('pii_value_regex' = 'active|expired|terminated|reinstated|paid');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('pii_business_glossary_term' = 'Grace Period Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('pii_value_regex' = 'standard|aca_aptc|group|individual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `is_eligible_for_aptc` SET TAGS ('pii_business_glossary_term' = 'ACA APTC Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `jurisdiction` SET TAGS ('pii_value_regex' = 'federal|state');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Grace Period Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Grace Period Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `outcome` SET TAGS ('pii_value_regex' = 'paid|terminated|reinstated|none');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Original Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `payment_received_date` SET TAGS ('pii_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Grace Period Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('pii_value_regex' = 'late_payment|non_payment|billing_error|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Grace Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `termination_warning_issued` SET TAGS ('pii_business_glossary_term' = 'Termination Warning Issued Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Grace Period Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` SET TAGS ('pii_subdomain' = 'adjustment_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `retro_adjustment_id` SET TAGS ('pii_business_glossary_term' = 'Billing Retroactive Adjustment ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('pii_business_glossary_term' = 'Adjustment Number (External)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('pii_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|posted|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('pii_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('pii_value_regex' = 'add|termination|rate_change|tier_change|dispute_credit|dispute_correction');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `authorization_reference` SET TAGS ('pii_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `credit_memo_reference` SET TAGS ('pii_business_glossary_term' = 'Credit Memo Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_open_date` SET TAGS ('pii_business_glossary_term' = 'Dispute Open Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_status` SET TAGS ('pii_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_status` SET TAGS ('pii_value_regex' = 'open|under_review|resolved|escalated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_type` SET TAGS ('pii_business_glossary_term' = 'Dispute Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_type` SET TAGS ('pii_value_regex' = 'invoice_amount|payment_misapplication|rate_error|retro_adjustment|aptc_discrepancy');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `disputed_amount` SET TAGS ('pii_business_glossary_term' = 'Disputed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `disputed_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `disputed_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `invoice_reference` SET TAGS ('pii_business_glossary_term' = 'Invoice Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `original_billing_period_end` SET TAGS ('pii_business_glossary_term' = 'Original Billing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `original_billing_period_start` SET TAGS ('pii_business_glossary_term' = 'Original Billing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `resolution_type` SET TAGS ('pii_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `resolution_type` SET TAGS ('pii_value_regex' = 'credit_issued|invoice_corrected|upheld');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `premium_refund_id` SET TAGS ('pii_business_glossary_term' = 'Premium Refund ID (PRID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Identifier (EGID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (MID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Identifier (PID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `policy_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `policy_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `premium_payment_id` SET TAGS ('pii_business_glossary_term' = 'Original Payment Identifier (OPID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (CBUID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Related Claim Identifier (RCID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `premium_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Related Invoice Identifier (RIID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Refund Approval Status (RAS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `cleared_timestamp` SET TAGS ('pii_business_glossary_term' = 'Refund Cleared Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `is_partial_refund` SET TAGS ('pii_business_glossary_term' = 'Partial Refund Indicator (PRI)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `is_tax_refund` SET TAGS ('pii_business_glossary_term' = 'Tax Refund Indicator (TRI)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `issued_timestamp` SET TAGS ('pii_business_glossary_term' = 'Refund Issued Timestamp (RIT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Refund Lifecycle Status (RLS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|processed|cancelled|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `original_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Original Payment Amount (OPA)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `original_payment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `original_payment_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp (RACT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp (RAUT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_amount` SET TAGS ('pii_business_glossary_term' = 'Refund Amount (RA)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_batch_number` SET TAGS ('pii_business_glossary_term' = 'Refund Batch Number (RBN)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_currency` SET TAGS ('pii_business_glossary_term' = 'Refund Currency Code (RFC)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_method` SET TAGS ('pii_business_glossary_term' = 'Refund Disbursement Method (RDM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_method` SET TAGS ('pii_value_regex' = 'ACH|check|credit_to_account|wire|online|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_notes` SET TAGS ('pii_business_glossary_term' = 'Refund Notes (RN)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_number` SET TAGS ('pii_business_glossary_term' = 'Refund Transaction Number (RTN)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_processing_fee` SET TAGS ('pii_business_glossary_term' = 'Refund Processing Fee (RPF)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_processing_fee` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_processing_fee` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_reason_code` SET TAGS ('pii_business_glossary_term' = 'Refund Reason Code (RRC)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_reason_description` SET TAGS ('pii_business_glossary_term' = 'Refund Reason Description (RRD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_type` SET TAGS ('pii_business_glossary_term' = 'Refund Type (RT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `refund_type` SET TAGS ('pii_value_regex' = 'overpayment|termination|rate_correction|plan_cancellation|adjustment|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag (RRF)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount Refunded (TAR)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `tax_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `tax_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('pii_business_glossary_term' = 'APTC Subsidy ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `annual_aptc_cap` SET TAGS ('pii_business_glossary_term' = 'Annual APTC Cap');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `annual_aptc_cap` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `annual_aptc_cap` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_monthly_amount` SET TAGS ('pii_business_glossary_term' = 'Advance Premium Tax Credit (APTC) Monthly Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_monthly_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_monthly_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_status` SET TAGS ('pii_business_glossary_term' = 'Subsidy Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `cms_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'CMS Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `cms_reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|reconciled|error');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `csr_variant` SET TAGS ('pii_business_glossary_term' = 'Cost‑Sharing Reduction (CSR) Variant Level');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `csr_variant` SET TAGS ('pii_value_regex' = '73|87|94');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `exchange_code` SET TAGS ('pii_business_glossary_term' = 'Marketplace Exchange Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `exchange_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `qhp_plan_code` SET TAGS ('pii_business_glossary_term' = 'Qualified Health Plan (QHP) Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `qhp_plan_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_effective_date` SET TAGS ('pii_business_glossary_term' = 'Subsidy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_number` SET TAGS ('pii_business_glossary_term' = 'Subsidy Identifier (Subsidy Number)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_termination_date` SET TAGS ('pii_business_glossary_term' = 'Subsidy Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_type` SET TAGS ('pii_business_glossary_term' = 'Subsidy Type (APTC or CSR)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_type` SET TAGS ('pii_value_regex' = 'APTC|CSR');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('pii_business_glossary_term' = 'Year‑to‑Date APTC Applied');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('pii_subdomain' = 'adjustment_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `cms_remittance_id` SET TAGS ('pii_business_glossary_term' = 'CMS Remittance ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'CMS Transaction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `edi_820_reference` SET TAGS ('pii_business_glossary_term' = 'EDI 820 Transaction Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `gross_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Payment Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `is_eligible` SET TAGS ('pii_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `mlr_rebate_offset_amount` SET TAGS ('pii_business_glossary_term' = 'MLR Rebate Offset Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `net_remittance_amount` SET TAGS ('pii_business_glossary_term' = 'Net Remittance Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `payment_period_end` SET TAGS ('pii_business_glossary_term' = 'Payment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `payment_period_start` SET TAGS ('pii_business_glossary_term' = 'Payment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type (CMS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'capitation|risk_corridor|reinsurance|risk_adjustment|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|reconciled|exception|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `remittance_number` SET TAGS ('pii_business_glossary_term' = 'Remittance Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `remittance_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `remittance_status` SET TAGS ('pii_business_glossary_term' = 'Remittance Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `remittance_status` SET TAGS ('pii_value_regex' = 'received|processed|posted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `remittance_timestamp` SET TAGS ('pii_business_glossary_term' = 'Remittance Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `risk_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `submission_type` SET TAGS ('pii_value_regex' = 'electronic|paper|manual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `cycle_id` SET TAGS ('pii_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `billing_calendar_id` SET TAGS ('pii_business_glossary_term' = 'Billing Calendar Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `renewal_cycle_id` SET TAGS ('pii_business_glossary_term' = 'Renewal Billing Cycle Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `billing_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Billing Frequency in Months');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `billing_method` SET TAGS ('pii_business_glossary_term' = 'Billing Method (Electronic, Paper, Direct Debit, Credit Card)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `billing_method` SET TAGS ('pii_value_regex' = 'electronic|paper|direct_debit|credit_card');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('pii_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('pii_business_glossary_term' = 'Billing Cycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `cycle_type` SET TAGS ('pii_business_glossary_term' = 'Billing Cycle Type (Monthly, Quarterly, Semi-Annual, Annual)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `cycle_type` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `default_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Default Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `cycle_description` SET TAGS ('pii_business_glossary_term' = 'Description of Billing Cycle Configuration');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount Applied to Premium');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `grace_period_days` SET TAGS ('pii_business_glossary_term' = 'Grace Period Days After Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `grace_period_days` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `grace_period_days` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `invoice_day_of_month` SET TAGS ('pii_business_glossary_term' = 'Invoice Generation Day of Month');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `is_pro_rata` SET TAGS ('pii_business_glossary_term' = 'Pro Rata Billing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `last_invoice_date` SET TAGS ('pii_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `net_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Net Premium Amount After Discounts');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `next_invoice_date` SET TAGS ('pii_business_glossary_term' = 'Next Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `payment_due_day_offset` SET TAGS ('pii_business_glossary_term' = 'Payment Due Day Offset');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `prorated_amount` SET TAGS ('pii_business_glossary_term' = 'Pro Rata Adjusted Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount Applied to Premium');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Total Amount Due for Billing Cycle');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `collection_case_id` SET TAGS ('pii_business_glossary_term' = 'Collection Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Case Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Collection Agency ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `action_count` SET TAGS ('pii_business_glossary_term' = 'Action Count');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `case_closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Case Closed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `case_number` SET TAGS ('pii_business_glossary_term' = 'Collection Case Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `case_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `case_open_timestamp` SET TAGS ('pii_business_glossary_term' = 'Case Open Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `collection_case_status` SET TAGS ('pii_business_glossary_term' = 'Collection Case Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `delinquency_age_days` SET TAGS ('pii_business_glossary_term' = 'Delinquency Age (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `delinquent_amount` SET TAGS ('pii_business_glossary_term' = 'Delinquent Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `final_resolution` SET TAGS ('pii_business_glossary_term' = 'Final Resolution');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `final_resolution` SET TAGS ('pii_value_regex' = 'paid_in_full|partial_payment|written_off|bankruptcy|plan_termination');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `last_action_date` SET TAGS ('pii_business_glossary_term' = 'Last Action Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `last_action_type` SET TAGS ('pii_business_glossary_term' = 'Last Action Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `last_action_type` SET TAGS ('pii_value_regex' = 'notice_sent|payment_arranged|legal_action|write_off|reinstated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `net_amount_due` SET TAGS ('pii_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Case Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `payment_plan_arrangement_details` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Arrangement Details');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `referral_date` SET TAGS ('pii_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `reinstatement_conditions` SET TAGS ('pii_business_glossary_term' = 'Reinstatement Conditions');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `reinstatement_conditions` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `reinstatement_conditions` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `reinstatement_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Reinstatement Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `reinstatement_eligibility_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `reinstatement_eligibility_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `termination_notice_issued_date` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Issued Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `write_off_amount` SET TAGS ('pii_business_glossary_term' = 'Write‑Off Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ALTER COLUMN `write_off_approval_reference` SET TAGS ('pii_business_glossary_term' = 'Write‑Off Approval Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `premium_reconciliation_id` SET TAGS ('pii_business_glossary_term' = 'Premium Reconciliation ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `premium_reconciliation_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `premium_reconciliation_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `cms_remittance_id` SET TAGS ('pii_business_glossary_term' = 'CMS Remittance Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `apr_rate` SET TAGS ('pii_business_glossary_term' = 'Annual Premium Rate (APR)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `aptc_subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Advance Premium Tax Credit (APTC) Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `is_finalized` SET TAGS ('pii_business_glossary_term' = 'Finalization Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `mlr_input_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio Input Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `net_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `pm_amount` SET TAGS ('pii_business_glossary_term' = 'Per Member Per Month Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `premium_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `premium_reconciliation_status` SET TAGS ('pii_value_regex' = 'open|in_review|approved|closed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Inclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code (US Postal)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `total_adjustments_amount` SET TAGS ('pii_business_glossary_term' = 'Total Adjustments Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `total_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Billed Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `total_collected_amount` SET TAGS ('pii_business_glossary_term' = 'Total Collected Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Premium Variance Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ALTER COLUMN `variance_reason` SET TAGS ('pii_business_glossary_term' = 'Premium Variance Reason');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` SET TAGS ('pii_subdomain' = 'adjustment_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `cobra_billing_id` SET TAGS ('pii_business_glossary_term' = 'COBRA Billing ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `admin_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Administrative Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `billing_cycle_month` SET TAGS ('pii_business_glossary_term' = 'Billing Cycle Month');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `billing_issue_timestamp` SET TAGS ('pii_business_glossary_term' = 'Billing Issue Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `billing_number` SET TAGS ('pii_business_glossary_term' = 'Billing Number (COBRA)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `billing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `cobra_status` SET TAGS ('pii_business_glossary_term' = 'COBRA Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `cobra_status` SET TAGS ('pii_value_regex' = 'elected|active|lapsed|exhausted|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `compliance_flag_dol` SET TAGS ('pii_business_glossary_term' = 'DOL Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `compliance_flag_erisa` SET TAGS ('pii_business_glossary_term' = 'ERISA Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `election_reference` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `initial_grace_period_days` SET TAGS ('pii_business_glossary_term' = 'Initial Grace Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `initial_grace_period_days` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `initial_grace_period_days` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `is_deleted` SET TAGS ('pii_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `last_payment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Payment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `ongoing_grace_period_days` SET TAGS ('pii_business_glossary_term' = 'Ongoing Grace Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `ongoing_grace_period_days` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `ongoing_grace_period_days` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|credit_card|direct_debit|online|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `payment_reference` SET TAGS ('pii_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'pending|paid|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Base Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|inactive');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `refund_amount` SET TAGS ('pii_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `retroactive_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Retroactive Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Retroactive Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `total_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` SET TAGS ('pii_subdomain' = 'adjustment_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `edi_820_id` SET TAGS ('pii_business_glossary_term' = 'EDI 820 Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `business_event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Business Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `business_identifier` SET TAGS ('pii_business_glossary_term' = 'Business Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `direction` SET TAGS ('pii_business_glossary_term' = 'Transaction Direction');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `direction` SET TAGS ('pii_value_regex' = 'inbound|outbound');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `error_code` SET TAGS ('pii_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `error_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `error_description` SET TAGS ('pii_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `invoice_reference` SET TAGS ('pii_business_glossary_term' = 'Invoice Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `is_reconciled` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `isa_receiver_qualifier_code` SET TAGS ('pii_business_glossary_term' = 'ISA Receiver Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `isa_receiver_qualifier_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `isa_sender_qualifier_code` SET TAGS ('pii_business_glossary_term' = 'ISA Sender Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `isa_sender_qualifier_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'received|validated|applied|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payee_npi` SET TAGS ('pii_business_glossary_term' = 'Payee National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payee_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payee_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payee_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payer_npi` SET TAGS ('pii_business_glossary_term' = 'Payer National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payer_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payer_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payer_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payment_method_code` SET TAGS ('pii_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payment_method_code` SET TAGS ('pii_value_regex' = 'ACH|Check|CreditCard|Wire');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payment_method_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'Premium|Refund|Adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `processing_notes` SET TAGS ('pii_business_glossary_term' = 'Processing Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `remittance_advice_number` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `remittance_advice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `settlement_date` SET TAGS ('pii_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `transaction_set_control_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Set Identifier (820)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `transaction_set_control_number` SET TAGS ('pii_value_regex' = '820');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `transaction_set_control_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` SET TAGS ('pii_fhir_resource' = 'Account');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `suspense_account_id` SET TAGS ('pii_business_glossary_term' = 'Suspense Account ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Resolver Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `payer_billing_role_id` SET TAGS ('pii_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `is_amount_mismatch` SET TAGS ('pii_business_glossary_term' = 'Amount Mismatch Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `is_duplicate` SET TAGS ('pii_business_glossary_term' = 'Duplicate Payment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `is_overpayment` SET TAGS ('pii_business_glossary_term' = 'Overpayment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Suspense Account Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `payer_account_reference` SET TAGS ('pii_business_glossary_term' = 'Payer Account Reference (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `payer_account_reference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `payer_account_reference` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `payment_channel` SET TAGS ('pii_value_regex' = 'web|mobile|call_center|mail|in_person');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|cash|credit_card|debit_card|electronic_transfer|online_payment');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `receipt_timestamp` SET TAGS ('pii_business_glossary_term' = 'Payment Receipt Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `resolution_due_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_value_regex' = 'applied|refunded|written_off|pending|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `resolution_timestamp` SET TAGS ('pii_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `suspense_account_status` SET TAGS ('pii_business_glossary_term' = 'Suspense Account Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `suspense_account_status` SET TAGS ('pii_value_regex' = 'open|in_process|resolved|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `suspense_number` SET TAGS ('pii_business_glossary_term' = 'Suspense Account Number (SUSPENSE_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `suspense_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `suspense_reason` SET TAGS ('pii_business_glossary_term' = 'Suspense Reason');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `suspense_reason` SET TAGS ('pii_value_regex' = 'unidentified_payer|amount_mismatch|duplicate_payment|missing_invoice|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `transaction_reference` SET TAGS ('pii_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `mlr_rebate_id` SET TAGS ('pii_business_glossary_term' = 'MLR Rebate ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `calculation_method` SET TAGS ('pii_business_glossary_term' = 'Rebate Calculation Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `calculation_method` SET TAGS ('pii_value_regex' = 'standard|custom');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `calculation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Rebate Calculation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `cms_filing_reference` SET TAGS ('pii_business_glossary_term' = 'CMS Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `disbursement_date` SET TAGS ('pii_business_glossary_term' = 'Rebate Disbursement Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `disbursement_method` SET TAGS ('pii_business_glossary_term' = 'Rebate Disbursement Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `disbursement_method` SET TAGS ('pii_value_regex' = 'check|premium_credit|enrollment_reduction');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `hhs_submission_status` SET TAGS ('pii_business_glossary_term' = 'HHS Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `hhs_submission_status` SET TAGS ('pii_value_regex' = 'submitted|pending|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'individual|small_group|large_group');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `mlr_percentage` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `mlr_rebate_status` SET TAGS ('pii_business_glossary_term' = 'Rebate Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `mlr_rebate_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|paid');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Rebate Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `quality_improvement_expenses` SET TAGS ('pii_business_glossary_term' = 'Quality Improvement Expenses');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `rebate_amount_due` SET TAGS ('pii_business_glossary_term' = 'Rebate Amount Due');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `rebate_number` SET TAGS ('pii_business_glossary_term' = 'Rebate Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `rebate_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `reporting_year` SET TAGS ('pii_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `total_incurred_claims` SET TAGS ('pii_business_glossary_term' = 'Total Incurred Claims');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `total_premium_earned` SET TAGS ('pii_business_glossary_term' = 'Total Premium Earned');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('pii_fhir_resource' = 'PaymentReconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('pii_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `authorization_date` SET TAGS ('pii_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `authorization_reference` SET TAGS ('pii_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `bank_name` SET TAGS ('pii_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('pii_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('pii_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('pii_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_country` SET TAGS ('pii_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_country` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_state` SET TAGS ('pii_business_glossary_term' = 'Billing State');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Card Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('pii_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_type` SET TAGS ('pii_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `card_type` SET TAGS ('pii_value_regex' = 'Visa|MasterCard|Amex|Discover|Other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('pii_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `is_auto_pay` SET TAGS ('pii_business_glossary_term' = 'Auto‑Pay Authorization Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('pii_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('pii_business_glossary_term' = 'Masked Bank Routing Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `method_type` SET TAGS ('pii_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `method_type` SET TAGS ('pii_value_regex' = 'ACH|Check|Wire|CreditCard|DebitCard|HSA');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Payment Method Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('pii_business_glossary_term' = 'Payment Method Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `pci_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'PCI Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `pci_compliance_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Payment Method Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `risk_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('pii_business_glossary_term' = 'Tokenized Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|failed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `verification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `premium_statement_id` SET TAGS ('pii_business_glossary_term' = 'Premium Statement Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier (PLAN_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (MEMBER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User Identifier (UPDATED_BY_UID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `premium_rate_id` SET TAGS ('pii_business_glossary_term' = 'Premium Rate Identifier (RATE_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `premium_statement_generator_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (CREATED_BY_UID)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `premium_statement_generator_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `premium_statement_generator_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Code (ADJ_REASON_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `aptc_amount` SET TAGS ('pii_business_glossary_term' = 'Advanced Premium Tax Credit Amount (APTC_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `aptc_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `billing_cycle` SET TAGS ('pii_business_glossary_term' = 'Billing Cycle (BILL_CYCLE)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date (COV_END_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date (COV_START_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Statement Delivery Method (DELIV_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'mail|email|portal');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `discount_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `gross_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Premium Amount (GROSS_PREM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `gross_premium_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `is_eligible_for_subsidy` SET TAGS ('pii_business_glossary_term' = 'Subsidy Eligibility Flag (SUBSIDY_ELIG_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `is_late_payment_flag` SET TAGS ('pii_business_glossary_term' = 'Late Payment Indicator (LATE_PAY_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `is_refund` SET TAGS ('pii_business_glossary_term' = 'Refund Indicator (REFUND_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `late_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Late Fee Amount (LATE_FEE_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `late_fee_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `net_premium_due` SET TAGS ('pii_business_glossary_term' = 'Net Premium Due (NET_PREM_DUE)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `net_premium_due` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Statement Notes (STMT_NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel (PAY_CHANNEL)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `payment_channel` SET TAGS ('pii_value_regex' = 'web|mobile|call_center|mail|portal');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date (PAY_DUE_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'credit_card|bank_transfer|check|cash|online|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `rebate_amount` SET TAGS ('pii_business_glossary_term' = 'Rebate Amount (REBATE_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `rebate_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `refund_amount` SET TAGS ('pii_business_glossary_term' = 'Refund Amount (REFUND_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `refund_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `statement_date` SET TAGS ('pii_business_glossary_term' = 'Statement Date (STMT_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `statement_number` SET TAGS ('pii_business_glossary_term' = 'Statement Number (STMT_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `statement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `statement_pdf_url` SET TAGS ('pii_business_glossary_term' = 'Statement PDF URL (PDF_URL)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `statement_status` SET TAGS ('pii_business_glossary_term' = 'Statement Status (STMT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `statement_status` SET TAGS ('pii_value_regex' = 'draft|issued|sent|paid|cancelled|void');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `statement_type` SET TAGS ('pii_business_glossary_term' = 'Statement Type (STMT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `statement_type` SET TAGS ('pii_value_regex' = 'individual|family|group');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `statement_version` SET TAGS ('pii_business_glossary_term' = 'Statement Version (STMT_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount (SUBSIDY_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `tax_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `total_payments_applied` SET TAGS ('pii_business_glossary_term' = 'Total Payments Applied (PAYMENTS_APPLIED)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `total_payments_applied` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` SET TAGS ('pii_subdomain' = 'premium_billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.plan.specificCost');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_plan_health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_plan_health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_plan_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `applicable_year` SET TAGS ('pii_business_glossary_term' = 'Applicable Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `aptc_amount` SET TAGS ('pii_business_glossary_term' = 'APTC Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `cobra_rate` SET TAGS ('pii_business_glossary_term' = 'COBRA Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'medical|dental|vision|rx');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_description` SET TAGS ('pii_business_glossary_term' = 'Schedule Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `employee_contribution_rate` SET TAGS ('pii_business_glossary_term' = 'Employee Contribution Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `employer_contribution_rate` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `family_tier_structure` SET TAGS ('pii_business_glossary_term' = 'Family Tier Structure');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `filing_date` SET TAGS ('pii_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `filing_status` SET TAGS ('pii_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `filing_status` SET TAGS ('pii_value_regex' = 'filed|pending|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `is_default_schedule` SET TAGS ('pii_business_glossary_term' = 'Default Schedule Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'individual|group|small_group|large_group');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `plan_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `premium_type` SET TAGS ('pii_business_glossary_term' = 'Premium Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `premium_type` SET TAGS ('pii_value_regex' = 'base|supplemental|discount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_amount` SET TAGS ('pii_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('pii_business_glossary_term' = 'Rate Schedule Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rating_area` SET TAGS ('pii_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rating_method` SET TAGS ('pii_business_glossary_term' = 'Rating Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rating_method` SET TAGS ('pii_value_regex' = 'community|age|composite|experience');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `rating_methodology_details` SET TAGS ('pii_business_glossary_term' = 'Rating Methodology Details');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `regulatory_county` SET TAGS ('pii_business_glossary_term' = 'Regulatory County');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `regulatory_filing_metadata` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Metadata');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `regulatory_state` SET TAGS ('pii_business_glossary_term' = 'Regulatory State');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `state_doi_filing_number` SET TAGS ('pii_business_glossary_term' = 'State DOI Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `state_doi_filing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `tobacco_surcharge_flag` SET TAGS ('pii_business_glossary_term' = 'Tobacco Surcharge Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `tobacco_surcharge_rate` SET TAGS ('pii_business_glossary_term' = 'Tobacco Surcharge Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `wellness_discount_flag` SET TAGS ('pii_business_glossary_term' = 'Wellness Discount Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ALTER COLUMN `wellness_discount_rate` SET TAGS ('pii_business_glossary_term' = 'Wellness Discount Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `billing_calendar_id` SET TAGS ('pii_business_glossary_term' = 'Billing Calendar Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `parent_billing_calendar_id` SET TAGS ('pii_business_glossary_term' = 'Parent Billing Calendar Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `parent_billing_calendar_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_approval_by` SET TAGS ('pii_business_glossary_term' = 'Calendar Approval By');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_approval_comments` SET TAGS ('pii_business_glossary_term' = 'Calendar Approval Comments');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_approval_date` SET TAGS ('pii_business_glossary_term' = 'Calendar Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_approval_status` SET TAGS ('pii_business_glossary_term' = 'Calendar Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_code` SET TAGS ('pii_business_glossary_term' = 'Calendar Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_created_at` SET TAGS ('pii_business_glossary_term' = 'Calendar Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_cycle_description` SET TAGS ('pii_business_glossary_term' = 'Calendar Cycle Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_cycle_frequency` SET TAGS ('pii_business_glossary_term' = 'Calendar Cycle Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_cycle_name` SET TAGS ('pii_business_glossary_term' = 'Calendar Cycle Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_cycle_unit` SET TAGS ('pii_business_glossary_term' = 'Calendar Cycle Unit');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_description` SET TAGS ('pii_business_glossary_term' = 'Calendar Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_effective_date` SET TAGS ('pii_business_glossary_term' = 'Calendar Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_end_date` SET TAGS ('pii_business_glossary_term' = 'Calendar End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Calendar Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_frequency` SET TAGS ('pii_business_glossary_term' = 'Calendar Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_is_active` SET TAGS ('pii_business_glossary_term' = 'Calendar Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_is_approved` SET TAGS ('pii_business_glossary_term' = 'Calendar Is Approved');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_is_current` SET TAGS ('pii_business_glossary_term' = 'Calendar Is Current');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_is_default` SET TAGS ('pii_business_glossary_term' = 'Calendar Is Default');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_is_legacy` SET TAGS ('pii_business_glossary_term' = 'Calendar Is Legacy');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_is_public` SET TAGS ('pii_business_glossary_term' = 'Calendar Is Public');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_is_restricted` SET TAGS ('pii_business_glossary_term' = 'Calendar Is Restricted');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_is_supplemental` SET TAGS ('pii_business_glossary_term' = 'Calendar Is Supplemental');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_business_glossary_term' = 'Calendar Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_notes` SET TAGS ('pii_business_glossary_term' = 'Calendar Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_start_date` SET TAGS ('pii_business_glossary_term' = 'Calendar Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_status` SET TAGS ('pii_business_glossary_term' = 'Calendar Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_type` SET TAGS ('pii_business_glossary_term' = 'Calendar Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_type_description` SET TAGS ('pii_business_glossary_term' = 'Calendar Type Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_updated_at` SET TAGS ('pii_business_glossary_term' = 'Calendar Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_version` SET TAGS ('pii_business_glossary_term' = 'Calendar Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_version_created_at` SET TAGS ('pii_business_glossary_term' = 'Calendar Version Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_version_created_by` SET TAGS ('pii_business_glossary_term' = 'Calendar Version Created By');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_version_number` SET TAGS ('pii_business_glossary_term' = 'Calendar Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_version_updated_at` SET TAGS ('pii_business_glossary_term' = 'Calendar Version Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `calendar_version_updated_by` SET TAGS ('pii_business_glossary_term' = 'Calendar Version Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fiscal_day` SET TAGS ('pii_business_glossary_term' = 'Fiscal Day');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fiscal_month` SET TAGS ('pii_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fiscal_quarter` SET TAGS ('pii_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fiscal_week` SET TAGS ('pii_business_glossary_term' = 'Fiscal Week');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`billing_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_subdomain' = 'adjustment_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_ssot_source_domain' = 'billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_ssot_duplicate_of' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_ssot_alias_of' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_ssot_canonical' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_ssot_ref' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` SET TAGS ('pii_ssot_concept' = 'contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('pii_business_glossary_term' = 'Billing Dispute ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `contract_dispute_id` SET TAGS ('pii_business_glossary_term' = 'Contract Contract Dispute Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `contract_dispute_id` SET TAGS ('pii_ssot_canonical' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `premium_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Related Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `premium_payment_id` SET TAGS ('pii_business_glossary_term' = 'Related Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Dispute Initiator Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `subscriber_id` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `dispute_category` SET TAGS ('pii_business_glossary_term' = 'Dispute Category');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `dispute_category` SET TAGS ('pii_value_regex' = 'invoice_amount|payment_misapplication|rate_error|retro_adjustment|aptc_discrepancy');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('pii_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('pii_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('pii_value_regex' = 'open|under_review|resolved|escalated|closed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `disputed_amount` SET TAGS ('pii_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `initiator_type` SET TAGS ('pii_business_glossary_term' = 'Dispute Initiator Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `initiator_type` SET TAGS ('pii_value_regex' = 'member|employer|provider');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `open_timestamp` SET TAGS ('pii_business_glossary_term' = 'Dispute Open Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('pii_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('pii_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('pii_value_regex' = 'credit_issued|invoice_corrected|upheld|partial_credit');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `ssot_dispute_ref_code` SET TAGS ('pii_business_glossary_term' = 'Ssot Dispute Ref Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `ssot_dispute_ref_code` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_ssot_source_domain' = 'billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_ssot_master' = 'payer');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_ssot_canonical' = 'billing.payer');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_ssot_ref' = 'claim.payer');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_ssot_concept' = 'payer');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` SET TAGS ('pii_vreq_skip_P205' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `payer_billing_role_id` SET TAGS ('pii_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `parent_payer_id` SET TAGS ('pii_business_glossary_term' = 'Parent Payer Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `parent_payer_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Payer Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Payer Address Line2');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `balance_due` SET TAGS ('pii_business_glossary_term' = 'Payer Balance Due');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `balance_outstanding` SET TAGS ('pii_business_glossary_term' = 'Payer Balance Outstanding');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `balance_paid` SET TAGS ('pii_business_glossary_term' = 'Payer Balance Paid');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Payer City');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `communication_contact_preference` SET TAGS ('pii_business_glossary_term' = 'Payer Communication Contact Preference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `communication_language` SET TAGS ('pii_business_glossary_term' = 'Payer Communication Language');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `communication_method` SET TAGS ('pii_business_glossary_term' = 'Payer Communication Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `communication_preference` SET TAGS ('pii_business_glossary_term' = 'Payer Communication Preference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `communication_time_zone` SET TAGS ('pii_business_glossary_term' = 'Payer Communication Time Zone');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_name` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `contact_role` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Role');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Payer Country');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Payer Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `credit_limit` SET TAGS ('pii_business_glossary_term' = 'Payer Credit Limit');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `currency` SET TAGS ('pii_business_glossary_term' = 'Payer Currency');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `ein` SET TAGS ('pii_business_glossary_term' = 'Payer Ein');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `ein` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `ein` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `email` SET TAGS ('pii_business_glossary_term' = 'Payer Email');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fax` SET TAGS ('pii_business_glossary_term' = 'Payer Fax');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fax` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fax` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Payer Language');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Payer Last Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Payer Last Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `last_payment_method` SET TAGS ('pii_business_glossary_term' = 'Payer Last Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `last_payment_status` SET TAGS ('pii_business_glossary_term' = 'Payer Last Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `legal_name` SET TAGS ('pii_business_glossary_term' = 'Payer Legal Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `legal_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `legal_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `payer_name` SET TAGS ('pii_business_glossary_term' = 'Payer Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `payer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `payer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `payer_status` SET TAGS ('pii_business_glossary_term' = 'Payer Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `payer_type` SET TAGS ('pii_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payer Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `phone` SET TAGS ('pii_business_glossary_term' = 'Payer Phone');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Payer Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'Payer State');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `tax_number` SET TAGS ('pii_business_glossary_term' = 'Payer Tax Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `tax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `tax_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `tax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `time_zone` SET TAGS ('pii_business_glossary_term' = 'Payer Time Zone');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Payer Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ALTER COLUMN `website` SET TAGS ('pii_business_glossary_term' = 'Payer Website');
