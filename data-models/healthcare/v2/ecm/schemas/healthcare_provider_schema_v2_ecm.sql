-- Schema for Domain: provider | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`provider` COMMENT 'Authoritative repository for all healthcare professionals and organizational providers. Includes physicians, nurses, allied health professionals, NPI (National Provider Identifier), DEA numbers, credentials, specialties, licensure, hospital privileges, credentialing status, payer enrollment, and provider network affiliations. SSOT for provider identity and authorization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`clinician` (
    `clinician_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Primary practice location',
    `specialty_id` BIGINT COMMENT 'Primary clinical specialty',
    `npi_registry_id` BIGINT COMMENT 'NPI registry reference',
    `taxonomy_id` BIGINT COMMENT 'NUCC taxonomy code',
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
    `secondary_specialty` STRING COMMENT 'The secondary specialty of the provider clinician record.',
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
    `accreditation_status_id` BIGINT COMMENT 'Accreditation status reference',
    `business_associate_agreement_id` BIGINT COMMENT 'BAA reference',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider org provider record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider org provider record.',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `npi_registry_id` BIGINT COMMENT 'NPI registry reference',
    `taxonomy_id` BIGINT COMMENT 'NUCC taxonomy code',
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
    `organization_type` STRING COMMENT 'The organization type value classifying the provider org provider record.',
    `organizational_npi` STRING COMMENT 'The organizational npi of the provider org provider record.',
    `ownership_type` STRING COMMENT 'For-profit, Non-profit, Government',
    `phone` STRING COMMENT 'Phone number',
    `primary_specialty` STRING COMMENT 'The primary specialty of the provider org provider record.',
    `provider_status` STRING COMMENT 'Active, Inactive, Terminated',
    `sam_exclusion_flag` BOOLEAN COMMENT 'The sam exclusion flag of the provider org provider record.',
    `state` STRING COMMENT 'The state of the provider org provider record.',
    `state_license_expiration_date` DATE COMMENT 'State license expiry',
    `state_license_number` STRING COMMENT 'The state license number of the provider org provider record.',
    `org_provider_status` STRING COMMENT 'The org provider status value classifying the provider org provider record.',
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
    `cpt_code_id` BIGINT COMMENT 'Primary CPT code',
    `icd_code_id` BIGINT COMMENT 'Primary ICD code',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED concept',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider specialty record.',
    `abms_board_name` STRING COMMENT 'The abms board name of the provider specialty record.',
    `acgme_program_code` STRING COMMENT 'The acgme program code value classifying the provider specialty record.',
    `additional_credentialing_required` BOOLEAN COMMENT 'The additional credentialing required of the provider specialty record.',
    `board_certification_body` STRING COMMENT 'The board certification body of the provider specialty record.',
    `board_certification_required` BOOLEAN COMMENT 'The board certification required of the provider specialty record.',
    `board_name` STRING COMMENT 'The board name of the provider specialty record.',
    `specialty_category` STRING COMMENT 'The specialty category of the provider specialty record.',
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
    `cpt_code_id` BIGINT COMMENT 'Authorized CPT code',
    `clinician_id` BIGINT COMMENT 'Clinician reference',
    `employee_id` BIGINT COMMENT 'Employee reference',
    `material_master_id` BIGINT COMMENT 'Material master',
    `specialty_id` BIGINT COMMENT 'Specialty reference',
    `training_id` BIGINT COMMENT 'Training reference',
    `board_action_date` DATE COMMENT 'Timestamp capturing the board action date associated with the provider credential record.',
    `board_action_flag` BOOLEAN COMMENT 'The board action flag of the provider credential record.',
    `caqh_submitted` BOOLEAN COMMENT 'The caqh submitted of the provider credential record.',
    `certifying_board_name` STRING COMMENT 'The certifying board name of the provider credential record.',
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
    `dea_business_activity_type` STRING COMMENT 'The dea business activity type value classifying the provider credential record.',
    `dea_schedule_authorizations` STRING COMMENT 'The dea schedule authorizations of the provider credential record.',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider credential record.',
    `issue_date` DATE COMMENT 'Timestamp capturing the issue date associated with the provider credential record.',
    `issuing_authority` STRING COMMENT 'The issuing authority of the provider credential record.',
    `issuing_authority_name` STRING COMMENT 'The issuing authority name of the provider credential record.',
    `issuing_state` STRING COMMENT 'The issuing state of the provider credential record.',
    `moc_status` STRING COMMENT 'The moc status value classifying the provider credential record.',
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
    `committee_id` BIGINT COMMENT 'Approving committee',
    `audit_id` BIGINT COMMENT 'Audit reference',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider privileging record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit within the provider privileging record.',
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
    `provisional_end_date` DATE COMMENT 'Timestamp capturing the provisional end date associated with the provider privileging record.',
    `reappointment_cycle_years` STRING COMMENT 'The reappointment cycle years of the provider privileging record.',
    `request_date` DATE COMMENT 'Timestamp capturing the request date associated with the provider privileging record.',
    `required_case_volume` STRING COMMENT 'The required case volume of the provider privileging record.',
    `revocation_date` DATE COMMENT 'Timestamp capturing the revocation date associated with the provider privileging record.',
    `revocation_reason` STRING COMMENT 'The revocation reason of the provider privileging record.',
    `source_record_reference` STRING COMMENT 'The source record reference of the provider privileging record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the provider privileging record.',
    `privileging_status` STRING COMMENT 'The privileging status value classifying the provider privileging record.',
    `suspension_date` DATE COMMENT 'Timestamp capturing the suspension date associated with the provider privileging record.',
    `suspension_reason` STRING COMMENT 'The suspension reason of the provider privileging record.',
    `telemedicine_authorized` BOOLEAN COMMENT 'The telemedicine authorized of the provider privileging record.',
    `training_requirement_met` BOOLEAN COMMENT 'The training requirement met of the provider privileging record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider privileging record.',
    CONSTRAINT pk_privileging PRIMARY KEY(`privileging_id`)
) COMMENT 'Clinical privileges granted to providers at specific facilities';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` (
    `credentialing_application_id` BIGINT COMMENT 'Primary key',
    `committee_id` BIGINT COMMENT 'Approving committee',
    `audit_id` BIGINT COMMENT 'Audit reference',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider credentialing application record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider credentialing application record.',
    `compliance_program_id` BIGINT COMMENT 'Compliance program',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the provider credentialing application record.',
    `specialty_id` BIGINT COMMENT 'Primary specialty',
    `application_number` STRING COMMENT 'The application number of the provider credentialing application record.',
    `application_status` STRING COMMENT 'The application status value classifying the provider credentialing application record.',
    `application_type` STRING COMMENT 'Initial, Reappointment, etc.',
    `board_certification_status` STRING COMMENT 'The board certification status value classifying the provider credentialing application record.',
    `caqh_provider_number` STRING COMMENT 'The caqh provider number of the provider credentialing application record.',
    `cme_compliance_status` STRING COMMENT 'The cme compliance status value classifying the provider credentialing application record.',
    `committee_review_date` DATE COMMENT 'Timestamp capturing the committee review date associated with the provider credentialing application record.',
    `complete_date` DATE COMMENT 'Timestamp capturing the complete date associated with the provider credentialing application record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `dea_number` STRING COMMENT 'The dea number of the provider credentialing application record.',
    `decision_date` DATE COMMENT 'Timestamp capturing the decision date associated with the provider credentialing application record.',
    `decision_type` STRING COMMENT 'Approved, Denied, etc.',
    `denial_reason` STRING COMMENT 'The denial reason of the provider credentialing application record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider credentialing application record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider credentialing application record.',
    `malpractice_aggregate_limit` DECIMAL(18,2) COMMENT 'The malpractice aggregate limit of the provider credentialing application record.',
    `malpractice_coverage_type` STRING COMMENT 'The malpractice coverage type value classifying the provider credentialing application record.',
    `malpractice_insurer_name` STRING COMMENT 'The malpractice insurer name of the provider credentialing application record.',
    `malpractice_per_occurrence_limit` DECIMAL(18,2) COMMENT 'The malpractice per occurrence limit of the provider credentialing application record.',
    `malpractice_policy_effective_date` DATE COMMENT 'Timestamp capturing the malpractice policy effective date associated with the provider credentialing application record.',
    `malpractice_policy_expiration_date` DATE COMMENT 'Timestamp capturing the malpractice policy expiration date associated with the provider credentialing application record.',
    `malpractice_policy_number` STRING COMMENT 'The malpractice policy number of the provider credentialing application record.',
    `medical_staff_category` STRING COMMENT 'The medical staff category of the provider credentialing application record.',
    `npdb_adverse_action_flag` BOOLEAN COMMENT 'The npdb adverse action flag of the provider credentialing application record.',
    `npdb_malpractice_flag` BOOLEAN COMMENT 'The npdb malpractice flag of the provider credentialing application record.',
    `npdb_query_date` DATE COMMENT 'Timestamp capturing the npdb query date associated with the provider credentialing application record.',
    `npdb_query_type` STRING COMMENT 'The npdb query type value classifying the provider credentialing application record.',
    `npdb_reference_number` STRING COMMENT 'The npdb reference number of the provider credentialing application record.',
    `npdb_response_date` DATE COMMENT 'Timestamp capturing the npdb response date associated with the provider credentialing application record.',
    `npdb_response_status` STRING COMMENT 'The npdb response status value classifying the provider credentialing application record.',
    `npi` STRING COMMENT 'The npi of the provider credentialing application record.',
    `oig_exclusion_check_status` STRING COMMENT 'The oig exclusion check status value classifying the provider credentialing application record.',
    `peer_reference_count` STRING COMMENT 'The peer reference count of the provider credentialing application record.',
    `peer_references_complete_flag` BOOLEAN COMMENT 'The peer references complete flag of the provider credentialing application record.',
    `peer_review_summary_status` STRING COMMENT 'The peer review summary status value classifying the provider credentialing application record.',
    `provisional_privileges_expiration_date` DATE COMMENT 'Timestamp capturing the provisional privileges expiration date associated with the provider credentialing application record.',
    `provisional_privileges_flag` BOOLEAN COMMENT 'The provisional privileges flag of the provider credentialing application record.',
    `psv_education_status` STRING COMMENT 'The psv education status value classifying the provider credentialing application record.',
    `psv_license_status` STRING COMMENT 'The psv license status value classifying the provider credentialing application record.',
    `psv_work_history_status` STRING COMMENT 'The psv work history status value classifying the provider credentialing application record.',
    `quality_indicator_review_status` STRING COMMENT 'The quality indicator review status value classifying the provider credentialing application record.',
    `reappointment_review_period_end` DATE COMMENT 'The reappointment review period end of the provider credentialing application record.',
    `reappointment_review_period_start` DATE COMMENT 'The reappointment review period start of the provider credentialing application record.',
    `received_date` DATE COMMENT 'Timestamp capturing the received date associated with the provider credentialing application record.',
    `sam_exclusion_check_status` STRING COMMENT 'The sam exclusion check status value classifying the provider credentialing application record.',
    `secondary_specialty` STRING COMMENT 'The secondary specialty of the provider credentialing application record.',
    `credentialing_application_status` STRING COMMENT 'The credentialing application status value classifying the provider credentialing application record.',
    `submission_date` DATE COMMENT 'Timestamp capturing the submission date associated with the provider credentialing application record.',
    `tail_coverage_indicator` BOOLEAN COMMENT 'The tail coverage indicator of the provider credentialing application record.',
    `telemedicine_privileges_requested` BOOLEAN COMMENT 'The telemedicine privileges requested of the provider credentialing application record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider credentialing application record.',
    CONSTRAINT pk_credentialing_application PRIMARY KEY(`credentialing_application_id`)
) COMMENT 'Initial and reappointment credentialing applications with committee review workflow';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` (
    `network_affiliation_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider network affiliation record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider network affiliation record.',
    `group_id` BIGINT COMMENT 'Unique identifier for the group within the provider network affiliation record.',
    `org_provider_id` BIGINT COMMENT 'Org provider',
    `payer_contract_id` BIGINT COMMENT 'Payer contract',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the provider network affiliation record.',
    `provider_network_id` BIGINT COMMENT 'Provider network',
    `provider_payer_enrollment_id` BIGINT COMMENT 'Provider payer enrollment',
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
    `network_affiliation_status` STRING COMMENT 'The network affiliation status value classifying the provider network affiliation record.',
    `telehealth_eligible` BOOLEAN COMMENT 'The telehealth eligible of the provider network affiliation record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the provider network affiliation record.',
    `termination_reason` STRING COMMENT 'The termination reason of the provider network affiliation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider network affiliation record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider network affiliation record.',
    CONSTRAINT pk_network_affiliation PRIMARY KEY(`network_affiliation_id`)
) COMMENT 'Provider participation in payer networks with tier and panel status';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`group` (
    `group_id` BIGINT COMMENT 'Primary key',
    `business_associate_agreement_id` BIGINT COMMENT 'Unique identifier for the business associate agreement within the provider group record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider group record.',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `specialty_id` BIGINT COMMENT 'Primary specialty',
    `taxonomy_id` BIGINT COMMENT 'Unique identifier for the taxonomy within the provider group record.',
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
    `group_npi` STRING COMMENT 'The group npi of the provider group record.',
    `group_status` STRING COMMENT 'The group status value classifying the provider group record.',
    `group_type` STRING COMMENT 'The group type value classifying the provider group record.',
    `hl7_fhir_organization_reference` STRING COMMENT 'The hl7 fhir organization reference of the provider group record.',
    `hospital_affiliation` STRING COMMENT 'The hospital affiliation of the provider group record.',
    `languages_supported` STRING COMMENT 'The languages supported of the provider group record.',
    `last_credentialing_date` DATE COMMENT 'Timestamp capturing the last credentialing date associated with the provider group record.',
    `medicaid_enrollment_status` STRING COMMENT 'The medicaid enrollment status value classifying the provider group record.',
    `medicare_enrollment_status` STRING COMMENT 'The medicare enrollment status value classifying the provider group record.',
    `mips_eligible` BOOLEAN COMMENT 'The mips eligible of the provider group record.',
    `mips_group_reporting` BOOLEAN COMMENT 'The mips group reporting of the provider group record.',
    `group_name` STRING COMMENT 'The group name of the provider group record.',
    `network_participation_status` STRING COMMENT 'The network participation status value classifying the provider group record.',
    `npi` STRING COMMENT 'The npi of the provider group record.',
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
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider group membership record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the group clinician within the provider group membership record.',
    `group_id` BIGINT COMMENT 'Unique identifier for the group within the provider group membership record.',
    `primary_group_clinician_id` BIGINT COMMENT 'Primary group clinician',
    `org_provider_id` BIGINT COMMENT 'Primary group org provider',
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
    `primary_specialty` STRING COMMENT 'The primary specialty of the provider group membership record.',
    `privileging_status` STRING COMMENT 'The privileging status value classifying the provider group membership record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The record created timestamp of the provider group membership record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The record updated timestamp of the provider group membership record.',
    `secondary_specialty` STRING COMMENT 'The secondary specialty of the provider group membership record.',
    `source_system_record_reference` STRING COMMENT 'The source system record reference of the provider group membership record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the provider group membership record.',
    `group_membership_status` STRING COMMENT 'The group membership status value classifying the provider group membership record.',
    `supervision_level` STRING COMMENT 'The supervision level of the provider group membership record.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the provider group membership record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider group membership record.',
    `verified_by` STRING COMMENT 'The verified by of the provider group membership record.',
    `verified_date` DATE COMMENT 'Timestamp capturing the verified date associated with the provider group membership record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider group membership record.',
    CONSTRAINT pk_group_membership PRIMARY KEY(`group_membership_id`)
) COMMENT 'Provider membership in groups with FTE allocation and role';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` (
    `malpractice_coverage_id` BIGINT COMMENT 'Primary key',
    `ap_invoice_id` BIGINT COMMENT 'AP invoice',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider malpractice coverage record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider malpractice coverage record.',
    `credentialing_application_id` BIGINT COMMENT 'Credentialing application',
    `credentialing_file_id` BIGINT COMMENT 'Credentialing file',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the provider malpractice coverage record.',
    `aggregate_limit` DECIMAL(18,2) COMMENT 'The aggregate limit of the provider malpractice coverage record.',
    `carrier_name` STRING COMMENT 'The carrier name of the provider malpractice coverage record.',
    `certificate_of_insurance_url` STRING COMMENT 'The certificate of insurance url of the provider malpractice coverage record.',
    `claims_history_indicator` BOOLEAN COMMENT 'The claims history indicator of the provider malpractice coverage record.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'The coverage amount of the provider malpractice coverage record.',
    `coverage_lapse_indicator` BOOLEAN COMMENT 'The coverage lapse indicator of the provider malpractice coverage record.',
    `coverage_specialty` STRING COMMENT 'The coverage specialty of the provider malpractice coverage record.',
    `coverage_state` STRING COMMENT 'The coverage state of the provider malpractice coverage record.',
    `coverage_status` STRING COMMENT 'The coverage status value classifying the provider malpractice coverage record.',
    `coverage_type` STRING COMMENT 'The coverage type value classifying the provider malpractice coverage record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'The currency code value classifying the provider malpractice coverage record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider malpractice coverage record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider malpractice coverage record.',
    `group_policy_indicator` BOOLEAN COMMENT 'The group policy indicator of the provider malpractice coverage record.',
    `insurer_contact_name` STRING COMMENT 'The insurer contact name of the provider malpractice coverage record.',
    `insurer_contact_phone` STRING COMMENT 'The insurer contact phone of the provider malpractice coverage record.',
    `insurer_naic_code` STRING COMMENT 'The insurer naic code value classifying the provider malpractice coverage record.',
    `lapse_explanation` STRING COMMENT 'The lapse explanation of the provider malpractice coverage record.',
    `nose_coverage_indicator` BOOLEAN COMMENT 'The nose coverage indicator of the provider malpractice coverage record.',
    `notes` STRING COMMENT 'The notes of the provider malpractice coverage record.',
    `open_claims_count` STRING COMMENT 'The open claims count of the provider malpractice coverage record.',
    `per_occurrence_limit` DECIMAL(18,2) COMMENT 'The per occurrence limit of the provider malpractice coverage record.',
    `policy_holder_name` STRING COMMENT 'The policy holder name of the provider malpractice coverage record.',
    `policy_number` STRING COMMENT 'The policy number of the provider malpractice coverage record.',
    `prior_acts_date` DATE COMMENT 'Timestamp capturing the prior acts date associated with the provider malpractice coverage record.',
    `renewal_reminder_date` DATE COMMENT 'Timestamp capturing the renewal reminder date associated with the provider malpractice coverage record.',
    `self_insured_indicator` BOOLEAN COMMENT 'The self insured indicator of the provider malpractice coverage record.',
    `source_record_reference` STRING COMMENT 'The source record reference of the provider malpractice coverage record.',
    `malpractice_coverage_status` STRING COMMENT 'The malpractice coverage status value classifying the provider malpractice coverage record.',
    `tail_coverage_effective_date` DATE COMMENT 'Timestamp capturing the tail coverage effective date associated with the provider malpractice coverage record.',
    `tail_coverage_expiration_date` DATE COMMENT 'Timestamp capturing the tail coverage expiration date associated with the provider malpractice coverage record.',
    `tail_coverage_indicator` BOOLEAN COMMENT 'The tail coverage indicator of the provider malpractice coverage record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `verification_date` DATE COMMENT 'Timestamp capturing the verification date associated with the provider malpractice coverage record.',
    `verification_method` STRING COMMENT 'The verification method of the provider malpractice coverage record.',
    `verification_status` STRING COMMENT 'The verification status value classifying the provider malpractice coverage record.',
    `verified_by` STRING COMMENT 'The verified by of the provider malpractice coverage record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider malpractice coverage record.',
    CONSTRAINT pk_malpractice_coverage PRIMARY KEY(`malpractice_coverage_id`)
) COMMENT 'Malpractice insurance coverage with limits and tail coverage tracking';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` (
    `npdb_query_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider npdb query record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider npdb query record.',
    `credentialing_application_id` BIGINT COMMENT 'Credentialing application',
    `original_query_npdb_query_id` BIGINT COMMENT 'Original query',
    `reappointment_id` BIGINT COMMENT 'Reappointment',
    `adverse_action_flag` BOOLEAN COMMENT 'The adverse action flag of the provider npdb query record.',
    `adverse_action_report_count` STRING COMMENT 'The adverse action report count of the provider npdb query record.',
    `cms_participating_facility_flag` BOOLEAN COMMENT 'The cms participating facility flag of the provider npdb query record.',
    `continuous_query_disenrollment_date` DATE COMMENT 'Timestamp capturing the continuous query disenrollment date associated with the provider npdb query record.',
    `continuous_query_enrollment_date` DATE COMMENT 'Timestamp capturing the continuous query enrollment date associated with the provider npdb query record.',
    `continuous_query_enrollment_flag` BOOLEAN COMMENT 'The continuous query enrollment flag of the provider npdb query record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_purpose` STRING COMMENT 'The credentialing purpose of the provider npdb query record.',
    `error_code` STRING COMMENT 'The error code value classifying the provider npdb query record.',
    `error_description` STRING COMMENT 'The error description of the provider npdb query record.',
    `malpractice_payment_flag` BOOLEAN COMMENT 'The malpractice payment flag of the provider npdb query record.',
    `malpractice_payment_report_count` STRING COMMENT 'The malpractice payment report count of the provider npdb query record.',
    `notes` STRING COMMENT 'The notes of the provider npdb query record.',
    `practitioner_type` STRING COMMENT 'The practitioner type value classifying the provider npdb query record.',
    `queried_date_of_birth` DATE COMMENT 'The queried date of birth of the provider npdb query record.',
    `queried_dea_number` STRING COMMENT 'The queried dea number of the provider npdb query record.',
    `queried_license_state` STRING COMMENT 'The queried license state of the provider npdb query record.',
    `queried_npi` STRING COMMENT 'The queried npi of the provider npdb query record.',
    `queried_practitioner_name` STRING COMMENT 'The queried practitioner name of the provider npdb query record.',
    `queried_ssn_last4` STRING COMMENT 'The queried ssn last4 of the provider npdb query record.',
    `queried_state_license_number` STRING COMMENT 'The queried state license number of the provider npdb query record.',
    `query_date` DATE COMMENT 'Timestamp capturing the query date associated with the provider npdb query record.',
    `query_expiration_date` DATE COMMENT 'Timestamp capturing the query expiration date associated with the provider npdb query record.',
    `query_reference_number` STRING COMMENT 'The query reference number of the provider npdb query record.',
    `query_status` STRING COMMENT 'The query status value classifying the provider npdb query record.',
    `query_type` STRING COMMENT 'The query type value classifying the provider npdb query record.',
    `querying_organization_name` STRING COMMENT 'The querying organization name of the provider npdb query record.',
    `querying_organization_npdb_number` STRING COMMENT 'The querying organization npdb number of the provider npdb query record.',
    `report_count` STRING COMMENT 'The report count of the provider npdb query record.',
    `report_received_flag` BOOLEAN COMMENT 'The report received flag of the provider npdb query record.',
    `response_date` DATE COMMENT 'Timestamp capturing the response date associated with the provider npdb query record.',
    `response_document_reference` STRING COMMENT 'The response document reference of the provider npdb query record.',
    `response_status` STRING COMMENT 'The response status value classifying the provider npdb query record.',
    `response_turnaround_days` STRING COMMENT 'The response turnaround days of the provider npdb query record.',
    `resubmission_flag` BOOLEAN COMMENT 'The resubmission flag of the provider npdb query record.',
    `review_completed_date` DATE COMMENT 'Timestamp capturing the review completed date associated with the provider npdb query record.',
    `review_outcome` STRING COMMENT 'The review outcome of the provider npdb query record.',
    `review_required_flag` BOOLEAN COMMENT 'The review required flag of the provider npdb query record.',
    `npdb_query_status` STRING COMMENT 'The npdb query status value classifying the provider npdb query record.',
    `submission_method` STRING COMMENT 'The submission method of the provider npdb query record.',
    `submitted_by_user` STRING COMMENT 'The submitted by user of the provider npdb query record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider npdb query record.',
    CONSTRAINT pk_npdb_query PRIMARY KEY(`npdb_query_id`)
) COMMENT 'National Practitioner Data Bank queries and responses';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`sanction` (
    `sanction_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider sanction record.',
    `investigation_id` BIGINT COMMENT 'Investigation',
    `org_provider_id` BIGINT COMMENT 'Org provider',
    `patient_safety_event_id` BIGINT COMMENT 'Patient safety event',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the provider sanction record.',
    `quality_peer_review_id` BIGINT COMMENT 'Quality peer review',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the provider sanction record.',
    `appeal_date` DATE COMMENT 'Timestamp capturing the appeal date associated with the provider sanction record.',
    `appeal_filed` BOOLEAN COMMENT 'The appeal filed of the provider sanction record.',
    `appeal_outcome` STRING COMMENT 'The appeal outcome of the provider sanction record.',
    `case_reference_number` STRING COMMENT 'The case reference number of the provider sanction record.',
    `cia_reference_number` STRING COMMENT 'The cia reference number of the provider sanction record.',
    `civil_monetary_penalty_amount` DECIMAL(18,2) COMMENT 'The civil monetary penalty amount of the provider sanction record.',
    `corporate_integrity_agreement` BOOLEAN COMMENT 'The corporate integrity agreement of the provider sanction record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_hold` BOOLEAN COMMENT 'The credentialing hold of the provider sanction record.',
    `dea_registration_number` STRING COMMENT 'The dea registration number of the provider sanction record.',
    `exclusion_type_code` STRING COMMENT 'The exclusion type code value classifying the provider sanction record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider sanction record.',
    `federal_program_exclusion` BOOLEAN COMMENT 'The federal program exclusion of the provider sanction record.',
    `internal_review_date` DATE COMMENT 'Timestamp capturing the internal review date associated with the provider sanction record.',
    `internal_review_status` STRING COMMENT 'The internal review status value classifying the provider sanction record.',
    `issuing_authority` STRING COMMENT 'The issuing authority of the provider sanction record.',
    `issuing_authority_type` STRING COMMENT 'The issuing authority type value classifying the provider sanction record.',
    `license_number` STRING COMMENT 'The license number of the provider sanction record.',
    `license_state` STRING COMMENT 'The license state of the provider sanction record.',
    `medicaid_exclusion` BOOLEAN COMMENT 'The medicaid exclusion of the provider sanction record.',
    `medicare_exclusion` BOOLEAN COMMENT 'The medicare exclusion of the provider sanction record.',
    `notes` STRING COMMENT 'The notes of the provider sanction record.',
    `notification_date` DATE COMMENT 'Timestamp capturing the notification date associated with the provider sanction record.',
    `notification_sent` BOOLEAN COMMENT 'The notification sent of the provider sanction record.',
    `npdb_report_date` DATE COMMENT 'Timestamp capturing the npdb report date associated with the provider sanction record.',
    `npdb_report_number` STRING COMMENT 'The npdb report number of the provider sanction record.',
    `npi` STRING COMMENT 'The npi of the provider sanction record.',
    `payer_enrollment_impact` BOOLEAN COMMENT 'The payer enrollment impact of the provider sanction record.',
    `privilege_suspension` BOOLEAN COMMENT 'The privilege suspension of the provider sanction record.',
    `provider_type` STRING COMMENT 'The provider type value classifying the provider sanction record.',
    `reason` STRING COMMENT 'The reason of the provider sanction record.',
    `reason_code` STRING COMMENT 'The reason code value classifying the provider sanction record.',
    `reinstatement_date` DATE COMMENT 'Timestamp capturing the reinstatement date associated with the provider sanction record.',
    `reported_to_npdb` BOOLEAN COMMENT 'The reported to npdb of the provider sanction record.',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the provider sanction record.',
    `sanction_date` DATE COMMENT 'Timestamp capturing the sanction date associated with the provider sanction record.',
    `sanction_status` STRING COMMENT 'The sanction status value classifying the provider sanction record.',
    `sanction_type` STRING COMMENT 'The sanction type value classifying the provider sanction record.',
    `sanctioning_authority` STRING COMMENT 'The sanctioning authority of the provider sanction record.',
    `screening_date` DATE COMMENT 'Timestamp capturing the screening date associated with the provider sanction record.',
    `screening_frequency` STRING COMMENT 'The screening frequency of the provider sanction record.',
    `screening_source` STRING COMMENT 'The screening source of the provider sanction record.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The settlement amount of the provider sanction record.',
    `source_document_reference` STRING COMMENT 'The source document reference of the provider sanction record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider sanction record.',
    CONSTRAINT pk_sanction PRIMARY KEY(`sanction_id`)
) COMMENT 'Provider sanctions, exclusions, and adverse actions (OIG, SAM, state boards)';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` (
    `dea_registration_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider dea registration record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider dea registration record.',
    `dea_number` STRING COMMENT 'The dea number of the provider dea registration record.',
    `dea_schedule` STRING COMMENT 'The dea schedule of the provider dea registration record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider dea registration record.',
    `issue_date` DATE COMMENT 'Timestamp capturing the issue date associated with the provider dea registration record.',
    `registration_status` STRING COMMENT 'The registration status value classifying the provider dea registration record.',
    `dea_registration_status` STRING COMMENT 'The dea registration status value classifying the provider dea registration record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider dea registration record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider dea registration record.',
    CONSTRAINT pk_dea_registration PRIMARY KEY(`dea_registration_id`)
) COMMENT 'DEA registration tracking';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`board_certification` (
    `board_certification_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider board certification record.',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the provider board certification record.',
    `board_name` STRING COMMENT 'The board name of the provider board certification record.',
    `certification_date` DATE COMMENT 'Timestamp capturing the certification date associated with the provider board certification record.',
    `certification_status` STRING COMMENT 'The certification status value classifying the provider board certification record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider board certification record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider board certification record.',
    `board_certification_status` STRING COMMENT 'The board certification status value classifying the provider board certification record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider board certification record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider board certification record.',
    CONSTRAINT pk_board_certification PRIMARY KEY(`board_certification_id`)
) COMMENT 'Board certifications';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`education_training` (
    `education_training_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider education training record.',
    `completion_date` DATE COMMENT 'Timestamp capturing the completion date associated with the provider education training record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider education training record.',
    `degree` STRING COMMENT 'The degree of the provider education training record.',
    `institution_name` STRING COMMENT 'The institution name of the provider education training record.',
    `program_type` STRING COMMENT 'The program type value classifying the provider education training record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the provider education training record.',
    `education_training_status` STRING COMMENT 'The education training status value classifying the provider education training record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider education training record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider education training record.',
    CONSTRAINT pk_education_training PRIMARY KEY(`education_training_id`)
) COMMENT 'Education and training history';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`reappointment` (
    `reappointment_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider reappointment record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider reappointment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider reappointment record.',
    `cycle` STRING COMMENT 'The cycle of the provider reappointment record.',
    `decision_date` DATE COMMENT 'Timestamp capturing the decision date associated with the provider reappointment record.',
    `due_date` DATE COMMENT 'Timestamp capturing the due date associated with the provider reappointment record.',
    `reappointment_status` STRING COMMENT 'The reappointment status value classifying the provider reappointment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider reappointment record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider reappointment record.',
    CONSTRAINT pk_reappointment PRIMARY KEY(`reappointment_id`)
) COMMENT 'Reappointment cycles';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` (
    `peer_reference_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider peer reference record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider peer reference record.',
    `received_date` DATE COMMENT 'Timestamp capturing the received date associated with the provider peer reference record.',
    `referee_email` STRING COMMENT 'The referee email of the provider peer reference record.',
    `referee_name` STRING COMMENT 'The referee name of the provider peer reference record.',
    `reference_status` STRING COMMENT 'The reference status value classifying the provider peer reference record.',
    `request_date` DATE COMMENT 'Timestamp capturing the request date associated with the provider peer reference record.',
    `peer_reference_status` STRING COMMENT 'The peer reference status value classifying the provider peer reference record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider peer reference record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider peer reference record.',
    CONSTRAINT pk_peer_reference PRIMARY KEY(`peer_reference_id`)
) COMMENT 'Peer references';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` (
    `cme_activity_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider cme activity record.',
    `activity_date` DATE COMMENT 'Timestamp capturing the activity date associated with the provider cme activity record.',
    `activity_name` STRING COMMENT 'The activity name of the provider cme activity record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider cme activity record.',
    `credit_hours` DECIMAL(18,2) COMMENT 'The credit hours of the provider cme activity record.',
    `provider_organization` STRING COMMENT 'The provider organization of the provider cme activity record.',
    `cme_activity_status` STRING COMMENT 'The cme activity status value classifying the provider cme activity record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider cme activity record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider cme activity record.',
    CONSTRAINT pk_cme_activity PRIMARY KEY(`cme_activity_id`)
) COMMENT 'CME activities';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` (
    `telehealth_authorization_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider telehealth authorization record.',
    `authorization_status` STRING COMMENT 'The authorization status value classifying the provider telehealth authorization record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider telehealth authorization record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider telehealth authorization record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the provider telehealth authorization record.',
    `state_code` STRING COMMENT 'The state code value classifying the provider telehealth authorization record.',
    `telehealth_authorization_status` STRING COMMENT 'The telehealth authorization status value classifying the provider telehealth authorization record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider telehealth authorization record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider telehealth authorization record.',
    CONSTRAINT pk_telehealth_authorization PRIMARY KEY(`telehealth_authorization_id`)
) COMMENT 'Telehealth authorizations';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` (
    `taxonomy_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider taxonomy record.',
    `taxonomy_code` STRING COMMENT 'The taxonomy code value classifying the provider taxonomy record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider taxonomy record.',
    `taxonomy_description` STRING COMMENT 'The taxonomy description of the provider taxonomy record.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating the is primary status of the provider taxonomy record.',
    `taxonomy_status` STRING COMMENT 'The taxonomy status value classifying the provider taxonomy record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider taxonomy record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider taxonomy record.',
    CONSTRAINT pk_taxonomy PRIMARY KEY(`taxonomy_id`)
) COMMENT 'NUCC taxonomy codes';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`affiliation_history` (
    `affiliation_history_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider affiliation history record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider affiliation history record.',
    `affiliation_type` STRING COMMENT 'The affiliation type value classifying the provider affiliation history record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider affiliation history record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the provider affiliation history record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the provider affiliation history record.',
    `affiliation_history_status` STRING COMMENT 'The affiliation history status value classifying the provider affiliation history record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider affiliation history record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider affiliation history record.',
    CONSTRAINT pk_affiliation_history PRIMARY KEY(`affiliation_history_id`)
) COMMENT 'Provider affiliation history';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` (
    `study_team_member_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider study team member record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the provider study team member record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider study team member record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the provider study team member record.',
    `role` STRING COMMENT 'The role of the provider study team member record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the provider study team member record.',
    `study_team_member_status` STRING COMMENT 'The study team member status value classifying the provider study team member record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider study team member record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider study team member record.',
    CONSTRAINT pk_study_team_member PRIMARY KEY(`study_team_member_id`)
) COMMENT 'Research study team members';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Unique identifier for the assignment assigned by employee within the provider assignment record.',
    `assignment_backup_clinician_id` BIGINT COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `assignment_clinician_id` BIGINT COMMENT 'Unique identifier for the assignment clinician within the provider assignment record.',
    `assignment_employee_id` BIGINT COMMENT 'Unique identifier for the assignment employee within the provider assignment record.',
    `assignment_supervising_clinician_id` BIGINT COMMENT 'Unique identifier for the assignment supervising clinician within the provider assignment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider assignment record.',
    `clinician_id` BIGINT COMMENT 'Added to expand thin product provider.assignment',
    `group_id` BIGINT COMMENT 'Unique identifier for the group within the provider assignment record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the provider assignment record.',
    `assignment_notes` STRING COMMENT 'The assignment notes of the provider assignment record.',
    `assignment_role` STRING COMMENT 'The assignment role of the provider assignment record.',
    `assignment_type` STRING COMMENT 'The assignment type value classifying the provider assignment record.',
    `call_schedule_flag` BOOLEAN COMMENT 'The call schedule flag of the provider assignment record.',
    `coverage_end_at` TIMESTAMP COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'The coverage percentage of the provider assignment record.',
    `coverage_scope` STRING COMMENT 'Added to expand thin product provider.assignment',
    `coverage_start_at` TIMESTAMP COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `coverage_type` STRING COMMENT 'The coverage type value classifying the provider assignment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider assignment record.',
    `department` STRING COMMENT 'The department of the provider assignment record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider assignment record.',
    `effort_percentage` DECIMAL(18,2) COMMENT 'The effort percentage of the provider assignment record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the provider assignment record.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The fte allocation of the provider assignment record.',
    `fte_percent` DECIMAL(18,2) COMMENT 'Added to expand thin product provider.assignment',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The fte percentage of the provider assignment record.',
    `is_primary_flag` BOOLEAN COMMENT 'Boolean flag indicating the is primary flag status of the provider assignment record.',
    `notes` STRING COMMENT 'Added to expand thin product provider.assignment',
    `on_call_flag` BOOLEAN COMMENT 'The on call flag of the provider assignment record.',
    `panel_size` STRING COMMENT 'The panel size of the provider assignment record.',
    `primary_assignment_flag` BOOLEAN COMMENT 'The primary assignment flag of the provider assignment record.',
    `primary_flag` BOOLEAN COMMENT 'Added to expand thin product provider.assignment',
    `priority_rank` STRING COMMENT 'The priority rank of the provider assignment record.',
    `reason` STRING COMMENT 'The reason of the provider assignment record.',
    `role` STRING COMMENT 'The role of the provider assignment record.',
    `scope_notes` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `service_line` STRING COMMENT 'Added to expand thin product provider.assignment',
    `shift_pattern` STRING COMMENT 'The shift pattern of the provider assignment record.',
    `shift_type` STRING COMMENT 'The shift type value classifying the provider assignment record.',
    `specialty_code` STRING COMMENT 'The specialty code value classifying the provider assignment record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the provider assignment record.',
    `assignment_status` STRING COMMENT 'Added to expand thin product provider.assignment',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the provider assignment record.',
    `termination_reason` STRING COMMENT 'The termination reason of the provider assignment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider assignment record.',
    `vibe_expanded_flag` BOOLEAN COMMENT 'The vibe expanded flag of the provider assignment record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the provider assignment record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider assignment record.',
    `weight` DECIMAL(18,2) COMMENT 'Added to expand thin product with domain-appropriate detail.',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'Provider assignments';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`affiliation` (
    `affiliation_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider affiliation record.',
    `group_id` BIGINT COMMENT 'Unique identifier for the group within the provider affiliation record.',
    `affiliation_status` STRING COMMENT 'The affiliation status value classifying the provider affiliation record.',
    `affiliation_type` STRING COMMENT 'The affiliation type value classifying the provider affiliation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider affiliation record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider affiliation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider affiliation record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider affiliation record.',
    CONSTRAINT pk_affiliation PRIMARY KEY(`affiliation_id`)
) COMMENT 'Provider affiliations';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`preference_card` (
    `preference_card_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider preference card record.',
    `card_status` STRING COMMENT 'The card status value classifying the provider preference card record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider preference card record.',
    `last_reviewed_date` DATE COMMENT 'Timestamp capturing the last reviewed date associated with the provider preference card record.',
    `procedure_name` STRING COMMENT 'The procedure name of the provider preference card record.',
    `preference_card_status` STRING COMMENT 'The preference card status value classifying the provider preference card record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider preference card record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider preference card record.',
    CONSTRAINT pk_preference_card PRIMARY KEY(`preference_card_id`)
) COMMENT 'Surgeon preference cards';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` (
    `survey_participation_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider survey participation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider survey participation record.',
    `participation_status` STRING COMMENT 'The participation status value classifying the provider survey participation record.',
    `response_date` DATE COMMENT 'Timestamp capturing the response date associated with the provider survey participation record.',
    `survey_participation_status` STRING COMMENT 'The survey participation status value classifying the provider survey participation record.',
    `survey_name` STRING COMMENT 'The survey name of the provider survey participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider survey participation record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider survey participation record.',
    CONSTRAINT pk_survey_participation PRIMARY KEY(`survey_participation_id`)
) COMMENT 'Provider survey participation';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`credentialing_file` (
    `credentialing_file_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider credentialing file record.',
    `credentialing_application_id` BIGINT COMMENT 'Unique identifier for the credentialing application within the provider credentialing file record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider credentialing file record.',
    `document_type` STRING COMMENT 'The document type value classifying the provider credentialing file record.',
    `file_status` STRING COMMENT 'The file status value classifying the provider credentialing file record.',
    `received_date` DATE COMMENT 'Timestamp capturing the received date associated with the provider credentialing file record.',
    `credentialing_file_status` STRING COMMENT 'The credentialing file status value classifying the provider credentialing file record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider credentialing file record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider credentialing file record.',
    CONSTRAINT pk_credentialing_file PRIMARY KEY(`credentialing_file_id`)
) COMMENT 'Credentialing file documents';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`committee` (
    `committee_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider committee record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the committee chair clinician within the provider committee record.',
    `committee_clinician_id` BIGINT COMMENT 'Unique identifier for the committee clinician within the provider committee record.',
    `committee_type` STRING COMMENT 'The committee type value classifying the provider committee record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider committee record.',
    `committee_name` STRING COMMENT 'The committee name of the provider committee record.',
    `scope` STRING COMMENT 'The scope of the provider committee record.',
    `committee_status` STRING COMMENT 'The committee status value classifying the provider committee record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider committee record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider committee record.',
    CONSTRAINT pk_committee PRIMARY KEY(`committee_id`)
) COMMENT 'SSOT resolved: defer to quality.committee as the single source of truth for this concept. This table is a domain-specific extension/reference.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` (
    `provider_payer_enrollment_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider provider payer enrollment record.',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the provider provider payer enrollment record.',
    `insurance_payer_enrollment_id` BIGINT COMMENT 'SSOT cross-reference to canonical insurance.insurance_payer_enrollment',
    `org_provider_id` BIGINT COMMENT 'Org provider',
    `payer_contract_id` BIGINT COMMENT 'Payer contract',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the provider provider payer enrollment record.',
    `provider_location_id` BIGINT COMMENT 'Provider location',
    `npi_registry_id` BIGINT COMMENT 'NPI registry',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the provider provider payer enrollment record.',
    `taxonomy_id` BIGINT COMMENT 'Unique identifier for the taxonomy within the provider provider payer enrollment record.',
    `application_submitted_date` DATE COMMENT 'Timestamp capturing the application submitted date associated with the provider provider payer enrollment record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the provider provider payer enrollment record.',
    `billing_npi` STRING COMMENT 'The billing npi of the provider provider payer enrollment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_expiration_date` DATE COMMENT 'Timestamp capturing the credentialing expiration date associated with the provider provider payer enrollment record.',
    `credentialing_status` STRING COMMENT 'The credentialing status value classifying the provider provider payer enrollment record.',
    `credentialing_tier` STRING COMMENT 'The credentialing tier of the provider provider payer enrollment record.',
    `dea_number` STRING COMMENT 'The dea number of the provider provider payer enrollment record.',
    `edi_submitter_code` STRING COMMENT 'The edi submitter code value classifying the provider provider payer enrollment record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider provider payer enrollment record.',
    `eft_enrolled` BOOLEAN COMMENT 'The eft enrolled of the provider provider payer enrollment record.',
    `enrollment_number` STRING COMMENT 'The enrollment number of the provider provider payer enrollment record.',
    `enrollment_scope` STRING COMMENT 'The enrollment scope of the provider provider payer enrollment record.',
    `enrollment_source` STRING COMMENT 'The enrollment source of the provider provider payer enrollment record.',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the provider provider payer enrollment record.',
    `enrollment_type` STRING COMMENT 'The enrollment type value classifying the provider provider payer enrollment record.',
    `group_npi` STRING COMMENT 'The group npi of the provider provider payer enrollment record.',
    `license_state` STRING COMMENT 'The license state of the provider provider payer enrollment record.',
    `medicaid_provider_number` STRING COMMENT 'The medicaid provider number of the provider provider payer enrollment record.',
    `network_status` STRING COMMENT 'The network status value classifying the provider provider payer enrollment record.',
    `notes` STRING COMMENT 'The notes of the provider provider payer enrollment record.',
    `oig_exclusion_check_date` DATE COMMENT 'Timestamp capturing the oig exclusion check date associated with the provider provider payer enrollment record.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'The oig exclusion checked of the provider provider payer enrollment record.',
    `pay_to_address_line1` STRING COMMENT 'The pay to address line1 of the provider provider payer enrollment record.',
    `payer_plan_name` STRING COMMENT 'The payer plan name of the provider provider payer enrollment record.',
    `payer_type` STRING COMMENT 'The payer type value classifying the provider provider payer enrollment record.',
    `provider_number` STRING COMMENT 'The provider number of the provider provider payer enrollment record.',
    `provider_type` STRING COMMENT 'The provider type value classifying the provider provider payer enrollment record.',
    `ptan` STRING COMMENT 'The ptan of the provider provider payer enrollment record.',
    `revalidation_due_date` DATE COMMENT 'Timestamp capturing the revalidation due date associated with the provider provider payer enrollment record.',
    `sam_exclusion_checked` BOOLEAN COMMENT 'The sam exclusion checked of the provider provider payer enrollment record.',
    `service_address_line1` STRING COMMENT 'The service address line1 of the provider provider payer enrollment record.',
    `service_city` STRING COMMENT 'The service city of the provider provider payer enrollment record.',
    `service_state` STRING COMMENT 'The service state of the provider provider payer enrollment record.',
    `service_zip_code` STRING COMMENT 'The service zip code value classifying the provider provider payer enrollment record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: insurance.insurance_payer_enrollment (duplicate reconciled to canonical)',
    `state_license_number` STRING COMMENT 'The state license number of the provider provider payer enrollment record.',
    `provider_payer_enrollment_status` STRING COMMENT 'The provider payer enrollment status value classifying the provider provider payer enrollment record.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the provider provider payer enrollment record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the provider provider payer enrollment record.',
    `termination_reason` STRING COMMENT 'The termination reason of the provider provider payer enrollment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider provider payer enrollment record.',
    CONSTRAINT pk_provider_payer_enrollment PRIMARY KEY(`provider_payer_enrollment_id`)
) COMMENT 'Provider enrollment with payers (Medicare, Medicaid, commercial plans)';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` (
    `provider_network_participation_id` BIGINT COMMENT 'Primary key',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider provider network participation record.',
    `insurance_network_participation2_id` BIGINT COMMENT 'Unique identifier for the network participation within the provider provider network participation record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the provider provider network participation record.',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network within the provider provider network participation record.',
    `consolidated_target` STRING COMMENT 'The consolidated target of the provider provider network participation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider provider network participation record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider provider network participation record.',
    `participant_type` STRING COMMENT 'participant_type=provider',
    `participation_status` STRING COMMENT 'The participation status value classifying the provider provider network participation record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: insurance.network_participation (consolidated network_participation participant_type=provider)',
    `ssot_consolidation_note` STRING COMMENT 'The ssot consolidation note of the provider provider network participation record.',
    `provider_network_participation_status` STRING COMMENT 'The provider network participation status value classifying the provider provider network participation record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the provider provider network participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider provider network participation record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider provider network participation record.',
    CONSTRAINT pk_provider_network_participation PRIMARY KEY(`provider_network_participation_id`)
) COMMENT 'DEPRECATED - consolidate into insurance.network_participation (participant_type=provider). Retained for backward compatibility. Consolidated into insurance.network_participation (participant_type=provider).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`provider_location` (
    `provider_location_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider provider location record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider provider location record.',
    `pharmacy_location_id` BIGINT COMMENT 'SSOT cross-reference to canonical pharmacy.pharmacy_location',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the provider location specialty within the provider provider location record.',
    `provider_specialty_id` BIGINT COMMENT 'Unique identifier for the provider specialty within the provider provider location record.',
    `absorbed_location_specialty_flag` BOOLEAN COMMENT 'The absorbed location specialty flag of the provider provider location record.',
    `accepts_new_patients` BOOLEAN COMMENT 'The accepts new patients of the provider provider location record.',
    `address_line1` STRING COMMENT 'The address line1 of the provider provider location record.',
    `city` STRING COMMENT 'The city of the provider provider location record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider provider location record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider provider location record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the provider provider location record.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating the is primary status of the provider provider location record.',
    `is_primary_specialty` BOOLEAN COMMENT 'Boolean flag indicating the is primary specialty status of the provider provider location record.',
    `location_name` STRING COMMENT 'The location name of the provider provider location record.',
    `location_phone` STRING COMMENT 'The location phone of the provider provider location record.',
    `location_scope` STRING COMMENT 'The location scope of the provider provider location record.',
    `location_specialty_description` STRING COMMENT 'The location specialty description of the provider provider location record.',
    `location_status` STRING COMMENT 'The location status value classifying the provider provider location record.',
    `location_type` STRING COMMENT 'The location type value classifying the provider provider location record.',
    `mvm_ecm_reconciled_flag` BOOLEAN COMMENT 'The mvm ecm reconciled flag of the provider provider location record.',
    `mvm_source_names` STRING COMMENT 'provider.location and provider.location_specialty mapped to provider.provider_location',
    `phone` STRING COMMENT 'The phone of the provider provider location record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: pharmacy.pharmacy_location (duplicate reconciled to canonical)',
    `state` STRING COMMENT 'The state of the provider provider location record.',
    `provider_location_status` STRING COMMENT 'The provider location status value classifying the provider provider location record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider provider location record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the provider provider location record.',
    `zip_code` STRING COMMENT 'The zip code value classifying the provider provider location record.',
    CONSTRAINT pk_provider_location PRIMARY KEY(`provider_location_id`)
) COMMENT 'Provider practice locations';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`provider`.`location_specialty` (
    `location_specialty_id` BIGINT COMMENT 'Unique identifier for the location specialty within the provider location specialty record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the provider location specialty record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the provider location specialty record.',
    `provider_location_id` BIGINT COMMENT 'Unique identifier for the provider location within the provider location specialty record.',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the provider location specialty record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the provider location specialty record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the provider location specialty record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the provider location specialty record.',
    `is_primary_specialty` BOOLEAN COMMENT 'Boolean flag indicating the is primary specialty status of the provider location specialty record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the provider location specialty record.',
    CONSTRAINT pk_location_specialty PRIMARY KEY(`location_specialty_id`)
) COMMENT 'Represents location specialty records in the provider domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_committee_id` FOREIGN KEY (`committee_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`committee`(`committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_privileging_clinician_id` FOREIGN KEY (`privileging_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_committee_id` FOREIGN KEY (`committee_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`committee`(`committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_provider_payer_enrollment_id` FOREIGN KEY (`provider_payer_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment`(`provider_payer_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_primary_group_clinician_id` FOREIGN KEY (`primary_group_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_credentialing_application_id` FOREIGN KEY (`credentialing_application_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`credentialing_application`(`credentialing_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_credentialing_file_id` FOREIGN KEY (`credentialing_file_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`credentialing_file`(`credentialing_file_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ADD CONSTRAINT `fk_provider_npdb_query_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ADD CONSTRAINT `fk_provider_npdb_query_credentialing_application_id` FOREIGN KEY (`credentialing_application_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`credentialing_application`(`credentialing_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ADD CONSTRAINT `fk_provider_npdb_query_original_query_npdb_query_id` FOREIGN KEY (`original_query_npdb_query_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`npdb_query`(`npdb_query_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ADD CONSTRAINT `fk_provider_npdb_query_reappointment_id` FOREIGN KEY (`reappointment_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`reappointment`(`reappointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` ADD CONSTRAINT `fk_provider_education_training_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ADD CONSTRAINT `fk_provider_peer_reference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` ADD CONSTRAINT `fk_provider_cme_activity_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ADD CONSTRAINT `fk_provider_telehealth_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ADD CONSTRAINT `fk_provider_taxonomy_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation_history` ADD CONSTRAINT `fk_provider_affiliation_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ADD CONSTRAINT `fk_provider_study_team_member_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_assignment_backup_clinician_id` FOREIGN KEY (`assignment_backup_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_assignment_clinician_id` FOREIGN KEY (`assignment_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_assignment_supervising_clinician_id` FOREIGN KEY (`assignment_supervising_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ADD CONSTRAINT `fk_provider_preference_card_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` ADD CONSTRAINT `fk_provider_survey_participation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_file` ADD CONSTRAINT `fk_provider_credentialing_file_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_file` ADD CONSTRAINT `fk_provider_credentialing_file_credentialing_application_id` FOREIGN KEY (`credentialing_application_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`credentialing_application`(`credentialing_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ADD CONSTRAINT `fk_provider_committee_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ADD CONSTRAINT `fk_provider_committee_committee_clinician_id` FOREIGN KEY (`committee_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_provider_location_id` FOREIGN KEY (`provider_location_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`provider_location`(`provider_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_provider_specialty_id` FOREIGN KEY (`provider_specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`location_specialty` ADD CONSTRAINT `fk_provider_location_specialty_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`location_specialty` ADD CONSTRAINT `fk_provider_location_specialty_provider_location_id` FOREIGN KEY (`provider_location_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`provider_location`(`provider_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`location_specialty` ADD CONSTRAINT `fk_provider_location_specialty_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`provider` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`provider` SET TAGS ('pii_domain' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` SET TAGS ('pii_subdomain' = 'provider_registry');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` SET TAGS ('pii_subdomain' = 'clinical_staff');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `clinician_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `caqh_provider_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `date_of_birth` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `dea_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `fellowship_program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `gender` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `gender` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `internship_program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `malpractice_policy_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_degree` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_degree` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_graduation_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_graduation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `medical_school_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `middle_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `name_suffix` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `residency_program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `state_license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ALTER COLUMN `work_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` SET TAGS ('pii_subdomain' = 'provider_registry');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` SET TAGS ('pii_subdomain' = 'organizational');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `org_provider_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `address_line2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `county` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `fax` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `legal_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `medicaid_provider_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `organizational_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_expiration_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `state_license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ALTER COLUMN `zip_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` SET TAGS ('pii_subdomain' = 'provider_registry');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` SET TAGS ('pii_entity' = 'reference');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` SET TAGS ('pii_subdomain' = 'clinical');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `abms_board_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `board_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `npi_taxonomy_eligible` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `credential_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `certifying_board_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `certifying_board_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `certifying_board_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `certifying_board_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `certifying_board_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `certifying_board_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `cme_accrediting_organization` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `credential_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_business_activity_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `dea_schedule_authorizations` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_authority_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ALTER COLUMN `issuing_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privileging_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `icd10_procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ALTER COLUMN `privilege_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `credentialing_application_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `caqh_provider_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `dea_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `dea_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `dea_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `dea_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `dea_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `dea_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `dea_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `dea_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `malpractice_insurer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `malpractice_insurer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `malpractice_insurer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `malpractice_insurer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `malpractice_insurer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `malpractice_insurer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `malpractice_policy_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` SET TAGS ('pii_subdomain' = 'network_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` SET TAGS ('pii_subdomain' = 'network');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `network_affiliation_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `gender_served` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `panel_capacity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `service_area_zip_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` SET TAGS ('pii_subdomain' = 'provider_registry');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` SET TAGS ('pii_subdomain' = 'organizational');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `admin_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_entity_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `billing_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `mips_group_reporting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `group_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_fax` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `primary_service_zip` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ALTER COLUMN `telehealth_capable` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` SET TAGS ('pii_subdomain' = 'provider_registry');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` SET TAGS ('pii_subdomain' = 'organizational');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `group_membership_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ALTER COLUMN `verified_by` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `malpractice_coverage_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `carrier_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `carrier_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `carrier_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `carrier_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `carrier_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `carrier_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `carrier_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `coverage_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `coverage_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `coverage_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `coverage_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `coverage_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `coverage_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `insurer_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `policy_holder_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `policy_holder_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `policy_holder_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `policy_holder_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `policy_holder_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `policy_holder_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `policy_holder_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `policy_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ALTER COLUMN `verified_by` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `npdb_query_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `cms_participating_facility_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `cms_participating_facility_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `cms_participating_facility_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `cms_participating_facility_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `cms_participating_facility_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `cms_participating_facility_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `cms_participating_facility_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_disenrollment_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_disenrollment_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_disenrollment_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_disenrollment_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_disenrollment_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_disenrollment_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_disenrollment_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `continuous_query_enrollment_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_date_of_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_date_of_birth` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_date_of_birth` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_dea_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_dea_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_dea_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_dea_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_dea_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_dea_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_dea_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_practitioner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_practitioner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_practitioner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_practitioner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_practitioner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_practitioner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_practitioner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_ssn_last4` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_ssn_last4` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_ssn_last4` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_ssn_last4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_ssn_last4` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_ssn_last4` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_ssn_last4` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_ssn_last4` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_state_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_state_license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_state_license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_state_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_state_license_number` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_state_license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_state_license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `queried_state_license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `querying_organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `querying_organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `querying_organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `querying_organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `querying_organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `querying_organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ALTER COLUMN `submitted_by_user` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` SET TAGS ('pii_subdomain' = 'compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `sanction_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_schedule` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_certification_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`board_certification` ALTER COLUMN `board_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` ALTER COLUMN `education_training_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` ALTER COLUMN `institution_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` ALTER COLUMN `institution_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` ALTER COLUMN `institution_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` ALTER COLUMN `institution_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` ALTER COLUMN `institution_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`education_training` ALTER COLUMN `institution_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`reappointment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`reappointment` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`reappointment` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`reappointment` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`reappointment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`reappointment` ALTER COLUMN `reappointment_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `peer_reference_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`peer_reference` ALTER COLUMN `referee_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` ALTER COLUMN `cme_activity_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`cme_activity` ALTER COLUMN `activity_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` SET TAGS ('pii_subdomain' = 'network_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `state_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `state_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`telehealth_authorization` ALTER COLUMN `telehealth_authorization_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` SET TAGS ('pii_subdomain' = 'provider_registry');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` SET TAGS ('pii_entity' = 'reference');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` SET TAGS ('pii_subdomain' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ALTER COLUMN `taxonomy_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation_history` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation_history` SET TAGS ('pii_subdomain' = 'network_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation_history` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation_history` SET TAGS ('pii_subdomain' = 'organizational');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation_history` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation_history` ALTER COLUMN `affiliation_history_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` SET TAGS ('pii_subdomain' = 'practice_engagement');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` SET TAGS ('pii_association_edges' = 'provider.clinician,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` SET TAGS ('pii_entity' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` SET TAGS ('pii_subdomain' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ALTER COLUMN `study_team_member_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` SET TAGS ('pii_subdomain' = 'practice_engagement');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` SET TAGS ('pii_association_edges' = 'provider.clinician,workforce.position');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` SET TAGS ('pii_subdomain' = 'scheduling');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ALTER COLUMN `assignment_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ALTER COLUMN `assignment_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation` SET TAGS ('pii_subdomain' = 'network_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation` SET TAGS ('pii_association_edges' = 'provider.clinician,workforce.org_unit');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation` SET TAGS ('pii_subdomain' = 'organizational');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation` ALTER COLUMN `affiliation_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` SET TAGS ('pii_subdomain' = 'practice_engagement');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` SET TAGS ('pii_association_edges' = 'provider.clinician,supply.material_master');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` SET TAGS ('pii_subdomain' = 'clinical');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `preference_card_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `preference_card_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `card_status` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `procedure_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `procedure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `procedure_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `procedure_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `procedure_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `procedure_name` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `procedure_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `procedure_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`preference_card` ALTER COLUMN `procedure_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` SET TAGS ('pii_subdomain' = 'practice_engagement');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` SET TAGS ('pii_association_edges' = 'provider.clinician,quality.accreditation_survey');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` SET TAGS ('pii_subdomain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` ALTER COLUMN `survey_participation_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` ALTER COLUMN `survey_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` ALTER COLUMN `survey_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` ALTER COLUMN `survey_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` ALTER COLUMN `survey_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` ALTER COLUMN `survey_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` ALTER COLUMN `survey_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`survey_participation` ALTER COLUMN `survey_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_file` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_file` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_file` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_file` SET TAGS ('pii_subdomain' = 'credentialing');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_file` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_file` ALTER COLUMN `credentialing_file_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_subdomain' = 'governance');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_ssot_canonical' = 'quality.committee');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_ssot_pair' = 'quality.committee');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_ssot_reference' = 'quality.committee');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_duplicate_pair' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` SET TAGS ('pii_ssot_primary' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ALTER COLUMN `committee_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ALTER COLUMN `committee_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ALTER COLUMN `committee_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ALTER COLUMN `committee_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ALTER COLUMN `committee_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ALTER COLUMN `committee_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ALTER COLUMN `committee_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ALTER COLUMN `scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_subdomain' = 'network_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_subdomain' = 'enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_ssot_pair' = 'insurance.insurance_payer_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_ssot_duplicate_of' = 'insurance.insurance_payer_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_ssot_canonical' = 'insurance.insurance_payer_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` SET TAGS ('pii_duplicate_of' = 'insurance.insurance_payer_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `provider_payer_enrollment_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `billing_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `billing_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `billing_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `billing_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `billing_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `billing_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `billing_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `billing_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `dea_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `dea_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `dea_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `dea_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `dea_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `dea_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `dea_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `enrollment_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `group_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `group_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `group_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `group_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `group_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `group_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `group_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `group_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `medicaid_provider_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `pay_to_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `pay_to_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `pay_to_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `pay_to_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `pay_to_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `pay_to_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `payer_plan_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `payer_plan_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `payer_plan_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `payer_plan_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `payer_plan_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `payer_plan_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `ptan` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_zip_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_zip_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_zip_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_zip_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `service_zip_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `state_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `state_license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `state_license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `state_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `state_license_number` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `state_license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `state_license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `state_license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_subdomain' = 'network_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_subdomain' = 'network');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_ssot_canonical' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_ssot_consolidated_into' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_consolidated_into' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_ssot' = 'deprecated');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_ssot_target' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` ALTER COLUMN `provider_network_participation_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` ALTER COLUMN `provider_network_participation_id` SET TAGS ('pii_ssot_role' = 'owner');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_subdomain' = 'provider_registry');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_entity' = 'provider');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_subdomain' = 'organizational');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_ssot_canonical' = 'facility.care_site');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_ssot_note' = 'Both should FK to canonical facility anchor');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_ssot_pair' = 'pharmacy.pharmacy_location');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_ssot_duplicate_of' = 'pharmacy.pharmacy_location');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_duplicate_of' = 'pharmacy.pharmacy_location');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_mvm_alias' = 'provider.location');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_mvm_ecm_reconciled' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` SET TAGS ('pii_ecm_superset' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `provider_location_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `location_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_business_glossary_term' = 'provider.location;provider.location_specialty');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `zip_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `zip_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `zip_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `zip_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ALTER COLUMN `zip_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`location_specialty` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`provider`.`location_specialty` SET TAGS ('pii_subdomain' = 'provider_registry');
