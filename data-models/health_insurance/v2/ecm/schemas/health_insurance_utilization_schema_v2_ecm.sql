-- Schema for Domain: utilization | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`utilization` COMMENT 'Manages utilization management (UM) and prior authorization (PA) workflows — inpatient concurrent review, retrospective review, medical necessity determination, peer-to-peer processes, and UM turnaround time compliance. Owns PA requests, clinical criteria application (InterQual, MCG), authorization decisions, length-of-stay benchmarks, and denial reasons. Supports NCQA UM accreditation standards and state PA reform mandates. Source system: InterQual or MCG.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` (
    `pa_request_id` BIGINT COMMENT 'Unique identifier for the prior authorization request.',
    `clinical_criteria_id` BIGINT COMMENT 'Identifier of the specific clinical rule applied.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory reporting of prior authorizations requires linking each PA request to the governing regulatory obligation.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: PA requests must be evaluated against the specific provider contract to determine coverage, prior‑auth requirements, and payment methodology; required for PA decision and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who made the authorization decision.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Prior Authorization Request Volume Report groups requests by health plan to monitor utilization and cost.',
    `plan_election_id` BIGINT COMMENT 'Identifier of the health plan under which the member is covered.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member requesting the service.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Required for Prior Authorization request processing to link each request to the provider entity for reporting, compliance, and performance metrics.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network relevant to the request.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Prior Authorization requests must verify providers credential status (NCQA, state license) before approval; linking enables automated credential checks for compliance.',
    `related_request_pa_request_id` BIGINT COMMENT 'Identifier of the related prior authorization request, if any.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Prior Authorization requests must verify the members active enrollment transaction to determine coverage and cost‑share, required for CMS PA reporting and claim adjudication.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Prior Authorization Request Report requires linking each request to the contracted vendor (lab, imaging) that will perform the service.',
    `additional_information_requests_count` STRING COMMENT 'Total number of additional information requests issued during review.',
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
    `fhir_coverage_eligibility_request_resource_id` STRING COMMENT '',
    CONSTRAINT pk_pa_request PRIMARY KEY(`pa_request_id`)
) COMMENT 'Core master entity representing a prior authorization (PA) request submitted by a provider or member for a proposed service, procedure, drug, or admission. Captures requesting provider NPI, member ID, requested service codes (CPT/HCPCS/ICD), urgency type (standard, expedited, urgent), submission channel (portal, fax, phone, EDI 278), submission timestamp, current PA status, and full status transition history. Also tracks additional information requests (AIRs) issued during review — information type requested, requested-from party, due date, received date, and TAT clock extension impact. Authoritative SSOT for all PA requests, their status lifecycle, and associated documentation requests.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` (
    `pa_decision_id` BIGINT COMMENT 'System-generated unique identifier for each prior authorization decision record.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Audits evaluate prior‑auth decisions; linking decisions to specific audit findings enables audit‑driven compliance analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PA Decision Audit Report requires recording which employee authorized each prior‑auth decision for compliance and traceability.',
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
    `clinical_criteria_set` STRING COMMENT 'Name of the clinical criteria library applied (e.g., InterQual, MCG).',
    `clinical_criteria_version` STRING COMMENT 'Version identifier of the criteria set used for the decision.',
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
    `fhir_coverage_eligibility_response_resource_id` STRING COMMENT '',
    CONSTRAINT pk_pa_decision PRIMARY KEY(`pa_decision_id`)
) COMMENT 'Transactional record capturing the authorization decision and underlying medical necessity determination rendered on a PA request. Stores decision date, decision type (approved, denied, partially approved, pended, withdrawn), clinical criteria applied (InterQual/MCG criteria set, version, effective date), criteria met/not met flag, clinical rationale narrative, ICD diagnosis codes supporting the determination, deciding reviewer NPI and credentials (MD, RN, PharmD), denial reason code and category (medical necessity, administrative, benefit exclusion, out-of-network, experimental/investigational), denial regulatory citation, appeal eligibility flag, and effective authorization period (start/end dates). Each PA request may have one or more decision records reflecting amendments, P2P reversals, or appeal overrides. Serves as the single evidentiary record for NCQA audits, state DOI market conduct exams, and denial defense.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` (
    `auth_service_line_id` BIGINT COMMENT 'System-generated unique identifier for each line item within a prior authorization request.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Required for Care Plan Progress Report: authorized service lines must be linked to the members active care plan to track service fulfillment and plan adherence.',
    `clinical_criteria_id` BIGINT COMMENT 'Identifier of the specific clinical rule set (InterQual/MCG) applied to this line.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Authorized Service Line Entry Log tracks the employee who entered or approved the service line, supporting internal audit and error correction.',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: Each authorized service line uses a fee schedule to calculate allowed amount; linking enables accurate payment calculation and regulatory fee‑schedule reporting.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Authorization Service Line Cost Tracking per plan supports financial analysis and rate setting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member for whom the service is authorized.',
    `pa_request_id` BIGINT COMMENT 'Identifier of the parent prior authorization request to which this service line belongs.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Associates each authorized service line with the ordering provider, enabling utilization analytics and provider reimbursement validation.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Service line authorizations require confirming the providers credential and sanction status for each CPT/HCPCS, supporting claim adjudication and audit.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Authorization Service Line Detail report tracks which vendor performs each authorized CPT/HCPCS service for performance and compliance.',
    `authorization_status` STRING COMMENT 'Current status of the service line within the prior authorization workflow.. Valid values are `approved|partially_approved|denied|pending|revoked`',
    `authorized_end_date` DATE COMMENT 'Expiration date after which the authorization is no longer valid.',
    `authorized_facility_npi` STRING COMMENT 'NPI of the facility where the service is to be performed.',
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
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Concurrent utilization reviews are often scoped within an audit engagement; the link tracks which engagement oversees each review.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to the member for this episode.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Concurrent Review Assignment process assigns a case‑manager employee to each review; the assignment is reported in the Review Assignment Dashboard.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Concurrent Review Utilization Management reports require linking each review to the members health plan.',
    `inpatient_admission_id` BIGINT COMMENT 'Identifier of the inpatient admission linked to this review.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose stay is under review.',
    `pa_request_id` BIGINT COMMENT 'Identifier of the originating prior‑authorization request.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Connects concurrent review records to the admitting provider for LOS benchmarking and clinical oversight reporting.',
    `um_case_id` BIGINT COMMENT 'Identifier of the overarching UM case that this review belongs to.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Concurrent Review Dashboard aggregates metrics by vendor for home‑health and post‑acute services under review.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` (
    `retrospective_review_id` BIGINT COMMENT 'System-generated unique identifier for each retrospective utilization review record.',
    `header_id` BIGINT COMMENT 'Identifier of the claim associated with the service being retrospectively reviewed.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Retrospective reviews assess claims against contract terms to identify over‑payments and ensure contractual compliance; required for audit and reimbursement adjustments.',
    `gap_id` BIGINT COMMENT 'Foreign key linking to care.care_gap. Business justification: Retrospective Review Closure Report uses review findings to close identified care gaps; linking each review to its care_gap provides auditability.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Regulatory audit of retrospective reviews is performed per employer; FK provides required grouping.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Retrospective Review Audit needs plan context to assess compliance and cost impact.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member whose service is being reviewed.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider who delivered the service under review.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Retrospective claim reviews assess compliance with network contracts; linking to network provides contract‑specific audit data.',
    `um_reviewer_id` BIGINT COMMENT 'Identifier of the clinical reviewer who made the final decision.',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment resulting from the review decision (e.g., denied amount, approved reimbursement).',
    `clinical_criteria_applied` STRING COMMENT 'Clinical decision support criteria set used for the review.. Valid values are `InterQual|MCG`',
    `compliance_state` STRING COMMENT 'Overall compliance status of the review with regulatory timelines.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the retrospective review record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the adjusted amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|JPY|AUD|CHF|CNY|MXN|INR — promote to reference product]',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating why a service was denied after retrospective review.',
    `denial_reason_description` STRING COMMENT 'Human‑readable description of the denial reason.',
    `documentation_completeness_flag` BOOLEAN COMMENT 'Indicates whether all required documentation was complete and sufficient.',
    `documentation_received_date` DATE COMMENT 'Date the required clinical documentation was received for the review.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_necessity_outcome` STRING COMMENT 'Result of the medical necessity determination for the reviewed service.. Valid values are `approved|denied|partial`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `retro_review_deadline_flag` BOOLEAN COMMENT 'Indicates whether the review was completed within the state‑mandated retro‑review deadline.',
    `review_completion_date` DATE COMMENT 'Date the review decision was finalized.',
    `review_initiation_date` DATE COMMENT 'Date the retrospective review process was started.',
    `review_notes` STRING COMMENT 'Free‑form comments entered by the reviewer regarding the decision.',
    `review_number` STRING COMMENT 'External reference number assigned to the review for tracking and reporting.',
    `review_status` STRING COMMENT 'Current workflow state of the retrospective review.. Valid values are `pending|in_review|completed|closed`',
    `review_type` STRING COMMENT 'Classification of the review; typically retrospective when prior authorization was not obtained.. Valid values are `retrospective|post_admission`',
    `service_date` DATE COMMENT 'Calendar date on which the medical service was provided.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    CONSTRAINT pk_retrospective_review PRIMARY KEY(`retrospective_review_id`)
) COMMENT 'Records retrospective (post-service) UM reviews conducted when prior authorization was not obtained before service delivery. Captures service date, review initiation date, clinical documentation received date, medical necessity outcome, denial or approval result, and applicable state retro-review deadline compliance flag. Supports NCQA UM accreditation standards for retrospective review turnaround time (TAT) compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` (
    `peer_to_peer_review_id` BIGINT COMMENT 'Primary key for peer_to_peer_review',
    `header_id` BIGINT COMMENT 'Identifier of the claim associated with this peer-to-peer review.',
    `pa_request_id` BIGINT COMMENT 'Unique business identifier assigned to the peer-to-peer review request.',
    `peer_pa_request_id` BIGINT COMMENT 'Identifier of the prior authorization request linked to this review.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Captures the requesting provider in peer‑to‑peer reviews for peer performance tracking and compliance with clinical peer‑review regulations.',
    `employee_id` BIGINT COMMENT 'add column reviewer_employee_id (BIGINT) with FK to workforce.employee.employee_id - internal medical director party to P2P',
    `completed_date` TIMESTAMP COMMENT 'Timestamp when the peer-to-peer review was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this review record was first captured in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deadline_compliance_flag` BOOLEAN COMMENT 'Indicates whether the review was completed within the state-mandated deadline.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional free-text comments or observations related to the review.',
    `outcome_description` STRING COMMENT 'Narrative summary of the discussion and rationale for the review outcome.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Flag indicating compliance with NCQA Utilization Management accreditation requirements.',
    `request_date` TIMESTAMP COMMENT 'Timestamp when the peer-to-peer review was requested by the provider.',
    `review_duration_days` STRING COMMENT 'Number of calendar days between request_date and completed_date.',
    `review_outcome` STRING COMMENT 'Result of the peer-to-peer review indicating whether the original denial was upheld, partially approved, or fully reversed.. Valid values are `upheld_denial|partial_approval|full_reversal`',
    `review_status` STRING COMMENT 'Current processing status of the peer-to-peer review.. Valid values are `pending|in_progress|completed|cancelled`',
    `reviewer_provider_npi` STRING COMMENT 'NPI of the plan physician reviewer who conducted the peer-to-peer review.',
    `scheduled_date` TIMESTAMP COMMENT 'Timestamp when the peer-to-peer review was scheduled to occur.',
    `state_code` STRING COMMENT 'Two-letter US state code governing the applicable peer-to-peer review deadline. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this review record.',
    CONSTRAINT pk_peer_to_peer_review PRIMARY KEY(`peer_to_peer_review_id`)
) COMMENT 'Tracks peer-to-peer (P2P) review interactions between the health plans medical director or physician reviewer and the requesting provider following an initial denial. Captures P2P request date, scheduled date, completed date, requesting provider NPI, plan physician reviewer NPI, discussion summary, outcome (upheld denial, partial approval, full reversal), and state P2P deadline compliance flag. Critical for NCQA UM accreditation and state PA reform mandates requiring P2P availability within specified timeframes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` (
    `tat_compliance_event_id` BIGINT COMMENT 'Unique identifier for the TAT compliance event record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Turn‑around‑time events are measured against specific regulatory standards; linking ties each event to its governing obligation.',
    `identity_id` BIGINT COMMENT 'Unique identifier for the member (patient) involved in the request.',
    `pa_request_id` BIGINT COMMENT 'Identifier of the prior authorization or utilization review request associated with this compliance event.',
    `provider_id` BIGINT COMMENT 'Unique identifier for the provider who submitted or is linked to the request.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: TAT compliance events are reported per network to satisfy regulator‑mandated network performance metrics.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the decision was made within the configured turnaround time.',
    `compliance_status` STRING COMMENT 'Overall status of the event after evaluation.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance event record was created in the data warehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the final decision (approval/denial) was recorded.',
    `due_timestamp` TIMESTAMP COMMENT 'Calculated deadline by which a decision must be made to meet the configured TAT.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the TAT compliance event was logged.',
    `event_type` STRING COMMENT 'Descriptor of the event type (e.g., tat_compliance).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `jurisdiction` STRING COMMENT 'State, federal, or other jurisdiction governing the TAT requirement.',
    `line_of_business` STRING COMMENT 'Business line to which the request belongs.. Valid values are `medical|dental|vision|pharmacy|behavioral`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the compliance event.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the request was first received by the utilization management system.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_period` STRING COMMENT 'Period (e.g., 2023Q1) for which the compliance event is reported to regulators.. Valid values are `^d{4}Q[1-4]$`',
    `review_type` STRING COMMENT 'Category of the utilization management review.. Valid values are `prior_authorization|concurrent_review|retrospective_review|utilization_review`',
    `root_cause_category` STRING COMMENT 'High‑level reason why a TAT breach occurred.. Valid values are `staffing|documentation|escalation|system|other`',
    `root_cause_detail` STRING COMMENT 'Free‑text description providing additional context for the root cause.',
    `tat_standard_days` STRING COMMENT 'Target turnaround time in days when the standard is expressed in days.',
    `tat_standard_hours` STRING COMMENT 'Target turnaround time in hours for the specific review type, urgency, and jurisdiction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compliance event record.',
    `urgency_level` STRING COMMENT 'Priority level of the request as defined by clinical or regulatory policy.. Valid values are `routine|urgent|stat`',
    `variance_days` DECIMAL(18,2) COMMENT 'Difference in days between actual decision time and the TAT target (positive = late).',
    `variance_hours` DECIMAL(18,2) COMMENT 'Difference in hours between actual decision time and the TAT target (positive = late).',
    CONSTRAINT pk_tat_compliance_event PRIMARY KEY(`tat_compliance_event_id`)
) COMMENT 'Transactional record tracking turnaround time (TAT) compliance for each PA request or UM review event. Captures applicable TAT standard configuration (review type, urgency level, line of business, state/federal/NCQA/CMS TAT limits in hours/days, plan-specific targets), request receipt timestamp, decision due timestamp, actual decision timestamp, compliant/non-compliant flag, variance in hours/days, root cause category for non-compliance (staffing, documentation pending, escalation delay), and regulatory reporting period. Supports NCQA UM accreditation TAT reporting, state DOI compliance filings, and CMS MA organization determination timeliness.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` (
    `um_case_id` BIGINT COMMENT 'System-generated unique identifier for the UM case.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Case Management Dashboard needs to reference the members care plan to align interventions and report case outcomes against the plan.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Utilization management cases are frequently initiated to satisfy specific regulatory obligations (e.g., CMS guidelines).',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Utilization Management cases are governed by the providers contract terms (coverage criteria, cost‑share); linking supports case review, compliance, and audit.',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.care_coordinator. Business justification: Case Management Process assigns a care coordinator to each utilization case; linking enables case‑to‑coordinator reporting and workload tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Utilization Management Cost Tracking links each case to the cost center responsible for case management expenses.',
    `employee_id` BIGINT COMMENT 'Identifier of the utilization management nurse or case manager assigned to the case.',
    `episode_of_care_id` BIGINT COMMENT 'Identifier linking the case to the broader episode of care.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Case management dashboards for employers require tying each utilization case to the employer sponsoring the member.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: UM Case Management Dashboard aggregates cases by health plan to monitor utilization trends.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the case.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: um_case may be initiated by a PA request; child (um_case) gets FK to parent (pa_request).',
    `provider_id` BIGINT COMMENT 'Identifier of the provider who rendered the service under review.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Case management reports attribute each case to the primary provider’s network for network adequacy analysis and cost allocation.',
    `um_program_id` BIGINT COMMENT 'Foreign key linking to utilization.um_program. Business justification: um_case belongs to a UM program configuration; child (case) gets FK to parent (um_program).',
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
    `prior_authorization_decision_date` DATE COMMENT 'Date the prior authorization decision was rendered.',
    `prior_authorization_number` STRING COMMENT 'Reference number for the prior authorization request linked to the case.',
    `prior_authorization_status` STRING COMMENT 'Current status of the prior authorization request.. Valid values are `pending|approved|denied|expired`',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` (
    `um_reviewer_id` BIGINT COMMENT 'Unique surrogate key for the utilization management reviewer.',
    `record_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
    `employee_id` BIGINT COMMENT 'add column employee_id (BIGINT) with FK to workforce.employee.employee_id - UM reviewers are internal staff',
    `um_workforce_employee_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
    `assigned_review_queue` STRING COMMENT 'Primary review queue to which the reviewer is assigned.',
    `city` STRING COMMENT 'City of reviewer’s address.',
    `compliance_state` STRING COMMENT 'Current compliance status of the reviewer with internal and external UM regulations.. Valid values are `compliant|non_compliant|pending|under_review`',
    `country` STRING COMMENT 'Country of reviewer’s residence.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reviewer record was first created in the system.',
    `credential_type` STRING COMMENT 'Professional credential held by the reviewer.. Valid values are `RN|MD|PharmD|LCSW|NP|PA`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `date_of_birth` DATE COMMENT 'Reviewer’s birth date.',
    `delegation_authority_level` STRING COMMENT 'Level of authority the reviewer has to delegate or approve utilization decisions.. Valid values are `none|review|approve|escalate|admin`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `email_address` STRING COMMENT 'Primary email for reviewer communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `first_name` STRING COMMENT 'Reviewer’s given name.',
    `full_name` STRING COMMENT 'Concatenated full legal name of the reviewer.',
    `hire_date` DATE COMMENT 'Date the reviewer was hired by the health plan.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_name` STRING COMMENT 'Reviewer’s family name.',
    `last_training_date` DATE COMMENT 'Date of the most recent required UM/PA training completed by the reviewer.',
    `license_expiration_date` DATE COMMENT 'Date when the reviewer’s professional license expires.',
    `license_number` STRING COMMENT 'State-issued license number for the reviewer.',
    `license_state` STRING COMMENT 'State that issued the professional license.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `middle_name` STRING COMMENT 'Reviewer’s middle name, if any.',
    `ncqa_qualified_flag` BOOLEAN COMMENT 'Indicates whether the reviewer meets NCQA accreditation qualifications.',
    `next_training_due_date` DATE COMMENT 'Scheduled date for the reviewer’s next required training.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations about the reviewer.',
    `npi` STRING COMMENT 'Unique identifier assigned to the reviewer by the National Provider Identifier system.',
    `phone_number` STRING COMMENT 'Primary contact phone number.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reviewer_status` STRING COMMENT 'Current lifecycle status of the reviewer within UM operations.. Valid values are `active|inactive|suspended|retired|pending`',
    `specialty` STRING COMMENT 'Medical specialty area of the reviewer (e.g., cardiology, oncology).',
    `state` STRING COMMENT 'State of reviewer’s address.',
    `street_address` STRING COMMENT 'Reviewer’s mailing street address.',
    `termination_date` DATE COMMENT 'Date the reviewer’s employment ended, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reviewer record.',
    `urac_qualified_flag` BOOLEAN COMMENT 'Indicates whether the reviewer meets URAC accreditation qualifications.',
    `version_number` STRING COMMENT 'Incremental version number for optimistic concurrency control.',
    `zip_code` STRING COMMENT 'Postal code of reviewer’s address.',
    CONSTRAINT pk_um_reviewer PRIMARY KEY(`um_reviewer_id`)
) COMMENT 'Master entity for UM clinical reviewers — nurses, medical directors, and physician advisors who conduct UM and PA reviews. Captures reviewer NPI (if applicable), reviewer name, credential type (RN, MD, PharmD, LCSW), specialty, active status, state licensure details, URAC/NCQA reviewer qualification status, assigned review queues, and delegation authority level. Distinct from the provider domain — this entity represents internal plan staff performing UM functions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` (
    `pa_notification_id` BIGINT COMMENT 'System-generated unique identifier for each prior authorization notification record.',
    `header_id` BIGINT COMMENT 'Identifier of the claim associated with the prior authorization, if the notification relates to a claim.',
    `facility_id` BIGINT COMMENT 'Unique identifier of the facility (e.g., hospital, clinic) receiving the notification, when applicable.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: PA Notification Compliance tracking needs the originating health plan for audit trails.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom the notification is addressed.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: pa_notification must reference the PA request it notifies about; child (notification) gets FK to parent (pa_request).',
    `employee_id` BIGINT COMMENT 'System user identifier who created the notification record.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the health care provider receiving the notification, when applicable.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Notification Audit Log records which vendor received the prior‑auth decision notification for traceability.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient acknowledged receipt of the notification, if applicable.',
    `approval_expiration_date` DATE COMMENT 'Date on which an approved prior authorization expires, if applicable.',
    `attachment_indicator` BOOLEAN COMMENT 'True if the notification includes an attached document (e.g., detailed denial letter).',
    `compliance_state` STRING COMMENT 'Current compliance status of the notification with applicable accreditation or regulatory rules.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification record was first created in the data warehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_reference` STRING COMMENT 'Identifier of the prior authorization request or decision that triggered this notification.',
    `delivery_channel` STRING COMMENT 'The medium used to deliver the notification to the recipient.. Valid values are `mail|fax|portal|phone|email`',
    `delivery_status` STRING COMMENT 'Current status of the notification delivery process.. Valid values are `sent|delivered|failed|pending_acknowledgment`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the delivery channel confirmed successful transmission or receipt.',
    `denial_reason_code` STRING COMMENT 'Standardized code representing the reason for a denial, when notification_type is denial.',
    `denial_reason_description` STRING COMMENT 'Human‑readable description of the denial reason.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_urgent` BOOLEAN COMMENT 'Indicates whether the notification requires expedited handling.',
    `language_code` STRING COMMENT 'ISO 639‑1 code of the language used for the notification content.. Valid values are `EN|ES|FR|DE|ZH|JA`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `message_body` STRING COMMENT 'Full text content of the notification sent to the recipient.',
    `notification_number` STRING COMMENT 'Business identifier assigned to the notification, used for tracking and reference in communications.',
    `notification_status` STRING COMMENT 'Overall lifecycle state of the notification record within the system.. Valid values are `draft|queued|sent|completed|cancelled`',
    `notification_type` STRING COMMENT 'Category of the notification indicating the decision outcome of the prior authorization request.. Valid values are `approval|denial|pend|expedited_acknowledgment`',
    `priority_level` STRING COMMENT 'Business priority assigned to the notification for processing and escalation.. Valid values are `low|medium|high|critical`',
    `recipient_type` STRING COMMENT 'Indicates whether the notification is addressed to a member, a health care provider, or a facility.. Valid values are `member|provider|facility`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Regulatory framework or mandate that requires this notification to be sent.. Valid values are `ACA|CMS_MA|STATE_MANDATE|NONE`',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the notification was transmitted to the delivery channel.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the notification record.',
    CONSTRAINT pk_pa_notification PRIMARY KEY(`pa_notification_id`)
) COMMENT 'Records all required notifications sent to members and providers regarding PA decisions, pend status, and denial notices. Captures notification type (approval notice, denial notice, pend notice, expedited acknowledgment), recipient type (member, provider, facility), delivery channel (mail, fax, portal, phone), sent timestamp, delivery confirmation, and regulatory notice requirement reference (ACA, state mandate, CMS MA). Supports NCQA UM accreditation notification standards and state PA reform mandates.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` (
    `inpatient_admission_id` BIGINT COMMENT 'System-generated unique identifier for the inpatient admission record.',
    `clinical_criteria_id` BIGINT COMMENT 'Identifier of the specific clinical rule used for concurrent review.',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Admission eligibility checks need the members enrollment eligibility span to confirm benefit coverage dates, essential for clinical validation and regulatory audit of inpatient services.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Inpatient Admission Utilization reports are generated per health plan for network adequacy analysis.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the insured member associated with the admission.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Final cost incurred for the admission after discharge.',
    `actual_los_days` STRING COMMENT 'Number of days the member actually stayed in the facility.',
    `admission_date` DATE COMMENT 'Date the member was admitted to the facility.',
    `admission_number` STRING COMMENT 'Business identifier assigned to the admission by the health plan.',
    `admission_status` STRING COMMENT 'Current lifecycle status of the admission.. Valid values are `admitted|discharged|cancelled|transferred`',
    `admission_type` STRING COMMENT 'Classification of the admission based on urgency.. Valid values are `elective|urgent|emergent|other`',
    `authorization_number` STRING COMMENT 'Unique identifier of the payers authorization for this admission.',
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
    `facility_npi` STRING COMMENT 'NPI of the admitting facility where the inpatient stay began.',
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
    `physician_npi` STRING COMMENT 'NPI of the physician responsible for the admission.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` (
    `um_program_id` BIGINT COMMENT 'System-generated unique identifier for each UM program definition.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Programs are designed to meet regulatory requirements; the FK supports program‑to‑obligation reporting.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: UM Program Enrollment reports require associating programs with the health plans they serve.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Program Ownership Management requires linking each utilization program to the responsible HR employee for accountability and budgeting.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Required for underwriting and pricing reports that allocate program costs by risk pool; program eligibility depends on the assigned risk pool.',
    `accreditation_category` STRING COMMENT 'Specific NCQA/URAC accreditation domain the program addresses (Turn‑Around‑Time, Criteria, Notification, Delegation, Peer‑to‑Peer).. Valid values are `tat|criteria|notification|delegation|p2p`',
    `accreditation_status` STRING COMMENT 'Overall compliance status with NCQA/URAC accreditation standards.. Valid values are `compliant|non_compliant|pending`',
    `accreditation_survey_date` DATE COMMENT 'Date of the most recent accreditation survey for this program.',
    `clinical_criteria_set` STRING COMMENT 'Name of the InterQual or MCG criteria set assigned to the program.',
    `compliance_notes` STRING COMMENT 'Free‑text field for additional compliance observations or exceptions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the UM program record was first created in the data lake.',
    `criteria_effective_date` DATE COMMENT 'Date on which the assigned clinical criteria become effective for the program.',
    `criteria_version` STRING COMMENT 'Version identifier of the clinical criteria set (e.g., v2024.1).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `um_program_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and key features of the UM program.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the UM program becomes operational.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the UM program is retired or superseded (null if open‑ended).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: CareTeam)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gap_analysis_date` DATE COMMENT 'Date when the most recent gap analysis was completed.',
    `gap_analysis_status` STRING COMMENT 'Current state of the gap analysis performed against accreditation requirements.. Valid values are `open|closed|in_progress`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Business segment(s) to which the UM program is applicable.. Valid values are `individual|group|medicare|medicaid|exchange|self_funded`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_review_due_date` DATE COMMENT 'Planned date for the next formal program review or update.',
    `pa_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization is mandatory for services under this program.',
    `program_code` STRING COMMENT 'External business identifier or code used to reference the UM program in contracts and reports.',
    `program_name` STRING COMMENT 'Human‑readable name of the utilization management program.',
    `program_notes` STRING COMMENT 'Additional internal comments or documentation about the UM program.',
    `program_type` STRING COMMENT 'Category of services the UM program applies to.. Valid values are `inpatient|outpatient|behavioral|pharmacy|specialty`',
    `program_version` STRING COMMENT 'Version label for the program definition (e.g., v1.0, v2.3).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Citation to the specific NCQA, URAC, or state DOI regulation governing the program.',
    `review_type_scope` STRING COMMENT 'Scope of review types covered by the program.. Valid values are `concurrent|retrospective|both`',
    `services_covered` STRING COMMENT 'Free‑text list or coded reference of clinical services that require UM review under this program.',
    `um_program_status` STRING COMMENT 'Current lifecycle status of the UM program.. Valid values are `active|inactive|retired|draft`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the UM program record.',
    CONSTRAINT pk_um_program PRIMARY KEY(`um_program_id`)
) COMMENT 'Master reference for the health plans UM program configurations — the formal UM program definitions required by NCQA, URAC, and state DOI. Captures program name, program type (inpatient UM, outpatient UM, behavioral health UM, pharmacy UM, specialty drug UM), applicable lines of business, clinical criteria set assigned (InterQual/MCG version and effective date), review type scope, NCQA/URAC accreditation compliance status by standard category (TAT, criteria, notification, delegation, P2P), accreditation survey dates, and current gap analysis. Governs which services require PA and which clinical criteria apply.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` (
    `pa_required_service_id` BIGINT COMMENT 'Unique surrogate key for each PA requirement record.',
    `benefit_id` BIGINT COMMENT 'add column benefit_id (BIGINT) with FK to plan.benefit.benefit_id - PA-required services map to benefits',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan to which this PA rule applies.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: pa_required_service defines services required for a specific PA request; child (required_service) gets FK to parent (pa_request).',
    `clinical_criteria_set` STRING COMMENT 'Name of the clinical criteria set (e.g., InterQual, MCG) used for evaluation.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when the PA requirement becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exemption_type` STRING COMMENT 'Reason why PA may be exempted for this service.. Valid values are `state_mandate|cms_requirement|gold_card|plan_policy|none`',
    `expiration_date` DATE COMMENT 'Date when the PA requirement ends; null if indefinite.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gold_card_approval_rate_met_flag` BOOLEAN COMMENT 'Indicates if the provider met the approval rate threshold.',
    `gold_card_approval_rate_threshold` DECIMAL(18,2) COMMENT 'Minimum approval rate percentage required for gold card eligibility.',
    `gold_card_effective_date` DATE COMMENT 'Start date of gold card exemption.',
    `gold_card_expiration_date` DATE COMMENT 'End date of gold card exemption.',
    `gold_card_flag` BOOLEAN COMMENT 'Indicates if a gold card exemption applies.',
    `gold_card_provider_npi` STRING COMMENT 'National Provider Identifier of the provider granted gold card status.',
    `gold_card_revocation_reason` STRING COMMENT 'Reason for revoking gold card status.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Business segment for the plan (e.g., commercial, Medicare Advantage).. Valid values are `commercial|medicare_advantage|medicaid|group|individual`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `pa_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization is required for the service.',
    `pa_required_service_status` STRING COMMENT 'Current lifecycle status of the PA requirement record.. Valid values are `active|inactive|retired|pending`',
    `pa_type` STRING COMMENT 'Type of PA process applicable.. Valid values are `standard|expedited|concurrent|none`',
    `provider_specialty_exemption_flag` BOOLEAN COMMENT 'Indicates if the providers specialty grants an exemption.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_citation` STRING COMMENT 'Reference to the regulatory rule or statute governing the PA requirement.',
    `service_code` STRING COMMENT 'The standardized code representing the medical service or procedure.',
    `service_description` STRING COMMENT 'Human readable description of the service.',
    `updated_by` STRING COMMENT 'Identifier of the user who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` STRING COMMENT 'Identifier of the user who created the record.',
    CONSTRAINT pk_pa_required_service PRIMARY KEY(`pa_required_service_id`)
) COMMENT 'Unified reference master defining PA requirements, exemptions, and gold card overrides by service, provider, plan, and line of business. Captures CPT/HCPCS code or service category, plan ID, line of business (commercial, Medicare Advantage, Medicaid), effective date, PA required/exempt flag, exemption type (state mandate, CMS requirement, gold card, plan policy), PA type (standard, expedited, concurrent), applicable clinical criteria set, regulatory citation, and provider specialty exemption criteria. For gold card entries: provider NPI, gold card effective/expiration dates, approval rate threshold met, qualifying performance period, and revocation reason. Drives PA intake routing, provider-facing PA requirement lookups, state PA reform compliance, and gold card mandate tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` (
    `um_delegation_id` BIGINT COMMENT 'System-generated unique identifier for each UM delegation arrangement.',
    `delegated_entity_id` BIGINT COMMENT 'add column delegated_entity_id (BIGINT) with FK to credential.delegated_entity.delegated_entity_id - UM delegation is to a delegated entity',
    `delegation_agreement_id` BIGINT COMMENT 'add column delegation_agreement_id (BIGINT) with FK to contract.delegation_agreement.delegation_agreement_id - UM delegation references the contractual agreement',
    `um_program_id` BIGINT COMMENT 'Foreign key linking to utilization.um_program. Business justification: um_delegation is associated with a UM program; child (delegation) gets FK to parent (um_program).',
    `audit_result_status` STRING COMMENT 'Outcome of the most recent audit.. Valid values are `pass|fail|conditional|pending`',
    `audit_schedule_date` DATE COMMENT 'Planned date for the next oversight audit of the delegation.',
    `compliance_status` STRING COMMENT 'NCQA UM delegation compliance status.. Valid values are `compliant|non_compliant|under_review`',
    `contract_terms_description` STRING COMMENT 'Free‑text description of key contractual obligations and limits.',
    `corrective_action_plan_reference` STRING COMMENT 'Reference identifier for any corrective action plan triggered by audit findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delegation record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delegated_entity_type` STRING COMMENT 'Classification of the delegated organization. Values: tpa, health_system, aco, ipa, specialty_vendor.. Valid values are `tpa|health_system|aco|ipa|specialty_vendor`',
    `delegated_functions` STRING COMMENT 'Comma‑separated list of UM functions the external entity performs under the delegation.. Valid values are `prior_authorization|concurrent_review|retrospective_review|utilization_review`',
    `delegation_number` STRING COMMENT 'External contract number or code assigned to the delegation agreement.',
    `delegation_status` STRING COMMENT 'Current lifecycle status of the delegation agreement.. Valid values are `active|inactive|terminated|suspended|pending`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date the delegation agreement becomes binding.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date the delegation agreement ends or is scheduled to terminate (null for open‑ended).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `performance_metric_actual_days` STRING COMMENT 'Actual average number of days achieved for UM turnaround time.',
    `performance_metric_target_days` STRING COMMENT 'Target number of days for UM turnaround time as stipulated in the contract.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `sub_delegation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the delegated entity may further sub‑delegate UM functions.',
    `termination_reason_code` STRING COMMENT 'Standard code indicating why the delegation was terminated.',
    `termination_reason_description` STRING COMMENT 'Human‑readable explanation of the termination reason.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the delegation record.',
    CONSTRAINT pk_um_delegation PRIMARY KEY(`um_delegation_id`)
) COMMENT 'Master entity tracking UM delegation arrangements where the health plan delegates UM functions to an external entity — TPA, health system, ACO, IPA, or specialty vendor. Captures delegated entity name and type, delegated UM functions (PA, concurrent review, retrospective review), delegation effective/termination dates, performance metrics, oversight audit schedule and results, NCQA delegation compliance status, sub-delegation restrictions, and corrective action plan references. Required for NCQA UM accreditation delegation oversight standards and state DOI delegation reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` (
    `medical_policy_id` BIGINT COMMENT 'System-generated unique identifier for the medical policy record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Medical policies must align with regulatory obligations; linking provides traceability for compliance audits.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Medical Policy Management Expense Tracking needs each policy linked to the cost center that maintains it.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Certain medical policies are employer‑specific; linking enables policy applicability checks per employer.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` (
    `bed_day_review_id` BIGINT COMMENT 'Unique identifier for the bed day review record.',
    `concurrent_review_id` BIGINT COMMENT 'Foreign key linking to utilization.concurrent_review. Business justification: bed_day_review records daily reviews for a concurrent review; child (bed_day_review) gets FK to parent (concurrent_review).',
    `coordinator_id` BIGINT COMMENT 'Identifier of the care coordinator assigned to the case.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Bed Day Review Cost Allocation links each review to the cost center budgeting bed‑day expenses.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Bed Day Review Metrics are reported per health plan to evaluate length‑of‑stay performance.',
    `inpatient_admission_id` BIGINT COMMENT 'add column inpatient_admission_id (BIGINT) with FK to utilization.inpatient_admission.inpatient_admission_id - bed day review is on the admission',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member whose stay is under review.',
    `parent_bed_day_review_id` BIGINT COMMENT 'Self-referencing FK on bed_day_review (parent_bed_day_review_id)',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Links bed‑day review to the responsible provider to support length‑of‑stay variance analysis and readmission risk reporting.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Bed‑day reviews compare LOS against network‑specific benchmarks; network_id is required for accurate network adequacy reporting.',
    `approval_decision` STRING COMMENT 'Outcome of the review regarding continuation of stay.. Valid values are `approved|denied|pending`',
    `bed_day_review_status` STRING COMMENT 'Current lifecycle status of the bed day review.. Valid values are `pending|in_progress|completed|closed|denied`',
    `clinical_criteria_met_flag` BOOLEAN COMMENT 'Indicates whether the patient met the required clinical criteria for continued stay.',
    `clinical_criteria_set` STRING COMMENT 'Name of the clinical criteria set applied during the review (e.g., InterQual, MCG).',
    `clinical_criteria_version` STRING COMMENT 'Version of the clinical criteria set used for the assessment.',
    `clinical_status` STRING COMMENT 'Clinician-assessed health status of the patient on the review date.. Valid values are `stable|improving|deteriorating|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason_code` STRING COMMENT 'Standardized code representing the reason for denial, if applicable.',
    `denial_reason_description` STRING COMMENT 'Human-readable description of the denial reason.',
    `discharge_planning_notes` STRING COMMENT 'Narrative notes regarding discharge planning and anticipated needs.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `extension_days_approved` STRING COMMENT 'Number of additional bed days approved beyond the original length of stay.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'True if the review is flagged as critical due to clinical urgency.',
    `length_of_stay_benchmark_met_flag` BOOLEAN COMMENT 'True if the current LOS is within the acceptable benchmark range.',
    `length_of_stay_current` STRING COMMENT 'Number of days the patient has been admitted up to the review date.',
    `length_of_stay_target` STRING COMMENT 'Targeted length of stay based on clinical criteria and benchmarks.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `readmission_risk_category` STRING COMMENT 'Risk category derived from the readmission risk score.. Valid values are `low|medium|high`',
    `readmission_risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score indicating probability of readmission within 30 days.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the review complies with applicable regulations (e.g., NCQA, CMS).',
    `review_notes` STRING COMMENT 'Free-text notes entered by the reviewer during the assessment.',
    `review_number` STRING COMMENT 'Business identifier assigned to each bed day review.',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp when the bed day review was performed.',
    `reviewer_npi` BIGINT COMMENT 'NPI of the clinical reviewer who performed the bed day assessment.',
    `social_work_involved` BOOLEAN COMMENT 'Indicates whether a social worker is engaged in the patients care plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review record.',
    CONSTRAINT pk_bed_day_review PRIMARY KEY(`bed_day_review_id`)
) COMMENT 'Tracks individual bed day reviews for inpatient concurrent review cases — daily clinical assessments of continued stay medical necessity. Captures review date, reviewer, clinical status, Milliman/InterQual criteria met, extension days approved, and discharge planning notes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` (
    `um_program_enrollment_id` BIGINT COMMENT '',
    `um_program_id` BIGINT COMMENT '',
    `subscriber_id` BIGINT COMMENT '',
    `member_id` BIGINT COMMENT '',
    `enrollment_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `enrollment_date` DATE COMMENT '',
    `disenrollment_date` DATE COMMENT '',
    `status_code` STRING COMMENT '',
    `enrollment_reason_code` STRING COMMENT '',
    `opt_in_method_code` STRING COMMENT '',
    CONSTRAINT pk_um_program_enrollment PRIMARY KEY(`um_program_enrollment_id`)
) COMMENT 'This association product represents the enrollment contract between a utilization management program and an employer group. It captures the effective period of the enrollment and the contribution strategy specific to that employer group.. Existence Justification: An employer group can enroll in multiple utilization management (UM) programs, and a single UM program can be applied to many employer groups. The enrollment is actively managed, with start/end dates and contribution strategy captured for each enrollment. This relationship is therefore a true many‑to‑many operational entity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` (
    `clinical_criteria_id` BIGINT COMMENT 'Primary key for clinical_criteria',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` (
    `episode_of_care_id` BIGINT COMMENT 'Primary key for episode_of_care',
    `bundled_payment_episode_id` BIGINT COMMENT 'add column bundled_payment_episode_id (BIGINT) with FK to contract.bundled_payment_episode.bundled_payment_episode_id - episode groupers feed bundled payment settlement',
    `provider_id` BIGINT COMMENT '',
    `episode_provider_id` BIGINT COMMENT 'System identifier for the healthcare provider delivering services in this episode.',
    `health_plan_id` BIGINT COMMENT 'Identifier for the insurance plan covering the episode of care.',
    `identity_id` BIGINT COMMENT 'System identifier for the patient associated with this episode of care.',
    `inpatient_admission_id` BIGINT COMMENT '',
    `parent_episode_of_care_id` BIGINT COMMENT 'Self-referencing FK on episode_of_care (parent_episode_of_care_id)',
    `admission_date` DATE COMMENT 'Date the patient was admitted to the facility for this episode.',
    `claim_approval_date` DATE COMMENT 'Date the claim was approved by the insurer.',
    `claim_denial_reason` STRING COMMENT 'Reason code or description for claim denial, if applicable.',
    `claim_status` STRING COMMENT 'Current status of the claim associated with this episode.',
    `claim_submission_date` DATE COMMENT 'Date the claim was submitted to the insurer.',
    `classification_or_type` STRING COMMENT 'The type of care episode, indicating the setting and nature of services.',
    `complication_flag` BOOLEAN COMMENT '',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the episode record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged from the facility.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the episode of care becomes effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the episode of care ends or is terminated. Nullable for ongoing episodes.',
    `episode_end_date` DATE COMMENT '',
    `episode_number` STRING COMMENT 'External business identifier for the episode of care, used in communications and reporting.',
    `episode_start_date` DATE COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: EpisodeOfCare)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grouper_methodology_code` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `length_of_stay_days` STRING COMMENT 'Number of days the patient stayed in the facility during this episode.',
    `lifecycle_status` STRING COMMENT 'Current state of the episode of care within its lifecycle.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_necessity_decision` STRING COMMENT 'Decision on medical necessity for the episode.',
    `medical_necessity_decision_date` DATE COMMENT 'Date the medical necessity decision was made.',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Net amount due after applying payments and adjustments.',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10 code representing the primary diagnosis for the episode.',
    `prior_authorization_decision_date` DATE COMMENT 'Date the prior authorization decision was made.',
    `prior_authorization_request_date` DATE COMMENT 'Date the prior authorization was requested.',
    `prior_authorization_status` STRING COMMENT 'Current status of the prior authorization request.',
    `procedure_codes` STRING COMMENT 'Comma-separated list of procedure codes (e.g., CPT) performed during the episode.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `secondary_diagnosis_codes` STRING COMMENT 'Comma-separated list of ICD-10 codes for secondary diagnoses.',
    `severity_score` STRING COMMENT '',
    `status_code` STRING COMMENT '',
    `total_adjustments` DECIMAL(18,2) COMMENT 'Total adjustments applied to the charges (e.g., discounts, write-offs).',
    `total_charges` DECIMAL(18,2) COMMENT 'Total billed amount for services rendered in this episode.',
    `total_episode_cost` DECIMAL(18,2) COMMENT '',
    `total_payments` DECIMAL(18,2) COMMENT 'Total payments received from insurer and patient for this episode.',
    `trigger_event_code` STRING COMMENT '',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the episode record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `utilization_review_date` DATE COMMENT 'Date the utilization review was conducted.',
    `utilization_review_decision` STRING COMMENT 'Decision outcome of the utilization review.',
    `utilization_review_decision_date` DATE COMMENT 'Date the utilization review decision was finalized.',
    `utilization_review_status` STRING COMMENT 'Status of the utilization review process for this episode.',
    CONSTRAINT pk_episode_of_care PRIMARY KEY(`episode_of_care_id`)
) COMMENT 'Master reference table for episode_of_care. Referenced by episode_of_care_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_related_request_pa_request_id` FOREIGN KEY (`related_request_pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_um_reviewer_id` FOREIGN KEY (`um_reviewer_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_reviewer`(`um_reviewer_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ADD CONSTRAINT `fk_utilization_peer_to_peer_review_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ADD CONSTRAINT `fk_utilization_peer_to_peer_review_peer_pa_request_id` FOREIGN KEY (`peer_pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ADD CONSTRAINT `fk_utilization_tat_compliance_event_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_episode_of_care_id` FOREIGN KEY (`episode_of_care_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`episode_of_care`(`episode_of_care_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ADD CONSTRAINT `fk_utilization_pa_notification_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ADD CONSTRAINT `fk_utilization_um_delegation_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_parent_medical_policy_id` FOREIGN KEY (`parent_medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ADD CONSTRAINT `fk_utilization_bed_day_review_concurrent_review_id` FOREIGN KEY (`concurrent_review_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`concurrent_review`(`concurrent_review_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ADD CONSTRAINT `fk_utilization_bed_day_review_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ADD CONSTRAINT `fk_utilization_bed_day_review_parent_bed_day_review_id` FOREIGN KEY (`parent_bed_day_review_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`bed_day_review`(`bed_day_review_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` ADD CONSTRAINT `fk_utilization_um_program_enrollment_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ADD CONSTRAINT `fk_utilization_clinical_criteria_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ADD CONSTRAINT `fk_utilization_clinical_criteria_parent_clinical_criteria_id` FOREIGN KEY (`parent_clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_parent_episode_of_care_id` FOREIGN KEY (`parent_episode_of_care_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`episode_of_care`(`episode_of_care_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`utilization` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`utilization` SET TAGS ('pii_domain' = 'utilization');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('pii_subdomain' = 'authorization_management');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('pii_fhir_resource' = 'ServiceRequest');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Request Identifier (PA Request ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `pa_request_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `clinical_criteria_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Identifier (Clinical Criteria ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Decision Maker Identifier (Decision Maker ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `plan_election_id` SET TAGS ('pii_business_glossary_term' = 'Member Plan Identifier (Plan ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Identifier (Network ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `related_request_pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Related Prior Authorization Request Identifier (Related Request ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `additional_information_requests_count` SET TAGS ('pii_business_glossary_term' = 'Count of Additional Information Requests (AIR Count)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline Date (Appeal Deadline)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `clinical_criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version Used (Clinical Criteria Version)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code for Estimated Amounts (Currency Code)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `decision_maker_role` SET TAGS ('pii_business_glossary_term' = 'Role of Decision Maker (Decision Maker Role)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `decision_maker_role` SET TAGS ('pii_value_regex' = 'physician|nurse|clinical_reviewer|admin');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code (Denial Reason)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Associated Diagnosis Code (ICD Diagnosis Code)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `estimated_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Adjustment Amount (Estimated Adjustment)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `estimated_gross_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Gross Cost (Estimated Gross Amount)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `estimated_net_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Net Cost (Estimated Net Amount)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `is_appealable` SET TAGS ('pii_business_glossary_term' = 'Flag Indicating if Request is Appealable (Appealable Flag)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `is_duplicate_request` SET TAGS ('pii_business_glossary_term' = 'Flag Indicating Duplicate Prior Authorization Request (Duplicate Flag)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `last_air_due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date of Last Additional Information Request (Last AIR Due Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `last_air_received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date of Last Additional Information Request (Last AIR Received Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Free-text Notes and Comments (Notes)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `pa_request_status` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Request Status (PA Request Status)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `pa_request_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|cancelled|in_review|closed');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_age_at_request` SET TAGS ('pii_business_glossary_term' = 'Member Age at Request Submission (Member Age)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_age_at_request` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_age_at_request` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('pii_business_glossary_term' = 'Member Gender at Request Submission (Member Gender)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('pii_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `patient_gender` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `prior_auth_decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date for Prior Authorization (Decision Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Requested Service Quantity (Quantity)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Request Number (PA Request Number)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Request Submission Timestamp (PA Request Timestamp)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_type` SET TAGS ('pii_business_glossary_term' = 'Urgency Type of Prior Authorization Request (PA Urgency Type)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `request_type` SET TAGS ('pii_value_regex' = 'standard|expedited|urgent');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `service_code` SET TAGS ('pii_business_glossary_term' = 'Requested Service Code (CPT/HCPCS/Procedure Code)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `service_type` SET TAGS ('pii_business_glossary_term' = 'Requested Service Category (Service Type)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `service_type` SET TAGS ('pii_value_regex' = 'procedure|drug|admission|therapy');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `submission_channel` SET TAGS ('pii_business_glossary_term' = 'Submission Channel for Prior Authorization Request (PA Submission Channel)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `submission_channel` SET TAGS ('pii_value_regex' = 'portal|fax|phone|edi_278');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `turnaround_time_days` SET TAGS ('pii_business_glossary_term' = 'Turnaround Time in Days (TAT Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ALTER COLUMN `fhir_coverage_eligibility_request_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('pii_subdomain' = 'authorization_management');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('pii_fhir_resource' = 'CoverageEligibilityResponse');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `pa_decision_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Decision ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `medical_policy_id` SET TAGS ('pii_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `medical_policy_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `medical_policy_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID (MEMBER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Request ID (PA_REQ_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `amendment_indicator` SET TAGS ('pii_business_glossary_term' = 'Amendment Indicator (AMEND_IND)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `amendment_indicator` SET TAGS ('pii_value_regex' = 'original|amended|reversal|override');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Eligibility Flag (APPEAL_ELIG)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_end_date` SET TAGS ('pii_business_glossary_term' = 'Authorization End Date (AUTH_END_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_period_type` SET TAGS ('pii_business_glossary_term' = 'Authorization Period Type (AUTH_PERIOD_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_period_type` SET TAGS ('pii_value_regex' = 'fixed|rolling');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_quantity` SET TAGS ('pii_business_glossary_term' = 'Authorized Quantity (AUTH_QTY)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_start_date` SET TAGS ('pii_business_glossary_term' = 'Authorization Start Date (AUTH_START_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_units` SET TAGS ('pii_business_glossary_term' = 'Authorization Units (AUTH_UNITS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `authorization_units` SET TAGS ('pii_value_regex' = 'days|visits|doses|sessions');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `clinical_criteria_set` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Set (CRIT_SET)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `clinical_criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version (CRIT_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_business_glossary_term' = 'Clinical Rationale Narrative (CLIN_RAT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `criteria_effective_date` SET TAGS ('pii_business_glossary_term' = 'Criteria Effective Date (CRIT_EFF_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `criteria_met_flag` SET TAGS ('pii_business_glossary_term' = 'Criteria Met Flag (CRIT_MET)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date and Time (DECISION_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_number` SET TAGS ('pii_business_glossary_term' = 'Decision Number (DECISION_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_status` SET TAGS ('pii_business_glossary_term' = 'Decision Status (DECISION_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_status` SET TAGS ('pii_value_regex' = 'active|amended|reversed|overridden');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_type` SET TAGS ('pii_business_glossary_term' = 'Decision Type (DECISION_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `decision_type` SET TAGS ('pii_value_regex' = 'approved|denied|partially_approved|pended|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_category` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Category (DENIAL_CAT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_category` SET TAGS ('pii_value_regex' = 'medical_need|administrative|benefit_exclusion|out_of_network|experimental');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code (DENIAL_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `denial_regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Denial Regulatory Citation (DENIAL_REG_CIT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `diagnosis_codes` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Codes (ICD_CODES)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `diagnosis_codes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `diagnosis_codes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `is_telehealth` SET TAGS ('pii_business_glossary_term' = 'Telehealth Flag (TELEHEALTH_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `is_urgent` SET TAGS ('pii_business_glossary_term' = 'Urgent Flag (URGENT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `prior_auth_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number (PA_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `prior_auth_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag (REG_COMP_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_credentials` SET TAGS ('pii_business_glossary_term' = 'Reviewer Credentials (REVIEWER_CRED)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_credentials` SET TAGS ('pii_value_regex' = 'MD|RN|PharmD|NP');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_business_glossary_term' = 'Reviewer NPI (REVIEWER_NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ALTER COLUMN `fhir_coverage_eligibility_response_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('pii_subdomain' = 'authorization_management');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('pii_fhir_resource' = 'Claim.item');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `auth_service_line_id` SET TAGS ('pii_business_glossary_term' = 'Authorization Service Line ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `clinical_criteria_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorization_status` SET TAGS ('pii_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorization_status` SET TAGS ('pii_value_regex' = 'approved|partially_approved|denied|pending|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_end_date` SET TAGS ('pii_business_glossary_term' = 'Authorized Service End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_facility_npi` SET TAGS ('pii_business_glossary_term' = 'Authorized Facility NPI');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_facility_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_facility_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_facility_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_price` SET TAGS ('pii_business_glossary_term' = 'Authorized Price');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_quantity` SET TAGS ('pii_business_glossary_term' = 'Authorized Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `authorized_start_date` SET TAGS ('pii_business_glossary_term' = 'Authorized Service Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `clinical_criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `cpt_code` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `cpt_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `cpt_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `decision_timestamp` SET TAGS ('pii_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `denial_reason` SET TAGS ('pii_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `hcpcs_code` SET TAGS ('pii_business_glossary_term' = 'Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `hcpcs_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `hcpcs_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `is_emergency` SET TAGS ('pii_business_glossary_term' = 'Emergency Service Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `is_experimental` SET TAGS ('pii_business_glossary_term' = 'Experimental Service Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `is_partial_approval` SET TAGS ('pii_business_glossary_term' = 'Partial Approval Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `place_of_service` SET TAGS ('pii_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `place_of_service` SET TAGS ('pii_value_regex' = 'office|hospital|clinic|home|telehealth');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `service_category` SET TAGS ('pii_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `service_category` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|dme|pharmacy|behavioral_health|telehealth');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('pii_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `concurrent_review_id` SET TAGS ('pii_business_glossary_term' = 'Concurrent Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `audit_engagement_id` SET TAGS ('pii_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Care Coordinator ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `inpatient_admission_id` SET TAGS ('pii_business_glossary_term' = 'Admission ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `um_case_id` SET TAGS ('pii_business_glossary_term' = 'Utilization Management Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `actual_discharge_date` SET TAGS ('pii_business_glossary_term' = 'Actual Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `admission_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `approved_length_of_stay` SET TAGS ('pii_business_glossary_term' = 'Approved Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `authorized_post_acute_service` SET TAGS ('pii_business_glossary_term' = 'Authorized Post‑Acute Service');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `benchmark_source` SET TAGS ('pii_business_glossary_term' = 'Benchmark Source');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `benchmark_source` SET TAGS ('pii_value_regex' = 'cms|milliman|plan_actuarial');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `benchmark_source_detail` SET TAGS ('pii_business_glossary_term' = 'Benchmark Source Detail');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `clinical_reviewer_npi` SET TAGS ('pii_business_glossary_term' = 'Clinical Reviewer NPI');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `clinical_reviewer_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `clinical_reviewer_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `clinical_reviewer_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `concurrent_review_status` SET TAGS ('pii_business_glossary_term' = 'Concurrent Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `concurrent_review_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|approved|denied|closed');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `current_length_of_stay` SET TAGS ('pii_business_glossary_term' = 'Current Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `discharge_barriers` SET TAGS ('pii_business_glossary_term' = 'Discharge Barriers');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `discharge_destination` SET TAGS ('pii_business_glossary_term' = 'Discharge Destination');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `discharge_destination` SET TAGS ('pii_value_regex' = 'home|snf|ltac|home_health|hospice');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Review Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `justification` SET TAGS ('pii_business_glossary_term' = 'Stay Continuation Justification');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `los_benchmark_mean` SET TAGS ('pii_business_glossary_term' = 'Length of Stay Benchmark Mean (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `los_benchmark_outlier_threshold` SET TAGS ('pii_business_glossary_term' = 'Length of Stay Outlier Threshold (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `los_benchmark_target` SET TAGS ('pii_business_glossary_term' = 'Length of Stay Benchmark Target (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `planned_discharge_date` SET TAGS ('pii_business_glossary_term' = 'Planned Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `readmission_risk_category` SET TAGS ('pii_business_glossary_term' = 'Readmission Risk Category');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `readmission_risk_category` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `readmission_risk_score` SET TAGS ('pii_business_glossary_term' = 'Readmission Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Review End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_notes` SET TAGS ('pii_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Concurrent Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Review Start Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'concurrent|retrospective');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `social_work_involved` SET TAGS ('pii_business_glossary_term' = 'Social Work Involvement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` SET TAGS ('pii_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `retrospective_review_id` SET TAGS ('pii_business_glossary_term' = 'Retrospective Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `gap_id` SET TAGS ('pii_business_glossary_term' = 'Care Gap Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `provider_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `provider_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `um_reviewer_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `um_reviewer_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `um_reviewer_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `adjusted_amount` SET TAGS ('pii_business_glossary_term' = 'Adjusted Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `adjusted_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Applied');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_value_regex' = 'InterQual|MCG');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `compliance_state` SET TAGS ('pii_business_glossary_term' = 'Compliance State');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `compliance_state` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `documentation_completeness_flag` SET TAGS ('pii_business_glossary_term' = 'Documentation Completeness Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `documentation_received_date` SET TAGS ('pii_business_glossary_term' = 'Documentation Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `medical_necessity_outcome` SET TAGS ('pii_business_glossary_term' = 'Medical Necessity Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `medical_necessity_outcome` SET TAGS ('pii_value_regex' = 'approved|denied|partial');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `medical_necessity_outcome` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `medical_necessity_outcome` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `retro_review_deadline_flag` SET TAGS ('pii_business_glossary_term' = 'Retro Review Deadline Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `review_initiation_date` SET TAGS ('pii_business_glossary_term' = 'Review Initiation Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `review_notes` SET TAGS ('pii_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Retrospective Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `review_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending|in_review|completed|closed');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'retrospective|post_admission');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Date of Service');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` SET TAGS ('pii_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `peer_to_peer_review_id` SET TAGS ('pii_business_glossary_term' = 'Peer To Peer Review Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Associated Claim Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `header_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `header_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Peer-to-Peer Review Request Identifier (REQ_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `peer_pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Associated Prior Authorization Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `peer_pa_request_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `peer_pa_request_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `completed_date` SET TAGS ('pii_business_glossary_term' = 'Completed Review Date and Time');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `deadline_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Deadline Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `outcome_description` SET TAGS ('pii_business_glossary_term' = 'Review Outcome Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Request Date and Time');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `review_duration_days` SET TAGS ('pii_business_glossary_term' = 'Review Duration (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `review_outcome` SET TAGS ('pii_business_glossary_term' = 'Peer-to-Peer Review Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `review_outcome` SET TAGS ('pii_value_regex' = 'upheld_denial|partial_approval|full_reversal');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Peer-to-Peer Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `reviewer_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Reviewer Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `reviewer_provider_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `reviewer_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `reviewer_provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Review Date and Time');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` SET TAGS ('pii_subdomain' = 'program_operations');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `tat_compliance_event_id` SET TAGS ('pii_business_glossary_term' = 'Turnaround Time (TAT) Compliance Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `provider_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `provider_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag (True if within TAT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `decision_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `due_timestamp` SET TAGS ('pii_business_glossary_term' = 'Decision Due Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Compliance Event Log Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Compliance Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction (State or Federal)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'medical|dental|vision|pharmacy|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes or Comments');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `receipt_timestamp` SET TAGS ('pii_business_glossary_term' = 'Request Receipt Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `regulatory_reporting_period` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Period');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `regulatory_reporting_period` SET TAGS ('pii_value_regex' = '^d{4}Q[1-4]$');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type (e.g., Prior Authorization, Concurrent Review)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'prior_authorization|concurrent_review|retrospective_review|utilization_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `root_cause_category` SET TAGS ('pii_business_glossary_term' = 'Root Cause Category for Non-Compliance');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `root_cause_category` SET TAGS ('pii_value_regex' = 'staffing|documentation|escalation|system|other');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `root_cause_detail` SET TAGS ('pii_business_glossary_term' = 'Root Cause Detail Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `tat_standard_days` SET TAGS ('pii_business_glossary_term' = 'Configured TAT Standard (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `tat_standard_hours` SET TAGS ('pii_business_glossary_term' = 'Configured TAT Standard (Hours)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `urgency_level` SET TAGS ('pii_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `urgency_level` SET TAGS ('pii_value_regex' = 'routine|urgent|stat');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `variance_days` SET TAGS ('pii_business_glossary_term' = 'Variance from TAT Standard (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ALTER COLUMN `variance_hours` SET TAGS ('pii_business_glossary_term' = 'Variance from TAT Standard (Hours)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('pii_subdomain' = 'program_operations');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('pii_fhir_resource' = 'Task');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `um_case_id` SET TAGS ('pii_business_glossary_term' = 'Utilization Management Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Care Coordinator Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned UM Nurse ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `episode_of_care_id` SET TAGS ('pii_business_glossary_term' = 'Episode of Care ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Primary Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `um_program_id` SET TAGS ('pii_business_glossary_term' = 'Um Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `appeal_indicator` SET TAGS ('pii_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `assigned_nurse_name` SET TAGS ('pii_business_glossary_term' = 'Assigned UM Nurse Name');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_close_date` SET TAGS ('pii_business_glossary_term' = 'Case Close Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_number` SET TAGS ('pii_business_glossary_term' = 'Utilization Management Case Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_open_date` SET TAGS ('pii_business_glossary_term' = 'Case Open Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_priority` SET TAGS ('pii_business_glossary_term' = 'Case Priority');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_priority` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_severity` SET TAGS ('pii_business_glossary_term' = 'Case Severity');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_severity` SET TAGS ('pii_value_regex' = 'critical|moderate|minor');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_status` SET TAGS ('pii_business_glossary_term' = 'Utilization Management Case Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_status` SET TAGS ('pii_value_regex' = 'open|closed|in_review|denied|approved|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_type` SET TAGS ('pii_business_glossary_term' = 'Utilization Management Case Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `case_type` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|behavioral|dme|pharmacy|other');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `clinical_criteria_set` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Set');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `clinical_criteria_set` SET TAGS ('pii_value_regex' = 'InterQual|MCG');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `clinical_criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `disposition_code` SET TAGS ('pii_business_glossary_term' = 'Case Disposition Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `disposition_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `disposition_description` SET TAGS ('pii_business_glossary_term' = 'Case Disposition Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `length_of_stay_actual` SET TAGS ('pii_business_glossary_term' = 'Actual Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `length_of_stay_target` SET TAGS ('pii_business_glossary_term' = 'Target Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Case Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `notes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Primary Provider NPI');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `primary_provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `prior_authorization_decision_date` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `prior_authorization_status` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `prior_authorization_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|expired');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `turnaround_time_days` SET TAGS ('pii_business_glossary_term' = 'Case Turnaround Time (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ALTER COLUMN `urgency_flag` SET TAGS ('pii_business_glossary_term' = 'Urgency Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` SET TAGS ('pii_subdomain' = 'program_operations');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `um_reviewer_id` SET TAGS ('pii_business_glossary_term' = 'UM Reviewer ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `um_workforce_employee_id` SET TAGS ('pii_business_glossary_term' = 'Workforce Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `um_workforce_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `um_workforce_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `assigned_review_queue` SET TAGS ('pii_business_glossary_term' = 'Assigned Review Queue');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `compliance_state` SET TAGS ('pii_business_glossary_term' = 'Compliance State');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `compliance_state` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending|under_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `country` SET TAGS ('pii_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `country` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `credential_type` SET TAGS ('pii_business_glossary_term' = 'Credential Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `credential_type` SET TAGS ('pii_value_regex' = 'RN|MD|PharmD|LCSW|NP|PA');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Date of Birth (DOB) (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `date_of_birth` SET TAGS ('pii_fhir_element' = 'birthDate');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `delegation_authority_level` SET TAGS ('pii_business_glossary_term' = 'Delegation Authority Level');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `delegation_authority_level` SET TAGS ('pii_value_regex' = 'none|review|approve|escalate|admin');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `email_address` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'First Name (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `first_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `full_name` SET TAGS ('pii_business_glossary_term' = 'Full Name (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `full_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `full_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `full_name` SET TAGS ('pii_fhir_element' = 'name.text');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `hire_date` SET TAGS ('pii_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Last Name (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `last_name` SET TAGS ('pii_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `last_training_date` SET TAGS ('pii_business_glossary_term' = 'Last Training Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'Professional License Number (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `license_state` SET TAGS ('pii_business_glossary_term' = 'License State');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Middle Name (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `middle_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `ncqa_qualified_flag` SET TAGS ('pii_business_glossary_term' = 'NCQA Qualification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `next_training_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `reviewer_status` SET TAGS ('pii_business_glossary_term' = 'Reviewer Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `reviewer_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|retired|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `specialty` SET TAGS ('pii_business_glossary_term' = 'Clinical Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `state` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `street_address` SET TAGS ('pii_business_glossary_term' = 'Street Address (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `street_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `street_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `urac_qualified_flag` SET TAGS ('pii_business_glossary_term' = 'URAC Qualification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Record Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'ZIP Code (PII)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ALTER COLUMN `zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` SET TAGS ('pii_subdomain' = 'authorization_management');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `pa_notification_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Notification ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim ID (CLAIM_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `header_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `header_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `facility_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID (FAC_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `facility_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `facility_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID (MEM_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID (CREATED_BY_UID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID (PROV_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `provider_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `provider_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Timestamp (ACK_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `approval_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Approval Expiration Date (APPROVAL_EXP_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `attachment_indicator` SET TAGS ('pii_business_glossary_term' = 'Attachment Indicator (ATTACH_IND)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `compliance_state` SET TAGS ('pii_business_glossary_term' = 'Compliance State (COMP_STATE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `compliance_state` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `decision_reference` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Decision Reference (PA_DEC_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `delivery_channel` SET TAGS ('pii_business_glossary_term' = 'Delivery Channel (DELIV_CHAN)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `delivery_channel` SET TAGS ('pii_value_regex' = 'mail|fax|portal|phone|email');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `delivery_status` SET TAGS ('pii_business_glossary_term' = 'Delivery Status (DELIV_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `delivery_status` SET TAGS ('pii_value_regex' = 'sent|delivered|failed|pending_acknowledgment');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `delivery_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delivery Timestamp (DELIV_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code (DENIAL_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description (DENIAL_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `is_urgent` SET TAGS ('pii_business_glossary_term' = 'Urgent Flag (URGENT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code (LANG_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = 'EN|ES|FR|DE|ZH|JA');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `language_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `message_body` SET TAGS ('pii_business_glossary_term' = 'Message Body (MSG_BODY)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `notification_number` SET TAGS ('pii_business_glossary_term' = 'Notification Number (NOTIF_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `notification_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `notification_status` SET TAGS ('pii_business_glossary_term' = 'Notification Lifecycle Status (NOTIF_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `notification_status` SET TAGS ('pii_value_regex' = 'draft|queued|sent|completed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `notification_type` SET TAGS ('pii_business_glossary_term' = 'Notification Type (NOTIF_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `notification_type` SET TAGS ('pii_value_regex' = 'approval|denial|pend|expedited_acknowledgment');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level (PRIORITY_LVL)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `recipient_type` SET TAGS ('pii_business_glossary_term' = 'Recipient Type (RECIP_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `recipient_type` SET TAGS ('pii_value_regex' = 'member|provider|facility');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference (REG_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_value_regex' = 'ACA|CMS_MA|STATE_MANDATE|NONE');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `sent_timestamp` SET TAGS ('pii_business_glossary_term' = 'Sent Timestamp (SENT_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('pii_subdomain' = 'episode_grouping');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('pii_fhir_resource' = 'Encounter');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `inpatient_admission_id` SET TAGS ('pii_business_glossary_term' = 'Inpatient Admission ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `clinical_criteria_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_cost_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `actual_los_days` SET TAGS ('pii_business_glossary_term' = 'Actual Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_number` SET TAGS ('pii_business_glossary_term' = 'Admission Number (ADM_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_status` SET TAGS ('pii_business_glossary_term' = 'Admission Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_status` SET TAGS ('pii_value_regex' = 'admitted|discharged|cancelled|transferred');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_type` SET TAGS ('pii_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `admission_type` SET TAGS ('pii_value_regex' = 'elective|urgent|emergent|other');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `authorization_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `authorization_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `authorization_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `clinical_criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `discharge_disposition` SET TAGS ('pii_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `discharge_disposition` SET TAGS ('pii_value_regex' = 'home|snf|rehab|expired|other');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Related Group (DRG) Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `drg_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Expected Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_cost_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `expected_los_days` SET TAGS ('pii_business_glossary_term' = 'Expected Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `facility_npi` SET TAGS ('pii_business_glossary_term' = 'Facility NPI (National Provider Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `facility_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `facility_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `facility_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `is_critical_care` SET TAGS ('pii_business_glossary_term' = 'Critical Care Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `is_readmission` SET TAGS ('pii_business_glossary_term' = 'Readmission Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `los_benchmark_met_flag` SET TAGS ('pii_business_glossary_term' = 'LOS Benchmark Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `los_target_days` SET TAGS ('pii_business_glossary_term' = 'Length of Stay Target (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `payer_authorization_status` SET TAGS ('pii_business_glossary_term' = 'Payer Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `payer_authorization_status` SET TAGS ('pii_value_regex' = 'authorized|pending|denied|not_required');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `physician_npi` SET TAGS ('pii_business_glossary_term' = 'Attending Physician NPI');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `physician_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `physician_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `physician_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `readmission_within_30_days` SET TAGS ('pii_business_glossary_term' = '30‑Day Readmission Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_decision` SET TAGS ('pii_business_glossary_term' = 'Review Decision');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_decision` SET TAGS ('pii_value_regex' = 'approved|denied|partial|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_decision_date` SET TAGS ('pii_business_glossary_term' = 'Review Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending|completed|escalated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` SET TAGS ('pii_subdomain' = 'program_operations');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` SET TAGS ('pii_fhir_resource' = 'CareTeam');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `um_program_id` SET TAGS ('pii_business_glossary_term' = 'Utilization Management Program Identifier (UM Program ID)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Program Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `accreditation_category` SET TAGS ('pii_business_glossary_term' = 'Accreditation Category (UM Accreditation Category)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `accreditation_category` SET TAGS ('pii_value_regex' = 'tat|criteria|notification|delegation|p2p');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status (UM Accreditation Status)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `accreditation_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `accreditation_survey_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Survey Date (UM Accreditation Survey Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `clinical_criteria_set` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Set (UM Clinical Criteria)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Compliance Notes (UM Compliance Notes)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (UM Record Created)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `criteria_effective_date` SET TAGS ('pii_business_glossary_term' = 'Criteria Effective Date (UM Criteria Effective Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `criteria_version` SET TAGS ('pii_business_glossary_term' = 'Criteria Version (UM Criteria Version)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `um_program_description` SET TAGS ('pii_business_glossary_term' = 'Program Description (UM Program Description)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date (UM Effective From)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date (UM Effective Until)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `gap_analysis_date` SET TAGS ('pii_business_glossary_term' = 'Gap Analysis Date (UM Gap Analysis Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `gap_analysis_status` SET TAGS ('pii_business_glossary_term' = 'Gap Analysis Status (UM Gap Analysis Status)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `gap_analysis_status` SET TAGS ('pii_value_regex' = 'open|closed|in_progress');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'individual|group|medicare|medicaid|exchange|self_funded');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `next_review_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Due Date (UM Review Due Date)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `pa_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required (PA Required)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code (UM Program Code)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `program_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Program Name (UM Program Name)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `program_notes` SET TAGS ('pii_business_glossary_term' = 'Program Notes (UM Program Notes)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Program Type (UM Program Type)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `program_type` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|behavioral|pharmacy|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `program_version` SET TAGS ('pii_business_glossary_term' = 'Program Version (UM Program Version)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference (UM Regulatory Reference)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `review_type_scope` SET TAGS ('pii_business_glossary_term' = 'Review Type Scope (UM Review Scope)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `review_type_scope` SET TAGS ('pii_value_regex' = 'concurrent|retrospective|both');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `services_covered` SET TAGS ('pii_business_glossary_term' = 'Services Covered (UM Services Covered)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `um_program_status` SET TAGS ('pii_business_glossary_term' = 'Program Status (UM Program Status)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `um_program_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UM Record Updated)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` SET TAGS ('pii_subdomain' = 'authorization_management');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `pa_required_service_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Service ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `clinical_criteria_set` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Set');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `exemption_type` SET TAGS ('pii_business_glossary_term' = 'Exemption Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `exemption_type` SET TAGS ('pii_value_regex' = 'state_mandate|cms_requirement|gold_card|plan_policy|none');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_approval_rate_met_flag` SET TAGS ('pii_business_glossary_term' = 'Gold Card Approval Rate Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_approval_rate_threshold` SET TAGS ('pii_business_glossary_term' = 'Gold Card Approval Rate Threshold (%)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_effective_date` SET TAGS ('pii_business_glossary_term' = 'Gold Card Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Gold Card Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_flag` SET TAGS ('pii_business_glossary_term' = 'Gold Card Override Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Gold Card Provider NPI');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_provider_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `gold_card_revocation_reason` SET TAGS ('pii_business_glossary_term' = 'Gold Card Revocation Reason');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|group|individual');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `pa_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `pa_required_service_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `pa_required_service_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `pa_type` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `pa_type` SET TAGS ('pii_value_regex' = 'standard|expedited|concurrent|none');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `provider_specialty_exemption_flag` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Exemption Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `service_code` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) or Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `service_description` SET TAGS ('pii_business_glossary_term' = 'Service Description (Full Name)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` SET TAGS ('pii_subdomain' = 'program_operations');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `um_delegation_id` SET TAGS ('pii_business_glossary_term' = 'Utilization Management Delegation ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `um_program_id` SET TAGS ('pii_business_glossary_term' = 'Um Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `audit_result_status` SET TAGS ('pii_business_glossary_term' = 'Audit Result Status (AUDIT_RESULT)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `audit_result_status` SET TAGS ('pii_value_regex' = 'pass|fail|conditional|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `audit_schedule_date` SET TAGS ('pii_business_glossary_term' = 'Audit Schedule Date (AUDIT_SCHED_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'NCQA Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `contract_terms_description` SET TAGS ('pii_business_glossary_term' = 'Contract Terms Description (CONTRACT_TERMS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Reference (CAP_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `delegated_entity_type` SET TAGS ('pii_business_glossary_term' = 'Delegated Entity Type (ENTITY_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `delegated_entity_type` SET TAGS ('pii_value_regex' = 'tpa|health_system|aco|ipa|specialty_vendor');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `delegated_functions` SET TAGS ('pii_business_glossary_term' = 'Delegated UM Functions (DELEGATED_FUNCS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `delegated_functions` SET TAGS ('pii_value_regex' = 'prior_authorization|concurrent_review|retrospective_review|utilization_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `delegation_number` SET TAGS ('pii_business_glossary_term' = 'Delegation Number (DELEGATION_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `delegation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `delegation_status` SET TAGS ('pii_business_glossary_term' = 'Delegation Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `delegation_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `performance_metric_actual_days` SET TAGS ('pii_business_glossary_term' = 'Performance Metric Actual (PERF_ACTUAL_DAYS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `performance_metric_target_days` SET TAGS ('pii_business_glossary_term' = 'Performance Metric Target (PERF_TARGET_DAYS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `sub_delegation_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Sub‑Delegation Allowed Flag (SUB_DELEG_ALLOWED)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_business_glossary_term' = 'Termination Reason Code (TERM_REASON_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `termination_reason_description` SET TAGS ('pii_business_glossary_term' = 'Termination Reason Description (TERM_REASON_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('pii_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('pii_fhir_resource' = 'Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_id` SET TAGS ('pii_business_glossary_term' = 'Medical Policy ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('pii_business_glossary_term' = 'Parent Medical Policy Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `parent_medical_policy_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `applicable_cpt_codes` SET TAGS ('pii_business_glossary_term' = 'Applicable CPT Codes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `applicable_hcpcs_codes` SET TAGS ('pii_business_glossary_term' = 'Applicable HCPCS Codes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `clinical_category` SET TAGS ('pii_business_glossary_term' = 'Clinical Category');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `clinical_criteria_source` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Source');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `clinical_criteria_source` SET TAGS ('pii_value_regex' = 'interqual|mcg|internal');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `clinical_criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non‑compliant|pending|exempt');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_amount` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_currency` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_units` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Units');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `coverage_limit_units` SET TAGS ('pii_value_regex' = 'visits|days|doses|sessions|procedures');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_emergency_covered` SET TAGS ('pii_business_glossary_term' = 'Emergency Service Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_exempt` SET TAGS ('pii_business_glossary_term' = 'Exemption Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_experimental_covered` SET TAGS ('pii_business_glossary_term' = 'Experimental Service Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_prior_auth_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `is_telehealth_covered` SET TAGS ('pii_business_glossary_term' = 'Telehealth Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `last_reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('pii_business_glossary_term' = 'Medical Policy Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending|draft|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `medical_policy_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_business_glossary_term' = 'Medical Policy Name');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Medical Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_type` SET TAGS ('pii_business_glossary_term' = 'Medical Policy Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `policy_type` SET TAGS ('pii_value_regex' = 'medical|surgical|behavioral|pharmacy|diagnostic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `prior_auth_approval_timeframe_days` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Approval Timeframe (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `version_effective_date` SET TAGS ('pii_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `version_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Version Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` SET TAGS ('pii_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `bed_day_review_id` SET TAGS ('pii_business_glossary_term' = 'Bed Day Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `concurrent_review_id` SET TAGS ('pii_business_glossary_term' = 'Concurrent Review Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Care Coordinator Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `parent_bed_day_review_id` SET TAGS ('pii_business_glossary_term' = 'Parent Bed Day Review Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `parent_bed_day_review_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `approval_decision` SET TAGS ('pii_business_glossary_term' = 'Approval Decision');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `approval_decision` SET TAGS ('pii_value_regex' = 'approved|denied|pending');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `bed_day_review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `bed_day_review_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|closed|denied');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `clinical_criteria_met_flag` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `clinical_criteria_set` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Set');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `clinical_criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `clinical_status` SET TAGS ('pii_business_glossary_term' = 'Clinical Status of Patient');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `clinical_status` SET TAGS ('pii_value_regex' = 'stable|improving|deteriorating|critical');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `discharge_planning_notes` SET TAGS ('pii_business_glossary_term' = 'Discharge Planning Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `extension_days_approved` SET TAGS ('pii_business_glossary_term' = 'Approved Extension Days');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Review Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `length_of_stay_benchmark_met_flag` SET TAGS ('pii_business_glossary_term' = 'Length of Stay Benchmark Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `length_of_stay_current` SET TAGS ('pii_business_glossary_term' = 'Current Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `length_of_stay_target` SET TAGS ('pii_business_glossary_term' = 'Target Length of Stay (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `readmission_risk_category` SET TAGS ('pii_business_glossary_term' = 'Readmission Risk Category');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `readmission_risk_category` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `readmission_risk_score` SET TAGS ('pii_business_glossary_term' = 'Readmission Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `review_notes` SET TAGS ('pii_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Bed Day Review Number (BDR#)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `review_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Review Date and Time');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_business_glossary_term' = 'Reviewer National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `reviewer_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `social_work_involved` SET TAGS ('pii_business_glossary_term' = 'Social Work Involvement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_subdomain' = 'program_operations');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_association_edges' = 'utilization.um_program,employer.employer_group');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_fhir_resource' = 'EnrollmentRequest');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('pii_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `clinical_criteria_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `medical_policy_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `medical_policy_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `parent_clinical_criteria_id` SET TAGS ('pii_business_glossary_term' = 'Parent Clinical Criteria Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `parent_clinical_criteria_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_category` SET TAGS ('pii_business_glossary_term' = 'Criteria Category');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_code` SET TAGS ('pii_business_glossary_term' = 'Criteria Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_description` SET TAGS ('pii_business_glossary_term' = 'Criteria Description');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_detail` SET TAGS ('pii_business_glossary_term' = 'Criteria Detail');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_effective_date` SET TAGS ('pii_business_glossary_term' = 'Criteria Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Criteria Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_limit_unit` SET TAGS ('pii_business_glossary_term' = 'Criteria Limit Unit');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_limit_value` SET TAGS ('pii_business_glossary_term' = 'Criteria Limit Value');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_name` SET TAGS ('pii_business_glossary_term' = 'Criteria Name');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_notes` SET TAGS ('pii_business_glossary_term' = 'Criteria Notes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_reference` SET TAGS ('pii_business_glossary_term' = 'Criteria Reference');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_rule_expression` SET TAGS ('pii_business_glossary_term' = 'Criteria Rule Expression');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_source` SET TAGS ('pii_business_glossary_term' = 'Criteria Source');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_status` SET TAGS ('pii_business_glossary_term' = 'Criteria Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_subcategory` SET TAGS ('pii_business_glossary_term' = 'Criteria Subcategory');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_threshold_unit` SET TAGS ('pii_business_glossary_term' = 'Criteria Threshold Unit');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_threshold_value` SET TAGS ('pii_business_glossary_term' = 'Criteria Threshold Value');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_type` SET TAGS ('pii_business_glossary_term' = 'Criteria Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `criteria_version` SET TAGS ('pii_business_glossary_term' = 'Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_subdomain' = 'episode_grouping');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_fhir_resource' = 'EpisodeOfCare');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_mvm_grouper' = 'core');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_mvm_priority' = 'critical');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_mvm_scope' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_scope' = 'mvm');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `episode_of_care_id` SET TAGS ('pii_business_glossary_term' = 'Episode Of Care Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `episode_of_care_id` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `episode_provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `episode_provider_id` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `identity_id` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `parent_episode_of_care_id` SET TAGS ('pii_business_glossary_term' = 'Parent Episode Of Care Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `parent_episode_of_care_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `parent_episode_of_care_id` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `admission_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `admission_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `claim_approval_date` SET TAGS ('pii_business_glossary_term' = 'Claim Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `claim_approval_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `claim_denial_reason` SET TAGS ('pii_business_glossary_term' = 'Claim Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `claim_denial_reason` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `claim_status` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `claim_submission_date` SET TAGS ('pii_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `claim_submission_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `classification_or_type` SET TAGS ('pii_business_glossary_term' = 'Classification Or Type');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `classification_or_type` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `created_at` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `created_timestamp` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `data_quality_score` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `discharge_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_end_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_from` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_start_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `effective_until` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `episode_number` SET TAGS ('pii_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `episode_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `episode_number` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `is_active` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `length_of_stay_days` SET TAGS ('pii_business_glossary_term' = 'Length Of Stay Days');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `length_of_stay_days` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `master_entity_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `medical_necessity_decision` SET TAGS ('pii_business_glossary_term' = 'Medical Necessity Decision');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `medical_necessity_decision` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `medical_necessity_decision` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `medical_necessity_decision` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `medical_necessity_decision_date` SET TAGS ('pii_business_glossary_term' = 'Medical Necessity Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `medical_necessity_decision_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `medical_necessity_decision_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `medical_necessity_decision_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `net_amount_due` SET TAGS ('pii_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `net_amount_due` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `prior_authorization_decision_date` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `prior_authorization_decision_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `prior_authorization_request_date` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `prior_authorization_request_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `prior_authorization_status` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `prior_authorization_status` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `procedure_codes` SET TAGS ('pii_business_glossary_term' = 'Procedure Codes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `procedure_codes` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_created_at` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_source_system` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_status` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_updated_at` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `record_version` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_business_glossary_term' = 'Secondary Diagnosis Codes');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `total_adjustments` SET TAGS ('pii_business_glossary_term' = 'Total Adjustments');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `total_adjustments` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `total_charges` SET TAGS ('pii_business_glossary_term' = 'Total Charges');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `total_charges` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `total_payments` SET TAGS ('pii_business_glossary_term' = 'Total Payments');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `total_payments` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `updated_at` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `utilization_review_date` SET TAGS ('pii_business_glossary_term' = 'Utilization Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `utilization_review_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `utilization_review_decision` SET TAGS ('pii_business_glossary_term' = 'Utilization Review Decision');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `utilization_review_decision` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `utilization_review_decision_date` SET TAGS ('pii_business_glossary_term' = 'Utilization Review Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `utilization_review_decision_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `utilization_review_status` SET TAGS ('pii_business_glossary_term' = 'Utilization Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ALTER COLUMN `utilization_review_status` SET TAGS ('pii_mvm' = 'true');
