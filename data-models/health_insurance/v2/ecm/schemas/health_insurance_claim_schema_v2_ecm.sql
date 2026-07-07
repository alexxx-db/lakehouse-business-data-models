-- Schema for Domain: claim | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`claim` COMMENT 'Core transactional domain for all medical, dental, vision, and behavioral health claims — professional (837P), institutional (837I), and dental (837D). Owns claim header and line detail, diagnosis codes (ICD), procedure codes (CPT/HCPCS), DRG assignments, adjudication decisions, EOB generation, COB processing, adjustments, denials, and LAE tracking. Interfaces with EDI clearinghouses (Availity, Change Healthcare) and supports IBNR reserving and MLR reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`header` (
    `header_id` BIGINT COMMENT 'Primary key for header',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Needed for account‑level statements that combine premium billing and claim charges, a core reporting requirement for member cost‑sharing and financial reconciliation.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Required for network participation and quality reporting; each claim must be linked to the provider entity for regulatory and performance analytics.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required for claim adjudication to reference the specific provider contract governing fees; essential for contract performance reporting and compliance audits.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that performed the latest status change.',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Needed to tie each claim to the eligibility span governing coverage, enabling eligibility checks and regulatory reporting of claim eligibility periods.',
    `header_rendering_provider_id` BIGINT COMMENT 'FK to provider.provider.provider_id — Every claim must resolve to a rendering provider for network status determination, fee schedule lookup, and provider payment. This is the second most critical operational join in health insurance.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for employer‑sponsored plan cost reporting and ACA employer reporting; each claim must be attributed to the employer group that provided the coverage.',
    `inpatient_admission_id` BIGINT COMMENT 'Foreign key linking to utilization.inpatient_admission. Business justification: Required for Admission‑to‑Claim reconciliation report; claims are generated from inpatient admissions, so linking each claim to its admission record is standard practice.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member (patient) associated with the claim.',
    `plan_service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: Network adequacy and service‑area compliance reports need to map each claim to the plan’s service area where the service was rendered.',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.care_program. Business justification: Needed for Program ROI analysis; associates each claim with the care program enrollment at service time for financial and outcome reporting.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Needed for Claim Intake Eligibility Check: validates rendering providers credential status before claim acceptance.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Required for claim adjudication to apply network‑specific contracts and cost‑share rules; claim processors need to know the provider network for each claim.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.party. Business justification: Needed to associate each claim with the contracting party (provider organization) for regulatory reporting and payment reconciliation.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Regulatory and solvency reporting aggregates claims by risk pool; linking claim to its pool enables accurate financial and compliance analysis.',
    `subscriber_id` BIGINT COMMENT 'FK to member.subscriber.subscriber_id — The claim-to-member join is the single most critical operational query in health insurance. Every claim must resolve to a member for eligibility verification, accumulator updates, and EOB generation. ',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Required for claim adjudication to reference the exact enrollment transaction that established coverage at service date, used in CMS audit and eligibility verification reports.',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: Needed for Case Management Dashboard; each claim must be tied to the utilization case that governs its clinical and financial review.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.plan_year. Business justification: Regulatory reporting and rate filing require associating each claim with the specific plan year under which coverage was provided.',
    `tertiary_rendering_provider_id` BIGINT COMMENT '',
    `adjustment_flag` BOOLEAN COMMENT 'Indicates if the claim includes any adjustments.',
    `admission_date` DATE COMMENT 'Date of patient admission for inpatient claims.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the insurer permits for the services.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed to the insurer before adjustments.',
    `billing_provider_npi` STRING COMMENT 'NPI of the provider responsible for billing.. Valid values are `^[0-9]{10}$`',
    `billing_type` STRING COMMENT 'Method of billing for the claim.. Valid values are `fee_for_service|capitation|bundled|global|per_diem`',
    `claim_event_timestamp` TIMESTAMP COMMENT 'Date and time of the primary service rendered for the claim.',
    `claim_line_count` STRING COMMENT 'Number of line detail records associated with this claim.',
    `claim_number` STRING COMMENT 'Unique claim identifier assigned by the insurer.',
    `claim_paid_date` DATE COMMENT '',
    `claim_received_date` DATE COMMENT '',
    `claim_source` STRING COMMENT 'Origin of the claim submission.. Valid values are `edi|paper|portal|api`',
    `claim_status` STRING COMMENT 'Current processing status of the claim.. Valid values are `submitted|pending|adjudicated|paid|denied|suspended`',
    `claim_type` STRING COMMENT 'Category of claim based on service type.. Valid values are `professional|institutional|dental|vision|behavioral`',
    `claim_version` STRING COMMENT 'Version number of the claim for tracking revisions.',
    `cob_indicator` BOOLEAN COMMENT 'Flag indicating whether coordination of benefits processing is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim header record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason_code` STRING COMMENT 'Code representing the reason for claim denial, if applicable.',
    `diagnosis_codes` STRING COMMENT 'Pipe-separated list of diagnosis codes associated with the claim.',
    `discharge_date` DATE COMMENT 'Date of patient discharge for inpatient claims.',
    `drg_code` STRING COMMENT 'DRG assignment for inpatient claims.. Valid values are `^[0-9]{3,4}$`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` BIGINT COMMENT '',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_hipaa_compliant` BOOLEAN COMMENT 'Flag indicating whether the claim data complies with HIPAA regulations.',
    `is_mlr_excluded` BOOLEAN COMMENT 'Indicates if the claim is excluded from MLR calculations.',
    `is_suspended` BOOLEAN COMMENT 'Indicates if the claim is currently suspended pending additional information.',
    `length_of_stay` STRING COMMENT 'Number of days between admission and discharge.',
    `lob` STRING COMMENT 'Business line to which the claim belongs.. Valid values are `medical|dental|vision|pharmacy|behavioral`',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Net amount paid to the provider after adjustments.',
    `place_of_service_code` STRING COMMENT 'Code indicating where the service was provided.. Valid values are `^[0-9]{2}$`',
    `prior_authorization_number` STRING COMMENT 'Reference number for prior authorization, if required.',
    `prior_status` STRING COMMENT 'Previous status before the most recent transition.. Valid values are `submitted|pending|adjudicated|paid|denied|suspended`',
    `procedure_codes` STRING COMMENT 'Pipe-separated list of procedure codes billed on the claim.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `referral_provider_npi` STRING COMMENT 'NPI of the referring provider, if applicable.. Valid values are `^[0-9]{10}$`',
    `sla_due_date` DATE COMMENT 'Date by which the claim must be processed to meet service level agreement.',
    `sla_met` BOOLEAN COMMENT 'Flag indicating whether the claim met the SLA deadline.',
    `status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition.',
    `suspension_reason` STRING COMMENT 'Reason why the claim was suspended.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim header record.',
    `fhir_resource_id` STRING COMMENT '',
    CONSTRAINT pk_header PRIMARY KEY(`header_id`)
) COMMENT 'Core master record and lifecycle hub for every submitted health insurance claim — professional (CMS-1500/837P), institutional (UB-04/837I), dental (ADA/837D), and behavioral health. Captures claim-level identifiers (ICN), claim type, bill type, place of service, financial totals (billed/allowed/paid), adjudication status with full status transition history (prior status, new status, timestamp, reason, changed-by), service dates, COB indicator, LOB, plan and member identifiers, provider NPIs (rendering, billing, facility, attending, referring), DRG assignment, admission details, claim source (EDI/paper/portal), adjustment linkage, pend/suspend reason tracking, SLA monitoring dates, and HIPAA compliance flags. Serves as the central hub linking all claim-related detail records.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`line` (
    `line_id` BIGINT COMMENT 'Primary key for line',
    `auth_service_line_id` BIGINT COMMENT 'Foreign key linking to utilization.auth_service_line. Business justification: Audit of Prior Authorization compliance; claim line references the authorized service line to verify authorized quantity, price, and status.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Adjudication uses benefit definitions to determine coverage and cost sharing for each claim line; linking claim line to plan.benefit is required for accurate payment calculation.',
    `header_id` BIGINT COMMENT 'Identifier of the parent claim to which this line belongs.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Each claim line maps to a specific ledger account for revenue recognition; required for daily financial reporting and cost allocation.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Enables Line‑Level Credential Verification Process: ensures each lines service provider is credentialed for reimbursement.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Line‑level provider attribution enables detailed utilization, cost, and service‑type analysis required by utilization review and case‑mix reporting.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.network_tier. Business justification: Needed for patient billing statements; tier determines deductible, copay, and coinsurance for each claim line in network‑based cost‑share calculations.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Vendor cost analysis report requires linking each claim line to the service vendor for expense tracking and compliance auditing.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any adjustment applied to the line after initial adjudication.',
    `adjustment_reason_code` STRING COMMENT 'Code describing the reason for the line adjustment.',
    `admission_date` DATE COMMENT 'Date the patient was admitted (applicable to institutional claims).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the payer agrees to pay for the line.',
    `anesthesia_minutes` STRING COMMENT 'Total minutes of anesthesia administered for the line (if applicable).',
    `billed_amount` DECIMAL(18,2) COMMENT 'Charged amount submitted to the payer for the line.',
    `cob_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by secondary/tertiary payers under COB processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason_code` STRING COMMENT 'Standard code indicating why the line was denied.',
    `line_description` STRING COMMENT 'Free‑text description of the service rendered.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged (applicable to institutional claims).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `emergency_indicator` BOOLEAN COMMENT 'True if the service was rendered as an emergency.',
    `epsdt_indicator` BOOLEAN COMMENT 'True if the service qualifies for EPSDT coverage (for Medicaid).',
    `family_planning_indicator` BOOLEAN COMMENT 'True if the service is related to family planning.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim.item)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_number` STRING COMMENT 'Sequential number of the line within the claim.',
    `line_status` STRING COMMENT 'Current processing status of the claim line.. Valid values are `posted|pending|denied|reversed|adjusted`',
    `line_type` STRING COMMENT 'Category of service rendered on the line.. Valid values are `professional|institutional|dental`',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `modifier_1` STRING COMMENT 'First two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_2` STRING COMMENT 'Second two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_3` STRING COMMENT 'Third two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_4` STRING COMMENT 'Fourth two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `ndc_code` STRING COMMENT 'Identifier for drug products when the line represents a pharmacy claim.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Amount actually paid by the payer for the line.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Sum of copay, coinsurance, and deductible amounts owed by the member.',
    `place_of_service_code` STRING COMMENT 'Two‑digit code indicating where the service was provided.. Valid values are `^[0-9]{2}$`',
    `prior_authorization_number` STRING COMMENT 'Reference number of the prior authorization associated with the line.',
    `procedure_code` STRING COMMENT 'Standard procedure code representing the service rendered.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `remark_code` STRING COMMENT 'Additional informational code attached to the line.',
    `revenue_code` STRING COMMENT 'Four‑digit code used for institutional billing to indicate type of service.. Valid values are `^[0-9]{4}$`',
    `service_date` DATE COMMENT 'Date on which the service was provided.',
    `units_of_service` DECIMAL(18,2) COMMENT 'Quantity of the service rendered (e.g., number of visits, dosage units).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Line-level detail for each service rendered within a claim. Captures line number, CPT/HCPCS procedure code, procedure modifier codes (up to 4), revenue code (institutional), service date, units of service, billed amount per line, allowed amount, paid amount, copay amount, coinsurance amount, deductible amount, COB paid amount, line status, denial reason code, remark codes, place of service code, rendering provider NPI at line level, NDC code (for drug lines), quantity qualifier, anesthesia minutes, emergency indicator, EPSDT indicator, family planning indicator, and prior authorization number.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` (
    `diagnosis_id` BIGINT COMMENT 'Primary key for diagnosis',
    `header_id` BIGINT COMMENT 'Identifier of the claim to which this diagnosis belongs.',
    `episode_of_care_id` BIGINT COMMENT 'add column episode_of_care_id (BIGINT) with FK to utilization.episode_of_care.episode_of_care_id - diagnoses populate episode groupers (FHIR/MVM vibe)',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: Clinical quality and risk‑adjustment reports need each diagnosis linked to its HCC mapping for proper risk score calculations.',
    `chronic_condition_flag` BOOLEAN COMMENT 'True if the diagnosis represents a chronic condition relevant for care management.',
    `diagnosis_code` STRING COMMENT 'Official diagnosis code assigned to the claim line.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the diagnosis line was initially loaded into the data lake.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `diagnosis_description` STRING COMMENT 'Full textual description of the diagnosis code.',
    `diagnosis_date` DATE COMMENT 'Calendar date the diagnosis was documented on the claim.',
    `diagnosis_sequence` STRING COMMENT '',
    `diagnosis_status` STRING COMMENT 'Operational status indicating if the diagnosis line is active, pending review, or logically deleted.. Valid values are `active|inactive|deleted|pending`',
    `diagnosis_type` STRING COMMENT 'Specifies the role of the diagnosis (e.g., principal, admitting, external cause, other).. Valid values are `principal|admitting|external_cause|other`',
    `drg_code` STRING COMMENT 'DRG (Diagnosis Related Group) code assigned for inpatient claims.',
    `drg_description` STRING COMMENT 'Textual description of the DRG code.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Condition)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hcc_category` STRING COMMENT 'HCC category code used for risk‑adjustment and RAF calculations.',
    `icd10_code` STRING COMMENT '',
    `icd_version` STRING COMMENT 'Indicates whether the diagnosis code follows ICD‑9‑CM or ICD‑10‑CM standards.. Valid values are `ICD-9|ICD-10`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_quantity` STRING COMMENT 'Number of times the same diagnosis appears on the claim; typically 1.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `poa_indicator` STRING COMMENT 'Indicates if the condition was present at the time of admission (Y=Yes, N=No, U=Unknown).. Valid values are `Y|N|U`',
    `present_on_admission_indicator` STRING COMMENT '',
    `qualifier` STRING COMMENT 'Free‑text qualifier providing extra context (e.g., laterality, severity).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Numeric factor used in risk‑adjustment calculations for the diagnosis.',
    `sequence` STRING COMMENT 'Ordinal position of the diagnosis on the claim (1‑n).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the diagnosis line.',
    CONSTRAINT pk_diagnosis PRIMARY KEY(`diagnosis_id`)
) COMMENT 'Diagnosis code assignments at the claim level supporting ICD-10-CM coding. Captures claim ICN, diagnosis sequence number, ICD version (ICD-10/ICD-9), diagnosis code, diagnosis description, diagnosis type (principal, admitting, external cause, other), POA (Present on Admission) indicator, HCC category mapping, chronic condition flag, and diagnosis qualifier. Supports DRG grouping, risk adjustment (HCC/RAF), HEDIS measure attribution, and clinical analytics.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`procedure` (
    `procedure_id` BIGINT COMMENT 'Primary key for procedure',
    `header_id` BIGINT COMMENT 'Identifier of the parent claim to which this procedure belongs.',
    `episode_of_care_id` BIGINT COMMENT 'add column episode_of_care_id (BIGINT) with FK to utilization.episode_of_care.episode_of_care_id - procedures populate episode groupers (FHIR/MVM vibe)',
    `practice_location_id` BIGINT COMMENT 'Identifier of the facility where the procedure was performed (e.g., hospital NPI or internal location code).',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Required for Provider Credential Verification Report: ensures surgeons credentials are valid for each procedure billed.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Links surgeon NPI to provider entity for surgeon performance, outcome, and credentialing dashboards mandated by quality‑measure reporting.',
    `anesthesia_time_minutes` STRING COMMENT 'Total minutes of anesthesia administered for the procedure.',
    `billing_category` STRING COMMENT 'Category used for billing and reimbursement rules.. Valid values are `inpatient|outpatient|professional|institutional`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Billed amount for the procedure before adjustments.',
    `claim_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the adjustment applied to the procedure charge.',
    `claim_adjustment_reason` STRING COMMENT 'Reason code for any post‑adjudication adjustment applied to this procedure.',
    `claim_line_number` STRING COMMENT 'Line number of this procedure within the claim file.',
    `claim_status` STRING COMMENT 'Current processing status of the claim line containing this procedure.. Valid values are `open|closed|denied|paid|reversed`',
    `procedure_code` STRING COMMENT 'Standardized code representing the medical procedure performed.',
    `code_system` STRING COMMENT 'The coding system used for the procedure_code field.. Valid values are `ICD-10-PCS|CPT|HCPCS`',
    `cpt_hcpcs_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `diagnosis_codes` STRING COMMENT 'Pipe‑delimited list of primary diagnosis codes (ICD‑10‑CM) associated with the procedure. [ENUM-REF-CANDIDATE: multiple codes — promote to reference product]',
    `documentation_indicator` STRING COMMENT 'Indicates completeness of clinical documentation for the procedure.. Valid values are `complete|partial|missing`',
    `drg_code` STRING COMMENT 'DRG assignment for the inpatient case derived from the procedure and diagnoses.',
    `drg_weight` DECIMAL(18,2) COMMENT 'Relative weight of the DRG used for reimbursement calculations.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Procedure)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_emergency` BOOLEAN COMMENT 'True if the procedure was performed under emergency conditions.',
    `is_outpatient` BOOLEAN COMMENT 'True if the procedure was performed in an outpatient setting.',
    `is_primary_procedure` BOOLEAN COMMENT 'True if this is the principal procedure for the claim.',
    `laterality` STRING COMMENT 'Anatomical side on which the procedure was performed.. Valid values are `left|right|bilateral|none`',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `modifier` STRING COMMENT 'Additional qualifier or modifier associated with the procedure code (e.g., bilateral, emergency).',
    `modifier_codes` STRING COMMENT '',
    `net_amount` DECIMAL(18,2) COMMENT 'Final reimbursable amount after adjustments, discounts, and contractual allowances.',
    `notes` STRING COMMENT 'Clinician‑entered free‑text comments about the procedure.',
    `prior_authorization_number` STRING COMMENT 'Identifier of the prior authorization request associated with the procedure, if any.',
    `prior_authorization_status` STRING COMMENT 'Current status of the prior authorization request.. Valid values are `approved|denied|pending`',
    `procedure_date` DATE COMMENT 'Calendar date on which the procedure was performed.',
    `procedure_status` STRING COMMENT 'Current processing status of the procedure record.. Valid values are `performed|scheduled|cancelled|pending`',
    `procedure_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the procedure was performed, captured to the second.',
    `quality_measure_flag` BOOLEAN COMMENT 'True if the procedure contributes to a quality measure (e.g., HEDIS).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the procedure record was first inserted into the data lake.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the procedure record.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `revenue_code` STRING COMMENT 'Hospital revenue code associated with the procedure for institutional claims.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk‑adjusted payment calculations.',
    `secondary_procedure_codes` STRING COMMENT 'Pipe‑delimited list of additional procedure codes related to the primary procedure. [ENUM-REF-CANDIDATE: multiple codes — promote to reference product]',
    `sequence` STRING COMMENT 'Ordinal position of the procedure within the claim (1‑based).',
    `service_location_type` STRING COMMENT 'Classification of the place where the procedure occurred.. Valid values are `hospital|clinic|outpatient_center|home`',
    `surgeon_name` STRING COMMENT 'Full name of the surgeon who performed the procedure.',
    `units_billed` STRING COMMENT '',
    `units_of_service` STRING COMMENT 'Number of units billed for the procedure (e.g., time‑based units).',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_procedure PRIMARY KEY(`procedure_id`)
) COMMENT 'Procedure code assignments at the claim header level (distinct from line-level CPT). Captures principal procedure code (ICD-10-PCS for inpatient), procedure date, procedure sequence, surgeon NPI, procedure qualifier, and secondary procedure codes. Supports DRG assignment, surgical case management, and inpatient utilization analytics. Primarily applicable to 837I institutional claims.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` (
    `adjudication_id` BIGINT COMMENT 'System-generated unique identifier for the adjudication record.',
    `header_id` BIGINT COMMENT 'Unique identifier of the claim that this adjudication decision applies to.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or system that performed the adjudication.',
    `eob_id` BIGINT COMMENT 'add column eob_id (BIGINT) with FK to claim.eob.eob_id - adjudication produces an EOB',
    `health_plan_id` BIGINT COMMENT 'Identifier of the benefit plan under which the claim was submitted.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: GL posting of adjudication results requires a journal entry; finance team uses journal_entry to record each adjudication for audit and reporting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the insured member associated with the claim.',
    `provider_id` BIGINT COMMENT 'National Provider Identifier (NPI) of the treating provider.',
    `accumulator_deductible_impact` DECIMAL(18,2) COMMENT 'Impact on the members deductible accumulator from this adjudication.',
    `accumulator_oop_impact` DECIMAL(18,2) COMMENT 'Impact on the members out‑of‑pocket accumulator.',
    `adjudication_number` STRING COMMENT 'External reference number assigned to the adjudication for audit and communication purposes.',
    `adjudication_status` STRING COMMENT 'Current status of the adjudication decision.. Valid values are `paid|denied|pended|suspended|voided`',
    `adjudication_timestamp` TIMESTAMP COMMENT 'Date and time when the adjudication decision was generated.',
    `admission_date` DATE COMMENT 'Date the patient was admitted (for institutional claims).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the plan permits for the service after contracts and fee schedules.',
    `allowed_amount_method` STRING COMMENT 'Methodology used to calculate the allowed amount.. Valid values are `fee_schedule|mac|rbp|capitation|custom`',
    `auto_adjudication_flag` BOOLEAN COMMENT 'Indicates whether the claim was processed automatically without manual review.',
    `claim_type` STRING COMMENT 'Category of the claim based on service setting.. Valid values are `professional|institutional|dental|vision|behavioral`',
    `cob_adjusted_amount` DECIMAL(18,2) COMMENT 'Amount adjusted after coordination of benefits.',
    `cob_processing_result` STRING COMMENT 'Result of COB processing for the claim.. Valid values are `primary|secondary|tertiary|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `[A-Z]{3}`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
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
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: ExplanationOfBenefit.adjudication)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_necessity_flag` BOOLEAN COMMENT 'Indicates whether the service met medical necessity criteria.',
    `network_status` STRING COMMENT 'Network relationship of the provider for this claim.. Valid values are `in_network|out_of_network|preferred|non_preferred`',
    `oop_amount` DECIMAL(18,2) COMMENT 'Member out‑of‑pocket responsibility after this adjudication.',
    `prior_authorization_required` BOOLEAN COMMENT 'True if the service required prior authorization.',
    `prior_authorization_status` STRING COMMENT 'Outcome of the prior authorization request.. Valid values are `approved|denied|pending|not_required`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the adjudication record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adjudication record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `service_date` DATE COMMENT 'Date on which the service was rendered.',
    `timeliness_flag` BOOLEAN COMMENT 'Indicates whether the claim was filed within the required time window.',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of all adjustments (deductibles, coinsurance, contractual) applied.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Aggregate charge amount submitted on the claim before any adjustments.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount payable to the provider after all adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_adjudication PRIMARY KEY(`adjudication_id`)
) COMMENT 'Authoritative record of the adjudication decision for each claim and claim line, capturing the full pre-payment processing lifecycle including all clinical and administrative edit results. Includes adjudication status (paid/denied/pended/suspended/voided), auto-adjudication flag, adjudicator ID, benefit plan applied, accumulator impacts (deductible/OOP), COB processing results, allowed amount calculation method (fee schedule/MAC/RBP/capitation), network status, medical necessity determination, and final disposition. Captures granular edit-level results (NCCI/OCE/LCD/NCD/plan-specific/timely filing/duplicate) with edit code, edit description, pass/fail/bypass/override outcomes per line, bypass reason, and override authority. Supports coding compliance, payment accuracy, and CMS edit mandate adherence.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`eob` (
    `eob_id` BIGINT COMMENT 'Unique surrogate key for the EOB record.',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: EOB is generated for a specific claim; linking to claim header provides the parent relationship',
    `member_communication_id` BIGINT COMMENT '',
    `identity_id` BIGINT COMMENT 'Unique identifier of the covered member associated with the claim.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Required for EOB Generation Rule: includes credential status of provider on explanation of benefits for compliance.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary subscriber (often the employee or policyholder).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the plan permits for the service.',
    `appeal_rights_text` STRING COMMENT 'Narrative describing the members right to appeal the decision.',
    `appeal_rights_version` STRING COMMENT 'Version identifier for the appeal rights language used.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed by the provider before any adjustments.',
    `claim_icn` STRING COMMENT 'Unique claim identifier used throughout the adjudication process.',
    `cob_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount adjusted due to coordination of benefits with other payers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the EOB record was first created in the data warehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_date` DATE COMMENT 'Date the EOB was actually delivered to the recipient.',
    `delivery_method` STRING COMMENT 'Method used to deliver the EOB to the member or provider.. Valid values are `mail|portal|edi`',
    `denial_reason_summary` STRING COMMENT 'Brief text explaining why a claim or line was denied.',
    `document_number` STRING COMMENT 'External document identifier assigned to the EOB for tracking and reference.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eob_status` STRING COMMENT 'Current lifecycle status of the EOB record.. Valid values are `generated|delivered|suppressed|error`',
    `eob_type` STRING COMMENT 'Indicates whether the EOB is intended for the member or the provider.. Valid values are `member|provider`',
    `fhir_explanation_of_benefit_resource_code` BIGINT COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: ExplanationOfBenefit)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `generation_timestamp` TIMESTAMP COMMENT 'Date and time when the EOB was generated by the claims engine.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language_code` STRING COMMENT 'ISO 639‑2 language code indicating the language of the EOB content.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_responsibility_amount` DECIMAL(18,2) COMMENT 'Portion of the claim the member must pay (deductible, copay, coinsurance, or non‑covered).',
    `member_responsibility_type` STRING COMMENT 'Category of the members financial responsibility for the claim.. Valid values are `deductible|copay|coinsurance|non_covered`',
    `plan_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by the health plan to the provider.',
    `provider_name` STRING COMMENT 'Legal name of the provider who rendered the service.',
    `provider_npi` STRING COMMENT 'Unique national identifier for the provider.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `remark_codes` STRING COMMENT 'Standardized codes providing additional claim processing information.',
    `sbc_reference` STRING COMMENT 'Link or identifier to the applicable Summary of Benefits and Coverage document.',
    `service_end_date` DATE COMMENT 'Last date of service covered by the claim.',
    `service_start_date` DATE COMMENT 'First date of service covered by the claim.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether the EOB should be suppressed from member delivery (e.g., for zero‑payment claims).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the EOB record.',
    `version_number` STRING COMMENT 'Sequential version number for revisions of the EOB.',
    `fhir_explanation_of_benefit_resource_id` STRING COMMENT '',
    CONSTRAINT pk_eob PRIMARY KEY(`eob_id`)
) COMMENT 'Explanation of Benefits document record generated for members and providers following claim adjudication. Captures EOB document ID, EOB type (member/provider), generation date, delivery method (mail/portal/EDI 835), member ID, subscriber ID, claim ICN, service dates, provider name, billed amount, allowed amount, plan paid amount, member responsibility (deductible, copay, coinsurance, non-covered), COB adjustment, denial reason summary, remark codes, appeal rights language version, SBC reference, and EOB suppression flag. Supports member transparency and ACA SBC compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Primary key for adjustment',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Adjustment records are created after an appeal decision; linking to the appeal case provides audit trail and regulatory reporting of appeal‑driven adjustments.',
    `header_id` BIGINT COMMENT 'Identifier of the original claim to which this adjustment applies.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or system that initiated the adjustment.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Financial adjustments to claims are posted as journal entries; linking enables accurate GL impact tracking and regulatory audit.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Adjustment may apply to a specific claim line; replace claim_line_number with a proper FK to claim.line',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the claim adjustment.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider linked to the adjusted claim.',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Total amount after the adjustment is applied.',
    `adjustment_date` TIMESTAMP COMMENT 'Timestamp when the adjustment was recorded or became effective.',
    `adjustment_status` STRING COMMENT 'Current processing status of the adjustment.. Valid values are `pending|approved|rejected|completed`',
    `adjustment_type` STRING COMMENT 'Category of the adjustment indicating its nature.. Valid values are `void|replacement|correction|retroactive`',
    `audit_finding_reference` STRING COMMENT 'Identifier of the audit finding or case that triggered the adjustment.',
    `audit_source` STRING COMMENT 'Origin of the audit finding (e.g., internal, RAC, OIG, provider self‑disclosure).. Valid values are `internal|rac|oig|provider_self_disclosure`',
    `audit_type` STRING COMMENT 'Type of audit that triggered the adjustment.. Valid values are `post_payment|pre_payment|clinical|coding|billing`',
    `adjustment_code` STRING COMMENT 'Internal code categorizing the adjustment for reporting.',
    `compliance_60_day_rule` BOOLEAN COMMENT 'Indicates whether the adjustment complies with the CMS 60‑day overpayment recoupment rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `demand_lifecycle_stage` STRING COMMENT 'Stage of the demand/collection lifecycle for the adjustment.. Valid values are `demand_created|demand_sent|demand_received|demand_resolved`',
    `adjustment_description` STRING COMMENT 'Narrative description of why and how the adjustment was made.',
    `diagnosis_code` STRING COMMENT 'ICD diagnosis code(s) associated with the claim adjustment, if relevant.',
    `effective_date` DATE COMMENT 'Date when the adjustment takes effect.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the adjustment ceases to be effective, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `identifier` STRING COMMENT 'External or business-facing identifier for the adjustment (e.g., RAC audit number).',
    `initiator_role` STRING COMMENT 'Business role of the initiator.. Valid values are `claims_adjuster|auditor|provider|member|system`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_duplicate` BOOLEAN COMMENT 'Flag identifying the adjustment as a duplicate payment correction.',
    `is_fraud` BOOLEAN COMMENT 'Indicates whether the adjustment is related to suspected fraud.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether the adjustment reverses a prior adjustment.',
    `is_void` BOOLEAN COMMENT 'Indicates whether the adjustment voids the original claim payment.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_adjustment_amount` DECIMAL(18,2) COMMENT 'Difference between original and adjusted amounts (positive for overpayment recovery, negative for additional payment).',
    `notes` STRING COMMENT 'Additional free‑form notes captured by the adjuster.',
    `original_amount` DECIMAL(18,2) COMMENT 'Total amount originally paid on the claim before any adjustment.',
    `overpayment_indicator` BOOLEAN COMMENT 'Flag indicating whether the adjustment relates to an overpayment.',
    `overpayment_type` STRING COMMENT 'Specific category of overpayment being corrected.. Valid values are `duplicate|incorrect_rate|ineligible_member|billing_error|fraud`',
    `prior_authorization_number` STRING COMMENT 'Reference number of the prior authorization linked to the claim, if applicable.',
    `procedure_code` STRING COMMENT 'Procedure code(s) related to the adjusted claim line.',
    `reason_code` STRING COMMENT 'Standardized code describing the business reason for the adjustment.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
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
    `header_id` BIGINT COMMENT 'Unique identifier of the claim associated with this denial.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the resolution action.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Denial may apply to a specific claim line; replace claim_line_number with a proper FK to claim.line',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose claim was denied.',
    `appeal_deadline_date` DATE COMMENT 'Last date by which an appeal must be filed.',
    `appeal_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the denial is eligible for an appeal.',
    `carc_code` STRING COMMENT 'Standardized code describing the reason for the claim adjustment/denial.',
    `clinical_criteria` STRING COMMENT 'Reference to the clinical guideline or utilization management criteria applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the denial record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_date` DATE COMMENT 'Date the denial decision was rendered.',
    `denial_number` STRING COMMENT 'External business identifier assigned to the denial, used in communications and reporting.',
    `denial_status` STRING COMMENT 'Current lifecycle status of the denial.. Valid values are `pending|reviewed|appealed|resolved|closed|rejected`',
    `denial_type` STRING COMMENT 'High‑level classification of the denial reason.. Valid values are `clinical|administrative|technical|cob|timely_filing`',
    `denied_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustments (e.g., contractual allowances, discounts) applied to the denied amount.',
    `denied_gross_amount` DECIMAL(18,2) COMMENT 'Original amount of the claim that was denied before any adjustments.',
    `denied_net_amount` DECIMAL(18,2) COMMENT 'Final net amount after adjustments that the member is responsible for due to the denial.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `letter_generated_flag` BOOLEAN COMMENT 'True if a formal denial letter was generated and sent to the member/provider.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_necessity_flag` BOOLEAN COMMENT 'Indicates whether the claim failed medical necessity criteria (true = not medically necessary).',
    `notes` STRING COMMENT 'Free‑form notes captured by reviewers or staff during denial handling.',
    `override_flag` BOOLEAN COMMENT 'True if the denial was manually overridden by a reviewer.',
    `override_reason` STRING COMMENT 'Explanation for why the denial was overridden.',
    `rac_code` STRING COMMENT 'Standardized remark code that provides additional context for the denial.',
    `reason_description` STRING COMMENT 'Narrative explanation of why the claim or line was denied.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resolution_date` DATE COMMENT 'Date the denial was resolved or closed.',
    `resolution_status` STRING COMMENT 'Current status of the denial resolution process.. Valid values are `pending|approved|denied|withdrawn|closed`',
    `subtype` STRING COMMENT 'More granular category within the denial type, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the denial record.',
    CONSTRAINT pk_denial PRIMARY KEY(`denial_id`)
) COMMENT 'Authoritative record of claim and claim line denials, capturing denial reason codes, clinical rationale, and resolution tracking. Includes denial ID, claim ICN, line number (if line-level denial), denial date, denial type (clinical, administrative, technical, COB, timely filing), CARC code, RARC code, denial reason description, clinical criteria applied (InterQual/MCG), medical necessity determination, denial letter generated flag, appeal eligibility flag, appeal deadline date, denial override flag, override reason, and resolution status. Supports appeals workflow, regulatory reporting, and denial management analytics.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`cob` (
    `cob_id` BIGINT COMMENT 'Primary key for cob',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: COB processing is performed per claim; linking to claim header enables traceability',
    `cob_record_id` BIGINT COMMENT 'FK to the members stored alternate-coverage record; member.cob is the claim-level COB processing event',
    `employee_id` BIGINT COMMENT 'Internal identifier of the user who performed the COB processing.',
    `member_eligibility_span_id` BIGINT COMMENT 'FK to member.member_eligibility_span.member_eligibility_span_id',
    `payer_claim_role_id` BIGINT COMMENT 'Internal identifier of the primary insurance payer.',
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
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when the COB processing became effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the COB record expires or is no longer valid (nullable).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_duplicate` BOOLEAN COMMENT 'Flag indicating whether this COB record was generated for a duplicate claim.',
    `is_manual_override` BOOLEAN COMMENT 'True if a user manually overrode automated COB decisions.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicaid_crossover_indicator` BOOLEAN COMMENT 'Flag showing if Medicaid is involved in a crossover scenario.',
    `method` STRING COMMENT 'Method used for coordination of benefits: standard, non‑duplication, or maintenance of benefits.. Valid values are `standard|non_duplication|maintenance_of_benefits`',
    `msp_indicator` BOOLEAN COMMENT 'Flag indicating whether Medicare is acting as the secondary payer for this claim.',
    `msp_type` STRING COMMENT 'Specifies the type of Medicare secondary payer relationship (full or partial).. Valid values are `full|partial`',
    `net_liability_amount` DECIMAL(18,2) COMMENT 'Remaining liability amount after primary and secondary payments and adjustments.',
    `other_insurance_type` STRING COMMENT 'Classification of the secondary insurance when it is not a standard payer (e.g., employer group, Medicare, Medicaid, auto, workers compensation).. Valid values are `employer_group|medicare|medicaid|auto|workers_comp`',
    `primary_payer_allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the primary payer allowed for the claim before COB.',
    `primary_payer_denial_reason` STRING COMMENT 'Reason code or description why the primary payer denied all or part of the claim.',
    `primary_payer_paid_amount` DECIMAL(18,2) COMMENT 'Amount actually paid by the primary payer after adjudication.',
    `process_order` STRING COMMENT 'Sequential order in which multiple payer COB steps are applied for the claim.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date‑time when the COB processing was completed.',
    `processing_user_name` STRING COMMENT 'Display name of the user who performed the COB processing.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `secondary_payer_allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the secondary payer is allowed to pay for the claim.',
    `secondary_payer_code` BIGINT COMMENT 'Internal identifier of the secondary insurance payer.',
    `secondary_payer_denial_reason` STRING COMMENT 'Reason code or description for any denial by the secondary payer.',
    `secondary_payer_name` STRING COMMENT 'Legal name of the secondary insurance payer.',
    `secondary_payer_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by the secondary payer after COB processing.',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'Sum of allowed amounts for all claim lines as determined by the primary payer.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Aggregate charge amount from all claim lines before any adjustments.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the primary payer before secondary adjudication.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COB record.',
    CONSTRAINT pk_cob PRIMARY KEY(`cob_id`)
) COMMENT 'Claim-level COB processing event';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`payment` (
    `payment_id` BIGINT COMMENT 'Primary key for payment',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Claim payments are disbursed through designated bank accounts; linking supports cash‑management reconciliation and audit trails.',
    `eob_id` BIGINT COMMENT 'add column eob_id (BIGINT) with FK to claim.eob.eob_id - payments are documented via EOB',
    `outcome_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_outcome. Business justification: Payments may be adjusted based on appeal outcomes; linking to the appeal outcome enables accurate reconciliation and compliance reporting of appeal‑related payment changes.',
    `header_id` BIGINT COMMENT 'FK to claim.header',
    `party_id` BIGINT COMMENT 'Unique identifier of the entity receiving the payment (provider NPI or member ID).',
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
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `payment_description` STRING COMMENT 'Free‑text description of the payment purpose.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PaymentReconciliation)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_account_number` STRING COMMENT 'General ledger account to which the payment is posted.',
    `gl_posting_date` DATE COMMENT 'Date the payment entry was posted to the general ledger.',
    `gl_reference_number` STRING COMMENT 'Reference identifier linking the payment to the GL transaction.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before any adjustments or taxes.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the payment has been fully reconciled.',
    `is_returned` BOOLEAN COMMENT 'True if the payment was returned by the bank or clearinghouse.',
    `is_voided` BOOLEAN COMMENT 'True if the payment was voided after issuance.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `method` STRING COMMENT 'Instrument used to disburse the payment.. Valid values are `eft|check|virtual_card|capitation_offset`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount paid to the payee after adjustments.',
    `note` STRING COMMENT 'Additional free‑form notes related to the payment.',
    `payee_type` STRING COMMENT 'Classification of the payee: provider, member, or other.. Valid values are `provider|member|other`',
    `payment_date` TIMESTAMP COMMENT 'Timestamp when the payment was issued to the payee.',
    `payment_number` STRING COMMENT 'External payment reference number used in remittance advice and provider communications.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment.. Valid values are `issued|cleared|voided|returned|stopped`',
    `payment_type` STRING COMMENT 'Category of the payment (e.g., claim settlement, capitation offset).. Valid values are `claim_payment|capitation|rebate|adjustment`',
    `racr_codes` STRING COMMENT 'Pipe‑separated list of RARC codes providing additional adjustment details.',
    `reason_code` STRING COMMENT 'Standard code indicating why the payment was made (e.g., claim settlement, rebate).',
    `reconciliation_status` STRING COMMENT 'Current status of the payments financial reconciliation.. Valid values are `reconciled|unreconciled|pending`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `returned_reason` STRING COMMENT 'Explanation for why the payment was returned.',
    `source` STRING COMMENT 'Indicates whether the payment originated from internal systems or an external entity.. Valid values are `internal|external`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax withheld or applied to the payment, if applicable.',
    `trace_number` STRING COMMENT 'Bank‑provided trace number for tracking the payment.',
    `transaction_control_number` STRING COMMENT 'Unique control number for the 835 remittance advice transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    `void_reason` STRING COMMENT 'Explanation for why the payment was voided.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Single source of truth for all claim payment disbursements and electronic remittance advice (835 ERA) transmitted to providers and members. Captures payee information (NPI/TIN/member ID), payment amount, payment date, payment method (EFT/check/virtual card/capitation offset), check/EFT trace number, payment status lifecycle (issued/cleared/voided/returned/stopped), 835 transaction control number, clearinghouse ID (Availity, Change Healthcare), CARC/RARC adjustment codes at claim level, claim-level payment detail, reconciliation status, and GL posting reference. Consolidates provider remittance advice and claim payment into a single authoritative record for payment reconciliation, cash posting, and provider inquiry resolution.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` (
    `ibnr_id` BIGINT COMMENT 'Primary key for ibnr',
    `actuarial_assumption_set_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'Identifier of the actuary responsible for the reserve estimate.',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - IBNR is calculated per plan/LOB for reserving (per user vibe: IBNR must be MVM-grade)',
    `pool_id` BIGINT COMMENT 'add column risk_pool_id (BIGINT) with FK to risk.pool.pool_id - IBNR reserves attach to risk pools (user vibe: IBNR in MVM)',
    `year_id` BIGINT COMMENT 'add column year_id (BIGINT) with FK to plan.year.year_id - IBNR is computed per plan year',
    `actuarial_method` STRING COMMENT 'Actuarial technique used to calculate the IBNR reserve.. Valid values are `Chain-Ladder|Bornhuetter-Ferguson`',
    `completion_factor` DECIMAL(18,2) COMMENT 'Factor representing the proportion of ultimate loss expected to be reported.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reserve record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `ibnr_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the reserve.',
    `development_factor` DECIMAL(18,2) COMMENT 'Factor applied to historical development to project IBNR.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the reserve becomes effective for reporting purposes.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the reserve ceases to be effective (nullable for open‑ended reserves).',
    `estimated_ibnr_amount` DECIMAL(18,2) COMMENT 'Actuarial estimate of incurred‑but‑not‑reported liability.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `ibnr_status` STRING COMMENT 'Current lifecycle status of the IBNR reserve record.. Valid values are `draft|active|approved|closed|rejected`',
    `incurred_month` DATE COMMENT 'Month in which the underlying claims were incurred.',
    `incurred_period_end` DATE COMMENT '',
    `incurred_period_start` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lag_factor` DECIMAL(18,2) COMMENT '',
    `line_of_business` STRING COMMENT 'Business line to which the reserve applies (e.g., Medical, Dental).. Valid values are `Medical|Dental|Vision|Behavioral`',
    `lob_code` STRING COMMENT '',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `methodology_code` STRING COMMENT '',
    `mlr_numerator_allocation` DECIMAL(18,2) COMMENT 'Portion of the IBNR reserve allocated to the Medical Loss Ratio numerator.',
    `paid_through_date` DATE COMMENT '',
    `paid_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative amount paid on the claim cohort to date.',
    `plan_type` STRING COMMENT 'Type of health plan associated with the reserve.. Valid values are `HMO|PPO|EPO|POS|HDHP`',
    `prior_period_reserve_amount` DECIMAL(18,2) COMMENT 'IBNR reserve amount from the previous reporting period.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reserve_amount` DECIMAL(18,2) COMMENT '',
    `reserve_change_amount` DECIMAL(18,2) COMMENT 'Difference between current and prior period reserve amounts.',
    `reserve_period_month` STRING COMMENT 'Month (1‑12) of the reserve reporting period.',
    `reserve_period_year` STRING COMMENT 'Calendar year of the reserve reporting period.',
    `reserve_run_date` DATE COMMENT 'Date on which the IBNR reserve calculation was performed.',
    `service_category` STRING COMMENT 'Category of services covered by the reserve.. Valid values are `Inpatient|Outpatient|Professional|Pharmacy|Dental`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reserve record.',
    CONSTRAINT pk_ibnr PRIMARY KEY(`ibnr_id`)
) COMMENT 'Incurred But Not Reported (IBNR) reserve estimates at the claim cohort level, supporting actuarial reserving and MLR reporting. Captures reserve ID, reserve period (month/year), LOB, plan type, service category, incurred month, paid-to-date amount, estimated IBNR amount, development factor applied, completion factor, actuarial method (chain-ladder/Bornhuetter-Ferguson), reserve run date, actuary ID, prior period reserve amount, reserve change amount, and MLR numerator allocation. Interfaces with Milliman MG-ALFA and Oracle Financials for statutory and GAAP reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` (
    `subrogation_id` BIGINT COMMENT 'Unique identifier for the subrogation record.',
    `header_id` BIGINT COMMENT 'Identifier of the claim associated with this subrogation.',
    `identity_id` BIGINT COMMENT 'Identifier of the insured member whose claim is being subrogated.',
    `payment_id` BIGINT COMMENT 'add column recovery_payment_id (BIGINT) with FK to claim.payment.payment_id - subrogation results in recovery payments',
    `accident_city` STRING COMMENT 'City of the accident location.',
    `accident_country` STRING COMMENT 'Three‑letter ISO country code of the accident location.',
    `accident_date` DATE COMMENT 'Date on which the loss event occurred.',
    `accident_state_code` STRING COMMENT 'Two‑letter state code where the accident occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the record was first inserted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `demand_amount` DECIMAL(18,2) COMMENT 'Amount requested in the initial demand to the third‑party insurer.',
    `demand_sent_date` DATE COMMENT 'Date the demand letter was sent to the third‑party insurer.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gross_recovery_amount` DECIMAL(18,2) COMMENT 'Total amount claimed from the third‑party before deductions.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Timestamp when the subrogation case was created in the system.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_lien_applied` BOOLEAN COMMENT 'Flag indicating whether a lien has been applied to the recovery.',
    `is_recovery_closed` BOOLEAN COMMENT 'Flag indicating the subrogation case is closed and no further action is expected.',
    `is_settlement_agreed` BOOLEAN COMMENT 'Indicates if the parties have reached a settlement agreement.',
    `legal_fees_amount` DECIMAL(18,2) COMMENT 'Attorney and legal costs associated with the subrogation.',
    `liability_type` STRING COMMENT 'Nature of the liability relationship with the third party.. Valid values are `primary|secondary|joint`',
    `lien_amount` DECIMAL(18,2) COMMENT 'Amount of any lien placed on the recovery.',
    `lien_holder_name` STRING COMMENT 'Name of the entity holding a lien on the recovery.',
    `lien_status` STRING COMMENT 'Current status of the lien.. Valid values are `pending|applied|released`',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `negotiation_start_date` DATE COMMENT 'Date when formal negotiations began.',
    `net_recovery_amount` DECIMAL(18,2) COMMENT 'Final amount recovered after legal fees and other adjustments.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recovery_method` STRING COMMENT 'Method used to obtain the recovery (e.g., direct payment, offset against claim, court judgment).. Valid values are `direct|offset|court`',
    `recovery_notes` STRING COMMENT 'Free‑form notes describing negotiations, special conditions, or observations.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this subrogation must be reported to state regulators.',
    `reporting_state_code` STRING COMMENT 'Two‑letter code of the state for regulatory reporting purposes.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Amount agreed upon in the settlement of the subrogation.',
    `settlement_date` DATE COMMENT 'Date the subrogation settlement was finalized.',
    `subrogation_number` STRING COMMENT 'Business identifier assigned to the subrogation case.',
    `subrogation_status` STRING COMMENT 'Current lifecycle status of the subrogation case.. Valid values are `identified|demand_sent|negotiating|settled|closed|rejected`',
    `subrogation_type` STRING COMMENT 'Category of third‑party liability (e.g., auto accident, workers compensation).. Valid values are `auto|workers_comp|premises|other`',
    `third_party_insurer_code` BIGINT COMMENT 'Identifier of the third‑party insurer or liable party.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the record.',
    CONSTRAINT pk_subrogation PRIMARY KEY(`subrogation_id`)
) COMMENT 'Third-party liability (TPL) and subrogation recovery tracking for claims where another party bears financial responsibility — auto accidents, workers compensation, premises liability, and other TPL scenarios. Captures subrogation type, third-party insurer details, accident information, demand and recovery lifecycle (identified → demand sent → negotiating → settled → closed), attorney/lien details, recovery amounts, and net recovery after legal fees. Supports recovery revenue optimization, LAE offset, and state-mandated TPL reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`drg` (
    `drg_id` BIGINT COMMENT 'Primary key for drg',
    `drg_claim_header_id` BIGINT COMMENT 'Identifier of the claim to which this DRG assignment belongs.',
    `drg_header_id` BIGINT COMMENT '',
    `inpatient_admission_id` BIGINT COMMENT '',
    `header_id` BIGINT COMMENT '',
    `arithmetic_mean_los` DECIMAL(18,2) COMMENT 'Arithmetic mean length of stay for the DRG across the reference population.',
    `assignment_status` STRING COMMENT 'Current processing status of the DRG assignment.. Valid values are `assigned|revised|rejected|finalized`',
    `base_rate_applied` DECIMAL(18,2) COMMENT 'Base payment rate applied to the DRG before adjustments.',
    `case_mix_index_contribution` DECIMAL(18,2) COMMENT 'Contribution of this DRG to the providers overall case mix index.',
    `cc_mcc_flag` STRING COMMENT 'Indicates whether the claim has no CC/MCC, a CC, or an MCC.. Valid values are `none|cc|mcc`',
    `drg_code` STRING COMMENT 'Three- or four‑digit Diagnosis Related Group code assigned to the claim.. Valid values are `^d{3,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DRG assignment record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `drg_description` STRING COMMENT 'Human‑readable description of the DRG code.',
    `drg_type` STRING COMMENT 'Category of the DRG based on care setting.. Valid values are `inpatient|outpatient|post-acute`',
    `effective_date` DATE COMMENT 'Date on which the DRG assignment becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date on which the DRG assignment expires, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geometric_mean_los` DECIMAL(18,2) COMMENT 'Geometric mean of length of stay for the DRG across the reference population.',
    `grouper_method` STRING COMMENT 'Methodology used to generate the DRG (e.g., MS‑DRG, APR‑DRG).. Valid values are `MS-DRG|APR-DRG|IR-DRG`',
    `grouper_run_timestamp` TIMESTAMP COMMENT 'Date‑time when the DRG grouper was executed for this claim.',
    `grouper_software_version` STRING COMMENT 'Version identifier of the software that performed the DRG grouping.',
    `grouper_status` STRING COMMENT 'Processing status of the grouper run for this assignment.. Valid values are `complete|pending|error`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_quantity` STRING COMMENT 'Number of DRG units represented by this line (typically 1).',
    `line_sequence_number` STRING COMMENT 'Sequence order of the DRG assignment within the claim (normally 1).',
    `major_diagnostic_category` STRING COMMENT 'Broad diagnostic category (MDC) associated with the DRG.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `outlier_payment_amount` DECIMAL(18,2) COMMENT 'Additional payment made when the claim exceeds the outlier threshold.',
    `outlier_threshold` DECIMAL(18,2) COMMENT 'Cost threshold above which an outlier payment is triggered.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Reimbursable amount calculated for the DRG before any claim‑level adjustments.',
    `payment_currency` STRING COMMENT 'Three‑letter ISO currency code for the DRG payment amount.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `principal_diagnosis_code` STRING COMMENT 'ICD‑10‑CM code of the principal diagnosis used for DRG assignment.. Valid values are `^[A-TV-Z][0-9][0-9A-Z](.[0-9A-Z]{1,4})?$`',
    `principal_procedure_code` STRING COMMENT 'CPT or HCPCS code of the principal procedure influencing DRG assignment.. Valid values are `^[0-9]{5}$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DRG assignment record.',
    `version` STRING COMMENT 'Version of the DRG grouper used (e.g., MS-DRG v38, APR-DRG v30).',
    `weight` DECIMAL(18,2) COMMENT 'Relative weight used to calculate reimbursement for the DRG.',
    CONSTRAINT pk_drg PRIMARY KEY(`drg_id`)
) COMMENT 'Diagnosis Related Group (DRG) assignment record for inpatient institutional claims, capturing the DRG grouper output. Includes DRG assignment ID, claim ICN, DRG version (MS-DRG/APR-DRG/IR-DRG), DRG code, DRG description, MDC (Major Diagnostic Category), DRG weight, geometric mean LOS, arithmetic mean LOS, base rate applied, outlier threshold, outlier payment amount, case mix index contribution, grouper software version, grouper run date, principal diagnosis used, principal procedure used, and complication/comorbidity (CC/MCC) flag. Supports inpatient reimbursement, case mix management, and utilization benchmarking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` (
    `accumulator_id` BIGINT COMMENT 'Primary key for accumulator',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan governing the benefit limits.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the accumulator applies.',
    `year_id` BIGINT COMMENT 'add column year_id (BIGINT) with FK to plan.year.year_id - deductible/OOP accumulators are per plan year',
    `accumulated_amount` DECIMAL(18,2) COMMENT 'Total amount that has been applied to the accumulator to date.',
    `accumulator_status` STRING COMMENT 'Current lifecycle status of the accumulator record.. Valid values are `active|inactive|closed|pending|suspended|expired`',
    `accumulator_type` STRING COMMENT 'Type of benefit being tracked (e.g., deductible, out‑of‑pocket maximum).. Valid values are `deductible|oop_max|visit_limit|rx_limit|hospital_stay|annual_max`',
    `adjustment_reason` STRING COMMENT 'Free‑text or coded reason describing why an adjustment was applied.',
    `benefit_category` STRING COMMENT 'High‑level category of the benefit tracked by the accumulator.. Valid values are `medical|dental|vision|pharmacy|wellness|behavioral`',
    `benefit_period_end` DATE COMMENT 'Last day of the benefit period for which the accumulator is calculated.',
    `benefit_period_start` DATE COMMENT 'First day of the benefit period for which the accumulator is calculated.',
    `accumulator_code` STRING COMMENT 'Business identifier code for the accumulator, used in reporting and member communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the accumulator record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `accumulator_description` STRING COMMENT 'Optional free‑form description or notes about the accumulator record.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent claim event that modified the accumulator.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_adjustment` BOOLEAN COMMENT 'Indicates whether the latest change to the accumulator was an adjustment (e.g., post‑payment correction).',
    `is_reversal` BOOLEAN COMMENT 'True if the most recent transaction reversed a prior accumulator entry.',
    `last_reset_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent reset of the accumulator (e.g., annual renewal).',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount allowed for the accumulator in the benefit period.',
    `line_of_business` STRING COMMENT 'Business segment classification for the members coverage.. Valid values are `individual|group|employer|government|commercial|medicare`',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_tier` STRING COMMENT 'Network tier defining provider cost-sharing rules for the accumulator.. Valid values are `in_network|out_of_network|preferred|standard|tier1|tier2`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Amount remaining before the member reaches the benefit limit.',
    `reversal_reason` STRING COMMENT 'Reason code or description for a reversal operation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the accumulator record.',
    CONSTRAINT pk_accumulator PRIMARY KEY(`accumulator_id`)
) COMMENT 'Member-level benefit accumulator ledger tracking deductibles, out-of-pocket maximums (MOOP), visit limits, and other benefit thresholds applied during claims adjudication. Captures current balances (accumulated amount, remaining balance, benefit limit) by member, benefit period, accumulator type, LOB, plan, and network tier, plus the full transaction-level audit trail of credits, debits, reversals, and resets applied by each claim event. Supports real-time adjudication decisions, ACA MOOP compliance, and member cost-sharing transparency.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` (
    `adjudication_rate_id` BIGINT COMMENT 'System-generated unique identifier for each adjudication rate record.',
    `provider_contract_id` BIGINT COMMENT 'Identifier of the contract under which this rate was negotiated.',
    `fee_schedule_id` BIGINT COMMENT 'FK to contract.fee_schedule',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - adjudication rates apply per plan',
    `adjudication_rate_status` STRING COMMENT 'Current lifecycle status of the rate.. Valid values are `active|inactive|retired|pending`',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum reimbursable amount for the procedure under this rate.',
    `awp_percentage` DECIMAL(18,2) COMMENT 'Percentage of AWP used for drug pricing calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `adjudication_rate_description` STRING COMMENT 'Human‑readable description or notes about the rate.',
    `effective_date` DATE COMMENT 'Date when this rate becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.plan.specificCost)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_cbsa` STRING COMMENT 'CBSA code representing the metropolitan area of service.',
    `geographic_county` STRING COMMENT 'County name or FIPS code for the service location.',
    `geographic_state` STRING COMMENT 'Two‑letter state abbreviation where service was rendered.. Valid values are `^[A-Z]{2}$`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `mac_rate` DECIMAL(18,2) COMMENT 'Maximum allowable cost for a drug or service as defined by MAC.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicare_fee_schedule_percent` DECIMAL(18,2) COMMENT 'Percentage of the Medicare fee schedule applied to calculate the allowed amount.',
    `network_tier` STRING COMMENT 'Tier classification of the provider within the plan network.. Valid values are `in_network|out_of_network|preferred|standard|specialty`',
    `place_of_service_code` STRING COMMENT 'Code indicating the location where service was provided. See POS code list; values beyond six are managed via reference table.',
    `procedure_code` STRING COMMENT 'Standard procedure code used for billing (CPT or HCPCS).. Valid values are `^[0-9]{5}$|^[A-Z0-9]{5}$`',
    `procedure_modifier` STRING COMMENT 'Optional modifier that further specifies the procedure.. Valid values are `^[A-Z0-9]{0,2}$`',
    `provider_specialty_code` STRING COMMENT 'Taxonomy code representing the providers specialty.',
    `provider_type` STRING COMMENT 'Broad classification of the provider entity.. Valid values are `physician|hospital|lab|pharmacy|clinic`',
    `rate_source` STRING COMMENT 'Origin of the rate definition (e.g., CMS, plan‑specific, contracted).. Valid values are `CMS|Plan|Contract`',
    `rate_type` STRING COMMENT 'Category of the rate (procedure, drug, bundle, or service).. Valid values are `procedure|drug|bundle|service`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rvu_based_flag` BOOLEAN COMMENT 'Indicates whether the allowed amount is derived from Relative Value Units.',
    `termination_date` DATE COMMENT 'Date when this rate is no longer valid (null if open‑ended).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate record.',
    CONSTRAINT pk_adjudication_rate PRIMARY KEY(`adjudication_rate_id`)
) COMMENT 'Adjudication-time reimbursement rate lookup defining allowed amounts for procedure codes by provider type, network tier, geographic area, and effective date. Captures rate ID, fee schedule name and version, CPT/HCPCS code, modifier, place of service, provider specialty, geographic area (state/county/CBSA), network tier, allowed amount, RVU-based calculation flag, Medicare fee schedule percentage, MAC rate, AWP percentage (for drug codes), effective date, termination date, and rate source (CMS/plan-specific/contracted). Owned by the claim domain as the adjudication-time rate snapshot — the contract domain owns the negotiated rate master; this product captures the rate as-applied at the moment of claim pricing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`attachment` (
    `attachment_id` BIGINT COMMENT 'System-generated unique identifier for the attachment record.',
    `line_id` BIGINT COMMENT 'Identifier of the specific claim line (service) the attachment supports, if applicable.',
    `credential_document_id` BIGINT COMMENT '',
    `authorization_document_id` BIGINT COMMENT '',
    `parent_attachment_id` BIGINT COMMENT 'Self-referencing FK on attachment (parent_attachment_id)',
    `header_id` BIGINT COMMENT 'Identifier of the claim to which this attachment belongs.',
    `access_count` STRING COMMENT 'Number of times the attachment has been accessed by users or systems.',
    `attachment_status` STRING COMMENT 'Current processing status of the attachment.. Valid values are `pending|received|reviewed|rejected|approved|archived`',
    `checksum_sha256` STRING COMMENT 'SHA-256 hash of the file used for integrity verification.. Valid values are `^[A-Fa-f0-9]{64}$`',
    `confidentiality_level` STRING COMMENT 'Data classification indicating the sensitivity of the attachment per corporate policy.. Valid values are `public|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'When the attachment record was first created in the data lake.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `attachment_description` STRING COMMENT 'Free‑form description or notes supplied by the submitter about the document.',
    `document_category` STRING COMMENT 'High‑level classification of the attachment content.. Valid values are `medical_record|itemized_bill|operative_report|lab_result|prescription|authorization`',
    `document_subtype` STRING COMMENT 'More specific classification within the document category (e.g., radiology_report, discharge_summary).',
    `document_type_code` STRING COMMENT '',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `encryption_method` STRING COMMENT 'Algorithm used to encrypt the attachment, if applicable.. Valid values are `aes256|des|none`',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time after which the attachment may be archived or purged.',
    `external_document_reference` STRING COMMENT 'Identifier assigned by the originating source system (e.g., provider, clearinghouse) to the document.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `file_name` STRING COMMENT 'Original name of the attached file as supplied by the submitter.',
    `file_size_bytes` BIGINT COMMENT 'Size of the attachment in bytes.',
    `file_type` STRING COMMENT 'Standard MIME type describing the file format (e.g., application/pdf, image/jpeg).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_encrypted` BOOLEAN COMMENT 'True if the attachment is stored in encrypted form.',
    `is_original` BOOLEAN COMMENT 'True if the attachment is the original source document; false if it is a copy or derived file.',
    `is_sensitive` BOOLEAN COMMENT 'Indicates whether the attachment contains PHI or other restricted information.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent access.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional comments or internal notes about the attachment.',
    `received_method` STRING COMMENT 'Method by which the attachment was submitted.. Valid values are `portal|fax|mail|edi|email`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `retention_period_days` STRING COMMENT 'Number of days the attachment must be retained to satisfy regulatory requirements.',
    `source_system_reference` STRING COMMENT 'Native identifier of the document in the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'When the attachment record was last modified.',
    `upload_timestamp` TIMESTAMP COMMENT 'Date and time when the attachment was received into the lakehouse.',
    `virus_scan_result` STRING COMMENT 'Outcome of the malware scan.. Valid values are `clean|infected|unknown`',
    `virus_scanned` BOOLEAN COMMENT 'Indicates whether the attachment has been scanned for malware.',
    CONSTRAINT pk_attachment PRIMARY KEY(`attachment_id`)
) COMMENT 'Clinical and supporting document attachments submitted with or requested for a claim — operative reports, medical records, itemized bills, and other documentation required for adjudication. Captures attachment type, submission method (275 EDI, portal, fax), receipt date, and association to claim header or line.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`status_event` (
    `status_event_id` BIGINT COMMENT 'Unique surrogate key for each immutable claim status event record.',
    `header_id` BIGINT COMMENT 'Identifier of the claim whose status transition is recorded.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or automated process that triggered the status change.',
    `parent_status_event_id` BIGINT COMMENT 'Self-referencing FK on status_event (parent_status_event_id)',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this event record was first inserted into the lakehouse.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this event record (e.g., after correction or annotation).',
    `comments` STRING COMMENT 'Optional free‑text notes added by the actor for context or clarification.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_source` STRING COMMENT 'Originating system that generated the status event (e.g., EDI gateway, core claims engine, pharmacy benefit manager).. Valid values are `EDI|CORE|PBM|UM|CAREMGMT|OTHER`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the status transition occurred.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_manual` BOOLEAN COMMENT 'Indicates whether the status change was performed manually (True) or automatically (False).',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `previous_status_code` STRING COMMENT 'Code representing the claims status before this transition.. Valid values are `received|pended|adjudicated|paid|denied|adjusted`',
    `reason_code` STRING COMMENT 'Standardized code indicating why the status changed (e.g., payment received, denial rule, manual override).',
    `reason_description` STRING COMMENT 'Human‑readable description of the reason for the status change.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `status_code` STRING COMMENT 'Code representing the claims new lifecycle status after the transition.. Valid values are `received|pended|adjudicated|paid|denied|adjusted`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `user_role` STRING COMMENT 'Role of the actor initiating the transition (system process, internal operator, provider, or member).. Valid values are `system|operator|provider|member`',
    CONSTRAINT pk_status_event PRIMARY KEY(`status_event_id`)
) COMMENT 'Immutable audit trail of claim lifecycle status transitions — received, pended, adjudicated, paid, denied, appealed, adjusted. Captures status code, transition timestamp, triggering user or system, and reason code. Supports 277 claim status inquiry responses.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` (
    `payer_claim_role_id` BIGINT COMMENT 'Primary key for payer',
    `payer_billing_role_id` BIGINT COMMENT 'SSOT reference to canonical payer master billing.payer',
    `health_plan_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
    `account_balance` DECIMAL(18,2) COMMENT 'Current balance of the payers account.',
    `account_currency` STRING COMMENT 'ISO 4217 currency code for the payers account.',
    `account_number` STRING COMMENT 'Bank account number used for payments to the payer.',
    `account_status` STRING COMMENT 'Lifecycle status of the payers account.',
    `address_line1` STRING COMMENT 'First line of the payers address.',
    `address_line2` STRING COMMENT 'Second line of the payers address, if applicable.',
    `business_number` STRING COMMENT 'Business registration number for the payer.',
    `city` STRING COMMENT 'City of the payers address.',
    `contact_email` STRING COMMENT 'Primary email address for contacting the payer.',
    `contact_name` STRING COMMENT 'Name of the primary contact person for the payer.',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting the payer.',
    `contract_end_date` DATE COMMENT 'End date of the payers contract.',
    `contract_number` STRING COMMENT 'Identifier for the payers contract with the insurer.',
    `contract_start_date` DATE COMMENT 'Start date of the payers contract.',
    `contract_status` STRING COMMENT 'Current status of the payers contract.',
    `country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the payers address.',
    `coverage_end_date` DATE COMMENT 'End date of coverage provided by the payer.',
    `coverage_start_date` DATE COMMENT 'Start date of coverage provided by the payer.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the payer record was first created.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deleted_at` TIMESTAMP COMMENT 'Timestamp when the payer record was soft-deleted.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `external_payer_naic_code` STRING COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lei` STRING COMMENT 'Legal Entity Identifier for the payer.',
    `logo_url` STRING COMMENT 'URL to the payers logo image.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional notes or remarks about the payer.',
    `other_carrier_naic_code` STRING COMMENT '',
    `payer_name` STRING COMMENT 'Legal name of the payer organization.',
    `payer_role_code` STRING COMMENT '',
    `payer_status` STRING COMMENT 'Current lifecycle status of the payer.',
    `payer_type` STRING COMMENT 'Category of the payer entity.',
    `payment_cycle` STRING COMMENT 'Description of the payment cycle for the payer.',
    `payment_frequency` STRING COMMENT 'Frequency of payments to the payer.',
    `payment_method` STRING COMMENT 'Preferred method of payment to the payer.',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the payer.',
    `rating` STRING COMMENT 'Rating assigned to the payer by the insurer.',
    `rating_source` STRING COMMENT 'Source of the rating for the payer.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_category` STRING COMMENT 'Risk category classification for the payer.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the payer.',
    `state` STRING COMMENT 'State or province abbreviation of the payers address.',
    `tax_number` STRING COMMENT 'Employer Identification Number (EIN) for the payer.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payer record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `website` STRING COMMENT 'Official website URL of the payer.',
    `zip` STRING COMMENT 'ZIP or postal code of the payers address.',
    CONSTRAINT pk_payer_claim_role PRIMARY KEY(`payer_claim_role_id`)
) COMMENT 'External other-carrier payer for COB processing. Distinct from billing.payer_billing_role which is the receiving plan legal entity acting as payer. [P200 skipped: target-product-missing:claim.payer renamed to claim.payer_claim_role per VREQ-009]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`claim`.`claim_payer` (
    `claim_payer_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'Foreign key to plan.health_plan for plan scoping',
    `primary_health_plan_id` BIGINT COMMENT 'add column external_payer_naic_code (no FK) and add health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - internal payer linkage for self-payer scenarios',
    `vendor_id` BIGINT COMMENT 'FK to vendor.vendor for third-party entity tracking',
    `cob_order_priority` STRING COMMENT '',
    `group_number` STRING COMMENT '',
    `other_carrier_naic_code` STRING COMMENT '',
    `payer_role_code` STRING COMMENT '',
    `policy_number` STRING COMMENT '',
    CONSTRAINT pk_claim_payer PRIMARY KEY(`claim_payer_id`)
) COMMENT 'External other-carrier payer for coordination of benefits (COB); distinct from billing.payer which is the receiving payer.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_eob_id` FOREIGN KEY (`eob_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`eob`(`eob_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_payer_claim_role_id` FOREIGN KEY (`payer_claim_role_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`payer_claim_role`(`payer_claim_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_eob_id` FOREIGN KEY (`eob_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`eob`(`eob_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ADD CONSTRAINT `fk_claim_subrogation_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ADD CONSTRAINT `fk_claim_subrogation_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`payment`(`payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ADD CONSTRAINT `fk_claim_drg_drg_claim_header_id` FOREIGN KEY (`drg_claim_header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ADD CONSTRAINT `fk_claim_drg_drg_header_id` FOREIGN KEY (`drg_header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ADD CONSTRAINT `fk_claim_drg_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_parent_attachment_id` FOREIGN KEY (`parent_attachment_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`attachment`(`attachment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ADD CONSTRAINT `fk_claim_status_event_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ADD CONSTRAINT `fk_claim_status_event_parent_status_event_id` FOREIGN KEY (`parent_status_event_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`status_event`(`status_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`claim` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`claim` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_fhir_resource' = 'Claim');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` SET TAGS ('pii_plan_service_area_fk_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Header Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `header_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Claiming Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Changed By (User ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `header_rendering_provider_id` SET TAGS ('pii_business_glossary_term' = 'Header Rendering Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `inpatient_admission_id` SET TAGS ('pii_business_glossary_term' = 'Inpatient Admission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `plan_service_area_id` SET TAGS ('pii_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'Care Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Provider Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Provider Party Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Subscriber Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `subscriber_id` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `um_case_id` SET TAGS ('pii_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `year_id` SET TAGS ('pii_business_glossary_term' = 'Plan Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `admission_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billed_amount` SET TAGS ('pii_business_glossary_term' = 'Billed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Billing Provider NPI');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_type` SET TAGS ('pii_business_glossary_term' = 'Billing Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `billing_type` SET TAGS ('pii_value_regex' = 'fee_for_service|capitation|bundled|global|per_diem');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Claim Service Date (Start)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_line_count` SET TAGS ('pii_business_glossary_term' = 'Claim Line Count');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('pii_business_glossary_term' = 'Claim Number (CLM)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_source` SET TAGS ('pii_business_glossary_term' = 'Claim Source');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_source` SET TAGS ('pii_value_regex' = 'edi|paper|portal|api');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_status` SET TAGS ('pii_value_regex' = 'submitted|pending|adjudicated|paid|denied|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_type` SET TAGS ('pii_business_glossary_term' = 'Claim Type (PROF/INST/DENT/VIS/BEH)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_type` SET TAGS ('pii_value_regex' = 'professional|institutional|dental|vision|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `claim_version` SET TAGS ('pii_business_glossary_term' = 'Claim Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `cob_indicator` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `diagnosis_codes` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Codes (ICD-10)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `diagnosis_codes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `diagnosis_codes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Related Group (DRG) Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `drg_code` SET TAGS ('pii_value_regex' = '^[0-9]{3,4}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `drg_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `is_hipaa_compliant` SET TAGS ('pii_business_glossary_term' = 'HIPAA Compliance Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `is_mlr_excluded` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `is_suspended` SET TAGS ('pii_business_glossary_term' = 'Suspended Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `length_of_stay` SET TAGS ('pii_business_glossary_term' = 'Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'medical|dental|vision|pharmacy|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `paid_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service Code (POS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `prior_status` SET TAGS ('pii_business_glossary_term' = 'Prior Claim Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `prior_status` SET TAGS ('pii_value_regex' = 'submitted|pending|adjudicated|paid|denied|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `procedure_codes` SET TAGS ('pii_business_glossary_term' = 'Procedure Codes (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Referral Provider NPI');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `sla_due_date` SET TAGS ('pii_business_glossary_term' = 'SLA Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `sla_met` SET TAGS ('pii_business_glossary_term' = 'SLA Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `status_change_timestamp` SET TAGS ('pii_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `suspension_reason` SET TAGS ('pii_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ALTER COLUMN `fhir_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('pii_fhir_resource' = 'Claim.item');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('pii_business_glossary_term' = 'Line Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `auth_service_line_id` SET TAGS ('pii_business_glossary_term' = 'Auth Service Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `benefit_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Identifier (CLM_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Provider Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Line Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `tier_id` SET TAGS ('pii_business_glossary_term' = 'Network Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Line Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Line Adjustment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `admission_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `anesthesia_minutes` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `billed_amount` SET TAGS ('pii_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `cob_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Line Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_description` SET TAGS ('pii_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `emergency_indicator` SET TAGS ('pii_business_glossary_term' = 'Emergency Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `epsdt_indicator` SET TAGS ('pii_business_glossary_term' = 'Early and Periodic Screening, Diagnostic, and Treatment (EPSDT) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `family_planning_indicator` SET TAGS ('pii_business_glossary_term' = 'Family Planning Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('pii_value_regex' = 'posted|pending|denied|reversed|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_type` SET TAGS ('pii_business_glossary_term' = 'Line Type (Professional/Institutional/Dental)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `line_type` SET TAGS ('pii_value_regex' = 'professional|institutional|dental');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `ndc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `paid_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `remark_code` SET TAGS ('pii_business_glossary_term' = 'Remark Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `remark_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `units_of_service` SET TAGS ('pii_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Line Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('pii_fhir_resource' = 'Condition');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `hcc_mapping_id` SET TAGS ('pii_business_glossary_term' = 'Risk Hcc Mapping Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Line Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('pii_value_regex' = 'active|inactive|deleted|pending');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_value_regex' = 'principal|admitting|external_cause|other');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `drg_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `drg_description` SET TAGS ('pii_business_glossary_term' = 'DRG Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `hcc_category` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `hcc_category` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `hcc_category` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `icd_version` SET TAGS ('pii_business_glossary_term' = 'ICD Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `icd_version` SET TAGS ('pii_value_regex' = 'ICD-9|ICD-10');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `line_quantity` SET TAGS ('pii_business_glossary_term' = 'Line Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('pii_business_glossary_term' = 'Present on Admission Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('pii_value_regex' = 'Y|N|U');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `qualifier` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Qualifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `sequence` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('pii_fhir_resource' = 'Procedure');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `practice_location_id` SET TAGS ('pii_business_glossary_term' = 'Service Location Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Surgeon Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Surgeon Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `anesthesia_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Time (Minutes)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `billing_category` SET TAGS ('pii_business_glossary_term' = 'Billing Category');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `billing_category` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|professional|institutional');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `charge_amount` SET TAGS ('pii_business_glossary_term' = 'Procedure Charge Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_line_number` SET TAGS ('pii_business_glossary_term' = 'Claim Line Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_line_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `claim_status` SET TAGS ('pii_value_regex' = 'open|closed|denied|paid|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code (ICD‑10‑PCS / CPT / HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `code_system` SET TAGS ('pii_business_glossary_term' = 'Procedure Code System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `code_system` SET TAGS ('pii_value_regex' = 'ICD-10-PCS|CPT|HCPCS');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `diagnosis_codes` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Codes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `diagnosis_codes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `diagnosis_codes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `documentation_indicator` SET TAGS ('pii_business_glossary_term' = 'Documentation Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `documentation_indicator` SET TAGS ('pii_value_regex' = 'complete|partial|missing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis‑Related Group (DRG) Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `drg_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `drg_weight` SET TAGS ('pii_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `is_emergency` SET TAGS ('pii_business_glossary_term' = 'Emergency Procedure Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `is_outpatient` SET TAGS ('pii_business_glossary_term' = 'Outpatient Procedure Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `is_primary_procedure` SET TAGS ('pii_business_glossary_term' = 'Primary Procedure Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Procedure Laterality');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|none');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `modifier` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Procedure Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Procedure Notes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `prior_authorization_status` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `prior_authorization_status` SET TAGS ('pii_value_regex' = 'approved|denied|pending');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_date` SET TAGS ('pii_business_glossary_term' = 'Procedure Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_business_glossary_term' = 'Procedure Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_value_regex' = 'performed|scheduled|cancelled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `procedure_timestamp` SET TAGS ('pii_business_glossary_term' = 'Procedure Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `quality_measure_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `revenue_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_business_glossary_term' = 'Secondary Procedure Codes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `sequence` SET TAGS ('pii_business_glossary_term' = 'Procedure Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `service_location_type` SET TAGS ('pii_business_glossary_term' = 'Service Location Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `service_location_type` SET TAGS ('pii_value_regex' = 'hospital|clinic|outpatient_center|home');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `surgeon_name` SET TAGS ('pii_business_glossary_term' = 'Surgeon Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `units_of_service` SET TAGS ('pii_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('pii_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('pii_fhir_resource' = 'ExplanationOfBenefit.adjudication');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `adjudication_id` SET TAGS ('pii_business_glossary_term' = 'Adjudication ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `header_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `header_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Adjudicator ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `provider_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `provider_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_deductible_impact` SET TAGS ('pii_business_glossary_term' = 'Deductible Accumulator Impact');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_deductible_impact` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_deductible_impact` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_oop_impact` SET TAGS ('pii_business_glossary_term' = 'OOP Accumulator Impact');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_oop_impact` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `accumulator_oop_impact` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `adjudication_number` SET TAGS ('pii_business_glossary_term' = 'Adjudication Number (External Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `adjudication_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `adjudication_status` SET TAGS ('pii_business_glossary_term' = 'Adjudication Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `adjudication_status` SET TAGS ('pii_value_regex' = 'paid|denied|pended|suspended|voided');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `adjudication_timestamp` SET TAGS ('pii_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `admission_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount_method` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount Calculation Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `allowed_amount_method` SET TAGS ('pii_value_regex' = 'fee_schedule|mac|rbp|capitation|custom');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `auto_adjudication_flag` SET TAGS ('pii_business_glossary_term' = 'Auto-Adjudication Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `claim_type` SET TAGS ('pii_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `claim_type` SET TAGS ('pii_value_regex' = 'professional|institutional|dental|vision|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_adjusted_amount` SET TAGS ('pii_business_glossary_term' = 'COB Adjusted Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_adjusted_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_adjusted_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_processing_result` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits (COB) Processing Result');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `cob_processing_result` SET TAGS ('pii_value_regex' = 'primary|secondary|tertiary|none');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount Applied');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `deductible_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `deductible_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `duplicate_claim_flag` SET TAGS ('pii_business_glossary_term' = 'Duplicate Claim Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_bypass_reason` SET TAGS ('pii_business_glossary_term' = 'Edit Bypass Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_code` SET TAGS ('pii_business_glossary_term' = 'Edit Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_description` SET TAGS ('pii_business_glossary_term' = 'Edit Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_outcome` SET TAGS ('pii_business_glossary_term' = 'Edit Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_outcome` SET TAGS ('pii_value_regex' = 'pass|fail|bypass|override');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_override_authority` SET TAGS ('pii_business_glossary_term' = 'Edit Override Authority');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_override_flag` SET TAGS ('pii_business_glossary_term' = 'Edit Override Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `edit_timestamp` SET TAGS ('pii_business_glossary_term' = 'Edit Evaluation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `medical_necessity_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Necessity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `medical_necessity_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `medical_necessity_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `network_status` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|preferred|non_preferred');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `oop_amount` SET TAGS ('pii_business_glossary_term' = 'Out‑Of‑Pocket (OOP) Amount Applied');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `oop_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `oop_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `prior_authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `prior_authorization_status` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `prior_authorization_status` SET TAGS ('pii_value_regex' = 'approved|denied|pending|not_required');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `timeliness_flag` SET TAGS ('pii_business_glossary_term' = 'Timely Filing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_adjustment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_adjustment_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Total Charged Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_charge_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_charge_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_net_amount` SET TAGS ('pii_business_glossary_term' = 'Total Net Payable Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_net_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `total_net_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('pii_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('pii_fhir_resource' = 'ExplanationOfBenefit');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_id` SET TAGS ('pii_business_glossary_term' = 'Explanation of Benefits (EOB) ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Eob Claim Header Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Provider Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `allowed_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `allowed_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `appeal_rights_text` SET TAGS ('pii_business_glossary_term' = 'Appeal Rights Text');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `appeal_rights_version` SET TAGS ('pii_business_glossary_term' = 'Appeal Rights Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `billed_amount` SET TAGS ('pii_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `billed_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `billed_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `claim_icn` SET TAGS ('pii_business_glossary_term' = 'Claim Internal Control Number (ICN)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `cob_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'COB Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `cob_adjustment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `cob_adjustment_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `delivery_date` SET TAGS ('pii_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'mail|portal|edi');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `denial_reason_summary` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Summary');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'EOB Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `document_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_status` SET TAGS ('pii_business_glossary_term' = 'EOB Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_status` SET TAGS ('pii_value_regex' = 'generated|delivered|suppressed|error');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_type` SET TAGS ('pii_business_glossary_term' = 'EOB Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `eob_type` SET TAGS ('pii_value_regex' = 'member|provider');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `generation_timestamp` SET TAGS ('pii_business_glossary_term' = 'EOB Generation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `language_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Member Responsibility Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_type` SET TAGS ('pii_business_glossary_term' = 'Member Responsibility Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `member_responsibility_type` SET TAGS ('pii_value_regex' = 'deductible|copay|coinsurance|non_covered');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `plan_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Plan Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `plan_paid_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `plan_paid_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `provider_name` SET TAGS ('pii_business_glossary_term' = 'Provider Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `provider_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `provider_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `remark_codes` SET TAGS ('pii_business_glossary_term' = 'Remark Codes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `sbc_reference` SET TAGS ('pii_business_glossary_term' = 'SBC Reference');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `service_end_date` SET TAGS ('pii_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `service_start_date` SET TAGS ('pii_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `suppression_flag` SET TAGS ('pii_business_glossary_term' = 'EOB Suppression Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ALTER COLUMN `fhir_explanation_of_benefit_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('pii_subdomain' = 'recovery_management');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('pii_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Initiator ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `line_id` SET TAGS ('pii_business_glossary_term' = 'Adjustment Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjusted_amount` SET TAGS ('pii_business_glossary_term' = 'Adjusted Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('pii_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('pii_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|completed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('pii_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('pii_value_regex' = 'void|replacement|correction|retroactive');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_finding_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Reference');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_source` SET TAGS ('pii_business_glossary_term' = 'Audit Source');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_source` SET TAGS ('pii_value_regex' = 'internal|rac|oig|provider_self_disclosure');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'post_payment|pre_payment|clinical|coding|billing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `compliance_60_day_rule` SET TAGS ('pii_business_glossary_term' = 'CMS 60‑Day Rule Compliance');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `demand_lifecycle_stage` SET TAGS ('pii_business_glossary_term' = 'Demand Lifecycle Stage');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `demand_lifecycle_stage` SET TAGS ('pii_value_regex' = 'demand_created|demand_sent|demand_received|demand_resolved');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `adjustment_description` SET TAGS ('pii_business_glossary_term' = 'Adjustment Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `identifier` SET TAGS ('pii_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `initiator_role` SET TAGS ('pii_business_glossary_term' = 'Initiator Role');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `initiator_role` SET TAGS ('pii_value_regex' = 'claims_adjuster|auditor|provider|member|system');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `is_duplicate` SET TAGS ('pii_business_glossary_term' = 'Is Duplicate Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `is_fraud` SET TAGS ('pii_business_glossary_term' = 'Is Fraud Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `is_reversal` SET TAGS ('pii_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `is_void` SET TAGS ('pii_business_glossary_term' = 'Is Void Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `net_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Net Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `original_amount` SET TAGS ('pii_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `overpayment_indicator` SET TAGS ('pii_business_glossary_term' = 'Overpayment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `overpayment_type` SET TAGS ('pii_business_glossary_term' = 'Overpayment Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `overpayment_type` SET TAGS ('pii_value_regex' = 'duplicate|incorrect_rate|ineligible_member|billing_error|fraud');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `recovery_method` SET TAGS ('pii_business_glossary_term' = 'Recovery Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `recovery_method` SET TAGS ('pii_value_regex' = 'offset|check|installment|write_off');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `recovery_status` SET TAGS ('pii_business_glossary_term' = 'Recovery Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `recovery_status` SET TAGS ('pii_value_regex' = 'pending|in_process|completed|failed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `resolution_status` SET TAGS ('pii_value_regex' = 'open|closed|escalated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `sequence` SET TAGS ('pii_business_glossary_term' = 'Adjustment Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('pii_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_id` SET TAGS ('pii_business_glossary_term' = 'Denial Identifier (DENIAL_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Identifier (CLAIM_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `header_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `header_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Resolved By User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `line_id` SET TAGS ('pii_business_glossary_term' = 'Denial Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (MEMBER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `carc_code` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Reason Code (CARC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `carc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `clinical_criteria` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Code (InterQual/MCG)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_date` SET TAGS ('pii_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_number` SET TAGS ('pii_business_glossary_term' = 'Denial Number (DENIAL_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_status` SET TAGS ('pii_business_glossary_term' = 'Denial Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_status` SET TAGS ('pii_value_regex' = 'pending|reviewed|appealed|resolved|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('pii_business_glossary_term' = 'Denial Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('pii_value_regex' = 'clinical|administrative|technical|cob|timely_filing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denied_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Denied Adjustment Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denied_gross_amount` SET TAGS ('pii_business_glossary_term' = 'Denied Gross Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `denied_net_amount` SET TAGS ('pii_business_glossary_term' = 'Denied Net Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `letter_generated_flag` SET TAGS ('pii_business_glossary_term' = 'Denial Letter Generated Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `medical_necessity_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Necessity Determination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `medical_necessity_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `medical_necessity_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Denial Management Notes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `override_flag` SET TAGS ('pii_business_glossary_term' = 'Denial Override Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `override_reason` SET TAGS ('pii_business_glossary_term' = 'Denial Override Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `override_reason` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `override_reason` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `rac_code` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Remark Code (RARC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `rac_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `reason_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `reason_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Denial Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Denial Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|withdrawn|closed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `subtype` SET TAGS ('pii_business_glossary_term' = 'Denial Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('pii_subdomain' = 'recovery_management');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('pii_business_glossary_term' = 'Cob Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Cob Claim Header Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Processing User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `payer_claim_role_id` SET TAGS ('pii_business_glossary_term' = 'Primary Payer Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `claim_icn` SET TAGS ('pii_business_glossary_term' = 'Claim Internal Control Number (ICN)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `claim_line_count` SET TAGS ('pii_business_glossary_term' = 'Claim Line Count');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('pii_business_glossary_term' = 'COB Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('pii_value_regex' = 'pending|processed|error|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `crossover_claim_flag` SET TAGS ('pii_business_glossary_term' = 'Crossover Claim Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `is_duplicate` SET TAGS ('pii_business_glossary_term' = 'Duplicate Claim Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `is_manual_override` SET TAGS ('pii_business_glossary_term' = 'Manual Override Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `medicaid_crossover_indicator` SET TAGS ('pii_business_glossary_term' = 'Medicaid Crossover Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'COB Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('pii_value_regex' = 'standard|non_duplication|maintenance_of_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `msp_indicator` SET TAGS ('pii_business_glossary_term' = 'Medicare Secondary Payer (MSP) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `msp_type` SET TAGS ('pii_business_glossary_term' = 'MSP Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `msp_type` SET TAGS ('pii_value_regex' = 'full|partial');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `net_liability_amount` SET TAGS ('pii_business_glossary_term' = 'Net Liability After COB');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `other_insurance_type` SET TAGS ('pii_business_glossary_term' = 'Other Insurance Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `other_insurance_type` SET TAGS ('pii_value_regex' = 'employer_group|medicare|medicaid|auto|workers_comp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `primary_payer_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Payer Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `primary_payer_denial_reason` SET TAGS ('pii_business_glossary_term' = 'Primary Payer Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `primary_payer_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Payer Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `process_order` SET TAGS ('pii_business_glossary_term' = 'COB Processing Order');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `processed_timestamp` SET TAGS ('pii_business_glossary_term' = 'COB Processed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `processing_user_name` SET TAGS ('pii_business_glossary_term' = 'Processing User Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `processing_user_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `processing_user_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `secondary_payer_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Payer Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `secondary_payer_code` SET TAGS ('pii_business_glossary_term' = 'Secondary Payer Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `secondary_payer_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `secondary_payer_denial_reason` SET TAGS ('pii_business_glossary_term' = 'Secondary Payer Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `secondary_payer_name` SET TAGS ('pii_business_glossary_term' = 'Secondary Payer Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `secondary_payer_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Payer Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `total_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `total_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `total_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('pii_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('pii_fhir_resource' = 'PaymentReconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_id` SET TAGS ('pii_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `outcome_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Payment Claim Claim Header Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `header_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Payee Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `party_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `party_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Payment Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `batch_sequence` SET TAGS ('pii_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `carc_codes` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Reason Codes (CARC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `channel` SET TAGS ('pii_value_regex' = 'clearinghouse|direct|bank');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `check_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `clearinghouse_code` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `clearinghouse_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `cycle` SET TAGS ('pii_business_glossary_term' = 'Payment Cycle');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `cycle` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_description` SET TAGS ('pii_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_account_number` SET TAGS ('pii_business_glossary_term' = 'GL Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_posting_date` SET TAGS ('pii_business_glossary_term' = 'GL Posting Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_reference_number` SET TAGS ('pii_business_glossary_term' = 'GL Reference Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gl_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `is_reconciled` SET TAGS ('pii_business_glossary_term' = 'Is Reconciled Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `is_returned` SET TAGS ('pii_business_glossary_term' = 'Is Returned Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `is_voided` SET TAGS ('pii_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `method` SET TAGS ('pii_value_regex' = 'eft|check|virtual_card|capitation_offset');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `note` SET TAGS ('pii_business_glossary_term' = 'Payment Note');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payee_type` SET TAGS ('pii_business_glossary_term' = 'Payee Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payee_type` SET TAGS ('pii_value_regex' = 'provider|member|other');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_number` SET TAGS ('pii_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'issued|cleared|voided|returned|stopped');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'claim_payment|capitation|rebate|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `racr_codes` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Remark Codes (RARC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Payment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'reconciled|unreconciled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `returned_reason` SET TAGS ('pii_business_glossary_term' = 'Returned Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Payment Source');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `source` SET TAGS ('pii_value_regex' = 'internal|external');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `trace_number` SET TAGS ('pii_business_glossary_term' = 'Payment Trace Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `trace_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `trace_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `trace_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `transaction_control_number` SET TAGS ('pii_business_glossary_term' = '835 Transaction Control Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `transaction_control_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ALTER COLUMN `void_reason` SET TAGS ('pii_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_subdomain' = 'reserve_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_mvm_grouper' = 'core');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_mvm_priority' = 'critical');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_mvm_scope' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_scope' = 'mvm');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `ibnr_id` SET TAGS ('pii_business_glossary_term' = 'Ibnr Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `ibnr_id` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Actuary ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `employee_id` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `actuarial_method` SET TAGS ('pii_business_glossary_term' = 'Actuarial Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `actuarial_method` SET TAGS ('pii_value_regex' = 'Chain-Ladder|Bornhuetter-Ferguson');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `actuarial_method` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `completion_factor` SET TAGS ('pii_business_glossary_term' = 'Completion Factor');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `completion_factor` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `created_timestamp` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `currency_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `data_quality_score` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `ibnr_description` SET TAGS ('pii_business_glossary_term' = 'Reserve Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `ibnr_description` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `development_factor` SET TAGS ('pii_business_glossary_term' = 'Development Factor');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `development_factor` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_end_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_from` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_start_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `effective_until` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `estimated_ibnr_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated IBNR Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `estimated_ibnr_amount` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `ibnr_status` SET TAGS ('pii_business_glossary_term' = 'Reserve Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `ibnr_status` SET TAGS ('pii_value_regex' = 'draft|active|approved|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `ibnr_status` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `incurred_month` SET TAGS ('pii_business_glossary_term' = 'Incurred Month');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `incurred_month` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `is_active` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'Medical|Dental|Vision|Behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `line_of_business` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `mlr_numerator_allocation` SET TAGS ('pii_business_glossary_term' = 'MLR Numerator Allocation');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `mlr_numerator_allocation` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `paid_to_date_amount` SET TAGS ('pii_business_glossary_term' = 'Paid To Date Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `paid_to_date_amount` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `plan_type` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `prior_period_reserve_amount` SET TAGS ('pii_business_glossary_term' = 'Prior Period Reserve Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `prior_period_reserve_amount` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_created_at` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_source_system` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_status` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_updated_at` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `record_version` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `reserve_change_amount` SET TAGS ('pii_business_glossary_term' = 'Reserve Change Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `reserve_change_amount` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `reserve_period_month` SET TAGS ('pii_business_glossary_term' = 'Reserve Period Month');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `reserve_period_month` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `reserve_period_year` SET TAGS ('pii_business_glossary_term' = 'Reserve Period Year');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `reserve_period_year` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `reserve_run_date` SET TAGS ('pii_business_glossary_term' = 'Reserve Run Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `reserve_run_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `service_category` SET TAGS ('pii_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `service_category` SET TAGS ('pii_value_regex' = 'Inpatient|Outpatient|Professional|Pharmacy|Dental');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `service_category` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` SET TAGS ('pii_subdomain' = 'recovery_management');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `subrogation_id` SET TAGS ('pii_business_glossary_term' = 'Subrogation ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `accident_city` SET TAGS ('pii_business_glossary_term' = 'Accident City');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `accident_country` SET TAGS ('pii_business_glossary_term' = 'Accident Country');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `accident_date` SET TAGS ('pii_business_glossary_term' = 'Accident Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `accident_state_code` SET TAGS ('pii_business_glossary_term' = 'Accident State Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `accident_state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `demand_amount` SET TAGS ('pii_business_glossary_term' = 'Demand Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `demand_sent_date` SET TAGS ('pii_business_glossary_term' = 'Demand Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `gross_recovery_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Recovery Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `initiated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Subrogation Initiated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `is_lien_applied` SET TAGS ('pii_business_glossary_term' = 'Is Lien Applied');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `is_recovery_closed` SET TAGS ('pii_business_glossary_term' = 'Is Recovery Closed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `is_settlement_agreed` SET TAGS ('pii_business_glossary_term' = 'Is Settlement Agreed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `legal_fees_amount` SET TAGS ('pii_business_glossary_term' = 'Legal Fees Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `liability_type` SET TAGS ('pii_business_glossary_term' = 'Liability Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `liability_type` SET TAGS ('pii_value_regex' = 'primary|secondary|joint');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `lien_amount` SET TAGS ('pii_business_glossary_term' = 'Lien Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `lien_holder_name` SET TAGS ('pii_business_glossary_term' = 'Lien Holder Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `lien_holder_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `lien_holder_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `lien_status` SET TAGS ('pii_business_glossary_term' = 'Lien Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `lien_status` SET TAGS ('pii_value_regex' = 'pending|applied|released');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `negotiation_start_date` SET TAGS ('pii_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `net_recovery_amount` SET TAGS ('pii_business_glossary_term' = 'Net Recovery Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `recovery_method` SET TAGS ('pii_business_glossary_term' = 'Recovery Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `recovery_method` SET TAGS ('pii_value_regex' = 'direct|offset|court');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `recovery_notes` SET TAGS ('pii_business_glossary_term' = 'Recovery Notes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `reporting_state_code` SET TAGS ('pii_business_glossary_term' = 'Reporting State Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `reporting_state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `settlement_amount` SET TAGS ('pii_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `settlement_date` SET TAGS ('pii_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `subrogation_number` SET TAGS ('pii_business_glossary_term' = 'Subrogation Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `subrogation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `subrogation_status` SET TAGS ('pii_business_glossary_term' = 'Subrogation Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `subrogation_status` SET TAGS ('pii_value_regex' = 'identified|demand_sent|negotiating|settled|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `subrogation_type` SET TAGS ('pii_business_glossary_term' = 'Subrogation Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `subrogation_type` SET TAGS ('pii_value_regex' = 'auto|workers_comp|premises|other');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `third_party_insurer_code` SET TAGS ('pii_business_glossary_term' = 'Third‑Party Insurer ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `third_party_insurer_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` SET TAGS ('pii_subdomain' = 'recovery_management');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'Drg Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `drg_claim_header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `arithmetic_mean_los` SET TAGS ('pii_business_glossary_term' = 'Arithmetic Mean Length of Stay');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'DRG Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `assignment_status` SET TAGS ('pii_value_regex' = 'assigned|revised|rejected|finalized');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `base_rate_applied` SET TAGS ('pii_business_glossary_term' = 'Base Rate Applied');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `case_mix_index_contribution` SET TAGS ('pii_business_glossary_term' = 'Case Mix Index Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `cc_mcc_flag` SET TAGS ('pii_business_glossary_term' = 'Complication/Comorbidity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `cc_mcc_flag` SET TAGS ('pii_value_regex' = 'none|cc|mcc');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `drg_code` SET TAGS ('pii_value_regex' = '^d{3,4}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `drg_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `drg_description` SET TAGS ('pii_business_glossary_term' = 'DRG Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `drg_type` SET TAGS ('pii_business_glossary_term' = 'DRG Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `drg_type` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|post-acute');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `geometric_mean_los` SET TAGS ('pii_business_glossary_term' = 'Geometric Mean Length of Stay');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `grouper_method` SET TAGS ('pii_business_glossary_term' = 'Grouper Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `grouper_method` SET TAGS ('pii_value_regex' = 'MS-DRG|APR-DRG|IR-DRG');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `grouper_run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Grouper Run Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `grouper_software_version` SET TAGS ('pii_business_glossary_term' = 'Grouper Software Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `grouper_status` SET TAGS ('pii_business_glossary_term' = 'Grouper Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `grouper_status` SET TAGS ('pii_value_regex' = 'complete|pending|error');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `line_quantity` SET TAGS ('pii_business_glossary_term' = 'Line Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `line_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `line_sequence_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `major_diagnostic_category` SET TAGS ('pii_business_glossary_term' = 'Major Diagnostic Category (MDC)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `outlier_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Outlier Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `outlier_threshold` SET TAGS ('pii_business_glossary_term' = 'Outlier Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'DRG Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `payment_currency` SET TAGS ('pii_business_glossary_term' = 'Payment Currency');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `payment_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Principal Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_value_regex' = '^[A-TV-Z][0-9][0-9A-Z](.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_business_glossary_term' = 'Principal Procedure Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'DRG Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ALTER COLUMN `weight` SET TAGS ('pii_business_glossary_term' = 'DRG Relative Weight');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` SET TAGS ('pii_subdomain' = 'reserve_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `accumulator_id` SET TAGS ('pii_business_glossary_term' = 'Accumulator Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `accumulated_amount` SET TAGS ('pii_business_glossary_term' = 'Accumulated Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `accumulator_status` SET TAGS ('pii_business_glossary_term' = 'Accumulator Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `accumulator_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|pending|suspended|expired');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `accumulator_type` SET TAGS ('pii_business_glossary_term' = 'Accumulator Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `accumulator_type` SET TAGS ('pii_value_regex' = 'deductible|oop_max|visit_limit|rx_limit|hospital_stay|annual_max');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `benefit_category` SET TAGS ('pii_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `benefit_category` SET TAGS ('pii_value_regex' = 'medical|dental|vision|pharmacy|wellness|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `benefit_period_end` SET TAGS ('pii_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `benefit_period_start` SET TAGS ('pii_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `accumulator_code` SET TAGS ('pii_business_glossary_term' = 'Accumulator Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `accumulator_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `accumulator_description` SET TAGS ('pii_business_glossary_term' = 'Accumulator Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Accumulator Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `is_adjustment` SET TAGS ('pii_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `is_reversal` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `last_reset_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Reset Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `limit_amount` SET TAGS ('pii_business_glossary_term' = 'Benefit Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'individual|group|employer|government|commercial|medicare');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|preferred|standard|tier1|tier2');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `remaining_balance` SET TAGS ('pii_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` SET TAGS ('pii_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.plan.specificCost');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `adjudication_rate_id` SET TAGS ('pii_business_glossary_term' = 'Adjudication Rate ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `adjudication_rate_status` SET TAGS ('pii_business_glossary_term' = 'Rate Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `adjudication_rate_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `awp_percentage` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `adjudication_rate_description` SET TAGS ('pii_business_glossary_term' = 'Rate Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `geographic_cbsa` SET TAGS ('pii_business_glossary_term' = 'Core Based Statistical Area (CBSA) Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `geographic_county` SET TAGS ('pii_business_glossary_term' = 'Geographic County');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `geographic_state` SET TAGS ('pii_business_glossary_term' = 'Geographic State');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `geographic_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `mac_rate` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) Rate');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `medicare_fee_schedule_percent` SET TAGS ('pii_business_glossary_term' = 'Medicare Fee Schedule Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|preferred|standard|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `procedure_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$|^[A-Z0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `procedure_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `procedure_modifier` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `procedure_modifier` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{0,2}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `provider_specialty_code` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `provider_specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `provider_type` SET TAGS ('pii_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `provider_type` SET TAGS ('pii_value_regex' = 'physician|hospital|lab|pharmacy|clinic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `rate_source` SET TAGS ('pii_business_glossary_term' = 'Rate Source');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `rate_source` SET TAGS ('pii_value_regex' = 'CMS|Plan|Contract');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `rate_type` SET TAGS ('pii_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `rate_type` SET TAGS ('pii_value_regex' = 'procedure|drug|bundle|service');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `rvu_based_flag` SET TAGS ('pii_business_glossary_term' = 'RVU‑Based Calculation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `attachment_id` SET TAGS ('pii_business_glossary_term' = 'Attachment ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `line_id` SET TAGS ('pii_business_glossary_term' = 'Related Claim Line ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `parent_attachment_id` SET TAGS ('pii_business_glossary_term' = 'Parent Attachment Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `parent_attachment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Related Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `access_count` SET TAGS ('pii_business_glossary_term' = 'Access Count');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `attachment_status` SET TAGS ('pii_business_glossary_term' = 'Attachment Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `attachment_status` SET TAGS ('pii_value_regex' = 'pending|received|reviewed|rejected|approved|archived');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `checksum_sha256` SET TAGS ('pii_business_glossary_term' = 'SHA-256 Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `checksum_sha256` SET TAGS ('pii_value_regex' = '^[A-Fa-f0-9]{64}$');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|confidential|restricted');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `attachment_description` SET TAGS ('pii_business_glossary_term' = 'Attachment Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `document_category` SET TAGS ('pii_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `document_category` SET TAGS ('pii_value_regex' = 'medical_record|itemized_bill|operative_report|lab_result|prescription|authorization');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `document_subtype` SET TAGS ('pii_business_glossary_term' = 'Document Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `encryption_method` SET TAGS ('pii_business_glossary_term' = 'Encryption Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `encryption_method` SET TAGS ('pii_value_regex' = 'aes256|des|none');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `expiration_timestamp` SET TAGS ('pii_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `external_document_reference` SET TAGS ('pii_business_glossary_term' = 'External Document Identifier (DOC_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `file_name` SET TAGS ('pii_business_glossary_term' = 'File Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `file_type` SET TAGS ('pii_business_glossary_term' = 'File Type (MIME)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `is_encrypted` SET TAGS ('pii_business_glossary_term' = 'Encryption Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `is_original` SET TAGS ('pii_business_glossary_term' = 'Original Document Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `is_sensitive` SET TAGS ('pii_business_glossary_term' = 'Sensitive Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `last_access_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Attachment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `received_method` SET TAGS ('pii_business_glossary_term' = 'Reception Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `received_method` SET TAGS ('pii_value_regex' = 'portal|fax|mail|edi|email');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `retention_period_days` SET TAGS ('pii_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `source_system_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Reference');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `upload_timestamp` SET TAGS ('pii_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `virus_scan_result` SET TAGS ('pii_business_glossary_term' = 'Virus Scan Result');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `virus_scan_result` SET TAGS ('pii_value_regex' = 'clean|infected|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ALTER COLUMN `virus_scanned` SET TAGS ('pii_business_glossary_term' = 'Virus Scan Performed');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `status_event_id` SET TAGS ('pii_business_glossary_term' = 'Claim Status Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'User ID');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `parent_status_event_id` SET TAGS ('pii_business_glossary_term' = 'Parent Status Event Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `parent_status_event_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `audit_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Event Comments');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `event_source` SET TAGS ('pii_business_glossary_term' = 'Event Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `event_source` SET TAGS ('pii_value_regex' = 'EDI|CORE|PBM|UM|CAREMGMT|OTHER');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `is_manual` SET TAGS ('pii_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `previous_status_code` SET TAGS ('pii_business_glossary_term' = 'Previous Claim Status Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `previous_status_code` SET TAGS ('pii_value_regex' = 'received|pended|adjudicated|paid|denied|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `previous_status_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Status Transition Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Status Transition Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `status_code` SET TAGS ('pii_business_glossary_term' = 'Current Claim Status Code');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `status_code` SET TAGS ('pii_value_regex' = 'received|pended|adjudicated|paid|denied|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `status_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `user_role` SET TAGS ('pii_business_glossary_term' = 'User Role');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ALTER COLUMN `user_role` SET TAGS ('pii_value_regex' = 'system|operator|provider|member');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_subdomain' = 'reserve_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_ssot_source_domain' = 'claim');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_ssot_duplicate_of' = 'billing.payer');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_ssot_alias_of' = 'billing.payer');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_ssot_canonical' = 'billing.payer');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_ssot_master' = 'billing.payer');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_ssot_concept' = 'payer');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_rename_redirect_applied' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` SET TAGS ('pii_vreq_skip_P200' = 'skip');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payer_claim_role_id` SET TAGS ('pii_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payer_billing_role_id` SET TAGS ('pii_business_glossary_term' = 'Billing Payer Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payer_billing_role_id` SET TAGS ('pii_ssot_canonical' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `account_balance` SET TAGS ('pii_business_glossary_term' = 'Payer Account Balance');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `account_balance` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `account_balance` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `account_currency` SET TAGS ('pii_business_glossary_term' = 'Payer Account Currency');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Payer Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `account_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'Payer Account Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Payer Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Payer Address Line2');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `business_number` SET TAGS ('pii_business_glossary_term' = 'Payer Business Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `business_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `business_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `business_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Payer City');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contact_name` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contract_end_date` SET TAGS ('pii_business_glossary_term' = 'Payer Contract End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Payer Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contract_start_date` SET TAGS ('pii_business_glossary_term' = 'Payer Contract Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `contract_status` SET TAGS ('pii_business_glossary_term' = 'Payer Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Payer Country');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Payer Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Payer Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Payer Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `deleted_at` SET TAGS ('pii_business_glossary_term' = 'Payer Deleted At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `lei` SET TAGS ('pii_business_glossary_term' = 'Payer Lei');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `lei` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `lei` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `logo_url` SET TAGS ('pii_business_glossary_term' = 'Payer Logo Url');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Payer Notes');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payer_name` SET TAGS ('pii_business_glossary_term' = 'Payer Name');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payer_status` SET TAGS ('pii_business_glossary_term' = 'Payer Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payer_type` SET TAGS ('pii_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payment_cycle` SET TAGS ('pii_business_glossary_term' = 'Payer Payment Cycle');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payment_frequency` SET TAGS ('pii_business_glossary_term' = 'Payer Payment Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payer Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payer Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `rating` SET TAGS ('pii_business_glossary_term' = 'Payer Rating');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `rating_source` SET TAGS ('pii_business_glossary_term' = 'Payer Rating Source');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Payer Risk Category');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Payer Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'Payer State');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `tax_number` SET TAGS ('pii_business_glossary_term' = 'Payer Tax Number');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `tax_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `tax_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `tax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Payer Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `website` SET TAGS ('pii_business_glossary_term' = 'Payer Website');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `zip` SET TAGS ('pii_business_glossary_term' = 'Payer Zip');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `zip` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ALTER COLUMN `zip` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`claim_payer` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`claim_payer` SET TAGS ('pii_subdomain' = 'reserve_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`claim_payer` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`claim_payer` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
