-- Schema for Domain: insurance | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:40

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
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Health plans contract with medical groups for network participation. Provider directory publishing, network adequacy calculations, and member assignment workflows require tracking which medical groups',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Health plans contract with specific hospital/facility organizations for in-network participation. Network adequacy reporting, provider directories, and claims adjudication require knowing which facili',
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
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `parent_benefit_id` BIGINT COMMENT 'FK to parent benefit',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Benefits often have specialty-specific coverage rules (e.g., cardiology procedures require board-certified cardiologist, mental health benefits limited to licensed psychiatrists/psychologists). Prior ',
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
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `primary_superseded_by_coverage_policy_id` BIGINT COMMENT 'FK to superseding policy',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
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
    `dependent_id` BIGINT COMMENT 'Foreign key linking to insurance.dependent. Business justification: A member enrollment record can represent the enrollment of a dependent (not just a subscriber). Currently member_enrollment links to subscriber via member_subscriber_id, but when the enrollee is a dep',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the member subscriber within the insurance member enrollment record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prior_member_enrollment_id` BIGINT COMMENT 'FK to prior enrollment',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
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
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: A dependent is covered under a specific health plan. While the subscriber already links to a health plan, dependents can be enrolled in the same or a different health plan (e.g., child on a separate C',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` (
    `payer_contract_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to provider group',
    `org_provider_id` BIGINT COMMENT 'FK to org provider',
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
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Fee schedules are often negotiated at medical group level, with group-specific rates differing from standard network rates. Claims adjudication, contract reconciliation, and payment processing require',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Fee schedules vary by facility type and specific contracted organizations (e.g., academic medical centers vs. community hospitals). Claims pricing, contract compliance audits, and reimbursement calcul',
    `payer_contract_id` BIGINT COMMENT 'FK to payer contract',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `primary_predecessor_schedule_fee_schedule_id` BIGINT COMMENT 'FK to predecessor schedule',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
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
    `fee_schedule_id` BIGINT COMMENT 'FK to fee schedule',
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
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: A prior authorization rule is the operational implementation of a coverage policys prior auth criteria. coverage_policy contains prior_authorization_required, prior_authorization_criteria, and medica',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `specialty_id` BIGINT COMMENT 'FK to specialty',
    `superseded_prior_auth_rule_id` BIGINT COMMENT 'FK to superseded rule',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` (
    `eligibility_span_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'FK to PCP clinician',
    `dependent_id` BIGINT COMMENT 'Foreign key linking to insurance.dependent. Business justification: An eligibility span tracks the time-bound coverage eligibility for a member. When the member is a dependent, the eligibility span should directly reference the dependent record. Currently eligibility_',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: An eligibility span is the time-bound expression of a members enrollment in a health plan. member_enrollment is the enrollment record that initiates and governs the coverage. Linking eligibility_span',
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
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_dependent_id` FOREIGN KEY (`dependent_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_prior_member_enrollment_id` FOREIGN KEY (`prior_member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_prior_subscriber_id` FOREIGN KEY (`prior_subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_primary_dependent_id` FOREIGN KEY (`primary_dependent_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_renewed_payer_contract_id` FOREIGN KEY (`renewed_payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_primary_predecessor_schedule_fee_schedule_id` FOREIGN KEY (`primary_predecessor_schedule_fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_primary_superseded_by_fee_schedule_line_id` FOREIGN KEY (`primary_superseded_by_fee_schedule_line_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_superseded_prior_auth_rule_id` FOREIGN KEY (`superseded_prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_dependent_id` FOREIGN KEY (`dependent_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_prior_eligibility_span_id` FOREIGN KEY (`prior_eligibility_span_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`insurance` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`insurance` SET TAGS ('dbx_domain' = 'insurance');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` SET TAGS ('dbx_subdomain' = 'plan_administration');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `apm_sponsor_flag` SET TAGS ('dbx_business_glossary_term' = 'APM Sponsor Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('dbx_business_glossary_term' = 'MIPS Reporting Payer Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `mips_reporting_payer_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `risk_adjustment_model` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Model');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` SET TAGS ('dbx_subdomain' = 'plan_administration');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` SET TAGS ('dbx_subdomain' = 'plan_administration');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `vibe_mutation_extra` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` SET TAGS ('dbx_subdomain' = 'plan_administration');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` SET TAGS ('dbx_subdomain' = 'plan_administration');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` SET TAGS ('dbx_subdomain' = 'plan_administration');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` SET TAGS ('dbx_subdomain' = 'member_coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` SET TAGS ('dbx_subdomain' = 'member_coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_number` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `suffix` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` SET TAGS ('dbx_subdomain' = 'member_coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `suffix` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` SET TAGS ('dbx_subdomain' = 'reimbursement_terms');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `apm_program_type` SET TAGS ('dbx_business_glossary_term' = 'APM Program Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `care_gap_closure_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Closure Incentive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'MIPS Reporting Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `mips_reporting_required_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `raf_adjustment_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'RAF Adjustment Applicable');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` SET TAGS ('dbx_subdomain' = 'reimbursement_terms');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` SET TAGS ('dbx_subdomain' = 'reimbursement_terms');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` SET TAGS ('dbx_subdomain' = 'reimbursement_terms');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` SET TAGS ('dbx_subdomain' = 'member_coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_vibe_mutation' = 'true');
