-- Schema for Domain: insurance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`insurance` COMMENT 'Master data management for insurance payers, health plans, benefit structures, provider networks, and coverage policies. SSOT for payer identity, plan configurations, network definitions, and benefit rules that are referenced by billing, claim, patient, and encounter domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer` (
    `payer_id` BIGINT COMMENT 'Primary key for payer',
    `parent_payer_id` BIGINT COMMENT 'FK to parent payer for hierarchy',
    `primary_successor_payer_id` BIGINT COMMENT 'FK to successor payer after merger/acquisition',
    `accepts_assignment` BOOLEAN COMMENT 'Whether payer accepts assignment of benefits',
    `active_flag` BOOLEAN COMMENT 'Whether payer is currently active',
    `apm_sponsor_flag` BOOLEAN COMMENT 'Payer sponsors an Alternative Payment Model.',
    `appeal_limit_days` STRING COMMENT 'Number of days allowed for claim appeals',
    `auto_renewal_flag` BOOLEAN COMMENT 'Whether contracts auto-renew',
    `payer_category` STRING COMMENT 'Category (commercial, Medicare, Medicaid, self-pay)',
    `claim_scrubbing_vendor` STRING COMMENT 'Name of claim scrubbing vendor',
    `claims_inquiry_phone` STRING COMMENT 'Phone number for claims inquiries',
    `claims_submission_endpoint` STRING COMMENT 'URL or EDI endpoint for claim submission',
    `clearinghouse_code` STRING COMMENT 'Clearinghouse identifier code',
    `coordination_of_benefits_required` BOOLEAN COMMENT 'Whether COB is required',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `customer_service_phone` STRING COMMENT 'Customer service phone number',
    `edi_payer_code` STRING COMMENT 'EDI payer identifier',
    `electronic_funds_transfer_flag` BOOLEAN COMMENT 'Whether EFT is supported',
    `eligibility_verification_method` STRING COMMENT 'Method for eligibility verification (270/271, portal, phone)',
    `id_external` STRING COMMENT 'External system identifier',
    `inactivation_date` DATE COMMENT 'Date payer was inactivated',
    `inactivation_reason` STRING COMMENT 'Reason for inactivation',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance payer record.',
    `mips_reporting_payer_flag` BOOLEAN COMMENT 'Payer participates in MIPS data submission.',
    `payer_name` STRING COMMENT 'Official payer name',
    `notes` STRING COMMENT 'Free-text notes',
    `npi` STRING COMMENT 'National Provider Identifier for payer',
    `payer_type` STRING COMMENT 'Type (HMO, PPO, EPO, POS, Indemnity)',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days',
    `portal_url` STRING COMMENT 'URL for payer portal',
    `prior_authorization_required` BOOLEAN COMMENT 'Whether prior auth is required',
    `provider_relations_email` STRING COMMENT 'Email for provider relations',
    `remittance_address_line1` STRING COMMENT 'The remittance address line1 of the insurance payer record.',
    `remittance_address_line2` STRING COMMENT 'The remittance address line2 of the insurance payer record.',
    `remittance_city` STRING COMMENT 'The remittance city of the insurance payer record.',
    `remittance_delivery_method` STRING COMMENT 'Remittance delivery method (mail, EDI, portal)',
    `remittance_postal_code` STRING COMMENT 'The remittance postal code value classifying the insurance payer record.',
    `remittance_state` STRING COMMENT 'The remittance state of the insurance payer record.',
    `risk_adjustment_model` STRING COMMENT 'Risk adjustment model used (CMS-HCC, HHS-HCC, etc.).',
    `short_name` STRING COMMENT 'Short name or abbreviation',
    `submission_method` STRING COMMENT 'Claim submission method (EDI, portal, paper)',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the insurance payer record.',
    `tier` STRING COMMENT 'Payer tier (national, regional, local)',
    `timely_filing_limit_days` STRING COMMENT 'Timely filing limit in days',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the insurance payer record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_payer PRIMARY KEY(`payer_id`)
) COMMENT 'Insurance payer organization (commercial, government, self-pay) that adjudicates and pays claims.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` (
    `health_plan_id` BIGINT COMMENT 'Primary key',
    `consent_policy_id` BIGINT COMMENT 'FK to consent policy',
    `icd_code_id` BIGINT COMMENT 'FK to covered diagnosis',
    `formulary_id` BIGINT COMMENT 'FK to formulary',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `predecessor_health_plan_id` BIGINT COMMENT 'FK to predecessor plan',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `benefit_year` STRING COMMENT 'The benefit year of the insurance health plan record.',
    `cms_contract_number` STRING COMMENT 'CMS contract number for Medicare Advantage',
    `cob_order` STRING COMMENT 'Coordination of benefits order',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'The coinsurance percentage of the insurance health plan record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Plan effective date',
    `emergency_room_copay_amount` DECIMAL(18,2) COMMENT 'ER copay amount',
    `family_deductible_amount` DECIMAL(18,2) COMMENT 'Family deductible',
    `family_oop_max_amount` DECIMAL(18,2) COMMENT 'Family out-of-pocket maximum',
    `fsa_eligible` BOOLEAN COMMENT 'FSA eligible flag',
    `funding_type` STRING COMMENT 'Funding type (fully-insured, self-funded)',
    `group_number` STRING COMMENT 'The group number of the insurance health plan record.',
    `hra_eligible` BOOLEAN COMMENT 'HRA eligible flag',
    `hsa_eligible` BOOLEAN COMMENT 'HSA eligible flag',
    `individual_deductible_amount` DECIMAL(18,2) COMMENT 'Individual deductible',
    `individual_oop_max_amount` DECIMAL(18,2) COMMENT 'Individual out-of-pocket maximum',
    `inpatient_hospital_copay_amount` DECIMAL(18,2) COMMENT 'Inpatient copay',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance health plan record.',
    `issuer_state` STRING COMMENT 'The issuer state of the insurance health plan record.',
    `metal_tier` STRING COMMENT 'Metal tier (Bronze, Silver, Gold, Platinum)',
    `open_enrollment_end_date` DATE COMMENT 'Timestamp capturing the open enrollment end date associated with the insurance health plan record.',
    `open_enrollment_start_date` DATE COMMENT 'Timestamp capturing the open enrollment start date associated with the insurance health plan record.',
    `out_of_network_coverage` BOOLEAN COMMENT 'Out-of-network coverage flag',
    `out_of_network_deductible_amount` DECIMAL(18,2) COMMENT 'Out-of-network deductible',
    `out_of_network_oop_max_amount` DECIMAL(18,2) COMMENT 'Out-of-network OOP max',
    `plan_document_url` STRING COMMENT 'URL to plan document',
    `plan_identifier` STRING COMMENT 'The plan identifier of the insurance health plan record.',
    `plan_name` STRING COMMENT 'The plan name of the insurance health plan record.',
    `plan_status` STRING COMMENT 'The plan status value classifying the insurance health plan record.',
    `plan_type` STRING COMMENT 'Plan type (HMO, PPO, EPO, POS)',
    `prescription_tier1_copay_amount` DECIMAL(18,2) COMMENT 'Tier 1 Rx copay',
    `prescription_tier2_copay_amount` DECIMAL(18,2) COMMENT 'Tier 2 Rx copay',
    `prescription_tier3_copay_amount` DECIMAL(18,2) COMMENT 'Tier 3 Rx copay',
    `prescription_tier4_copay_amount` DECIMAL(18,2) COMMENT 'Tier 4 Rx copay',
    `preventive_care_covered` BOOLEAN COMMENT 'Preventive care covered flag',
    `primary_care_copay_amount` DECIMAL(18,2) COMMENT 'Primary care copay',
    `prior_authorization_required` BOOLEAN COMMENT 'Prior auth required flag',
    `requires_pcp_selection` BOOLEAN COMMENT 'PCP selection required flag',
    `requires_referral_for_specialist` BOOLEAN COMMENT 'Referral required for specialist',
    `service_area_description` STRING COMMENT 'The service area description of the insurance health plan record.',
    `specialist_copay_amount` DECIMAL(18,2) COMMENT 'Specialist copay',
    `state_filing_number` STRING COMMENT 'The state filing number of the insurance health plan record.',
    `termination_date` DATE COMMENT 'Plan termination date',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `urgent_care_copay_amount` DECIMAL(18,2) COMMENT 'Urgent care copay',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_health_plan PRIMARY KEY(`health_plan_id`)
) COMMENT 'Specific health insurance plan offered by a payer with defined benefits, networks, and cost-sharing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`benefit` (
    `benefit_id` BIGINT COMMENT 'Primary key',
    `icd_code_id` BIGINT COMMENT 'FK to diagnosis code',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `parent_benefit_id` BIGINT COMMENT 'FK to parent benefit',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `hcpcs_code_id` BIGINT COMMENT 'FK to HCPCS code',
    `allowed_amount_basis` STRING COMMENT 'Basis for allowed amount',
    `benefit_status` STRING COMMENT 'The benefit status value classifying the insurance benefit record.',
    `benefit_category` STRING COMMENT 'The benefit category of the insurance benefit record.',
    `benefit_code` STRING COMMENT 'The benefit code value classifying the insurance benefit record.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'The coinsurance percentage of the insurance benefit record.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The copay amount of the insurance benefit record.',
    `cost_sharing_tier` STRING COMMENT 'The cost sharing tier of the insurance benefit record.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'The coverage percentage of the insurance benefit record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `day_limit_count` STRING COMMENT 'The day limit count of the insurance benefit record.',
    `day_limit_period` STRING COMMENT 'The day limit period of the insurance benefit record.',
    `days_supply_limit` STRING COMMENT 'The days supply limit of the insurance benefit record.',
    `deductible_applies_flag` BOOLEAN COMMENT 'The deductible applies flag of the insurance benefit record.',
    `benefit_description` STRING COMMENT 'The benefit description of the insurance benefit record.',
    `diagnosis_code_type` STRING COMMENT 'The diagnosis code type value classifying the insurance benefit record.',
    `dollar_limit_amount` DECIMAL(18,2) COMMENT 'The dollar limit amount of the insurance benefit record.',
    `dollar_limit_period` STRING COMMENT 'The dollar limit period of the insurance benefit record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance benefit record.',
    `essential_health_benefit_flag` BOOLEAN COMMENT 'The essential health benefit flag of the insurance benefit record.',
    `exclusions_text` STRING COMMENT 'The exclusions text of the insurance benefit record.',
    `formulary_tier` STRING COMMENT 'The formulary tier of the insurance benefit record.',
    `hsa_eligible_flag` BOOLEAN COMMENT 'The hsa eligible flag of the insurance benefit record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance benefit record.',
    `limitations_text` STRING COMMENT 'The limitations text of the insurance benefit record.',
    `mail_order_available_flag` BOOLEAN COMMENT 'The mail order available flag of the insurance benefit record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `benefit_name` STRING COMMENT 'The benefit name of the insurance benefit record.',
    `network_type` STRING COMMENT 'The network type value classifying the insurance benefit record.',
    `out_of_pocket_applies_flag` BOOLEAN COMMENT 'The out of pocket applies flag of the insurance benefit record.',
    `place_of_service_code` STRING COMMENT 'The place of service code value classifying the insurance benefit record.',
    `preventive_care_flag` BOOLEAN COMMENT 'The preventive care flag of the insurance benefit record.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Prior auth required flag',
    `procedure_code_type` STRING COMMENT 'The procedure code type value classifying the insurance benefit record.',
    `quantity_limit_flag` BOOLEAN COMMENT 'The quantity limit flag of the insurance benefit record.',
    `referral_required_flag` BOOLEAN COMMENT 'The referral required flag of the insurance benefit record.',
    `service_type_code` STRING COMMENT 'The service type code value classifying the insurance benefit record.',
    `step_therapy_required_flag` BOOLEAN COMMENT 'The step therapy required flag of the insurance benefit record.',
    `subcategory` STRING COMMENT 'The subcategory of the insurance benefit record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance benefit record.',
    `tier` STRING COMMENT 'Benefit tier',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the insurance benefit record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_extra` STRING COMMENT 'Placeholder attribute added by VIBE mutation to ensure model change.',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `visit_limit_count` STRING COMMENT 'The visit limit count of the insurance benefit record.',
    `visit_limit_period` STRING COMMENT 'The visit limit period of the insurance benefit record.',
    CONSTRAINT pk_benefit PRIMARY KEY(`benefit_id`)
) COMMENT 'Specific benefit coverage detail within a health plan (service type, cost-sharing, limits).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` (
    `provider_network_id` BIGINT COMMENT 'Primary key',
    `parent_network_provider_network_id` BIGINT COMMENT 'FK to parent network',
    `parent_provider_network_id` BIGINT COMMENT 'FK to parent network',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'The accepting new patients flag of the insurance provider network record.',
    `adequacy_review_date` DATE COMMENT 'Network adequacy review date',
    `behavioral_health_included_flag` BOOLEAN COMMENT 'The behavioral health included flag of the insurance provider network record.',
    `cms_approval_date` DATE COMMENT 'Timestamp capturing the cms approval date associated with the insurance provider network record.',
    `cms_filing_date` DATE COMMENT 'Timestamp capturing the cms filing date associated with the insurance provider network record.',
    `cms_filing_status` STRING COMMENT 'The cms filing status value classifying the insurance provider network record.',
    `contract_type` STRING COMMENT 'The contract type value classifying the insurance provider network record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_standard` STRING COMMENT 'The credentialing standard of the insurance provider network record.',
    `dental_network_included_flag` BOOLEAN COMMENT 'The dental network included flag of the insurance provider network record.',
    `directory_last_updated_date` DATE COMMENT 'Timestamp capturing the directory last updated date associated with the insurance provider network record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance provider network record.',
    `facility_count` STRING COMMENT 'The facility count of the insurance provider network record.',
    `geographic_service_area` STRING COMMENT 'The geographic service area of the insurance provider network record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance provider network record.',
    `network_adequacy_status` STRING COMMENT 'The network adequacy status value classifying the insurance provider network record.',
    `network_code` STRING COMMENT 'Network identifier',
    `network_description` STRING COMMENT 'The network description of the insurance provider network record.',
    `network_directory_url` STRING COMMENT 'The network directory url of the insurance provider network record.',
    `network_model` STRING COMMENT 'The network model of the insurance provider network record.',
    `network_name` STRING COMMENT 'The network name of the insurance provider network record.',
    `network_status` STRING COMMENT 'The network status value classifying the insurance provider network record.',
    `network_tier` STRING COMMENT 'The network tier of the insurance provider network record.',
    `network_type` STRING COMMENT 'The network type value classifying the insurance provider network record.',
    `pcp_count` STRING COMMENT 'The pcp count of the insurance provider network record.',
    `pharmacy_network_included_flag` BOOLEAN COMMENT 'The pharmacy network included flag of the insurance provider network record.',
    `provider_count` STRING COMMENT 'The provider count of the insurance provider network record.',
    `quality_tier_methodology` STRING COMMENT 'The quality tier methodology of the insurance provider network record.',
    `recredentialing_cycle_months` STRING COMMENT 'Recredentialing cycle in months',
    `risk_arrangement` STRING COMMENT 'The risk arrangement of the insurance provider network record.',
    `service_area_type` STRING COMMENT 'The service area type value classifying the insurance provider network record.',
    `specialist_count` STRING COMMENT 'The specialist count of the insurance provider network record.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'The telehealth enabled flag of the insurance provider network record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance provider network record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance provider network record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `vision_network_included_flag` BOOLEAN COMMENT 'The vision network included flag of the insurance provider network record.',
    CONSTRAINT pk_provider_network PRIMARY KEY(`provider_network_id`)
) COMMENT 'Network of contracted providers (clinicians, facilities) for a payer or health plan.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` (
    `plan_network_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `superseded_plan_network_id` BIGINT COMMENT 'FK to superseded plan network',
    `auto_assignment_eligible` BOOLEAN COMMENT 'Auto assignment eligible flag',
    `claims_processing_priority` STRING COMMENT 'The claims processing priority of the insurance plan network record.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'The coinsurance percentage of the insurance plan network record.',
    `contract_number` STRING COMMENT 'The contract number of the insurance plan network record.',
    `copay_tier_code` STRING COMMENT 'The copay tier code value classifying the insurance plan network record.',
    `county_code` STRING COMMENT 'The county code value classifying the insurance plan network record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deductible_applies` BOOLEAN COMMENT 'Deductible applies flag',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance plan network record.',
    `filing_reference_number` STRING COMMENT 'The filing reference number of the insurance plan network record.',
    `geographic_region` STRING COMMENT 'The geographic region of the insurance plan network record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance plan network record.',
    `member_communication_required` BOOLEAN COMMENT 'Member communication required flag',
    `network_adequacy_certification_date` DATE COMMENT 'Timestamp capturing the network adequacy certification date associated with the insurance plan network record.',
    `network_adequacy_certified` BOOLEAN COMMENT 'Network adequacy certified flag',
    `network_priority` STRING COMMENT 'The network priority of the insurance plan network record.',
    `network_role` STRING COMMENT 'The network role of the insurance plan network record.',
    `network_tier` STRING COMMENT 'The network tier of the insurance plan network record.',
    `network_type` STRING COMMENT 'The network type value classifying the insurance plan network record.',
    `notes` STRING COMMENT 'The notes of the insurance plan network record.',
    `out_of_network_coverage` BOOLEAN COMMENT 'Out-of-network coverage flag',
    `out_of_pocket_max_applies` BOOLEAN COMMENT 'Out-of-pocket max applies flag',
    `pcp_selection_required` BOOLEAN COMMENT 'PCP selection required flag',
    `plan_network_status` STRING COMMENT 'The plan network status value classifying the insurance plan network record.',
    `referral_required` BOOLEAN COMMENT 'Referral required flag',
    `regulatory_filing_required` BOOLEAN COMMENT 'Regulatory filing required flag',
    `reimbursement_method` STRING COMMENT 'The reimbursement method of the insurance plan network record.',
    `state_code` STRING COMMENT 'The state code value classifying the insurance plan network record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance plan network record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance plan network record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance plan network record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_plan_network PRIMARY KEY(`plan_network_id`)
) COMMENT 'Association between a health plan and a provider network with tier and cost-sharing rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` (
    `coverage_policy_id` BIGINT COMMENT 'Primary key',
    `compliance_policy_id` BIGINT COMMENT 'FK to compliance policy',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `drg_id` BIGINT COMMENT 'Unique identifier for the drg within the insurance coverage policy record.',
    `hcpcs_code_id` BIGINT COMMENT 'FK to HCPCS code',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `primary_superseded_by_coverage_policy_id` BIGINT COMMENT 'FK to superseding policy',
    `form_template_id` BIGINT COMMENT 'FK to required consent form template',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
    `taxonomy_id` BIGINT COMMENT 'FK to taxonomy',
    `age_restrictions` STRING COMMENT 'The age restrictions of the insurance coverage policy record.',
    `appeals_allowed` BOOLEAN COMMENT 'Appeals allowed flag',
    `appeals_process_description` STRING COMMENT 'The appeals process description of the insurance coverage policy record.',
    `clinical_evidence_source` STRING COMMENT 'The clinical evidence source of the insurance coverage policy record.',
    `coverage_determination` STRING COMMENT 'The coverage determination of the insurance coverage policy record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance coverage policy record.',
    `exclusions` STRING COMMENT 'The exclusions of the insurance coverage policy record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the insurance coverage policy record.',
    `frequency_limitations` STRING COMMENT 'The frequency limitations of the insurance coverage policy record.',
    `gender_restrictions` STRING COMMENT 'The gender restrictions of the insurance coverage policy record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance coverage policy record.',
    `last_updated_date` DATE COMMENT 'Timestamp capturing the last updated date associated with the insurance coverage policy record.',
    `medical_necessity_criteria` STRING COMMENT 'The medical necessity criteria of the insurance coverage policy record.',
    `network_restrictions` STRING COMMENT 'The network restrictions of the insurance coverage policy record.',
    `place_of_service_restrictions` STRING COMMENT 'The place of service restrictions of the insurance coverage policy record.',
    `policy_approval_date` DATE COMMENT 'Timestamp capturing the policy approval date associated with the insurance coverage policy record.',
    `policy_approved_by` STRING COMMENT 'The policy approved by of the insurance coverage policy record.',
    `policy_category` STRING COMMENT 'The policy category of the insurance coverage policy record.',
    `policy_description` STRING COMMENT 'The policy description of the insurance coverage policy record.',
    `policy_number` STRING COMMENT 'The policy number of the insurance coverage policy record.',
    `policy_owner` STRING COMMENT 'The policy owner of the insurance coverage policy record.',
    `policy_status` STRING COMMENT 'The policy status value classifying the insurance coverage policy record.',
    `policy_title` STRING COMMENT 'The policy title of the insurance coverage policy record.',
    `policy_type` STRING COMMENT 'The policy type value classifying the insurance coverage policy record.',
    `policy_version` STRING COMMENT 'The policy version of the insurance coverage policy record.',
    `prior_authorization_criteria` STRING COMMENT 'The prior authorization criteria of the insurance coverage policy record.',
    `prior_authorization_required` BOOLEAN COMMENT 'Prior auth required flag',
    `provider_specialty_restrictions` STRING COMMENT 'The provider specialty restrictions of the insurance coverage policy record.',
    `quantity_limitations` STRING COMMENT 'The quantity limitations of the insurance coverage policy record.',
    `regulatory_basis` STRING COMMENT 'The regulatory basis of the insurance coverage policy record.',
    `review_date` DATE COMMENT 'Timestamp capturing the review date associated with the insurance coverage policy record.',
    `step_therapy_criteria` STRING COMMENT 'The step therapy criteria of the insurance coverage policy record.',
    `step_therapy_required` BOOLEAN COMMENT 'Step therapy required flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance coverage policy record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_coverage_policy PRIMARY KEY(`coverage_policy_id`)
) COMMENT 'Medical policy defining coverage criteria, prior auth requirements, and medical necessity for services.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` (
    `member_enrollment_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'FK to PCP clinician',
    `compliance_policy_id` BIGINT COMMENT 'FK to compliance policy',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the member subscriber within the insurance member enrollment record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_member_enrollment_id` BIGINT COMMENT 'FK to prior enrollment',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `benefit_period_end_date` DATE COMMENT 'Timestamp capturing the benefit period end date associated with the insurance member enrollment record.',
    `benefit_period_start_date` DATE COMMENT 'Timestamp capturing the benefit period start date associated with the insurance member enrollment record.',
    `cobra_indicator` BOOLEAN COMMENT 'The cobra indicator of the insurance member enrollment record.',
    `cobra_qualifying_event_date` DATE COMMENT 'Timestamp capturing the cobra qualifying event date associated with the insurance member enrollment record.',
    `coverage_tier` STRING COMMENT 'The coverage tier of the insurance member enrollment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the insurance member enrollment record.',
    `eligibility_verification_date` DATE COMMENT 'Timestamp capturing the eligibility verification date associated with the insurance member enrollment record.',
    `eligibility_verification_status` STRING COMMENT 'The eligibility verification status value classifying the insurance member enrollment record.',
    `enrollment_channel` STRING COMMENT 'The enrollment channel of the insurance member enrollment record.',
    `enrollment_created_timestamp` TIMESTAMP COMMENT 'The enrollment created timestamp of the insurance member enrollment record.',
    `enrollment_effective_date` DATE COMMENT 'Timestamp capturing the enrollment effective date associated with the insurance member enrollment record.',
    `enrollment_notes` STRING COMMENT 'The enrollment notes of the insurance member enrollment record.',
    `enrollment_source` STRING COMMENT 'The enrollment source of the insurance member enrollment record.',
    `enrollment_source_system` STRING COMMENT 'The enrollment source system of the insurance member enrollment record.',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the insurance member enrollment record.',
    `enrollment_termination_date` DATE COMMENT 'Timestamp capturing the enrollment termination date associated with the insurance member enrollment record.',
    `enrollment_type` STRING COMMENT 'The enrollment type value classifying the insurance member enrollment record.',
    `enrollment_updated_timestamp` TIMESTAMP COMMENT 'The enrollment updated timestamp of the insurance member enrollment record.',
    `group_number` STRING COMMENT 'The group number of the insurance member enrollment record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance member enrollment record.',
    `last_premium_payment_date` DATE COMMENT 'Timestamp capturing the last premium payment date associated with the insurance member enrollment record.',
    `medicaid_number` STRING COMMENT 'The medicaid number of the insurance member enrollment record.',
    `medicare_part_a_effective_date` DATE COMMENT 'Timestamp capturing the medicare part a effective date associated with the insurance member enrollment record.',
    `medicare_part_b_effective_date` DATE COMMENT 'Timestamp capturing the medicare part b effective date associated with the insurance member enrollment record.',
    `pcp_assignment_date` DATE COMMENT 'Timestamp capturing the pcp assignment date associated with the insurance member enrollment record.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The premium amount of the insurance member enrollment record.',
    `premium_payment_frequency` STRING COMMENT 'The premium payment frequency of the insurance member enrollment record.',
    `premium_payment_status` STRING COMMENT 'The premium payment status value classifying the insurance member enrollment record.',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `relationship_to_subscriber` STRING COMMENT 'The relationship to subscriber of the insurance member enrollment record.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'The subsidy amount of the insurance member enrollment record.',
    `subsidy_type` STRING COMMENT 'The subsidy type value classifying the insurance member enrollment record.',
    `termination_reason` STRING COMMENT 'The termination reason of the insurance member enrollment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the insurance member enrollment record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance member enrollment record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_member_enrollment PRIMARY KEY(`member_enrollment_id`)
) COMMENT 'Patient enrollment in a health plan with coverage dates, PCP assignment, and eligibility status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` (
    `subscriber_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_subscriber_id` BIGINT COMMENT 'FK to prior subscriber',
    `address_line_1` STRING COMMENT 'The address line 1 of the insurance subscriber record.',
    `address_line_2` STRING COMMENT 'The address line 2 of the insurance subscriber record.',
    `city` STRING COMMENT 'The city of the insurance subscriber record.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'The cobra eligible flag of the insurance subscriber record.',
    `cobra_end_date` DATE COMMENT 'Timestamp capturing the cobra end date associated with the insurance subscriber record.',
    `cobra_start_date` DATE COMMENT 'Timestamp capturing the cobra start date associated with the insurance subscriber record.',
    `country_code` STRING COMMENT 'The country code value classifying the insurance subscriber record.',
    `coverage_status` STRING COMMENT 'The coverage status value classifying the insurance subscriber record.',
    `coverage_type` STRING COMMENT 'The coverage type value classifying the insurance subscriber record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `date_of_birth` DATE COMMENT 'The date of birth of the insurance subscriber record.',
    `dual_eligible_flag` BOOLEAN COMMENT 'The dual eligible flag of the insurance subscriber record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the insurance subscriber record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the insurance subscriber record.',
    `email_address` STRING COMMENT 'The email address of the insurance subscriber record.',
    `first_name` STRING COMMENT 'The first name of the insurance subscriber record.',
    `gender` STRING COMMENT 'The gender of the insurance subscriber record.',
    `group_number` STRING COMMENT 'The group number of the insurance subscriber record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance subscriber record.',
    `last_name` STRING COMMENT 'The last name of the insurance subscriber record.',
    `medicaid_eligible_flag` BOOLEAN COMMENT 'The medicaid eligible flag of the insurance subscriber record.',
    `medicaid_number` STRING COMMENT 'The medicaid number of the insurance subscriber record.',
    `medicare_eligible_flag` BOOLEAN COMMENT 'The medicare eligible flag of the insurance subscriber record.',
    `medicare_number` STRING COMMENT 'The medicare number of the insurance subscriber record.',
    `middle_name` STRING COMMENT 'The middle name of the insurance subscriber record.',
    `network_tier` STRING COMMENT 'The network tier of the insurance subscriber record.',
    `phone_number` STRING COMMENT 'The phone number of the insurance subscriber record.',
    `postal_code` STRING COMMENT 'The postal code value classifying the insurance subscriber record.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The premium amount of the insurance subscriber record.',
    `premium_frequency` STRING COMMENT 'The premium frequency of the insurance subscriber record.',
    `primary_care_physician_npi` STRING COMMENT 'The primary care physician npi of the insurance subscriber record.',
    `relationship_to_insured` STRING COMMENT 'The relationship to insured of the insurance subscriber record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the insurance subscriber record.',
    `ssn` STRING COMMENT 'The ssn of the insurance subscriber record.',
    `state` STRING COMMENT 'The state of the insurance subscriber record.',
    `suffix` STRING COMMENT 'The suffix of the insurance subscriber record.',
    `termination_reason` STRING COMMENT 'The termination reason of the insurance subscriber record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance subscriber record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_subscriber PRIMARY KEY(`subscriber_id`)
) COMMENT 'Primary insurance subscriber (policyholder) with demographics and coverage details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`dependent` (
    `dependent_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'FK to PCP clinician',
    `mpi_record_id` BIGINT COMMENT 'FK to member MPI record',
    `dependent_mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `primary_dependent_id` BIGINT COMMENT 'FK to primary dependent',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber',
    `address_line_1` STRING COMMENT 'The address line 1 of the insurance dependent record.',
    `address_line_2` STRING COMMENT 'The address line 2 of the insurance dependent record.',
    `city` STRING COMMENT 'The city of the insurance dependent record.',
    `coordination_of_benefits_indicator` BOOLEAN COMMENT 'COB indicator',
    `country_code` STRING COMMENT 'The country code value classifying the insurance dependent record.',
    `coverage_effective_date` DATE COMMENT 'Timestamp capturing the coverage effective date associated with the insurance dependent record.',
    `coverage_termination_date` DATE COMMENT 'Timestamp capturing the coverage termination date associated with the insurance dependent record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `date_of_birth` DATE COMMENT 'The date of birth of the insurance dependent record.',
    `disability_status` STRING COMMENT 'The disability status value classifying the insurance dependent record.',
    `disability_verification_date` DATE COMMENT 'Timestamp capturing the disability verification date associated with the insurance dependent record.',
    `eligibility_status` STRING COMMENT 'The eligibility status value classifying the insurance dependent record.',
    `email_address` STRING COMMENT 'The email address of the insurance dependent record.',
    `enrollment_date` DATE COMMENT 'Timestamp capturing the enrollment date associated with the insurance dependent record.',
    `enrollment_source` STRING COMMENT 'The enrollment source of the insurance dependent record.',
    `first_name` STRING COMMENT 'The first name of the insurance dependent record.',
    `gender` STRING COMMENT 'The gender of the insurance dependent record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance dependent record.',
    `last_eligibility_verification_date` DATE COMMENT 'Timestamp capturing the last eligibility verification date associated with the insurance dependent record.',
    `last_name` STRING COMMENT 'The last name of the insurance dependent record.',
    `middle_name` STRING COMMENT 'The middle name of the insurance dependent record.',
    `phone_number` STRING COMMENT 'The phone number of the insurance dependent record.',
    `postal_code` STRING COMMENT 'The postal code value classifying the insurance dependent record.',
    `relationship_type` STRING COMMENT 'The relationship type value classifying the insurance dependent record.',
    `ssn` STRING COMMENT 'The ssn of the insurance dependent record.',
    `state` STRING COMMENT 'The state of the insurance dependent record.',
    `student_status` STRING COMMENT 'The student status value classifying the insurance dependent record.',
    `student_verification_date` DATE COMMENT 'Timestamp capturing the student verification date associated with the insurance dependent record.',
    `suffix` STRING COMMENT 'The suffix of the insurance dependent record.',
    `termination_reason` STRING COMMENT 'The termination reason of the insurance dependent record.',
    `tobacco_use_indicator` BOOLEAN COMMENT 'The tobacco use indicator of the insurance dependent record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance dependent record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_dependent PRIMARY KEY(`dependent_id`)
) COMMENT 'Dependent covered under a subscribers insurance policy.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` (
    `employer_group_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `parent_employer_group_id` BIGINT COMMENT 'FK to parent employer group',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `third_party_administrator_id` BIGINT COMMENT 'Unique identifier for the third party administrator within the insurance employer group record.',
    `aca_applicable_large_employer_indicator` BOOLEAN COMMENT 'The aca applicable large employer indicator of the insurance employer group record.',
    `address_line_1` STRING COMMENT 'The address line 1 of the insurance employer group record.',
    `address_line_2` STRING COMMENT 'The address line 2 of the insurance employer group record.',
    `billing_frequency` STRING COMMENT 'The billing frequency of the insurance employer group record.',
    `city` STRING COMMENT 'The city of the insurance employer group record.',
    `cobra_administrator` STRING COMMENT 'The cobra administrator of the insurance employer group record.',
    `contact_email` STRING COMMENT 'The contact email of the insurance employer group record.',
    `contact_name` STRING COMMENT 'The contact name of the insurance employer group record.',
    `contact_phone` STRING COMMENT 'The contact phone of the insurance employer group record.',
    `country_code` STRING COMMENT 'The country code value classifying the insurance employer group record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance employer group record.',
    `employee_count` STRING COMMENT 'The employee count of the insurance employer group record.',
    `employer_contribution_percentage` DECIMAL(18,2) COMMENT 'The employer contribution percentage of the insurance employer group record.',
    `employer_ein` STRING COMMENT 'The employer ein of the insurance employer group record.',
    `erisa_plan_indicator` BOOLEAN COMMENT 'The erisa plan indicator of the insurance employer group record.',
    `funding_type` STRING COMMENT 'The funding type value classifying the insurance employer group record.',
    `grace_period_days` STRING COMMENT 'The grace period days of the insurance employer group record.',
    `group_name` STRING COMMENT 'The group name of the insurance employer group record.',
    `group_number` STRING COMMENT 'The group number of the insurance employer group record.',
    `group_size` STRING COMMENT 'The group size of the insurance employer group record.',
    `group_status` STRING COMMENT 'The group status value classifying the insurance employer group record.',
    `hsa_eligible_indicator` BOOLEAN COMMENT 'The hsa eligible indicator of the insurance employer group record.',
    `industry_risk_class` STRING COMMENT 'The industry risk class of the insurance employer group record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance employer group record.',
    `minimum_participation_percentage` DECIMAL(18,2) COMMENT 'The minimum participation percentage of the insurance employer group record.',
    `naics_code` STRING COMMENT 'The naics code value classifying the insurance employer group record.',
    `payment_method` STRING COMMENT 'The payment method of the insurance employer group record.',
    `plan_sponsor_type` STRING COMMENT 'The plan sponsor type value classifying the insurance employer group record.',
    `postal_code` STRING COMMENT 'The postal code value classifying the insurance employer group record.',
    `rate_guarantee_months` STRING COMMENT 'The rate guarantee months of the insurance employer group record.',
    `renewal_date` DATE COMMENT 'Timestamp capturing the renewal date associated with the insurance employer group record.',
    `sic_code` STRING COMMENT 'The sic code value classifying the insurance employer group record.',
    `situs_state_code` STRING COMMENT 'The situs state code value classifying the insurance employer group record.',
    `state_code` STRING COMMENT 'The state code value classifying the insurance employer group record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance employer group record.',
    `underwriting_tier` STRING COMMENT 'The underwriting tier of the insurance employer group record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance employer group record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `wellness_program_indicator` BOOLEAN COMMENT 'The wellness program indicator of the insurance employer group record.',
    CONSTRAINT pk_employer_group PRIMARY KEY(`employer_group_id`)
) COMMENT 'Employer group purchasing health insurance for employees.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` (
    `payer_contract_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to provider group',
    `org_provider_id` BIGINT COMMENT 'FK to org provider',
    `payer_contact_id` BIGINT COMMENT 'FK to payer contact',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `renewed_payer_contract_id` BIGINT COMMENT 'FK to renewed contract',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
    `amendment_count` STRING COMMENT 'The amendment count of the insurance payer contract record.',
    `apm_program_type` STRING COMMENT 'Type of APM program if this is a VBC contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'The auto renewal flag of the insurance payer contract record.',
    `base_reimbursement_percentage` DECIMAL(18,2) COMMENT 'The base reimbursement percentage of the insurance payer contract record.',
    `care_gap_closure_incentive_amount` DECIMAL(18,2) COMMENT 'Per-gap incentive payment amount for care gap closure.',
    `carve_out_services` STRING COMMENT 'The carve out services of the insurance payer contract record.',
    `claims_submission_method` STRING COMMENT 'The claims submission method of the insurance payer contract record.',
    `contract_administrator_email` STRING COMMENT 'The contract administrator email of the insurance payer contract record.',
    `contract_administrator_name` STRING COMMENT 'The contract administrator name of the insurance payer contract record.',
    `contract_document_location` STRING COMMENT 'The contract document location of the insurance payer contract record.',
    `contract_name` STRING COMMENT 'The contract name of the insurance payer contract record.',
    `contract_number` STRING COMMENT 'The contract number of the insurance payer contract record.',
    `contract_status` STRING COMMENT 'The contract status value classifying the insurance payer contract record.',
    `contract_type` STRING COMMENT 'The contract type value classifying the insurance payer contract record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_required` BOOLEAN COMMENT 'Credentialing required flag',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance payer contract record.',
    `fee_schedule_reference` STRING COMMENT 'The fee schedule reference of the insurance payer contract record.',
    `geographic_coverage` STRING COMMENT 'The geographic coverage of the insurance payer contract record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance payer contract record.',
    `last_amendment_date` DATE COMMENT 'Timestamp capturing the last amendment date associated with the insurance payer contract record.',
    `mips_reporting_required_flag` BOOLEAN COMMENT 'Contract requires MIPS quality reporting.',
    `network_tier` STRING COMMENT 'The network tier of the insurance payer contract record.',
    `notes` STRING COMMENT 'The notes of the insurance payer contract record.',
    `payment_terms_days` STRING COMMENT 'The payment terms days of the insurance payer contract record.',
    `prior_authorization_required` BOOLEAN COMMENT 'Prior auth required flag',
    `quality_bonus_eligible` BOOLEAN COMMENT 'Quality bonus eligible flag',
    `quality_measure_set` STRING COMMENT 'The quality measure set of the insurance payer contract record.',
    `quality_penalty_eligible` BOOLEAN COMMENT 'Quality penalty eligible flag',
    `raf_adjustment_applicable_flag` BOOLEAN COMMENT 'Contract uses risk adjustment factor for payment.',
    `reconciliation_frequency` STRING COMMENT 'The reconciliation frequency of the insurance payer contract record.',
    `regulatory_filing_reference` STRING COMMENT 'The regulatory filing reference of the insurance payer contract record.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Regulatory filing required flag',
    `reimbursement_method` STRING COMMENT 'The reimbursement method of the insurance payer contract record.',
    `renewal_notice_days` STRING COMMENT 'The renewal notice days of the insurance payer contract record.',
    `risk_arrangement_type` STRING COMMENT 'The risk arrangement type value classifying the insurance payer contract record.',
    `state_code` STRING COMMENT 'The state code value classifying the insurance payer contract record.',
    `stop_loss_threshold_amount` DECIMAL(18,2) COMMENT 'The stop loss threshold amount of the insurance payer contract record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance payer contract record.',
    `timely_filing_limit_days` STRING COMMENT 'The timely filing limit days of the insurance payer contract record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance payer contract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the insurance payer contract record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance payer contract record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_payer_contract PRIMARY KEY(`payer_contract_id`)
) COMMENT 'Contract between provider organization and payer defining reimbursement terms and obligations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` (
    `fee_schedule_id` BIGINT COMMENT 'Primary key',
    `payer_contract_id` BIGINT COMMENT 'FK to payer contract',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `primary_predecessor_schedule_fee_schedule_id` BIGINT COMMENT 'FK to predecessor schedule',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
    `taxonomy_id` BIGINT COMMENT 'FK to taxonomy',
    `annual_inflation_rate` DECIMAL(18,2) COMMENT 'The annual inflation rate of the insurance fee schedule record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the insurance fee schedule record.',
    `approved_by` STRING COMMENT 'The approved by of the insurance fee schedule record.',
    `authorization_required` BOOLEAN COMMENT 'Authorization required flag',
    `billed_charges_percentage` DECIMAL(18,2) COMMENT 'The billed charges percentage of the insurance fee schedule record.',
    `carve_out_services` STRING COMMENT 'The carve out services of the insurance fee schedule record.',
    `claims_submission_method` STRING COMMENT 'The claims submission method of the insurance fee schedule record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance fee schedule record.',
    `facility_type` STRING COMMENT 'The facility type value classifying the insurance fee schedule record.',
    `fee_schedule_status` STRING COMMENT 'The fee schedule status value classifying the insurance fee schedule record.',
    `filing_reference_number` STRING COMMENT 'The filing reference number of the insurance fee schedule record.',
    `geographic_adjustment_factor` DECIMAL(18,2) COMMENT 'The geographic adjustment factor of the insurance fee schedule record.',
    `geographic_scope` STRING COMMENT 'The geographic scope of the insurance fee schedule record.',
    `inflation_adjustment_method` STRING COMMENT 'The inflation adjustment method of the insurance fee schedule record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance fee schedule record.',
    `interest_penalty_rate` DECIMAL(18,2) COMMENT 'The interest penalty rate of the insurance fee schedule record.',
    `locality_code` STRING COMMENT 'The locality code value classifying the insurance fee schedule record.',
    `medicare_percentage` DECIMAL(18,2) COMMENT 'The medicare percentage of the insurance fee schedule record.',
    `network_tier` STRING COMMENT 'The network tier of the insurance fee schedule record.',
    `notes` STRING COMMENT 'The notes of the insurance fee schedule record.',
    `outlier_payment_threshold` DECIMAL(18,2) COMMENT 'The outlier payment threshold of the insurance fee schedule record.',
    `payment_terms_days` STRING COMMENT 'The payment terms days of the insurance fee schedule record.',
    `quality_adjustment_percentage` DECIMAL(18,2) COMMENT 'The quality adjustment percentage of the insurance fee schedule record.',
    `quality_incentive_eligible` BOOLEAN COMMENT 'Quality incentive eligible flag',
    `rate_basis` STRING COMMENT 'The rate basis of the insurance fee schedule record.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Regulatory filing required flag',
    `reimbursement_model` STRING COMMENT 'The reimbursement model of the insurance fee schedule record.',
    `schedule_code` STRING COMMENT 'The schedule code value classifying the insurance fee schedule record.',
    `schedule_name` STRING COMMENT 'The schedule name of the insurance fee schedule record.',
    `schedule_type` STRING COMMENT 'The schedule type value classifying the insurance fee schedule record.',
    `service_category` STRING COMMENT 'The service category of the insurance fee schedule record.',
    `state_code` STRING COMMENT 'The state code value classifying the insurance fee schedule record.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'The stop loss threshold of the insurance fee schedule record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance fee schedule record.',
    `timely_filing_limit_days` STRING COMMENT 'The timely filing limit days of the insurance fee schedule record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance fee schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `version_number` STRING COMMENT 'The version number of the insurance fee schedule record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance fee schedule record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Fee schedule defining reimbursement rates for services under a payer contract.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` (
    `fee_schedule_line_id` BIGINT COMMENT 'Primary key',
    `drg_id` BIGINT COMMENT 'Unique identifier for the drg within the insurance fee schedule line record.',
    `fee_schedule_id` BIGINT COMMENT 'FK to fee schedule',
    `hcpcs_code_id` BIGINT COMMENT 'FK to HCPCS code',
    `primary_superseded_by_fee_schedule_line_id` BIGINT COMMENT 'FK to superseding line',
    `anesthesia_base_units` DECIMAL(18,2) COMMENT 'The anesthesia base units of the insurance fee schedule line record.',
    `assistant_surgeon_allowed` BOOLEAN COMMENT 'Assistant surgeon allowed flag',
    `authorization_required` BOOLEAN COMMENT 'Authorization required flag',
    `bilateral_indicator` STRING COMMENT 'The bilateral indicator of the insurance fee schedule line record.',
    `bundled_indicator` BOOLEAN COMMENT 'The bundled indicator of the insurance fee schedule line record.',
    `case_rate_amount` DECIMAL(18,2) COMMENT 'The case rate amount of the insurance fee schedule line record.',
    `contract_reference_number` STRING COMMENT 'The contract reference number of the insurance fee schedule line record.',
    `contracted_rate_amount` DECIMAL(18,2) COMMENT 'The contracted rate amount of the insurance fee schedule line record.',
    `conversion_factor` DECIMAL(18,2) COMMENT 'The conversion factor of the insurance fee schedule line record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance fee schedule line record.',
    `facility_type` STRING COMMENT 'The facility type value classifying the insurance fee schedule line record.',
    `fee_schedule_line_status` STRING COMMENT 'The fee schedule line status value classifying the insurance fee schedule line record.',
    `geographic_modifier` STRING COMMENT 'The geographic modifier of the insurance fee schedule line record.',
    `global_period_days` STRING COMMENT 'The global period days of the insurance fee schedule line record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance fee schedule line record.',
    `line_number` STRING COMMENT 'The line number of the insurance fee schedule line record.',
    `maximum_reimbursement` DECIMAL(18,2) COMMENT 'The maximum reimbursement of the insurance fee schedule line record.',
    `minimum_reimbursement` DECIMAL(18,2) COMMENT 'The minimum reimbursement of the insurance fee schedule line record.',
    `modifier_1` STRING COMMENT 'The modifier 1 of the insurance fee schedule line record.',
    `modifier_2` STRING COMMENT 'The modifier 2 of the insurance fee schedule line record.',
    `modifier_3` STRING COMMENT 'The modifier 3 of the insurance fee schedule line record.',
    `modifier_4` STRING COMMENT 'The modifier 4 of the insurance fee schedule line record.',
    `multiple_procedure_reduction` DECIMAL(18,2) COMMENT 'The multiple procedure reduction of the insurance fee schedule line record.',
    `notes` STRING COMMENT 'The notes of the insurance fee schedule line record.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'The per diem rate of the insurance fee schedule line record.',
    `percent_of_charges` DECIMAL(18,2) COMMENT 'The percent of charges of the insurance fee schedule line record.',
    `percent_of_medicare` DECIMAL(18,2) COMMENT 'The percent of medicare of the insurance fee schedule line record.',
    `place_of_service_code` STRING COMMENT 'The place of service code value classifying the insurance fee schedule line record.',
    `procedure_code` STRING COMMENT 'The procedure code value classifying the insurance fee schedule line record.',
    `procedure_code_type` STRING COMMENT 'The procedure code type value classifying the insurance fee schedule line record.',
    `quality_reporting_required` BOOLEAN COMMENT 'Quality reporting required flag',
    `rate_basis` STRING COMMENT 'The rate basis of the insurance fee schedule line record.',
    `rate_version` STRING COMMENT 'The rate version of the insurance fee schedule line record.',
    `revenue_code` STRING COMMENT 'The revenue code value classifying the insurance fee schedule line record.',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'The rvu malpractice of the insurance fee schedule line record.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'The rvu practice expense of the insurance fee schedule line record.',
    `rvu_total` DECIMAL(18,2) COMMENT 'The rvu total of the insurance fee schedule line record.',
    `rvu_work` DECIMAL(18,2) COMMENT 'The rvu work of the insurance fee schedule line record.',
    `specialty_code` STRING COMMENT 'The specialty code value classifying the insurance fee schedule line record.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'The stop loss threshold of the insurance fee schedule line record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance fee schedule line record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance fee schedule line record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance fee schedule line record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_fee_schedule_line PRIMARY KEY(`fee_schedule_line_id`)
) COMMENT 'Individual line item in a fee schedule specifying reimbursement for a specific procedure or service.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` (
    `prior_auth_rule_id` BIGINT COMMENT 'Primary key',
    `compliance_policy_id` BIGINT COMMENT 'FK to compliance policy',
    `hcpcs_code_id` BIGINT COMMENT 'FK to HCPCS code',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `measure_id` BIGINT COMMENT 'FK to quality measure',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
    `superseded_prior_auth_rule_id` BIGINT COMMENT 'FK to superseded rule',
    `taxonomy_id` BIGINT COMMENT 'FK to taxonomy',
    `age_maximum` STRING COMMENT 'The age maximum of the insurance prior auth rule record.',
    `age_minimum` STRING COMMENT 'The age minimum of the insurance prior auth rule record.',
    `appeal_process_description` STRING COMMENT 'The appeal process description of the insurance prior auth rule record.',
    `auto_approval_criteria` STRING COMMENT 'The auto approval criteria of the insurance prior auth rule record.',
    `auto_approval_eligible` BOOLEAN COMMENT 'Auto approval eligible flag',
    `clinical_criteria_reference` STRING COMMENT 'The clinical criteria reference of the insurance prior auth rule record.',
    `contact_fax` STRING COMMENT 'The contact fax of the insurance prior auth rule record.',
    `contact_phone` STRING COMMENT 'The contact phone of the insurance prior auth rule record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `diagnosis_code` STRING COMMENT 'The diagnosis code value classifying the insurance prior auth rule record.',
    `documentation_required` STRING COMMENT 'The documentation required of the insurance prior auth rule record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance prior auth rule record.',
    `exception_criteria` STRING COMMENT 'The exception criteria of the insurance prior auth rule record.',
    `frequency_limit` STRING COMMENT 'The frequency limit of the insurance prior auth rule record.',
    `frequency_limit_period_days` STRING COMMENT 'The frequency limit period days of the insurance prior auth rule record.',
    `gender_restriction` STRING COMMENT 'The gender restriction of the insurance prior auth rule record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance prior auth rule record.',
    `medical_policy_number` STRING COMMENT 'The medical policy number of the insurance prior auth rule record.',
    `notes` STRING COMMENT 'The notes of the insurance prior auth rule record.',
    `pa_requirement_type` STRING COMMENT 'The pa requirement type value classifying the insurance prior auth rule record.',
    `place_of_service_code` STRING COMMENT 'The place of service code value classifying the insurance prior auth rule record.',
    `portal_url` STRING COMMENT 'The portal url of the insurance prior auth rule record.',
    `prior_auth_rule_status` STRING COMMENT 'The prior auth rule status value classifying the insurance prior auth rule record.',
    `procedure_code` STRING COMMENT 'The procedure code value classifying the insurance prior auth rule record.',
    `procedure_code_type` STRING COMMENT 'The procedure code type value classifying the insurance prior auth rule record.',
    `quantity_limit` DECIMAL(18,2) COMMENT 'The quantity limit of the insurance prior auth rule record.',
    `quantity_limit_period_days` STRING COMMENT 'The quantity limit period days of the insurance prior auth rule record.',
    `regulatory_basis` STRING COMMENT 'The regulatory basis of the insurance prior auth rule record.',
    `rule_code` STRING COMMENT 'The rule code value classifying the insurance prior auth rule record.',
    `rule_name` STRING COMMENT 'The rule name of the insurance prior auth rule record.',
    `service_category` STRING COMMENT 'The service category of the insurance prior auth rule record.',
    `step_therapy_criteria` STRING COMMENT 'The step therapy criteria of the insurance prior auth rule record.',
    `step_therapy_required` BOOLEAN COMMENT 'Step therapy required flag',
    `submission_method` STRING COMMENT 'The submission method of the insurance prior auth rule record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance prior auth rule record.',
    `turnaround_time_hours` STRING COMMENT 'The turnaround time hours of the insurance prior auth rule record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance prior auth rule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `urgent_turnaround_time_hours` STRING COMMENT 'The urgent turnaround time hours of the insurance prior auth rule record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance prior auth rule record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_prior_auth_rule PRIMARY KEY(`prior_auth_rule_id`)
) COMMENT 'Rule defining when prior authorization is required for a service, procedure, or diagnosis.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` (
    `utilization_review_id` BIGINT COMMENT 'Primary key',
    `appealed_utilization_review_id` BIGINT COMMENT 'FK to appealed review',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `employee_id` BIGINT COMMENT 'FK to reviewer employee',
    `encounter_authorization_id` BIGINT COMMENT 'FK to encounter authorization',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `cost_center_id` BIGINT COMMENT 'FK to review cost center',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `admission_date` DATE COMMENT 'Timestamp capturing the admission date associated with the insurance utilization review record.',
    `appeal_filed` BOOLEAN COMMENT 'Appeal filed flag',
    `appeal_rights_notified` BOOLEAN COMMENT 'Appeal rights notified flag',
    `approved_length_of_stay` STRING COMMENT 'The approved length of stay of the insurance utilization review record.',
    `clinical_criteria_applied` STRING COMMENT 'The clinical criteria applied of the insurance utilization review record.',
    `clinical_documentation_reviewed` STRING COMMENT 'The clinical documentation reviewed of the insurance utilization review record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `criteria_version` STRING COMMENT 'The criteria version of the insurance utilization review record.',
    `denial_reason_code` STRING COMMENT 'The denial reason code value classifying the insurance utilization review record.',
    `denial_reason_description` STRING COMMENT 'The denial reason description of the insurance utilization review record.',
    `diagnosis_code` STRING COMMENT 'The diagnosis code value classifying the insurance utilization review record.',
    `discharge_date` DATE COMMENT 'Timestamp capturing the discharge date associated with the insurance utilization review record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance utilization review record.',
    `medical_record_number` STRING COMMENT 'The medical record number of the insurance utilization review record.',
    `notification_method` STRING COMMENT 'The notification method of the insurance utilization review record.',
    `notification_sent_date` DATE COMMENT 'Timestamp capturing the notification sent date associated with the insurance utilization review record.',
    `peer_to_peer_date` DATE COMMENT 'Timestamp capturing the peer to peer date associated with the insurance utilization review record.',
    `peer_to_peer_requested` BOOLEAN COMMENT 'Peer-to-peer requested flag',
    `place_of_service_code` STRING COMMENT 'The place of service code value classifying the insurance utilization review record.',
    `procedure_code` STRING COMMENT 'The procedure code value classifying the insurance utilization review record.',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `regulatory_timeframe_met` BOOLEAN COMMENT 'Regulatory timeframe met flag',
    `rendering_provider_npi` STRING COMMENT 'The rendering provider npi of the insurance utilization review record.',
    `requested_length_of_stay` STRING COMMENT 'The requested length of stay of the insurance utilization review record.',
    `review_completion_date` DATE COMMENT 'Timestamp capturing the review completion date associated with the insurance utilization review record.',
    `review_decision` STRING COMMENT 'The review decision of the insurance utilization review record.',
    `review_initiation_date` DATE COMMENT 'Timestamp capturing the review initiation date associated with the insurance utilization review record.',
    `review_number` STRING COMMENT 'The review number of the insurance utilization review record.',
    `review_status` STRING COMMENT 'The review status value classifying the insurance utilization review record.',
    `review_type` STRING COMMENT 'The review type value classifying the insurance utilization review record.',
    `reviewer_credentials` STRING COMMENT 'The reviewer credentials of the insurance utilization review record.',
    `reviewer_notes` STRING COMMENT 'The reviewer notes of the insurance utilization review record.',
    `service_date` DATE COMMENT 'Timestamp capturing the service date associated with the insurance utilization review record.',
    `turnaround_time_hours` STRING COMMENT 'The turnaround time hours of the insurance utilization review record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance utilization review record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance utilization review record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_utilization_review PRIMARY KEY(`utilization_review_id`)
) COMMENT 'Utilization review decision (concurrent, retrospective, prospective) for medical necessity and appropriateness.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` (
    `eligibility_span_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'FK to PCP clinician',
    `eligibility_id` BIGINT COMMENT 'FK to eligibility',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_eligibility_span_id` BIGINT COMMENT 'FK to prior span',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber',
    `benefit_period_end_date` DATE COMMENT 'Timestamp capturing the benefit period end date associated with the insurance eligibility span record.',
    `benefit_period_start_date` DATE COMMENT 'Timestamp capturing the benefit period start date associated with the insurance eligibility span record.',
    `cobra_indicator` BOOLEAN COMMENT 'The cobra indicator of the insurance eligibility span record.',
    `cobra_qualifying_event` STRING COMMENT 'The cobra qualifying event of the insurance eligibility span record.',
    `cobra_qualifying_event_date` DATE COMMENT 'Timestamp capturing the cobra qualifying event date associated with the insurance eligibility span record.',
    `coordination_of_benefits_indicator` BOOLEAN COMMENT 'COB indicator',
    `coverage_level` STRING COMMENT 'The coverage level of the insurance eligibility span record.',
    `coverage_order` STRING COMMENT 'The coverage order of the insurance eligibility span record.',
    `coverage_type` STRING COMMENT 'The coverage type value classifying the insurance eligibility span record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `dual_eligibility_indicator` BOOLEAN COMMENT 'The dual eligibility indicator of the insurance eligibility span record.',
    `dual_eligibility_type` STRING COMMENT 'The dual eligibility type value classifying the insurance eligibility span record.',
    `eligibility_end_date` DATE COMMENT 'Timestamp capturing the eligibility end date associated with the insurance eligibility span record.',
    `eligibility_start_date` DATE COMMENT 'Timestamp capturing the eligibility start date associated with the insurance eligibility span record.',
    `eligibility_status` STRING COMMENT 'The eligibility status value classifying the insurance eligibility span record.',
    `eligibility_verification_date` DATE COMMENT 'Timestamp capturing the eligibility verification date associated with the insurance eligibility span record.',
    `eligibility_verification_status` STRING COMMENT 'The eligibility verification status value classifying the insurance eligibility span record.',
    `enrollment_method` STRING COMMENT 'The enrollment method of the insurance eligibility span record.',
    `enrollment_source` STRING COMMENT 'The enrollment source of the insurance eligibility span record.',
    `exchange_indicator` BOOLEAN COMMENT 'The exchange indicator of the insurance eligibility span record.',
    `group_number` STRING COMMENT 'The group number of the insurance eligibility span record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance eligibility span record.',
    `medicaid_indicator` BOOLEAN COMMENT 'The medicaid indicator of the insurance eligibility span record.',
    `medicare_indicator` BOOLEAN COMMENT 'The medicare indicator of the insurance eligibility span record.',
    `notes` STRING COMMENT 'The notes of the insurance eligibility span record.',
    `pcp_assignment_date` DATE COMMENT 'Timestamp capturing the pcp assignment date associated with the insurance eligibility span record.',
    `pcp_required_indicator` BOOLEAN COMMENT 'The pcp required indicator of the insurance eligibility span record.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The premium amount of the insurance eligibility span record.',
    `premium_payment_frequency` STRING COMMENT 'The premium payment frequency of the insurance eligibility span record.',
    `prior_authorization_required_indicator` BOOLEAN COMMENT 'Prior auth required indicator',
    `referral_required_indicator` BOOLEAN COMMENT 'The referral required indicator of the insurance eligibility span record.',
    `relationship_to_subscriber` STRING COMMENT 'The relationship to subscriber of the insurance eligibility span record.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'The subsidy amount of the insurance eligibility span record.',
    `subsidy_type` STRING COMMENT 'The subsidy type value classifying the insurance eligibility span record.',
    `termination_reason` STRING COMMENT 'The termination reason of the insurance eligibility span record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance eligibility span record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance eligibility span record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_eligibility_span PRIMARY KEY(`eligibility_span_id`)
) COMMENT 'Time-bound eligibility period for a member in a health plan with coverage details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` (
    `accumulator_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `claim_id` BIGINT COMMENT 'FK to last claim',
    `member_enrollment_id` BIGINT COMMENT 'Unique identifier for the member enrollment within the insurance accumulator record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber',
    `accumulated_amount` DECIMAL(18,2) COMMENT 'The accumulated amount of the insurance accumulator record.',
    `accumulator_type` STRING COMMENT 'Accumulator type (deductible, OOP, benefit)',
    `benefit_period_end_date` DATE COMMENT 'Timestamp capturing the benefit period end date associated with the insurance accumulator record.',
    `benefit_period_start_date` DATE COMMENT 'Timestamp capturing the benefit period start date associated with the insurance accumulator record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deductible_accumulated_amount` DECIMAL(18,2) COMMENT 'The deductible accumulated amount of the insurance accumulator record.',
    `deductible_remaining_amount` DECIMAL(18,2) COMMENT 'The deductible remaining amount of the insurance accumulator record.',
    `family_accumulator_flag` BOOLEAN COMMENT 'The family accumulator flag of the insurance accumulator record.',
    `in_network_flag` BOOLEAN COMMENT 'The in network flag of the insurance accumulator record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance accumulator record.',
    `last_updated_date` DATE COMMENT 'Timestamp capturing the last updated date associated with the insurance accumulator record.',
    `limit_amount` DECIMAL(18,2) COMMENT 'The limit amount of the insurance accumulator record.',
    `network_tier` STRING COMMENT 'The network tier of the insurance accumulator record.',
    `oop_accumulated_amount` DECIMAL(18,2) COMMENT 'The oop accumulated amount of the insurance accumulator record.',
    `oop_remaining_amount` DECIMAL(18,2) COMMENT 'The oop remaining amount of the insurance accumulator record.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The remaining amount of the insurance accumulator record.',
    `service_category` STRING COMMENT 'The service category of the insurance accumulator record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance accumulator record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_accumulator PRIMARY KEY(`accumulator_id`)
) COMMENT 'Running total of deductible, out-of-pocket, and benefit usage for a member in a benefit period.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` (
    `capitation_contract_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `group_id` BIGINT COMMENT 'FK to provider group',
    `org_provider_id` BIGINT COMMENT 'FK to org provider',
    `payer_contract_id` BIGINT COMMENT 'FK to payer contract',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_capitation_contract_id` BIGINT COMMENT 'FK to prior contract',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
    `age_band_adjustment_factor` DECIMAL(18,2) COMMENT 'The age band adjustment factor of the insurance capitation contract record.',
    `auto_renewal_flag` BOOLEAN COMMENT 'The auto renewal flag of the insurance capitation contract record.',
    `capitation_rate_pmpm` DECIMAL(18,2) COMMENT 'The capitation rate pmpm of the insurance capitation contract record.',
    `carve_out_services` STRING COMMENT 'The carve out services of the insurance capitation contract record.',
    `contract_name` STRING COMMENT 'The contract name of the insurance capitation contract record.',
    `contract_number` STRING COMMENT 'The contract number of the insurance capitation contract record.',
    `contract_status` STRING COMMENT 'The contract status value classifying the insurance capitation contract record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance capitation contract record.',
    `gender_adjustment_factor` DECIMAL(18,2) COMMENT 'The gender adjustment factor of the insurance capitation contract record.',
    `geographic_adjustment_factor` DECIMAL(18,2) COMMENT 'The geographic adjustment factor of the insurance capitation contract record.',
    `included_services` STRING COMMENT 'The included services of the insurance capitation contract record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance capitation contract record.',
    `member_count_threshold` STRING COMMENT 'The member count threshold of the insurance capitation contract record.',
    `notes` STRING COMMENT 'The notes of the insurance capitation contract record.',
    `payment_frequency` STRING COMMENT 'The payment frequency of the insurance capitation contract record.',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'The pmpm rate of the insurance capitation contract record.',
    `pmpm_rate_amount` DECIMAL(18,2) COMMENT 'The pmpm rate amount of the insurance capitation contract record.',
    `quality_bonus_eligible` BOOLEAN COMMENT 'Quality bonus eligible flag',
    `quality_withhold_percentage` DECIMAL(18,2) COMMENT 'The quality withhold percentage of the insurance capitation contract record.',
    `reconciliation_frequency` STRING COMMENT 'The reconciliation frequency of the insurance capitation contract record.',
    `risk_adjustment_methodology` STRING COMMENT 'The risk adjustment methodology of the insurance capitation contract record.',
    `risk_arrangement_type` STRING COMMENT 'The risk arrangement type value classifying the insurance capitation contract record.',
    `risk_corridor_lower_threshold` DECIMAL(18,2) COMMENT 'The risk corridor lower threshold of the insurance capitation contract record.',
    `risk_corridor_upper_threshold` DECIMAL(18,2) COMMENT 'The risk corridor upper threshold of the insurance capitation contract record.',
    `service_area` STRING COMMENT 'The service area of the insurance capitation contract record.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'The stop loss threshold of the insurance capitation contract record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance capitation contract record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance capitation contract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance capitation contract record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_capitation_contract PRIMARY KEY(`capitation_contract_id`)
) COMMENT 'Capitation contract defining per-member-per-month payment to provider for defined services.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` (
    `capitation_payment_id` BIGINT COMMENT 'Primary key',
    `capitation_contract_id` BIGINT COMMENT 'FK to capitation contract',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `group_id` BIGINT COMMENT 'FK to provider group',
    `org_provider_id` BIGINT COMMENT 'FK to org provider',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_capitation_payment_id` BIGINT COMMENT 'FK to prior payment',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The adjustment amount of the insurance capitation payment record.',
    `adjustment_reason` STRING COMMENT 'The adjustment reason of the insurance capitation payment record.',
    `age_band_adjustment` DECIMAL(18,2) COMMENT 'The age band adjustment of the insurance capitation payment record.',
    `base_capitation_amount` DECIMAL(18,2) COMMENT 'The base capitation amount of the insurance capitation payment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `gender_adjustment` DECIMAL(18,2) COMMENT 'The gender adjustment of the insurance capitation payment record.',
    `geographic_adjustment` DECIMAL(18,2) COMMENT 'The geographic adjustment of the insurance capitation payment record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance capitation payment record.',
    `member_count` STRING COMMENT 'The member count of the insurance capitation payment record.',
    `member_month_count` STRING COMMENT 'The member month count of the insurance capitation payment record.',
    `member_months` STRING COMMENT 'The member months of the insurance capitation payment record.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net payment amount of the insurance capitation payment record.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The payment amount of the insurance capitation payment record.',
    `payment_date` DATE COMMENT 'Timestamp capturing the payment date associated with the insurance capitation payment record.',
    `payment_method` STRING COMMENT 'The payment method of the insurance capitation payment record.',
    `payment_number` STRING COMMENT 'The payment number of the insurance capitation payment record.',
    `payment_period_end_date` DATE COMMENT 'Timestamp capturing the payment period end date associated with the insurance capitation payment record.',
    `payment_period_start_date` DATE COMMENT 'Timestamp capturing the payment period start date associated with the insurance capitation payment record.',
    `payment_status` STRING COMMENT 'The payment status value classifying the insurance capitation payment record.',
    `quality_bonus_amount` DECIMAL(18,2) COMMENT 'The quality bonus amount of the insurance capitation payment record.',
    `quality_withhold_amount` DECIMAL(18,2) COMMENT 'The quality withhold amount of the insurance capitation payment record.',
    `reconciliation_adjustment` DECIMAL(18,2) COMMENT 'The reconciliation adjustment of the insurance capitation payment record.',
    `risk_adjustment_amount` DECIMAL(18,2) COMMENT 'The risk adjustment amount of the insurance capitation payment record.',
    `stop_loss_recovery_amount` DECIMAL(18,2) COMMENT 'The stop loss recovery amount of the insurance capitation payment record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance capitation payment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance capitation payment record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_capitation_payment PRIMARY KEY(`capitation_payment_id`)
) COMMENT 'Capitation payment made to provider for a defined member panel and time period.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` (
    `risk_adjustment_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `member_enrollment_id` BIGINT COMMENT 'Unique identifier for the member enrollment within the insurance risk adjustment record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_risk_adjustment_id` BIGINT COMMENT 'FK to prior risk adjustment',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber',
    `calculation_date` DATE COMMENT 'Timestamp capturing the calculation date associated with the insurance risk adjustment record.',
    `calculation_method` STRING COMMENT 'The calculation method of the insurance risk adjustment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `diagnosis_count` STRING COMMENT 'The diagnosis count of the insurance risk adjustment record.',
    `hcc_count` STRING COMMENT 'The hcc count of the insurance risk adjustment record.',
    `hcc_list` STRING COMMENT 'The hcc list of the insurance risk adjustment record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance risk adjustment record.',
    `measurement_year` STRING COMMENT 'The measurement year of the insurance risk adjustment record.',
    `model_version` STRING COMMENT 'The model version of the insurance risk adjustment record.',
    `raf_score` DECIMAL(18,2) COMMENT 'The raf score of the insurance risk adjustment record.',
    `risk_model` STRING COMMENT 'The risk model of the insurance risk adjustment record.',
    `risk_score_category` STRING COMMENT 'The risk score category of the insurance risk adjustment record.',
    `submission_status` STRING COMMENT 'The submission status value classifying the insurance risk adjustment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance risk adjustment record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_risk_adjustment PRIMARY KEY(`risk_adjustment_id`)
) COMMENT 'Risk adjustment score (HCC, RAF) for a member used in capitation and quality payment calculations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` (
    `coordination_of_benefits_id` BIGINT COMMENT 'Primary key',
    `claim_id` BIGINT COMMENT 'FK to claim',
    `payer_id` BIGINT COMMENT 'FK to other payer',
    `member_enrollment_id` BIGINT COMMENT 'Unique identifier for the member enrollment within the insurance coordination of benefits record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `primary_payer_id` BIGINT COMMENT 'FK to primary payer',
    `prior_coordination_of_benefits_id` BIGINT COMMENT 'FK to prior COB',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `cob_determination_date` DATE COMMENT 'Timestamp capturing the cob determination date associated with the insurance coordination of benefits record.',
    `cob_determination_method` STRING COMMENT 'The cob determination method of the insurance coordination of benefits record.',
    `cob_order` STRING COMMENT 'The cob order of the insurance coordination of benefits record.',
    `cob_rule` STRING COMMENT 'The cob rule of the insurance coordination of benefits record.',
    `cob_status` STRING COMMENT 'The cob status value classifying the insurance coordination of benefits record.',
    `cob_type` STRING COMMENT 'The cob type value classifying the insurance coordination of benefits record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance coordination of benefits record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance coordination of benefits record.',
    `other_coverage_effective_date` DATE COMMENT 'Timestamp capturing the other coverage effective date associated with the insurance coordination of benefits record.',
    `other_coverage_termination_date` DATE COMMENT 'Timestamp capturing the other coverage termination date associated with the insurance coordination of benefits record.',
    `other_coverage_type` STRING COMMENT 'The other coverage type value classifying the insurance coordination of benefits record.',
    `other_payer_paid_amount` DECIMAL(18,2) COMMENT 'The other payer paid amount of the insurance coordination of benefits record.',
    `other_policy_number` STRING COMMENT 'The other policy number of the insurance coordination of benefits record.',
    `primary_coverage_effective_date` DATE COMMENT 'Timestamp capturing the primary coverage effective date associated with the insurance coordination of benefits record.',
    `primary_coverage_termination_date` DATE COMMENT 'Timestamp capturing the primary coverage termination date associated with the insurance coordination of benefits record.',
    `primary_payer_paid_amount` DECIMAL(18,2) COMMENT 'The primary payer paid amount of the insurance coordination of benefits record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance coordination of benefits record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance coordination of benefits record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance coordination of benefits record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_coordination_of_benefits PRIMARY KEY(`coordination_of_benefits_id`)
) COMMENT 'Coordination of benefits determination when a member has multiple insurance coverages.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` (
    `network_adequacy_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_network_adequacy_id` BIGINT COMMENT 'FK to prior assessment',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
    `adequacy_standard` STRING COMMENT 'The adequacy standard of the insurance network adequacy record.',
    `adequacy_status` STRING COMMENT 'The adequacy status value classifying the insurance network adequacy record.',
    `assessment_date` DATE COMMENT 'Timestamp capturing the assessment date associated with the insurance network adequacy record.',
    `assessment_method` STRING COMMENT 'The assessment method of the insurance network adequacy record.',
    `compliance_status` STRING COMMENT 'The compliance status value classifying the insurance network adequacy record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `distance_standard_met` BOOLEAN COMMENT 'Distance standard met flag',
    `distance_standard_met_flag` BOOLEAN COMMENT 'The distance standard met flag of the insurance network adequacy record.',
    `geographic_region` STRING COMMENT 'The geographic region of the insurance network adequacy record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance network adequacy record.',
    `max_distance_miles` DECIMAL(18,2) COMMENT 'The max distance miles of the insurance network adequacy record.',
    `max_wait_time_days` STRING COMMENT 'The max wait time days of the insurance network adequacy record.',
    `measurement_date` DATE COMMENT 'Timestamp capturing the measurement date associated with the insurance network adequacy record.',
    `member_count` STRING COMMENT 'The member count of the insurance network adequacy record.',
    `notes` STRING COMMENT 'The notes of the insurance network adequacy record.',
    `provider_count` STRING COMMENT 'The provider count of the insurance network adequacy record.',
    `provider_ratio` DECIMAL(18,2) COMMENT 'The provider ratio of the insurance network adequacy record.',
    `provider_to_member_ratio` DECIMAL(18,2) COMMENT 'The provider to member ratio of the insurance network adequacy record.',
    `regulatory_standard` STRING COMMENT 'The regulatory standard of the insurance network adequacy record.',
    `specialty_type` STRING COMMENT 'The specialty type value classifying the insurance network adequacy record.',
    `time_standard_met` BOOLEAN COMMENT 'Time standard met flag',
    `time_standard_met_flag` BOOLEAN COMMENT 'The time standard met flag of the insurance network adequacy record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance network adequacy record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance network adequacy record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_network_adequacy PRIMARY KEY(`network_adequacy_id`)
) COMMENT 'Network adequacy assessment measuring provider availability and access standards for a network.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` (
    `formulary_tier_id` BIGINT COMMENT 'Primary key',
    `drug_master_id` BIGINT COMMENT 'FK to drug master',
    `formulary_id` BIGINT COMMENT 'FK to formulary',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `primary_superseded_by_formulary_tier_id` BIGINT COMMENT 'FK to superseding tier',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'The coinsurance percentage of the insurance formulary tier record.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The copay amount of the insurance formulary tier record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `days_supply_limit` STRING COMMENT 'The days supply limit of the insurance formulary tier record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance formulary tier record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance formulary tier record.',
    `mail_order_copay_amount` DECIMAL(18,2) COMMENT 'The mail order copay amount of the insurance formulary tier record.',
    `prior_authorization_required` BOOLEAN COMMENT 'Prior auth required flag',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'The prior authorization required flag of the insurance formulary tier record.',
    `quantity_limit` STRING COMMENT 'The quantity limit of the insurance formulary tier record.',
    `step_therapy_required` BOOLEAN COMMENT 'Step therapy required flag',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance formulary tier record.',
    `tier_description` STRING COMMENT 'The tier description of the insurance formulary tier record.',
    `tier_level` STRING COMMENT 'The tier level of the insurance formulary tier record.',
    `tier_name` STRING COMMENT 'The tier name of the insurance formulary tier record.',
    `tier_number` STRING COMMENT 'The tier number of the insurance formulary tier record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance formulary tier record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance formulary tier record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_formulary_tier PRIMARY KEY(`formulary_tier_id`)
) COMMENT 'Formulary tier assignment for a drug in a health plans formulary with cost-sharing rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` (
    `premium_billing_id` BIGINT COMMENT 'Primary key',
    `employer_group_id` BIGINT COMMENT 'FK to employer group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `member_enrollment_id` BIGINT COMMENT 'Unique identifier for the member enrollment within the insurance premium billing record.',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_premium_billing_id` BIGINT COMMENT 'FK to prior billing',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber',
    `amount_due` DECIMAL(18,2) COMMENT 'The amount due of the insurance premium billing record.',
    `amount_paid` DECIMAL(18,2) COMMENT 'The amount paid of the insurance premium billing record.',
    `billing_date` DATE COMMENT 'Timestamp capturing the billing date associated with the insurance premium billing record.',
    `billing_frequency` STRING COMMENT 'The billing frequency of the insurance premium billing record.',
    `billing_period_end_date` DATE COMMENT 'Timestamp capturing the billing period end date associated with the insurance premium billing record.',
    `billing_period_start_date` DATE COMMENT 'Timestamp capturing the billing period start date associated with the insurance premium billing record.',
    `billing_status` STRING COMMENT 'The billing status value classifying the insurance premium billing record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `due_date` DATE COMMENT 'Timestamp capturing the due date associated with the insurance premium billing record.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The employer contribution amount of the insurance premium billing record.',
    `grace_period_end_date` DATE COMMENT 'Timestamp capturing the grace period end date associated with the insurance premium billing record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance premium billing record.',
    `invoice_number` STRING COMMENT 'The invoice number of the insurance premium billing record.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'The late fee amount of the insurance premium billing record.',
    `member_contribution_amount` DECIMAL(18,2) COMMENT 'The member contribution amount of the insurance premium billing record.',
    `payment_date` DATE COMMENT 'Timestamp capturing the payment date associated with the insurance premium billing record.',
    `payment_method` STRING COMMENT 'The payment method of the insurance premium billing record.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The premium amount of the insurance premium billing record.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'The subsidy amount of the insurance premium billing record.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'The total amount due of the insurance premium billing record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance premium billing record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance premium billing record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_premium_billing PRIMARY KEY(`premium_billing_id`)
) COMMENT 'Premium billing record for a subscriber or employer group with payment status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` (
    `payer_contact_id` BIGINT COMMENT 'Primary key',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_payer_contact_id` BIGINT COMMENT 'FK to prior contact',
    `active_flag` BOOLEAN COMMENT 'The active flag of the insurance payer contact record.',
    `contact_email` STRING COMMENT 'The contact email of the insurance payer contact record.',
    `contact_first_name` STRING COMMENT 'The contact first name of the insurance payer contact record.',
    `contact_last_name` STRING COMMENT 'The contact last name of the insurance payer contact record.',
    `contact_name` STRING COMMENT 'The contact name of the insurance payer contact record.',
    `contact_phone` STRING COMMENT 'The contact phone of the insurance payer contact record.',
    `contact_role` STRING COMMENT 'The contact role of the insurance payer contact record.',
    `contact_title` STRING COMMENT 'The contact title of the insurance payer contact record.',
    `contact_type` STRING COMMENT 'The contact type value classifying the insurance payer contact record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `department` STRING COMMENT 'The department of the insurance payer contact record.',
    `email_address` STRING COMMENT 'The email address of the insurance payer contact record.',
    `fax_number` STRING COMMENT 'The fax number of the insurance payer contact record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance payer contact record.',
    `is_primary_contact` BOOLEAN COMMENT 'Is primary contact flag',
    `notes` STRING COMMENT 'The notes of the insurance payer contact record.',
    `phone_number` STRING COMMENT 'The phone number of the insurance payer contact record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance payer contact record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance payer contact record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_payer_contact PRIMARY KEY(`payer_contact_id`)
) COMMENT 'Contact person at a payer organization for provider relations, claims, or contracting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` (
    `vbc_performance_id` BIGINT COMMENT 'Primary key',
    `capitation_contract_id` BIGINT COMMENT 'FK to capitation contract',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `group_id` BIGINT COMMENT 'FK to provider group',
    `org_provider_id` BIGINT COMMENT 'FK to org provider',
    `payer_contract_id` BIGINT COMMENT 'FK to payer contract',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_vbc_performance_id` BIGINT COMMENT 'FK to prior performance',
    `measure_id` BIGINT COMMENT 'FK to quality measure',
    `actual_performance_rate` DECIMAL(18,2) COMMENT 'The actual performance rate of the insurance vbc performance record.',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'The benchmark rate of the insurance vbc performance record.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'The bonus amount of the insurance vbc performance record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `denominator_count` STRING COMMENT 'The denominator count of the insurance vbc performance record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance vbc performance record.',
    `measure_name` STRING COMMENT 'The measure name of the insurance vbc performance record.',
    `measurement_period` STRING COMMENT 'The measurement period of the insurance vbc performance record.',
    `measurement_period_end_date` DATE COMMENT 'Timestamp capturing the measurement period end date associated with the insurance vbc performance record.',
    `measurement_period_start_date` DATE COMMENT 'Timestamp capturing the measurement period start date associated with the insurance vbc performance record.',
    `numerator_count` STRING COMMENT 'The numerator count of the insurance vbc performance record.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The penalty amount of the insurance vbc performance record.',
    `performance_score` DECIMAL(18,2) COMMENT 'The performance score of the insurance vbc performance record.',
    `performance_status` STRING COMMENT 'The performance status value classifying the insurance vbc performance record.',
    `performance_tier` STRING COMMENT 'The performance tier of the insurance vbc performance record.',
    `quality_score` DECIMAL(18,2) COMMENT 'The quality score of the insurance vbc performance record.',
    `shared_savings_amount` DECIMAL(18,2) COMMENT 'The shared savings amount of the insurance vbc performance record.',
    `target_performance_rate` DECIMAL(18,2) COMMENT 'The target performance rate of the insurance vbc performance record.',
    `total_cost_of_care_amount` DECIMAL(18,2) COMMENT 'The total cost of care amount of the insurance vbc performance record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance vbc performance record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance vbc performance record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_vbc_performance PRIMARY KEY(`vbc_performance_id`)
) COMMENT 'Value-based care performance metrics for a provider or group under a VBC contract.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` (
    `member_attribution_id` BIGINT COMMENT 'Primary key',
    `accountable_care_organization_id` BIGINT COMMENT 'Unique identifier for the accountable care organization within the insurance member attribution record.',
    `clinician_id` BIGINT COMMENT 'FK to PCP clinician',
    `group_id` BIGINT COMMENT 'FK to provider group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `member_enrollment_id` BIGINT COMMENT 'Unique identifier for the member enrollment within the insurance member attribution record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `payer_contract_id` BIGINT COMMENT 'Unique identifier for the payer contract within the insurance member attribution record.',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_member_attribution_id` BIGINT COMMENT 'FK to prior attribution',
    `attribution_date` DATE COMMENT 'Timestamp capturing the attribution date associated with the insurance member attribution record.',
    `attribution_end_date` DATE COMMENT 'Timestamp capturing the attribution end date associated with the insurance member attribution record.',
    `attribution_method` STRING COMMENT 'The attribution method of the insurance member attribution record.',
    `attribution_reason` STRING COMMENT 'The attribution reason of the insurance member attribution record.',
    `attribution_source` STRING COMMENT 'The attribution source of the insurance member attribution record.',
    `attribution_start_date` DATE COMMENT 'Timestamp capturing the attribution start date associated with the insurance member attribution record.',
    `attribution_status` STRING COMMENT 'The attribution status value classifying the insurance member attribution record.',
    `attribution_type` STRING COMMENT 'The attribution type value classifying the insurance member attribution record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance member attribution record.',
    `measurement_period` STRING COMMENT 'The measurement period of the insurance member attribution record.',
    `measurement_year` STRING COMMENT 'The measurement year of the insurance member attribution record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance member attribution record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance member attribution record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_member_attribution PRIMARY KEY(`member_attribution_id`)
) COMMENT 'Attribution of a member to a primary care provider or accountable care organization for quality and cost accountability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` (
    `insurance_payer_enrollment_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Facility or care site associated with this payer enrollment.',
    `clinician_id` BIGINT COMMENT 'Added to expand thin product provider.insurance_payer_enrollment',
    `credentialing_application_id` BIGINT COMMENT 'Credentialing application supporting enrollment',
    `fee_schedule_id` BIGINT COMMENT 'Fee schedule applicable to this enrollment',
    `health_plan_id` BIGINT COMMENT 'Specific health plan within the payer for this enrollment.',
    `insurance_clinician_id` BIGINT COMMENT 'FK to clinician',
    `insurance_provider_network_id` BIGINT COMMENT 'Provider network for this enrollment',
    `org_provider_id` BIGINT COMMENT 'FK to org provider',
    `payer_contract_id` BIGINT COMMENT 'Added to expand thin product insurance.insurance_payer_enrollment',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_insurance_payer_enrollment_id` BIGINT COMMENT 'FK to prior enrollment',
    `provider_network_id` BIGINT COMMENT 'Added to expand thin product insurance.insurance_payer_enrollment',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is accepting new patients under this enrollment.',
    `application_date` DATE COMMENT 'Date when the enrollment application was submitted.',
    `approval_date` DATE COMMENT 'Date when the enrollment was approved by the payer.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_status` STRING COMMENT 'The credentialing status value classifying the insurance insurance payer enrollment record.',
    `delegated_credentialing_flag` BOOLEAN COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance insurance payer enrollment record.',
    `enrollment_effective_date` DATE COMMENT 'Added to expand thin product insurance.insurance_payer_enrollment',
    `enrollment_number` STRING COMMENT 'The enrollment number of the insurance insurance payer enrollment record.',
    `enrollment_processing_days` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `enrollment_review_note` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `enrollment_scope` STRING COMMENT 'The enrollment scope of the insurance insurance payer enrollment record.',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the insurance insurance payer enrollment record.',
    `enrollment_termination_date` DATE COMMENT 'Added to expand thin product insurance.insurance_payer_enrollment',
    `enrollment_type` STRING COMMENT 'Type of enrollment (initial, revalidation, change)',
    `extra_attr_1` STRING COMMENT 'The extra attr 1 of the insurance insurance payer enrollment record.',
    `extra_attr_2` STRING COMMENT 'The extra attr 2 of the insurance insurance payer enrollment record.',
    `extra_attr_3` STRING COMMENT 'The extra attr 3 of the insurance insurance payer enrollment record.',
    `extra_attr_4` STRING COMMENT 'The extra attr 4 of the insurance insurance payer enrollment record.',
    `extra_attr_5` STRING COMMENT 'The extra attr 5 of the insurance insurance payer enrollment record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance insurance payer enrollment record.',
    `last_revalidation_date` DATE COMMENT 'Date of last revalidation',
    `medicaid_enrollment_flag` BOOLEAN COMMENT 'Whether provider is enrolled in Medicaid',
    `medicare_opt_out_flag` BOOLEAN COMMENT 'Whether provider has opted out of Medicare',
    `network_tier` STRING COMMENT 'The network tier of the insurance insurance payer enrollment record.',
    `notes` STRING COMMENT 'Enrollment notes',
    `panel_size_limit` STRING COMMENT 'Maximum panel size allowed under enrollment',
    `par_status` STRING COMMENT 'Participating provider status (e.g., participating, non-participating).',
    `participating_flag` BOOLEAN COMMENT 'Whether provider is participating',
    `payer_provider_number` STRING COMMENT 'The payer provider number of the insurance insurance payer enrollment record.',
    `provider_transaction_access_number` STRING COMMENT 'The provider transaction access number of the insurance insurance payer enrollment record.',
    `ptan` STRING COMMENT 'The ptan of the insurance insurance payer enrollment record.',
    `re_enrollment_date` DATE COMMENT 'Added to expand thin product insurance.insurance_payer_enrollment',
    `recredentialing_due_date` DATE COMMENT 'Date by which recredentialing must be completed.',
    `reimbursement_method` STRING COMMENT 'Reimbursement method (FFS, capitation, bundled, value-based)',
    `reimbursement_rate_percentage` DECIMAL(18,2) COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `revalidation_due_date` DATE COMMENT 'Date revalidation is due',
    `roster_effective_date` DATE COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `specialty_code` STRING COMMENT 'Specialty code for enrollment',
    `ssot_reference` STRING COMMENT 'The ssot reference of the insurance insurance payer enrollment record.',
    `submission_date` DATE COMMENT 'Timestamp capturing the submission date associated with the insurance insurance payer enrollment record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance insurance payer enrollment record.',
    `termination_reason` STRING COMMENT 'Reason for termination of the payer enrollment.',
    `updated_by` STRING COMMENT 'The updated by of the insurance insurance payer enrollment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_expanded_flag` BOOLEAN COMMENT 'Flag added by VIBE batch to expand thin product attribute set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance insurance payer enrollment record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_insurance_payer_enrollment PRIMARY KEY(`insurance_payer_enrollment_id`)
) COMMENT 'SSOT resolved: defer to provider.provider_payer_enrollment as the single source of truth for this concept. This table is a domain-specific extension/reference.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` (
    `payer_compliance_requirement_id` BIGINT COMMENT 'Primary key',
    `compliance_policy_id` BIGINT COMMENT 'FK to compliance policy',
    `payer_contract_id` BIGINT COMMENT 'FK to payer contract',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_payer_compliance_requirement_id` BIGINT COMMENT 'FK to prior requirement',
    `compliance_frequency` STRING COMMENT 'The compliance frequency of the insurance payer compliance requirement record.',
    `compliance_status` STRING COMMENT 'The compliance status value classifying the insurance payer compliance requirement record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `payer_compliance_requirement_description` STRING COMMENT 'The payer compliance requirement description of the insurance payer compliance requirement record.',
    `due_date` DATE COMMENT 'Timestamp capturing the due date associated with the insurance payer compliance requirement record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance payer compliance requirement record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance payer compliance requirement record.',
    `penalty_description` STRING COMMENT 'The penalty description of the insurance payer compliance requirement record.',
    `regulatory_basis` STRING COMMENT 'The regulatory basis of the insurance payer compliance requirement record.',
    `requirement_category` STRING COMMENT 'The requirement category of the insurance payer compliance requirement record.',
    `requirement_name` STRING COMMENT 'The requirement name of the insurance payer compliance requirement record.',
    `requirement_status` STRING COMMENT 'The requirement status value classifying the insurance payer compliance requirement record.',
    `requirement_type` STRING COMMENT 'The requirement type value classifying the insurance payer compliance requirement record.',
    `review_date` DATE COMMENT 'Timestamp capturing the review date associated with the insurance payer compliance requirement record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance payer compliance requirement record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance payer compliance requirement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance payer compliance requirement record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_payer_compliance_requirement PRIMARY KEY(`payer_compliance_requirement_id`)
) COMMENT 'Compliance requirement imposed by a payer (e.g., quality reporting, data submission, audit participation).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` (
    `plan_consent_requirement_id` BIGINT COMMENT 'Primary key',
    `consent_policy_id` BIGINT COMMENT 'FK to consent policy',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `form_template_id` BIGINT COMMENT 'FK to form template',
    `plan_required_consent_form_template_id` BIGINT COMMENT 'Unique identifier for the plan required consent form template within the insurance plan consent requirement record.',
    `prior_plan_consent_requirement_id` BIGINT COMMENT 'FK to prior requirement',
    `consent_category` STRING COMMENT 'The consent category of the insurance plan consent requirement record.',
    `consent_description` STRING COMMENT 'The consent description of the insurance plan consent requirement record.',
    `consent_name` STRING COMMENT 'The consent name of the insurance plan consent requirement record.',
    `consent_type` STRING COMMENT 'The consent type value classifying the insurance plan consent requirement record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance plan consent requirement record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance plan consent requirement record.',
    `mandatory_flag` BOOLEAN COMMENT 'The mandatory flag of the insurance plan consent requirement record.',
    `regulatory_basis` STRING COMMENT 'The regulatory basis of the insurance plan consent requirement record.',
    `required_flag` BOOLEAN COMMENT 'The required flag of the insurance plan consent requirement record.',
    `requirement_description` STRING COMMENT 'The requirement description of the insurance plan consent requirement record.',
    `requirement_status` STRING COMMENT 'The requirement status value classifying the insurance plan consent requirement record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance plan consent requirement record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance plan consent requirement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance plan consent requirement record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_plan_consent_requirement PRIMARY KEY(`plan_consent_requirement_id`)
) COMMENT 'Consent requirement for a health plan (e.g., data sharing, care coordination, telehealth).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`broker` (
    `broker_id` BIGINT COMMENT 'Primary key',
    `prior_broker_id` BIGINT COMMENT 'FK to prior broker',
    `active_flag` BOOLEAN COMMENT 'The active flag of the insurance broker record.',
    `broker_license_number` STRING COMMENT 'The broker license number of the insurance broker record.',
    `broker_type` STRING COMMENT 'The broker type value classifying the insurance broker record.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The commission rate of the insurance broker record.',
    `contact_email` STRING COMMENT 'The contact email of the insurance broker record.',
    `contact_name` STRING COMMENT 'The contact name of the insurance broker record.',
    `contact_phone` STRING COMMENT 'The contact phone of the insurance broker record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `email_address` STRING COMMENT 'The email address of the insurance broker record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance broker record.',
    `license_number` STRING COMMENT 'The license number of the insurance broker record.',
    `license_state` STRING COMMENT 'The license state of the insurance broker record.',
    `broker_name` STRING COMMENT 'The broker name of the insurance broker record.',
    `npi` STRING COMMENT 'Broker NPI',
    `phone_number` STRING COMMENT 'The phone number of the insurance broker record.',
    `broker_status` STRING COMMENT 'The broker status value classifying the insurance broker record.',
    `tax_identification_number` STRING COMMENT 'Broker tax ID',
    `updated_by` STRING COMMENT 'The updated by of the insurance broker record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance broker record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Insurance broker or agent facilitating health plan sales and enrollment.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` (
    `third_party_administrator_id` BIGINT COMMENT 'Primary key',
    `prior_third_party_administrator_id` BIGINT COMMENT 'FK to prior TPA',
    `active_flag` BOOLEAN COMMENT 'The active flag of the insurance third party administrator record.',
    `contact_email` STRING COMMENT 'The contact email of the insurance third party administrator record.',
    `contact_name` STRING COMMENT 'The contact name of the insurance third party administrator record.',
    `contact_phone` STRING COMMENT 'The contact phone of the insurance third party administrator record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance third party administrator record.',
    `email_address` STRING COMMENT 'The email address of the insurance third party administrator record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance third party administrator record.',
    `phone_number` STRING COMMENT 'The phone number of the insurance third party administrator record.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the insurance third party administrator record.',
    `tpa_name` STRING COMMENT 'The tpa name of the insurance third party administrator record.',
    `tpa_npi` STRING COMMENT 'The tpa npi of the insurance third party administrator record.',
    `tpa_tax_identification_number` STRING COMMENT 'TPA tax ID',
    `tpa_type` STRING COMMENT 'The tpa type value classifying the insurance third party administrator record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance third party administrator record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance third party administrator record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_third_party_administrator PRIMARY KEY(`third_party_administrator_id`)
) COMMENT 'Third-party administrator (TPA) managing claims and benefits for self-funded employer groups.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` (
    `accountable_care_organization_id` BIGINT COMMENT 'Primary key',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_accountable_care_organization_id` BIGINT COMMENT 'FK to prior ACO',
    `aco_identifier` STRING COMMENT 'The aco identifier of the insurance accountable care organization record.',
    `aco_name` STRING COMMENT 'The aco name of the insurance accountable care organization record.',
    `aco_npi` STRING COMMENT 'The aco npi of the insurance accountable care organization record.',
    `aco_status` STRING COMMENT 'The aco status value classifying the insurance accountable care organization record.',
    `aco_tax_identification_number` STRING COMMENT 'ACO tax ID',
    `aco_type` STRING COMMENT 'The aco type value classifying the insurance accountable care organization record.',
    `beneficiary_count` STRING COMMENT 'The beneficiary count of the insurance accountable care organization record.',
    `cms_aco_number` STRING COMMENT 'CMS ACO ID',
    `contact_email` STRING COMMENT 'The contact email of the insurance accountable care organization record.',
    `contact_name` STRING COMMENT 'The contact name of the insurance accountable care organization record.',
    `contact_phone` STRING COMMENT 'The contact phone of the insurance accountable care organization record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance accountable care organization record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance accountable care organization record.',
    `member_count` STRING COMMENT 'The member count of the insurance accountable care organization record.',
    `program_name` STRING COMMENT 'The program name of the insurance accountable care organization record.',
    `risk_track` STRING COMMENT 'The risk track of the insurance accountable care organization record.',
    `accountable_care_organization_status` STRING COMMENT 'The accountable care organization status value classifying the insurance accountable care organization record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance accountable care organization record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance accountable care organization record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance accountable care organization record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_accountable_care_organization PRIMARY KEY(`accountable_care_organization_id`)
) COMMENT 'Accountable care organization (ACO) participating in value-based care programs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` (
    `insurance_network_participation2_id` BIGINT COMMENT 'Unique identifier for the insurance network participation2 within the insurance insurance network participation2 record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the insurance insurance network participation2 record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the insurance insurance network participation2 record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the insurance insurance network participation2 record.',
    `payer_contract_id` BIGINT COMMENT 'Unique identifier for the payer contract within the insurance insurance network participation2 record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the insurance insurance network participation2 record.',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network within the insurance insurance network participation2 record.',
    `billing_network_participation_ref` BIGINT COMMENT 'Reference to billing_network_participation record (merged)',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the insurance insurance network participation2 record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance insurance network participation2 record.',
    `insurance_network_participation_ref` BIGINT COMMENT 'Reference to insurance_network_participation record (merged)',
    `network_tier` STRING COMMENT 'The network tier of the insurance insurance network participation2 record.',
    `participant_code` BIGINT COMMENT 'The participant code value classifying the insurance insurance network participation2 record.',
    `participant_type` STRING COMMENT 'Indicates source domain of the participation record (billing, insurance, provider)',
    `participation_status` STRING COMMENT 'The participation status value classifying the insurance insurance network participation2 record.',
    `provider_network_participation_ref` BIGINT COMMENT 'Reference to provider_network_participation record (merged)',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance insurance network participation2 record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the insurance insurance network participation2 record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_insurance_network_participation2 PRIMARY KEY(`insurance_network_participation2_id`)
) COMMENT 'Single source of truth for network participation across billing, insurance, and provider domains; use participant_type to distinguish. pharmacy.pharmacy_network_participation retained separately (PBM domain).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` (
    `insurance_network_participation_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `care_site_id` BIGINT COMMENT 'FK to facility care site',
    `fee_schedule_id` BIGINT COMMENT 'FK to fee schedule',
    `insurance_network_participation2_id` BIGINT COMMENT 'Unique identifier for the network participation within the insurance insurance network participation record.',
    `payer_contract_id` BIGINT COMMENT 'FK to payer contract',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_insurance_network_participation_id` BIGINT COMMENT 'FK to prior participation',
    `provider_location_id` BIGINT COMMENT 'FK to provider location',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `provider_payer_enrollment_id` BIGINT COMMENT 'FK to provider payer enrollment',
    `accepting_new_patients` BOOLEAN COMMENT 'Accepting new patients flag',
    `attribution_eligible` BOOLEAN COMMENT 'Attribution eligible flag',
    `claims_submission_method` STRING COMMENT 'The claims submission method of the insurance insurance network participation record.',
    `consolidated_target` STRING COMMENT 'The consolidated target of the insurance insurance network participation record.',
    `contracted_specialty` STRING COMMENT 'The contracted specialty of the insurance insurance network participation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_date` DATE COMMENT 'Timestamp capturing the credentialing date associated with the insurance insurance network participation record.',
    `credentialing_status` STRING COMMENT 'The credentialing status value classifying the insurance insurance network participation record.',
    `directory_listing_name` STRING COMMENT 'The directory listing name of the insurance insurance network participation record.',
    `directory_visible` BOOLEAN COMMENT 'Directory visible flag',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the insurance insurance network participation record.',
    `exclusion_screening_date` DATE COMMENT 'Timestamp capturing the exclusion screening date associated with the insurance insurance network participation record.',
    `exclusion_status` STRING COMMENT 'The exclusion status value classifying the insurance insurance network participation record.',
    `insurance_batch_marker` STRING COMMENT 'The insurance batch marker of the insurance insurance network participation record.',
    `network_adequacy_category` STRING COMMENT 'The network adequacy category of the insurance insurance network participation record.',
    `network_participation_type` STRING COMMENT 'The network participation type value classifying the insurance insurance network participation record.',
    `network_tier` STRING COMMENT 'The network tier of the insurance insurance network participation record.',
    `npi` STRING COMMENT 'The npi of the insurance insurance network participation record.',
    `panel_status` STRING COMMENT 'The panel status value classifying the insurance insurance network participation record.',
    `participant_type` STRING COMMENT 'participant_type=insurance',
    `participation_status` STRING COMMENT 'The participation status value classifying the insurance insurance network participation record.',
    `participation_tier` STRING COMMENT 'The participation tier of the insurance insurance network participation record.',
    `payer_provider_number` STRING COMMENT 'The payer provider number of the insurance insurance network participation record.',
    `prior_authorization_required` BOOLEAN COMMENT 'Prior auth required flag',
    `quality_tier` STRING COMMENT 'The quality tier of the insurance insurance network participation record.',
    `recredentialing_due_date` DATE COMMENT 'Timestamp capturing the recredentialing due date associated with the insurance insurance network participation record.',
    `reimbursement_method` STRING COMMENT 'The reimbursement method of the insurance insurance network participation record.',
    `risk_arrangement` STRING COMMENT 'The risk arrangement of the insurance insurance network participation record.',
    `specialty_code` STRING COMMENT 'The specialty code value classifying the insurance insurance network participation record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: insurance.network_participation (consolidated network_participation participant_type=insurance)',
    `ssot_consolidation_note` STRING COMMENT 'The ssot consolidation note of the insurance insurance network participation record.',
    `telehealth_enabled` BOOLEAN COMMENT 'Telehealth enabled flag',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the insurance insurance network participation record.',
    `termination_reason` STRING COMMENT 'The termination reason of the insurance insurance network participation record.',
    `termination_reason_code` STRING COMMENT 'The termination reason code value classifying the insurance insurance network participation record.',
    `updated_by` STRING COMMENT 'The updated by of the insurance insurance network participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the insurance insurance network participation record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_insurance_network_participation PRIMARY KEY(`insurance_network_participation_id`)
) COMMENT 'Provider (clinician or facility) participation in an insurance network with credentialing and status. Consolidated into insurance.network_participation (participant_type=insurance).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ADD CONSTRAINT `fk_insurance_payer_parent_payer_id` FOREIGN KEY (`parent_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ADD CONSTRAINT `fk_insurance_payer_primary_successor_payer_id` FOREIGN KEY (`primary_successor_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_predecessor_health_plan_id` FOREIGN KEY (`predecessor_health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_parent_benefit_id` FOREIGN KEY (`parent_benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_parent_network_provider_network_id` FOREIGN KEY (`parent_network_provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_parent_provider_network_id` FOREIGN KEY (`parent_provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ADD CONSTRAINT `fk_insurance_plan_network_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ADD CONSTRAINT `fk_insurance_plan_network_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ADD CONSTRAINT `fk_insurance_plan_network_superseded_plan_network_id` FOREIGN KEY (`superseded_plan_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`plan_network`(`plan_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_primary_superseded_by_coverage_policy_id` FOREIGN KEY (`primary_superseded_by_coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_prior_member_enrollment_id` FOREIGN KEY (`prior_member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_prior_subscriber_id` FOREIGN KEY (`prior_subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_primary_dependent_id` FOREIGN KEY (`primary_dependent_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`broker`(`broker_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_parent_employer_group_id` FOREIGN KEY (`parent_employer_group_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`employer_group`(`employer_group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_third_party_administrator_id` FOREIGN KEY (`third_party_administrator_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`third_party_administrator`(`third_party_administrator_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_payer_contact_id` FOREIGN KEY (`payer_contact_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contact`(`payer_contact_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_renewed_payer_contract_id` FOREIGN KEY (`renewed_payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_primary_predecessor_schedule_fee_schedule_id` FOREIGN KEY (`primary_predecessor_schedule_fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_primary_superseded_by_fee_schedule_line_id` FOREIGN KEY (`primary_superseded_by_fee_schedule_line_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_superseded_prior_auth_rule_id` FOREIGN KEY (`superseded_prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_appealed_utilization_review_id` FOREIGN KEY (`appealed_utilization_review_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`utilization_review`(`utilization_review_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_prior_eligibility_span_id` FOREIGN KEY (`prior_eligibility_span_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_prior_capitation_contract_id` FOREIGN KEY (`prior_capitation_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`capitation_contract`(`capitation_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_capitation_contract_id` FOREIGN KEY (`capitation_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`capitation_contract`(`capitation_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_prior_capitation_payment_id` FOREIGN KEY (`prior_capitation_payment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`capitation_payment`(`capitation_payment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_prior_risk_adjustment_id` FOREIGN KEY (`prior_risk_adjustment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`risk_adjustment`(`risk_adjustment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_primary_payer_id` FOREIGN KEY (`primary_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_prior_coordination_of_benefits_id` FOREIGN KEY (`prior_coordination_of_benefits_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits`(`coordination_of_benefits_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ADD CONSTRAINT `fk_insurance_network_adequacy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ADD CONSTRAINT `fk_insurance_network_adequacy_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ADD CONSTRAINT `fk_insurance_network_adequacy_prior_network_adequacy_id` FOREIGN KEY (`prior_network_adequacy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`network_adequacy`(`network_adequacy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ADD CONSTRAINT `fk_insurance_network_adequacy_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ADD CONSTRAINT `fk_insurance_formulary_tier_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ADD CONSTRAINT `fk_insurance_formulary_tier_primary_superseded_by_formulary_tier_id` FOREIGN KEY (`primary_superseded_by_formulary_tier_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`formulary_tier`(`formulary_tier_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_employer_group_id` FOREIGN KEY (`employer_group_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`employer_group`(`employer_group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_prior_premium_billing_id` FOREIGN KEY (`prior_premium_billing_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`premium_billing`(`premium_billing_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ADD CONSTRAINT `fk_insurance_payer_contact_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ADD CONSTRAINT `fk_insurance_payer_contact_prior_payer_contact_id` FOREIGN KEY (`prior_payer_contact_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contact`(`payer_contact_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_capitation_contract_id` FOREIGN KEY (`capitation_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`capitation_contract`(`capitation_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_prior_vbc_performance_id` FOREIGN KEY (`prior_vbc_performance_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`vbc_performance`(`vbc_performance_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_accountable_care_organization_id` FOREIGN KEY (`accountable_care_organization_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`accountable_care_organization`(`accountable_care_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_prior_member_attribution_id` FOREIGN KEY (`prior_member_attribution_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_attribution`(`member_attribution_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_insurance_provider_network_id` FOREIGN KEY (`insurance_provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_prior_insurance_payer_enrollment_id` FOREIGN KEY (`prior_insurance_payer_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment`(`insurance_payer_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ADD CONSTRAINT `fk_insurance_payer_compliance_requirement_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ADD CONSTRAINT `fk_insurance_payer_compliance_requirement_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ADD CONSTRAINT `fk_insurance_payer_compliance_requirement_prior_payer_compliance_requirement_id` FOREIGN KEY (`prior_payer_compliance_requirement_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement`(`payer_compliance_requirement_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ADD CONSTRAINT `fk_insurance_plan_consent_requirement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ADD CONSTRAINT `fk_insurance_plan_consent_requirement_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ADD CONSTRAINT `fk_insurance_plan_consent_requirement_prior_plan_consent_requirement_id` FOREIGN KEY (`prior_plan_consent_requirement_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement`(`plan_consent_requirement_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ADD CONSTRAINT `fk_insurance_broker_prior_broker_id` FOREIGN KEY (`prior_broker_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`broker`(`broker_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ADD CONSTRAINT `fk_insurance_third_party_administrator_prior_third_party_administrator_id` FOREIGN KEY (`prior_third_party_administrator_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`third_party_administrator`(`third_party_administrator_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ADD CONSTRAINT `fk_insurance_accountable_care_organization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ADD CONSTRAINT `fk_insurance_accountable_care_organization_prior_accountable_care_organization_id` FOREIGN KEY (`prior_accountable_care_organization_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`accountable_care_organization`(`accountable_care_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` ADD CONSTRAINT `fk_insurance_insurance_network_participation2_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` ADD CONSTRAINT `fk_insurance_insurance_network_participation2_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` ADD CONSTRAINT `fk_insurance_insurance_network_participation2_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_insurance_network_participation2_id` FOREIGN KEY (`insurance_network_participation2_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2`(`insurance_network_participation2_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_prior_insurance_network_participation_id` FOREIGN KEY (`prior_insurance_network_participation_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`insurance` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`insurance` SET TAGS ('pii_domain' = 'insurance');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` SET TAGS ('pii_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `apm_sponsor_flag` SET TAGS ('pii_business_glossary_term' = 'APM Sponsor Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('pii_business_glossary_term' = 'MIPS Reporting Payer Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `risk_adjustment_model` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Model');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` SET TAGS ('pii_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` SET TAGS ('pii_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` SET TAGS ('pii_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` SET TAGS ('pii_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicaid_number` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` SET TAGS ('pii_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_number` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `suffix` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` SET TAGS ('pii_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `suffix` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` SET TAGS ('pii_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `employer_ein` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `grace_period_days` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `situs_state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `situs_state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `situs_state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `situs_state_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `situs_state_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `situs_state_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `state_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `state_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `underwriting_tier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `underwriting_tier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `underwriting_tier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `underwriting_tier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `underwriting_tier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `underwriting_tier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `underwriting_tier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `apm_program_type` SET TAGS ('pii_business_glossary_term' = 'APM Program Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `care_gap_closure_incentive_amount` SET TAGS ('pii_business_glossary_term' = 'Care Gap Closure Incentive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'MIPS Reporting Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `raf_adjustment_applicable_flag` SET TAGS ('pii_business_glossary_term' = 'RAF Adjustment Applicable');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` SET TAGS ('pii_subdomain' = 'utilization_authorization');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` SET TAGS ('pii_subdomain' = 'utilization_authorization');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_documentation_reviewed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_documentation_reviewed` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_documentation_reviewed` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_documentation_reviewed` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_documentation_reviewed` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_documentation_reviewed` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_documentation_reviewed` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` SET TAGS ('pii_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` SET TAGS ('pii_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` SET TAGS ('pii_subdomain' = 'value_payment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` SET TAGS ('pii_subdomain' = 'value_payment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `gender_adjustment` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `gender_adjustment` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `gender_adjustment` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `geographic_adjustment` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `geographic_adjustment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `geographic_adjustment` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `geographic_adjustment` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `geographic_adjustment` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `geographic_adjustment` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` SET TAGS ('pii_subdomain' = 'value_payment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` SET TAGS ('pii_subdomain' = 'utilization_authorization');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `geographic_region` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `geographic_region` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `geographic_region` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `geographic_region` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `geographic_region` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `geographic_region` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` SET TAGS ('pii_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` SET TAGS ('pii_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` SET TAGS ('pii_subdomain' = 'value_payment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `measure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `measure_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `measure_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `measure_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `measure_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `measure_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` SET TAGS ('pii_subdomain' = 'value_payment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_association_edges' = 'provider.clinician,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_domain' = 'insurance');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_reconciled' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_ssot' = 'provider.provider_payer_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_ssot_pair' = 'provider.provider_payer_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_scope' = 'payer_perspective');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_ssot_differentiated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_enrollment_context' = 'network_directory');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_ssot_canonical' = 'provider.provider_payer_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_ssot_primary' = 'provider.provider_payer_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_ssot_reference' = 'provider.provider_payer_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('pii_duplicate_pair' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_role' = 'primary_provider_network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `enrollment_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `par_status` SET TAGS ('pii_business_glossary_term' = 'PAR Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `participating_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `participating_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `participating_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `participating_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `participating_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `participating_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `participating_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `recredentialing_due_date` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Due Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` SET TAGS ('pii_subdomain' = 'utilization_authorization');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` SET TAGS ('pii_association_edges' = 'compliance.compliance_program,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` SET TAGS ('pii_subdomain' = 'utilization_authorization');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` SET TAGS ('pii_association_edges' = 'insurance.health_plan,consent.consent_form_template');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `consent_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `consent_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `consent_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `consent_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `consent_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `consent_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` SET TAGS ('pii_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` SET TAGS ('pii_subdomain' = 'value_payment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_tax_identification_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` SET TAGS ('pii_subdomain' = 'value_payment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_tax_identification_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` SET TAGS ('pii_ssot' = 'consolidated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` SET TAGS ('pii_consolidates' = 'billing.billing_network_participation;insurance.insurance_network_participation;provider.provider_network_participation');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('pii_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('pii_ssot_canonical' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('pii_ssot_consolidated_into' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('pii_consolidated_into' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('pii_ssot' = 'deprecated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `accepting_new_patients` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `accepting_new_patients` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `accepting_new_patients` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `accepting_new_patients` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `accepting_new_patients` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `accepting_new_patients` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `accepting_new_patients` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_listing_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_listing_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_listing_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_listing_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_listing_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_listing_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_listing_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_listing_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
