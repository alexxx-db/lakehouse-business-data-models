-- Schema for Domain: billing | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`billing` COMMENT 'Single source of truth for premium billing and revenue collection — group invoicing, individual premium statements, payment processing, grace periods, retroactive adjustments, premium reconciliation, refunds, and collections. Owns APR rate structures, PMPM calculations, subsidy and APTC tracking for ACA members, and accounts receivable. Supports CMS premium remittance and state DOI financial reporting. Source system: HealthEdge or custom billing platform.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` (
    `premium_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the premium invoice record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Every premium invoice is issued against a master billing account. The account entity is the financial relationship owner (employer group, individual subscriber, etc.). Without this FK, premium_invoice',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan or benefit design underlying the premium.',
    `identity_id` BIGINT COMMENT 'Identifier of the individual member associated with the invoice, if applicable.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Premium invoices are generated for a specific plan election. Billing teams trace invoices to plan elections for premium validation, retroactive adjustment processing, and member billing inquiries. pla',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Premium invoices are generated against a specific policy. Direct policy_id enables invoice generation, premium reconciliation, and policy renewal billing workflows. Health insurance billing analysts r',
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
    `aptc_subsidy_id` BIGINT COMMENT 'Foreign key linking to billing.aptc_subsidy. Business justification: invoice_line carries aptc_subsidy_amount and csr_adjustment_amount as decimal values representing the subsidy applied at the line level. Linking to the aptc_subsidy record normalizes the subsidy refer',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Each invoice line represents a members premium for a specific benefit package enrollment period. Benefit-package-level billing reconciliation and MLR reporting require this link. Finance and actuaria',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan or benefit design associated with the charge.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the covered member or subscriber for this premium charge.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Each invoice line represents a charge for coverage tied to a specific plan election. Premium reconciliation, retroactive adjustment processing, and coverage-tier rate validation require linking invoic',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Invoice lines represent per-period premium charges tied to a specific policy. Direct policy_id enables policy-level premium reconciliation reports, ACA regulatory reporting by policy, and coverage per',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the parent invoice header to which this line belongs.',
    `premium_rate_id` BIGINT COMMENT 'Foreign key linking to billing.premium_rate. Business justification: Each invoice line represents a charge computed from a specific APR/PMPM rate structure. Linking invoice_line to premium_rate normalizes the rate reference and enables rate-level reconciliation and aud',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Needed for line‑level reconciliation: each invoice line reflects a specific enrollment transaction (plan tier, coverage), supporting detailed financial reporting.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the business reason for a premium adjustment.. Valid values are `A|B|C|D|E|F`',
    `adjustment_reason_description` STRING COMMENT 'Human‑readable description of the adjustment reason.',
    `aptc_subsidy_amount` DECIMAL(18,2) COMMENT 'Advanced Premium Tax Credit amount applied to reduce the members premium.',
    `billing_period_end` DATE COMMENT 'End date of the billing period associated with this line.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period associated with this line.',
    `coverage_end_date` DATE COMMENT 'Last day of coverage for which the premium is billed (nullable for open‑ended coverage).',
    `coverage_start_date` DATE COMMENT 'First day of coverage for which the premium is billed.',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: A premium payment is made by or on behalf of a billing account. The account is the financial entity responsible for premium obligations. Without this FK, premium_payment has no direct link to the bill',
    `identity_id` BIGINT COMMENT 'Identifier of the member associated with the premium payment.',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to billing.payment_method. Business justification: Each premium payment is executed using a specific authorized payment method (ACH, credit card, check, etc.). The payment_method table is the master record of authorized payment instruments for a billi',
    `policy_id` BIGINT COMMENT 'Identifier of the insurance policy to which the premium payment applies.',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the premium invoice that this payment is applied to.',
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
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Facilities (hospitals, ASCs) hold billing accounts for capitation, bundled payments, and value-based care settlements. The account table already links to provider and group_practice; adding facility_i',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Group practices receive consolidated reimbursements; the link enables the Group Practice Billing Summary and CMS reporting of provider‑level payments.',
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
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Premium rates are benefit-package-specific (metal tier, cost-sharing structure drive rate differences). Billing setup and quoting processes require looking up the applicable premium_rate by benefit_pa',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - premium rates are per plan (currently only links to rate_schedule)',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: Premium rates are filed and effective for specific open enrollment periods. Rate validation during enrollment, state DOI regulatory filing reconciliation, and actuarial reporting all require linking r',
    `plan_association_id` BIGINT COMMENT 'Foreign key linking to network.plan_association. Business justification: Premium rates are actuarially filed per plan-network association (a specific plan offered within a specific network in a market segment). Regulatory rate filings and CMS submissions require tracing ea',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: Actuarial rate reconciliation: plan.premium_rate must trace back to the filed plan.rate record to support regulatory compliance audits comparing actuarially filed rates vs. billed amounts. Actuarie',
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
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Grace periods are triggered by non-payment on a specific plan election. Termination processing, reinstatement workflows, and CMS grace period regulatory reporting all require identifying which plan el',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Grace periods are triggered by non-payment on a specific policy. Direct policy_id enables termination processing, reinstatement eligibility checks, and CMS regulatory reporting. Health insurance opera',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the invoice that triggered the grace period.',
    `premium_payment_id` BIGINT COMMENT 'Foreign key linking to billing.premium_payment. Business justification: A grace period is resolved (closed/cured) when a premium payment is received. grace_period already carries payment_received_date (DATE) as a denormalized capture, but has no FK to the actual payment r',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` (
    `aptc_subsidy_id` BIGINT COMMENT 'System-generated unique identifier for the APTC subsidy record.',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - APTC is computed per QHP',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member receiving the subsidy.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: APTC subsidies are applied to a specific QHP plan election. CMS annual reconciliation (IRS Form 8962), 1095-A generation, and subsidy eligibility verification all require linking the subsidy record di',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: APTC subsidies are applied to a specific policys premium. Direct policy_id enables ACA subsidy reconciliation (IRS Form 8962, CMS EDGE server reporting) at the policy level — a mandatory regulatory r',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_aptc_subsidy_id` FOREIGN KEY (`aptc_subsidy_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`aptc_subsidy`(`aptc_subsidy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_premium_rate_id` FOREIGN KEY (`premium_rate_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_rate`(`premium_rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_process|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|email|portal');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|paid|partially_paid|void|delinquent');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'group_list_bill|group_self_bill|individual_statement|cobra|government_remittance');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `is_eligible_for_subsidy` SET TAGS ('dbx_business_glossary_term' = 'Eligibility for Subsidy');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `net_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'portal|mail|phone');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'electronic|check|credit_card|direct_deposit');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `retroactive_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `source_system_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('dbx_value_regex' = '^STMT[0-9]{8}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount (APTC)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'aptc|state_subsidy|none');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'Aptc Subsidy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `premium_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `aptc_subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'APTC Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `csr_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'CSR Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `employer_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `is_refund` SET TAGS ('dbx_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
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
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `nsf_indicator` SET TAGS ('dbx_business_glossary_term' = 'NSF Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payer_type` SET TAGS ('dbx_value_regex' = 'employer|member|cms|state_medicaid|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount (Gross)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|call_center|mail|batch|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|check|wire|credit_card|eft|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|unmatched|exception');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_due_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'applied|refunded|written_off|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `suspense_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` SET TAGS ('dbx_subdomain' = 'invoice_management');
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
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `is_overpayment` SET TAGS ('dbx_business_glossary_term' = 'Is Overpayment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `is_suspense_resolution` SET TAGS ('dbx_business_glossary_term' = 'Is Suspense Resolution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
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
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `total_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustments Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `total_billed` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `total_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Collected Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` SET TAGS ('dbx_subdomain' = 'account_setup');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (ACC_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CR_LIM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance (CUR_BAL)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (GRACE_DAYS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `invoice_generation_day` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generation Day');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `next_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Next Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_due_day` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Day');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|due_on_receipt');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `pmpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month Rate (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` SET TAGS ('dbx_subdomain' = 'account_setup');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `plan_association_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `age_band` SET TAGS ('dbx_business_glossary_term' = 'Age Band');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `aptc_amount` SET TAGS ('dbx_business_glossary_term' = 'Advanced Premium Tax Credit (APTC) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `cobra_rate` SET TAGS ('dbx_business_glossary_term' = 'COBRA Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'individual|employee_spouse|family|dual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `employee_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `employer_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `family_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Family Tier Structure');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'individual|group|small_group|large_group');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `plan_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_rate_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_type` SET TAGS ('dbx_business_glossary_term' = 'Premium Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `premium_type` SET TAGS ('dbx_value_regex' = 'APR|PMPM');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rating_area_reference` SET TAGS ('dbx_business_glossary_term' = 'Rating Area Reference');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rating_method` SET TAGS ('dbx_business_glossary_term' = 'Rating Method');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `rating_method` SET TAGS ('dbx_value_regex' = 'community|age|composite|experience');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `regulatory_filing_metadata` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Metadata');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `state_doi_filing_number` SET TAGS ('dbx_business_glossary_term' = 'State DOI Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `state_doi_filing_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `tobacco_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Surcharge Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ALTER COLUMN `wellness_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Wellness Discount Rate');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` SET TAGS ('dbx_subdomain' = 'account_setup');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `day_count` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Day Count');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_description` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Description');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `extension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Grace Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `extension_flag` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Extension Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_number` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_value_regex' = 'active|expired|terminated|reinstated|paid');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('dbx_value_regex' = 'standard|aca_aptc|group|individual');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `is_eligible_for_aptc` SET TAGS ('dbx_business_glossary_term' = 'ACA APTC Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'paid|terminated|reinstated|none');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'late_payment|non_payment|billing_error|other');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `state_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `state_code` SET TAGS ('dbx_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `termination_warning_issued` SET TAGS ('dbx_business_glossary_term' = 'Termination Warning Issued Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` SET TAGS ('dbx_subdomain' = 'account_setup');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'APTC Subsidy ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
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
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `csr_variant` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Sharing Reduction (CSR) Variant Level');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `csr_variant` SET TAGS ('dbx_value_regex' = '73|87|94');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Exchange Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `exchange_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `qhp_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Qualified Health Plan (QHP) Code');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `qhp_plan_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_number` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Identifier (Subsidy Number)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type (APTC or CSR)');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'APTC|CSR');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('dbx_business_glossary_term' = 'Year‑to‑Date APTC Applied');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` SET TAGS ('dbx_subdomain' = 'invoice_management');
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
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `is_auto_pay` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Authorization Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Routing Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `method_type` SET TAGS ('dbx_value_regex' = 'ACH|Check|Wire|CreditCard|DebitCard|HSA');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Notes');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `pci_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `pci_compliance_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed');
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
