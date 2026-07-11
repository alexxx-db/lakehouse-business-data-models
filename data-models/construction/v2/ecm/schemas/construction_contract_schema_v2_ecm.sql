-- Schema for Domain: contract | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:37:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`contract` COMMENT 'Authoritative contract repository governing all contractual agreements including FIDIC-based EPC, GMP (Guaranteed Maximum Price), lump-sum, and unit-rate contracts. Owns CO (Change Order) logs, LD (Liquidated Damages) provisions, DLP (Defects Liability Period) terms, EOT (Extension of Time) entitlements, payment schedules, and contract milestone administration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`agreement` (
    `agreement_id` BIGINT COMMENT 'System-generated unique identifier for the master contract record.',
    `account_id` BIGINT COMMENT 'Identifier of the client (owner) of the contract.',
    `approved_material_list_id` BIGINT COMMENT 'Foreign key linking to material.approved_material_list. Business justification: REQUIRED: Contracts include an approved material list for procurement compliance; experts expect a direct link to the list for validation and reporting.',
    `bid_opportunity_id` BIGINT COMMENT 'Foreign key linking to bid.bid_opportunity. Business justification: Opportunity tracking: linking contract to the originating bid opportunity supports pipeline‑to‑contract reporting and performance analysis.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Required for Permit Compliance Tracking: contracts must reference the specific permit authorizing the work; permits are reviewed before contract award.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project that the contract supports.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Environmental Impact Assessment linkage: contracts need to attach the approved assessment to satisfy regulatory and client environmental requirements.',
    `firm_profile_id` BIGINT COMMENT 'Identifier of the main subcontractor associated with the agreement.',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.green_certification. Business justification: Green building certifications are contractual deliverables; linking certification to the agreement tracks compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Required for assigning a project manager to each contract; used in project oversight and performance reports.',
    `tender_id` BIGINT COMMENT 'Foreign key linking to bid.tender. Business justification: Award process: contract is created from an awarded tender; linking enables contract‑tender audit trails and compliance reporting.',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary contractor responsible for delivering the work.',
    `waste_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_target. Business justification: Sustainability clauses often set waste‑diversion targets; the contract must reference the specific waste target record.',
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
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Needed for Communication Log and Regulatory Contact Register to identify the primary client contact responsible for a contract party.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Identifies the internal employee liaison for each contract party; used in communication logs and stakeholder registers.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to firm.firm_profile. Business justification: Contract Party Management links party records to firm firm profiles for compliance, reporting, and JV tracking.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`contract_scope` (
    `contract_scope_id` BIGINT COMMENT 'Unique identifier for the contract scope record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Each contract scope belongs to a single agreement; adding agreement_id creates a parent link and eliminates the silo.',
    `boq_id` BIGINT COMMENT 'Reference to the BOQ that quantifies the scope items.',
    `technical_specification_id` BIGINT COMMENT 'Identifier for the technical specification linked to the scope.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element that the scope aligns to.',
    `actual_end_date` DATE COMMENT 'Actual date work on the scope was completed.',
    `actual_start_date` DATE COMMENT 'Actual date work on the scope began.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the scope was formally approved.',
    `attachments_flag` BOOLEAN COMMENT 'Indicates whether supporting documents are attached to the scope record.',
    `change_order_count` STRING COMMENT 'Number of change orders that have been applied to this scope.',
    `city` STRING COMMENT 'City where the scope work is performed.',
    `compliance_requirements` STRING COMMENT 'Text describing regulatory or compliance conditions tied to the scope.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the scope is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scope record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD`',
    `dlp_end_date` DATE COMMENT 'Date when the defects liability period expires.',
    `effective_end_date` DATE COMMENT 'Date when the scope ceases to be binding (nullable for open‑ended scopes).',
    `effective_start_date` DATE COMMENT 'Date when the scope becomes contractually binding.',
    `eot_entitlement_flag` BOOLEAN COMMENT 'Indicates whether the scope includes entitlement to extensions of time.',
    `exclusions` STRING COMMENT 'Text describing work items explicitly excluded from the scope.',
    `geographic_area` STRING COMMENT 'Textual description of the geographic boundaries covered by the scope.',
    `inclusions` STRING COMMENT 'Text describing work items explicitly included in the scope.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the primary site for the scope.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Monetary amount stipulated for liquidated damages under the contract.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the primary site for the scope.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the scope.',
    `planned_end_date` DATE COMMENT 'Planned completion date for the scope.',
    `planned_start_date` DATE COMMENT 'Planned start date for execution of the scope.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the total quantity (e.g., cubic meters, kilograms).. Valid values are `m3|kg|ton|unit|sq_m`',
    `region` STRING COMMENT 'Region or state within the country for the scope location.',
    `revision_number` STRING COMMENT 'Sequential revision number for the scope document.',
    `risk_level` STRING COMMENT 'Overall risk classification for the scope.. Valid values are `low|medium|high|critical`',
    `scope_code` STRING COMMENT 'Business identifier code for the scope of works.',
    `scope_name` STRING COMMENT 'Human‑readable name or title of the scope of works.',
    `scope_status` STRING COMMENT 'Current lifecycle status of the scope.. Valid values are `active|inactive|completed|cancelled|draft`',
    `scope_type` STRING COMMENT 'Classification of the scope (e.g., design, construction, procurement).. Valid values are `design|construction|procurement|commissioning|maintenance`',
    `site_address` STRING COMMENT 'Full postal address of the construction site.',
    `total_amount` DECIMAL(18,2) COMMENT 'Monetary value of the scope before taxes and adjustments.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all items covered by the scope.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scope record.',
    `version_number` STRING COMMENT 'Version identifier (e.g., v1.0, v2.1) for the scope.',
    `wbs_reference` STRING COMMENT 'Human‑readable WBS code or description.',
    CONSTRAINT pk_contract_scope PRIMARY KEY(`contract_scope_id`)
) COMMENT 'Defines the detailed scope of works attached to a contract agreement, including WBS (Work Breakdown Structure) reference, deliverable descriptions, technical specifications reference, BOQ (Bill of Quantities) linkage, geographic boundaries, and exclusions. Serves as the authoritative scope baseline against which change orders and EOT (Extension of Time) claims are evaluated.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`contract_milestone` (
    `contract_milestone_id` BIGINT COMMENT 'System-generated unique identifier for the contract milestone record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the parent contract to which this milestone belongs.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project associated with the contract milestone.',
    `party_id` BIGINT COMMENT 'Identifier of the party (e.g., contractor, project manager) responsible for delivering the milestone.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Milestones are tied to work fronts for progress monitoring and payment certification.',
    `actual_date` DATE COMMENT 'Date the milestone was actually achieved or certified.',
    `amendment_number` STRING COMMENT 'Sequential number of any amendment made to the milestone.',
    `amendment_reason` STRING COMMENT 'Reason provided for the most recent amendment to the milestone.',
    `compliance_status` STRING COMMENT 'Indicates compliance of the milestone with contractual and regulatory requirements.. Valid values are `compliant|non-compliant|pending`',
    `contract_milestone_status` STRING COMMENT 'Current lifecycle status of the milestone.. Valid values are `planned|forecasted|achieved|delayed|cancelled`',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Difference between milestone_value and amount actually paid.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the milestone value.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `defects_notified_date` DATE COMMENT 'Date the employer formally notified the contractor of defects.',
    `contract_milestone_description` STRING COMMENT 'Free‑text description providing additional context for the milestone.',
    `dlp_end_date` DATE COMMENT 'End date of the Defects Liability Period.',
    `dlp_start_date` DATE COMMENT 'Start date of the Defects Liability Period associated with the milestone.',
    `final_certificate_issued_date` DATE COMMENT 'Date the final completion certificate was issued.',
    `forecast_date` DATE COMMENT 'Updated forecasted date based on progress and risk assessments.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the milestone is deemed critical for project schedule or payment.',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'Daily rate applied if liquidated damages are triggered.',
    `ld_triggered` BOOLEAN COMMENT 'Indicates whether liquidated damages have been incurred for this milestone.',
    `liquidated_damages_applicable` BOOLEAN COMMENT 'Flag indicating whether liquidated damages may be assessed for this milestone.',
    `milestone_code` STRING COMMENT 'Business identifier code for the milestone, used in contracts and payment schedules.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone (e.g., Notice to Proceed, Practical Completion).',
    `milestone_type` STRING COMMENT 'Classification of the milestone type according to contract terminology.. Valid values are `NTP|Sectional Completion|Practical Completion|Final Certificate|DLP Start|DLP End`',
    `milestone_value` DECIMAL(18,2) COMMENT 'Monetary value of the milestone, often linked to a payment certificate.',
    `notes` STRING COMMENT 'Additional notes or comments entered by users.',
    `outstanding_defects_flag` BOOLEAN COMMENT 'Indicates whether any defects remain unresolved at DLP expiry.',
    `payment_certificate_date` DATE COMMENT 'Date the payment certificate was issued.',
    `payment_certificate_number` STRING COMMENT 'Reference number of the payment certificate linked to the milestone.',
    `performance_certificate_date` DATE COMMENT 'Date the performance certificate was issued.',
    `performance_certificate_issued` BOOLEAN COMMENT 'Flag showing if a performance certificate has been issued for the milestone.',
    `planned_date` DATE COMMENT 'Date originally scheduled for the milestone in the contract baseline.',
    `rectification_deadline` DATE COMMENT 'Deadline by which the contractor must rectify notified defects.',
    `regulatory_reference` STRING COMMENT 'Reference to specific regulatory clause or standard governing the milestone (e.g., FIDIC Clause 12.1).',
    `retention_amount` DECIMAL(18,2) COMMENT 'Portion of the milestone value retained until final acceptance.',
    `retention_release_date` DATE COMMENT 'Scheduled date for releasing retained amounts after final acceptance.',
    `schedule_variance_days` STRING COMMENT 'Difference in days between planned_date and actual_date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    CONSTRAINT pk_contract_milestone PRIMARY KEY(`contract_milestone_id`)
) COMMENT 'Tracks contractually obligated milestones, key dates, and DLP (Defects Liability Period) obligations within a contract. Covers NTP (Notice to Proceed), sectional completion dates, practical completion, DLP start/end dates, performance certificate issuance, and final certificate dates. Records planned date, forecast date, actual achieved date, milestone value (if linked to payment), milestone type, and milestone status. Manages the complete DLP register including defects notified by the employer, contractor rectification commitments, rectification deadlines, outstanding defects at DLP expiry, and the transition from practical completion through to final certificate issuance and retention release. Used for LD (Liquidated Damages) trigger assessment, payment certification, DLP management, and retention release scheduling.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`payment_schedule` (
    `payment_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the payment schedule.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which this payment schedule belongs.',
    `contract_milestone_id` BIGINT COMMENT 'Identifier of the milestone associated with the payment.',
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
    `construction_project_id` BIGINT COMMENT 'Reference to the project associated with the contract.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or authority who certified the payment.',
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
    `milestone_code` STRING COMMENT 'Code identifying the contract milestone tied to this certificate.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`contract_change_order` (
    `contract_change_order_id` BIGINT COMMENT 'System generated unique identifier for the contract change order record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the original contract to which this change order applies.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Records which employee initiated a change order; essential for change‑order audit and approval workflow.',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Change Order driven by Regulatory Change: when a regulation changes, a change order records the reference to the regulatory_change record.',
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
    CONSTRAINT pk_contract_change_order PRIMARY KEY(`contract_change_order_id`)
) COMMENT 'Authoritative log of all CO (Change Orders) and contract variations issued against a contract. Records variation instruction reference, scope description, reason code (employer-directed, unforeseen conditions, design change), cost impact (addition or omission), schedule impact in days, approval status, and executed value. Tracks the full variation lifecycle from instruction through valuation, negotiation, and formal execution. Links to EOT claims where schedule impact is asserted.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` (
    `contract_eot_claim_id` BIGINT COMMENT 'System generated unique identifier for the EOT claim record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the underlying contract to which this EOT claim relates.',
    `ncr_id` BIGINT COMMENT 'Identifier of a Non‑Conformance Report linked to the claim.',
    `rfi_id` BIGINT COMMENT 'Identifier of a Request for Information that is associated with the claim.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the claim.',
    `contract_change_order_id` BIGINT COMMENT 'Identifier of a change order that may be linked to the time extension request.',
    `party_id` BIGINT COMMENT 'Identifier of the contractor submitting the EOT claim.',
    `employee_id` BIGINT COMMENT 'Identifier of the engineer or assessor responsible for the claim evaluation.',
    `tertiary_contract_claim_updated_by_user_employee_id` BIGINT COMMENT 'System user identifier who last modified the claim.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Financial value of the claim based on days claimed and daily rate.',
    `claim_approved_by` STRING COMMENT 'Name of the individual who approved or rejected the claim.',
    `claim_assessor_comments` STRING COMMENT 'Free‑text comments entered by the engineer or assessor during evaluation.',
    `claim_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `claim_currency` STRING COMMENT 'Three‑letter ISO currency code for the claim amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `claim_decision_date` DATE COMMENT 'Date when the final decision on the claim was recorded.',
    `claim_external_reference` STRING COMMENT 'Reference number used by external parties (e.g., client or auditor) to identify the claim.',
    `claim_final_amount` DECIMAL(18,2) COMMENT 'Final monetary amount after any adjustments or partial approvals.',
    `claim_final_days` STRING COMMENT 'Total number of days finally approved for the extension.',
    `claim_impact_on_milestones` STRING COMMENT 'Explanation of how the extension affects key project milestones.',
    `claim_is_critical` BOOLEAN COMMENT 'True if the claim is deemed critical to project delivery or financial exposure.',
    `claim_new_schedule_date` DATE COMMENT 'Projected completion date after applying the approved extension.',
    `claim_notes` STRING COMMENT 'Additional free‑form notes captured by any stakeholder.',
    `claim_number` STRING COMMENT 'Unique claim number assigned by the contractor or system for tracking.',
    `claim_original_schedule_date` DATE COMMENT 'Baseline project completion date before any extensions.',
    `claim_priority` STRING COMMENT 'Priority level assigned to the claim for processing urgency.. Valid values are `high|medium|low`',
    `claim_resolution_date` DATE COMMENT 'Date when the claim was fully closed and any adjustments were posted.',
    `claim_review_date` DATE COMMENT 'Date on which the claim was formally reviewed by the project engineer.',
    `claim_source_system` STRING COMMENT 'Originating operational system where the claim was first recorded.. Valid values are `Procore|Primavera|SAP`',
    `claim_status` STRING COMMENT 'Current processing status of the claim within the claim lifecycle.. Valid values are `submitted|under_review|approved|rejected|withdrawn`',
    `claim_status_reason` STRING COMMENT 'Explanation for the current status, such as reason for rejection or hold.',
    `claim_submission_timestamp` TIMESTAMP COMMENT 'Date and time when the contractor formally submitted the EOT claim.',
    `claim_type` STRING COMMENT 'Category describing the contractual basis for the time extension request.. Valid values are `employer_risk|force_majeure|client_change|weather|other`',
    `claim_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the claim record.',
    `days_assessed` STRING COMMENT 'Number of days approved by the engineer after assessment.',
    `days_claimed` STRING COMMENT 'Number of calendar days the contractor claims as an extension.',
    `delay_event_description` STRING COMMENT 'Narrative description of the event that caused the schedule delay.',
    `determination_outcome` STRING COMMENT 'Final decision result after engineering review.. Valid values are `approved|rejected|partial|pending`',
    `entitlement_basis` STRING COMMENT 'FIDIC sub‑clause or contractual provision that justifies the claim.',
    `liquidated_damages_impact` DECIMAL(18,2) COMMENT 'Estimated reduction in liquidated damages exposure due to the approved extension.',
    `revised_completion_date` DATE COMMENT 'New projected project completion date after the approved extension.',
    `supporting_document_refs` STRING COMMENT 'Comma‑separated list of document IDs (e.g., drawings, logs, photos) that substantiate the claim.',
    CONSTRAINT pk_contract_eot_claim PRIMARY KEY(`contract_eot_claim_id`)
) COMMENT 'Records EOT (Extension of Time) claims submitted by the contractor asserting entitlement to additional time due to employer risk events, force majeure, or other contractual grounds. Captures claim submission date, delay event description, days claimed, days assessed by engineer, grounds of entitlement (FIDIC Sub-Clause reference), supporting documentation references, and final determination outcome. Critical for managing LD (Liquidated Damages) exposure and revised completion date.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`ld_assessment` (
    `ld_assessment_id` BIGINT COMMENT 'System-generated unique identifier for each liquidated damages assessment record.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract to which this LD assessment applies.',
    `contract_milestone_id` BIGINT COMMENT 'Identifier of the specific contract milestone (e.g., substantial completion) that triggered the LD assessment.',
    `payment_certificate_id` BIGINT COMMENT 'Reference to the payment certificate from which the LD amount will be deducted.',
    `actual_completion_date` DATE COMMENT 'Date on which the milestone was actually completed, as recorded on site.',
    `assessed_by` STRING COMMENT 'Name of the individual or team that performed the LD assessment.',
    `assessment_date` DATE COMMENT 'Date on which the LD assessment was formally recorded.',
    `assessment_number` STRING COMMENT 'Business identifier assigned to the LD assessment, typically following the contracts numbering scheme.. Valid values are `^LD-d{6}$`',
    `assessment_reason` STRING COMMENT 'Narrative explanation for why the LD assessment was generated (e.g., missed milestone, force majeure).',
    `assessment_status` STRING COMMENT 'Current processing status of the LD assessment.. Valid values are `pending|approved|rejected|waived`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the LD amounts (e.g., USD, EUR).',
    `delay_days` STRING COMMENT 'Number of calendar days the milestone was delayed beyond the due date.',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'Contractual LD rate applied for each day of delay, expressed in the contract currency.',
    `ld_waiver_flag` BOOLEAN COMMENT 'Indicates whether a waiver has been granted for this assessment (true = waiver granted).',
    `ld_waiver_justification` STRING COMMENT 'Explanation or contractual clause supporting the granted waiver.',
    `milestone_due_date` DATE COMMENT 'Scheduled date by which the milestone was contractually required to be achieved.',
    `milestone_name` STRING COMMENT 'Descriptive name of the contractual milestone that was missed (e.g., "Substantial Completion").',
    `net_ld_deducted` DECIMAL(18,2) COMMENT 'Final liquidated damages amount deducted from the payment certificate after waivers.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the assessment.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the LD assessment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the LD assessment record.',
    `total_ld_amount` DECIMAL(18,2) COMMENT 'Gross liquidated damages amount before any waivers or reductions.',
    `waiver_amount` DECIMAL(18,2) COMMENT 'Amount of LD that has been waived or reduced per contractual negotiation.',
    CONSTRAINT pk_ld_assessment PRIMARY KEY(`ld_assessment_id`)
) COMMENT 'Tracks LD (Liquidated Damages) assessments applied or withheld against a contractor for failure to achieve contractual completion milestones. Records the milestone missed, LD rate per day (as defined in the contract appendix), number of days in delay, total LD amount assessed, any LD waiver or reduction granted, and the net LD deducted from payment certificates. Provides the authoritative LD register for financial reporting and dispute management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` (
    `contract_retention_ledger_id` BIGINT COMMENT 'System-generated unique identifier for each retention ledger record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which this retention record belongs.',
    `payment_certificate_id` BIGINT COMMENT 'Identifier of the payment certificate that triggered the retention calculation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Logs the employee entering retention ledger data; needed for financial control and traceability.',
    `contract_milestone_code` STRING COMMENT 'Code representing the contract milestone tied to this retention entry.. Valid values are `NTP|practical_completion|substantial_completion|interim|final`',
    `contract_retention_ledger_status` STRING COMMENT 'Current lifecycle status of the retention ledger entry.. Valid values are `active|released|closed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ledger record was first inserted.',
    `cumulative_retention_balance` DECIMAL(18,2) COMMENT 'Running total of retention still held after this release.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary values in this record.. Valid values are `^[A-Z]{3}$`',
    `effective_timestamp` TIMESTAMP COMMENT 'Exact point in time when the retention entry became effective.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the entry.',
    `release_amount` DECIMAL(18,2) COMMENT 'Amount of retention released in this transaction (partial or full).',
    `release_date` DATE COMMENT 'Calendar date on which the retention amount was released.',
    `release_reason` STRING COMMENT 'Free‑text explanation for why the retention was released (e.g., milestone achieved, DLP expiry).',
    `retention_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment to the retention (positive or negative) applied after initial calculation.',
    `retention_adjustment_reason` STRING COMMENT 'Explanation for why a retention adjustment was made.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Monetary amount retained for this entry before any releases.',
    `retention_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the retention bond when substitution occurs.',
    `retention_bond_currency` STRING COMMENT 'Currency of the retention bond amount.. Valid values are `^[A-Z]{3}$`',
    `retention_bond_substituted_flag` BOOLEAN COMMENT 'Indicates whether a retention bond was used in place of cash retention.',
    `retention_entry_number` STRING COMMENT 'Human‑readable sequential identifier for the retention entry, often used in reports and certificates.',
    `retention_hold_expiry_date` DATE COMMENT 'Date when a retention hold is scheduled to be lifted if unresolved.',
    `retention_hold_flag` BOOLEAN COMMENT 'Indicates if the retention amount is currently on hold (e.g., due to dispute).',
    `retention_hold_reason` STRING COMMENT 'Explanation for why the retention is being held.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the payment amount retained as per contract terms (e.g., 5.00%).',
    `retention_release_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total retention released in this transaction.',
    `retention_release_sequence` STRING COMMENT 'Ordinal number indicating the order of releases for a given contract.',
    `retention_release_type` STRING COMMENT 'Reason category for the retention release (e.g., practical completion, DLP expiry).. Valid values are `practical_completion|defects_liability|bond_substitution|partial|final`',
    `retention_source` STRING COMMENT 'Origin of the retention amount (e.g., regular payment certificate, change order, or manual adjustment).. Valid values are `payment_certificate|change_order|adjustment`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the ledger record.',
    CONSTRAINT pk_contract_retention_ledger PRIMARY KEY(`contract_retention_ledger_id`)
) COMMENT 'Tracks the accumulation and release of retention monies held under a contract. Records retention percentage applied per payment certificate, cumulative retention balance, practical completion release amount (typically 50% of retention), DLP (Defects Liability Period) expiry release amount, retention bond substitution details, and any partial releases approved. Provides the authoritative retention balance for financial reconciliation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`dlp_register` (
    `dlp_register_id` BIGINT COMMENT 'System generated unique identifier for each DLP register record.',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - DLP registers track defects liability periods per project',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Assigns an employee owner for each Defect Liability Period; used in DLP monitoring and responsibility reports.',
    `agreement_id` BIGINT COMMENT 'Unique identifier of the contract to which this DLP register belongs.',
    `wbs_element_id` BIGINT COMMENT 'add column wbs_element_id (BIGINT) with FK to project.wbs_element.wbs_element_id - DLP items relate to specific WBS elements/zones',
    `certification_issued_date` DATE COMMENT 'Date the DLP completion certificate was issued.',
    `contractor_rectification_deadline` DATE COMMENT 'Latest date by which the contractor must rectify the notified defect.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DLP register record was first created.',
    `defect_notified_date` DATE COMMENT 'Date the employer formally notified a defect during the DLP.',
    `dlp_certification_issued` BOOLEAN COMMENT 'Flag indicating whether a DLP completion certificate has been issued.',
    `dlp_closure_reason` STRING COMMENT 'Reason why the DLP was closed.. Valid values are `completion|termination|mutual_agreement|other`',
    `dlp_closure_reason_detail` STRING COMMENT 'Additional details explaining the closure reason.',
    `dlp_compliance_status` STRING COMMENT 'Compliance assessment of the DLP against contractual and regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `dlp_document_reference` STRING COMMENT 'Reference identifier for the primary DLP documentation (e.g., file ID).',
    `dlp_end_date` DATE COMMENT 'Scheduled date when the DLP expires, assuming no extensions.',
    `dlp_extension_end_date` DATE COMMENT 'New expiry date after an approved DLP extension.',
    `dlp_extension_granted` BOOLEAN COMMENT 'Indicates whether an extension to the DLP has been approved.',
    `dlp_inspection_date` DATE COMMENT 'Date on which the required DLP inspection was performed.',
    `dlp_inspection_required` BOOLEAN COMMENT 'Indicates whether a formal inspection is required before DLP closure.',
    `dlp_milestone_code` STRING COMMENT 'Code linking the DLP to a specific project milestone.',
    `dlp_milestone_description` STRING COMMENT 'Description of the project milestone associated with the DLP.',
    `dlp_owner` STRING COMMENT 'Name of the party responsible for managing the DLP (e.g., contractor or client).',
    `dlp_recorded_by` STRING COMMENT 'Name of the user who entered or last updated the DLP record.',
    `dlp_release_date` DATE COMMENT 'Date when any retained security or financial hold is released after DLP closure.',
    `dlp_retention_amount` DECIMAL(18,2) COMMENT 'Monetary amount retained under the DLP for potential defect remediation.',
    `dlp_retention_currency` STRING COMMENT 'Currency of the retained amount (ISO 4217 code).',
    `dlp_start_date` DATE COMMENT 'Date when the DLP officially begins.',
    `dlp_status` STRING COMMENT 'Current lifecycle status of the DLP.. Valid values are `active|expired|closed|extended|terminated|pending`',
    `dlp_type` STRING COMMENT 'Classification of the DLP (e.g., standard, extended, or custom arrangement).. Valid values are `standard|extended|custom`',
    `final_certificate_date` DATE COMMENT 'Date the final completion certificate was issued, ending the DLP.',
    `is_liquidated_damages_applicable` BOOLEAN COMMENT 'Indicates whether liquidated damages provisions apply during the DLP.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Monetary amount specified for liquidated damages, if applicable.',
    `liquidated_damages_currency` STRING COMMENT 'Currency of the liquidated damages amount (ISO 4217 code).',
    `notes` STRING COMMENT 'Additional free‑form notes or comments related to the DLP.',
    `outstanding_defects_count` STRING COMMENT 'Number of defects still open at the time of record capture.',
    `outstanding_defects_description` STRING COMMENT 'Free‑text description of the remaining defects at DLP expiry.',
    `performance_certificate_date` DATE COMMENT 'Date the performance certificate was issued, marking practical completion.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DLP register record.',
    CONSTRAINT pk_dlp_register PRIMARY KEY(`dlp_register_id`)
) COMMENT 'Manages the DLP (Defects Liability Period) obligations for each contract or sectional completion. Records DLP start date, DLP end date, defects notified by the employer, contractor rectification commitments, performance certificate issuance date, and outstanding defects at DLP expiry. Tracks the transition from practical completion through to final certificate issuance and retention release.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique surrogate key for each contract amendment record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the original contract to which this amendment applies.',
    `contract_change_order_id` BIGINT COMMENT 'Identifier of a change order linked to this amendment, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Tracks employee who drafted a contract amendment; needed for amendment audit trails.',
    `amendment_number` STRING COMMENT 'Sequential identifier assigned to the amendment within the contract lifecycle.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `draft|pending_approval|approved|rejected|executed|closed`',
    `amendment_type` STRING COMMENT 'Category of amendment indicating its nature.. Valid values are `supplemental|variation|novation|deed_of_variation|addendum`',
    `approval_date` DATE COMMENT 'Date when the amendment was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the amendment.',
    `amendment_category` STRING COMMENT 'High-level category of impact caused by the amendment.. Valid values are `financial|schedule|scope|quality|safety`',
    `change_order_number` STRING COMMENT 'External change order number associated with the amendment.',
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
    `agreement_id` BIGINT COMMENT 'add column agreement_id (BIGINT) with FK to contract.agreement.agreement_id - insurance registers track policies required under specific contracts',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - insurance coverage is project-specific',
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
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Subcontract Permit Requirement: each subcontract must reference the permit(s) required for its scope of work.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Subcontract Environmental Assessment: linking subcontract to its specific environmental assessment ensures compliance monitoring.',
    `firm_profile_id` BIGINT COMMENT 'Identifier of the subcontractor party that performs the work.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: REQUIRED: Subcontracts specify the exact material to be supplied; this FK supports the Subcontract‑Material tracking sheet used in procurement.',
    `agreement_id` BIGINT COMMENT 'Identifier of the parent/main contract to which this subcontract is linked.',
    `subcontract_main_contract_agreement_id` BIGINT COMMENT 'Identifier of the overarching contract under which this subcontract is issued.',
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
    `scope_summary` STRING COMMENT 'Brief textual description of the work scope covered by the subcontract.',
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
    `firm_profile_id` BIGINT COMMENT 'Unique identifier of the subcontractor receiving the payment.',
    `payment_application_id` BIGINT COMMENT 'Identifier of the payment application submitted by the subcontractor.',
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
    `party_id` BIGINT COMMENT 'Identifier of the party (e.g., contractor, subcontractor) that raised the dispute.',
    `dispute_respondent_contract_party_id` BIGINT COMMENT 'Identifier of the party against whom the dispute is filed.',
    `employee_id` BIGINT COMMENT 'Identifier of the legal counsel or law firm representing the claimant or respondent.',
    `arbitration_reference` STRING COMMENT 'Reference number for any arbitration proceeding linked to the dispute.',
    `change_order_reference` STRING COMMENT 'Identifier of a related change order that may have triggered the dispute.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`advance_payment` (
    `advance_payment_id` BIGINT COMMENT 'System-generated unique identifier for the advance payment record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the underlying contract to which the advance payment is linked.',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - advance payments are project-specific financial transactions',
    `employee_id` BIGINT COMMENT 'add column employee_id (BIGINT) with FK to hr.employee.employee_id - advance payments need an approver reference',
    `vendor_id` BIGINT COMMENT 'Identifier of the contractor receiving the advance payment.',
    `advance_payment_status` STRING COMMENT 'Current lifecycle status of the advance payment.. Valid values are `pending|issued|partially_recovered|fully_recovered|cancelled|reversed`',
    `amount_adjustment` DECIMAL(18,2) COMMENT 'Any adjustments (fees, taxes, interest) applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount of the advance payment before any adjustments or fees.',
    `amount_net` DECIMAL(18,2) COMMENT 'Net amount after adjustments, representing the actual funds made available to the contractor.',
    `contract_value` DECIMAL(18,2) COMMENT 'Original total monetary value of the contract associated with the advance payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the advance payment record was first created in the system.',
    `cumulative_recovered_amount` DECIMAL(18,2) COMMENT 'Total amount recovered to date through payment certificate deductions or other recoveries.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the advance payment (e.g., USD, EUR).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used if the advance payment currency differs from the reporting currency.',
    `exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was determined.',
    `guarantee_expiry_date` DATE COMMENT 'Date on which the guarantee for the advance payment expires.',
    `guarantee_reference` STRING COMMENT 'Reference identifier for the guarantee (bank, insurance, performance) backing the advance payment.',
    `guarantee_type` STRING COMMENT 'Type of guarantee provided for the advance payment.. Valid values are `bank|insurance|performance|none`',
    `interest_accrued_amount` DECIMAL(18,2) COMMENT 'Interest amount accrued to date on the outstanding balance.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the outstanding balance, expressed as a percent.',
    `is_guarantee_required` BOOLEAN COMMENT 'Indicates whether a guarantee is required for this advance payment.',
    `is_interest_applicable` BOOLEAN COMMENT 'True if interest is charged on the outstanding balance.',
    `is_recovered` BOOLEAN COMMENT 'True when the outstanding balance has been fully recovered.',
    `is_tax_included` BOOLEAN COMMENT 'Indicates whether tax is already included in the gross amount.',
    `issue_date` DATE COMMENT 'Date the advance payment was disbursed to the contractor.',
    `last_recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered in the most recent recovery transaction.',
    `last_recovery_date` DATE COMMENT 'Date of the most recent recovery transaction.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the advance payment.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining amount of the advance payment that has not yet been recovered.',
    `payment_number` STRING COMMENT 'Business identifier assigned to the advance payment, used in contracts and accounting.',
    `payment_terms` STRING COMMENT 'Contractual terms governing the advance payment (e.g., 30 days net).',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage of the total contract value that the advance payment represents.',
    `recovery_method` STRING COMMENT 'Method used to recover the advance payment.. Valid values are `invoice_deduction|direct_payment|retention|other`',
    `repayment_end_date` DATE COMMENT 'Date by which the full advance payment must be recovered.',
    `repayment_frequency` STRING COMMENT 'Frequency at which repayments are scheduled.. Valid values are `monthly|quarterly|milestone|lump_sum`',
    `repayment_schedule_description` STRING COMMENT 'Free‑text description of the repayment schedule (e.g., monthly installments, milestone‑based).',
    `repayment_start_date` DATE COMMENT 'Date when the contractor must begin repaying the advance payment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the advance payment.',
    `tax_code` STRING COMMENT 'Tax code applicable to the advance payment.. Valid values are `VAT|GST|NONE`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the advance payment record.',
    CONSTRAINT pk_advance_payment PRIMARY KEY(`advance_payment_id`)
) COMMENT 'Tracks advance payment (mobilization payment) transactions issued to contractors under contract terms. Records advance payment amount, advance payment percentage of contract value, issue date, repayment schedule, cumulative amount recovered through payment certificate deductions, outstanding advance balance, and advance payment guarantee reference. Manages the full advance payment lifecycle from disbursement through full recovery.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`closeout` (
    `closeout_id` BIGINT COMMENT 'System-generated unique identifier for each contract closeout record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the original contract that is being closed out.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Records who finalised contract close‑out; required for close‑out certification and audit.',
    `document_register_id` BIGINT COMMENT 'Identifier of the primary document package associated with the closeout.',
    `party_id` BIGINT COMMENT 'Identifier of the primary party (owner/client) associated with the closeout.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments (retentions, penalties, change order impacts) applied to the gross amount.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the closeout.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the closeout was approved.',
    `bond_release_flag` BOOLEAN COMMENT 'Indicates whether performance/bid bonds have been released.',
    `change_order_summary` STRING COMMENT 'Narrative summary of all change orders applied during the project.',
    `checklist_completed_date` DATE COMMENT 'Date when the closeout checklist was marked as completed.',
    `checklist_status` STRING COMMENT 'Progress status of the closeout checklist.. Valid values are `not_started|in_progress|completed`',
    `closeout_date` DATE COMMENT 'Date on which the contract was officially closed out.',
    `closeout_number` STRING COMMENT 'External reference number assigned to the contract closeout process.',
    `closeout_status` STRING COMMENT 'Current lifecycle state of the closeout record.. Valid values are `draft|in_review|approved|rejected|closed`',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance status of the closeout.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the closeout record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `dlp_end_date` DATE COMMENT 'Date when the Defects Liability Period expires.',
    `eot_claims_settled_flag` BOOLEAN COMMENT 'Indicates whether all Extension of Time claims have been settled.',
    `final_account_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount before adjustments for the final account.',
    `final_contract_value` DECIMAL(18,2) COMMENT 'Contract value after all change orders and adjustments.',
    `final_payment_certificate_number` STRING COMMENT 'Reference number of the final payment certificate issued to the contractor.',
    `is_finalized` BOOLEAN COMMENT 'Indicates whether the closeout record has been finalized and locked.',
    `ld_waiver_flag` BOOLEAN COMMENT 'Indicates whether a waiver for liquidated damages was granted.',
    `lessons_learned_reference` STRING COMMENT 'Link or identifier to the documented lessons‑learned record for the project.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net amount payable after all adjustments.',
    `o_m_manual_handover_date` DATE COMMENT 'Date the Operations & Maintenance manual was handed over to the client.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'The baseline contract amount before any changes.',
    `outstanding_punch_items_count` STRING COMMENT 'Number of punch‑list items still open at the time of closeout.',
    `performance_certificate_issued_date` DATE COMMENT 'Date the performance certificate was issued to the contractor.',
    `practical_completion_date` DATE COMMENT 'Date when practical completion of the project was declared.',
    `punch_list_status` STRING COMMENT 'Current status of the punch‑list items at closeout.. Valid values are `open|closed|partial`',
    `remarks` STRING COMMENT 'Free‑form comments or notes about the closeout.',
    `retention_release_flag` BOOLEAN COMMENT 'Indicates whether retention monies have been released (true) or are still held (false).',
    `signed_by_contractor` STRING COMMENT 'Name of the contractor signatory on the final closeout documents.',
    `signed_timestamp` TIMESTAMP COMMENT 'Date and time when the contractor signed the closeout documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the closeout record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between final and original contract values.',
    `warranty_end_date` DATE COMMENT 'End date of the warranty period.',
    `warranty_start_date` DATE COMMENT 'Start date of the warranty period for the completed works.',
    CONSTRAINT pk_closeout PRIMARY KEY(`closeout_id`)
) COMMENT 'Records the formal contract close-out process including practical completion declaration, final account agreement, performance certificate issuance, final payment certificate, retention release, bond release, and O&M (Operations and Maintenance) manual handover. Captures close-out checklist status, outstanding punch list items, final contract value versus original contract value, and lessons learned reference. Marks the definitive end of contractual obligations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`contractual_notice` (
    `contractual_notice_id` BIGINT COMMENT 'System-generated unique identifier for the contractual notice record.',
    `agreement_id` BIGINT COMMENT 'add column agreement_id (BIGINT) with FK to contract.agreement.agreement_id - contractual notices are issued under a specific contract agreement',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - contractual notices relate to specific project contexts',
    `party_id` BIGINT COMMENT 'Identifier of the party that issued the notice (e.g., contractor, client, subcontractor).',
    `receiving_party_id` BIGINT COMMENT 'Identifier of the party that is the intended recipient of the notice.',
    `response_to_contractual_notice_id` BIGINT COMMENT 'Self-referencing FK on contractual_notice (response_to_contractual_notice_id)',
    `acknowledgment_date` DATE COMMENT 'Date on which the receiving party acknowledged the notice.',
    `acknowledgment_status` STRING COMMENT 'Current acknowledgment state of the receiving party.. Valid values are `acknowledged|pending|rejected`',
    `clause_reference` STRING COMMENT 'Reference to the specific contract clause (e.g., FIDIC 20.1) that governs the notice.',
    `contractual_deadline` DATE COMMENT 'Statutory time‑bar deadline by which the notice must be served to preserve rights.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notice record was first created in the system.',
    `delivery_method` STRING COMMENT 'Means by which the notice was delivered to the receiving party.. Valid values are `email|registered_mail|hand_delivered|electronic_portal`',
    `contractual_notice_description` STRING COMMENT 'Free‑text description of the notice content and purpose.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the notice is considered critical for contract performance or claim entitlement.',
    `notice_date` DATE COMMENT 'Date on which the notice was formally issued.',
    `notice_number` STRING COMMENT 'External reference number assigned to the notice by the contract administration.',
    `notice_status` STRING COMMENT 'Overall lifecycle state of the notice.. Valid values are `issued|acknowledged|responded|closed|rejected`',
    `notice_type` STRING COMMENT 'Category of the contractual notice according to FIDIC and industry practice.. Valid values are `time_bar|delay|variation|payment|dissatisfaction|termination`',
    `record_source_system` STRING COMMENT 'Name of the operational system where the notice originated (e.g., Procore, Aconex).',
    `response_due_date` DATE COMMENT 'Date by which the receiving party must respond to the notice.',
    `supporting_document_refs` STRING COMMENT 'Comma‑separated list of document identifiers attached to the notice (e.g., PDFs, drawings).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the notice record.',
    CONSTRAINT pk_contractual_notice PRIMARY KEY(`contractual_notice_id`)
) COMMENT 'Authoritative register of all contractual notices issued or received under a contract, including FIDIC Clause 20.1 time-bar notices, delay notices, variation notices, payment notices, dissatisfaction notices, and termination notices. Records notice type, issuing party, receiving party, notice date, contractual time-bar deadline, clause reference, delivery method, acknowledgment status, and response due date. Critical for managing FIDIC time-bar compliance where failure to notify within prescribed periods results in loss of entitlement to claims, EOT, or additional payment.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` (
    `change_order_activity_impact_id` BIGINT COMMENT 'Primary key for the change_order_activity_impact association',
    `activity_id` BIGINT COMMENT 'Foreign key linking to the schedule activity',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - change order activity impacts need project context',
    `contract_change_order_id` BIGINT COMMENT 'Foreign key linking to the contract change order',
    `impact_type` STRING COMMENT 'Category of impact (e.g., scope, cost, schedule)',
    `revised_cost` DECIMAL(18,2) COMMENT 'Adjusted cost for the activity due to the change order',
    `revised_finish_date` DATE COMMENT 'New planned finish date for the activity after the change order',
    `revised_start_date` DATE COMMENT 'New planned start date for the activity after the change order',
    `schedule_impact_days` STRING COMMENT 'Number of days added or removed from the activity schedule',
    CONSTRAINT pk_change_order_activity_impact PRIMARY KEY(`change_order_activity_impact_id`)
) COMMENT 'Associative entity that records the impact of a contract change order on a schedule activity. Each row links one contract_change_order to one activity and stores impact-specific data such as revised dates, cost adjustments and impact type.. Existence Justification: A contract change order documents a variation to the contract scope, cost, or schedule. In practice each change order can affect many schedule activities, and a single activity can be impacted by multiple change orders over the life of a project. The relationship itself carries attributes such as revised dates, cost impact and impact type, which are managed by project staff.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` (
    `insurance_certificate_id` BIGINT COMMENT 'Unique identifier for the insurance certificate record. Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this insurance certificate is required. Enables project-level compliance reporting.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor who submitted this insurance certificate. Enables tracking of all certificates by subcontractor across multiple contracts.',
    `subcontract_id` BIGINT COMMENT 'Reference to the subcontract that this insurance certificate covers. Links the certificate to the specific scope-of-work agreement requiring insurance compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Insurance compliance verification is performed by a designated HR/compliance employee; needed for regulatory reporting.',
    `additional_insured_flag` BOOLEAN COMMENT 'Indicates whether the general contractor is named as an additional insured on the policy. Critical for liability protection and contract compliance.',
    `aggregate_limit` DECIMAL(18,2) COMMENT 'The maximum amount the insurer will pay for all claims during the policy period. Distinct from per-occurrence coverage limits.',
    `certificate_holder_address` STRING COMMENT 'The address of the certificate holder. Used for correspondence and verification purposes.',
    `certificate_holder_name` STRING COMMENT 'The name of the entity to whom the certificate is issued, typically the general contractor or project owner. Confirms the certificate is issued for the correct party.',
    `certificate_number` STRING COMMENT 'The unique certificate number issued by the insurance provider. This is the externally-known identifier used for verification and claims.',
    `certificate_status` STRING COMMENT 'The current compliance status of the insurance certificate. Drives site access decisions and compliance alerts.. Valid values are `valid|expiring_soon|expired|non_compliant|pending_verification|rejected`',
    `compliance_notes` STRING COMMENT 'Free-text notes regarding compliance issues, exceptions, or special conditions related to the insurance certificate. Used for audit trails and issue resolution.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'The total coverage limit provided by the insurance policy. Represents the maximum amount the insurer will pay for covered claims.',
    `coverage_currency` STRING COMMENT 'The currency in which the coverage amount is denominated. Three-letter ISO 4217 currency code.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this insurance certificate record was first created in the system. Used for audit trails and data lineage.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The deductible amount that the subcontractor must pay before insurance coverage applies. Impacts risk assessment and claims processing.',
    `document_url` STRING COMMENT 'The URL or file path to the digital copy of the insurance certificate document. Enables quick access for verification and audits.',
    `effective_date` DATE COMMENT 'The date when the insurance coverage becomes active. Used to determine if coverage is in force for site access and contract compliance.',
    `expiry_date` DATE COMMENT 'The date when the insurance coverage expires. Critical for compliance monitoring and triggering renewal alerts.',
    `insurer_name` STRING COMMENT 'The legal name of the insurance company that issued the policy. Used for verification and claims processing.',
    `insurer_rating` STRING COMMENT 'The financial strength rating of the insurance company (e.g., A.M. Best rating). Used to assess the reliability and solvency of the insurer.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this insurance certificate record was last modified. Used for change tracking and audit purposes.',
    `non_compliance_reason` STRING COMMENT 'The specific reason why the certificate is marked as non-compliant. Drives corrective action and communication with the subcontractor.',
    `per_occurrence_limit` DECIMAL(18,2) COMMENT 'The maximum amount the insurer will pay for a single claim or occurrence. Used to assess adequacy of coverage for high-risk activities.',
    `policy_number` STRING COMMENT 'The unique policy number assigned by the insurer. Used for verification and claims tracking.',
    `policy_type` STRING COMMENT 'The type of insurance policy covered by this certificate. Determines the risk category and compliance requirements for the subcontractor. [ENUM-REF-CANDIDATE: general_liability|workers_compensation|professional_indemnity|contractors_all_risk|employers_liability|auto_liability|umbrella|pollution_liability — 8 candidates stripped; promote to reference product]',
    `primary_non_contributory_flag` BOOLEAN COMMENT 'Indicates whether the subcontractors insurance is primary and non-contributory to the general contractors coverage. Ensures the subcontractors policy pays first.',
    `renewal_reminder_sent_date` DATE COMMENT 'The date when a renewal reminder was sent to the subcontractor. Used to track proactive compliance management efforts.',
    `submission_date` DATE COMMENT 'The date when the subcontractor submitted the insurance certificate to the general contractor. Used for compliance tracking and audit trails.',
    `verification_date` DATE COMMENT 'The date when the insurance certificate was verified by the general contractor or compliance team. Confirms authenticity and coverage adequacy.',
    `waiver_of_subrogation_flag` BOOLEAN COMMENT 'Indicates whether the policy includes a waiver of subrogation in favor of the general contractor. Prevents the insurer from pursuing claims against the GC.',
    CONSTRAINT pk_insurance_certificate PRIMARY KEY(`insurance_certificate_id`)
) COMMENT 'Insurance compliance certificates submitted by subcontractors as a condition of contract execution and ongoing site access. Tracks policy type (general liability, workers compensation, professional indemnity, contractors all-risk), insurer name, policy number, coverage amount, effective date, expiry date, certificate status (valid, expiring, expired, non-compliant), and the subcontract it covers. Drives compliance alerts for expiring coverage.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ADD CONSTRAINT `fk_contract_contract_scope_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ADD CONSTRAINT `fk_contract_payment_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ADD CONSTRAINT `fk_contract_payment_schedule_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ADD CONSTRAINT `fk_contract_contract_eot_claim_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ADD CONSTRAINT `fk_contract_contract_eot_claim_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ADD CONSTRAINT `fk_contract_contract_eot_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ADD CONSTRAINT `fk_contract_ld_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ADD CONSTRAINT `fk_contract_ld_assessment_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ADD CONSTRAINT `fk_contract_ld_assessment_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ADD CONSTRAINT `fk_contract_contract_retention_ledger_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ADD CONSTRAINT `fk_contract_contract_retention_ledger_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ADD CONSTRAINT `fk_contract_dlp_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ADD CONSTRAINT `fk_contract_insurance_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ADD CONSTRAINT `fk_contract_insurance_register_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_subcontract_main_contract_agreement_id` FOREIGN KEY (`subcontract_main_contract_agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_dispute_respondent_contract_party_id` FOREIGN KEY (`dispute_respondent_contract_party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ADD CONSTRAINT `fk_contract_advance_payment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ADD CONSTRAINT `fk_contract_contractual_notice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ADD CONSTRAINT `fk_contract_contractual_notice_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ADD CONSTRAINT `fk_contract_contractual_notice_receiving_party_id` FOREIGN KEY (`receiving_party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ADD CONSTRAINT `fk_contract_contractual_notice_response_to_contractual_notice_id` FOREIGN KEY (`response_to_contractual_notice_id`) REFERENCES `vibe_construction_v1`.`contract`.`contractual_notice`(`contractual_notice_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ADD CONSTRAINT `fk_contract_change_order_activity_impact_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ADD CONSTRAINT `fk_contract_insurance_certificate_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_construction_v1`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` SET TAGS ('dbx_ssot_owner' = 'contract_agreement');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `approved_material_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Material List Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `bid_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `firm_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Green Certification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `waste_target_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Target Id (Foreign Key)');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `geographic_location` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_business_glossary_term' = 'Health & Safety Plan Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_pii_flag' = 'true');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`party` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Identifier');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `firm_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `is_jv_partner` SET TAGS ('dbx_business_glossary_term' = 'Joint‑Venture Partner Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `is_primary_party` SET TAGS ('dbx_business_glossary_term' = 'Primary Party Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country Code)');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `signatory_authority` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `contract_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `boq_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Scope End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Scope Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `attachments_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachments Present Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Effective End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `eot_entitlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time Entitlement Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Scope Exclusions');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `geographic_area` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `inclusions` SET TAGS ('dbx_business_glossary_term' = 'Scope Inclusions');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scope Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Scope End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Scope Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'm3|kg|ton|unit|sq_m');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Scope Risk Level');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `scope_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `scope_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `scope_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `scope_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|cancelled|draft');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'design|construction|procurement|commissioning|maintenance');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `site_address` SET TAGS ('dbx_business_glossary_term' = 'Site Address');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Scope Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_scope` ALTER COLUMN `wbs_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amendment Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amendment Reason');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `contract_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `contract_milestone_status` SET TAGS ('dbx_value_regex' = 'planned|forecasted|achieved|delayed|cancelled');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `defects_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Notified Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `contract_milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `dlp_start_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `final_certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Final Certificate Issued Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Rate per Day');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `ld_triggered` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Triggered');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `liquidated_damages_applicable` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Applicable');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'NTP|Sectional Completion|Practical Completion|Final Certificate|DLP Start|DLP End');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `milestone_value` SET TAGS ('dbx_business_glossary_term' = 'Milestone Value');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `outstanding_defects_flag` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Defects Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `payment_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `payment_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `performance_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Certificate Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `performance_certificate_issued` SET TAGS ('dbx_business_glossary_term' = 'Performance Certificate Issued');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `rectification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Rectification Deadline');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `retention_release_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` SET TAGS ('dbx_subdomain' = 'payment_billing');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone ID');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Reference (PAY_METHOD_REF)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `payment_method_reference` SET TAGS ('dbx_pii_financial' = 'true');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `total_installments` SET TAGS ('dbx_business_glossary_term' = 'Total Installments (TOTAL_INST)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` SET TAGS ('dbx_subdomain' = 'payment_billing');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Payment Certificate ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifier ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `ld_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `net_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Due (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certificate Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_certificate_status` SET TAGS ('dbx_value_regex' = 'draft|issued|approved|rejected|paid|cancelled');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cheque|cash|letter_of_credit');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_method` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|reconciled');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'interim|final');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ALTER COLUMN `work_progress_percent` SET TAGS ('dbx_business_glossary_term' = 'Work Progress Percent');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` SET TAGS ('dbx_subdomain' = 'claims_variations');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Change Order ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `change_order_type` SET TAGS ('dbx_business_glossary_term' = 'Change Order Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `change_order_type` SET TAGS ('dbx_value_regex' = 'addition|omission|time_extension|price_adjustment|scope_change');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `contract_change_order_status` SET TAGS ('dbx_business_glossary_term' = 'Change Order Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `contract_change_order_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|executed|closed');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `eot_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time Claim Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Executed Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Change Order Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `ld_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Provision Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'employer_directed|unforeseen_condition|design_change|regulatory|client_request');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact (Days)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `variation_instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Variation Instruction Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` SET TAGS ('dbx_subdomain' = 'claims_variations');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `contract_eot_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Extension of Time (EOT) Claim ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Related NCR ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Related RFI ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change Order ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `tertiary_contract_claim_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `tertiary_contract_claim_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `tertiary_contract_claim_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `tertiary_contract_claim_updated_by_user_employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount (Monetary)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Claim Approver Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_approved_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_assessor_comments` SET TAGS ('dbx_business_glossary_term' = 'Assessor Comments');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_currency` SET TAGS ('dbx_business_glossary_term' = 'Claim Currency');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Decision Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_final_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Claim Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_final_days` SET TAGS ('dbx_business_glossary_term' = 'Final Approved Days');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_impact_on_milestones` SET TAGS ('dbx_business_glossary_term' = 'Milestone Impact Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Claim Indicator');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_new_schedule_date` SET TAGS ('dbx_business_glossary_term' = 'New Scheduled Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'EOT Claim Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_original_schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Original Scheduled Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_priority` SET TAGS ('dbx_business_glossary_term' = 'Claim Priority');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Resolution Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_review_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Review Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_source_system` SET TAGS ('dbx_value_regex' = 'Procore|Primavera|SAP');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'EOT Claim Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'EOT Claim Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'employer_risk|force_majeure|client_change|weather|other');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `claim_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `days_assessed` SET TAGS ('dbx_business_glossary_term' = 'Days Assessed');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `days_claimed` SET TAGS ('dbx_business_glossary_term' = 'Days Claimed');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `delay_event_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_business_glossary_term' = 'Claim Determination Outcome');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|partial|pending');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `entitlement_basis` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Basis (FIDIC Clause)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `liquidated_damages_impact` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Impact');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_eot_claim` ALTER COLUMN `supporting_document_refs` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document References');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` SET TAGS ('dbx_subdomain' = 'claims_variations');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `ld_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Assessment ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessed By (ASSESED_BY)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number (ASSESSMENT_NUMBER)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^LD-d{6}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `assessment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reason (ASSESSMENT_REASON)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status (ASSESSMENT_STATUS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|waived');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `delay_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Days (DELAY_DAYS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Rate Per Day (LD_RATE_PER_DAY)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `ld_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'LD Waiver Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `ld_waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'LD Waiver Justification');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `milestone_due_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Due Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name (MILESTONE_NAME)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `milestone_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `net_ld_deducted` SET TAGS ('dbx_business_glossary_term' = 'Net LD Deducted (NET_LD_DEDUCTED)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `total_ld_amount` SET TAGS ('dbx_business_glossary_term' = 'Total LD Amount (TOTAL_LD_AMOUNT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`ld_assessment` ALTER COLUMN `waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'LD Waiver Amount (LD_WAIVER_AMOUNT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` SET TAGS ('dbx_subdomain' = 'payment_billing');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `contract_retention_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Retention Ledger ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `contract_milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `contract_milestone_code` SET TAGS ('dbx_value_regex' = 'NTP|practical_completion|substantial_completion|interim|final');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `contract_retention_ledger_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Ledger Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `contract_retention_ledger_status` SET TAGS ('dbx_value_regex' = 'active|released|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `cumulative_retention_balance` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Retention Balance');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Retention Ledger Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `release_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Reason');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Retention Adjustment Reason');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Bond Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_bond_currency` SET TAGS ('dbx_business_glossary_term' = 'Retention Bond Currency (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_bond_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_bond_substituted_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Bond Substituted Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Retention Entry Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_hold_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Hold Expiry Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_hold_expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Hold Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Retention Hold Reason');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_release_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Percentage');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_release_sequence` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Sequence');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_release_type` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_release_type` SET TAGS ('dbx_value_regex' = 'practical_completion|defects_liability|bond_substitution|partial|final');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_source` SET TAGS ('dbx_business_glossary_term' = 'Retention Source');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `retention_source` SET TAGS ('dbx_value_regex' = 'payment_certificate|change_order|adjustment');
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_retention_ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_register_id` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period Register ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dlp Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `certification_issued_date` SET TAGS ('dbx_business_glossary_term' = 'DLP Certification Issued Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `contractor_rectification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Contractor Rectification Deadline');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `contractor_rectification_deadline` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `defect_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Defect Notification Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_certification_issued` SET TAGS ('dbx_business_glossary_term' = 'DLP Certification Issued');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_closure_reason` SET TAGS ('dbx_business_glossary_term' = 'DLP Closure Reason');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_closure_reason` SET TAGS ('dbx_value_regex' = 'completion|termination|mutual_agreement|other');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_closure_reason_detail` SET TAGS ('dbx_business_glossary_term' = 'DLP Closure Reason Detail');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'DLP Compliance Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_document_reference` SET TAGS ('dbx_business_glossary_term' = 'DLP Document Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_extension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period Extension End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_extension_granted` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period Extension Granted');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'DLP Inspection Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'DLP Inspection Required');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_milestone_code` SET TAGS ('dbx_business_glossary_term' = 'DLP Milestone Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_milestone_description` SET TAGS ('dbx_business_glossary_term' = 'DLP Milestone Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_owner` SET TAGS ('dbx_business_glossary_term' = 'DLP Owner');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_owner` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_recorded_by` SET TAGS ('dbx_business_glossary_term' = 'DLP Recorded By');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_recorded_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_release_date` SET TAGS ('dbx_business_glossary_term' = 'DLP Retention Release Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_retention_amount` SET TAGS ('dbx_business_glossary_term' = 'DLP Retention Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_retention_currency` SET TAGS ('dbx_business_glossary_term' = 'DLP Retention Currency');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_start_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_status` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_status` SET TAGS ('dbx_value_regex' = 'active|expired|closed|extended|terminated|pending');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_type` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `dlp_type` SET TAGS ('dbx_value_regex' = 'standard|extended|custom');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `final_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Final Certificate Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `is_liquidated_damages_applicable` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Applicable');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `liquidated_damages_currency` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Currency');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'DLP Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `outstanding_defects_count` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Defects Count');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `outstanding_defects_description` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Defects Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `performance_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Certificate Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change Order ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|executed|closed');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'supplemental|variation|novation|deed_of_variation|addendum');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_category` SET TAGS ('dbx_business_glossary_term' = 'Amendment Category');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `amendment_category` SET TAGS ('dbx_value_regex' = 'financial|schedule|scope|quality|safety');
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Change Order Number');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_identifier' = 'true');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bond Guarantee ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount (BOND_AMOUNT)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_status` SET TAGS ('dbx_business_glossary_term' = 'Bond Status (BOND_STATUS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_status` SET TAGS ('dbx_value_regex' = 'active|expired|called|released|pending|cancelled');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bond Type (BOND_TYPE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'performance|advance|retention|bid|parent_company');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `call_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Call Condition Description (CALL_CONDITION_DESCRIPTION)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `call_condition_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date (CALL_DATE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMPLIANCE_REQUIREMENTS)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_description` SET TAGS ('dbx_business_glossary_term' = 'Bond Description (DESCRIPTION)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From (EFFECTIVE_FROM)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until (EFFECTIVE_UNTIL)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXPIRY_DATE)');
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ALTER COLUMN `expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurance_register_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Register ID');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurance_register_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurance_register_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|cancelled|lapsed');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ALTER COLUMN `insurer_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `firm_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Back‑to‑Back Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_main_contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Main Contract ID');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope Summary');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_number` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_status` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|completed|closed');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_type` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `subcontract_type` SET TAGS ('dbx_value_regex' = 'domestic|nominated|specialist|trade');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `updated_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Value Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `value_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` SET TAGS ('dbx_subdomain' = 'payment_billing');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `subcontract_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Payment ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `firm_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Application ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `is_late_payment` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Indicator');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `is_ld_deduction_applied` SET TAGS ('dbx_business_glossary_term' = 'LD Deduction Applied Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `is_ld_deduction_applied` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `is_retention_applied` SET TAGS ('dbx_business_glossary_term' = 'Retention Applied Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `ld_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Deduction');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `ld_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'electronic|manual|portal|mobile');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|cash|credit_card|wire|online');
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_pii_financial' = 'true');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` SET TAGS ('dbx_subdomain' = 'claims_variations');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Dispute ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `dispute_respondent_contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `arbitration_reference` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ALTER COLUMN `change_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Order Reference');
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
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` SET TAGS ('dbx_subdomain' = 'payment_billing');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `advance_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `advance_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `advance_payment_status` SET TAGS ('dbx_value_regex' = 'pending|issued|partially_recovered|fully_recovered|cancelled|reversed');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `amount_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Advance Payment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Advance Payment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `cumulative_recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Recovered Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `guarantee_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Expiry Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `guarantee_expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `guarantee_reference` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Guarantee Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_value_regex' = 'bank|insurance|performance|none');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `interest_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrued Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `is_guarantee_required` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Required Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `is_interest_applicable` SET TAGS ('dbx_business_glossary_term' = 'Interest Applicable Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `is_recovered` SET TAGS ('dbx_business_glossary_term' = 'Fully Recovered Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Issue Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `last_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Recovery Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `last_recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recovery Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Advance Payment Balance');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Percentage of Contract Value');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'invoice_deduction|direct_payment|retention|other');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `repayment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Repayment End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `repayment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Repayment Frequency');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `repayment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|lump_sum');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `repayment_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Repayment Schedule Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `repayment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Repayment Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = 'VAT|GST|NONE');
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` SET TAGS ('dbx_subdomain' = 'claims_variations');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `closeout_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Closeout ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `bond_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Bond Release Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `change_order_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Order Summary');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `checklist_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Checklist Completed Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Closeout Checklist Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `checklist_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `closeout_number` SET TAGS ('dbx_business_glossary_term' = 'Closeout Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `closeout_status` SET TAGS ('dbx_business_glossary_term' = 'Closeout Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `closeout_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|closed');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `eot_claims_settled_flag` SET TAGS ('dbx_business_glossary_term' = 'EOT Claims Settled Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `final_account_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Account Gross Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `final_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Final Contract Value');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `final_payment_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Certificate Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `is_finalized` SET TAGS ('dbx_business_glossary_term' = 'Is Finalized Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `ld_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Waiver Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `lessons_learned_reference` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `o_m_manual_handover_date` SET TAGS ('dbx_business_glossary_term' = 'O&M Manual Handover Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `outstanding_punch_items_count` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Punch Items Count');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `performance_certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Certificate Issued Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `practical_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Practical Completion Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `punch_list_status` SET TAGS ('dbx_business_glossary_term' = 'Punch List Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `punch_list_status` SET TAGS ('dbx_value_regex' = 'open|closed|partial');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `retention_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `signed_by_contractor` SET TAGS ('dbx_business_glossary_term' = 'Signed By Contractor');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `signed_by_contractor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `signed_by_contractor` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `signed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contractor Signature Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Variance Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `contractual_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Contractual Notice ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `receiving_party_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `response_to_contractual_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Response To Contractual Notice Id');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `response_to_contractual_notice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'acknowledged|pending|rejected');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Clause Reference');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `contractual_deadline` SET TAGS ('dbx_business_glossary_term' = 'Contractual Deadline');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|registered_mail|hand_delivered|electronic_portal');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `contractual_notice_description` SET TAGS ('dbx_business_glossary_term' = 'Notice Description');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Notice Indicator');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_business_glossary_term' = 'Notice Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `notice_status` SET TAGS ('dbx_business_glossary_term' = 'Notice Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `notice_status` SET TAGS ('dbx_value_regex' = 'issued|acknowledged|responded|closed|rejected');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_business_glossary_term' = 'Notice Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_value_regex' = 'time_bar|delay|variation|payment|dissatisfaction|termination');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `supporting_document_refs` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document References');
ALTER TABLE `vibe_construction_v1`.`contract`.`contractual_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` SET TAGS ('dbx_subdomain' = 'claims_variations');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` SET TAGS ('dbx_association_edges' = 'contract.contract_change_order,schedule.activity');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ALTER COLUMN `change_order_activity_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Activity Impact - Change Order Activity Impact Id');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Activity Impact - Activity Id');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Activity Impact - Contract Change Order Id');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ALTER COLUMN `impact_type` SET TAGS ('dbx_business_glossary_term' = 'Impact Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ALTER COLUMN `revised_cost` SET TAGS ('dbx_business_glossary_term' = 'Revised Cost');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ALTER COLUMN `revised_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Finish Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ALTER COLUMN `revised_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Start Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` SET TAGS ('dbx_subdomain' = 'agreement_administration');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `insurance_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `firm_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `additional_insured_flag` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `aggregate_limit` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Limit');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `certificate_holder_address` SET TAGS ('dbx_business_glossary_term' = 'Certificate Holder Address');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `certificate_holder_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `certificate_holder_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `certificate_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Certificate Holder Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `certificate_holder_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `certificate_holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'valid|expiring_soon|expired|non_compliant|pending_verification|rejected');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Name');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `insurer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `insurer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `insurer_rating` SET TAGS ('dbx_business_glossary_term' = 'Insurer Rating');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `per_occurrence_limit` SET TAGS ('dbx_business_glossary_term' = 'Per Occurrence Limit');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `primary_non_contributory_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary and Non-Contributory Flag');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `renewal_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reminder Sent Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ALTER COLUMN `waiver_of_subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver of Subrogation Flag');
