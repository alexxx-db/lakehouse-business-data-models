-- Schema for Domain: claim | Business: Health_Insurance | Version: v3_mvm
-- Generated on: 2026-07-10 22:45:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`claim` COMMENT 'Core transactional domain for all medical, dental, vision, and behavioral health claims — professional (837P), institutional (837I), and dental (837D). Owns claim header and line detail, diagnosis codes (ICD), procedure codes (CPT/HCPCS), DRG assignments, adjudication decisions, EOB generation, COB processing, adjustments, denials, and LAE tracking. Interfaces with EDI clearinghouses (Availity, Change Healthcare) and supports IBNR reserving and MLR reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`header` (
    `header_id` BIGINT COMMENT 'Primary key for header',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Needed for account‑level statements that combine premium billing and claim charges, a core reporting requirement for member cost‑sharing and financial reconciliation.',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Claims submitted under a group NPI must link to provider.group_practice for group-level claims analytics, capitation payment reconciliation, and value-based contract performance reporting. billing_pro',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.eligibility_span. Business justification: Claim intake requires immediate eligibility verification against the members eligibility span before adjudication begins. This is a distinct pre-adjudication edit step. The header-level link captures',
    `eligibility_verification_id` BIGINT COMMENT 'Foreign key linking to enrollment.eligibility_verification. Business justification: Claims adjudication must reference the real-time eligibility verification performed at time of service (capturing authorization_number, benefit_remaining, deductible_remaining). This eligibility-at-t',
    `grace_period_id` BIGINT COMMENT 'Foreign key linking to billing.grace_period. Business justification: ACA mandates special claim handling during premium grace periods: claims must be pended in grace period 2-3 and retroactively denied if premium unpaid. Claim adjudication systems must directly referen',
    `inpatient_admission_id` BIGINT COMMENT 'Foreign key linking to utilization.inpatient_admission. Business justification: Required for Admission‑to‑Claim reconciliation report; claims are generated from inpatient admissions, so linking each claim to its admission record is standard practice.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Outpatient claims require PA validation at the header level before adjudication. The headers denormalized prior_authorization_number should resolve to the actual pa_request record, enabling PA comp',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Claim adjudication requires direct reference to the members active plan election at time of service to validate coverage tier, benefit limits, and premium. This eligibility-at-adjudication linkage ',
    `plan_service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: Network adequacy and service‑area compliance reports need to map each claim to the plan’s service area where the service was rendered.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Required for network participation and quality reporting; each claim must be linked to the provider entity for regulatory and performance analytics.',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: Care program cost attribution and ROI reporting: payers must link claims to the active care management program at time of service to measure program effectiveness, calculate PMPM savings, and satisfy ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Inpatient and outpatient claims must be linked to the rendering facility for DRG-based payment, network adequacy reporting, and CMS facility quality reporting. Header has billing_provider_npi (denorma',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Header-level service location is required for network status verification, geographic claims analysis, and directory accuracy audits. place_of_service_code is a denormalized code; a FK to practice_loc',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Required for claim adjudication to reference the exact enrollment transaction that established coverage at service date, used in CMS audit and eligibility verification reports.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.plan_year. Business justification: Regulatory reporting and rate filing require associating each claim with the specific plan year under which coverage was provided.',
    `adjustment_flag` BOOLEAN COMMENT 'Indicates if the claim includes any adjustments.',
    `admission_date` DATE COMMENT 'Date of patient admission for inpatient claims.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the insurer permits for the services.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed to the insurer before adjustments.',
    `billing_provider_npi` STRING COMMENT 'NPI of the provider responsible for billing.. Valid values are `^[0-9]{10}$`',
    `billing_type` STRING COMMENT 'Method of billing for the claim.. Valid values are `fee_for_service|capitation|bundled|global|per_diem`',
    `claim_event_timestamp` TIMESTAMP COMMENT 'Date and time of the primary service rendered for the claim.',
    `claim_line_count` STRING COMMENT 'Number of line detail records associated with this claim.',
    `claim_number` STRING COMMENT 'Unique claim identifier assigned by the insurer.',
    `claim_source` STRING COMMENT 'Origin of the claim submission.. Valid values are `edi|paper|portal|api`',
    `claim_status` STRING COMMENT 'Current processing status of the claim.. Valid values are `submitted|pending|adjudicated|paid|denied|suspended`',
    `claim_type` STRING COMMENT 'Category of claim based on service type.. Valid values are `professional|institutional|dental|vision|behavioral`',
    `claim_version` STRING COMMENT 'Version number of the claim for tracking revisions.',
    `cob_indicator` BOOLEAN COMMENT 'Flag indicating whether coordination of benefits processing is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim header record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `denial_reason_code` STRING COMMENT 'Code representing the reason for claim denial, if applicable.',
    `diagnosis_codes` STRING COMMENT 'Pipe-separated list of diagnosis codes associated with the claim.',
    `discharge_date` DATE COMMENT 'Date of patient discharge for inpatient claims.',
    `drg_code` STRING COMMENT 'DRG assignment for inpatient claims.. Valid values are `^[0-9]{3,4}$`',
    `is_hipaa_compliant` BOOLEAN COMMENT 'Flag indicating whether the claim data complies with HIPAA regulations.',
    `is_mlr_excluded` BOOLEAN COMMENT 'Indicates if the claim is excluded from MLR calculations.',
    `is_suspended` BOOLEAN COMMENT 'Indicates if the claim is currently suspended pending additional information.',
    `length_of_stay` STRING COMMENT 'Number of days between admission and discharge.',
    `lob` STRING COMMENT 'Business line to which the claim belongs.. Valid values are `medical|dental|vision|pharmacy|behavioral`',
    `paid_amount` DECIMAL(18,2) COMMENT 'Net amount paid to the provider after adjustments.',
    `place_of_service_code` STRING COMMENT 'Code indicating where the service was provided.. Valid values are `^[0-9]{2}$`',
    `prior_status` STRING COMMENT 'Previous status before the most recent transition.. Valid values are `submitted|pending|adjudicated|paid|denied|suspended`',
    `procedure_codes` STRING COMMENT 'Pipe-separated list of procedure codes billed on the claim.',
    `referral_provider_npi` STRING COMMENT 'NPI of the referring provider, if applicable.. Valid values are `^[0-9]{10}$`',
    `sla_due_date` DATE COMMENT 'Date by which the claim must be processed to meet service level agreement.',
    `sla_met` BOOLEAN COMMENT 'Flag indicating whether the claim met the SLA deadline.',
    `status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition.',
    `suspension_reason` STRING COMMENT 'Reason why the claim was suspended.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim header record.',
    CONSTRAINT pk_header PRIMARY KEY(`header_id`)
) COMMENT 'Core master record and lifecycle hub for every submitted health insurance claim — professional (CMS-1500/837P), institutional (UB-04/837I), dental (ADA/837D), and behavioral health. Captures claim-level identifiers (ICN), claim type, bill type, place of service, financial totals (billed/allowed/paid), adjudication status with full status transition history (prior status, new status, timestamp, reason, changed-by), service dates, COB indicator, LOB, plan and member identifiers, provider NPIs (rendering, billing, facility, attending, referring), DRG assignment, admission details, claim source (EDI/paper/portal), adjustment linkage, pend/suspend reason tracking, SLA monitoring dates, and HIPAA compliance flags. Serves as the central hub linking all claim-related detail records.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`line` (
    `line_id` BIGINT COMMENT 'Primary key for line',
    `auth_service_line_id` BIGINT COMMENT 'Foreign key linking to utilization.auth_service_line. Business justification: Audit of Prior Authorization compliance; claim line references the authorized service line to verify authorized quantity, price, and status.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Adjudication uses benefit definitions to determine coverage and cost sharing for each claim line; linking claim line to plan.benefit is required for accurate payment calculation.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Pharmacy claim lines require benefit package context for retail vs mail-order copay differentiation, specialty drug management program rules, and generic substitution requirements during adjudication.',
    `header_id` BIGINT COMMENT 'Identifier of the parent claim to which this line belongs.',
    `cost_share_rule_id` BIGINT COMMENT 'Foreign key linking to plan.cost_share_rule. Business justification: Service lines apply specific cost-share rules based on service category, network type, and member tier. Line-level cost-sharing calculation requires direct rule reference.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Medical claim lines referencing drugs (infusions, injectables, DME) require drug identity for MLR drug-spend categorization, duplicate therapy detection across medical/pharmacy claims, and formulary c',
    `fee_schedule_rate_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule_rate. Business justification: Claim line allowed_amount is derived from a specific fee schedule rate row. Linking claim.line to contract.fee_schedule_rate enables contract compliance auditing, repricing dispute resolution, and MLR',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: Claim line adjudication applies par agreement contracted rates to calculate allowed amounts at the service-line level. Line-level rate validation against par agreement is a core claims adjudication en',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Care plan adherence tracking: linking individual claim service lines to the directing care plan enables payers to measure whether members received care-plan-specified services, supporting case manager',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Line‑level provider attribution enables detailed utilization, cost, and service‑type analysis required by utilization review and case‑mix reporting.',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Reimbursement policies (NCCI edits, modifier reductions, global surgery, max units) govern line-level adjudication decisions. Linking claim.line to the applied reimbursement_policy enables denial root',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.network_tier. Business justification: Needed for patient billing statements; tier determines deductible, copay, and coinsurance for each claim line in network‑based cost‑share calculations.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any adjustment applied to the line after initial adjudication.',
    `adjustment_reason_code` STRING COMMENT 'Code describing the reason for the line adjustment.',
    `admission_date` DATE COMMENT 'Date the patient was admitted (applicable to institutional claims).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the payer agrees to pay for the line.',
    `anesthesia_minutes` STRING COMMENT 'Total minutes of anesthesia administered for the line (if applicable).',
    `billed_amount` DECIMAL(18,2) COMMENT 'Charged amount submitted to the payer for the line.',
    `cob_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by secondary/tertiary payers under COB processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created in the system.',
    `denial_reason_code` STRING COMMENT 'Standard code indicating why the line was denied.',
    `line_description` STRING COMMENT 'Free‑text description of the service rendered.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged (applicable to institutional claims).',
    `emergency_indicator` BOOLEAN COMMENT 'True if the service was rendered as an emergency.',
    `epsdt_indicator` BOOLEAN COMMENT 'True if the service qualifies for EPSDT coverage (for Medicaid).',
    `family_planning_indicator` BOOLEAN COMMENT 'True if the service is related to family planning.',
    `line_status` STRING COMMENT 'Current processing status of the claim line.. Valid values are `posted|pending|denied|reversed|adjusted`',
    `line_type` STRING COMMENT 'Category of service rendered on the line.. Valid values are `professional|institutional|dental`',
    `modifier_1` STRING COMMENT 'First two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_2` STRING COMMENT 'Second two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_3` STRING COMMENT 'Third two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_4` STRING COMMENT 'Fourth two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `number` STRING COMMENT 'Sequential number of the line within the claim.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Amount actually paid by the payer for the line.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Sum of copay, coinsurance, and deductible amounts owed by the member.',
    `place_of_service_code` STRING COMMENT 'Two‑digit code indicating where the service was provided.. Valid values are `^[0-9]{2}$`',
    `prior_authorization_number` STRING COMMENT 'Reference number of the prior authorization associated with the line.',
    `procedure_code` STRING COMMENT 'Standard procedure code representing the service rendered.',
    `remark_code` STRING COMMENT 'Additional informational code attached to the line.',
    `revenue_code` STRING COMMENT 'Four‑digit code used for institutional billing to indicate type of service.. Valid values are `^[0-9]{4}$`',
    `service_date` DATE COMMENT 'Date on which the service was provided.',
    `units_of_service` DECIMAL(18,2) COMMENT 'Quantity of the service rendered (e.g., number of visits, dosage units).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Line-level detail for each service rendered within a claim. Captures line number, CPT/HCPCS procedure code, procedure modifier codes (up to 4), revenue code (institutional), service date, units of service, billed amount per line, allowed amount, paid amount, copay amount, coinsurance amount, deductible amount, COB paid amount, line status, denial reason code, remark codes, place of service code, rendering provider NPI at line level, NDC code (for drug lines), quantity qualifier, anesthesia minutes, emergency indicator, EPSDT indicator, family planning indicator, and prior authorization number.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` (
    `diagnosis_id` BIGINT COMMENT 'Primary key for diagnosis',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Diagnosis codes trigger benefit-specific coverage rules (preventive service flag, prior authorization requirements, exclusions, EHB classification). Medical necessity determination and coverage adjudi',
    `header_id` BIGINT COMMENT 'Identifier of the claim to which this diagnosis belongs.',
    `identity_id` BIGINT COMMENT 'add column member_identity_id (BIGINT) with FK to member.identity.identity_id - diagnoses are associated with specific members',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: Clinical quality and risk‑adjustment reports need each diagnosis linked to its HCC mapping for proper risk score calculations.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Diagnosis codes are year-specific for risk adjustment (HCC model version changes annually, ICD version updates). CMS risk adjustment and RADV audit process.',
    `chronic_condition_flag` BOOLEAN COMMENT 'True if the diagnosis represents a chronic condition relevant for care management.',
    `diagnosis_code` STRING COMMENT 'Official diagnosis code assigned to the claim line.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the diagnosis line was initially loaded into the data lake.',
    `diagnosis_description` STRING COMMENT 'Full textual description of the diagnosis code.',
    `diagnosis_date` DATE COMMENT 'Calendar date the diagnosis was documented on the claim.',
    `diagnosis_status` STRING COMMENT 'Operational status indicating if the diagnosis line is active, pending review, or logically deleted.. Valid values are `active|inactive|deleted|pending`',
    `diagnosis_type` STRING COMMENT 'Specifies the role of the diagnosis (e.g., principal, admitting, external cause, other).. Valid values are `principal|admitting|external_cause|other`',
    `drg_code` STRING COMMENT 'DRG (Diagnosis Related Group) code assigned for inpatient claims.',
    `drg_description` STRING COMMENT 'Textual description of the DRG code.',
    `hcc_category` STRING COMMENT 'HCC category code used for risk‑adjustment and RAF calculations.',
    `icd_version` STRING COMMENT 'Indicates whether the diagnosis code follows ICD‑9‑CM or ICD‑10‑CM standards.. Valid values are `ICD-9|ICD-10`',
    `line_quantity` STRING COMMENT 'Number of times the same diagnosis appears on the claim; typically 1.',
    `poa_indicator` STRING COMMENT 'Indicates if the condition was present at the time of admission (Y=Yes, N=No, U=Unknown).. Valid values are `Y|N|U`',
    `qualifier` STRING COMMENT 'Free‑text qualifier providing extra context (e.g., laterality, severity).',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Numeric factor used in risk‑adjustment calculations for the diagnosis.',
    `sequence` STRING COMMENT 'Ordinal position of the diagnosis on the claim (1‑n).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the diagnosis line.',
    CONSTRAINT pk_diagnosis PRIMARY KEY(`diagnosis_id`)
) COMMENT 'Diagnosis code assignments at the claim level supporting ICD-10-CM coding. Captures claim ICN, diagnosis sequence number, ICD version (ICD-10/ICD-9), diagnosis code, diagnosis description, diagnosis type (principal, admitting, external cause, other), POA (Present on Admission) indicator, HCC category mapping, chronic condition flag, and diagnosis qualifier. Supports DRG grouping, risk adjustment (HCC/RAF), HEDIS measure attribution, and clinical analytics.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`procedure` (
    `procedure_id` BIGINT COMMENT 'Primary key for procedure',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Procedure codes map to benefit coverage rules for authorization requirements, visit/service limits, and cost-sharing tiers. Utilization management and payment determination process.',
    `header_id` BIGINT COMMENT 'Identifier of the parent claim to which this procedure belongs.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Surgical and outpatient procedures are performed at specific credentialed facilities. CMS quality measures, value-based care analytics, and facility credentialing verification require a direct FK from',
    `identity_id` BIGINT COMMENT 'add column member_identity_id (BIGINT) with FK to member.identity.identity_id - procedures are performed on specific members',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.service_area. Business justification: Supports network adequacy compliance reporting by linking procedure location to the defined service area of the provider network.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Procedure-level PA validation is required for high-cost services (surgery, imaging, specialty drugs). The procedure records denormalized prior_authorization_number and prior_authorization_status ',
    `practice_location_id` BIGINT COMMENT 'Identifier of the facility where the procedure was performed (e.g., hospital NPI or internal location code).',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Links surgeon NPI to provider entity for surgeon performance, outcome, and credentialing dashboards mandated by quality‑measure reporting.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Procedure coding and coverage rules are year-specific (CPT/HCPCS annual updates, plan year benefit design changes). Claims processing and regulatory compliance process.',
    `anesthesia_time_minutes` STRING COMMENT 'Total minutes of anesthesia administered for the procedure.',
    `billing_category` STRING COMMENT 'Category used for billing and reimbursement rules.. Valid values are `inpatient|outpatient|professional|institutional`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Billed amount for the procedure before adjustments.',
    `claim_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the adjustment applied to the procedure charge.',
    `claim_adjustment_reason` STRING COMMENT 'Reason code for any post‑adjudication adjustment applied to this procedure.',
    `claim_line_number` STRING COMMENT 'Line number of this procedure within the claim file.',
    `claim_status` STRING COMMENT 'Current processing status of the claim line containing this procedure.. Valid values are `open|closed|denied|paid|reversed`',
    `procedure_code` STRING COMMENT 'Standardized code representing the medical procedure performed.',
    `code_system` STRING COMMENT 'The coding system used for the procedure_code field.. Valid values are `ICD-10-PCS|CPT|HCPCS`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `diagnosis_codes` STRING COMMENT 'Pipe‑delimited list of primary diagnosis codes (ICD‑10‑CM) associated with the procedure. [ENUM-REF-CANDIDATE: multiple codes — promote to reference product]',
    `documentation_indicator` STRING COMMENT 'Indicates completeness of clinical documentation for the procedure.. Valid values are `complete|partial|missing`',
    `drg_code` STRING COMMENT 'DRG assignment for the inpatient case derived from the procedure and diagnoses.',
    `drg_weight` DECIMAL(18,2) COMMENT 'Relative weight of the DRG used for reimbursement calculations.',
    `is_emergency` BOOLEAN COMMENT 'True if the procedure was performed under emergency conditions.',
    `is_outpatient` BOOLEAN COMMENT 'True if the procedure was performed in an outpatient setting.',
    `is_primary_procedure` BOOLEAN COMMENT 'True if this is the principal procedure for the claim.',
    `laterality` STRING COMMENT 'Anatomical side on which the procedure was performed.. Valid values are `left|right|bilateral|none`',
    `modifier` STRING COMMENT 'Additional qualifier or modifier associated with the procedure code (e.g., bilateral, emergency).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final reimbursable amount after adjustments, discounts, and contractual allowances.',
    `notes` STRING COMMENT 'Clinician‑entered free‑text comments about the procedure.',
    `procedure_date` DATE COMMENT 'Calendar date on which the procedure was performed.',
    `procedure_status` STRING COMMENT 'Current processing status of the procedure record.. Valid values are `performed|scheduled|cancelled|pending`',
    `quality_measure_flag` BOOLEAN COMMENT 'True if the procedure contributes to a quality measure (e.g., HEDIS).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the procedure record was first inserted into the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the procedure record.',
    `revenue_code` STRING COMMENT 'Hospital revenue code associated with the procedure for institutional claims.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk‑adjusted payment calculations.',
    `sequence` STRING COMMENT 'Ordinal position of the procedure within the claim (1‑based).',
    `surgeon_name` STRING COMMENT 'Full name of the surgeon who performed the procedure.',
    `timestamp` TIMESTAMP COMMENT 'Exact date‑time when the procedure was performed, captured to the second.',
    `units_of_service` STRING COMMENT 'Number of units billed for the procedure (e.g., time‑based units).',
    CONSTRAINT pk_procedure PRIMARY KEY(`procedure_id`)
) COMMENT 'Procedure code assignments at the claim header level (distinct from line-level CPT). Captures principal procedure code (ICD-10-PCS for inpatient), procedure date, procedure sequence, surgeon NPI, procedure qualifier, and secondary procedure codes. Supports DRG assignment, surgical case management, and inpatient utilization analytics. Primarily applicable to 837I institutional claims.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` (
    `adjudication_id` BIGINT COMMENT 'System-generated unique identifier for the adjudication record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Adjudication validates cost-sharing (deductible, OOP max, copays) against members enrolled benefit package tier. Auto-adjudication rules apply package-level limits for metal tier compliance and netwo',
    `header_id` BIGINT COMMENT 'Unique identifier of the claim that this adjudication decision applies to.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Adjudication occurs at both the claim header level and the individual claim line level in health insurance (837P professional claims adjudicate each service line independently). The adjudication table',
    `cost_share_rule_id` BIGINT COMMENT 'Foreign key linking to plan.cost_share_rule. Business justification: Adjudication engine applies specific cost-share rules (copay amount, coinsurance rate, deductible) to calculate allowed and paid amounts. Core claims payment calculation process.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Pharmacy claim adjudication applies drug-specific edits: formulary compliance, step therapy, quantity limits, and DUR alerts. Linking adjudication to drug_master enables drug-level adjudication audit ',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.eligibility_span. Business justification: Adjudication MUST verify the members active eligibility span at date of service — this is the foundational adjudication edit. The eligibility_span defines coverage window, benefit package, network ti',
    `fee_schedule_rate_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule_rate. Business justification: Adjudication is the authoritative financial record; regulators and auditors require a direct link from the adjudication event to the fee schedule rate used to compute allowed_amount. Supports contract',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: Adjudication applies offering-specific cost-sharing rules (deductible, OOP, employee contribution caps). adjudication already has group_id and health_plan_id but not the specific offering. ACA afforda',
    `health_plan_id` BIGINT COMMENT 'Identifier of the benefit plan under which the claim was submitted.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the insured member associated with the claim.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: Adjudicators validate authorized quantity, authorized dates, and approval status from the PA decision record against the claim being processed. Direct FK to pa_decision supports adjudication edit chec',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Adjudication must verify prior authorization existence and status before approving payment. Linking adjudication directly to pa_request enables auto-adjudication PA validation, edit code generation fo',
    `provider_id` BIGINT COMMENT 'National Provider Identifier (NPI) of the treating provider.',
    `stop_loss_policy_id` BIGINT COMMENT 'Foreign key linking to employer.stop_loss_policy. Business justification: Adjudication for self-funded groups is where stop-loss threshold evaluation occurs and is recorded. The adjudication record must reference the applicable stop-loss policy to document whether the indiv',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Adjudication directly applies tier-based cost-sharing rules (deductible, copay, coinsurance differentials). The adjudication engine must reference the tier to calculate member cost-share amounts. This',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: VBC adjudication attribution is a named business process: adjudicated claims must be attributed to the VBC contract for shared savings calculation, benchmark expenditure tracking, and quality gate rep',
    `accumulator_deductible_impact` DECIMAL(18,2) COMMENT 'Impact on the members deductible accumulator from this adjudication.',
    `accumulator_oop_impact` DECIMAL(18,2) COMMENT 'Impact on the members out‑of‑pocket accumulator.',
    `adjudication_status` STRING COMMENT 'Current status of the adjudication decision.. Valid values are `paid|denied|pended|suspended|voided`',
    `admission_date` DATE COMMENT 'Date the patient was admitted (for institutional claims).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the plan permits for the service after contracts and fee schedules.',
    `allowed_amount_method` STRING COMMENT 'Methodology used to calculate the allowed amount.. Valid values are `fee_schedule|mac|rbp|capitation|custom`',
    `auto_adjudication_flag` BOOLEAN COMMENT 'Indicates whether the claim was processed automatically without manual review.',
    `claim_type` STRING COMMENT 'Category of the claim based on service setting.. Valid values are `professional|institutional|dental|vision|behavioral`',
    `cob_adjusted_amount` DECIMAL(18,2) COMMENT 'Amount adjusted after coordination of benefits.',
    `cob_processing_result` STRING COMMENT 'Result of COB processing for the claim.. Valid values are `primary|secondary|tertiary|none`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `[A-Z]{3}`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Portion of the members deductible applied by this adjudication.',
    `diagnosis_code` STRING COMMENT 'Primary diagnosis code associated with the claim.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged (for institutional claims).',
    `duplicate_claim_flag` BOOLEAN COMMENT 'True if the claim is identified as a potential duplicate.',
    `edit_bypass_reason` STRING COMMENT 'Reason provided when an edit was bypassed.',
    `edit_code` STRING COMMENT 'Code of the clinical or administrative edit applied (e.g., NCCI, OCE).',
    `edit_description` STRING COMMENT 'Human‑readable description of the edit.',
    `edit_outcome` STRING COMMENT 'Result of the edit evaluation.. Valid values are `pass|fail|bypass|override`',
    `edit_override_authority` STRING COMMENT 'Identifier of the person or system that overrode the edit.',
    `edit_override_flag` BOOLEAN COMMENT 'Indicates whether the edit result was manually overridden.',
    `edit_timestamp` TIMESTAMP COMMENT 'Date and time when the edit was evaluated.',
    `medical_necessity_flag` BOOLEAN COMMENT 'Indicates whether the service met medical necessity criteria.',
    `network_status` STRING COMMENT 'Network relationship of the provider for this claim.. Valid values are `in_network|out_of_network|preferred|non_preferred`',
    `number` STRING COMMENT 'External reference number assigned to the adjudication for audit and communication purposes.',
    `oop_amount` DECIMAL(18,2) COMMENT 'Member out‑of‑pocket responsibility after this adjudication.',
    `prior_authorization_required` BOOLEAN COMMENT 'True if the service required prior authorization.',
    `prior_authorization_status` STRING COMMENT 'Outcome of the prior authorization request.. Valid values are `approved|denied|pending|not_required`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the adjudication record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adjudication record.',
    `service_date` DATE COMMENT 'Date on which the service was rendered.',
    `timeliness_flag` BOOLEAN COMMENT 'Indicates whether the claim was filed within the required time window.',
    `timestamp` TIMESTAMP COMMENT 'Date and time when the adjudication decision was generated.',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of all adjustments (deductibles, coinsurance, contractual) applied.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Aggregate charge amount submitted on the claim before any adjustments.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount payable to the provider after all adjustments.',
    CONSTRAINT pk_adjudication PRIMARY KEY(`adjudication_id`)
) COMMENT 'Authoritative record of the adjudication decision for each claim and claim line, capturing the full pre-payment processing lifecycle including all clinical and administrative edit results. Includes adjudication status (paid/denied/pended/suspended/voided), auto-adjudication flag, adjudicator ID, benefit plan applied, accumulator impacts (deductible/OOP), COB processing results, allowed amount calculation method (fee schedule/MAC/RBP/capitation), network status, medical necessity determination, and final disposition. Captures granular edit-level results (NCCI/OCE/LCD/NCD/plan-specific/timely filing/duplicate) with edit code, edit description, pass/fail/bypass/override outcomes per line, bypass reason, and override authority. Supports coding compliance, payment accuracy, and CMS edit mandate adherence.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`eob` (
    `eob_id` BIGINT COMMENT 'Unique surrogate key for the EOB record.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: An Explanation of Benefits (EOB) document is generated directly from the adjudication decision — it communicates the adjudication outcome (allowed amounts, deductibles, COB adjustments, denial reasons',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: EOB is generated for a specific claim; linking to claim header provides the parent relationship',
    `formulary_drug_tier_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary_drug_tier. Business justification: CMS Part D and ACA require EOBs to explain member cost-sharing by formulary tier. Linking eob to formulary_drug_tier enables accurate tier-based cost-sharing explanation on member EOBs, supports SBC a',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: EOB documents display plan-specific information (plan name, SBC reference URL, appeal rights version, regulatory classification). Required for member communication and ERISA/ACA disclosure compliance.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the covered member associated with the claim.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: EOB generation requires direct policy context to display coverage limits, deductible amounts, OOP max, and premium details. Regulatory EOB standards (ACA, ERISA) require policy-level benefit informati',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Required for EOB Generation Rule: includes credential status of provider on explanation of benefits for compliance.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary subscriber (often the employee or policyholder).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the plan permits for the service.',
    `appeal_rights_text` STRING COMMENT 'Narrative describing the members right to appeal the decision.',
    `appeal_rights_version` STRING COMMENT 'Version identifier for the appeal rights language used.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed by the provider before any adjustments.',
    `claim_icn` STRING COMMENT 'Unique claim identifier used throughout the adjudication process.',
    `cob_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount adjusted due to coordination of benefits with other payers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the EOB record was first created in the data warehouse.',
    `delivery_date` DATE COMMENT 'Date the EOB was actually delivered to the recipient.',
    `delivery_method` STRING COMMENT 'Method used to deliver the EOB to the member or provider.. Valid values are `mail|portal|edi`',
    `denial_reason_summary` STRING COMMENT 'Brief text explaining why a claim or line was denied.',
    `document_number` STRING COMMENT 'External document identifier assigned to the EOB for tracking and reference.',
    `eob_status` STRING COMMENT 'Current lifecycle status of the EOB record.. Valid values are `generated|delivered|suppressed|error`',
    `eob_type` STRING COMMENT 'Indicates whether the EOB is intended for the member or the provider.. Valid values are `member|provider`',
    `generation_timestamp` TIMESTAMP COMMENT 'Date and time when the EOB was generated by the claims engine.',
    `language_code` STRING COMMENT 'ISO 639‑2 language code indicating the language of the EOB content.',
    `member_responsibility_amount` DECIMAL(18,2) COMMENT 'Portion of the claim the member must pay (deductible, copay, coinsurance, or non‑covered).',
    `member_responsibility_type` STRING COMMENT 'Category of the members financial responsibility for the claim.. Valid values are `deductible|copay|coinsurance|non_covered`',
    `plan_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by the health plan to the provider.',
    `provider_npi` STRING COMMENT 'Unique national identifier for the provider.',
    `remark_codes` STRING COMMENT 'Standardized codes providing additional claim processing information.',
    `sbc_reference` STRING COMMENT 'Link or identifier to the applicable Summary of Benefits and Coverage document.',
    `service_end_date` DATE COMMENT 'Last date of service covered by the claim.',
    `service_start_date` DATE COMMENT 'First date of service covered by the claim.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether the EOB should be suppressed from member delivery (e.g., for zero‑payment claims).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the EOB record.',
    `version_number` STRING COMMENT 'Sequential version number for revisions of the EOB.',
    CONSTRAINT pk_eob PRIMARY KEY(`eob_id`)
) COMMENT 'Explanation of Benefits document record generated for members and providers following claim adjudication. Captures EOB document ID, EOB type (member/provider), generation date, delivery method (mail/portal/EDI 835), member ID, subscriber ID, claim ICN, service dates, provider name, billed amount, allowed amount, plan paid amount, member responsibility (deductible, copay, coinsurance, non-covered), COB adjustment, denial reason summary, remark codes, appeal rights language version, SBC reference, and EOB suppression flag. Supports member transparency and ACA SBC compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Primary key for adjustment',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Overpayment recovery and claim adjustment posting require direct linkage to the billing account where recoveries are tracked. Accounts receivable workflows and recovery_status reporting depend on know',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: Post-adjudication adjustments (recoveries, audit findings, overpayment corrections, reversals) are corrections to a specific adjudication decision. The adjustment table currently links to claim.header',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Audit findings (e.g., RAC, OIG, internal audits) directly trigger claim adjustments for overpayment recovery. A proper FK replaces the denormalized audit_finding_reference text field, enabling complia',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Adjustments reference specific benefit rules when correcting coverage determinations (limit violations, exclusion codes, authorization requirements). Claims correction and audit process.',
    `header_id` BIGINT COMMENT 'Identifier of the original claim to which this adjustment applies.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Corrective action plans mandating systematic claim reprocessing (e.g., CMS 60-day overpayment rule remediation, state audit CAPs) drive batches of claim adjustments. Linking adjustment to corrective_a',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Pharmacy claim adjustments for overpayment recovery, manufacturer rebate reconciliation, and fraud investigations require drug-level identity. Linking adjustment to drug_master enables drug-specific o',
    `fwa_case_id` BIGINT COMMENT 'Foreign key linking to compliance.fwa_case. Business justification: When an FWA investigation identifies fraud or overpayment, claim adjustments are initiated to recover funds. Linking adjustment to fwa_case enables FWA recovery tracking, regulatory reporting on case-',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Adjustments track plan-level overpayment recovery, MLR exclusion flags, and regulatory reporting requirements. Financial reconciliation and CMS MLR reporting process.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Adjustment may apply to a specific claim line; replace claim_line_number with a proper FK to claim.line',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the claim adjustment.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Risk adjustment payment corrections (CMS reconciliation, retroactive risk score changes) require linking the adjustment to the specific risk score version that triggered it. Supports risk adjustment a',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Claim adjustments triggered by PA findings (unauthorized services, retroactive PA denials, authorization reversals) must reference the originating PA request. This link supports overpayment recovery w',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Adjustment records are created after an appeal decision; linking to the appeal case provides audit trail and regulatory reporting of appeal‑driven adjustments.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider linked to the adjusted claim.',
    `radv_audit_id` BIGINT COMMENT 'Foreign key linking to risk.radv_audit. Business justification: RADV audit findings directly generate claim payment adjustments and overpayment demands from CMS. The adjustment table has audit_finding_reference, audit_source, and audit_type columns confirming audi',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Total amount after the adjustment is applied.',
    `adjustment_date` TIMESTAMP COMMENT 'Timestamp when the adjustment was recorded or became effective.',
    `adjustment_status` STRING COMMENT 'Current processing status of the adjustment.. Valid values are `pending|approved|rejected|completed`',
    `adjustment_type` STRING COMMENT 'Category of the adjustment indicating its nature.. Valid values are `void|replacement|correction|retroactive`',
    `audit_source` STRING COMMENT 'Origin of the audit finding (e.g., internal, RAC, OIG, provider self‑disclosure).. Valid values are `internal|rac|oig|provider_self_disclosure`',
    `audit_type` STRING COMMENT 'Type of audit that triggered the adjustment.. Valid values are `post_payment|pre_payment|clinical|coding|billing`',
    `adjustment_code` STRING COMMENT 'Internal code categorizing the adjustment for reporting.',
    `compliance_60_day_rule` BOOLEAN COMMENT 'Indicates whether the adjustment complies with the CMS 60‑day overpayment recoupment rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `demand_lifecycle_stage` STRING COMMENT 'Stage of the demand/collection lifecycle for the adjustment.. Valid values are `demand_created|demand_sent|demand_received|demand_resolved`',
    `adjustment_description` STRING COMMENT 'Narrative description of why and how the adjustment was made.',
    `diagnosis_code` STRING COMMENT 'ICD diagnosis code(s) associated with the claim adjustment, if relevant.',
    `effective_date` DATE COMMENT 'Date when the adjustment takes effect.',
    `expiration_date` DATE COMMENT 'Date when the adjustment ceases to be effective, if applicable.',
    `identifier` STRING COMMENT 'External or business-facing identifier for the adjustment (e.g., RAC audit number).',
    `initiator_role` STRING COMMENT 'Business role of the initiator.. Valid values are `claims_adjuster|auditor|provider|member|system`',
    `is_duplicate` BOOLEAN COMMENT 'Flag identifying the adjustment as a duplicate payment correction.',
    `is_fraud` BOOLEAN COMMENT 'Indicates whether the adjustment is related to suspected fraud.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether the adjustment reverses a prior adjustment.',
    `is_void` BOOLEAN COMMENT 'Indicates whether the adjustment voids the original claim payment.',
    `net_adjustment_amount` DECIMAL(18,2) COMMENT 'Difference between original and adjusted amounts (positive for overpayment recovery, negative for additional payment).',
    `notes` STRING COMMENT 'Additional free‑form notes captured by the adjuster.',
    `original_amount` DECIMAL(18,2) COMMENT 'Total amount originally paid on the claim before any adjustment.',
    `overpayment_indicator` BOOLEAN COMMENT 'Flag indicating whether the adjustment relates to an overpayment.',
    `overpayment_type` STRING COMMENT 'Specific category of overpayment being corrected.. Valid values are `duplicate|incorrect_rate|ineligible_member|billing_error|fraud`',
    `procedure_code` STRING COMMENT 'Procedure code(s) related to the adjusted claim line.',
    `reason_code` STRING COMMENT 'Standardized code describing the business reason for the adjustment.',
    `recovery_method` STRING COMMENT 'Method used to recover the overpayment.. Valid values are `offset|check|installment|write_off`',
    `recovery_status` STRING COMMENT 'Current status of the recovery process.. Valid values are `pending|in_process|completed|failed`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True when the adjustment must be reported to regulatory bodies (e.g., CMS RAC).',
    `resolution_status` STRING COMMENT 'Overall resolution state of the adjustment case.. Valid values are `open|closed|escalated`',
    `sequence` STRING COMMENT 'Sequential order of adjustments applied to the same claim.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adjustment record.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Single source of truth for all post-adjudication corrections, recoveries, and audit findings — including claim adjustments, voids, reprocessing events, overpayment identification and recovery, and post-payment audit results for payment integrity and FWA detection. Captures adjustment type (void/replacement/corrected/retroactive), overpayment type (duplicate payment/incorrect rate/ineligible member/billing error/fraud), audit type (post-payment/prepayment/clinical/coding/billing), audit source (internal/RAC/OIG/provider self-disclosure), financial impact (original vs adjusted amounts, net adjustment, overpayment amount, recovery amounts, demand lifecycle), initiator, CMS 60-day overpayment rule compliance, recovery method (offset/check/installment), recovery status, and resolution status. Supports payment integrity programs, CMS RAC audit compliance, and regulatory overpayment reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`denial` (
    `denial_id` BIGINT COMMENT 'System-generated unique identifier for the denial record.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: A denial is a specific outcome of the adjudication process — when adjudication results in a denial decision, a denial record is created capturing the denial reason codes (CARC/RARC), clinical criteria',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Denials cite benefit-level exclusions, coverage limits, and clinical criteria. Denial management, appeals processing, and medical necessity review process.',
    `header_id` BIGINT COMMENT 'Unique identifier of the claim associated with this denial.',
    `formulary_exception_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary_exception. Business justification: When a formulary exception request is denied, a denial record is created. Linking denial to formulary_exception enables CMS Part D coverage determination tracking, appeal rights notification complianc',
    `grace_period_id` BIGINT COMMENT 'Foreign key linking to billing.grace_period. Business justification: Grace period expiration is a specific denial trigger under ACA regulations. Linking claim.denial directly to billing.grace_period enables regulatory reporting on grace-period-triggered denials, suppor',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Denials require plan-specific appeal rights, timelines (grace period days), and regulatory classification for member notification. Appeals management and state/federal compliance process.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Denial may apply to a specific claim line; replace claim_line_number with a proper FK to claim.line',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: Denials based on medical necessity or non-covered services must cite the specific medical policy version that drove the denial. This link supports appeal defense documentation, regulatory audit trails',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose claim was denied.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Denials caused by missing or failed PA must reference the originating PA request for appeal workflows, ACA-mandated denial notice generation, and regulatory reporting. This link enables denial-to-PA t',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Denial processing and appeal resolution require direct policy reference to validate coverage limits, benefit exclusions, and policy-level eligibility at time of service. Denial letters and regulatory ',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: Pharmacy claim denials are frequently caused by PA failures or missing PA. Linking denial to pharmacy.prior_authorization supports CMS/ACA timely denial reporting, appeals processing, and denial root-',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Denials are frequently triggered by specific reimbursement policy rules (NCCI, modifier, POS restrictions). Linking denial to the policy that generated it enables denial root-cause analysis, appeals w',
    `appeal_deadline_date` DATE COMMENT 'Last date by which an appeal must be filed.',
    `appeal_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the denial is eligible for an appeal.',
    `carc_code` STRING COMMENT 'Standardized code describing the reason for the claim adjustment/denial.',
    `clinical_criteria` STRING COMMENT 'Reference to the clinical guideline or utilization management criteria applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the denial record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `denial_date` DATE COMMENT 'Date the denial decision was rendered.',
    `denial_status` STRING COMMENT 'Current lifecycle status of the denial.. Valid values are `pending|reviewed|appealed|resolved|closed|rejected`',
    `denial_type` STRING COMMENT 'High‑level classification of the denial reason.. Valid values are `clinical|administrative|technical|cob|timely_filing`',
    `denied_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustments (e.g., contractual allowances, discounts) applied to the denied amount.',
    `denied_gross_amount` DECIMAL(18,2) COMMENT 'Original amount of the claim that was denied before any adjustments.',
    `denied_net_amount` DECIMAL(18,2) COMMENT 'Final net amount after adjustments that the member is responsible for due to the denial.',
    `letter_generated_flag` BOOLEAN COMMENT 'True if a formal denial letter was generated and sent to the member/provider.',
    `medical_necessity_flag` BOOLEAN COMMENT 'Indicates whether the claim failed medical necessity criteria (true = not medically necessary).',
    `notes` STRING COMMENT 'Free‑form notes captured by reviewers or staff during denial handling.',
    `number` STRING COMMENT 'External business identifier assigned to the denial, used in communications and reporting.',
    `override_flag` BOOLEAN COMMENT 'True if the denial was manually overridden by a reviewer.',
    `override_reason` STRING COMMENT 'Explanation for why the denial was overridden.',
    `rac_code` STRING COMMENT 'Standardized remark code that provides additional context for the denial.',
    `reason_description` STRING COMMENT 'Narrative explanation of why the claim or line was denied.',
    `resolution_date` DATE COMMENT 'Date the denial was resolved or closed.',
    `resolution_status` STRING COMMENT 'Current status of the denial resolution process.. Valid values are `pending|approved|denied|withdrawn|closed`',
    `subtype` STRING COMMENT 'More granular category within the denial type, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the denial record.',
    CONSTRAINT pk_denial PRIMARY KEY(`denial_id`)
) COMMENT 'Authoritative record of claim and claim line denials, capturing denial reason codes, clinical rationale, and resolution tracking. Includes denial ID, claim ICN, line number (if line-level denial), denial date, denial type (clinical, administrative, technical, COB, timely filing), CARC code, RARC code, denial reason description, clinical criteria applied (InterQual/MCG), medical necessity determination, denial letter generated flag, appeal eligibility flag, appeal deadline date, denial override flag, override reason, and resolution status. Supports appeals workflow, regulatory reporting, and denial management analytics.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`cob` (
    `cob_id` BIGINT COMMENT 'Primary key for cob',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: Coordination of Benefits (COB) processing is an integral part of the adjudication workflow — COB determines the secondary payer liability after the primary payer adjudicates. The cob table currently l',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: COB processing is performed per claim; linking to claim header enables traceability',
    `pharmacy_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_claim. Business justification: COB coordination for pharmacy claims (Part D/Medicaid crossover, dual-coverage members) requires direct linkage to the pharmacy claim being coordinated. Enables Part D TrOOP tracking, MSP pharmacy COB',
    `cob_record_id` BIGINT COMMENT 'Foreign key linking to member.cob_record. Business justification: COB adjudication processing must reference the members COB record to determine payer order, coordination rules, and MSP compliance. This is a core operational link: claim COB processing directly cons',
    `group_id` BIGINT COMMENT 'Internal identifier of the user who performed the COB processing.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: COB processing determines primary vs secondary payer responsibility based on plan coordination rules and MSP indicator. Coordination of benefits adjudication and Medicare crossover processing.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the adjustment applied to the net liability.',
    `adjustment_reason` STRING COMMENT 'Reason for any monetary adjustment applied during COB processing.',
    `batch_number` STRING COMMENT 'Identifier of the ETL batch that loaded this COB record.',
    `claim_icn` STRING COMMENT 'Unique identifier assigned to the underlying claim that this COB record relates to.',
    `claim_line_count` STRING COMMENT 'Number of line items on the underlying claim.',
    `cob_status` STRING COMMENT 'Current processing status of the COB record.. Valid values are `pending|processed|error|reversed`',
    `comments` STRING COMMENT 'Free‑form notes entered by the processor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COB record was first created in the system.',
    `crossover_claim_flag` BOOLEAN COMMENT 'Indicates whether the claim crosses over between primary and secondary payer responsibilities.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for monetary values (e.g., USD).. Valid values are `USD`',
    `effective_date` DATE COMMENT 'Date when the COB processing became effective.',
    `expiration_date` DATE COMMENT 'Date when the COB record expires or is no longer valid (nullable).',
    `is_duplicate` BOOLEAN COMMENT 'Flag indicating whether this COB record was generated for a duplicate claim.',
    `is_manual_override` BOOLEAN COMMENT 'True if a user manually overrode automated COB decisions.',
    `medicaid_crossover_indicator` BOOLEAN COMMENT 'Flag showing if Medicaid is involved in a crossover scenario.',
    `method` STRING COMMENT 'Method used for coordination of benefits: standard, non‑duplication, or maintenance of benefits.. Valid values are `standard|non_duplication|maintenance_of_benefits`',
    `msp_indicator` BOOLEAN COMMENT 'Flag indicating whether Medicare is acting as the secondary payer for this claim.',
    `msp_type` STRING COMMENT 'Specifies the type of Medicare secondary payer relationship (full or partial).. Valid values are `full|partial`',
    `net_liability_amount` DECIMAL(18,2) COMMENT 'Remaining liability amount after primary and secondary payments and adjustments.',
    `primary_payer_allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the primary payer allowed for the claim before COB.',
    `primary_payer_denial_reason` STRING COMMENT 'Reason code or description why the primary payer denied all or part of the claim.',
    `primary_payer_paid_amount` DECIMAL(18,2) COMMENT 'Amount actually paid by the primary payer after adjudication.',
    `process_order` STRING COMMENT 'Sequential order in which multiple payer COB steps are applied for the claim.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date‑time when the COB processing was completed.',
    `processing_user_name` STRING COMMENT 'Display name of the user who performed the COB processing.',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'Sum of allowed amounts for all claim lines as determined by the primary payer.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Aggregate charge amount from all claim lines before any adjustments.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the primary payer before secondary adjudication.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COB record.',
    CONSTRAINT pk_cob PRIMARY KEY(`cob_id`)
) COMMENT 'Coordination of Benefits processing record for claims involving multiple payers. Captures COB record ID, claim ICN, primary payer ID, primary payer name, primary payer paid amount, primary payer allowed amount, primary payer denial reason, secondary payer ID, COB processing order, COB method (standard/non-duplication/maintenance of benefits), other insurance type (employer group/Medicare/Medicaid/auto/workers comp), Medicare as secondary payer (MSP) indicator, MSP type, crossover claim flag, Medicaid crossover indicator, and net liability after COB. Supports accurate secondary adjudication and CMS MSP compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`payment` (
    `payment_id` BIGINT COMMENT 'Primary key for payment',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Claim payment disbursement reconciliation and GL posting require direct traceability from claim payments to billing accounts. Payment reconciliation reports and financial close processes depend on thi',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: Claim payments are authorized and calculated by the adjudication process — the adjudication record determines the net_amount, allowed_amount, and payment authorization. The payment table currently lin',
    `dispensing_pharmacy_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispensing_pharmacy. Business justification: Direct pharmacy payments (EFT/check to dispensing pharmacies) require linking to the dispensing pharmacy entity for network audit, 1099 tax reporting, payment reconciliation against contracted dispens',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Payment batches reconcile against plan-level financial accounts, MLR reporting, and risk adjustment factors. Financial settlement and CMS regulatory reporting process.',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: Provider payments are governed by par agreement terms (contracted rates, EFT routing, payment conditions). Payment reconciliation against par agreement contracted rates is a named operational process ',
    `pbm_contract_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pbm_contract. Business justification: PBM payments are governed by PBM contracts specifying dispensing fees, rebate pass-through, and performance guarantees. Linking payment to pbm_contract enables PBM financial reconciliation, rebate set',
    `header_id` BIGINT COMMENT 'FK to claim.header',
    `party_id` BIGINT COMMENT 'Unique identifier of the entity receiving the payment (provider NPI or member ID).',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Payments may be adjusted based on appeal outcomes; linking to the appeal outcome enables accurate reconciliation and compliance reporting of appeal‑related payment changes.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: Capitation and risk-adjusted payments reconcile against rate tables (age-rated premium, underwriting class, rating area). Provider payment reconciliation and financial settlement process.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of all adjustments (CARC/RARC) applied to the gross amount.',
    `batch_number` BIGINT COMMENT 'Identifier of the batch in which this payment was processed.',
    `batch_sequence` STRING COMMENT 'Sequence order of the payment within its batch.',
    `carc_codes` STRING COMMENT 'Pipe‑separated list of CARC codes applied to the claim payment.',
    `channel` STRING COMMENT 'Delivery channel for the payment transaction.. Valid values are `clearinghouse|direct|bank`',
    `check_number` STRING COMMENT 'Check number when payment method is a paper check.',
    `clearinghouse_code` BIGINT COMMENT 'Identifier of the EDI clearinghouse that processed the 835 transaction.',
    `clearinghouse_name` STRING COMMENT 'Human‑readable name of the clearinghouse (e.g., Availity, Change Healthcare).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the payment.. Valid values are `USD|CAD|EUR`',
    `cycle` STRING COMMENT 'Frequency with which the payment is issued.. Valid values are `monthly|quarterly|annual|ad_hoc`',
    `payment_description` STRING COMMENT 'Free‑text description of the payment purpose.',
    `gl_posting_date` DATE COMMENT 'Date the payment entry was posted to the general ledger.',
    `gl_reference_number` STRING COMMENT 'Reference identifier linking the payment to the GL transaction.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before any adjustments or taxes.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the payment has been fully reconciled.',
    `is_returned` BOOLEAN COMMENT 'True if the payment was returned by the bank or clearinghouse.',
    `is_voided` BOOLEAN COMMENT 'True if the payment was voided after issuance.',
    `method` STRING COMMENT 'Instrument used to disburse the payment.. Valid values are `eft|check|virtual_card|capitation_offset`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount paid to the payee after adjustments.',
    `note` STRING COMMENT 'Additional free‑form notes related to the payment.',
    `number` STRING COMMENT 'External payment reference number used in remittance advice and provider communications.',
    `payee_type` STRING COMMENT 'Classification of the payee: provider, member, or other.. Valid values are `provider|member|other`',
    `payment_date` TIMESTAMP COMMENT 'Timestamp when the payment was issued to the payee.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment.. Valid values are `issued|cleared|voided|returned|stopped`',
    `payment_type` STRING COMMENT 'Category of the payment (e.g., claim settlement, capitation offset).. Valid values are `claim_payment|capitation|rebate|adjustment`',
    `racr_codes` STRING COMMENT 'Pipe‑separated list of RARC codes providing additional adjustment details.',
    `reason_code` STRING COMMENT 'Standard code indicating why the payment was made (e.g., claim settlement, rebate).',
    `reconciliation_status` STRING COMMENT 'Current status of the payments financial reconciliation.. Valid values are `reconciled|unreconciled|pending`',
    `returned_reason` STRING COMMENT 'Explanation for why the payment was returned.',
    `source` STRING COMMENT 'Indicates whether the payment originated from internal systems or an external entity.. Valid values are `internal|external`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax withheld or applied to the payment, if applicable.',
    `trace_number` STRING COMMENT 'Bank‑provided trace number for tracking the payment.',
    `transaction_control_number` STRING COMMENT 'Unique control number for the 835 remittance advice transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    `void_reason` STRING COMMENT 'Explanation for why the payment was voided.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Single source of truth for all claim payment disbursements and electronic remittance advice (835 ERA) transmitted to providers and members. Captures payee information (NPI/TIN/member ID), payment amount, payment date, payment method (EFT/check/virtual card/capitation offset), check/EFT trace number, payment status lifecycle (issued/cleared/voided/returned/stopped), 835 transaction control number, clearinghouse ID (Availity, Change Healthcare), CARC/RARC adjustment codes at claim level, claim-level payment detail, reconciliation status, and GL posting reference. Consolidates provider remittance advice and claim payment into a single authoritative record for payment reconciliation, cash posting, and provider inquiry resolution.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`claim` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`claim` SET TAGS ('dbx_domain' = 'claim');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Header Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `eligibility_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `inpatient_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Admission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `plan_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Claiming Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Practice Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Billing Provider NPI');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_type` SET TAGS ('dbx_value_regex' = 'fee_for_service|capitation|bundled|global|per_diem');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Service Date (Start)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_line_count` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Count');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number (CLM)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_source` SET TAGS ('dbx_business_glossary_term' = 'Claim Source');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_source` SET TAGS ('dbx_value_regex' = 'edi|paper|portal|api');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|adjudicated|paid|denied|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type (PROF/INST/DENT/VIS/BEH)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'professional|institutional|dental|vision|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_version` SET TAGS ('dbx_business_glossary_term' = 'Claim Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Codes (ICD-10)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Related Group (DRG) Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `drg_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `is_hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Compliance Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `is_mlr_excluded` SET TAGS ('dbx_business_glossary_term' = 'Medical Loss Ratio Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `is_suspended` SET TAGS ('dbx_business_glossary_term' = 'Suspended Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Code (POS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Claim Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `prior_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|adjudicated|paid|denied|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `procedure_codes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Codes (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Referral Provider NPI');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `auth_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Auth Service Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (CLM_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fee_schedule_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Line Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Line Adjustment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `anesthesia_minutes` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `cob_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Line Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `emergency_indicator` SET TAGS ('dbx_business_glossary_term' = 'Emergency Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `epsdt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Early and Periodic Screening, Diagnostic, and Treatment (EPSDT) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `family_planning_indicator` SET TAGS ('dbx_business_glossary_term' = 'Family Planning Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'posted|pending|denied|reversed|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type (Professional/Institutional/Dental)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'professional|institutional|dental');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remark Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Line Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Hcc Mapping Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Line Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|pending');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_value_regex' = 'principal|admitting|external_cause|other');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `drg_description` SET TAGS ('dbx_business_glossary_term' = 'DRG Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `hcc_category` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `hcc_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `hcc_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `icd_version` SET TAGS ('dbx_business_glossary_term' = 'ICD Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `icd_version` SET TAGS ('dbx_value_regex' = 'ICD-9|ICD-10');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `line_quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_value_regex' = 'Y|N|U');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `qualifier` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Qualifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Surgeon Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `anesthesia_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Time (Minutes)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `billing_category` SET TAGS ('dbx_business_glossary_term' = 'Billing Category');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `billing_category` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|professional|institutional');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Procedure Charge Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_line_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'open|closed|denied|paid|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (ICD‑10‑PCS / CPT / HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `code_system` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `code_system` SET TAGS ('dbx_value_regex' = 'ICD-10-PCS|CPT|HCPCS');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Codes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `documentation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Documentation Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `documentation_indicator` SET TAGS ('dbx_value_regex' = 'complete|partial|missing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis‑Related Group (DRG) Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procedure Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `is_outpatient` SET TAGS ('dbx_business_glossary_term' = 'Outpatient Procedure Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `is_primary_procedure` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Procedure Laterality');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|none');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `modifier` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Procedure Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Notes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Procedure Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Procedure Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_value_regex' = 'performed|scheduled|cancelled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Procedure Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `surgeon_name` SET TAGS ('dbx_business_glossary_term' = 'Surgeon Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Procedure Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `header_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `header_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fee_schedule_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `stop_loss_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_deductible_impact` SET TAGS ('dbx_business_glossary_term' = 'Deductible Accumulator Impact');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_deductible_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_deductible_impact` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_oop_impact` SET TAGS ('dbx_business_glossary_term' = 'OOP Accumulator Impact');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_oop_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_oop_impact` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `adjudication_status` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `adjudication_status` SET TAGS ('dbx_value_regex' = 'paid|denied|pended|suspended|voided');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount_method` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount Calculation Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount_method` SET TAGS ('dbx_value_regex' = 'fee_schedule|mac|rbp|capitation|custom');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `auto_adjudication_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Adjudication Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'professional|institutional|dental|vision|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'COB Adjusted Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_adjusted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_adjusted_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_processing_result` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Processing Result');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_processing_result` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|none');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount Applied');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `duplicate_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Claim Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_bypass_reason` SET TAGS ('dbx_business_glossary_term' = 'Edit Bypass Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_code` SET TAGS ('dbx_business_glossary_term' = 'Edit Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_description` SET TAGS ('dbx_business_glossary_term' = 'Edit Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Edit Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|bypass|override');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_override_authority` SET TAGS ('dbx_business_glossary_term' = 'Edit Override Authority');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Edit Override Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Edit Evaluation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Necessity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|preferred|non_preferred');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Number (External Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `oop_amount` SET TAGS ('dbx_business_glossary_term' = 'Out‑Of‑Pocket (OOP) Amount Applied');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `oop_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `oop_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|not_required');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `timeliness_flag` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charged Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Payable Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_id` SET TAGS ('dbx_business_glossary_term' = 'Explanation of Benefits (EOB) ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Eob Claim Header Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `formulary_drug_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Drug Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `appeal_rights_text` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Text');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `appeal_rights_version` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `billed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `billed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `claim_icn` SET TAGS ('dbx_business_glossary_term' = 'Claim Internal Control Number (ICN)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `cob_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'COB Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `cob_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `cob_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|portal|edi');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `denial_reason_summary` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Summary');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'EOB Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_status` SET TAGS ('dbx_business_glossary_term' = 'EOB Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_status` SET TAGS ('dbx_value_regex' = 'generated|delivered|suppressed|error');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_type` SET TAGS ('dbx_business_glossary_term' = 'EOB Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_type` SET TAGS ('dbx_value_regex' = 'member|provider');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'EOB Generation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Member Responsibility Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_type` SET TAGS ('dbx_business_glossary_term' = 'Member Responsibility Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_type` SET TAGS ('dbx_value_regex' = 'deductible|copay|coinsurance|non_covered');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `plan_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Plan Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `plan_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `plan_paid_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `remark_codes` SET TAGS ('dbx_business_glossary_term' = 'Remark Codes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `sbc_reference` SET TAGS ('dbx_business_glossary_term' = 'SBC Reference');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'EOB Suppression Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fwa_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fwa Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `radv_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Radv Audit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'void|replacement|correction|retroactive');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_source` SET TAGS ('dbx_business_glossary_term' = 'Audit Source');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_source` SET TAGS ('dbx_value_regex' = 'internal|rac|oig|provider_self_disclosure');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'post_payment|pre_payment|clinical|coding|billing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `compliance_60_day_rule` SET TAGS ('dbx_business_glossary_term' = 'CMS 60‑Day Rule Compliance');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `demand_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Demand Lifecycle Stage');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `demand_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'demand_created|demand_sent|demand_received|demand_resolved');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `initiator_role` SET TAGS ('dbx_business_glossary_term' = 'Initiator Role');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `initiator_role` SET TAGS ('dbx_value_regex' = 'claims_adjuster|auditor|provider|member|system');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Is Duplicate Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `is_fraud` SET TAGS ('dbx_business_glossary_term' = 'Is Fraud Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `is_void` SET TAGS ('dbx_business_glossary_term' = 'Is Void Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `net_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `overpayment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `overpayment_type` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `overpayment_type` SET TAGS ('dbx_value_regex' = 'duplicate|incorrect_rate|ineligible_member|billing_error|fraud');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'offset|check|installment|write_off');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `recovery_status` SET TAGS ('dbx_value_regex' = 'pending|in_process|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|closed|escalated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Identifier (DENIAL_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (CLAIM_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `header_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `header_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `formulary_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Exception Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (MEMBER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `carc_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code (CARC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `clinical_criteria` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Code (InterQual/MCG)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_status` SET TAGS ('dbx_business_glossary_term' = 'Denial Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|appealed|resolved|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('dbx_business_glossary_term' = 'Denial Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('dbx_value_regex' = 'clinical|administrative|technical|cob|timely_filing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denied_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Adjustment Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denied_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Gross Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denied_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Net Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `letter_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Denial Letter Generated Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Necessity Determination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Denial Management Notes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Denial Number (DENIAL_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Denial Override Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Override Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `override_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `override_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `rac_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code (RARC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `reason_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `reason_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Denial Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn|closed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Denial Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Claim Header Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `pharmacy_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Claim Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `cob_record_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Processing User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `group_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `group_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `claim_icn` SET TAGS ('dbx_business_glossary_term' = 'Claim Internal Control Number (ICN)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `claim_line_count` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Count');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('dbx_business_glossary_term' = 'COB Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('dbx_value_regex' = 'pending|processed|error|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `crossover_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Crossover Claim Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Claim Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `medicaid_crossover_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Crossover Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'COB Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'standard|non_duplication|maintenance_of_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `msp_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medicare Secondary Payer (MSP) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `msp_type` SET TAGS ('dbx_business_glossary_term' = 'MSP Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `msp_type` SET TAGS ('dbx_value_regex' = 'full|partial');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `net_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Liability After COB');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `primary_payer_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `primary_payer_denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `primary_payer_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `process_order` SET TAGS ('dbx_business_glossary_term' = 'COB Processing Order');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'COB Processed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `processing_user_name` SET TAGS ('dbx_business_glossary_term' = 'Processing User Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `processing_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `processing_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `total_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `dispensing_pharmacy_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `pbm_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pbm Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Claim Claim Header Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `header_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `party_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `party_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `batch_sequence` SET TAGS ('dbx_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `carc_codes` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Codes (CARC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'clearinghouse|direct|bank');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `clearinghouse_code` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `cycle` SET TAGS ('dbx_business_glossary_term' = 'Payment Cycle');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_reference_number` SET TAGS ('dbx_business_glossary_term' = 'GL Reference Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Is Reconciled Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `is_returned` SET TAGS ('dbx_business_glossary_term' = 'Is Returned Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'eft|check|virtual_card|capitation_offset');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Payment Note');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Payee Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payee_type` SET TAGS ('dbx_value_regex' = 'provider|member|other');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'issued|cleared|voided|returned|stopped');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'claim_payment|capitation|rebate|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `racr_codes` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Codes (RARC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `returned_reason` SET TAGS ('dbx_business_glossary_term' = 'Returned Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Payment Source');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `trace_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Trace Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `trace_number` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `transaction_control_number` SET TAGS ('dbx_business_glossary_term' = '835 Transaction Control Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
