-- Schema for Domain: provider | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`provider` COMMENT 'Authoritative repository for all healthcare professionals and organizational providers. Includes physicians, nurses, allied health professionals, NPI (National Provider Identifier), DEA numbers, credentials, specialties, licensure, hospital privileges, credentialing status, payer enrollment, and provider network affiliations. SSOT for provider identity and authorization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`clinician` (
    `clinician_id` BIGINT COMMENT 'Primary key',
    `specialty_id` BIGINT COMMENT 'Primary clinical specialty',
    `board_certification_expiration_date` DATE COMMENT 'Board certification expiry',
    `board_certified` BOOLEAN COMMENT 'Board certification status',
    `caqh_provider_number` STRING COMMENT 'CAQH provider identifier',
    `clinician_status` STRING COMMENT 'The clinician status value classifying the provider clinician record.',
    `clinician_type` STRING COMMENT 'MD, DO, NP, PA, etc.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_expiration_date` DATE COMMENT 'Credentialing expiry date',
    `credentialing_status` STRING COMMENT 'Active, Pending, Expired',
    `date_of_birth` DATE COMMENT 'Provider date of birth',
    `dea_number` STRING COMMENT 'DEA registration number',
    `email_address` STRING COMMENT 'The email address of the provider clinician record.',
    `employment_status` STRING COMMENT 'Active, Terminated, On Leave',
    `employment_type` STRING COMMENT 'Employed, Contracted, Locum',
    `fellowship_completion_date` DATE COMMENT 'Timestamp capturing the fellowship completion date associated with the provider clinician record.',
    `fellowship_program_name` STRING COMMENT 'The fellowship program name of the provider clinician record.',
    `first_name` STRING COMMENT 'Provider first name',
    `gender` STRING COMMENT 'Provider gender',
    `hire_date` DATE COMMENT 'Employment start date',
    `internship_completion_date` DATE COMMENT 'Timestamp capturing the internship completion date associated with the provider clinician record.',
    `internship_program_name` STRING COMMENT 'The internship program name of the provider clinician record.',
    `last_name` STRING COMMENT 'Provider last name',
    `license_expiration_date` DATE COMMENT 'State license expiry',
    `license_state` STRING COMMENT 'State of licensure',
    `malpractice_expiration_date` DATE COMMENT 'Malpractice insurance expiry',
    `malpractice_policy_number` STRING COMMENT 'The malpractice policy number of the provider clinician record.',
    `medicaid_enrolled` BOOLEAN COMMENT 'Medicaid enrollment status',
    `medical_degree` STRING COMMENT 'MD, DO, MBBS, etc.',
    `medical_school_graduation_date` DATE COMMENT 'Timestamp capturing the medical school graduation date associated with the provider clinician record.',
    `medical_school_name` STRING COMMENT 'The medical school name of the provider clinician record.',
    `medicare_enrolled` BOOLEAN COMMENT 'Medicare enrollment status',
    `middle_name` STRING COMMENT 'Provider middle name',
    `name_suffix` STRING COMMENT 'Jr, Sr, III, etc.',
    `npi` STRING COMMENT 'The npi of the provider clinician record.',
    `oig_exclusion_check_date` DATE COMMENT 'Timestamp capturing the oig exclusion check date associated with the provider clinician record.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'OIG exclusion check performed',
    `payer_enrollment_status` STRING COMMENT 'The payer enrollment status value classifying the provider clinician record.',
    `phone` STRING COMMENT 'The phone of the provider clinician record.',
    `primary_source_verified` BOOLEAN COMMENT 'Primary source verification completed',
    `professional_designation` STRING COMMENT 'FACP, FACS, etc.',
    `residency_acgme_accredited` BOOLEAN COMMENT 'ACGME accreditation status',
    `residency_completion_date` DATE COMMENT 'Timestamp capturing the residency completion date associated with the provider clinician record.',
    `residency_program_name` STRING COMMENT 'The residency program name of the provider clinician record.',
    `state_license_number` STRING COMMENT 'The state license number of the provider clinician record.',
    `termination_date` DATE COMMENT 'Employment termination date',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vibe_provider_domain_ensured` STRING COMMENT 'The vibe provider domain ensured of the provider clinician record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider clinician record.',
    `work_email` STRING COMMENT 'Work email address',
    `work_phone` STRING COMMENT 'Work phone number',
    CONSTRAINT pk_clinician PRIMARY KEY(`clinician_id`)
) COMMENT 'Individual healthcare providers (physicians, NPs, PAs, etc.) with clinical credentials';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`org_provider` (
    `org_provider_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider org provider record.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: org_provider stores primary_specialty as a free-text STRING, which is a denormalized reference to the specialty reference table. Replacing this with a proper FK specialty_id → specialty ensures refere',
    `accreditation_body` STRING COMMENT 'Accrediting organization',
    `accreditation_expiration_date` DATE COMMENT 'Accreditation expiry',
    `accreditation_status` STRING COMMENT 'The accreditation status value classifying the provider org provider record.',
    `address_line1` STRING COMMENT 'The address line1 of the provider org provider record.',
    `address_line2` STRING COMMENT 'The address line2 of the provider org provider record.',
    `bed_count` STRING COMMENT 'Licensed bed count',
    `city` STRING COMMENT 'The city of the provider org provider record.',
    `cms_certification_number` STRING COMMENT 'The cms certification number of the provider org provider record.',
    `county` STRING COMMENT 'The county of the provider org provider record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_expiration_date` DATE COMMENT 'Credentialing expiry',
    `credentialing_status` STRING COMMENT 'The credentialing status value classifying the provider org provider record.',
    `critical_access_hospital_flag` BOOLEAN COMMENT 'CAH designation',
    `disproportionate_share_flag` BOOLEAN COMMENT 'DSH designation',
    `doing_business_as_name` STRING COMMENT 'The doing business as name of the provider org provider record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider org provider record.',
    `ehr_system` STRING COMMENT 'EHR system name',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the provider org provider record.',
    `facility_type` STRING COMMENT 'Hospital, Clinic, Lab, etc.',
    `fax` STRING COMMENT 'Fax number',
    `fhir_endpoint_url` STRING COMMENT 'The fhir endpoint url of the provider org provider record.',
    `legal_name` STRING COMMENT 'Legal entity name',
    `license_state` STRING COMMENT 'State of licensure',
    `medicaid_provider_number` STRING COMMENT 'The medicaid provider number of the provider org provider record.',
    `medicare_participation_flag` BOOLEAN COMMENT 'Medicare participation',
    `network_participation_status` STRING COMMENT 'The network participation status value classifying the provider org provider record.',
    `oig_exclusion_flag` BOOLEAN COMMENT 'The oig exclusion flag of the provider org provider record.',
    `org_provider_status` STRING COMMENT 'The org provider status value classifying the provider org provider record.',
    `organization_type` STRING COMMENT 'The organization type value classifying the provider org provider record.',
    `organizational_npi` STRING COMMENT 'The organizational npi of the provider org provider record.',
    `ownership_type` STRING COMMENT 'For-profit, Non-profit, Government',
    `phone` STRING COMMENT 'Phone number',
    `provider_status` STRING COMMENT 'Active, Inactive, Terminated',
    `sam_exclusion_flag` BOOLEAN COMMENT 'The sam exclusion flag of the provider org provider record.',
    `state` STRING COMMENT 'The state of the provider org provider record.',
    `state_license_expiration_date` DATE COMMENT 'State license expiry',
    `state_license_number` STRING COMMENT 'The state license number of the provider org provider record.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the provider org provider record.',
    `teaching_status` STRING COMMENT 'Teaching hospital status',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the provider org provider record.',
    `trauma_level` STRING COMMENT 'Trauma center level',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider org provider record.',
    `website_url` STRING COMMENT 'The website url of the provider org provider record.',
    `zip_code` STRING COMMENT 'The zip code value classifying the provider org provider record.',
    CONSTRAINT pk_org_provider PRIMARY KEY(`org_provider_id`)
) COMMENT 'Organizational providers (hospitals, clinics, labs, DME suppliers)';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`specialty` (
    `specialty_id` BIGINT COMMENT 'Primary key',
    `abms_board_name` STRING COMMENT 'The abms board name of the provider specialty record.',
    `acgme_program_code` STRING COMMENT 'The acgme program code value classifying the provider specialty record.',
    `board_certification_body` STRING COMMENT 'The board certification body of the provider specialty record.',
    `board_certification_required` BOOLEAN COMMENT 'The board certification required of the provider specialty record.',
    `board_name` STRING COMMENT 'The board name of the provider specialty record.',
    `specialty_category` STRING COMMENT 'The specialty category of the provider specialty record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider specialty record.',
    `cms_enrollment_specialty_type` STRING COMMENT 'The cms enrollment specialty type value classifying the provider specialty record.',
    `cms_specialty_code` STRING COMMENT 'The cms specialty code value classifying the provider specialty record.',
    `specialty_code` STRING COMMENT 'The specialty code value classifying the provider specialty record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `dea_registration_required` BOOLEAN COMMENT 'The dea registration required of the provider specialty record.',
    `specialty_description` STRING COMMENT 'The specialty description of the provider specialty record.',
    `display_order` STRING COMMENT 'The display order of the provider specialty record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider specialty record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the provider specialty record.',
    `fhir_practitioner_role_code` STRING COMMENT 'The fhir practitioner role code value classifying the provider specialty record.',
    `hedis_measure_set` STRING COMMENT 'The hedis measure set of the provider specialty record.',
    `hospital_privileges_applicable` BOOLEAN COMMENT 'The hospital privileges applicable of the provider specialty record.',
    `mips_eligible` BOOLEAN COMMENT 'The mips eligible of the provider specialty record.',
    `specialty_name` STRING COMMENT 'The specialty name of the provider specialty record.',
    `network_adequacy_category` STRING COMMENT 'The network adequacy category of the provider specialty record.',
    `npi_taxonomy_eligible` BOOLEAN COMMENT 'The npi taxonomy eligible of the provider specialty record.',
    `nucc_classification` STRING COMMENT 'The nucc classification of the provider specialty record.',
    `nucc_provider_type` STRING COMMENT 'The nucc provider type value classifying the provider specialty record.',
    `nucc_specialization` STRING COMMENT 'The nucc specialization of the provider specialty record.',
    `nucc_taxonomy_code` STRING COMMENT 'The nucc taxonomy code value classifying the provider specialty record.',
    `payer_enrollment_eligible` BOOLEAN COMMENT 'The payer enrollment eligible of the provider specialty record.',
    `pecos_specialty_code` STRING COMMENT 'The pecos specialty code value classifying the provider specialty record.',
    `prescribing_authority` BOOLEAN COMMENT 'The prescribing authority of the provider specialty record.',
    `primary_care_designation` BOOLEAN COMMENT 'The primary care designation of the provider specialty record.',
    `prior_authorization_required` BOOLEAN COMMENT 'The prior authorization required of the provider specialty record.',
    `referral_required` BOOLEAN COMMENT 'The referral required of the provider specialty record.',
    `rvu_work_component` DECIMAL(18,2) COMMENT 'The rvu work component of the provider specialty record.',
    `short_description` STRING COMMENT 'The short description of the provider specialty record.',
    `specialty_status` STRING COMMENT 'The specialty status value classifying the provider specialty record.',
    `specialty_type` STRING COMMENT 'The specialty type value classifying the provider specialty record.',
    `surgical_specialty` BOOLEAN COMMENT 'The surgical specialty of the provider specialty record.',
    `taxonomy_code` STRING COMMENT 'The taxonomy code value classifying the provider specialty record.',
    `telehealth_eligible` BOOLEAN COMMENT 'The telehealth eligible of the provider specialty record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `version_number` STRING COMMENT 'The version number of the provider specialty record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider specialty record.',
    CONSTRAINT pk_specialty PRIMARY KEY(`specialty_id`)
) COMMENT 'Clinical specialties and subspecialties with credentialing and enrollment rules';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`credential` (
    `credential_id` BIGINT COMMENT 'Primary key',
    `board_certification_id` BIGINT COMMENT 'Foreign key linking to provider.board_certification. Business justification: When a credential record is of type board certification, it should reference the authoritative board_certification record. The credential table stores certifying_board_name and moc_status which are ow',
    `clinician_id` BIGINT COMMENT 'Clinician reference',
    `dea_registration_id` BIGINT COMMENT 'Foreign key linking to provider.dea_registration. Business justification: When a credential record is of type DEA, it should reference the authoritative dea_registration record rather than duplicating DEA-specific attributes. The credential table currently stores dea_busine',
    `specialty_id` BIGINT COMMENT 'Specialty reference',
    `board_action_date` DATE COMMENT 'Timestamp capturing the board action date associated with the provider credential record.',
    `board_action_flag` BOOLEAN COMMENT 'The board action flag of the provider credential record.',
    `caqh_submitted` BOOLEAN COMMENT 'The caqh submitted of the provider credential record.',
    `cme_accrediting_organization` STRING COMMENT 'The cme accrediting organization of the provider credential record.',
    `cme_activity_title` STRING COMMENT 'The cme activity title of the provider credential record.',
    `cme_activity_type` STRING COMMENT 'The cme activity type value classifying the provider credential record.',
    `cme_category` STRING COMMENT 'The cme category of the provider credential record.',
    `cme_credit_hours` DECIMAL(18,2) COMMENT 'The cme credit hours of the provider credential record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credential_number` STRING COMMENT 'The credential number of the provider credential record.',
    `credential_status` STRING COMMENT 'The credential status value classifying the provider credential record.',
    `credential_type` STRING COMMENT 'License, Certification, DEA, etc.',
    `days_to_expiration` STRING COMMENT 'The days to expiration of the provider credential record.',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider credential record.',
    `issue_date` DATE COMMENT 'Timestamp capturing the issue date associated with the provider credential record.',
    `issuing_authority` STRING COMMENT 'The issuing authority of the provider credential record.',
    `issuing_authority_name` STRING COMMENT 'The issuing authority name of the provider credential record.',
    `issuing_state` STRING COMMENT 'The issuing state of the provider credential record.',
    `notes` STRING COMMENT 'The notes of the provider credential record.',
    `npdb_queried` BOOLEAN COMMENT 'The npdb queried of the provider credential record.',
    `npdb_query_date` DATE COMMENT 'Timestamp capturing the npdb query date associated with the provider credential record.',
    `oig_exclusion_check_date` DATE COMMENT 'Timestamp capturing the oig exclusion check date associated with the provider credential record.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'The oig exclusion checked of the provider credential record.',
    `payer_enrollment_relevant` BOOLEAN COMMENT 'The payer enrollment relevant of the provider credential record.',
    `primary_source_verified` BOOLEAN COMMENT 'The primary source verified of the provider credential record.',
    `privileging_relevant` BOOLEAN COMMENT 'The privileging relevant of the provider credential record.',
    `psv_date` DATE COMMENT 'Timestamp capturing the psv date associated with the provider credential record.',
    `psv_method` STRING COMMENT 'The psv method of the provider credential record.',
    `recredentialing_due_date` DATE COMMENT 'Timestamp capturing the recredentialing due date associated with the provider credential record.',
    `renewal_date` DATE COMMENT 'Timestamp capturing the renewal date associated with the provider credential record.',
    `restriction_description` STRING COMMENT 'The restriction description of the provider credential record.',
    `sam_exclusion_checked` BOOLEAN COMMENT 'The sam exclusion checked of the provider credential record.',
    `source_system_record_reference` STRING COMMENT 'The source system record reference of the provider credential record.',
    `subtype` STRING COMMENT 'The subtype of the provider credential record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `verification_source` STRING COMMENT 'The verification source of the provider credential record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider credential record.',
    CONSTRAINT pk_credential PRIMARY KEY(`credential_id`)
) COMMENT 'Individual credentials (licenses, certifications, DEA, board certs) with expiration tracking';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`privileging` (
    `privileging_id` BIGINT COMMENT 'Primary key',
    `credential_id` BIGINT COMMENT 'Foreign key linking to provider.credential. Business justification: Clinical privileges are granted based on verified credentials (board certifications, state licenses, DEA registrations). The privileging table has board_certification_required (BOOLEAN) and training_r',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Clinical privileges are granted to providers AT specific facilities (hospitals, clinics). The privileging table describes privileges at a specific facility but has no FK to org_provider. Adding org_pr',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary privileging clinician within the provider privileging record.',
    `privileging_clinician_id` BIGINT COMMENT 'Unique identifier for the privileging clinician within the provider privileging record.',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the provider privileging record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the provider privileging record.',
    `board_certification_required` BOOLEAN COMMENT 'The board certification required of the provider privileging record.',
    `completed_case_volume` STRING COMMENT 'The completed case volume of the provider privileging record.',
    `cpt_code` STRING COMMENT 'The cpt code value classifying the provider privileging record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delineation_form_version` STRING COMMENT 'The delineation form version of the provider privileging record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider privileging record.',
    `emtala_covered` BOOLEAN COMMENT 'The emtala covered of the provider privileging record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider privileging record.',
    `fppe_completion_date` DATE COMMENT 'Timestamp capturing the fppe completion date associated with the provider privileging record.',
    `fppe_required` BOOLEAN COMMENT 'The fppe required of the provider privileging record.',
    `granted_date` DATE COMMENT 'Timestamp capturing the granted date associated with the provider privileging record.',
    `icd10_procedure_code` STRING COMMENT 'The icd10 procedure code value classifying the provider privileging record.',
    `is_provisional` BOOLEAN COMMENT 'Boolean flag indicating the is provisional status of the provider privileging record.',
    `malpractice_verified` BOOLEAN COMMENT 'The malpractice verified of the provider privileging record.',
    `npdb_report_date` DATE COMMENT 'Timestamp capturing the npdb report date associated with the provider privileging record.',
    `npdb_report_required` BOOLEAN COMMENT 'The npdb report required of the provider privileging record.',
    `oppe_last_review_date` DATE COMMENT 'Timestamp capturing the oppe last review date associated with the provider privileging record.',
    `peer_review_score` DECIMAL(18,2) COMMENT 'The peer review score of the provider privileging record.',
    `privilege_category` STRING COMMENT 'The privilege category of the provider privileging record.',
    `privilege_description` STRING COMMENT 'The privilege description of the provider privileging record.',
    `privilege_name` STRING COMMENT 'The privilege name of the provider privileging record.',
    `privilege_number` STRING COMMENT 'The privilege number of the provider privileging record.',
    `privilege_status` STRING COMMENT 'The privilege status value classifying the provider privileging record.',
    `privilege_type` STRING COMMENT 'The privilege type value classifying the provider privileging record.',
    `privileging_status` STRING COMMENT 'The privileging status value classifying the provider privileging record.',
    `provisional_end_date` DATE COMMENT 'Timestamp capturing the provisional end date associated with the provider privileging record.',
    `reappointment_cycle_years` STRING COMMENT 'The reappointment cycle years of the provider privileging record.',
    `request_date` DATE COMMENT 'Timestamp capturing the request date associated with the provider privileging record.',
    `required_case_volume` STRING COMMENT 'The required case volume of the provider privileging record.',
    `revocation_date` DATE COMMENT 'Timestamp capturing the revocation date associated with the provider privileging record.',
    `revocation_reason` STRING COMMENT 'The revocation reason of the provider privileging record.',
    `source_record_reference` STRING COMMENT 'The source record reference of the provider privileging record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the provider privileging record.',
    `suspension_date` DATE COMMENT 'Timestamp capturing the suspension date associated with the provider privileging record.',
    `suspension_reason` STRING COMMENT 'The suspension reason of the provider privileging record.',
    `telemedicine_authorized` BOOLEAN COMMENT 'The telemedicine authorized of the provider privileging record.',
    `training_requirement_met` BOOLEAN COMMENT 'The training requirement met of the provider privileging record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider privileging record.',
    CONSTRAINT pk_privileging PRIMARY KEY(`privileging_id`)
) COMMENT 'Clinical privileges granted to providers at specific facilities';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` (
    `network_affiliation_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider network affiliation record.',
    `group_id` BIGINT COMMENT 'Unique identifier for the group within the provider network affiliation record.',
    `org_provider_id` BIGINT COMMENT 'Org provider',
    `payer_contract_id` BIGINT COMMENT 'Payer contract',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the provider network affiliation record.',
    `provider_network_id` BIGINT COMMENT 'Provider network',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the provider network affiliation record.',
    `accepts_new_patients` BOOLEAN COMMENT 'The accepts new patients of the provider network affiliation record.',
    `aco_participant_flag` BOOLEAN COMMENT 'The aco participant flag of the provider network affiliation record.',
    `affiliation_status` STRING COMMENT 'The affiliation status value classifying the provider network affiliation record.',
    `age_range_max` STRING COMMENT 'The age range max of the provider network affiliation record.',
    `age_range_min` STRING COMMENT 'The age range min of the provider network affiliation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider network affiliation record.',
    `credentialing_expiration_date` DATE COMMENT 'Timestamp capturing the credentialing expiration date associated with the provider network affiliation record.',
    `credentialing_status` STRING COMMENT 'The credentialing status value classifying the provider network affiliation record.',
    `directory_published_flag` BOOLEAN COMMENT 'The directory published flag of the provider network affiliation record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider network affiliation record.',
    `gender_served` STRING COMMENT 'The gender served of the provider network affiliation record.',
    `geographic_service_area` STRING COMMENT 'The geographic service area of the provider network affiliation record.',
    `handicap_accessible` BOOLEAN COMMENT 'The handicap accessible of the provider network affiliation record.',
    `hospital_affiliation_flag` BOOLEAN COMMENT 'The hospital affiliation flag of the provider network affiliation record.',
    `languages_spoken` STRING COMMENT 'The languages spoken of the provider network affiliation record.',
    `last_verified_date` DATE COMMENT 'Timestamp capturing the last verified date associated with the provider network affiliation record.',
    `mips_eligible` BOOLEAN COMMENT 'The mips eligible of the provider network affiliation record.',
    `network_adequacy_category` STRING COMMENT 'The network adequacy category of the provider network affiliation record.',
    `network_affiliation_status` STRING COMMENT 'The network affiliation status value classifying the provider network affiliation record.',
    `network_tier` STRING COMMENT 'The network tier of the provider network affiliation record.',
    `notes` STRING COMMENT 'The notes of the provider network affiliation record.',
    `npi` STRING COMMENT 'The npi of the provider network affiliation record.',
    `panel_capacity` STRING COMMENT 'The panel capacity of the provider network affiliation record.',
    `panel_current_count` STRING COMMENT 'The panel current count of the provider network affiliation record.',
    `panel_status` STRING COMMENT 'The panel status value classifying the provider network affiliation record.',
    `participation_type` STRING COMMENT 'The participation type value classifying the provider network affiliation record.',
    `primary_care_designation` BOOLEAN COMMENT 'The primary care designation of the provider network affiliation record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The record created timestamp of the provider network affiliation record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The record updated timestamp of the provider network affiliation record.',
    `reimbursement_model` STRING COMMENT 'The reimbursement model of the provider network affiliation record.',
    `service_area_state` STRING COMMENT 'The service area state of the provider network affiliation record.',
    `service_area_zip_code` STRING COMMENT 'The service area zip code value classifying the provider network affiliation record.',
    `source_record_reference` STRING COMMENT 'The source record reference of the provider network affiliation record.',
    `telehealth_eligible` BOOLEAN COMMENT 'The telehealth eligible of the provider network affiliation record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the provider network affiliation record.',
    `termination_reason` STRING COMMENT 'The termination reason of the provider network affiliation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider network affiliation record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider network affiliation record.',
    CONSTRAINT pk_network_affiliation PRIMARY KEY(`network_affiliation_id`)
) COMMENT 'Provider participation in payer networks with tier and panel status';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`group` (
    `group_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider group record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: A provider group (medical group, IPA, ACO) is typically affiliated with or anchored to a primary organizational provider (hospital or clinic). The group table currently stores hospital_affiliation as ',
    `specialty_id` BIGINT COMMENT 'Primary specialty',
    `accepts_new_patients` BOOLEAN COMMENT 'The accepts new patients of the provider group record.',
    `aco_participant` BOOLEAN COMMENT 'The aco participant of the provider group record.',
    `admin_contact_email` STRING COMMENT 'The admin contact email of the provider group record.',
    `billing_entity_name` STRING COMMENT 'The billing entity name of the provider group record.',
    `billing_npi` STRING COMMENT 'The billing npi of the provider group record.',
    `contract_effective_date` DATE COMMENT 'Timestamp capturing the contract effective date associated with the provider group record.',
    `contract_termination_date` DATE COMMENT 'Timestamp capturing the contract termination date associated with the provider group record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_expiration_date` DATE COMMENT 'Timestamp capturing the credentialing expiration date associated with the provider group record.',
    `credentialing_status` STRING COMMENT 'The credentialing status value classifying the provider group record.',
    `doing_business_as_name` STRING COMMENT 'The doing business as name of the provider group record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider group record.',
    `fqhc_designation` BOOLEAN COMMENT 'The fqhc designation of the provider group record.',
    `group_status` STRING COMMENT 'The group status value classifying the provider group record.',
    `group_type` STRING COMMENT 'The group type value classifying the provider group record.',
    `hl7_fhir_organization_reference` STRING COMMENT 'The hl7 fhir organization reference of the provider group record.',
    `languages_supported` STRING COMMENT 'The languages supported of the provider group record.',
    `last_credentialing_date` DATE COMMENT 'Timestamp capturing the last credentialing date associated with the provider group record.',
    `medicaid_enrollment_status` STRING COMMENT 'The medicaid enrollment status value classifying the provider group record.',
    `medicare_enrollment_status` STRING COMMENT 'The medicare enrollment status value classifying the provider group record.',
    `mips_eligible` BOOLEAN COMMENT 'The mips eligible of the provider group record.',
    `mips_group_reporting` BOOLEAN COMMENT 'The mips group reporting of the provider group record.',
    `group_name` STRING COMMENT 'The group name of the provider group record.',
    `network_participation_status` STRING COMMENT 'The network participation status value classifying the provider group record.',
    `npi` STRING COMMENT 'The group npi of the provider group record.',
    `payer_enrollment_status` STRING COMMENT 'The payer enrollment status value classifying the provider group record.',
    `primary_fax` STRING COMMENT 'The primary fax of the provider group record.',
    `primary_phone` STRING COMMENT 'The primary phone of the provider group record.',
    `primary_service_address_line1` STRING COMMENT 'The primary service address line1 of the provider group record.',
    `primary_service_city` STRING COMMENT 'The primary service city of the provider group record.',
    `primary_service_state` STRING COMMENT 'The primary service state of the provider group record.',
    `primary_service_zip` STRING COMMENT 'The primary service zip of the provider group record.',
    `rhc_designation` BOOLEAN COMMENT 'The rhc designation of the provider group record.',
    `size` STRING COMMENT 'The size of the provider group record.',
    `source_system_group_reference` STRING COMMENT 'The source system group reference of the provider group record.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the provider group record.',
    `telehealth_capable` BOOLEAN COMMENT 'The telehealth capable of the provider group record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the provider group record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider group record.',
    `website_url` STRING COMMENT 'The website url of the provider group record.',
    CONSTRAINT pk_group PRIMARY KEY(`group_id`)
) COMMENT 'Provider groups (medical groups, IPAs, ACOs) with group NPI and TIN';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`group_membership` (
    `group_membership_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'Unique identifier for the group within the provider group membership record.',
    `clinician_id` BIGINT COMMENT 'Primary group clinician',
    `org_provider_id` BIGINT COMMENT 'Primary group org provider',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: group_membership tracks a clinicians role and specialty within a group. The table currently stores primary_specialty as a free-text STRING, which is a denormalized reference to the specialty table. R',
    `academic_appointment_rank` STRING COMMENT 'The academic appointment rank of the provider group membership record.',
    `aco_participation` BOOLEAN COMMENT 'The aco participation of the provider group membership record.',
    `contract_end_date` DATE COMMENT 'Timestamp capturing the contract end date associated with the provider group membership record.',
    `contract_number` STRING COMMENT 'The contract number of the provider group membership record.',
    `contract_start_date` DATE COMMENT 'Timestamp capturing the contract start date associated with the provider group membership record.',
    `cost_center_code` STRING COMMENT 'The cost center code value classifying the provider group membership record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider group membership record.',
    `credentialing_expiration_date` DATE COMMENT 'Timestamp capturing the credentialing expiration date associated with the provider group membership record.',
    `credentialing_status` STRING COMMENT 'The credentialing status value classifying the provider group membership record.',
    `department` STRING COMMENT 'The department of the provider group membership record.',
    `departure_reason` STRING COMMENT 'The departure reason of the provider group membership record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider group membership record.',
    `employment_type` STRING COMMENT 'The employment type value classifying the provider group membership record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the provider group membership record.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The fte allocation of the provider group membership record.',
    `group_membership_status` STRING COMMENT 'The group membership status value classifying the provider group membership record.',
    `is_accepting_patients` BOOLEAN COMMENT 'Boolean flag indicating the is accepting patients status of the provider group membership record.',
    `is_primary_affiliation` BOOLEAN COMMENT 'Boolean flag indicating the is primary affiliation status of the provider group membership record.',
    `is_voluntary_separation` BOOLEAN COMMENT 'Boolean flag indicating the is voluntary separation status of the provider group membership record.',
    `medical_staff_category` STRING COMMENT 'The medical staff category of the provider group membership record.',
    `membership_role` STRING COMMENT 'The membership role of the provider group membership record.',
    `membership_status` STRING COMMENT 'The membership status value classifying the provider group membership record.',
    `mips_eligible` BOOLEAN COMMENT 'The mips eligible of the provider group membership record.',
    `network_participation_status` STRING COMMENT 'The network participation status value classifying the provider group membership record.',
    `notes` STRING COMMENT 'The notes of the provider group membership record.',
    `npdb_report_date` DATE COMMENT 'Timestamp capturing the npdb report date associated with the provider group membership record.',
    `npdb_report_required` BOOLEAN COMMENT 'The npdb report required of the provider group membership record.',
    `npi` STRING COMMENT 'The npi of the provider group membership record.',
    `payer_enrollment_status` STRING COMMENT 'The payer enrollment status value classifying the provider group membership record.',
    `privileging_status` STRING COMMENT 'The privileging status value classifying the provider group membership record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The record created timestamp of the provider group membership record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The record updated timestamp of the provider group membership record.',
    `source_system_record_reference` STRING COMMENT 'The source system record reference of the provider group membership record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the provider group membership record.',
    `supervision_level` STRING COMMENT 'The supervision level of the provider group membership record.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the provider group membership record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider group membership record.',
    `verified_by` STRING COMMENT 'The verified by of the provider group membership record.',
    `verified_date` DATE COMMENT 'Timestamp capturing the verified date associated with the provider group membership record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider group membership record.',
    CONSTRAINT pk_group_membership PRIMARY KEY(`group_membership_id`)
) COMMENT 'Provider membership in groups with FTE allocation and role';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` (
    `dea_registration_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider dea registration record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider dea registration record.',
    `dea_number` STRING COMMENT 'The dea number of the provider dea registration record.',
    `dea_registration_status` STRING COMMENT 'The dea registration status value classifying the provider dea registration record.',
    `dea_schedule` STRING COMMENT 'The dea schedule of the provider dea registration record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider dea registration record.',
    `issue_date` DATE COMMENT 'Timestamp capturing the issue date associated with the provider dea registration record.',
    `registration_status` STRING COMMENT 'The registration status value classifying the provider dea registration record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider dea registration record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider dea registration record.',
    CONSTRAINT pk_dea_registration PRIMARY KEY(`dea_registration_id`)
) COMMENT 'DEA registration tracking';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`board_certification` (
    `board_certification_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider board certification record.',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the provider board certification record.',
    `board_certification_status` STRING COMMENT 'The board certification status value classifying the provider board certification record.',
    `board_name` STRING COMMENT 'The board name of the provider board certification record.',
    `certification_date` DATE COMMENT 'Timestamp capturing the certification date associated with the provider board certification record.',
    `certification_status` STRING COMMENT 'The certification status value classifying the provider board certification record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider board certification record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider board certification record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider board certification record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider board certification record.',
    CONSTRAINT pk_board_certification PRIMARY KEY(`board_certification_id`)
) COMMENT 'Board certifications';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_board_certification_id` FOREIGN KEY (`board_certification_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`board_certification`(`board_certification_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_dea_registration_id` FOREIGN KEY (`dea_registration_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`dea_registration`(`dea_registration_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`credential`(`credential_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_privileging_clinician_id` FOREIGN KEY (`privileging_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`provider` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`provider` SET TAGS ('dbx_domain' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` SET TAGS ('dbx_subdomain' = 'individual_practitioners');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `caqh_provider_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `gender` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `malpractice_policy_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_degree` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_degree` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_graduation_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_graduation_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` SET TAGS ('dbx_subdomain' = 'organizational_entities');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `cms_certification_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` SET TAGS ('dbx_subdomain' = 'organizational_entities');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` SET TAGS ('dbx_subdomain' = 'individual_practitioners');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `credential_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `board_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Dea Registration Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `credential_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` SET TAGS ('dbx_subdomain' = 'individual_practitioners');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privileging_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` SET TAGS ('dbx_subdomain' = 'organizational_entities');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `network_affiliation_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` SET TAGS ('dbx_subdomain' = 'organizational_entities');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` SET TAGS ('dbx_subdomain' = 'organizational_entities');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `group_membership_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `verified_by` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` SET TAGS ('dbx_subdomain' = 'individual_practitioners');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` SET TAGS ('dbx_subdomain' = 'individual_practitioners');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_certification_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('dbx_mask_non_prod' = 'true');
