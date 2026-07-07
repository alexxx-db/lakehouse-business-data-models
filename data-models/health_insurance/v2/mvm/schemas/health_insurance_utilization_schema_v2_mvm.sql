-- Schema for Domain: utilization | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`utilization` COMMENT 'Manages utilization management (UM) and prior authorization (PA) workflows — inpatient concurrent review, retrospective review, medical necessity determination, peer-to-peer processes, and UM turnaround time compliance. Owns PA requests, clinical criteria application (InterQual, MCG), authorization decisions, length-of-stay benchmarks, and denial reasons. Supports NCQA UM accreditation standards and state PA reform mandates. Source system: InterQual or MCG.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` (
    `pa_request_id` BIGINT COMMENT 'Unique identifier for the prior authorization request.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: PA requests are submitted for specific covered benefits. The benefit record defines authorization_required and authorization_type, enabling PA intake validation. Benefit-level PA volume reporting is a',
    `clinical_criteria_id` BIGINT COMMENT 'Identifier of the specific clinical rule applied.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Prior Authorization Request Volume Report groups requests by health plan to monitor utilization and cost.',
    `plan_election_id` BIGINT COMMENT 'Identifier of the health plan under which the member is covered.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Prior authorization adjudication requires knowing the exact policy in force: benefit limits, prior auth requirements, and cost-sharing rules are policy-specific. Regulatory turnaround-time compliance ',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member requesting the service.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Required for Prior Authorization request processing to link each request to the provider entity for reporting, compliance, and performance metrics.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network relevant to the request.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Facilities (hospitals, ASCs) submit PA requests directly for inpatient procedures and facility-based services, distinct from individual provider submissions. Linking to provider.facility enables facil',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: PA requests are evaluated against tier-specific prior authorization requirements (tier.prior_authorization_required_flag). The tier determines whether PA is required and what cost-share applies post-a',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Prior Authorization requests must verify the members active enrollment transaction to determine coverage and cost‑share, required for CMS PA reporting and claim adjudication.',
    `appeal_deadline_date` DATE COMMENT 'Final date by which an appeal must be filed.',
    `clinical_criteria_version` STRING COMMENT 'Version of the clinical criteria set applied to the request.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the data warehouse.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated amounts.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_maker_role` STRING COMMENT 'Professional role of the decision maker.. Valid values are `physician|nurse|clinical_reviewer|admin`',
    `denial_reason_code` STRING COMMENT 'Code representing the reason for denial, if applicable.',
    `diagnosis_code` STRING COMMENT 'Diagnosis code supporting the medical necessity of the request.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `estimated_adjustment_amount` DECIMAL(18,2) COMMENT 'Estimated adjustments (e.g., discounts, co-pays) applied to the gross amount.',
    `estimated_gross_amount` DECIMAL(18,2) COMMENT 'Initial estimated gross cost of the requested service before adjustments.',
    `estimated_net_amount` DECIMAL(18,2) COMMENT 'Final estimated net cost after adjustments.',
    `fhir_coverage_eligibility_request_resource_identifier` BIGINT COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: CoverageEligibilityRequest)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_appealable` BOOLEAN COMMENT 'Indicates whether the member may appeal a denial.',
    `is_duplicate_request` BOOLEAN COMMENT 'Indicates whether this request is a duplicate of an existing request.',
    `last_air_due_date` DATE COMMENT 'Due date for the most recent additional information request.',
    `last_air_received_date` DATE COMMENT 'Date the last additional information request was received.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional comments or notes related to the request.',
    `pa_request_status` STRING COMMENT 'Current lifecycle status of the prior authorization request.. Valid values are `pending|approved|denied|cancelled|in_review|closed`',
    `patient_age_at_request` STRING COMMENT 'Age of the member at the time of request submission.',
    `patient_gender` STRING COMMENT 'Gender of the member at the time of request.. Valid values are `male|female|other|unknown`',
    `prior_auth_decision_date` DATE COMMENT 'Date the prior authorization decision was made.',
    `quantity` STRING COMMENT 'Number of units or sessions requested.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `request_number` STRING COMMENT 'Business identifier assigned to the prior authorization request.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the prior authorization request was submitted.',
    `request_type` STRING COMMENT 'Urgency classification of the prior authorization request.. Valid values are `standard|expedited|urgent`',
    `service_code` STRING COMMENT 'Procedure, service, or drug code associated with the request.',
    `service_type` STRING COMMENT 'Category of the service being requested for prior authorization.. Valid values are `procedure|drug|admission|therapy`',
    `submission_channel` STRING COMMENT 'Channel through which the prior authorization request was submitted.. Valid values are `portal|fax|phone|edi_278`',
    `turnaround_time_days` STRING COMMENT 'Number of days from submission to final decision.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the request record.',
    CONSTRAINT pk_pa_request PRIMARY KEY(`pa_request_id`)
) COMMENT 'Core master entity representing a prior authorization (PA) request submitted by a provider or member for a proposed service, procedure, drug, or admission. Captures requesting provider NPI, member ID, requested service codes (CPT/HCPCS/ICD), urgency type (standard, expedited, urgent), submission channel (portal, fax, phone, EDI 278), submission timestamp, current PA status, and full status transition history. Also tracks additional information requests (AIRs) issued during review — information type requested, requested-from party, due date, received date, and TAT clock extension impact. Authoritative SSOT for all PA requests, their status lifecycle, and associated documentation requests.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` (
    `pa_decision_id` BIGINT COMMENT 'System-generated unique identifier for each prior authorization decision record.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: ACA and state regulations require health plans to report denial rates by benefit category. pa_decision is the authoritative denial record; direct benefit linkage enables regulatory denial rate reporti',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: A PA decision is made based on specific clinical criteria (InterQual/MCG). pa_decision currently stores clinical_criteria_set (STRING) and clinical_criteria_version (STRING) as denormalized references',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: PA Decision Summary Dashboard needs the plan context to calculate approval rates per plan.',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: pa_decision references the medical policy that governs the decision; child (decision) gets FK to parent (medical_policy).',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member/patient associated with the request.',
    `pa_request_id` BIGINT COMMENT 'Identifier of the prior‑authorization request to which this decision belongs.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Links PA decision to the originating provider for audit trails, regulatory reporting, and provider‑specific denial analysis.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Prior Authorization decisions require confirming the provider’s participation in a specific network; network_id enables compliance reporting and eligibility checks.',
    `amendment_indicator` STRING COMMENT 'Indicates if this record is the original decision or an amendment/reversal.. Valid values are `original|amended|reversal|override`',
    `appeal_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the member is eligible to appeal the decision.',
    `authorization_end_date` DATE COMMENT 'Effective end date of the approved authorization period.',
    `authorization_period_type` STRING COMMENT 'Specifies if the authorization period is a fixed date range or rolling.. Valid values are `fixed|rolling`',
    `authorization_quantity` STRING COMMENT 'Number of units (e.g., days, visits, doses) authorized.',
    `authorization_start_date` DATE COMMENT 'Effective start date of the approved authorization period.',
    `authorization_units` STRING COMMENT 'Unit of measure for the authorized quantity.. Valid values are `days|visits|doses|sessions`',
    `clinical_rationale` STRING COMMENT 'Free‑text explanation of the clinical reasoning behind the decision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the decision record was first inserted into the data lake.',
    `criteria_effective_date` DATE COMMENT 'Date on which the applied clinical criteria version became effective.',
    `criteria_met_flag` BOOLEAN COMMENT 'Indicates whether the request met all required clinical criteria (true) or not (false).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_date` TIMESTAMP COMMENT 'Timestamp when the prior authorization decision was rendered.',
    `decision_number` STRING COMMENT 'External business identifier assigned to the decision, often used in communications and audit trails.',
    `decision_status` STRING COMMENT 'Current lifecycle status of the decision record.. Valid values are `active|amended|reversed|overridden`',
    `decision_type` STRING COMMENT 'Classification of the decision outcome.. Valid values are `approved|denied|partially_approved|pended|withdrawn`',
    `denial_reason_category` STRING COMMENT 'High‑level category of the denial reason.. Valid values are `medical_need|administrative|benefit_exclusion|out_of_network|experimental`',
    `denial_reason_code` STRING COMMENT 'Standardized code representing the specific reason for denial.',
    `denial_regulatory_citation` STRING COMMENT 'Reference to the regulatory or policy citation supporting the denial.',
    `diagnosis_codes` STRING COMMENT 'Pipe‑separated list of ICD‑10 diagnosis codes supporting the medical necessity determination.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_coverage_eligibility_response_resource_identifier` BIGINT COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: CoverageEligibilityResponse)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_telehealth` BOOLEAN COMMENT 'True if the service requested is delivered via telehealth.',
    `is_urgent` BOOLEAN COMMENT 'True if the request was marked urgent.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `prior_auth_number` STRING COMMENT 'Business number assigned to the prior‑authorization request.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates compliance with NCQA UM accreditation or state PA regulations.',
    `reviewer_credentials` STRING COMMENT 'Professional credentials of the reviewer (e.g., MD, RN, PharmD, NP).. Valid values are `MD|RN|PharmD|NP`',
    `reviewer_npi` STRING COMMENT 'National Provider Identifier of the clinician or reviewer who rendered the decision.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the decision record.',
    CONSTRAINT pk_pa_decision PRIMARY KEY(`pa_decision_id`)
) COMMENT 'Transactional record capturing the authorization decision and underlying medical necessity determination rendered on a PA request. Stores decision date, decision type (approved, denied, partially approved, pended, withdrawn), clinical criteria applied (InterQual/MCG criteria set, version, effective date), criteria met/not met flag, clinical rationale narrative, ICD diagnosis codes supporting the determination, deciding reviewer NPI and credentials (MD, RN, PharmD), denial reason code and category (medical necessity, administrative, benefit exclusion, out-of-network, experimental/investigational), denial regulatory citation, appeal eligibility flag, and effective authorization period (start/end dates). Each PA request may have one or more decision records reflecting amendments, P2P reversals, or appeal overrides. Serves as the single evidentiary record for NCQA audits, state DOI market conduct exams, and denial defense.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` (
    `auth_service_line_id` BIGINT COMMENT 'System-generated unique identifier for each line item within a prior authorization request.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Each authorized service line specifies the facility where the service is authorized to be performed. Linking to provider.facility enables in-network facility verification, claims adjudication matching',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Each authorized service line maps to a specific plan benefit for coverage determination and cost-sharing calculation. Benefit-level authorization reporting (approval rates by benefit category) is a co',
    `clinical_criteria_id` BIGINT COMMENT 'Identifier of the specific clinical rule set (InterQual/MCG) applied to this line.',
    `cost_share_rule_id` BIGINT COMMENT 'Foreign key linking to plan.cost_share_rule. Business justification: Authorized service lines require cost-share rule application to calculate member liability (copay, coinsurance, deductible) at the time of authorization. Member financial counseling and pre-service co',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Authorization Service Line Cost Tracking per plan supports financial analysis and rate setting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member for whom the service is authorized.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: auth_service_line captures line-item detail for each service authorized within a PA request. The authorization of each service line is governed by a specific PA decision. auth_service_line already has',
    `pa_request_id` BIGINT COMMENT 'Identifier of the parent prior authorization request to which this service line belongs.',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: Each authorized service line is rendered under a specific PAR agreement governing reimbursement methodology and contracted rates. Linking auth_service_line to par_agreement enables contract compliance',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Associates each authorized service line with the ordering provider, enabling utilization analytics and provider reimbursement validation.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Authorized service lines are approved at a specific network tier that governs cost-share differentials (coinsurance, copay) and prior auth requirements. The authorized_price on auth_service_line is ti',
    `authorization_status` STRING COMMENT 'Current status of the service line within the prior authorization workflow.. Valid values are `approved|partially_approved|denied|pending|revoked`',
    `authorized_end_date` DATE COMMENT 'Expiration date after which the authorization is no longer valid.',
    `authorized_price` DECIMAL(18,2) COMMENT 'Maximum reimbursable amount per unit for the authorized service.',
    `authorized_quantity` DECIMAL(18,2) COMMENT 'Number of units of the service or product approved for the member.',
    `authorized_start_date` DATE COMMENT 'Effective date when the authorized service may begin.',
    `clinical_criteria_version` STRING COMMENT 'Version of the clinical criteria used for medical necessity determination.',
    `cpt_code` STRING COMMENT 'Standard CPT code representing the clinical service or procedure authorized.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the service line record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the authorized price.. Valid values are `USD|CAD|EUR`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date‑time when the authorization decision for this line was made.',
    `denial_reason` STRING COMMENT 'Explanation code or text why the service line was denied or partially approved.',
    `diagnosis_icd_code` STRING COMMENT 'ICD code linking the authorized service to the clinical diagnosis supporting medical necessity.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim.item)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hcpcs_code` STRING COMMENT 'HCPCS code (Level II) for services, supplies, or drugs not covered by CPT.. Valid values are `^[A-Z][0-9]{4}$`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_emergency` BOOLEAN COMMENT 'True if the authorized service is classified as an emergency.',
    `is_experimental` BOOLEAN COMMENT 'True if the service is considered experimental or investigational.',
    `is_partial_approval` BOOLEAN COMMENT 'Indicates whether only a portion of the requested service quantity was approved.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the prior authorization request.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions from the reviewer.',
    `place_of_service` STRING COMMENT 'Location type where the service is to be rendered.. Valid values are `office|hospital|clinic|home|telehealth`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date‑time when the prior authorization request containing this line was submitted.',
    `service_category` STRING COMMENT 'Broad classification of the authorized service (e.g., inpatient, outpatient, DME, pharmacy).. Valid values are `inpatient|outpatient|dme|pharmacy|behavioral_health|telehealth`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the authorized quantity (e.g., tablets, sessions, days).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the service line record.',
    CONSTRAINT pk_auth_service_line PRIMARY KEY(`auth_service_line_id`)
) COMMENT 'Line-item detail for each service, procedure, or drug authorized within a PA request. Captures CPT/HCPCS code, ICD diagnosis code, authorized quantity, authorized units of service, service category (inpatient, outpatient, DME, pharmacy, behavioral health), place of service, authorized facility NPI, and approved date range. Supports partial approvals where only a subset of requested services are authorized.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` (
    `concurrent_review_id` BIGINT COMMENT 'System-generated unique identifier for the concurrent review record.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to the member for this episode.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Concurrent Review Utilization Management reports require linking each review to the members health plan.',
    `inpatient_admission_id` BIGINT COMMENT 'Identifier of the inpatient admission linked to this review.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose stay is under review.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: concurrent_review manages the ongoing inpatient UM review process. Each concurrent review episode results in or references a PA decision (approval of continued stay, denial, or discharge recommendatio',
    `pa_request_id` BIGINT COMMENT 'Identifier of the originating prior‑authorization request.',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Concurrent inpatient review applies length-of-stay benchmarks and post-acute benefit rules governed by the members plan election. Reviewers must reference the plan election to determine authorized da',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Concurrent review findings (discharge barriers, post-acute services, readmission risk) must be recorded against the members active care plan. Discharge planners update care plan goals based on review',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Connects concurrent review records to the admitting provider for LOS benchmarking and clinical oversight reporting.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Concurrent review decisions — approved LOS, authorized post-acute services, discharge destination — are network-specific. The network determines which post-acute facilities are in-network and which LO',
    `um_case_id` BIGINT COMMENT 'Identifier of the overarching UM case that this review belongs to.',
    `actual_discharge_date` DATE COMMENT 'Date the member actually left the hospital.',
    `admission_date` DATE COMMENT 'Date the member was admitted to the hospital.',
    `approved_length_of_stay` STRING COMMENT 'Maximum number of days approved for continued stay based on the review.',
    `authorized_post_acute_service` STRING COMMENT 'Post‑acute care service(s) approved during the review (e.g., physical therapy, home health).',
    `benchmark_source` STRING COMMENT 'Source of the LOS benchmark values.. Valid values are `cms|milliman|plan_actuarial`',
    `benchmark_source_detail` STRING COMMENT 'Free‑text description of the benchmark source (e.g., specific CMS report or Milliman model).',
    `clinical_reviewer_npi` STRING COMMENT 'NPI of the clinician performing the review.',
    `concurrent_review_status` STRING COMMENT 'Current state of the review workflow.. Valid values are `pending|in_progress|approved|denied|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `criteria_version` STRING COMMENT 'Version of InterQual or MCG criteria applied.',
    `current_length_of_stay` STRING COMMENT 'Number of days the member has been hospitalized to date.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `discharge_barriers` STRING COMMENT 'Identified obstacles preventing timely discharge (e.g., equipment, placement).',
    `discharge_destination` STRING COMMENT 'Intended location after hospital discharge.. Valid values are `home|snf|ltac|home_health|hospice`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'True if the review is flagged as critical due to high acuity or risk.',
    `justification` STRING COMMENT 'Narrative explanation for why continued stay is medically necessary.',
    `los_benchmark_mean` DECIMAL(18,2) COMMENT 'Average LOS for the DRG or service line used as a benchmark.',
    `los_benchmark_outlier_threshold` DECIMAL(18,2) COMMENT 'Threshold beyond which the stay is considered an outlier.',
    `los_benchmark_target` DECIMAL(18,2) COMMENT 'Plan‑specific target LOS for the case.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_review_date` DATE COMMENT 'Scheduled date for the subsequent concurrent review.',
    `planned_discharge_date` DATE COMMENT 'Projected date for member discharge as determined by the reviewer.',
    `readmission_risk_category` STRING COMMENT 'Risk tier derived from the readmission risk score.. Valid values are `low|medium|high`',
    `readmission_risk_score` DECIMAL(18,2) COMMENT 'Predictive score indicating likelihood of readmission within 30 days.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `review_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the review was completed or closed.',
    `review_notes` STRING COMMENT 'Additional free‑text comments entered by the reviewer.',
    `review_number` STRING COMMENT 'Human‑readable unique code assigned to the review for tracking and communication.',
    `review_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the concurrent review was initiated.',
    `review_type` STRING COMMENT 'Specifies whether the review is concurrent (ongoing) or retrospective.. Valid values are `concurrent|retrospective`',
    `social_work_involved` BOOLEAN COMMENT 'Indicates whether a social worker was consulted for discharge planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_concurrent_review PRIMARY KEY(`concurrent_review_id`)
) COMMENT 'Manages inpatient concurrent review records for admitted members — the ongoing UM review process evaluating continued medical necessity during a hospital stay. Captures admission date, current and approved length of stay (LOS), LOS benchmarks by DRG (geometric/arithmetic mean LOS, plan-specific target, outlier threshold, benchmark source — CMS, Milliman, plan actuarial), next review date, clinical reviewer NPI, InterQual/MCG criteria version applied, continued stay justification. Includes integrated discharge planning: planned discharge date, discharge destination (home, SNF, LTAC, home health, hospice), post-acute services authorized, barriers to discharge, social work involvement, care coordinator assigned, actual discharge date, and readmission risk score. Links to the originating PA request, UM case, and inpatient admission.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` (
    `um_case_id` BIGINT COMMENT 'System-generated unique identifier for the UM case.',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.care_coordinator. Business justification: Case Management Process assigns a care coordinator to each utilization case; linking enables case‑to‑coordinator reporting and workload tracking.',
    `event_id` BIGINT COMMENT 'Foreign key linking to enrollment.event. Business justification: Enrollment events such as terminations, plan changes, or COBRA elections directly trigger UM case status changes — active cases must be resolved or transferred when coverage ends. Compliance reporting',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: UM Case Management Dashboard aggregates cases by health plan to monitor utilization trends.',
    `inpatient_admission_id` BIGINT COMMENT 'Foreign key linking to utilization.inpatient_admission. Business justification: um_case is the overarching UM workflow container. For inpatient UM cases, the case is directly associated with a specific inpatient admission. While the relationship is navigable via concurrent_review',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the case.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: UM case management is explicitly risk-stratified: case complexity scoring, resource assignment, and prioritization are driven by the members RAF score and HCC count. Case managers reference the activ',
    `member_risk_tier_id` BIGINT COMMENT 'Foreign key linking to care.member_risk_tier. Business justification: UM case prioritization, assignment, and intensity of management are driven by the members risk tier. Case managers use risk tier to determine intervention level. Population health reports on case man',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: um_case is the overarching UM workflow container and currently stores prior_authorization_decision_date, prior_authorization_number, and prior_authorization_status as denormalized PA decision attribut',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: um_case may be initiated by a PA request; child (um_case) gets FK to parent (pa_request).',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: UM case management applies benefit rules, authorization thresholds, and network requirements specific to the members active plan election. Case managers and compliance reports require direct linkage ',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Case Management Dashboard needs to reference the members care plan to align interventions and report case outcomes against the plan.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider who rendered the service under review.',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: UM cases are opened under specific disease management or complex case management programs (e.g., oncology, cardiac). Program-level reporting on case volume, outcomes, and cost requires this direct lin',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Case management reports attribute each case to the primary provider’s network for network adequacy analysis and cost allocation.',
    `appeal_indicator` BOOLEAN COMMENT 'True if the case has been appealed.',
    `assigned_nurse_name` STRING COMMENT 'Full name of the UM nurse or case manager handling the case.',
    `case_close_date` DATE COMMENT 'Date the UM case was closed or completed; null if still open.',
    `case_complexity_score` DECIMAL(18,2) COMMENT '',
    `case_number` STRING COMMENT 'Business-visible case number used for tracking and communication.',
    `case_open_date` DATE COMMENT 'Date the UM case was opened and became active.',
    `case_priority` STRING COMMENT 'Priority level assigned to the case for workload management.. Valid values are `high|medium|low`',
    `case_severity` STRING COMMENT 'Severity rating reflecting clinical urgency and complexity.. Valid values are `critical|moderate|minor`',
    `case_status` STRING COMMENT 'Current lifecycle status of the UM case.. Valid values are `open|closed|in_review|denied|approved|pending`',
    `case_type` STRING COMMENT 'Category of the case based on care setting or service type.. Valid values are `inpatient|outpatient|behavioral|dme|pharmacy|other`',
    `clinical_criteria_set` STRING COMMENT 'Source set of clinical criteria applied (InterQual or MCG).. Valid values are `InterQual|MCG`',
    `clinical_criteria_version` STRING COMMENT 'Version identifier of the clinical criteria set used for the case.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the case meets NCQA UM accreditation requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the UM case record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason_code` STRING COMMENT 'Code indicating why a prior authorization or claim was denied.',
    `denial_reason_description` STRING COMMENT 'Textual explanation of the denial reason.',
    `disposition_code` STRING COMMENT 'Standard code representing the final outcome of the case.',
    `disposition_description` STRING COMMENT 'Human‑readable description of the case outcome.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Task)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `length_of_stay_actual` STRING COMMENT 'Observed length of stay for the episode, expressed in days.',
    `length_of_stay_target` STRING COMMENT 'Planned maximum length of stay for the episode, expressed in days.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑text field for clinical or administrative comments.',
    `primary_diagnosis_code` STRING COMMENT 'ICD code representing the principal diagnosis driving the case.',
    `primary_diagnosis_description` STRING COMMENT 'Text description of the principal diagnosis.',
    `primary_provider_npi` STRING COMMENT 'National Provider Identifier of the primary provider.',
    `priority_level_code` STRING COMMENT '',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `turnaround_time_days` STRING COMMENT 'Number of days from case open to final disposition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the UM case record.',
    `urgency_code` STRING COMMENT '',
    `urgency_flag` BOOLEAN COMMENT 'True if the case requires expedited review per clinical criteria.',
    CONSTRAINT pk_um_case PRIMARY KEY(`um_case_id`)
) COMMENT 'Master entity representing a utilization management (UM) case — the overarching workflow container grouping all UM activities (PA requests, concurrent reviews, retrospective reviews, P2P reviews, appeals) for a single member episode of care. Captures case type (inpatient, outpatient, behavioral health, DME, pharmacy), case open/close dates, assigned UM nurse or case manager, episode of care identifier, primary diagnosis, and case disposition. Enables end-to-end UM workflow tracking, workload management, and NCQA UM accreditation reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` (
    `inpatient_admission_id` BIGINT COMMENT 'System-generated unique identifier for the inpatient admission record.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: The attending physician on an inpatient admission is a distinct role from the PA-requesting provider. Credentialing validation, network participation verification, quality reporting (HEDIS, CMS), and ',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Inpatient admissions are covered under specific inpatient benefits that define coinsurance rates, prior auth requirements, and coverage limits. Benefit-level inpatient utilization reporting (admission',
    `clinical_criteria_id` BIGINT COMMENT 'Identifier of the specific clinical rule used for concurrent review.',
    `cost_share_rule_id` BIGINT COMMENT 'Foreign key linking to plan.cost_share_rule. Business justification: Inpatient admissions require cost-share rule application to calculate member financial liability (deductible, coinsurance per admission). Pre-admission financial counseling and post-discharge EOB gene',
    `eligibility_verification_id` BIGINT COMMENT 'Foreign key linking to enrollment.eligibility_verification. Business justification: At hospital admission, real-time eligibility verification is performed to confirm active coverage before authorizing the stay. The admission record must reference the eligibility verification result u',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Inpatient admissions occur at a specific facility. Linking to provider.facility enables network adequacy reporting, accreditation verification, cost benchmarking by facility type, and claims adjudicat',
    `grace_period_id` BIGINT COMMENT 'Foreign key linking to billing.grace_period. Business justification: ACA grace period rules require plans to pend inpatient claims in months 2-3 of non-payment. Linking inpatient_admission to grace_period enables tracking of admissions at risk of retroactive terminatio',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Inpatient Admission Utilization reports are generated per health plan for network adequacy analysis.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the insured member associated with the admission.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: An inpatient admission subject to UM review requires prior authorization. inpatient_admission currently stores authorization_number (STRING) as a denormalized reference to the PA. Adding pa_request_id',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Inpatient admission authorization requires validating the members active plan election to apply correct benefit limits, cost-sharing, and network rules. UM staff and claims adjudicators routinely ref',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Discharge planning and post-acute care coordination require linking an inpatient admission directly to the governing care plan. Case managers and discharge planners use this link to update care plan g',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Inpatient admission authorization, DRG-based payment, and length-of-stay benchmarking are governed by the members active policy (deductible, out-of-pocket max, coverage limits). Claims adjudication a',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Inpatient admissions are reviewed against the specific provider network to determine in-network vs. out-of-network benefit status, concurrent review routing, and LOS benchmark applicability. UM analys',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Final cost incurred for the admission after discharge.',
    `actual_los_days` STRING COMMENT 'Number of days the member actually stayed in the facility.',
    `admission_date` DATE COMMENT 'Date the member was admitted to the facility.',
    `admission_number` STRING COMMENT 'Business identifier assigned to the admission by the health plan.',
    `admission_status` STRING COMMENT 'Current lifecycle status of the admission.. Valid values are `admitted|discharged|cancelled|transferred`',
    `admission_type` STRING COMMENT 'Classification of the admission based on urgency.. Valid values are `elective|urgent|emergent|other`',
    `clinical_criteria_version` STRING COMMENT 'Version of the clinical criteria set (e.g., InterQual v2023) applied to the admission.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the admission record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason_code` STRING COMMENT 'Standardized code representing why the admission was denied.',
    `denial_reason_description` STRING COMMENT 'Narrative description of the denial reason.',
    `discharge_date` DATE COMMENT 'Date the member was discharged from the facility.',
    `discharge_disposition` STRING COMMENT 'Post‑discharge destination of the member.. Valid values are `home|snf|rehab|expired|other`',
    `drg_code` STRING COMMENT 'DRG assignment for the admission used for payment and benchmarking.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expected_cost_amount` DECIMAL(18,2) COMMENT 'Projected cost of the admission before services are rendered.',
    `expected_los_days` STRING COMMENT 'Projected number of days the member is expected to stay, based on clinical criteria.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Encounter)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical_care` BOOLEAN COMMENT 'Indicates whether the admission involved critical care services.',
    `is_readmission` BOOLEAN COMMENT 'True if the admission is a readmission within the defined look‑back period.',
    `los_benchmark_met_flag` BOOLEAN COMMENT 'Indicates whether actual LOS met the benchmark target.',
    `los_target_days` STRING COMMENT 'Benchmark target days for LOS based on plan and diagnosis.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payer_authorization_status` STRING COMMENT 'Current status of the payers prior‑authorization for the admission.. Valid values are `authorized|pending|denied|not_required`',
    `primary_diagnosis_code` STRING COMMENT 'ICD code representing the principal diagnosis for the admission.',
    `readmission_within_30_days` BOOLEAN COMMENT 'True if the admission occurs within 30 days of a prior discharge.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `review_decision` STRING COMMENT 'Outcome of the utilization management review.. Valid values are `approved|denied|partial|pending`',
    `review_decision_date` DATE COMMENT 'Date the UM reviewer rendered a decision.',
    `review_status` STRING COMMENT 'Current status of the utilization management review.. Valid values are `pending|completed|escalated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the admission record.',
    CONSTRAINT pk_inpatient_admission PRIMARY KEY(`inpatient_admission_id`)
) COMMENT 'UM-managed inpatient admission record for admissions subject to concurrent review. Captures admitting facility NPI, admitting physician NPI, admission date, admission type (elective, urgent, emergent), primary admitting diagnosis (ICD), DRG assignment, expected LOS, actual discharge date, discharge disposition (home, SNF, rehab, expired), and payer authorization status. Serves as the anchor for concurrent review workflows and LOS benchmark comparisons. Distinct from the claim domains institutional claim — this is the clinical/UM view of the admission, not the billing view.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` (
    `medical_policy_id` BIGINT COMMENT 'System-generated unique identifier for the medical policy record.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Medical policies govern coverage decisions for specific plan benefits. When a benefit is modified (e.g., coverage type changes), the associated medical policy must be reviewed. NCQA UM accreditation r',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Medical Policy Applicability Matrix links each policy to the plans it governs for compliance reporting.',
    `parent_medical_policy_id` BIGINT COMMENT 'Self-referencing FK on medical_policy (parent_medical_policy_id)',
    `applicable_cpt_codes` STRING COMMENT 'Comma‑separated list of CPT procedure codes covered under the policy.',
    `applicable_hcpcs_codes` STRING COMMENT 'Comma‑separated list of HCPCS codes (including drugs) covered under the policy.',
    `clinical_category` STRING COMMENT 'High‑level clinical grouping (e.g., cardiology, orthopedics) to which the policy applies.',
    `clinical_criteria_source` STRING COMMENT 'Origin of the clinical criteria used in the policy.. Valid values are `interqual|mcg|internal`',
    `clinical_criteria_version` STRING COMMENT 'Version identifier of the clinical criteria set applied.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the policy with respect to external regulations.. Valid values are `compliant|non‑compliant|pending|exempt`',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Monetary cap applied to the total covered amount for the policy period.',
    `coverage_limit_currency` STRING COMMENT 'Three‑letter ISO currency code for the coverage limit amount.',
    `coverage_limit_units` STRING COMMENT 'Unit of measure for the coverage limit (e.g., visits, days).. Valid values are `visits|days|doses|sessions|procedures`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date on which the policy becomes binding for members.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date on which the policy ceases to be binding; null for open‑ended policies.',
    `evidence_grade_code` STRING COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_emergency_covered` BOOLEAN COMMENT 'Indicates whether emergency services are covered without prior authorization.',
    `is_exempt` BOOLEAN COMMENT 'True if the policy includes exemptions for specific services or member groups.',
    `is_experimental_covered` BOOLEAN COMMENT 'True if experimental or investigational services are permitted under the policy.',
    `is_prior_auth_required` BOOLEAN COMMENT 'Indicates whether a prior authorization must be obtained for services covered by this policy.',
    `is_telehealth_covered` BOOLEAN COMMENT 'Indicates whether telehealth services are covered under the policy.',
    `last_reviewed_by` STRING COMMENT 'Identifier of the user who performed the most recent policy review.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy was last reviewed for clinical or regulatory updates.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_policy_status` STRING COMMENT 'Current lifecycle state of the policy.. Valid values are `active|inactive|suspended|pending|draft|terminated`',
    `ncqa_aligned_flag` BOOLEAN COMMENT '',
    `notes` STRING COMMENT 'Free‑form text for additional comments, special considerations, or audit remarks.',
    `policy_effective_date` DATE COMMENT '',
    `policy_name` STRING COMMENT 'Human‑readable name of the policy for reporting and UI display.',
    `policy_number` STRING COMMENT 'External business identifier assigned to the policy, used in member communications and claim adjudication.',
    `policy_review_date` DATE COMMENT '',
    `policy_type` STRING COMMENT 'Category of the policy indicating the primary clinical domain it governs.. Valid values are `medical|surgical|behavioral|pharmacy|diagnostic`',
    `prior_auth_approval_timeframe_days` STRING COMMENT 'Maximum number of calendar days allowed to approve a prior authorization request.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Citation to the regulatory rule or guideline that mandates this policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the policy record.',
    `version_effective_date` DATE COMMENT 'Date when this version of the policy became effective.',
    `version_expiration_date` DATE COMMENT 'Date when this version of the policy was superseded or retired.',
    `version_number` STRING COMMENT 'Sequential version identifier for policy revisions.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the policy record.',
    CONSTRAINT pk_medical_policy PRIMARY KEY(`medical_policy_id`)
) COMMENT 'Master reference for medical policies and clinical criteria used in utilization management decisions — including medical necessity criteria, clinical guidelines, evidence-based medicine references, and policy effective dates. Captures policy ID, policy name, clinical category, applicable CPT/HCPCS codes, review criteria source (InterQual, MCG, internal), and version history.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` (
    `clinical_criteria_id` BIGINT COMMENT 'Primary key for clinical_criteria',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Clinical criteria are defined for specific covered benefits (e.g., MRI criteria apply to imaging benefit, bariatric criteria apply to surgical benefit). Benefit-specific criteria management ensures cr',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: NCQA/URAC accreditation requires tracing clinical criteria to the specific health plan whose UM program uses them. Every other utilization product links to health_plan; clinical_criteria is the only o',
    `medical_policy_id` BIGINT COMMENT 'add column medical_policy_id (BIGINT) with FK to utilization.medical_policy.medical_policy_id - clinical criteria implement medical policies',
    `parent_clinical_criteria_id` BIGINT COMMENT 'Self-referencing FK on clinical_criteria (parent_clinical_criteria_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `criteria_category` STRING COMMENT 'Broad category indicating the clinical setting or context of the criteria.',
    `criteria_code` STRING COMMENT 'Unique code assigned to the clinical criteria, used for lookup and integration.',
    `criteria_description` STRING COMMENT 'Detailed description of the clinical criteria, including its purpose and application.',
    `criteria_detail` STRING COMMENT 'Textual or structured detail of the rule or logic that defines the criteria.',
    `criteria_effective_date` DATE COMMENT 'Date when the clinical criteria becomes effective and applicable.',
    `criteria_expiration_date` DATE COMMENT 'Date when the clinical criteria is no longer valid or applicable.',
    `criteria_limit_unit` STRING COMMENT 'Unit of measurement for the limit value (e.g., days, dollars).',
    `criteria_limit_value` DECIMAL(18,2) COMMENT 'Numeric limit value used in the criteria rule (e.g., maximum allowed).',
    `criteria_name` STRING COMMENT 'Human-readable name of the clinical criteria.',
    `criteria_notes` STRING COMMENT 'Additional notes or comments about the clinical criteria.',
    `criteria_reference` STRING COMMENT 'Reference to external standard or guideline that the criteria aligns with.',
    `criteria_rule_expression` STRING COMMENT 'Formal expression or logic that defines how the criteria is evaluated.',
    `criteria_source` STRING COMMENT 'Originating system or authority that defines the clinical criteria.',
    `criteria_status` STRING COMMENT 'Current lifecycle status of the clinical criteria.',
    `criteria_subcategory` STRING COMMENT 'More specific classification within the category to refine the criteria context.',
    `criteria_threshold_unit` STRING COMMENT 'Unit of measurement for the threshold value (e.g., days, dollars).',
    `criteria_threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value used in the criteria rule (e.g., maximum days, minimum cost).',
    `criteria_type` STRING COMMENT 'Category of the clinical criteria indicating the type of clinical element it applies to.',
    `criteria_version` STRING COMMENT 'Version identifier of the clinical criteria to track updates and revisions.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Current status of the record for data lifecycle management.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated in the system.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_clinical_criteria PRIMARY KEY(`clinical_criteria_id`)
) COMMENT 'Master reference table for clinical_criteria. Referenced by clinical_criteria_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_parent_medical_policy_id` FOREIGN KEY (`parent_medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ADD CONSTRAINT `fk_utilization_clinical_criteria_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ADD CONSTRAINT `fk_utilization_clinical_criteria_parent_clinical_criteria_id` FOREIGN KEY (`parent_clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`utilization` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`utilization` SET TAGS ('dbx_domain' = 'utilization');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('dbx_subdomain' = 'authorization_management');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request Identifier (PA Request ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Identifier (Clinical Criteria ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Member Plan Identifier (Plan ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Identifier (Network ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date (Appeal Deadline)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version Used (Clinical Criteria Version)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code for Estimated Amounts (Currency Code)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `decision_maker_role` SET TAGS ('dbx_business_glossary_term' = 'Role of Decision Maker (Decision Maker Role)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `decision_maker_role` SET TAGS ('dbx_value_regex' = 'physician|nurse|clinical_reviewer|admin');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code (Denial Reason)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Associated Diagnosis Code (ICD Diagnosis Code)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `estimated_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Adjustment Amount (Estimated Adjustment)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `estimated_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Cost (Estimated Gross Amount)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `estimated_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Cost (Estimated Net Amount)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `is_appealable` SET TAGS ('dbx_business_glossary_term' = 'Flag Indicating if Request is Appealable (Appealable Flag)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `is_duplicate_request` SET TAGS ('dbx_business_glossary_term' = 'Flag Indicating Duplicate Prior Authorization Request (Duplicate Flag)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `last_air_due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date of Last Additional Information Request (Last AIR Due Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `last_air_received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date of Last Additional Information Request (Last AIR Received Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Free-text Notes and Comments (Notes)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `pa_request_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request Status (PA Request Status)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `pa_request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|cancelled|in_review|closed');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_age_at_request` SET TAGS ('dbx_business_glossary_term' = 'Member Age at Request Submission (Member Age)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_age_at_request` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_age_at_request` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Member Gender at Request Submission (Member Gender)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `prior_auth_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date for Prior Authorization (Decision Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Quantity (Quantity)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request Number (PA Request Number)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request Submission Timestamp (PA Request Timestamp)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Urgency Type of Prior Authorization Request (PA Urgency Type)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|urgent');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Code (CPT/HCPCS/Procedure Code)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `service_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Category (Service Type)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'procedure|drug|admission|therapy');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel for Prior Authorization Request (PA Submission Channel)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'portal|fax|phone|edi_278');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time in Days (TAT Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('dbx_subdomain' = 'authorization_management');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Decision ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID (MEMBER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request ID (PA_REQ_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Amendment Indicator (AMEND_IND)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_value_regex' = 'original|amended|reversal|override');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligibility Flag (APPEAL_ELIG)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization End Date (AUTH_END_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_period_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization Period Type (AUTH_PERIOD_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_period_type` SET TAGS ('dbx_value_regex' = 'fixed|rolling');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Quantity (AUTH_QTY)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Start Date (AUTH_START_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_units` SET TAGS ('dbx_business_glossary_term' = 'Authorization Units (AUTH_UNITS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_units` SET TAGS ('dbx_value_regex' = 'days|visits|doses|sessions');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale Narrative (CLIN_RAT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `criteria_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Criteria Effective Date (CRIT_EFF_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `criteria_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Criteria Met Flag (CRIT_MET)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date and Time (DECISION_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_number` SET TAGS ('dbx_business_glossary_term' = 'Decision Number (DECISION_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Decision Status (DECISION_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_value_regex' = 'active|amended|reversed|overridden');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Type (DECISION_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_value_regex' = 'approved|denied|partially_approved|pended|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Category (DENIAL_CAT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_category` SET TAGS ('dbx_value_regex' = 'medical_need|administrative|benefit_exclusion|out_of_network|experimental');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code (DENIAL_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Denial Regulatory Citation (DENIAL_REG_CIT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Codes (ICD_CODES)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `is_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Flag (TELEHEALTH_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Urgent Flag (URGENT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `prior_auth_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number (PA_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `prior_auth_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (REG_COMP_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_credentials` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Credentials (REVIEWER_CRED)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_credentials` SET TAGS ('dbx_value_regex' = 'MD|RN|PharmD|NP');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_business_glossary_term' = 'Reviewer NPI (REVIEWER_NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_npi` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('dbx_subdomain' = 'authorization_management');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `auth_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Service Line ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'approved|partially_approved|denied|pending|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_end_date` SET TAGS ('dbx_business_glossary_term' = 'Authorized Service End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_price` SET TAGS ('dbx_business_glossary_term' = 'Authorized Price');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_start_date` SET TAGS ('dbx_business_glossary_term' = 'Authorized Service Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `cpt_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `cpt_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Service Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `is_experimental` SET TAGS ('dbx_business_glossary_term' = 'Experimental Service Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `is_partial_approval` SET TAGS ('dbx_business_glossary_term' = 'Partial Approval Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `place_of_service` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `place_of_service` SET TAGS ('dbx_value_regex' = 'office|hospital|clinic|home|telehealth');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|dme|pharmacy|behavioral_health|telehealth');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('dbx_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `concurrent_review_id` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `inpatient_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Admission ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `actual_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `approved_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Approved Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `authorized_post_acute_service` SET TAGS ('dbx_business_glossary_term' = 'Authorized Post‑Acute Service');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_value_regex' = 'cms|milliman|plan_actuarial');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `benchmark_source_detail` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source Detail');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `clinical_reviewer_npi` SET TAGS ('dbx_business_glossary_term' = 'Clinical Reviewer NPI');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `clinical_reviewer_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `clinical_reviewer_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `clinical_reviewer_npi` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `concurrent_review_status` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `concurrent_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|denied|closed');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `current_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Current Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `discharge_barriers` SET TAGS ('dbx_business_glossary_term' = 'Discharge Barriers');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_business_glossary_term' = 'Discharge Destination');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_value_regex' = 'home|snf|ltac|home_health|hospice');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Review Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Stay Continuation Justification');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `los_benchmark_mean` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay Benchmark Mean (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `los_benchmark_outlier_threshold` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay Outlier Threshold (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `los_benchmark_target` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay Benchmark Target (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `planned_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `readmission_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Category');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `readmission_risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `readmission_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Start Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'concurrent|retrospective');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `social_work_involved` SET TAGS ('dbx_business_glossary_term' = 'Social Work Involvement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('dbx_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `inpatient_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Admission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `member_risk_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `appeal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `assigned_nurse_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned UM Nurse Name');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_close_date` SET TAGS ('dbx_business_glossary_term' = 'Case Close Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_severity` SET TAGS ('dbx_business_glossary_term' = 'Case Severity');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_severity` SET TAGS ('dbx_value_regex' = 'critical|moderate|minor');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_review|denied|approved|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Case Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|behavioral|dme|pharmacy|other');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `clinical_criteria_set` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Set');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `clinical_criteria_set` SET TAGS ('dbx_value_regex' = 'InterQual|MCG');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Case Disposition Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `disposition_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `disposition_description` SET TAGS ('dbx_business_glossary_term' = 'Case Disposition Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `length_of_stay_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `length_of_stay_target` SET TAGS ('dbx_business_glossary_term' = 'Target Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider NPI');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_provider_npi` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Case Turnaround Time (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_business_glossary_term' = 'Urgency Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('dbx_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `inpatient_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Admission ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `eligibility_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_los_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_number` SET TAGS ('dbx_business_glossary_term' = 'Admission Number (ADM_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_status` SET TAGS ('dbx_business_glossary_term' = 'Admission Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_status` SET TAGS ('dbx_value_regex' = 'admitted|discharged|cancelled|transferred');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_type` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|other');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_value_regex' = 'home|snf|rehab|expired|other');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Related Group (DRG) Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_los_days` SET TAGS ('dbx_business_glossary_term' = 'Expected Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `is_critical_care` SET TAGS ('dbx_business_glossary_term' = 'Critical Care Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `is_readmission` SET TAGS ('dbx_business_glossary_term' = 'Readmission Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `los_benchmark_met_flag` SET TAGS ('dbx_business_glossary_term' = 'LOS Benchmark Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `los_target_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay Target (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `payer_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `payer_authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|pending|denied|not_required');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `readmission_within_30_days` SET TAGS ('dbx_business_glossary_term' = '30‑Day Readmission Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_decision` SET TAGS ('dbx_business_glossary_term' = 'Review Decision');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|partial|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Review Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|escalated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('dbx_subdomain' = 'policy_criteria');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Medical Policy Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `applicable_cpt_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable CPT Codes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `applicable_hcpcs_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable HCPCS Codes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `clinical_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Category');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `clinical_criteria_source` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Source');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `clinical_criteria_source` SET TAGS ('dbx_value_regex' = 'interqual|mcg|internal');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `clinical_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non‑compliant|pending|exempt');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Units');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_units` SET TAGS ('dbx_value_regex' = 'visits|days|doses|sessions|procedures');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_emergency_covered` SET TAGS ('dbx_business_glossary_term' = 'Emergency Service Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Exemption Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_experimental_covered` SET TAGS ('dbx_business_glossary_term' = 'Experimental Service Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_prior_auth_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_telehealth_covered` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|draft|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Name');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'medical|surgical|behavioral|pharmacy|diagnostic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `prior_auth_approval_timeframe_days` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Approval Timeframe (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `version_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('dbx_subdomain' = 'policy_criteria');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `parent_clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Clinical Criteria Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `parent_clinical_criteria_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_category` SET TAGS ('dbx_business_glossary_term' = 'Criteria Category');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_code` SET TAGS ('dbx_business_glossary_term' = 'Criteria Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Criteria Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_detail` SET TAGS ('dbx_business_glossary_term' = 'Criteria Detail');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Criteria Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Criteria Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Criteria Limit Unit');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Criteria Limit Value');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_name` SET TAGS ('dbx_business_glossary_term' = 'Criteria Name');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_notes` SET TAGS ('dbx_business_glossary_term' = 'Criteria Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_reference` SET TAGS ('dbx_business_glossary_term' = 'Criteria Reference');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_rule_expression` SET TAGS ('dbx_business_glossary_term' = 'Criteria Rule Expression');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_source` SET TAGS ('dbx_business_glossary_term' = 'Criteria Source');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_status` SET TAGS ('dbx_business_glossary_term' = 'Criteria Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Criteria Subcategory');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Criteria Threshold Unit');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Criteria Threshold Value');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_type` SET TAGS ('dbx_business_glossary_term' = 'Criteria Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
