-- Schema for Domain: contract | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-27 01:56:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`contract` COMMENT 'Authoritative contract repository governing all contractual agreements including FIDIC-based EPC, GMP (Guaranteed Maximum Price), lump-sum, and unit-rate contracts. Owns CO (Change Order) logs, LD (Liquidated Damages) provisions, DLP (Defects Liability Period) terms, EOT (Extension of Time) entitlements, payment schedules, and contract milestone administration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`agreement` (
    `agreement_id` BIGINT COMMENT 'System-generated unique identifier for the master contract record.',
    `account_id` BIGINT COMMENT 'Identifier of the client (owner) of the contract.',
    `master_services_agreement_id` BIGINT COMMENT 'Foreign key linking to client.master_services_agreement. Business justification: Framework call-off management: construction agreements are frequently issued as call-offs under a parent MSA. Ceiling value tracking, framework utilisation reporting, and MSA compliance audits all req',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to client.client_opportunity. Business justification: Bid-to-contract conversion tracking: every executed agreement originates from a won client opportunity. Pipeline-to-revenue reporting, CRM reconciliation, and win/loss analysis all require tracing whi',
    `prequalification_id` BIGINT COMMENT 'Foreign key linking to client.client_prequalification. Business justification: Contract award compliance: construction procurement rules require that agreements are only awarded to prequalified entities. Compliance audits and regulatory reviews verify which prequalification reco',
    `rfp_issuance_id` BIGINT COMMENT 'Foreign key linking to client.rfp_issuance. Business justification: Contract award traceability: procurement audit trails and regulatory compliance require linking each executed agreement to the specific RFP issuance that triggered it. Construction contract administra',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: The contract agreements milestone_schedule and notice_to_proceed_date must be reconciled against the schedule baseline in effect at contract award. This link enables contract-baseline alignment repor',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary contractor responsible for delivering the work.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.. Valid values are `draft|pending|active|suspended|terminated|closed`',
    `amendment_effective_date` DATE COMMENT 'Date the amendment becomes effective.',
    `amendment_number` STRING COMMENT 'Sequential identifier for a contract amendment.',
    `amendment_type` STRING COMMENT 'Type of amendment (e.g., supplemental, variation, novation).. Valid values are `supplemental|variation|novation`',
    `award_date` DATE COMMENT 'Date the contract was formally awarded to the contractor.',
    `boq_reference` STRING COMMENT 'Reference to the Bill of Quantities associated with the contract.',
    `compliance_requirements` STRING COMMENT 'Regulatory and statutory compliance obligations attached to the agreement.',
    `contract_number` STRING COMMENT 'External contract identifier used in all business communications and legal documents.',
    `contract_type` STRING COMMENT 'Classification of the agreement (e.g., EPC, GMP, Lump Sum, Unit Rate, Design-Build, Design-Bid-Build, PPP, BOT). [ENUM-REF-CANDIDATE: EPC|GMP|LumpSum|UnitRate|DesignBuild|DesignBidBuild|PPP|BOT — promote to reference product]',
    `contract_value` DECIMAL(18,2) COMMENT 'Original monetary value of the agreement as agreed at award.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the contract value.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `defects_liability_period_months` STRING COMMENT 'Duration after completion during which the contractor is liable for defects.',
    `dispute_resolution` STRING COMMENT 'Method for resolving disputes (e.g., arbitration, litigation, mediation).',
    `effective_end_date` DATE COMMENT 'Date the agreement terminates or expires (null for open‑ended contracts).',
    `effective_start_date` DATE COMMENT 'Date the agreement becomes legally binding.',
    `environmental_impact_assessment_ref` STRING COMMENT 'Reference to the approved environmental impact assessment linked to the contract.',
    `extension_of_time_days` STRING COMMENT 'Number of days granted as an extension of time (EOT) under the contract.',
    `geographic_location` STRING COMMENT 'Three‑letter ISO country code where the contract work is performed.. Valid values are `^[A-Z]{3}$`',
    `governing_law` STRING COMMENT 'Jurisdiction whose law governs the contract.',
    `health_safety_plan_ref` STRING COMMENT 'Reference to the HSE plan governing safety on the contract site.',
    `insurance_requirements` STRING COMMENT 'Required insurance coverage and limits for the contract.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Monetary amount payable for each day of delay beyond the agreed completion date.',
    `milestone_schedule` STRING COMMENT 'Key project milestones linked to contract payments.',
    `notice_to_proceed_date` DATE COMMENT 'Date the client issued the Notice to Proceed (NTP) to start work.',
    `payment_schedule` STRING COMMENT 'Description of payment milestones, dates, and conditions.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Security amount posted by the contractor to guarantee performance.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment retained until contract close‑out.',
    `revised_completion_date` DATE COMMENT 'New contract completion date after amendment.',
    `revised_contract_value` DECIMAL(18,2) COMMENT 'Contract value after applying the amendment.',
    `scope_description` STRING COMMENT 'Narrative description of the work scope covered by the agreement.',
    `special_conditions` STRING COMMENT 'Any special or bespoke conditions that modify standard contract terms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `wbs_reference` STRING COMMENT 'Identifier linking the contract to the associated Work Breakdown Structure.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Master contract record representing the authoritative SSOT for all contractual agreements in the construction domain. Captures FIDIC-based EPC, GMP (Guaranteed Maximum Price), lump-sum, unit-rate, DB (Design-Build), DBB (Design-Bid-Build), PPP (Public-Private Partnership), and BOT (Build-Operate-Transfer) contract types via a type classification attribute. Stores contract identity, scope narrative, detailed scope of works including WBS (Work Breakdown Structure) reference, deliverable descriptions, technical specifications reference, BOQ (Bill of Quantities) linkage, geographic boundaries, and exclusions. Records execution dates, NTP (Notice to Proceed) date, contract value, currency, governing law, dispute resolution mechanism, contract status lifecycle from award through close-out, and particular/special conditions that modify standard form terms. Maintains status transition history for audit and lifecycle analytics. Records all formal amendments including supplemental agreements, deed of variations, and novation agreements with amendment number, type, effective date, revised contract value, revised completion date, and execution status. Serves as the authoritative scope baseline against which change orders and EOT claims are evaluated.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`party` (
    `party_id` BIGINT COMMENT 'System‑generated unique identifier for each party associated with a contract.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Required for Contract Administration Report linking each contract party to the client account it represents, enabling account‑level performance and compliance tracking.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Parties are associated with the agreement they belong to; linking provides inbound/outbound relationship.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Maps each contract party that is a supplier to its vendor record, enabling vendor performance tracking per contract.',
    `address_line1` STRING COMMENT 'Primary street address of the party.',
    `address_line2` STRING COMMENT 'Additional address information (suite, floor, etc.).',
    `bank_account_number` STRING COMMENT 'Account number used for contract‑related payments.',
    `bank_name` STRING COMMENT 'Financial institution where the partys account is held.',
    `city` STRING COMMENT 'City component of the mailing address.',
    `contact_email` STRING COMMENT 'Main email used for contractual communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for reaching the party.',
    `country_code` STRING COMMENT 'Three‑letter country code for the mailing address.. Valid values are `[A-Z]{3}`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the party record was first entered into the system.',
    `insurance_certificate_number` STRING COMMENT 'Reference number of the insurance policy covering the party.',
    `insurance_expiry_date` DATE COMMENT 'Date when the provided insurance coverage ends.',
    `is_jv_partner` BOOLEAN COMMENT 'True when the party participates as a JV partner in the contract.',
    `is_primary_party` BOOLEAN COMMENT 'True when the party is the main responsible entity for the contract.',
    `jurisdiction` STRING COMMENT 'Three‑letter country code where the party is legally registered.. Valid values are `[A-Z]{3}`',
    `legal_entity_name` STRING COMMENT 'Official registered name of the corporate entity.',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Monetary cap on the partys contractual liability.',
    `party_name` STRING COMMENT 'Full legal name of the party (individual or organization) as it appears in the contract.',
    `notes` STRING COMMENT 'Additional comments, observations, or special conditions related to the party.',
    `participation_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership or profit share for joint‑venture partners.',
    `party_status` STRING COMMENT 'Operational status of the party within the contract management system.. Valid values are `active|inactive|terminated|suspended`',
    `party_type` STRING COMMENT 'Category that defines the business role of the party in construction contracts.',
    `payment_terms` STRING COMMENT 'Agreed payment schedule (e.g., Net 30).. Valid values are `net30|net45|net60|net90|upon_receipt`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the mailing address.',
    `record_source_system` STRING COMMENT 'Name of the operational system of record that originated the party data.',
    `registration_number` STRING COMMENT 'Government‑issued registration identifier for the legal entity.',
    `role_in_contract` STRING COMMENT 'The functional role the party plays for the specific contract (e.g., owner, contractor).. Valid values are `owner|contractor|consultant|guarantor|subcontractor|joint_venture`',
    `signatory_authority` BOOLEAN COMMENT 'True when the party is authorized to execute the contract on behalf of its organization.',
    `state_province` STRING COMMENT 'State or province component of the mailing address.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax ID for the party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the party record.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Association entity capturing all parties bound to a contract agreement, including the employer/client, general contractor (GC), joint venture (JV) partners, engineer/consultant, and guarantors. Records party role, signatory authority, legal entity name, registration number, jurisdiction, and participation percentage for JV arrangements. Enables multi-party contract structures common in EPC and PPP delivery models.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`payment_schedule` (
    `payment_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the payment schedule.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which this payment schedule belongs.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Milestone-driven payment scheduling is the standard in construction contracts. Payment schedule installments are triggered by milestone completion events (NTP, substantial completion, final acceptance',
    `actual_payment_date` DATE COMMENT 'Date the payment was actually made.',
    `advance_balance_remaining` DECIMAL(18,2) COMMENT 'Outstanding advance amount yet to be recovered.',
    `advance_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the advance payment disbursed.',
    `advance_payment_flag` BOOLEAN COMMENT 'Indicates whether this schedule includes an advance payment component.',
    `advance_recovery_amount` DECIMAL(18,2) COMMENT 'Cumulative amount recovered from subsequent payments.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp representing the business event that generated the schedule, e.g., milestone approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment schedule record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the payment amounts.. Valid values are `^[A-Z]{3}$`',
    `payment_schedule_description` STRING COMMENT 'Free-text description providing additional context for the payment schedule.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the gross amount before tax.',
    `due_date` DATE COMMENT 'Date by which the payment is contractually due.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, or retentions.',
    `guarantee_reference` STRING COMMENT 'Reference to the advance payment guarantee document.',
    `installment_number` STRING COMMENT 'Sequence number of this payment within the overall schedule.',
    `is_final_payment` BOOLEAN COMMENT 'True if this schedule represents the final payment of the contract.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the payment schedule.. Valid values are `draft|active|closed|void`',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount payable after tax, discount, and retention adjustments.',
    `net_amount_after_discount` DECIMAL(18,2) COMMENT 'Net payable amount after discount and before tax.',
    `notes` STRING COMMENT 'Additional remarks or observations related to the payment schedule.',
    `payment_certificate_date` DATE COMMENT 'Date the payment certificate was issued.',
    `payment_certificate_number` STRING COMMENT 'Reference number of the payment certificate issued for this schedule.',
    `payment_method` STRING COMMENT 'Means by which the payment will be transferred.. Valid values are `bank_transfer|cheque|cash|credit_card`',
    `payment_method_reference` STRING COMMENT 'Reference details for the payment method, such as bank account number.',
    `payment_source` STRING COMMENT 'Originating party responsible for the payment.. Valid values are `employer|client|owner`',
    `payment_status` STRING COMMENT 'Current processing status of the payment.. Valid values are `pending|approved|paid|rejected|cancelled`',
    `payment_terms` STRING COMMENT 'Contractual terms governing payment timing, e.g., Net 30.',
    `payment_type` STRING COMMENT 'Classification of the payment schedule based on its nature.. Valid values are `milestone|time_based|retention|advance|final`',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount retained from the payment as per contract terms.',
    `retention_release_amount` DECIMAL(18,2) COMMENT 'Amount of retention to be released on the scheduled release date.',
    `retention_release_date` DATE COMMENT 'Date when the retained amount is scheduled to be released.',
    `schedule_number` STRING COMMENT 'External reference number for the payment schedule as defined in the contract.',
    `scheduled_date` DATE COMMENT 'Date the payment is scheduled to be processed.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the gross amount.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the payment.',
    `total_installments` STRING COMMENT 'Total number of installments defined in the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment schedule record.',
    CONSTRAINT pk_payment_schedule PRIMARY KEY(`payment_schedule_id`)
) COMMENT 'Defines the contractual payment schedule governing when and how much the employer is obligated to pay the contractor, including full advance payment (mobilization payment) lifecycle management. Captures payment terms, payment intervals, payment due dates, payment method, currency, and supports both milestone-based and time-based payment structures as defined under FIDIC and GMP contract forms. Manages the complete advance payment lifecycle: advance payment amount, percentage of contract value, disbursement date, repayment/recovery schedule, cumulative amount recovered through payment certificate deductions, outstanding advance balance, advance payment guarantee reference, and advance payment status from initial disbursement through full recovery. Serves as the authoritative SSOT for all payment scheduling and advance payment tracking, alongside progress payment and retention release scheduling.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`payment_certificate` (
    `payment_certificate_id` BIGINT COMMENT 'System-generated unique identifier for the payment certificate record.',
    `agreement_id` BIGINT COMMENT 'Reference to the master contract to which this certificate belongs.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Milestone-based payment certification is the dominant payment model in construction (FIDIC, NEC). Payment certificates are issued upon milestone completion (practical completion, sectional completion)',
    `payment_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.payment_schedule. Business justification: payment_certificate records the actual IPC/FPC issued against a contractual payment schedule. payment_schedule defines the installment plan (due dates, amounts, retention terms). Each payment certific',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Payment certificates are issued for work completed at specific work fronts. Linking enables site-level payment tracking, work-front-level cash flow reporting, and supports the superintendent sign-off ',
    `actual_payment_date` DATE COMMENT 'Date on which the payment was actually received.',
    `advance_recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered against any previously paid advances.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate was approved.',
    `certificate_number` STRING COMMENT 'Business identifier assigned to each payment certificate, following the convention CP########.. Valid values are `^CP[0-9]{8}$`',
    `certification_date` TIMESTAMP COMMENT 'Timestamp when the certificate was formally issued.',
    `certification_version` STRING COMMENT 'Version number for revised certificates.',
    `certified_amount` DECIMAL(18,2) COMMENT 'Gross amount certified for payment before deductions.',
    `change_order_reference` STRING COMMENT 'Reference number of any change order affecting this payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency for the payment.. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'Date the invoice was issued.',
    `invoice_number` STRING COMMENT 'Reference to the invoice generated for this certificate.',
    `is_advance_recovered` BOOLEAN COMMENT 'True when an advance payment is being recovered.',
    `is_ld_applied` BOOLEAN COMMENT 'True when liquidated damages are deducted.',
    `is_pay_when_paid` BOOLEAN COMMENT 'Indicates whether payment is contingent on receipt of funds from the client.',
    `is_retention_applied` BOOLEAN COMMENT 'Indicates if retention is being held for this certificate.',
    `ld_deduction_amount` DECIMAL(18,2) COMMENT 'Deduction applied for liquidated damages, if any.',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Final payable amount after all deductions.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the certificate.',
    `payment_certificate_status` STRING COMMENT 'Current lifecycle state of the certificate.. Valid values are `draft|issued|approved|rejected|paid|cancelled`',
    `payment_due_date` DATE COMMENT 'Date by which the net amount is contractually due.',
    `payment_method` STRING COMMENT 'Means by which the payment will be made.. Valid values are `bank_transfer|cheque|cash|letter_of_credit`',
    `payment_status` STRING COMMENT 'Current status of the payment transaction.. Valid values are `pending|processed|failed|reconciled`',
    `payment_type` STRING COMMENT 'Indicates whether the certificate is for an interim or final payment.. Valid values are `interim|final`',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount retained per contract terms, deducted from the certified amount.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the certified amount.',
    `tax_code` STRING COMMENT 'Code representing the tax regime applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the certificate record.',
    `work_progress_percent` DECIMAL(18,2) COMMENT 'Percentage of work completed as reported for this certificate.',
    CONSTRAINT pk_payment_certificate PRIMARY KEY(`payment_certificate_id`)
) COMMENT 'Transactional record of each interim payment certificate (IPC) and final payment certificate (FPC) issued under a main contract or subcontract. Captures certified amount, retention deducted, advance payment recovery, LD deductions, net amount due, certification date, certifier identity, payment due date, and actual payment date. Supports both main contract certification (FIDIC Clause 14) and subcontract payment certification via a contract-level discriminator distinguishing main contract from subcontract certificates. Records subcontract payment applications, certified amounts, and enables back-to-back payment flow management between main contract receipts and subcontractor disbursements. Supports cash flow forecasting, pay-when-paid clause administration, and unified payment reconciliation across the full contract hierarchy.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique surrogate key for each contract amendment record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the original contract to which this amendment applies.',
    `change_order_id` BIGINT COMMENT 'Foreign key linking to project.project_change_order. Business justification: Contract amendments in construction are formally triggered by approved project change orders. Change management traceability (PCO→CCO→Amendment) is a core contract administration process required for ',
    `commercial_change_order_id` BIGINT COMMENT 'Identifier of a change order linked to this amendment, if applicable.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Contract amendments in construction are frequently triggered by revised IFC drawings that change scope, quantities, or specifications. Linking amendment to the governing drawing supports contract chan',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Contract amendments that change contract value must trigger budget revisions. Linking amendment to the resulting project_budget revision provides an audit trail of budget changes driven by contract am',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Contract amendments changing completion dates or scope trigger a revised schedule baseline. Linking amendment to the resulting schedule_baseline enables contract-schedule traceability for audit, EOT c',
    `amendment_number` STRING COMMENT 'Sequential identifier assigned to the amendment within the contract lifecycle.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `draft|pending_approval|approved|rejected|executed|closed`',
    `amendment_type` STRING COMMENT 'Category of amendment indicating its nature.. Valid values are `supplemental|variation|novation|deed_of_variation|addendum`',
    `approval_date` DATE COMMENT 'Date when the amendment was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the amendment.',
    `amendment_category` STRING COMMENT 'High-level category of impact caused by the amendment.. Valid values are `financial|schedule|scope|quality|safety`',
    `change_summary` STRING COMMENT 'Brief summary of key changes introduced by the amendment.',
    `contract_milestone` STRING COMMENT 'Milestone of the contract impacted by the amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was created in the system.',
    `amendment_description` STRING COMMENT 'Narrative description of the amendment purpose and changes.',
    `document_reference` STRING COMMENT 'Reference identifier or path to the signed amendment document.',
    `document_signed_flag` BOOLEAN COMMENT 'Indicates whether the amendment document has been signed.',
    `document_storage_path` STRING COMMENT 'File system or repository path where the signed amendment is stored.',
    `effective_date` DATE COMMENT 'Date when the amendment becomes legally effective.',
    `effective_until` DATE COMMENT 'Date until which the amendment remains in effect, if applicable.',
    `execution_status` STRING COMMENT 'Operational execution status of the amendment implementation.. Valid values are `not_started|in_progress|completed|cancelled`',
    `impact_financial` DECIMAL(18,2) COMMENT 'Monetary impact of the amendment on the contract value.',
    `impact_schedule_days` STRING COMMENT 'Number of days added or removed from the contract schedule due to the amendment.',
    `impact_scope_description` STRING COMMENT 'Narrative description of how the scope is affected.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the amendment contains confidential information.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the amendment record.',
    `legal_review_status` STRING COMMENT 'Status of the legal review process for the amendment.. Valid values are `not_started|in_review|approved|rejected`',
    `notes` STRING COMMENT 'Additional free-text notes related to the amendment.',
    `original_completion_date` DATE COMMENT 'Original contract completion date prior to amendment.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'Contract value before any amendments.',
    `payment_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment to payment schedule amount due to amendment.',
    `payment_schedule_new_date` DATE COMMENT 'New date for the next payment after amendment.',
    `reason_code` STRING COMMENT 'Code representing the primary reason for the amendment.. Valid values are `design_change|scope_change|regulatory|client_request|cost_overrun`',
    `revised_completion_date` DATE COMMENT 'New contract completion date after amendment.',
    `revised_contract_value` DECIMAL(18,2) COMMENT 'Total contract value after applying the amendment.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the amendment.. Valid values are `low|medium|high|critical`',
    `scope` STRING COMMENT 'Detailed description of the scope changes introduced.',
    `signed_date` DATE COMMENT 'Date when the amendment was signed by the parties.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the amendment record.',
    `version` STRING COMMENT 'Version number of the amendment record for change tracking.',
    `created_by` STRING COMMENT 'User identifier who created the amendment record.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Records formal amendments to the original contract agreement, including supplemental agreements, deed of variations, and novation agreements. Captures amendment number, amendment type, effective date, description of changes to original terms, revised contract value, revised completion date, and execution status. Maintains a complete amendment history for each contract to support audit and dispute resolution.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` (
    `bond_guarantee_id` BIGINT COMMENT 'Unique surrogate key for the bond guarantee record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which this bond guarantee is attached.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project associated with the bond guarantee.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.party. Business justification: bond_guarantee tracks performance bonds, advance payment guarantees, retention bonds, and parent company guarantees. Each bond/guarantee is issued by or on behalf of a specific contractual party (e.g.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Connects bond guarantee issuing party to vendor master, required for bond compliance and risk reporting.',
    `bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the bond guarantee.',
    `bond_guarantee_status` STRING COMMENT 'Current lifecycle status of the bond guarantee.. Valid values are `active|expired|called|released|pending|cancelled`',
    `bond_type` STRING COMMENT 'Classification of the bond guarantee type.. Valid values are `performance|advance|retention|bid|parent_company`',
    `call_condition_description` STRING COMMENT 'Conditions under which the bond can be called by the obligee.',
    `call_date` DATE COMMENT 'Date when the bond was called, if applicable.',
    `compliance_requirements` STRING COMMENT 'Regulatory compliance requirements applicable to the bond guarantee (e.g., OSHA, ISO 9001).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bond guarantee record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code of the bond amount.. Valid values are `^[A-Z]{3}$`',
    `bond_guarantee_description` STRING COMMENT 'Free-text description or notes about the bond guarantee.',
    `effective_from` DATE COMMENT 'Date from which the bond guarantee becomes effective.',
    `effective_until` DATE COMMENT 'Date until which the bond guarantee remains in effect, if different from expiry.',
    `expiry_date` DATE COMMENT 'Date when the bond guarantee expires.',
    `guarantee_number` STRING COMMENT 'Unique identifier assigned to the bond guarantee by the issuing surety or bank.',
    `guarantee_purpose` STRING COMMENT 'Purpose of the bond guarantee within the contract.. Valid values are `performance|payment|maintenance|completion|other`',
    `issue_date` DATE COMMENT 'Date when the bond guarantee was issued.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction governing the bond guarantee. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|AUS|DEU|FRA|CHN|IND|BRA — promote to reference product]',
    `release_date` DATE COMMENT 'Date when the bond was released or returned to the issuer.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the contract value retained under the bond, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bond guarantee record.',
    CONSTRAINT pk_bond_guarantee PRIMARY KEY(`bond_guarantee_id`)
) COMMENT 'Tracks all performance bonds, advance payment guarantees, retention bonds, bid bonds, and parent company guarantees associated with a contract. Records bond type, issuing bank or surety, bond amount, bond currency, issue date, expiry date, call conditions, and current status (active, expired, called, released). Provides the authoritative bond register for contract administration and financial risk management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`insurance_register` (
    `insurance_register_id` BIGINT COMMENT 'System-generated unique identifier for the insurance register record.',
    `agreement_id` BIGINT COMMENT 'add column agreement_id (BIGINT) with FK to contract.agreement.agreement_id - insurance register entries should reference the underlying agreement',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Plant-all-risk and equipment insurance policies are tracked per asset in construction. Linking insurance_register to asset enables compliance reporting (which assets have valid insurance?), supports',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Project insurance compliance reporting is a regulatory and contractual requirement in construction (CAR, TPL, professional indemnity policies are project-specific). Direct project linkage supports ins',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Insurance claims in construction are triggered by specific safety incidents. Linking the insurance policy register to the triggering incident supports workers compensation processing, insurer notific',
    `party_id` BIGINT COMMENT 'Internal identifier of the contract or entity that is insured.',
    `claim_history_available` BOOLEAN COMMENT 'Indicates whether any claims have been filed under this policy.',
    `compliance_status` STRING COMMENT 'Indicates whether the policy meets contractual and regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount the policy will pay for covered losses.',
    `coverage_type` STRING COMMENT 'Category of insurance coverage required by the contract.. Valid values are `contractor_all_risk|third_party_liability|professional_indemnity|workers_compensation|marine_cargo|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the insurance register entry was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values (e.g., USD, EUR).',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the insured party must pay before the insurer covers losses.',
    `effective_date` DATE COMMENT 'Date the insurance coverage becomes active.',
    `expiry_date` DATE COMMENT 'Date the insurance coverage terminates unless renewed.',
    `insurance_certificate_number` STRING COMMENT 'Identifier of the issued insurance certificate document.',
    `insurance_register_status` STRING COMMENT 'Current lifecycle status of the insurance policy.. Valid values are `active|expired|pending|cancelled|lapsed`',
    `insurer_name` STRING COMMENT 'Legal name of the insurance company providing the coverage.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the country where the policy is governed.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the policy.',
    `policy_document_reference` STRING COMMENT 'Location or identifier of the stored insurance certificate/document.',
    `policy_number` STRING COMMENT 'External identifier assigned by the insurer to the insurance policy.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Periodic payment amount required to keep the policy in force.',
    `premium_currency` STRING COMMENT 'Currency of the premium payment.',
    `premium_due_date` DATE COMMENT 'Date the next premium payment must be received.',
    `premium_payment_frequency` STRING COMMENT 'How often the premium is due.. Valid values are `monthly|quarterly|annually`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the policy satisfies all applicable regulatory requirements (OSHA, ISO, etc.).',
    `renewal_date` DATE COMMENT 'Date by which the policy must be renewed to avoid lapse.',
    `renewal_notification_sent` BOOLEAN COMMENT 'Flag indicating if a renewal reminder has been sent to the contract administrator.',
    `risk_class` STRING COMMENT 'Risk classification assigned to the policy based on project exposure.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the record.',
    CONSTRAINT pk_insurance_register PRIMARY KEY(`insurance_register_id`)
) COMMENT 'Maintains the register of all contractually required insurance policies for a contract, including contractor all-risk (CAR), third-party liability, professional indemnity, workers compensation, and marine cargo. Records policy number, insurer name, coverage type, coverage amount, policy period, deductible, and compliance status. Tracks insurance renewal obligations and notifies contract administrators of expiring coverage.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`subcontract` (
    `subcontract_id` BIGINT COMMENT 'System generated unique identifier for the subcontract record.',
    `scope_of_work_id` BIGINT COMMENT 'Foreign key linking to contract.scope_of_work. Business justification: A subcontract is let for a defined scope of work. subcontract.scope_summary is a free-text field that duplicates what scope_of_work.scope_name and scope_of_work.inclusions/exclusions provide authorita',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Links subcontract vendor to master vendor for compliance, insurance, and bonding checks.',
    `change_order_count` STRING COMMENT 'Total number of change orders issued against this subcontract.',
    `completion_date` DATE COMMENT 'Target date for subcontract completion as per the contract.',
    `compliance_status` STRING COMMENT 'Current compliance status of the subcontract with regulatory and contractual obligations.. Valid values are `compliant|non_compliant|pending`',
    `contract_category` STRING COMMENT 'High‑level category of the subcontract agreement (e.g., Engineering Procurement Construction, Guaranteed Maximum Price, Lump‑Sum).. Valid values are `EPC|GMP|LumpSum|UnitRate|CostPlus|TimeAndMaterial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subcontract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the subcontract value.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `defects_liability_period_end` DATE COMMENT 'Date when the defects liability period expires.',
    `effective_from` DATE COMMENT 'Date when the subcontract becomes legally binding (often the Notice to Proceed date).',
    `effective_until` DATE COMMENT 'Date when the subcontract ends or expires; null for open‑ended agreements.',
    `extension_of_time_days` STRING COMMENT 'Number of days granted as an extension of time for project completion.',
    `insurance_requirements` STRING COMMENT 'Summary of insurance coverage obligations for the subcontractor.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount stipulated for delays or breaches.',
    `milestone_description` STRING COMMENT 'Key contractual milestones associated with the subcontract.',
    `notice_to_proceed_date` DATE COMMENT 'Date when the subcontractor is authorized to commence work.',
    `payment_schedule_description` STRING COMMENT 'Textual description of the payment milestones and dates.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed for the subcontract.. Valid values are `net30|net45|net60|milestone|upon_completion`',
    `risk_rating` STRING COMMENT 'Qualitative risk rating assigned to the subcontract.. Valid values are `low|medium|high`',
    `safety_requirements` STRING COMMENT 'Safety and HSE obligations stipulated in the subcontract.',
    `subcontract_number` STRING COMMENT 'External contract number or code assigned to the subcontract as defined in the main contract documents.',
    `subcontract_status` STRING COMMENT 'Current lifecycle state of the subcontract.. Valid values are `draft|active|suspended|terminated|completed|closed`',
    `subcontract_type` STRING COMMENT 'Classification of the subcontract based on procurement approach (e.g., domestic, nominated, specialist, trade).. Valid values are `domestic|nominated|specialist|trade`',
    `updated_by` STRING COMMENT 'User identifier who last modified the subcontract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subcontract record.',
    `value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the subcontract as agreed in the contract.',
    `created_by` STRING COMMENT 'User identifier who created the subcontract record.',
    CONSTRAINT pk_subcontract PRIMARY KEY(`subcontract_id`)
) COMMENT 'Master record for subcontracts let by the main contractor to specialist trade and MEP (Mechanical Electrical Plumbing) subcontractors under the main contract. Captures subcontract type (domestic, nominated, specialist), subcontract value, scope summary, back-to-back terms with main contract, NTP date, completion date, and subcontract status. Distinct from the subcontractor domain master — this entity owns the contractual instrument, not the subcontractor party profile.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` (
    `subcontract_payment_id` BIGINT COMMENT 'System-generated unique identifier for the subcontract payment record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the master contract under which the subcontract work is performed.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Subcontract payment obligations in the contract domain are triggered by subcontractor invoices in finance. Linking them enables AP-to-subcontract payment matching, a standard construction accounts pay',
    `progress_update_id` BIGINT COMMENT 'Foreign key linking to schedule.progress_update. Business justification: Subcontract payments are certified based on measured progress of subcontract work. Linking subcontract_payment to the substantiating progress_update enables subcontract payment audit trails, pay-when-',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: subcontract_payment is the transactional payment record issued under a subcontract. Currently it only has agreement_id → agreement (the master contract), but lacks a direct FK to its immediate parent ',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_invoice. Business justification: Subcontract payment processing in construction requires matching each subcontract payment record to the specific vendor invoice that triggered it. AP teams use this link for payment reconciliation, th',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Subcontract payments are made for work completed at specific work fronts. This link enables work-front-level subcontractor payment tracking and cost control reporting — essential for project cost mana',
    `actual_payment_date` DATE COMMENT 'Date the payment was actually received by the subcontractor.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of taxes, fees, or other adjustments applied to the gross amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amounts.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Date by which the payment is contractually due.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount claimed before any deductions.',
    `is_late_payment` BOOLEAN COMMENT 'True if the actual payment date is later than the due date.',
    `is_ld_deduction_applied` BOOLEAN COMMENT 'True when liquidated damages have been deducted from the payment.',
    `is_retention_applied` BOOLEAN COMMENT 'True when a retention amount is held back from the payment.',
    `ld_deduction_amount` DECIMAL(18,2) COMMENT 'Amount deducted for liquidated damages, if applicable.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after all adjustments and deductions.',
    `notes` STRING COMMENT 'Free-text field for any additional comments or explanations.',
    `payment_channel` STRING COMMENT 'Interface through which the payment was processed.. Valid values are `electronic|manual|portal|mobile`',
    `payment_date` DATE COMMENT 'Date the payment was issued to the subcontractor.',
    `payment_method` STRING COMMENT 'Instrument used to make the payment.. Valid values are `bank_transfer|check|cash|credit_card|wire|online`',
    `payment_number` STRING COMMENT 'Business-visible identifier assigned to the payment application (e.g., PAY-2023-00123).. Valid values are `^[A-Z0-9-]+$`',
    `payment_type` STRING COMMENT 'Classification of the payment (e.g., progress payment, final payment).. Valid values are `progress|final|retention_release|interim`',
    `retention_amount` DECIMAL(18,2) COMMENT 'Portion of the payment retained per contract terms.',
    `retention_percent` DECIMAL(18,2) COMMENT 'Retention expressed as a percentage of the gross amount.',
    `subcontract_payment_status` STRING COMMENT 'Current lifecycle state of the payment record.. Valid values are `draft|submitted|approved|rejected|paid|cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment record.',
    CONSTRAINT pk_subcontract_payment PRIMARY KEY(`subcontract_payment_id`)
) COMMENT 'Transactional record of payment applications and payment certificates issued under each subcontract. Captures application amount, certified amount, retention deducted, LD deductions, net payment due, payment due date, and actual payment date. Enables back-to-back payment flow management between main contract receipts and subcontractor disbursements, supporting cash flow forecasting and pay-when-paid clause administration.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`dispute` (
    `dispute_id` BIGINT COMMENT 'System generated unique identifier for the contract dispute record.',
    `agreement_id` BIGINT COMMENT 'Reference to the underlying contract to which the dispute relates.',
    `construction_project_id` BIGINT COMMENT 'Reference to the project under which the contract and dispute are scoped.',
    `delay_event_id` BIGINT COMMENT 'Foreign key linking to schedule.delay_event. Business justification: Construction disputes frequently originate from unresolved delay events. dispute has fidic_clause and arbitration_reference but no FK to the originating delay_event. Claims and legal teams need this l',
    `commercial_change_order_id` BIGINT COMMENT 'Foreign key linking to contract.commercial_change_order. Business justification: dispute.change_order_reference is a STRING field that informally references a commercial change order. In construction, many disputes arise directly from contested change orders (e.g., disputed variat',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Construction disputes routinely cite specific drawings as evidence — discrepancies between issued drawings and as-built conditions, or conflicting drawing revisions, are common dispute grounds. Claims',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Construction disputes frequently arise directly from safety incidents — injury claims, property damage events, regulatory penalties. Legal case management, insurance claim processing, and FIDIC disput',
    `party_id` BIGINT COMMENT 'Identifier of the party (e.g., contractor, subcontractor) that raised the dispute.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Construction disputes frequently originate from specific work front conditions (changed ground conditions, access restrictions, productivity impacts). Linking dispute to work_front enables site-level ',
    `arbitration_reference` STRING COMMENT 'Reference number for any arbitration proceeding linked to the dispute.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Monetary amount claimed by the claimant in the dispute.',
    `claim_currency` STRING COMMENT 'Three‑letter ISO currency code for the claimed amount.. Valid values are `^[A-Z]{3}$`',
    `claim_reason_code` STRING COMMENT 'Standardized code describing the underlying reason for the claim (e.g., delayed_payment, scope_change).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was first created in the system.',
    `dab_reference` STRING COMMENT 'Reference identifier for the Dispute Adjudication Board case associated with the dispute.',
    `dispute_description` STRING COMMENT 'Detailed narrative describing the nature and background of the dispute.',
    `dispute_number` STRING COMMENT 'Business visible identifier or reference number assigned to the dispute.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute.. Valid values are `open|under_review|settled|closed|rejected|withdrawn`',
    `dispute_type` STRING COMMENT 'Category of the dispute indicating the primary issue area. [ENUM-REF-CANDIDATE: payment|scope|delay|quality|safety|environment|other — 7 candidates stripped; promote to reference product]',
    `escalation_deadline` DATE COMMENT 'Date by which the dispute must be escalated to higher authority if not resolved.',
    `fidic_clause` STRING COMMENT 'Specific FIDIC clause cited as governing the dispute resolution process.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the dispute is considered critical to project delivery or financial performance.',
    `legal_cost_amount` DECIMAL(18,2) COMMENT 'Total legal fees incurred for handling the dispute.',
    `legal_cost_currency` STRING COMMENT 'Currency of the legal cost amount.. Valid values are `^[A-Z]{3}$`',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Final monetary amount agreed upon to settle the dispute, after adjustments.',
    `priority` STRING COMMENT 'Business priority assigned to the dispute for escalation and handling.. Valid values are `low|medium|high|critical`',
    `resolution_amount` DECIMAL(18,2) COMMENT 'Monetary amount associated with the resolution (e.g., payment made, penalty applied).',
    `resolution_currency` STRING COMMENT 'ISO currency code for the resolution amount.. Valid values are `^[A-Z]{3}$`',
    `resolution_date` DATE COMMENT 'Date on which the dispute was formally resolved.',
    `resolution_outcome` STRING COMMENT 'Result of the dispute resolution process.. Valid values are `arbitration|mediation|settlement|court|dismissed|pending`',
    `settlement_currency` STRING COMMENT 'ISO currency code for the net settlement amount.. Valid values are `^[A-Z]{3}$`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the dispute was formally submitted.',
    `supporting_document_refs` STRING COMMENT 'Comma‑separated list of document identifiers or URLs that provide evidence for the dispute.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the dispute record.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Records formal disputes, claims, and adjudication proceedings arising under a contract. Captures dispute reference, dispute type (payment, scope, delay, quality), claim amount, dispute submission date, DAB (Dispute Adjudication Board) reference, arbitration reference, legal counsel assigned, current status, and resolution outcome. Supports FIDIC Clause 20 dispute resolution workflow and legal cost tracking.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` (
    `commercial_change_order_id` BIGINT COMMENT 'System generated unique identifier for the contract change order record.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Change orders carry schedule_impact_days and eot_claim_reference but no FK to the specific impacted activity. EOT substantiation and schedule impact analysis require tracing each CCO to the affected a',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Approved commercial change orders update the project budget. Linking CCO to the budget revision it triggered enables change order budget impact traceability — a key contract administration and finance',
    `change_order_id` BIGINT COMMENT 'FK reference to single source of truth project.project_change_order (SSOT dedup).',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: RFIs are a primary trigger for commercial change orders in construction — a design clarification RFI identifies a discrepancy, and the contractor submits a CCO for resulting cost/time impact. Linking ',
    `vendor_id` BIGINT COMMENT 'Identifier of the contractor or subcontractor responsible for executing the change order work.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Change orders frequently affect a particular work front; the link supports impact analysis per front.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments (e.g., taxes, fees, discounts) applied to the gross amount.',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the change order.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the change order received approval.',
    `change_order_number` STRING COMMENT 'External reference number assigned to the change order by the contract administration system.',
    `change_order_type` STRING COMMENT 'Classification of the change order purpose, e.g., addition, omission, time extension, price adjustment, or scope change.. Valid values are `addition|omission|time_extension|price_adjustment|scope_change`',
    `comments` STRING COMMENT 'Free‑form notes or remarks entered by users regarding the change order.',
    `contract_change_order_status` STRING COMMENT 'Current lifecycle status of the change order.. Valid values are `draft|submitted|approved|rejected|executed|closed`',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Monetary impact of the change order on the contract price (positive for additions, negative for omissions).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the change order record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.',
    `dlp_end_date` DATE COMMENT 'Date when the Defects Liability Period expires for work covered by the change order.',
    `effective_date` DATE COMMENT 'Date on which the change order becomes contractually effective.',
    `eot_claim_reference` STRING COMMENT 'Link to any Extension of Time claim associated with the schedule impact.',
    `executed_timestamp` TIMESTAMP COMMENT 'Date and time when the change order was executed and became binding.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before any adjustments, taxes, or discounts.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the change order is considered critical to project delivery.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the change order record.',
    `ld_provision_amount` DECIMAL(18,2) COMMENT 'Monetary amount stipulated for liquidated damages if the change order affects performance penalties.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after adjustments.',
    `reason_code` STRING COMMENT 'Standardized code indicating why the change order was initiated.. Valid values are `employer_directed|unforeseen_condition|design_change|regulatory|client_request`',
    `revised_completion_date` DATE COMMENT 'New contract completion date after applying schedule impact.',
    `schedule_impact_days` STRING COMMENT 'Number of days the contract schedule is extended or reduced due to the change order.',
    `scope_description` STRING COMMENT 'Narrative description of the work scope affected by the change order.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the change order was formally submitted for approval.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the change order record.',
    `variation_instruction_reference` STRING COMMENT 'Reference to the original variation instruction that triggered this change order.',
    `created_by` STRING COMMENT 'User identifier of the person who created the change order record.',
    CONSTRAINT pk_commercial_change_order PRIMARY KEY(`commercial_change_order_id`)
) COMMENT 'Authoritative log of all CO (Change Orders) and contract variations issued against a contract. Records variation instruction reference, scope description, reason code (employer-directed, unforeseen conditions, design change), cost impact (addition or omission), schedule impact in days, approval status, and executed value. Tracks the full variation lifecycle from instruction through valuation, negotiation, and formal execution. Links to EOT claims where schedule impact is asserted. [SSOT: distinct source of truth for contract domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`scope_of_work` (
    `scope_of_work_id` BIGINT COMMENT 'Unique identifier for the contract scope record.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Each scope of work item is assigned a cost code for cost control and budget tracking. This is standard construction cost management practice — a quantity surveyor expects every scope item to map to a ',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Scope of work in construction contracts is defined by specific drawings — the drawing is the graphical contract document that governs what is to be built. Contract scope verification, progress measure',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Every defined scope of work in construction requires an approved SWMS before work commences — a standard HSE and contractual obligation. HSE auditors and project managers verify each scope item has a ',
    `actual_end_date` DATE COMMENT 'Actual date work on the scope was completed.',
    `actual_start_date` DATE COMMENT 'Actual date work on the scope began.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the scope was formally approved.',
    `attachments_flag` BOOLEAN COMMENT 'Indicates whether supporting documents are attached to the scope record.',
    `compliance_requirements` STRING COMMENT 'Text describing regulatory or compliance conditions tied to the scope.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scope record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD`',
    `dlp_end_date` DATE COMMENT 'Date when the defects liability period expires.',
    `effective_end_date` DATE COMMENT 'Date when the scope ceases to be binding (nullable for open‑ended scopes).',
    `effective_start_date` DATE COMMENT 'Date when the scope becomes contractually binding.',
    `eot_entitlement_flag` BOOLEAN COMMENT 'Indicates whether the scope includes entitlement to extensions of time.',
    `exclusions` STRING COMMENT 'Text describing work items explicitly excluded from the scope.',
    `inclusions` STRING COMMENT 'Text describing work items explicitly included in the scope.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Monetary amount stipulated for liquidated damages under the contract.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the scope.',
    `planned_end_date` DATE COMMENT 'Planned completion date for the scope.',
    `planned_start_date` DATE COMMENT 'Planned start date for execution of the scope.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the total quantity (e.g., cubic meters, kilograms).. Valid values are `m3|kg|ton|unit|sq_m`',
    `revision_number` STRING COMMENT 'Sequential revision number for the scope document.',
    `risk_level` STRING COMMENT 'Overall risk classification for the scope.. Valid values are `low|medium|high|critical`',
    `scope_code` STRING COMMENT 'Business identifier code for the scope of works.',
    `scope_name` STRING COMMENT 'Human‑readable name or title of the scope of works.',
    `scope_status` STRING COMMENT 'Current lifecycle status of the scope.. Valid values are `active|inactive|completed|cancelled|draft`',
    `scope_type` STRING COMMENT 'Classification of the scope (e.g., design, construction, procurement).. Valid values are `design|construction|procurement|commissioning|maintenance`',
    `total_amount` DECIMAL(18,2) COMMENT 'Monetary value of the scope before taxes and adjustments.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all items covered by the scope.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scope record.',
    `version_number` STRING COMMENT 'Version identifier (e.g., v1.0, v2.1) for the scope.',
    `wbs_reference` STRING COMMENT 'Human‑readable WBS code or description.',
    CONSTRAINT pk_scope_of_work PRIMARY KEY(`scope_of_work_id`)
) COMMENT 'Defines the detailed scope of works attached to a contract agreement, including WBS (Work Breakdown Structure) reference, deliverable descriptions, technical specifications reference, BOQ (Bill of Quantities) linkage, geographic boundaries, and exclusions. Serves as the authoritative scope baseline against which change orders and EOT (Extension of Time) claims are evaluated. [SSOT: distinct source of truth for contract domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` (
    `scope_variation_item_id` BIGINT COMMENT 'Primary key for the scope_variation_item association',
    `commercial_change_order_id` BIGINT COMMENT 'Foreign key linking to the commercial change order that drives this scope variation',
    `scope_of_work_id` BIGINT COMMENT 'Foreign key linking to the scope of work package affected by this variation',
    `approval_status` STRING COMMENT 'The approval state of this specific scope-variation pairing. May differ from the overall CO approval status when individual scope impacts are negotiated or disputed separately during final account reconciliation.',
    `change_order_count` STRING COMMENT 'Number of change orders that have been applied to this scope. [Moved from scope_of_work: This is a derived aggregate count of how many COs have been applied to this scope. It is a computed field that can be derived from the scope_variation_item association table via COUNT(). Storing it on scope_of_work creates a denormalized counter that must be maintained in sync. It does not belong on the parent entity — it belongs as a derivable metric from the association.]',
    `effective_date` DATE COMMENT 'The date on which this variation becomes effective for this specific scope package. May differ per scope package when a single CO is applied to multiple scopes with staggered implementation dates.',
    `quantity_delta` DECIMAL(18,2) COMMENT 'The BOQ quantity change (positive for addition, negative for omission) for this specific scope item resulting from this change order. Essential for BOQ adjustment tracking at the scope-package level.',
    `scope_change_description` STRING COMMENT 'Narrative description of what specifically changed within this scope package as a result of this change order. Distinct from the CO-level scope_description which describes the overall variation instruction.',
    `scope_impact_amount` DECIMAL(18,2) COMMENT 'The monetary impact of this specific change order on this specific scope package. Distinct from the COs total cost_impact_amount, which aggregates across all affected scopes. Required for BOQ-level final account reconciliation.',
    CONSTRAINT pk_scope_variation_item PRIMARY KEY(`scope_variation_item_id`)
) COMMENT 'This association product represents the Contract linkage between a scope_of_work package and a commercial_change_order in FIDIC-based construction contract administration. It captures the specific impact of a variation instruction on an individual scope package, enabling final account reconciliation, BOQ adjustments, and EOT substantiation at the scope-package level. Each record links one scope_of_work to one commercial_change_order with attributes that exist only in the context of this scope-variation pairing.. Existence Justification: In FIDIC-based EPC and lump-sum construction contracts, a single scope package (scope_of_work) can be affected by multiple change orders over the contract lifecycle (e.g., a civil works scope may receive a design change CO, an unforeseen conditions CO, and an employer-directed CO). Conversely, a single change order can span multiple scope packages simultaneously (e.g., a site-wide acceleration instruction affecting civil, mechanical, and electrical scopes). The business actively manages this relationship as a scope variation item or variation scope mapping — a recognized artifact in final account reconciliation, BOQ adjustments, and EOT substantiation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ADD CONSTRAINT `fk_contract_payment_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_payment_schedule_id` FOREIGN KEY (`payment_schedule_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_schedule`(`payment_schedule_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_commercial_change_order_id` FOREIGN KEY (`commercial_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`commercial_change_order`(`commercial_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ADD CONSTRAINT `fk_contract_insurance_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ADD CONSTRAINT `fk_contract_insurance_register_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_commercial_change_order_id` FOREIGN KEY (`commercial_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`commercial_change_order`(`commercial_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ADD CONSTRAINT `fk_contract_scope_variation_item_commercial_change_order_id` FOREIGN KEY (`commercial_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`commercial_change_order`(`commercial_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ADD CONSTRAINT `fk_contract_scope_variation_item_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope_of_work`(`scope_of_work_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_construction_v1`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `master_services_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Services Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Client Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `prequalification_id` SET TAGS ('dbx_business_glossary_term' = 'Client Prequalification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Issuance Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|suspended|terminated|closed');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'supplemental|variation|novation');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `boq_reference` SET TAGS ('dbx_business_glossary_term' = 'BOQ Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `defects_liability_period_months` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (Months)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `dispute_resolution` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `environmental_impact_assessment_ref` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `extension_of_time_days` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (Days)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `geographic_location` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_business_glossary_term' = 'Health & Safety Plan Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `notice_to_proceed_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract Value');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `wbs_reference` SET TAGS ('dbx_business_glossary_term' = 'WBS Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Identifier');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `is_jv_partner` SET TAGS ('dbx_business_glossary_term' = 'Joint‑Venture Partner Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `is_primary_party` SET TAGS ('dbx_business_glossary_term' = 'Primary Party Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country Code)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Party Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Participation Percentage');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type (Classification)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|net90|upon_receipt');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `role_in_contract` SET TAGS ('dbx_business_glossary_term' = 'Role in Contract');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `role_in_contract` SET TAGS ('dbx_value_regex' = 'owner|contractor|consultant|guarantor|subcontractor|joint_venture');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `signatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Signatory Authority Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` SET TAGS ('dbx_subdomain' = 'payment_compliance');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date (ACT_PAY_DT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `advance_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'Advance Balance Remaining (ADV_BAL_REMAIN)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount (ADV_AMT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `advance_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Flag (ADV_FLAG)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `advance_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recovery Amount (ADV_REC_AMT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Business Event Timestamp (EVENT_TS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Description (DESC)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (GROSS_AMT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `guarantee_reference` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Reference (GUAR_REF)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `installment_number` SET TAGS ('dbx_business_glossary_term' = 'Installment Number (INST_NUM)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `is_final_payment` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Indicator (FINAL_FLAG)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|closed|void');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `net_amount_after_discount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount After Discount (NET_AMT_DISC)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Date (CERT_DT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Number (CERT_NUM)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cheque|cash|credit_card');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Reference (PAY_METHOD_REF)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_source` SET TAGS ('dbx_business_glossary_term' = 'Payment Source (PAY_SOURCE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_source` SET TAGS ('dbx_value_regex' = 'employer|client|owner');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|rejected|cancelled');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type (PAY_TYPE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'milestone|time_based|retention|advance|final');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount (RET_AMT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `retention_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Amount (RET_REL_AMT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `retention_release_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Date (RET_REL_DT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number (SCH_NUM)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Date (SCHD_DT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `total_installments` SET TAGS ('dbx_business_glossary_term' = 'Total Installments (TOTAL_INST)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` SET TAGS ('dbx_subdomain' = 'payment_compliance');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Payment Certificate ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `advance_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recovery Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Number (PCN)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^CP[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date and Time');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `certification_version` SET TAGS ('dbx_business_glossary_term' = 'Certification Version');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `certified_amount` SET TAGS ('dbx_business_glossary_term' = 'Certified Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `change_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Order Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `is_advance_recovered` SET TAGS ('dbx_business_glossary_term' = 'Advance Recovery Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `is_ld_applied` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Applied Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `is_pay_when_paid` SET TAGS ('dbx_business_glossary_term' = 'Pay‑When‑Paid Clause Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `is_retention_applied` SET TAGS ('dbx_business_glossary_term' = 'Retention Applied Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `ld_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Deduction (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `net_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Due (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certificate Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_certificate_status` SET TAGS ('dbx_value_regex' = 'draft|issued|approved|rejected|paid|cancelled');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cheque|cash|letter_of_credit');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|reconciled');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'interim|final');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `work_progress_percent` SET TAGS ('dbx_business_glossary_term' = 'Work Progress Percent');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Project Change Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `commercial_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change Order ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|executed|closed');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'supplemental|variation|novation|deed_of_variation|addendum');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_category` SET TAGS ('dbx_business_glossary_term' = 'Amendment Category');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_category` SET TAGS ('dbx_value_regex' = 'financial|schedule|scope|quality|safety');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `contract_milestone` SET TAGS ('dbx_business_glossary_term' = 'Amendment Contract Milestone');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `document_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Signed Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Storage Path');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Until');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `impact_financial` SET TAGS ('dbx_business_glossary_term' = 'Amendment Financial Impact (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `impact_financial` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `impact_financial` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `impact_schedule_days` SET TAGS ('dbx_business_glossary_term' = 'Amendment Schedule Impact (Days)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `impact_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Scope Impact Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Amendment Confidential Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Amendment Last Modified By');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_review|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `original_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Original Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `payment_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustment Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `payment_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `payment_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `payment_schedule_new_date` SET TAGS ('dbx_business_glossary_term' = 'New Payment Schedule Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'design_change|scope_change|regulatory|client_request|cost_overrun');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract Value (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Amendment Risk Rating');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Amendment Scope');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Amendment Created By');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` SET TAGS ('dbx_subdomain' = 'risk_assurance');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bond Guarantee ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount (BOND_AMOUNT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_status` SET TAGS ('dbx_business_glossary_term' = 'Bond Status (BOND_STATUS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_status` SET TAGS ('dbx_value_regex' = 'active|expired|called|released|pending|cancelled');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bond Type (BOND_TYPE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'performance|advance|retention|bid|parent_company');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `call_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Call Condition Description (CALL_CONDITION_DESCRIPTION)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date (CALL_DATE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMPLIANCE_REQUIREMENTS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_description` SET TAGS ('dbx_business_glossary_term' = 'Bond Description (DESCRIPTION)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From (EFFECTIVE_FROM)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until (EFFECTIVE_UNTIL)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXPIRY_DATE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `guarantee_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Number (GUARANTEE_NUMBER)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `guarantee_purpose` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Purpose (GUARANTEE_PURPOSE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `guarantee_purpose` SET TAGS ('dbx_value_regex' = 'performance|payment|maintenance|completion|other');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date (ISSUE_DATE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURISDICTION)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date (RELEASE_DATE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage (RETENTION_PERCENTAGE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` SET TAGS ('dbx_subdomain' = 'risk_assurance');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurance_register_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Register ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Party ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `claim_history_available` SET TAGS ('dbx_business_glossary_term' = 'Claim History Available');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type (CT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'contractor_all_risk|third_party_liability|professional_indemnity|workers_compensation|marine_cargo|other');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurance_register_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurance_register_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|cancelled|lapsed');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country Code)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `policy_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number (PN)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `premium_due_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Due Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `renewal_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Sent');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `risk_class` SET TAGS ('dbx_business_glossary_term' = 'Risk Class');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `risk_class` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `scope_of_work_id` SET TAGS ('dbx_business_glossary_term' = 'Scope Of Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `contract_category` SET TAGS ('dbx_business_glossary_term' = 'Contract Category');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `contract_category` SET TAGS ('dbx_value_regex' = 'EPC|GMP|LumpSum|UnitRate|CostPlus|TimeAndMaterial');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `defects_liability_period_end` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `extension_of_time_days` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (Days)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `notice_to_proceed_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `payment_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|milestone|upon_completion');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_number` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_status` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|completed|closed');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_type` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_type` SET TAGS ('dbx_value_regex' = 'domestic|nominated|specialist|trade');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Value Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `value_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` SET TAGS ('dbx_subdomain' = 'payment_compliance');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `subcontract_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Payment ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `progress_update_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Update Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `is_late_payment` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Indicator');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `is_ld_deduction_applied` SET TAGS ('dbx_business_glossary_term' = 'LD Deduction Applied Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `is_retention_applied` SET TAGS ('dbx_business_glossary_term' = 'Retention Applied Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `ld_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Deduction');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'electronic|manual|portal|mobile');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|cash|credit_card|wire|online');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'progress|final|retention_release|interim');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `retention_percent` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `subcontract_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `subcontract_payment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|paid|cancelled');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` SET TAGS ('dbx_subdomain' = 'risk_assurance');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Dispute ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `delay_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `commercial_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Commercial Change Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `arbitration_reference` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `claim_currency` SET TAGS ('dbx_business_glossary_term' = 'Claim Currency');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `claim_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `claim_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Reason Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `dab_reference` SET TAGS ('dbx_business_glossary_term' = 'DAB Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|settled|closed|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `escalation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Escalation Deadline');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `fidic_clause` SET TAGS ('dbx_business_glossary_term' = 'FIDIC Clause Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `legal_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Legal Cost Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `legal_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Legal Cost Currency');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `legal_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `resolution_currency` SET TAGS ('dbx_business_glossary_term' = 'Resolution Currency');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `resolution_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|settlement|court|dismissed|pending');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `supporting_document_refs` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document References');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` SET TAGS ('dbx_subdomain' = 'payment_compliance');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `commercial_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Change Order ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Impacted Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Project Change Order Id');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `change_order_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `change_order_type` SET TAGS ('dbx_business_glossary_term' = 'Change Order Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `change_order_type` SET TAGS ('dbx_value_regex' = 'addition|omission|time_extension|price_adjustment|scope_change');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `contract_change_order_status` SET TAGS ('dbx_business_glossary_term' = 'Change Order Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `contract_change_order_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|executed|closed');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_ssot_source' = 'project.project_change_order');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ssot_source' = 'project.project_change_order');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_ssot_source' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_ssot_source' = 'project.project_change_order');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `eot_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time Claim Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Executed Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Change Order Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `ld_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Provision Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'employer_directed|unforeseen_condition|design_change|regulatory|client_request');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_ssot_source' = 'project.project_change_order');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_ssot_source' = 'subcontractor.subcontractor_change_order');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact (Days)');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_ssot_source' = 'project.project_change_order');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ssot_source' = 'project.project_change_order');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `variation_instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Variation Instruction Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `scope_of_work_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Scope End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Scope Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `attachments_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachments Present Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ssot_source' = 'design.design_scope');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Effective End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `eot_entitlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time Entitlement Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Scope Exclusions');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `inclusions` SET TAGS ('dbx_business_glossary_term' = 'Scope Inclusions');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scope Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Scope End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Scope Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'm3|kg|ton|unit|sq_m');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `revision_number` SET TAGS ('dbx_ssot_source' = 'design.design_scope');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Scope Risk Level');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `scope_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `scope_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `scope_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|cancelled|draft');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `scope_status` SET TAGS ('dbx_ssot_source' = 'design.design_scope');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'design|construction|procurement|commissioning|maintenance');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Scope Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ALTER COLUMN `wbs_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` SET TAGS ('dbx_association_edges' = 'contract.scope_of_work,contract.commercial_change_order');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `scope_variation_item_id` SET TAGS ('dbx_business_glossary_term' = 'Scope Variation Item - Scope Variation Item Id');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `commercial_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Scope Variation Item - Commercial Change Order Id');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `scope_of_work_id` SET TAGS ('dbx_business_glossary_term' = 'Scope Variation Item - Scope Of Work Id');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Scope Variation Approval Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Variation Effective Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `quantity_delta` SET TAGS ('dbx_business_glossary_term' = 'Quantity Delta');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `scope_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Scope Impact Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_variation_item` ALTER COLUMN `scope_impact_amount` SET TAGS ('dbx_financial' = 'true');
