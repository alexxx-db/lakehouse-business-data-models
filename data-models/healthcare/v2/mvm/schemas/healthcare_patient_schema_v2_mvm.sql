-- Schema for Domain: patient | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`patient` COMMENT 'Master data for all individuals receiving healthcare services. SSOT for patient identity, demographics, MRN (Medical Record Number), MPI (Master Patient Index), insurance coverage, emergency contacts, consent records, SDOH (Social Determinants of Health), patient preferences, and PHI-protected identity information. Referenced by every clinical and financial domain via patient_id FK.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` (
    `mpi_record_id` BIGINT COMMENT 'Unique surrogate primary key for the MPI golden record in the enterprise lakehouse. Serves as the enterprise-wide patient_id referenced by every clinical and financial domain. Role: MASTER_PARTY (enterprise identity anchor).',
    `surviving_mpi_record_id` BIGINT COMMENT 'For non-surviving (merged/deprecated) MPI records, the mpi_record_id of the surviving golden record that absorbed this identity. Null for active golden records. Supports merge history traversal and MRN crosswalk resolution.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this MPI golden record was first created in the enterprise MPI system. Serves as the authoritative record creation audit timestamp. Required for HIPAA audit trail compliance.',
    `date_of_birth` DATE COMMENT 'The patients date of birth in yyyy-MM-dd format. Core PHI identifier used for identity matching, age-based clinical decision support, eligibility verification, and regulatory reporting. One of the 18 HIPAA PHI identifiers.',
    `date_of_death` DATE COMMENT 'The date of the patients death in yyyy-MM-dd format. Populated when deceased_flag is True. Sourced from EHR ADT, state vital records, or Social Security Death Index. Used for mortality reporting, quality measures, and population health analytics.',
    `deceased_flag` BOOLEAN COMMENT 'Indicates whether the patient is deceased. True = patient is deceased. Used to suppress deceased patients from active care management workflows, population health outreach, and appointment scheduling.',
    `deployment_guide_section` STRING COMMENT 'The deployment guide section of the patient mpi record record.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` STRING COMMENT 'Marker for digital health integration',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `enterprise_patient_number` STRING COMMENT 'The enterprise-wide, human-readable unique patient identifier assigned by the MPI system. Serves as the SSOT identity key across all facilities, EHR systems, and HIE platforms. Distinct from facility-level MRNs.. Valid values are `^EP-[0-9]{10}$`',
    `ethnicity_code` STRING COMMENT 'The patients self-reported ethnicity using OMB codes (2135-2=Hispanic or Latino, 2186-5=Not Hispanic or Latino, UNK=Unknown/Not Reported). Collected per CMS health equity and USCDI requirements.. Valid values are `2135-2|2186-5|UNK`',
    `first_registration_date` DATE COMMENT 'The date the patient was first registered in the enterprise MPI system. Represents the earliest known encounter with the healthcare organization. Used for longitudinal care analytics and patient tenure reporting.',
    `gender_identity` STRING COMMENT 'The patients self-reported gender identity. Collected per CMS and ONC requirements for health equity reporting and SDOH documentation. Distinct from sex at birth. [ENUM-REF-CANDIDATE: male|female|transgender_male|transgender_female|nonbinary|genderqueer|other|unknown — promote to reference product]',
    `hie_patient_number` STRING COMMENT 'The patient identifier assigned by the regional or national Health Information Exchange (HIE) network. Used for cross-organizational patient matching and care coordination. Supports CMS Interoperability and Patient Access Rule compliance.',
    `identity_confidence_tier` STRING COMMENT 'A tiered classification of the overall identity confidence for this MPI golden record based on the number and quality of verified identity traits (e.g., government ID verified, biometric match, multi-source corroboration). high=strong multi-source verification; low=minimal corroboration; unverified=no identity proofing completed.. Valid values are `high|medium|low|unverified`',
    `identity_resolution_status` STRING COMMENT 'Current identity resolution status of this MPI record. golden = authoritative enterprise identity; candidate = awaiting resolution; overlay = erroneous merge detected; duplicate = confirmed duplicate pending merge; merged = non-surviving record post-merge; unmerged = previously merged record that was separated; pending_review = flagged for analyst review. Core MPI lifecycle field. [ENUM-REF-CANDIDATE: golden|candidate|overlay|duplicate|merged|unmerged|pending_review — 7 candidates stripped; promote to reference product]',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether the patient requires a professional interpreter for clinical encounters. True = interpreter services must be arranged. Supports compliance with Section 1557 of the ACA (language access) and CMS CLAS Standards.',
    `is_duplicate_flag` BOOLEAN COMMENT 'Indicates whether this MPI record has been identified as a duplicate of another enterprise patient identity. True = confirmed or suspected duplicate. Used to trigger merge workflow in the MPI tool.',
    `is_overlay_flag` BOOLEAN COMMENT 'Indicates whether this MPI record has been identified as an overlay — a patient safety event where two distinct patients records were erroneously merged. Overlay detection is a critical patient safety and HIM compliance function. True = overlay detected.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to this MPI golden record, including demographic changes, merge/unmerge events, or status changes. Used for change data capture, HIE synchronization, and audit compliance.',
    `last_verified_date` DATE COMMENT 'The most recent date on which the patients identity was actively verified against a government-issued ID or biometric at a point of service. Used to assess identity confidence staleness and trigger re-verification workflows.',
    `legal_first_name` STRING COMMENT 'The patients legal given/first name as recorded in the MPI golden record. PHI under HIPAA. Used for identity verification and clinical documentation.',
    `legal_last_name` STRING COMMENT 'The patients legal family/surname as recorded in the MPI golden record. Used for identity matching, clinical documentation, and regulatory reporting. PHI under HIPAA.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'The probabilistic confidence score (0.0000–1.0000) produced by the identity matching algorithm indicating the likelihood that two records represent the same individual. Scores above the enterprise threshold trigger automatic merge; scores in the review band require analyst adjudication.',
    `medicaid_number` STRING COMMENT 'The state-assigned Medicaid recipient identifier for patients enrolled in Medicaid. Format varies by state. Used for Medicaid claims submission, eligibility verification, and CMS reporting.',
    `medicare_beneficiary_number` STRING COMMENT 'The CMS-assigned Medicare Beneficiary Identifier (MBI) for patients enrolled in Medicare. Replaced the Social Security Number-based Health Insurance Claim Number (HICN). Required for Medicare claims submission and CMS quality reporting.. Valid values are `^[1-9][AC-HJ-NP-RT-Y][AC-HJ-NP-RT-Y0-9][0-9][AC-HJ-NP-RT-Y][AC-HJ-NP-RT-Y0-9][0-9][AC-HJ-NP-RT-Y]{2}[0-9]{2}$`',
    `merge_algorithm` STRING COMMENT 'The name or version of the probabilistic or deterministic matching algorithm used to identify this record as a merge candidate (e.g., Verato_v3.2, Epic_MPI_Deterministic, Rhapsody_Probabilistic_v2). Supports algorithm governance and audit.',
    `merge_reason` STRING COMMENT 'The documented reason or trigger for the merge of this MPI record into a surviving golden record. Supports audit trail and quality improvement for identity resolution processes.. Valid values are `algorithmic_match|manual_review|adt_event|hie_linkage|patient_request|clerical_correction`',
    `merge_timestamp` TIMESTAMP COMMENT 'The date and time when this MPI record was merged into a surviving golden record. Null if the record has never been merged. Part of the merge/unmerge audit trail required for HIM compliance.',
    `middle_name` STRING COMMENT 'The patients middle name or middle initial as recorded in the MPI golden record. Used to disambiguate patients with identical first and last names during identity resolution.',
    `mpi_record_status` STRING COMMENT 'The current lifecycle status of this MPI golden record. active=current enterprise identity in use; inactive=no recent activity; merged=non-surviving record post-merge; deceased=patient deceased; test=test/training record; blocked=access restricted pending review.. Valid values are `active|inactive|merged|deceased|test|blocked`',
    `mrn` STRING COMMENT 'The primary facility-level Medical Record Number (MRN) assigned to the patient at the enterprise anchor facility. Additional facility MRNs are tracked in the MRN crosswalk. Sourced from Epic EHR or Cerner Millennium ADT.',
    `name_suffix` STRING COMMENT 'Generational or professional suffix appended to the patients legal name (e.g., Jr., Sr., III). Used in identity matching to reduce false-positive duplicate detection.. Valid values are `Jr.|Sr.|II|III|IV|Esq.`',
    `national_health_id_type` STRING COMMENT 'The type or issuing authority of the national health identifier stored in national_health_id (e.g., NHS_NUMBER=UK NHS Number, EHIC=European Health Insurance Card, MEDICARE_BENE_ID=CMS Medicare Beneficiary Identifier, MEDICAID_ID=State Medicaid ID).. Valid values are `NHS_NUMBER|EHIC|MEDICAID_ID|MEDICARE_BENE_ID|OTHER`',
    `national_health_number` STRING COMMENT 'National health identifier assigned by a government health authority (e.g., NHS Number for UK patients, EHIC number for EU patients, national health ID for international patients). Supports international patient identity standards and cross-border care coordination.',
    `npi_crosswalk_count` STRING COMMENT 'The number of distinct facility-level MRN crosswalk entries linked to this MPI golden record. Indicates the breadth of the patients care history across the enterprise. Used for MPI quality monitoring and duplicate detection analytics.',
    `patient_class` STRING COMMENT 'The primary classification of the patient based on their predominant care setting and service utilization pattern. Drives billing, regulatory reporting, and population health segmentation. Sourced from ADT systems (Epic/Cerner). [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|observation|recurring|newborn|deceased — 7 candidates stripped; promote to reference product]',
    `preferred_name` STRING COMMENT 'The name the patient prefers to be called, which may differ from their legal name. Supports patient-centered care and CAHPS patient experience requirements.',
    `primary_language_code` STRING COMMENT 'The ISO 639-1/639-2 language code representing the patients primary spoken language (e.g., en for English, es for Spanish, zh for Chinese). Used to trigger interpreter services, translated materials, and CLAS Standards compliance.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `race_code` STRING COMMENT 'The patients self-reported race using OMB/CDC race category codes. Collected per CMS health equity and USCDI requirements. Used for HEDIS disparity reporting, population health stratification, and health equity analytics. [ENUM-REF-CANDIDATE: 1002-5|2028-9|2054-5|2076-8|2106-3|2131-1|UNK — promote to reference product]',
    `restricted_access_flag` BOOLEAN COMMENT 'Indicates whether access to this patients MPI record and associated PHI is restricted beyond standard role-based access controls. True = restricted access enforced. Applies to sensitive populations (e.g., behavioral health, HIV, substance abuse) per 42 CFR Part 2 and state law.',
    `sex_at_birth` STRING COMMENT 'The patients biological sex recorded at birth (M=Male, F=Female, X=Intersex/Other, U=Unknown). Used for clinical decision support, lab reference ranges, and CMS/HEDIS quality reporting. Distinct from gender identity.. Valid values are `M|F|X|U`',
    `source_system_code` STRING COMMENT 'The originating EHR or operational system that contributed the identity record that seeded this MPI golden record (e.g., EPIC=Epic EHR, CERNER=Cerner Millennium, MEDITECH=MEDITECH Expanse, HIE=Health Information Exchange). Supports data lineage and source system reconciliation. [ENUM-REF-CANDIDATE: EPIC|CERNER|MEDITECH|MANUAL|HIE|SALESFORCE_HC|EXTERNAL — 7 candidates stripped; promote to reference product]',
    `ssn_last4` STRING COMMENT 'The last four digits of the patients Social Security Number (SSN). Stored in truncated form to support identity matching while minimizing PHI/PII exposure. Full SSN must not be stored in the silver layer per HIPAA minimum necessary standard.. Valid values are `^[0-9]{4}$`',
    `unmerge_reason` STRING COMMENT 'The documented reason for reversing a prior merge action on this MPI record. Supports patient safety investigation and HIM quality improvement workflows.. Valid values are `overlay_correction|erroneous_merge|patient_dispute|clerical_error|hie_discrepancy`',
    `unmerge_timestamp` TIMESTAMP COMMENT 'The date and time when a previously merged MPI record was separated (unmerged) due to an overlay correction or erroneous merge reversal. Null if the record has never been unmerged. Critical patient safety audit field.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the timestamp for the mpi record record was last updated.',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_ai_added_flag` BOOLEAN COMMENT 'Marker added by VIBE mutator',
    `vibe_batch_marker` STRING COMMENT 'Batch marker used to tag records processed by the vibe batch pipeline for the mpi_record entity.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient mpi record record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient mpi record record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient mpi record record.',
    `vip_flag` BOOLEAN COMMENT 'Indicates whether the patient has been designated as a VIP (e.g., celebrity, executive, employee, or high-profile individual) requiring enhanced privacy protections and restricted access controls. True = VIP designation active. Triggers break-the-glass audit logging.',
    CONSTRAINT pk_mpi_record PRIMARY KEY(`mpi_record_id`)
) COMMENT 'Enterprise Single Source of Truth (SSOT) for patient identity across multi-facility health systems. The Master Patient Index record serves as the authoritative golden record for patient identity resolution, linking all facility-specific MRNs, demographic data, and identity attributes into a unified enterprise patient identity. Supports EMPI matching algorithms, identity confidence scoring, merge/unmerge workflows, and cross-facility patient linking for integrated delivery networks (IDNs) and health information exchanges (HIEs).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`demographics` (
    `demographics_id` BIGINT COMMENT 'Unique surrogate identifier for the patient demographics record. Primary key for the demographics data product within the patient domain Silver layer.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the master patient record. Links demographics to the canonical patient identity in the Master Patient Index (MPI).',
    `advance_directive_on_file` BOOLEAN COMMENT 'Indicates whether the patient has an advance directive (e.g., living will, healthcare proxy, POLST) on file with the health system. Supports EMTALA-compliant emergency care and Joint Commission patient rights standards.',
    `birth_date` DATE COMMENT 'Patients date of birth in ISO 8601 format (yyyy-MM-dd). Core PHI element used for age calculation, eligibility verification, clinical decision support, and identity matching. Required by CMS and HIPAA.',
    `birth_time` TIMESTAMP COMMENT 'Exact timestamp of the patients birth. Clinically significant for neonatal records, multiple births, and vital statistics reporting to state health departments.',
    `census_tract` STRING COMMENT 'US Census Bureau census tract code derived from the patients home address via geocoding. Enables Social Determinants of Health (SDOH) stratification, Area Deprivation Index (ADI) linkage, and population health analytics.. Valid values are `^[0-9]{4,6}(.[0-9]{2})?$`',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient demographics record was first created in the source EHR registration system. Supports audit trail, data lineage, and HIPAA access logging requirements.',
    `death_cause_code` STRING COMMENT 'ICD-10-CM code representing the underlying cause of death as recorded on the death certificate. Used for vital statistics reporting, mortality analytics, and population health research.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `death_certificate_number` STRING COMMENT 'State-issued death certificate reference number. Used to cross-reference vital statistics records and support legal and administrative processes following patient death.',
    `death_date` DATE COMMENT 'Date the patient was pronounced deceased (yyyy-MM-dd). Required for vital statistics reporting, care plan closure, and population health mortality analytics. Sourced from Epic ADT or state vital records.',
    `deceased_indicator` BOOLEAN COMMENT 'Indicates whether the patient is deceased. Triggers suppression of outreach communications, updates to active care plans, and vital statistics reporting workflows.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` STRING COMMENT 'Flag indicating integration with digital health domain',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `email_address` STRING COMMENT 'Patients primary email address for electronic communications including appointment reminders, patient portal access, and health education materials. PHI per HIPAA when combined with health information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `enterprise_mrn` STRING COMMENT 'Cross-facility enterprise-level MRN assigned by the Master Patient Index (MPI) to uniquely identify the patient across all facilities and care sites within the health system.',
    `ethnicity_code` STRING COMMENT 'Patients self-reported ethnicity using OMB/CDC ethnicity codes. Values: 2135-2=Hispanic or Latino, 2186-5=Not Hispanic or Latino, UNK=Unknown. Required for CMS demographic reporting and health equity analytics.. Valid values are `2135-2|2186-5|UNK`',
    `gender_identity` STRING COMMENT 'Patients self-identified gender, which may differ from sex assigned at birth. Supports inclusive care, patient experience, and CMS demographic data collection requirements. [ENUM-REF-CANDIDATE: male|female|transgender_male|transgender_female|nonbinary|genderqueer|other|unknown|prefer_not_to_disclose — promote to reference product]',
    `home_address_line1` STRING COMMENT 'Primary street address line for the patients home residence. Used for correspondence, population health outreach, SDOH census tract linkage, and vital statistics reporting.',
    `home_address_line2` STRING COMMENT 'Secondary address line for the patients home residence (apartment, suite, unit number). Supplements home_address_line1 for complete address resolution.',
    `home_city` STRING COMMENT 'City of the patients home residence address. Used for geographic analysis, population health stratification, and service area reporting.',
    `home_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the patients home residence (e.g., USA, CAN, MEX). Supports international patient management and cross-border care coordination.. Valid values are `^[A-Z]{3}$`',
    `home_postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the patients home residence. Used for geographic analysis, SDOH census tract linkage, population health outreach, and payer eligibility verification.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `home_state` STRING COMMENT 'Two-letter USPS state abbreviation for the patients home residence. Used for state-level regulatory reporting, vital statistics, and payer eligibility.. Valid values are `^[A-Z]{2}$`',
    `interpreter_required` BOOLEAN COMMENT 'Indicates whether the patient requires a professional interpreter for clinical encounters. Triggers interpreter service workflows in scheduling and ADT systems. Supports EMTALA and Title VI compliance.',
    `legal_first_name` STRING COMMENT 'Patients legal given name as recorded in the official registration. Used for identity verification, clinical documentation, and billing.',
    `legal_last_name` STRING COMMENT 'Patients legal family name (surname) as recorded in the official registration. Used for identity verification, billing, and legal documentation. Sourced from Epic ADT registration.',
    `mailing_address_line1` STRING COMMENT 'Primary street address line for the patients mailing address when different from home address. Used for correspondence, EOB delivery, and appointment reminders.',
    `mailing_address_same_as_home` BOOLEAN COMMENT 'Indicates whether the patients mailing address is identical to their home address. When True, mailing address fields are not separately stored. Simplifies address management in multi-address scenarios.',
    `mailing_city` STRING COMMENT 'City of the patients mailing address when different from home address.',
    `mailing_postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the patients mailing address when different from home address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `mailing_state` STRING COMMENT 'Two-letter USPS state abbreviation for the patients mailing address when different from home address.. Valid values are `^[A-Z]{2}$`',
    `marital_status` STRING COMMENT 'Patients current marital or domestic partnership status. Used in social history documentation, insurance coordination of benefits, and next-of-kin determination. Sourced from Epic ADT registration. [ENUM-REF-CANDIDATE: single|married|divorced|widowed|separated|domestic_partner|unknown — 7 candidates stripped; promote to reference product]',
    `middle_name` STRING COMMENT 'Patients middle name or middle initial as recorded in registration. Supports identity disambiguation in the MPI when first and last names are common.',
    `mrn` STRING COMMENT 'Facility-assigned Medical Record Number uniquely identifying the patient within the health system. Sourced from Epic EHR or Cerner Millennium registration module. Core PHI identifier per HIPAA.',
    `name_suffix` STRING COMMENT 'Generational or professional suffix appended to the patients legal name (e.g., Jr., Sr., II, III). Used for identity matching and legal documentation.. Valid values are `Jr.|Sr.|II|III|IV|Esq.`',
    `patient_portal_enrolled` BOOLEAN COMMENT 'Indicates whether the patient is enrolled in the health systems patient portal (e.g., MyChart in Epic). Supports patient engagement metrics, Meaningful Use/Promoting Interoperability reporting, and digital health outreach.',
    `preferred_language_code` STRING COMMENT 'Patients preferred spoken/written language for healthcare communications, expressed as an ISO 639-1 or 639-2 language code (e.g., en, es, zh). Drives interpreter services, patient education material selection, and EMTALA-compliant communication. Required by CMS and Title VI of the Civil Rights Act.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `preferred_name` STRING COMMENT 'Name the patient prefers to be called, which may differ from their legal name. Used in patient-facing communications, care team interactions, and patient experience initiatives. Supports LGBTQ+ inclusive care.',
    `primary_phone` STRING COMMENT 'Patients primary contact telephone number. Used for appointment reminders, care coordination, and emergency contact. Sourced from Epic ADT registration.. Valid values are `^+?[0-9-()s]{7,20}$`',
    `primary_phone_type` STRING COMMENT 'Classification of the patients primary phone number (home landline, mobile/cell, work). Determines eligibility for automated outreach under TCPA regulations.. Valid values are `home|mobile|work|other`',
    `pronouns` STRING COMMENT 'Patients preferred personal pronouns for use in clinical communications and care team interactions. Supports inclusive, patient-centered care and Joint Commission standards.. Valid values are `he/him|she/her|they/them|ze/zir|other|unknown`',
    `race_code` STRING COMMENT 'Patients self-reported race using OMB/CDC race category codes. Required for CMS demographic reporting, HEDIS measures, population health stratification, and health equity analytics. Supports multiple race selections per OMB standards. [ENUM-REF-CANDIDATE: 1002-5|2028-9|2054-5|2076-8|2106-3|2131-1|UNK — promote to reference product]',
    `race_description` STRING COMMENT 'Human-readable description of the patients self-reported race category (e.g., American Indian or Alaska Native, Asian, Black or African American). Paired with race_code for display and reporting.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the patients demographic record in the MPI. Active=current patient, Inactive=no recent encounters, Merged=duplicate resolved into another record, Deceased=patient has died, Test=test/training record.. Valid values are `active|inactive|merged|deceased|test`',
    `religion_code` STRING COMMENT 'Patients self-reported religious affiliation using HL7 v3 ReligiousAffiliation code set. Informs chaplaincy services, dietary restrictions, end-of-life care preferences, and culturally competent care delivery. [ENUM-REF-CANDIDATE: promote to reference product per HL7 v3 ReligiousAffiliation value set]',
    `sdoh_food_insecurity` BOOLEAN COMMENT 'Indicates whether the patient has screened positive for food insecurity. Core SDOH data element supporting care management referrals, population health stratification, and CMS health equity reporting.',
    `sdoh_housing_status` STRING COMMENT 'Patients self-reported housing stability status. Core SDOH data element used for population health stratification, care management prioritization, and CMS health equity reporting.. Valid values are `stable|unstable|homeless|temporary|unknown`',
    `sex_at_birth` STRING COMMENT 'Biological sex assigned at birth as recorded on the birth certificate. Distinct from gender identity. Required for clinical decision support, lab reference ranges, and CMS demographic reporting. Values: M=Male, F=Female, X=Intersex/Other, U=Unknown.. Valid values are `M|F|X|U`',
    `ssn_last4` STRING COMMENT 'Last four digits of the patients Social Security Number. Used for identity verification and insurance eligibility checks without storing the full SSN. Full SSN is not stored per HIPAA minimum necessary and PCI DSS principles.. Valid values are `^[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the patient demographics record. Used for change data capture (CDC), ETL incremental loads, and audit trail compliance.',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient demographics record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient demographics record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient demographics record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient demographics record.',
    `vip_indicator` BOOLEAN COMMENT 'Flags the patient as a VIP (e.g., celebrity, executive, employee, or high-profile individual) requiring enhanced privacy protections and special handling protocols. Triggers restricted access controls and audit logging per HIPAA minimum necessary standard.',
    CONSTRAINT pk_demographics PRIMARY KEY(`demographics_id`)
) COMMENT 'Core patient demographic profile — legal name, date of birth, gender identity, sex assigned at birth, race, ethnicity, preferred language, marital status, religion, addresses (home, mailing, temporary, work with geocoding and SDOH census tract linkage), phone numbers, email, emergency contacts with authorization levels and healthcare proxy designations, deceased status (date, cause, manner of death, death certificate reference), and PHI-protected identity attributes. SSOT for patient identity attributes downstream of MPI, multi-address management, and emergency contact records. Supports population health outreach, EMTALA-compliant emergency contact access, vital statistics reporting, and population health stratification. Compliant with HIPAA PHI classification, CMS demographic data requirements, and aligned with HL7 FHIR Patient resource demographics elements. Sourced from EHR registration modules, ADT systems, and state vital records.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate identifier for each patient address record in the Master Patient Index (MPI). Primary key for the patient.address data product.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient record in the Master Patient Index (MPI) to whom this address belongs. Links address to the patient master.',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active indicates the address is in use; inactive indicates it has been superseded; undeliverable indicates mail has been returned or the address is not reachable; returned_mail indicates USPS or courier returned correspondence.. Valid values are `active|inactive|undeliverable|returned_mail`',
    `address_type` STRING COMMENT 'Classifies the purpose of the address record. Supported types: home (primary residence), mailing (preferred correspondence), temporary (short-term stay), work (employer location), billing (financial correspondence), guarantor (responsible party address). [ENUM-REF-CANDIDATE: home|mailing|temporary|work|billing|guarantor — promote to reference product if additional types are needed]. Valid values are `home|mailing|temporary|work|billing|guarantor`',
    `area_deprivation_index` DECIMAL(18,2) COMMENT 'National Area Deprivation Index (ADI) score derived from the census tract of this address, ranging from 1 (least deprived) to 100 (most deprived). Used for SDOH risk stratification, population health segmentation, and value-based care program targeting.',
    `census_tract` STRING COMMENT 'U.S. Census Bureau census tract identifier for the address location. Used for SDOH stratification, Area Deprivation Index (ADI) linkage, and population health analytics to identify socioeconomic risk factors.',
    `city` STRING COMMENT 'City or municipality of the patient address. Used for population health outreach, care gap closure, and Social Determinants of Health (SDOH) stratification.',
    `clinical_ai_integration_marker` DECIMAL(18,2) COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the address (e.g., USA, CAN, MEX). Supports international patient populations and cross-border care coordination.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish name associated with the patient address. Used for SDOH stratification, public health reporting, and county-level population health analytics.',
    `county_fips_code` STRING COMMENT 'Five-digit Federal Information Processing Standards (FIPS) code uniquely identifying the county. Enables linkage to census data, Area Deprivation Index (ADI), and federal SDOH datasets for population health management.. Valid values are `^d{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the source system or the Silver Layer data product. Supports audit trail, data lineage, and HIPAA access logging requirements.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` DECIMAL(18,2) COMMENT 'Marker attribute digital_health_integration_marker on patient.address capturing digital health integration marker.',
    `digital_health_integration_timestamp` DOUBLE COMMENT 'Timestamp of digital health integration',
    `digital_health_marker` STRING COMMENT 'Digital health marker for the patient address record.',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `district` STRING COMMENT 'Administrative district or borough associated with the address. Used in urban markets and international patient populations for sub-county geographic segmentation and population health reporting.',
    `do_not_contact_reason` STRING COMMENT 'Free-text or coded reason why the patient has requested no contact at this address (e.g., patient request, domestic violence protection, deceased, address undeliverable). Supports HIPAA confidential communications compliance and patient preference management.',
    `effective_end_date` DATE COMMENT 'Date on which this address record is no longer active for the patient. Null indicates the address is currently active. Supports historical address tracking and transitions of care documentation.',
    `effective_start_date` DATE COMMENT 'Date from which this address record is considered active and valid for the patient. Supports temporal address management, enabling historical address lookups and point-in-time reporting for care coordination and billing.',
    `geocode_precision` STRING COMMENT 'Precision level of the geocoded coordinates indicating how accurately the latitude/longitude represents the address. Rooftop is highest precision; ungeocoded indicates geocoding has not been performed or failed.. Valid values are `rooftop|range_interpolated|geometric_center|approximate|ungeocoded`',
    `health_service_area` STRING COMMENT 'Dartmouth Atlas Health Service Area (HSA) or facility-defined service area code associated with the address. Used for population health management, market analysis, and care utilization reporting.',
    `housing_type` STRING COMMENT 'Categorizes the patients housing situation at this address. Supports Social Determinants of Health (SDOH) screening, housing instability risk stratification, and population health management programs. Aligned with AHRQ SDOH domain of housing instability.. Valid values are `owned|rented|shelter|transitional|group_home|unhoused`',
    `is_confidential` BOOLEAN COMMENT 'Indicates the address is marked confidential and must not be disclosed to unauthorized parties, including family members. Supports domestic violence protections, sensitive patient situations, and HIPAA confidential communications requirements under 45 CFR §164.522(b).',
    `is_do_not_mail` BOOLEAN COMMENT 'Indicates the patient has requested that no physical mail be sent to this address. Enforced during population health outreach, care gap closure mailings, and marketing communications to honor patient preferences and comply with HIPAA minimum necessary standards.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this address is the patients primary address of record. Only one address per patient should be flagged as primary at any given time. Used by clinical and billing systems to select the default address for correspondence.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees, WGS84) derived from geocoding the address. Supports spatial analytics, drive-time analysis, care access mapping, and population health outreach routing.',
    `line1` STRING COMMENT 'Primary street address line including house/building number and street name. First line of the patients physical or mailing address as captured in Epic or Cerner registration.',
    `line2` STRING COMMENT 'Secondary address line for apartment, suite, unit, floor, or building designator. Supplements address_line1 for multi-unit dwellings.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees, WGS84) derived from geocoding the address. Supports spatial analytics, drive-time analysis, care access mapping, and population health outreach routing.',
    `move_in_date` DATE COMMENT 'Date the patient moved into or began residing at this address, as reported by the patient during registration or updated via patient portal. Supports address tenure analysis and SDOH housing stability assessments.',
    `move_out_date` DATE COMMENT 'Date the patient moved out of or ceased residing at this address, as reported during registration update or returned mail processing. Used to close address records and trigger re-registration workflows.',
    `mrn` STRING COMMENT 'Medical Record Number assigned to the patient by the facility. Carried on the address record to support address-level patient identification and deduplication workflows in the Master Patient Index (MPI).',
    `mutator_added_flag` BOOLEAN COMMENT 'Flag added by mutator to ensure model change.',
    `ncoa_match_code` STRING COMMENT 'USPS NCOA match result code indicating the outcome of the change-of-address lookup (e.g., individual match, family match, business match, no match, moved with no forwarding address). Used to assess address currency and trigger update workflows.',
    `ncoa_update_date` DATE COMMENT 'Date on which this address was last updated via USPS National Change of Address (NCOA) processing. Supports address hygiene programs and ensures outreach mailings reach patients who have relocated.',
    `postal_code` STRING COMMENT 'USPS ZIP or ZIP+4 postal code for the address. Used for geographic routing, population health outreach, and SDOH analysis. Note: Per HIPAA Safe Harbor, full 9-digit ZIP codes for small geographic areas may require de-identification.. Valid values are `^d{5}(-d{4})?$`',
    `preferred_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code representing the patients preferred language for written communications sent to this address (e.g., en, es, zh). Supports culturally competent outreach and CMS language access requirements.. Valid values are `^[a-z]{2,3}$`',
    `sdoh_housing_instability_flag` BOOLEAN COMMENT 'Indicates the patient has been identified as experiencing housing instability at this address based on SDOH screening (e.g., PRAPARE, AHC HRSN). Triggers care management interventions and community resource referrals.',
    `source_system_address_code` STRING COMMENT 'Native identifier for this address record in the originating operational system (e.g., Epic address record ID, Cerner address sequence number). Supports ETL reconciliation, deduplication, and cross-system traceability.',
    `state_code` STRING COMMENT 'Two-letter USPS state or territory abbreviation (e.g., CA, TX, NY). Used for state-level regulatory reporting, licensure verification, and population health segmentation.. Valid values are `^[A-Z]{2}$`',
    `updated_by` STRING COMMENT 'Username or system identifier of the user or automated process that last modified this address record. Supports HIPAA audit trail requirements and data stewardship accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last modified in the source system or the Silver Layer data product. Supports change data capture (CDC), incremental ETL processing, and audit trail requirements.',
    `urban_rural_classification` STRING COMMENT 'Classifies the address location as urban, suburban, rural, or frontier based on USDA Rural-Urban Commuting Area (RUCA) codes or HRSA definitions. Used for CMS geographic payment adjustments, rural health program eligibility, and access-to-care analytics.. Valid values are `urban|suburban|rural|frontier`',
    `validation_date` DATE COMMENT 'Date on which the address was last validated against USPS or a third-party address verification service. Supports re-validation scheduling and data quality monitoring.',
    `validation_source` STRING COMMENT 'Name of the system or service used to validate the address (e.g., USPS CASS, Melissa Data, SmartyStreets, Epic Address Validation). Supports audit trails for address quality management.',
    `validation_status` STRING COMMENT 'Current USPS or third-party address validation status. Validated indicates the address was confirmed deliverable by USPS CASS certification or equivalent. Corrected indicates the address was standardized during validation. Used to ensure accuracy of outreach mailings and care gap closure communications.. Valid values are `validated|unvalidated|invalid|corrected|pending`',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the patient address record.',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient address record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_extra` STRING COMMENT 'The vibe mutation extra of the patient address record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient address record.',
    `vibe_mutation_marker_added` STRING COMMENT 'The vibe mutation marker added of the patient address record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient address record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient address record.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Patient address records supporting multiple address types (home, mailing, temporary, work) with full address components, geocoding coordinates, county/census tract for SDOH analysis, address validation status, effective date ranges, and do-not-mail flags. Supports population health outreach, care gap closure, and SDOH stratification. Sourced from Epic and Cerner registration systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` (
    `insurance_coverage_id` BIGINT COMMENT 'Unique surrogate identifier for each insurance coverage record in the patient domain. Primary key for the insurance_coverage data product.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Insurance coverage must reference the specific health plan for benefit lookup, eligibility verification, and claims adjudication. Revenue cycle and eligibility workflows require knowing which health_p',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization responsible for adjudicating claims under this coverage. Aligns with the payer master in the reference data domain.',
    `mpi_record_id` BIGINT COMMENT 'The insurance member identification number assigned by the payer to uniquely identify the insured individual. Used in eligibility verification (X12 270/271), claims submission (CMS-1500, UB-04), and Electronic Remittance Advice (ERA) matching.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to insurance.subscriber. Business justification: Insurance coverage tracks a members coverage under a subscribers policy. Billing, COB processing, and claims adjudication require identifying the subscriber (policyholder) for each coverage record. ',
    `benefit_year_end` DATE COMMENT 'The end date of the insurance plans benefit year (plan year). Used to reset deductible and out-of-pocket accumulator tracking and to identify coverage renewal requirements.',
    `benefit_year_start` DATE COMMENT 'The start date of the insurance plans benefit year (plan year). Used to reset deductible and out-of-pocket accumulator tracking. May differ from the coverage effective date for mid-year enrollments.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `cob_priority` STRING COMMENT 'Numeric priority order for Coordination of Benefits (COB) when a patient has multiple insurance coverages. 1 = primary payer, 2 = secondary payer, 3 = tertiary payer. Governs claim submission sequencing and payment responsibility allocation.',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'The percentage of covered service costs the patient is responsible for after the deductible is met, expressed as a decimal (e.g., 0.2000 = 20%). Used in patient financial counseling and Revenue Cycle Management (RCM) estimation.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount the patient is required to pay at the time of service for a covered visit or procedure (e.g., $25 primary care, $50 specialist). Used in point-of-service collection and patient financial counseling.',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the insurance coverage record. Drives eligibility verification workflows, claim submission eligibility, and front-end Revenue Cycle Management (RCM) processes. Active = currently valid; Pending = awaiting confirmation; Terminated = coverage ended; Suspended = temporarily inactive.. Valid values are `active|inactive|pending|terminated|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this insurance coverage record was first created in the system. Supports audit trail, data lineage, and HIPAA audit control requirements.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The annual deductible amount the patient must pay out-of-pocket before the insurance plan begins covering costs. Expressed in USD. Used in patient financial counseling, prior authorization, and Revenue Cycle Management (RCM) workflows.',
    `deductible_met_amount` DECIMAL(18,2) COMMENT 'The year-to-date amount the patient has applied toward their annual deductible. Sourced from real-time eligibility verification (X12 271) responses. Used in patient financial counseling and point-of-service collection.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` STRING COMMENT 'Flag indicating integration with digital health domain',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `effective_date` DATE COMMENT 'The date on which the insurance coverage becomes effective and claims may be submitted. Used in eligibility verification and coordination of benefits (COB) sequencing. Aligns with X12 271 DTP*356 segment.',
    `eligibility_response_code` STRING COMMENT 'The X12 271 AAA or EB segment response code returned by the payer during eligibility verification, indicating the specific eligibility status or rejection reason (e.g., 1 = Active Coverage, AAA = Rejection). Supports denial prevention and RCM analytics.',
    `eligibility_transaction_number` STRING COMMENT 'The unique transaction control number (TCN) or trace number assigned to the X12 270/271 eligibility verification transaction or FHIR CoverageEligibilityRequest. Enables end-to-end audit trail and transaction reconciliation.',
    `eligibility_verification_method` STRING COMMENT 'The method used to perform the most recent eligibility verification for this coverage. Supports audit trail requirements and verification workflow analytics. EDI_270_271 = X12 batch or real-time transaction; portal = payer web portal; phone = verbal verification; real_time_API = FHIR-based real-time check.. Valid values are `EDI_270_271|portal|phone|manual|real_time_API`',
    `eligibility_verification_status` STRING COMMENT 'The current status of the most recent eligibility verification transaction for this coverage record. Reflects the outcome of X12 270/271 EDI, portal, or phone-based verification. Drives front-end Revenue Cycle Management (RCM) workflows and claim denial prevention.. Valid values are `verified|unverified|pending|failed|not_eligible`',
    `eligibility_verified_by` STRING COMMENT 'The name or system identifier of the staff member, automated process, or clearinghouse that performed the most recent eligibility verification. Supports audit trail and accountability for Revenue Cycle Management (RCM) workflows.',
    `eligibility_verified_timestamp` TIMESTAMP COMMENT 'The date and time when the most recent eligibility verification was completed. Used in the eligibility verification audit trail and to determine whether re-verification is required based on payer-specific or organizational SLA policies.',
    `group_number` STRING COMMENT 'The employer or group plan number assigned by the payer that identifies the specific group policy under which the member is covered. Required for claims submission and eligibility verification.',
    `insurance_card_back_url` STRING COMMENT 'Secure URL or document reference to the scanned or photographed back of the patients insurance card. Stored in a HIPAA-compliant document management system. Contains payer contact information and claims submission instructions.',
    `insurance_card_front_url` STRING COMMENT 'Secure URL or document reference to the scanned or photographed front of the patients insurance card. Stored in a HIPAA-compliant document management system. Used for manual verification and patient registration workflows.',
    `medicaid_state_code` STRING COMMENT 'Two-letter US state code identifying the state Medicaid program under which the patient is enrolled. Null for non-Medicaid plans. Required for Medicaid claim submission and state-specific billing rules.. Valid values are `^[A-Z]{2}$`',
    `medicare_part` STRING COMMENT 'For Medicare coverage, identifies the specific Medicare part: A (Hospital Insurance), B (Medical Insurance), C (Medicare Advantage/HMO), or D (Prescription Drug Coverage). Null for non-Medicare plans. Drives CMS billing rules and claim form selection.. Valid values are `A|B|C|D`',
    `network_status` STRING COMMENT 'Indicates whether the patients coverage is being used within the payers contracted provider network (in-network) or outside it (out-of-network). Affects patient cost-sharing, claim adjudication rates, and denial risk.. Valid values are `in_network|out_of_network|unknown`',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'The maximum annual amount the patient is required to pay out-of-pocket for covered services, after which the plan covers 100% of costs. Used in patient financial counseling and Revenue Cycle Management (RCM) workflows.',
    `out_of_pocket_met_amount` DECIMAL(18,2) COMMENT 'The year-to-date amount the patient has applied toward their annual out-of-pocket maximum. Sourced from real-time eligibility verification (X12 271) responses. Informs point-of-service collection decisions.',
    `payer_electronic_number` STRING COMMENT 'The electronic payer identification number used for submitting X12 EDI transactions (270/271 eligibility, 837 claims). Also known as the EDI payer ID or clearinghouse payer ID. Distinct from the NPI.',
    `prior_auth_required` BOOLEAN COMMENT 'Indicates whether the insurance plan requires prior authorization (pre-authorization) before certain services, procedures, or medications are covered. Drives pre-authorization workflows in Order Management and Surgical/Procedural Scheduling.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether the insurance plan requires a referral from a Primary Care Physician (PCP) before the patient can see a specialist. Applicable primarily to Health Maintenance Organization (HMO) and Point of Service (POS) plans.',
    `rx_bin` STRING COMMENT 'The 6-digit Bank Identification Number (BIN) used to route pharmacy claims to the correct Pharmacy Benefit Manager (PBM). Printed on the insurance card and required for real-time pharmacy eligibility and adjudication via NCPDP SCRIPT standard.. Valid values are `^[0-9]{6}$`',
    `rx_group` STRING COMMENT 'The pharmacy benefit group number used to identify the specific pharmacy benefit plan within the Pharmacy Benefit Manager (PBM) system. Printed on the insurance card alongside RxBIN and PCN.',
    `rx_pcn` STRING COMMENT 'The Processor Control Number (PCN) used in conjunction with the RxBIN to route pharmacy claims to the correct sub-processor within the Pharmacy Benefit Manager (PBM). Required for pharmacy eligibility verification.',
    `source_system_record_code` STRING COMMENT 'The native primary key or record identifier for this coverage record in the originating operational system (e.g., Epic coverage record ID, Cerner insurance record ID). Enables traceability from the Silver layer back to the system of record.',
    `subscriber_relationship` STRING COMMENT 'The relationship of the patient (beneficiary) to the primary insurance subscriber. Determines coordination of benefits (COB) rules and claim filing requirements. Self indicates the patient is the primary subscriber.. Valid values are `self|spouse|child|dependent|other`',
    `termination_date` DATE COMMENT 'The date on which the insurance coverage ends or is terminated. Null indicates open-ended active coverage. Used to prevent claim submission for services rendered outside the coverage period. Aligns with X12 271 DTP*357 segment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this insurance coverage record was most recently modified. Supports change tracking, audit trail, and incremental ETL processing in the Databricks Silver layer.',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient insurance coverage record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient insurance coverage record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient insurance coverage record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient insurance coverage record.',
    CONSTRAINT pk_insurance_coverage PRIMARY KEY(`insurance_coverage_id`)
) COMMENT 'Patient insurance coverage, eligibility, and verification records. Captures payer name, plan name, plan type (HMO, PPO, POS, Medicare, Medicaid, self-pay), member ID, group number, subscriber relationship, coverage effective and termination dates, coordination of benefits (COB) priority, copay/deductible/out-of-pocket amounts, pre-authorization requirements, and real-time/batch eligibility verification transactions (270/271 EDI, portal, phone) with verification status, confirmed coverage details, verification date/time, payer queried, and verification audit trail. SSOT for patient payer eligibility and verification consumed by billing and claims domains. Supports front-end RCM workflows, claim denial prevention, and prior authorization management. Aligned with X12 270/271 transaction standards and HL7 FHIR Coverage resource. Sourced from EHR revenue cycle and eligibility verification modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`guarantor` (
    `guarantor_id` BIGINT COMMENT 'Unique surrogate identifier for the financial guarantor record within the patient accounting system. Primary key for the guarantor entity; referenced by patient account and billing records across the Revenue Cycle Management (RCM) domain.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient record for whom this guarantor is financially responsible. Links the guarantor to the Master Patient Index (MPI) and enables RCM workflows to associate account balances with the correct patient.',
    `account_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance owed by the guarantor on the patient account in USD. Represents the net self-pay balance after insurance adjudication, contractual adjustments, and payments applied. Core metric for RCM self-pay collection and patient financial counseling.',
    `account_number` STRING COMMENT 'Externally-known patient accounting number assigned to the guarantor account in the EHR revenue cycle or patient accounting system (e.g., Epic Resolute HB guarantor account number). Used by billing staff, financial counselors, and self-pay collection teams to identify and reference the account.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the guarantor account within the Revenue Cycle Management (RCM) workflow. Drives billing, collection, and write-off processes. [ENUM-REF-CANDIDATE: active|inactive|collections|bad_debt|deceased|bankruptcy — promote to reference product if additional statuses are required]. Valid values are `active|inactive|collections|bad_debt|deceased|bankruptcy`',
    `address_line1` STRING COMMENT 'Primary street address line of the guarantors mailing or billing address. Used for billing statement delivery, collection correspondence, and address verification in RCM workflows.',
    `address_line2` STRING COMMENT 'Secondary address line for the guarantor (apartment, suite, unit, floor, PO Box). Supplements address_line1 for complete mailing address used in billing and collection correspondence.',
    `annual_income` DECIMAL(18,2) COMMENT 'Self-reported or verified annual gross income of the guarantor in USD. Used for financial assistance (charity care) eligibility screening, sliding-scale fee determination, and payment plan structuring per CMS and ACA financial assistance requirements.',
    `bad_debt_flag` BOOLEAN COMMENT 'Indicates whether the guarantor account balance has been written off as bad debt in the patient accounting system. Supports financial reporting, bad debt reserve calculations, and RAC audit documentation per GAAP and CMS guidelines.',
    `bankruptcy_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has filed for bankruptcy protection. When True, all collection activities must cease immediately per the automatic stay provisions of the U.S. Bankruptcy Code (11 U.S.C. §362) and the account is flagged for legal review.',
    `city` STRING COMMENT 'City of the guarantors billing or mailing address. Used in billing statement generation, collection correspondence, and geographic analytics for patient financial services.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `collection_agency_flag` BOOLEAN COMMENT 'Indicates whether the guarantor account has been referred to an external collection agency for bad debt recovery. When True, direct billing and collection activities by the healthcare organization are suspended per FDCPA requirements.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the guarantors billing or mailing address (e.g., USA, CAN, MEX). Supports international patient billing and cross-border financial correspondence.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the guarantor record was first created in the patient accounting system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Supports audit trail requirements, data lineage, and HIPAA compliance documentation.',
    `date_of_birth` DATE COMMENT 'Date of birth of the guarantor individual in yyyy-MM-dd format. Used for identity verification, eligibility determination for financial assistance programs, and demographic analytics in patient financial services.',
    `deceased_flag` BOOLEAN COMMENT 'Indicates whether the guarantor is deceased. When True, billing and collection workflows are routed to estate billing processes and direct collection outreach is suspended per FDCPA and state probate law requirements.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` STRING COMMENT 'Flag indicating integration with digital health domain',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `do_not_contact_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has requested cessation of all billing and collection contact. When True, all outreach activities are suppressed in compliance with FDCPA cease-and-desist provisions and HIPAA patient rights.',
    `email_address` STRING COMMENT 'Email address of the guarantor used for electronic billing statements (e-statements), payment portal communications, and financial counseling correspondence. Consent for electronic communication must be documented per HIPAA and CAN-SPAM Act.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employer_name` STRING COMMENT 'Name of the guarantors current employer. Used in financial counseling, self-pay collection assessments, and financial assistance (charity care) eligibility screening to evaluate ability to pay.',
    `employer_phone` STRING COMMENT 'Phone number of the guarantors employer. Used in self-pay collection processes and financial counseling to verify employment status and facilitate payment arrangements.. Valid values are `^+?[0-9-() ]{7,20}$`',
    `employment_status` STRING COMMENT 'Current employment status of the guarantor. Used in financial assistance (charity care) eligibility determination, payment plan structuring, and self-pay collection risk stratification. [ENUM-REF-CANDIDATE: employed_full_time|employed_part_time|self_employed|unemployed|retired|student|disabled — promote to reference product]',
    `estatement_consent_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has consented to receive electronic billing statements (e-statements) via email or patient portal in lieu of paper statements. Supports paperless billing initiatives and reduces statement delivery costs in RCM.',
    `federal_poverty_level_pct` DECIMAL(18,2) COMMENT 'Calculated Federal Poverty Level (FPL) percentage for the guarantors household based on annual income and household size. Determines eligibility tier for financial assistance programs, charity care, and sliding-scale discounts per ACA Section 501(r) and CMS guidelines.',
    `financial_assistance_status` STRING COMMENT 'Current status of the guarantors financial assistance (charity care) application. Drives billing hold, discount application, and collection suspension workflows in the RCM system. Supports ACA Section 501(r) compliance reporting.. Valid values are `not_applied|pending|approved|denied|partial`',
    `financial_assistance_type` STRING COMMENT 'Type of financial assistance program approved or applied for by the guarantor. Determines the discount percentage, payment schedule, and billing workflow applied to the account. [ENUM-REF-CANDIDATE: charity_care|sliding_scale|payment_plan|hardship|medicaid_pending — promote to reference product]. Valid values are `charity_care|sliding_scale|payment_plan|hardship|medicaid_pending`',
    `first_name` STRING COMMENT 'Legal first (given) name of the guarantor individual. Used in billing correspondence, patient financial counseling communications, and self-pay collection outreach. Protected Health Information (PHI) under HIPAA when linked to patient account data.',
    `guarantor_type` STRING COMMENT 'Classification of the guarantor indicating whether the responsible party is the patient themselves, a family member, a legal guardian, an estate, or an organization. Determines billing workflow routing and financial counseling approach. [ENUM-REF-CANDIDATE: self|parent|spouse|legal_guardian|estate|organization — promote to reference product if additional types are required]. Valid values are `self|parent|spouse|legal_guardian|estate|organization`',
    `home_phone` STRING COMMENT 'Home telephone number of the guarantor. Primary contact channel for billing inquiries, financial counseling outreach, and self-pay collection calls. Stored in compliance with HIPAA and Telephone Consumer Protection Act (TCPA) requirements.. Valid values are `^+?[0-9-() ]{7,20}$`',
    `household_size` STRING COMMENT 'Number of individuals in the guarantors household. Used in conjunction with annual income to determine Federal Poverty Level (FPL) percentage for financial assistance (charity care) eligibility and sliding-scale fee calculations.',
    `last_name` STRING COMMENT 'Legal last (family) name of the guarantor individual. Used in billing correspondence, collection letters, and identity verification for patient financial services.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the most recent payment received from the guarantor in USD. Used alongside last_payment_date for payment plan compliance monitoring, collection risk assessment, and RCM reporting.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from the guarantor toward the outstanding account balance. Used in collection aging analysis, payment plan compliance monitoring, and bad debt risk stratification.',
    `last_statement_date` DATE COMMENT 'Date on which the most recent billing statement was generated and sent to the guarantor. Used to track billing cycle compliance, manage statement frequency, and support collection escalation timelines in RCM.',
    `middle_name` STRING COMMENT 'Legal middle name or initial of the guarantor individual. Supports identity verification and disambiguation in patient accounting and self-pay collection workflows.',
    `mobile_phone` STRING COMMENT 'Mobile/cell phone number of the guarantor. Supports SMS billing notifications, payment reminders, and collection outreach. Consent for text messaging must be captured separately per TCPA requirements.. Valid values are `^+?[0-9-() ]{7,20}$`',
    `organization_name` STRING COMMENT 'Legal name of the organization acting as guarantor when the responsible party is a business entity, estate, or institution rather than an individual. Populated when guarantor_type is organization or estate.',
    `payment_plan_amount` DECIMAL(18,2) COMMENT 'Agreed monthly payment amount under the guarantors active payment plan arrangement in USD. Used by RCM billing staff to monitor payment plan compliance and trigger collection escalation if payments are missed.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has an active payment plan arrangement for the outstanding account balance. When True, collection activities are suspended and the account follows the payment plan schedule in the RCM system.',
    `postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code of the guarantors billing or mailing address. Used for billing statement delivery, collection correspondence, and geographic segmentation in patient financial analytics.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `preferred_contact_method` STRING COMMENT 'Guarantors preferred method of contact for billing statements, payment reminders, and financial counseling communications. Drives outreach channel selection in RCM workflows and patient financial services.. Valid values are `home_phone|work_phone|mobile_phone|email|mail`',
    `relationship_to_patient` STRING COMMENT 'Describes the guarantors relationship to the patient as defined in the EHR patient accounting module. Used for financial counseling, billing correspondence, and HIPAA-compliant disclosure of account information. [ENUM-REF-CANDIDATE: self|spouse|parent|child|sibling|grandparent|legal_guardian|other — promote to reference product]',
    `responsibility_pct` DECIMAL(18,2) COMMENT 'Percentage of the total patient account balance for which this guarantor is financially responsible. Supports scenarios where multiple guarantors share responsibility for a single patient account (e.g., divorced parents of a minor patient). Value range: 0.00 to 100.00.',
    `since_date` DATE COMMENT 'Date on which the individual or organization was first established as the financial guarantor for the patient account. Marks the effective start of financial responsibility and is used in RCM aging analysis and financial counseling workflows.',
    `sms_consent_flag` BOOLEAN COMMENT 'Indicates whether the guarantor has provided explicit written consent to receive SMS/text message billing notifications and payment reminders. Required for TCPA compliance before sending automated text messages to the guarantors mobile phone.',
    `ssn_masked` STRING COMMENT 'Masked Social Security Number (SSN) of the guarantor, displaying only the last four digits (format: XXX-XX-NNNN). Used for identity verification in self-pay collections, financial assistance screening, and credit bureau reporting. Full SSN must never be stored in the Silver layer per HIPAA and PCI DSS data minimization requirements.. Valid values are `^XXX-XX-[0-9]{4}$`',
    `state` STRING COMMENT 'Two-letter US state or territory code of the guarantors billing or mailing address (e.g., CA, TX, NY). Used for billing correspondence, state-specific financial assistance program eligibility, and regulatory reporting.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the guarantor record was most recently modified in the patient accounting system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Supports change data capture (CDC), audit trail requirements, and Silver layer incremental load processing.',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient guarantor record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient guarantor record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient guarantor record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient guarantor record.',
    `work_phone` STRING COMMENT 'Work telephone number of the guarantor. Used as an alternate contact channel for billing and collection communications when home phone is unavailable. Stored in compliance with HIPAA and TCPA.. Valid values are `^+?[0-9-() ]{7,20}$`',
    CONSTRAINT pk_guarantor PRIMARY KEY(`guarantor_id`)
) COMMENT 'Financial guarantor record identifying the individual or entity responsible for patient account balances. Captures guarantor name, relationship to patient, address, phone, employer information, SSN (masked), and account responsibility percentage. Supports RCM billing workflows, patient financial counseling, and self-pay collection processes. Sourced from EHR revenue cycle and patient accounting modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` (
    `emergency_contact_id` BIGINT COMMENT 'Unique surrogate identifier for the emergency contact record in the Master Patient Index (MPI) system. Primary key for the emergency_contact data product.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this emergency contact is registered. Links to the patient master record in the Master Patient Index (MPI).',
    `address_line1` STRING COMMENT 'Primary street address line for the emergency contacts residence. Used for written correspondence, legal notifications, and discharge planning documentation.',
    `address_line2` STRING COMMENT 'Secondary address line for the emergency contact (e.g., apartment number, suite, unit). Supplements address_line1 for complete mailing address resolution.',
    `city` STRING COMMENT 'City of residence for the emergency contact. Used in conjunction with state and postal code for complete address resolution and geographic analytics.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `consent_date` DATE COMMENT 'The date on which the patient provided consent to designate this individual as an emergency contact and/or authorized recipient of PHI. Required for HIPAA audit trails and regulatory compliance.',
    `consent_obtained_by` STRING COMMENT 'Name or identifier of the staff member (e.g., registration clerk, nurse) who obtained the patients consent to designate this emergency contact. Supports HIPAA audit trail requirements and accountability in the registration workflow.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the emergency contact record. Active = currently valid and reachable; Inactive = no longer applicable (e.g., relationship ended); Deceased = contact has died; Unverified = contact information has not been confirmed with the patient.. Valid values are `active|inactive|deceased|unverified`',
    `contact_type` STRING COMMENT 'Classification of the contacts role relative to the patient. Determines the scope of authority and notification priority. Values include emergency_contact (general notification), healthcare_proxy (authorized to make medical decisions), legal_guardian (legal authority over patient), authorized_representative (authorized to receive PHI per HIPAA), next_of_kin (biological/legal family), guarantor (financial responsibility). [ENUM-REF-CANDIDATE: emergency_contact|healthcare_proxy|legal_guardian|authorized_representative|next_of_kin|guarantor — promote to reference product]. Valid values are `emergency_contact|healthcare_proxy|legal_guardian|authorized_representative|next_of_kin|guarantor`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the emergency contacts address. Supports international patients and contacts residing outside the United States.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this emergency contact record was first created in the system. Supports audit trail requirements, HIPAA compliance, and data lineage tracking. Stored in ISO 8601 format with timezone offset.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` STRING COMMENT 'Flag indicating integration with digital health domain',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `effective_end_date` DATE COMMENT 'The date on which this emergency contact designation is no longer valid (e.g., divorce, death of contact, revocation by patient). Null indicates the contact is currently active with no defined end date.',
    `effective_start_date` DATE COMMENT 'The date from which this emergency contact designation is considered valid and active. Supports temporal validity tracking for contact records, particularly when contacts change over time (e.g., new spouse, new guardian).',
    `email_address` STRING COMMENT 'Email address of the emergency contact. Used for non-urgent communications, appointment notifications, and electronic delivery of care summaries or discharge instructions where PHI authorization permits.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Legal given (first) name of the emergency contact individual. Used for identification and communication during care coordination and emergency notification workflows.',
    `healthcare_proxy_flag` BOOLEAN COMMENT 'Indicates whether this contact has been designated as the patients healthcare proxy (durable power of attorney for healthcare decisions). When True, this individual is legally authorized to make medical decisions on behalf of the patient if the patient is incapacitated. Distinct from phi_disclosure_authorized.',
    `home_phone` STRING COMMENT 'Residential landline phone number for the emergency contact. Used as a secondary contact channel when mobile phone is unavailable. Stored in E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `interpreter_required` BOOLEAN COMMENT 'Indicates whether a professional interpreter is required when communicating with this emergency contact. Supports compliance with Section 1557 of the Affordable Care Act (ACA) language access requirements and TJC communication standards.',
    `last_name` STRING COMMENT 'Legal family (last) name of the emergency contact individual. Used in conjunction with first_name for full identity resolution and communication.',
    `legal_guardian_flag` BOOLEAN COMMENT 'Indicates whether this contact holds legal guardianship over the patient (e.g., parent of a minor, court-appointed guardian for an incapacitated adult). When True, this individual has legal authority over the patients care decisions and access to medical records.',
    `lives_with_patient` BOOLEAN COMMENT 'Indicates whether the emergency contact resides in the same household as the patient. Relevant for discharge planning, home care coordination, and Social Determinants of Health (SDOH) assessments.',
    `middle_name` STRING COMMENT 'Middle name or initial of the emergency contact. Supports full legal name resolution and disambiguation when multiple contacts share the same first and last name.',
    `mobile_phone` STRING COMMENT 'Mobile (cell) phone number for the emergency contact. Preferred channel for urgent notifications and SMS-based communication during emergency and discharge planning workflows. Stored in E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `notes` STRING COMMENT 'Free-text field for additional clinical or administrative notes about this emergency contact (e.g., Contact is deaf — use text messaging only, Contact travels frequently — try mobile first). Supports nuanced care coordination and communication planning.',
    `notification_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient has explicitly consented to this contact being notified in the event of an emergency, admission, or discharge. Supports EMTALA compliance and HIPAA-compliant notification workflows.',
    `phi_disclosure_authorized` BOOLEAN COMMENT 'Indicates whether the patient has authorized this contact to receive Protected Health Information (PHI) about their care. Critical for HIPAA compliance — clinical staff must verify this flag before disclosing any PHI to the contact. True = authorized; False = not authorized.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the emergency contacts address. Supports mail delivery, geographic segmentation, and Social Determinants of Health (SDOH) analysis.. Valid values are `^d{5}(-d{4})?$`',
    `preferred_contact_method` STRING COMMENT 'The contacts preferred communication channel for receiving notifications and messages. Drives automated notification routing in care coordination and discharge planning workflows.. Valid values are `mobile|home_phone|work_phone|email|text_sms`',
    `preferred_language` STRING COMMENT 'The contacts preferred spoken/written language for communication, expressed as a BCP-47 language tag (e.g., en, es, zh-CN). Used to arrange interpreter services and ensure effective communication during emergency notifications and care coordination.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `preferred_name` STRING COMMENT 'The name the emergency contact prefers to be called, which may differ from their legal name. Supports patient-centered communication and cultural sensitivity in care coordination.',
    `priority_order` STRING COMMENT 'Numeric rank indicating the order in which this contact should be notified in an emergency (1 = first contact, 2 = second, etc.). Supports triage and discharge planning workflows where multiple contacts exist for a single patient.',
    `proxy_document_effective_date` DATE COMMENT 'The date on which the proxy authorization document (e.g., durable power of attorney, healthcare proxy form) became legally effective. Used to validate the currency of the authorization during care decisions.',
    `proxy_document_expiration_date` DATE COMMENT 'The date on which the proxy authorization document expires, if applicable. Null indicates the document is open-ended with no expiration. Clinical staff must verify this date before acting on proxy authority.',
    `proxy_document_type` STRING COMMENT 'Type of legal document on file that establishes this contacts authority as a healthcare proxy or legal guardian. Required for clinical staff to verify decision-making authority before acting on the contacts instructions.. Valid values are `durable_power_of_attorney|healthcare_proxy_form|court_order|advance_directive|none`',
    `relationship_type` STRING COMMENT 'The personal or familial relationship between the emergency contact and the patient (e.g., spouse, parent, sibling). Used for care coordination, discharge planning, and EMTALA compliance. Distinct from contact_type which captures the legal/functional role. [ENUM-REF-CANDIDATE: spouse|parent|child|sibling|domestic_partner|grandparent|aunt_uncle|friend|employer|other — promote to reference product]',
    `source_system_contact_code` STRING COMMENT 'The native identifier assigned to this emergency contact record in the originating source system (e.g., Epic contact ID, Cerner relationship ID). Used for cross-system reconciliation, ETL traceability, and Health Information Exchange (HIE) matching.',
    `state_code` STRING COMMENT 'Two-letter US state or territory code for the emergency contacts address. Follows USPS state abbreviation standards. Used for geographic reporting and jurisdictional compliance.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this emergency contact record was most recently modified. Supports change tracking, audit trail requirements, and incremental data loading in the Silver Layer lakehouse architecture.',
    `verified_by` STRING COMMENT 'Name or identifier of the staff member who last verified the accuracy of this emergency contacts information. Supports accountability and data quality governance in the patient registration process.',
    `verified_date` DATE COMMENT 'The most recent date on which the emergency contacts information was verified with the patient or the contact directly. Supports data quality management and ensures contact information is current for emergency use.',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient emergency contact record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient emergency contact record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient emergency contact record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient emergency contact record.',
    `work_phone` STRING COMMENT 'Business or workplace phone number for the emergency contact. Used during daytime hours when the contact may be reached at their place of employment. Stored in E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `work_phone_extension` STRING COMMENT 'Extension number associated with the contacts work phone. Required for routing calls within large organizations where the contact is employed.. Valid values are `^d{1,6}$`',
    CONSTRAINT pk_emergency_contact PRIMARY KEY(`emergency_contact_id`)
) COMMENT 'Patient emergency contact records capturing contact name, relationship type, priority order, phone numbers (home, mobile, work), address, and authorization level (e.g., authorized to receive PHI, healthcare proxy, legal guardian). Supports EMTALA compliance, care coordination, and discharge planning workflows. Sourced from Epic and Cerner registration modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` (
    `pcp_attribution_id` BIGINT COMMENT 'Unique surrogate identifier for each PCP attribution record in the Master Patient Index (MPI) attribution registry. Serves as the primary key for all downstream joins across population health, HEDIS, and value-based care reporting.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: ACO/MSSP and value-based care contracts require facility-level patient attribution alongside clinician attribution. CMS quality reporting and network adequacy analysis depend on knowing which org_prov',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: PCP attribution requires tracking the specialty of the attributed provider for network adequacy reporting, panel composition analysis, primary care vs specialist attribution rules, and risk-adjusted q',
    `care_team_id` BIGINT COMMENT 'Reference to the care team record when attribution is assigned to a multidisciplinary care team rather than a single PCP. Supports Accountable Care Organization (ACO) and Patient-Centered Medical Home (PCMH) attribution models where team-based care is the unit of attribution.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician record for the Primary Care Physician (PCP) or care team lead to whom the patient is attributed. Used to resolve provider demographics, specialty, and panel capacity from the provider domain.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient record in the Master Patient Index (MPI). Links the attribution record to the attributed patients demographic and identity data. Every clinical and financial domain references this identifier.',
    `health_plan_id` BIGINT COMMENT 'Reference to the payer insurance plan record associated with this attribution. Attribution rules and measurement periods vary by plan type (ACO, HMO, PPO, POS). Links to the billing and revenue cycle domain for plan-specific attribution logic.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: PCP attribution in value-based care is plan-specific — a patient may be attributed to different PCPs under different insurance plans. pcp_attribution already has payer_id and health_plan_id (cross-dom',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: PCP attribution is valid only for a specific enrollment period. ACO attribution, HEDIS measurement, and value-based care reporting all require knowing which member_enrollment record the attribution co',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: PCP attribution is an enterprise-level patient record that should link directly to the MPI for identity resolution and cross-facility patient matching. Currently pcp_attribution links to demographics ',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the patient pcp attribution record.',
    `aco_contract_number` STRING COMMENT 'CMS-assigned contract number for the Accountable Care Organization (ACO) governing this attribution. Required for CMS Medicare Shared Savings Program (MSSP) reporting, shared savings reconciliation, and regulatory submissions to CMS.. Valid values are `^ACO[0-9]{6}$`',
    `attributed_provider_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the attributed Primary Care Physician (PCP) or care team lead as registered with the National Plan and Provider Enumeration System (NPPES). Required for HEDIS, MIPS, and CMS value-based care reporting submissions.. Valid values are `^[0-9]{10}$`',
    `attribution_confidence_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the statistical confidence level of the attribution assignment. Higher scores indicate stronger evidence of the patient-PCP relationship based on visit frequency, claims history, or enrollment data. Used to prioritize manual review of low-confidence attributions and to weight population health analytics.',
    `attribution_method` STRING COMMENT 'The methodology used to assign the patient to the PCP or care team. Claims-based attribution uses historical utilization patterns; enrollment-based uses payer plan enrollment data; manual is provider-assigned; algorithm-based uses predictive models; hybrid combines multiple methods; empanelment is practice-panel assignment. Drives HEDIS, MIPS, and ACO reporting logic.. Valid values are `claims_based|enrollment_based|manual|algorithm_based|hybrid|empanelment`',
    `attribution_override_reason` STRING COMMENT 'Free-text or coded reason when an attribution assignment has been manually overridden from the algorithm-generated or payer-assigned attribution. Documents the clinical or administrative justification for the override, supporting audit trails and compliance with CMS and NCQA attribution integrity requirements.',
    `attribution_rank` STRING COMMENT 'Ordinal rank (1 = primary) when a patient has multiple concurrent attribution records across different payers or plans. Rank 1 designates the primary PCP attribution used for population health management and HEDIS reporting. Higher ranks indicate secondary or supplemental attributions.',
    `attribution_review_date` DATE COMMENT 'Scheduled or completed date for the next periodic review of this attribution record. Attribution records are reviewed quarterly or annually per payer contract requirements to ensure accuracy of panel rosters and compliance with HEDIS and MIPS reporting periods.',
    `attribution_segment` STRING COMMENT 'Insurance coverage segment of the attributed patient. Determines applicable attribution methodology, quality measure set, and regulatory reporting requirements. Dual eligible patients (Medicare and Medicaid) require special attribution handling per CMS duals coordination rules.. Valid values are `commercial|medicare|medicaid|dual_eligible|uninsured`',
    `attribution_source` STRING COMMENT 'The operational system of record from which this attribution record was sourced. Identifies whether the attribution originated from Epic Healthy Planet, Cerner Millennium, a payer attribution feed, manual entry, HL7 FHIR interface, or a population health management platform. Critical for data lineage and ETL reconciliation.. Valid values are `epic_healthy_planet|cerner_millennium|payer_feed|manual_entry|hl7_fhir|population_health_platform`',
    `attribution_status` STRING COMMENT 'Current lifecycle status of the PCP attribution record. Active indicates a current, valid attribution; pending indicates awaiting confirmation; disputed indicates a payer or provider challenge; terminated indicates the attribution period has ended; under_review indicates compliance or audit review in progress.. Valid values are `active|inactive|pending|terminated|disputed|under_review`',
    `care_management_enrolled` BOOLEAN COMMENT 'Indicates whether the attributed patient is currently enrolled in a care management or disease management program under the attributed PCP or ACO. True = enrolled in care management. Used for population health program tracking and HEDIS care management measure reporting.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `consent_on_file` BOOLEAN COMMENT 'Indicates whether the patient has provided documented consent for their health information to be shared with the attributed PCP, care team, and ACO for care coordination and population health management purposes. Required for HIPAA-compliant data sharing under ACO and HIE participation agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PCP attribution record was first created in the Silver Layer lakehouse. Supports data lineage, audit trail requirements, and compliance with HIPAA audit control standards. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_sharing_opt_out` BOOLEAN COMMENT 'Indicates whether the patient has exercised their right to opt out of data sharing with the ACO or population health program under CMS beneficiary notification and opt-out requirements. True = patient has opted out. Patients who opt out must be excluded from ACO attribution and shared data feeds.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` STRING COMMENT 'Flag indicating integration with digital health domain',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `disenrollment_reason` STRING COMMENT 'Coded reason for the termination of the PCP attribution. Used for panel management analytics, provider turnover reporting, and population health program evaluation. [ENUM-REF-CANDIDATE: provider_change|plan_disenrollment|patient_request|provider_termination|death|moved_out_of_area|other — promote to reference product]',
    `effective_date` DATE COMMENT 'The calendar date on which the PCP attribution becomes effective and the patient is considered part of the attributed providers panel. Used as the start boundary for HEDIS measurement periods, MIPS performance calculations, and ACO shared savings attribution windows.',
    `end_date` DATE COMMENT 'The calendar date on which the PCP attribution terminates. Null indicates an open-ended, currently active attribution. Used to calculate attribution duration, panel turnover, and to exclude patients from measurement periods after disenrollment or provider change.',
    `geographic_region` STRING COMMENT 'Geographic region or service area associated with this attribution record, typically aligned with CMS Hospital Referral Regions (HRR) or payer-defined service areas. Used for population health geographic analysis, regional quality benchmarking, and ACO regional benchmark calculations.',
    `hcc_risk_score` DECIMAL(18,2) COMMENT 'CMS Hierarchical Condition Category (HCC) risk adjustment score for the attributed patient at the time of attribution. Used in Medicare Advantage and ACO shared savings calculations to adjust expected expenditures for patient complexity. Sourced from CMS risk adjustment data or population health platform.',
    `hedis_eligible` BOOLEAN COMMENT 'Indicates whether this attribution record qualifies the patient for inclusion in HEDIS (Healthcare Effectiveness Data and Information Set) measure calculations for the current measurement year. Eligibility is determined by continuous enrollment criteria, plan type, and attribution method per NCQA HEDIS Technical Specifications.',
    `is_primary_attribution` BOOLEAN COMMENT 'Indicates whether this attribution record is the patients primary PCP attribution used as the single source of truth (SSOT) for population health management, HEDIS measurement, and MIPS performance reporting. True = primary attribution; False = secondary or supplemental attribution.',
    `last_visit_date` DATE COMMENT 'Date of the most recent qualifying primary care visit between the patient and the attributed PCP within the attribution lookback period. Used to assess recency of the patient-provider relationship and to support attribution validation and panel management.',
    `lookback_period_months` STRING COMMENT 'The number of months in the historical claims lookback window used to determine claims-based attribution. Standard values are 12 or 24 months per CMS and NCQA attribution methodologies. Stored to support audit and reproducibility of attribution assignments.',
    `measurement_year` STRING COMMENT 'The calendar year for which this attribution record is applicable for quality measurement reporting (HEDIS, MIPS, ACO quality measures). Attribution records are typically finalized at the start of each measurement year and used throughout the performance period.',
    `mips_eligible` BOOLEAN COMMENT 'Indicates whether the attributed provider qualifies for Merit-based Incentive Payment System (MIPS) performance measurement under MACRA for this attribution record. Eligibility is based on provider NPI, patient volume thresholds, and billing thresholds per CMS MIPS eligibility criteria.',
    `override_authorized_by` STRING COMMENT 'Name or identifier of the clinical or administrative staff member who authorized a manual attribution override. Required for audit trail integrity and compliance with CMS and NCQA attribution override documentation requirements.',
    `override_date` DATE COMMENT 'Date on which the manual attribution override was authorized and applied. Used in conjunction with override_authorized_by and attribution_override_reason to maintain a complete audit trail of attribution changes.',
    `panel_assignment_date` DATE COMMENT 'Date the patient was formally added to the attributed PCPs patient panel in the practice management or population health system (e.g., Epic Healthy Planet empanelment). May differ from the attribution effective date when payer attribution and practice empanelment are managed separately.',
    `payer_attribution_number` STRING COMMENT 'The external attribution identifier assigned by the payer or managed care organization in their attribution feed. Used to reconcile internal attribution records with payer-issued attribution rosters and to resolve attribution disputes with payers.',
    `plan_type` STRING COMMENT 'The type of health insurance plan governing this attribution relationship. Accountable Care Organization (ACO), Health Maintenance Organization (HMO), Preferred Provider Organization (PPO), Point of Service (POS), Exclusive Provider Organization (EPO), or Patient-Centered Medical Home (PCMH). Determines attribution methodology and performance measurement rules.. Valid values are `ACO|HMO|PPO|POS|EPO|PCMH`',
    `risk_stratification_tier` STRING COMMENT 'Patient risk stratification tier assigned at the time of attribution, based on clinical complexity, chronic condition burden, and Social Determinants of Health (SDOH) factors. Used by the attributed PCP and care team to prioritize outreach, care management intensity, and resource allocation in population health programs.. Valid values are `low|moderate|high|very_high`',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether the patient has documented Social Determinants of Health (SDOH) risk factors (e.g., food insecurity, housing instability, transportation barriers) that require care coordination support from the attributed PCP or care team. True = SDOH risk factors present.',
    `source_feed_date` DATE COMMENT 'Date of the payer attribution feed or population health system extract from which this attribution record was loaded. Used for data currency validation, ETL reconciliation, and to identify stale attribution records that require refresh from the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this PCP attribution record was last modified in the Silver Layer lakehouse. Used to detect and process incremental changes during ETL pipeline runs and to support audit trail requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient pcp attribution record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient pcp attribution record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient pcp attribution record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient pcp attribution record.',
    `visit_count_lookback` STRING COMMENT 'Number of qualifying primary care visits with the attributed provider during the claims-based attribution lookback period (typically 24 months). Used to validate and support claims-based attribution assignments and to calculate attribution confidence scores per CMS and NCQA methodologies.',
    CONSTRAINT pk_pcp_attribution PRIMARY KEY(`pcp_attribution_id`)
) COMMENT 'Patient attribution to Primary Care Physician (PCP) or care team records capturing attributed provider NPI, attribution method (claims-based, enrollment-based, manual), attribution panel, attribution effective and end dates, ACO/HMO/PPO plan attribution, and attribution confidence score. SSOT for care team assignment used in population health, HEDIS, MIPS, and value-based care reporting. Sourced from population health management and payer attribution feeds.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` (
    `eligibility_check_id` BIGINT COMMENT 'Unique surrogate identifier for each insurance eligibility verification transaction record in the Silver layer lakehouse.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_appointment. Business justification: Eligibility verification is performed at radiology appointment scheduling time, not only at order placement. Linking eligibility_check directly to radiology_appointment supports appointment-level pre-',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: Eligibility checks are performed for specific appointment/service types to verify coverage applicability. Linking eligibility_check to appointment_type supports service-specific prior authorization wo',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Real-time benefit verification during CPOE ordering requires linking eligibility checks to specific orders for prior authorization determination, formulary checking, and coverage validation at order p',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Prior authorization eligibility checks are triggered by specific diagnosis codes (e.g., oncology, behavioral health). Revenue cycle and utilization management teams require the diagnosis_id on eligibi',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Eligibility checks are initiated by specific facilities. Revenue cycle management, denial tracking, and payer contract performance reporting require knowing which org_provider initiated each eligibili',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Real-time eligibility verification at registration/scheduling validates patient benefits against specific health plan (not just payer). Deductible, copay, and network status are plan-specific. Removes',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Eligibility checks verify specific insurance coverage records. Currently eligibility_check links to payer and subscriber separately, but the authoritative coverage record is insurance_coverage. Adding',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Eligibility verification is routinely performed for lab orders requiring prior authorization. The eligibility_check already links to imaging_order and clinical_order but lacks a lab_order FK. Revenue ',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose insurance eligibility is being verified. Links to the Master Patient Index (MPI) and serves as the primary party reference for this transaction.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Eligibility verifications are often triggered by specific provider orders or referrals. Tracking the ordering clinician supports prior authorization workflows, audit trails for medical necessity, and ',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Insurance eligibility verification is a core step in the patient registration workflow. registration_event has eligibility_verified_flag and eligibility_verification_timestamp confirming that eligibil',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or scheduled appointment that triggered this eligibility verification. Nullable when verification is performed outside of a specific encounter context (e.g., batch eligibility runs).',
    `clearinghouse_name` STRING COMMENT 'The name of the EDI clearinghouse (e.g., Change Healthcare, Availity, Waystar) used to route the 270/271 eligibility transaction between the provider and the payer. Null for direct payer connections.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `coinsurance_percent` DECIMAL(18,2) COMMENT 'The percentage of covered service costs the patient is responsible for after the deductible is met, as confirmed in the eligibility response (e.g., 20.00 for a 20% patient coinsurance obligation).',
    `coordination_of_benefits_flag` BOOLEAN COMMENT 'Indicates whether the patient has multiple insurance coverages requiring Coordination of Benefits (COB) processing. True = secondary or tertiary payer exists and COB rules must be applied during claims adjudication.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The fixed copayment amount the patient is required to pay at the time of service for the applicable service type (e.g., office visit, specialist, ED), as confirmed in the eligibility response.',
    `coverage_type` STRING COMMENT 'Indicates the order of coverage for this payer relative to other payers the patient may have. primary = first-pay payer; secondary = pays after primary; tertiary = pays after secondary.. Valid values are `primary|secondary|tertiary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility check record was first created in the source system and ingested into the Silver layer. Supports audit trail and data lineage requirements.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` STRING COMMENT 'Flag indicating integration with digital health domain',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `family_deductible_amount` DECIMAL(18,2) COMMENT 'The annual family deductible amount for the patients insurance plan as confirmed in the eligibility response. Applicable when the patient is covered under a family plan.',
    `group_number` STRING COMMENT 'The insurance group number associated with the patients coverage plan, as returned in the payers eligibility response. Identifies the employer group or plan sponsor.',
    `individual_deductible_amount` DECIMAL(18,2) COMMENT 'The annual individual deductible amount for the patients insurance plan as confirmed in the eligibility response. Represents the amount the patient must pay out-of-pocket before insurance begins covering costs.',
    `individual_deductible_met_amount` DECIMAL(18,2) COMMENT 'The year-to-date amount of the individual deductible that the patient has already satisfied as of the verification date. Used to calculate remaining patient financial responsibility.',
    `individual_out_of_pocket_max` DECIMAL(18,2) COMMENT 'The annual individual out-of-pocket maximum (OOPM) for the patients plan as confirmed in the eligibility response. Once met, the insurer covers 100% of covered services for the remainder of the benefit year.',
    `individual_out_of_pocket_met` DECIMAL(18,2) COMMENT 'The year-to-date amount applied toward the patients individual out-of-pocket maximum as of the verification date. Used to determine remaining patient financial liability.',
    `is_override` BOOLEAN COMMENT 'Indicates whether the eligibility verification result was manually overridden by a staff member, superseding the automated payer response. True = result was overridden; False = result reflects the original payer response.',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) of the patient as used in the eligibility inquiry submitted to the payer. Captured here as it appeared in the transaction for audit and reconciliation purposes.',
    `network_status` STRING COMMENT 'Indicates whether the rendering provider or facility is in-network or out-of-network with the patients insurance plan, as confirmed in the eligibility response. Affects patient cost-sharing obligations.. Valid values are `in_network|out_of_network|unknown`',
    `override_reason` STRING COMMENT 'Free-text reason documented when a staff member manually overrides the eligibility verification result (e.g., patient confirmed coverage verbally, payer system outage). Supports audit trail for compliance.',
    `prior_auth_number` STRING COMMENT 'The prior authorization number issued by the payer for the specific service, if authorization has already been obtained at the time of eligibility verification. Null if no prior auth exists or is not yet required.',
    `prior_auth_required` BOOLEAN COMMENT 'Indicates whether the payer requires prior authorization (PA) for the service type being verified. True = prior authorization must be obtained before rendering service to avoid claim denial.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether the patients plan requires a referral from a Primary Care Physician (PCP) before the patient can receive specialist or ancillary services. Common for HMO and POS plan types.',
    `rejection_reason_code` STRING COMMENT 'The ASC X12 AAA reject reason code returned by the payer when the eligibility inquiry could not be processed (e.g., 15 = Required information missing, 72 = Invalid/missing subscriber/insured ID). Null when verification is successful.',
    `rejection_reason_description` STRING COMMENT 'Human-readable description of the rejection reason returned by the payer or clearinghouse when the eligibility inquiry failed. Supports staff workflow resolution and denial prevention.',
    `response_timestamp` TIMESTAMP COMMENT 'The exact date and time when the payer returned the eligibility response (271 transaction or portal/phone response). Used to calculate verification turnaround time for SLA monitoring.',
    `service_date` DATE COMMENT 'The date of service for which eligibility is being verified. May be the date of an upcoming appointment or the date of a completed encounter. Used to confirm coverage was active on the specific date of care.',
    `transaction_control_number` STRING COMMENT 'Unique control number assigned to the 270/271 EDI eligibility inquiry and response transaction set. Used for end-to-end transaction tracing and reconciliation with payer acknowledgments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility check record was last modified, such as when a manual override or correction was applied post-verification.',
    `verification_method` STRING COMMENT 'The method used to perform the eligibility verification. edi_270_271 = HIPAA-compliant EDI transaction; portal = payer web portal; phone = telephone inquiry; fax = fax-based verification; real_time_api = real-time API call (e.g., FHIR-based); batch = overnight batch eligibility run.. Valid values are `edi_270_271|portal|phone|fax|real_time_api|batch`',
    `verification_status` STRING COMMENT 'Current lifecycle status of the eligibility verification transaction as returned by the payer. active = patient is currently covered; inactive = coverage lapsed; pending = awaiting payer response; error = transaction failed; partial = incomplete response received; not_found = member not found in payer system.. Valid values are `active|inactive|pending|error|partial|not_found`',
    `verification_timestamp` TIMESTAMP COMMENT 'The exact date and time when the eligibility verification request was initiated and submitted to the payer. Serves as the principal business event timestamp for this transaction.',
    `verification_type` STRING COMMENT 'Indicates whether the eligibility check was performed in real-time at point of service, as part of a scheduled batch run (e.g., night-before appointment verification), or manually initiated by a staff member.. Valid values are `real_time|batch|manual|scheduled`',
    `verification_user` STRING COMMENT 'The verification user of the patient eligibility check record.',
    `verified_by_user` STRING COMMENT 'The username or staff identifier of the person who performed or confirmed the eligibility verification, applicable for manual or portal-based verifications. Null for fully automated EDI or batch verifications.',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient eligibility check record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient eligibility check record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient eligibility check record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient eligibility check record.',
    CONSTRAINT pk_eligibility_check PRIMARY KEY(`eligibility_check_id`)
) COMMENT 'Real-time and batch insurance eligibility verification transaction records capturing verification date and time, payer queried, verification method (270/271 EDI, portal, phone), eligibility status returned, coverage details confirmed, copay/deductible amounts verified, prior authorization requirements, and verification source system. Supports front-end RCM workflows and reduces claim denials. Sourced from Epic Resolute and Cerner Revenue Cycle eligibility modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`registration_event` (
    `registration_event_id` BIGINT COMMENT 'Unique surrogate identifier for each patient registration lifecycle event record in the Master Patient Index (MPI). Primary key for this product. Role: TRANSACTION_HEADER.',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to patient.demographics. Business justification: A registration event captures the patients demographic state at time of registration. Linking registration_event to demographics provides direct access to the patients demographic profile (language,',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Patient registration always occurs at a specific facility. CMS, state health departments, and internal admissions reporting require knowing which org_provider (hospital/clinic) performed the registrat',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to patient.guarantor. Business justification: During patient registration, the financial guarantor (the individual or entity responsible for the patients account balance) is identified and established. Linking registration_event to guarantor cap',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: ADT registration events capture plan-specific enrollment context at point of service for billing and eligibility. Business process: admit/transfer/discharge messages include plan details for claims su',
    `insurance_coverage_id` BIGINT COMMENT 'Reference to the patients primary insurance coverage record active at the time of this registration event. Used for eligibility verification, prior authorization, and revenue cycle management.',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Patient registration (ADT events) must link to the active member enrollment record to confirm coverage, assign financial class, and trigger eligibility verification. Epic/Cerner registration workflows',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: At patient registration (ADT event), a billing patient account is created or linked — this is the foundational revenue cycle workflow. Financial class assignment, insurance verification, and billing s',
    `clinician_id` BIGINT COMMENT 'Reference to the attending clinician assigned to the patient at the time of registration. Corresponds to HL7 PV1-7 Attending Doctor. Used for care team attribution and provider-level registration analytics.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient master record in the Master Patient Index (MPI) for whom this registration event was generated. Links every registration event to the canonical patient identity.',
    `tertiary_registration_pcp_provider_clinician_id` BIGINT COMMENT 'Reference to the patients designated Primary Care Physician (PCP) at the time of registration. Used for care coordination, referral authorization, and population health management.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Patient registration directly initiates or maps to a hospital visit record. Revenue cycle, compliance, and ADT reconciliation workflows require linking the registration event to its corresponding visi',
    `admission_type` STRING COMMENT 'Classifies the urgency and nature of the patients admission at registration. Aligns with UB-04 Form Locator 14 and CMS billing requirements. Drives DRG grouping and reimbursement logic.. Valid values are `elective|urgent|emergent|newborn|trauma`',
    `admit_reason` STRING COMMENT 'Free-text or coded description of the chief complaint or reason for the patients registration or admission at this event. Corresponds to HL7 PV2-3 Admit Reason. Supports clinical documentation and triage analytics.',
    `adt_message_type` STRING COMMENT 'The HL7 Admit Discharge Transfer (ADT) message type code that triggered or corresponds to this registration event (e.g., A01, A04, A08, A28, A31, A40). Provides direct traceability to the source HL7 message for interoperability and audit purposes.',
    `advance_directive_flag` BOOLEAN COMMENT 'Indicates whether the patient has an advance directive (e.g., living will, healthcare proxy, DNR order) on file at the time of this registration event. Required by the Patient Self-Determination Act and CMS Conditions of Participation.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `completeness_score` DECIMAL(18,2) COMMENT 'A numeric score (0.00–100.00) representing the percentage of required registration data fields that were populated at the time of this event. Used to identify incomplete registrations requiring follow-up and to measure registration quality across facilities and staff.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether the patients general consent for treatment was obtained and documented during this registration event. Required for HIPAA compliance and The Joint Commission accreditation standards.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this registration event record was first created in the data platform. Serves as the record audit creation timestamp for data lineage, SLA monitoring, and ETL reconciliation.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` STRING COMMENT 'Flag indicating integration with digital health domain',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `discharge_disposition` STRING COMMENT 'The patients discharge disposition code at the time of a discharge-related registration update event (e.g., home, skilled nursing facility, expired, AMA). Corresponds to UB-04 Form Locator 17 and HL7 PV1-36. Null for non-discharge events. [ENUM-REF-CANDIDATE: home|snf|rehab|expired|ama|transfer|hospice|ltac — promote to reference product]',
    `drg_code` STRING COMMENT 'The preliminary Diagnosis-Related Group (DRG) code assigned at registration based on the anticipated principal diagnosis and procedure. Used for prospective payment estimation and case mix index (CMI) tracking. May be updated at discharge.',
    `duplicate_flag` BOOLEAN COMMENT 'Indicates whether this registration event was identified as a potential duplicate patient record in the Master Patient Index (MPI). Triggers MPI duplicate review and merge workflow. Critical for patient safety and data integrity.',
    `eligibility_verification_timestamp` TIMESTAMP COMMENT 'The date and time at which insurance eligibility was electronically verified for this registration event. Used for revenue cycle audit trails and payer dispute resolution.',
    `eligibility_verified_flag` BOOLEAN COMMENT 'Indicates whether the patients insurance eligibility was verified in real-time during this registration event via electronic eligibility transaction (HIPAA 270/271). Supports revenue cycle management and denial prevention.',
    `enterprise_mrn` STRING COMMENT 'The enterprise-wide Medical Record Number assigned by the Master Patient Index (MPI) that persists across all facilities and registration events for a single patient identity. Distinct from facility-level MRN.',
    `event_status` STRING COMMENT 'Current workflow status of the registration event. Completed indicates the event was fully processed and committed to the MPI. Pending indicates the event is awaiting verification or approval. Failed indicates a system or validation error prevented completion.. Valid values are `completed|pending|cancelled|failed|in_progress`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the registration event occurred in the source system. Represents the real-world business event time, not the record audit timestamp. Used for MPI audit trail sequencing and regulatory reporting.',
    `event_type` STRING COMMENT 'Classifies the type of registration lifecycle event: new_registration (first-time patient identity creation), pre_registration (advance registration before arrival), update (demographic or insurance data change), merge (two patient records combined in MPI), unmerge (previously merged records separated). Drives MPI audit trail logic.. Valid values are `new_registration|pre_registration|update|merge|unmerge`',
    `expected_los_days` DECIMAL(18,2) COMMENT 'The anticipated Length of Stay (LOS) in days estimated at the time of registration or admission. Used for bed management, discharge planning, and case management workflows. Supports Average Length of Stay (ALOS) benchmarking.',
    `financial_class` STRING COMMENT 'The patients financial classification at the time of registration, indicating the primary payer category (e.g., Medicare, Medicaid, Commercial, Self-Pay, Charity). Drives revenue cycle routing, eligibility verification, and billing workflows. [ENUM-REF-CANDIDATE: medicare|medicaid|commercial|self_pay|charity|workers_comp|tricare — promote to reference product]',
    `hipaa_notice_delivered_flag` BOOLEAN COMMENT 'Indicates whether the HIPAA Notice of Privacy Practices (NPP) was delivered to the patient during this registration event, as required by the HIPAA Privacy Rule. Supports OCR audit readiness.',
    `identity_verification_method` STRING COMMENT 'The method used to verify the patients identity at the time of registration. Options include government-issued photo ID, insurance card, biometric scan, passport, self-reported (no verification), or none. Critical for fraud prevention, HIPAA compliance, and MPI accuracy.. Valid values are `photo_id|insurance_card|biometric|passport|none|self_reported`',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether the patient requires interpreter services at the time of this registration event. Triggers interpreter scheduling workflows and ensures compliance with Section 1557 of the Affordable Care Act language access requirements.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this registration event record is the current active version in the silver layer. Set to False for records superseded by subsequent updates, merges, or corrections. Supports slowly changing dimension (SCD) pattern for MPI history.',
    `language_preference` STRING COMMENT 'The patients preferred spoken or written language for communication, captured at registration. Drives interpreter services requests and language-concordant care delivery. Stored as ISO 639-1 two-letter language code (e.g., en, es, zh).',
    `mpi_match_score` DECIMAL(18,2) COMMENT 'The probabilistic match score (0.00–100.00) assigned by the MPI algorithm when this registration event was processed, indicating the confidence level of patient identity matching. Scores above threshold trigger auto-merge; scores in range trigger manual review.',
    `mpi_match_status` STRING COMMENT 'The outcome of the MPI identity matching process for this registration event. Indicates whether the patient was identified as a new patient, automatically matched to an existing record, flagged for manual review, automatically merged, or returned no match.. Valid values are `new_patient|auto_matched|manual_review|auto_merged|no_match`',
    `mrn` STRING COMMENT 'The Medical Record Number assigned to the patient at the registering facility at the time of this event. Serves as the facility-level patient identifier within the Electronic Health Record (EHR). May differ across facilities before MPI merge resolution.',
    `patient_class` STRING COMMENT 'The patient classification at the time of this registration event, indicating the intended care setting. Aligns with HL7 PV1-2 Patient Class field. Drives billing, bed management, and regulatory reporting logic.. Valid values are `inpatient|outpatient|emergency|observation|recurring|preadmit`',
    `point_of_care` STRING COMMENT 'The specific unit, department, or care area within the facility where the patient was registered (e.g., Emergency Department, ICU, Outpatient Clinic). Corresponds to HL7 PV1-3 Assigned Patient Location. Used for capacity and throughput analytics.',
    `pre_authorization_number` STRING COMMENT 'The prior authorization number obtained from the payer at the time of registration for planned services. Required for revenue cycle management and claim adjudication. Null if no prior authorization was required or obtained.',
    `prior_mrn` STRING COMMENT 'The Medical Record Number of the patient record that was merged or unmerged in this event. Preserved for MPI audit trail and downstream system reconciliation. Null for non-merge events.',
    `registration_date` DATE COMMENT 'The calendar date on which the patient registration event was initiated. Used for day-level reporting, scheduling, and operational analytics distinct from the precise event timestamp.',
    `registration_source` STRING COMMENT 'The channel or pathway through which the patient registration was initiated. Examples include Emergency Department (ED) walk-in, scheduled appointment, inpatient transfer, online pre-registration portal, referral, or direct admission. Supports operational throughput and access analytics. [ENUM-REF-CANDIDATE: ed_walk_in|scheduled|transfer|online_pre_registration|referral|direct_admit — promote to reference product]. Valid values are `ed_walk_in|scheduled|transfer|online_pre_registration|referral|direct_admit`',
    `restricted_record_flag` BOOLEAN COMMENT 'Indicates whether this patients record has been flagged for restricted access beyond standard role-based controls (e.g., sensitive diagnoses, employee patient, domestic violence victim). Enforces HIPAA minimum necessary and break-the-glass access policies.',
    `source_system_event_code` STRING COMMENT 'The native identifier of this registration event in the originating source system (e.g., Epic ADT event ID, Cerner encounter number). Enables bidirectional traceability between the lakehouse silver layer and the operational EHR system.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this registration event record was last modified in the data platform. Used for change data capture, incremental ETL processing, and audit trail maintenance.',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient registration event record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient registration event record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient registration event record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient registration event record.',
    `vip_flag` BOOLEAN COMMENT 'Indicates whether the patient has been designated as a VIP (e.g., public figure, employee, board member) requiring enhanced privacy protections and special handling during registration and care delivery. Restricts access to PHI per HIPAA minimum necessary standard.',
    CONSTRAINT pk_registration_event PRIMARY KEY(`registration_event_id`)
) COMMENT 'Patient registration lifecycle event records capturing event type (new registration, pre-registration, update, merge, unmerge), registration date and time, registering facility, registration source (ED walk-in, scheduled, transfer, online pre-registration), registration completeness score, identity verification method (photo ID, insurance card, biometric), and registration staff. Provides the audit trail for patient identity creation and maintenance events within the MPI lifecycle. Distinct from encounter-level ADT events — this product tracks identity/registration events, not clinical visit movements. Sourced from EHR ADT and registration modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`portal_account` (
    `portal_account_id` BIGINT COMMENT 'Unique surrogate identifier for the patient portal account record. Primary key for the portal_account data product. Role classification: MASTER_AGREEMENT — represents a long-running digital engagement relationship between a patient and the healthcare organizations portal platform.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient master record who owns this portal account. Links the digital engagement account to the patients identity in the Master Patient Index (MPI). Every portal account must be associated with exactly one patient.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Patient portal accounts require a direct enterprise identity link to the MPI for identity resolution, duplicate detection, and cross-facility patient matching. While portal_account already links to de',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Enterprise patient portals are hosted and managed by specific health systems or facilities (org_providers). Patient engagement reporting, portal adoption metrics, and facility-level digital health ini',
    `account_status` STRING COMMENT 'Current lifecycle status of the patient portal account. Drives access control, engagement workflows, and MIPS Promoting Interoperability reporting. pending_activation indicates account created but not yet activated by patient. locked indicates temporary security lockout. Satisfies MASTER_AGREEMENT LIFECYCLE_STATUS category.. Valid values are `active|inactive|suspended|pending_activation|locked|deactivated`',
    `account_type` STRING COMMENT 'Classification of the portal account indicating whether it is a direct patient account, a proxy account (parent, guardian, caregiver, healthcare POA), or a shared account. Determines applicable access rules and HIPAA authorization requirements. Satisfies MASTER_AGREEMENT CLASSIFICATION_OR_TYPE category.. Valid values are `patient|proxy|shared`',
    `activation_date` DATE COMMENT 'Calendar date on which the patient first activated and verified their portal account. Distinct from created_date — an account may be created by staff but not activated by the patient until later. Key metric for digital front door strategy and patient engagement KPIs.',
    `activation_method` STRING COMMENT 'Method by which the patient portal account was activated. Supports analysis of activation channel effectiveness for digital front door strategy and patient engagement programs.. Valid values are `staff_assisted|self_service|kiosk|mail|email_invite|sms_invite`',
    `app_link_date` DATE COMMENT 'Date on which the patient first linked a third-party digital health application to their portal account. Used for interoperability adoption tracking and CMS Promoting Interoperability reporting.',
    `appointment_scheduling_enabled` BOOLEAN COMMENT 'Indicates whether the patient has been enabled for self-service appointment scheduling through the portal. Supports digital front door strategy, patient access analytics, and operational capacity planning.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `created_date` DATE COMMENT 'Calendar date on which the portal account was first created in the portal platform. Used for cohort analysis, onboarding funnel reporting, and MIPS Promoting Interoperability measure denominators. Satisfies MASTER_AGREEMENT EFFECTIVE_FROM category.',
    `created_timestamp` TIMESTAMP COMMENT 'Precise date and time when this portal account record was first created in the lakehouse silver layer. Supports data lineage, audit trail, and ETL processing controls. Satisfies MASTER_AGREEMENT record audit created category.',
    `deactivation_date` DATE COMMENT 'Calendar date on which the portal account was deactivated or terminated. Null for currently active accounts. Used for access revocation auditing and HIPAA compliance reporting. Satisfies MASTER_AGREEMENT EFFECTIVE_UNTIL category.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_app_linked` BOOLEAN COMMENT 'Indicates whether the patient has linked one or more third-party digital health applications (e.g., Apple Health, Google Fit, wearable device apps) to their portal account via FHIR API. Supports CMS Interoperability Final Rule compliance and patient-generated health data ingestion.',
    `digital_health_integration_marker` STRING COMMENT 'Flag indicating integration with digital health domain',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `identity_verification_method` STRING COMMENT 'Method used to verify the patients identity during portal account setup. Supports NIST identity assurance level classification and HIPAA security rule compliance for user authentication.. Valid values are `in_person|online_proofing|government_id|knowledge_based|staff_verified|none`',
    `identity_verified_date` DATE COMMENT 'Date on which the patients identity was formally verified. Supports audit trail requirements and periodic re-verification workflows per NIST identity assurance standards.',
    `identity_verified_flag` BOOLEAN COMMENT 'Indicates whether the patients identity has been formally verified during portal account setup (e.g., via in-person verification, identity proofing service, or government ID check). Supports NIST identity assurance level requirements and HIPAA access control.',
    `last_login_date` DATE COMMENT 'Most recent calendar date on which the patient successfully authenticated and logged into the portal. Used for patient engagement analytics, dormant account identification, and MIPS Promoting Interoperability active patient measures.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Precise date and time of the most recent successful patient authentication to the portal. Provides granular session tracking for security auditing and HIPAA access log compliance beyond the date-level last_login_date.',
    `login_failure_count` STRING COMMENT 'Number of consecutive failed authentication attempts since the last successful login. Used to trigger account lockout policies per HIPAA security rule requirements and NIST password management guidelines.',
    `messaging_opt_in` BOOLEAN COMMENT 'Indicates whether the patient has opted in to receive secure portal messages from care team members. Supports patient engagement workflows, care coordination, and MIPS Promoting Interoperability secure messaging measures.',
    `notification_email` STRING COMMENT 'Email address used for portal notification delivery. May differ from the patients primary contact email on file. Used for account activation links, secure message alerts, appointment reminders, and test result notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `notification_mobile_phone` STRING COMMENT 'Mobile phone number used for SMS-based portal notifications and two-factor authentication. May differ from the patients primary contact phone on file. Subject to TCPA consent requirements.',
    `notification_preference` STRING COMMENT 'Patients preferred channel for receiving portal notifications (e.g., new messages, appointment reminders, test results). Drives outbound communication workflows and patient engagement strategy.. Valid values are `email|sms|push|in_portal|none`',
    `portal_account_number` STRING COMMENT 'Externally-known unique alphanumeric identifier assigned to the portal account by the portal platform (e.g., Epic MyChart account number, Cerner HealtheLife account ID). Used for cross-system reconciliation and patient-facing reference. Satisfies MASTER_AGREEMENT BUSINESS_IDENTIFIER category.',
    `portal_platform` STRING COMMENT 'Name of the patient portal platform hosting this account (e.g., Epic MyChart, Cerner HealtheLife). Identifies the source system for digital engagement and determines applicable integration patterns for FHIR-based data exchange.. Valid values are `MyChart|HealtheLife|FollowMyHealth|Healow|PatientFusion|Other`',
    `proxy_access_flag` BOOLEAN COMMENT 'Indicates whether this portal account has been granted proxy access to another patients health record (e.g., parent accessing a minor childs record, adult caregiver accessing an elderly patients record). When true, proxy-specific fields are populated.',
    `proxy_access_level` STRING COMMENT 'Scope of access granted to the proxy account holder. full allows all portal functions including messaging and scheduling; limited restricts to specific record sections; view_only allows read-only access to designated information. Enforces HIPAA minimum necessary standard.. Valid values are `full|limited|view_only`',
    `proxy_authorization_date` DATE COMMENT 'Date on which proxy access was formally authorized and granted. Establishes the start of the proxy access period for audit and compliance purposes.',
    `proxy_date_of_birth` DATE COMMENT 'Date of birth of the proxy account holder. Used for identity verification during proxy access setup and to confirm the proxy is a legal adult where required (e.g., adult caregiver, healthcare POA).',
    `proxy_expiration_date` DATE COMMENT 'Date on which the proxy access authorization expires. Null for indefinite authorizations. System should automatically revoke access on this date. Critical for HIPAA compliance and time-limited proxy arrangements (e.g., temporary caregiver).',
    `proxy_first_name` STRING COMMENT 'First (given) name of the proxy account holder who has been granted access to the patients portal record. Required for identity verification and HIPAA-compliant proxy access management.',
    `proxy_last_name` STRING COMMENT 'Last (family) name of the proxy account holder who has been granted access to the patients portal record. Required for identity verification and HIPAA-compliant proxy access management.',
    `proxy_legal_document_reference` STRING COMMENT 'Reference identifier or URL to the supporting legal documentation (e.g., court order number, POA document ID, scanned document storage path) that authorizes the proxy access. Supports HIPAA audit and legal compliance.',
    `proxy_legal_document_type` STRING COMMENT 'Type of legal documentation supporting the proxy access authorization. Required for healthcare POA and legal guardian proxy relationships. Supports HIPAA compliance and legal defensibility of proxy access grants.. Valid values are `court_order|power_of_attorney|guardianship_decree|parental_consent|advance_directive|other`',
    `proxy_relationship_type` STRING COMMENT 'Type of relationship between the proxy account holder and the patient whose record is being accessed. Determines applicable HIPAA authorization requirements and access scope. Aligned with HL7 FHIR RelatedPerson.relationship value set.. Valid values are `parent|legal_guardian|adult_caregiver|healthcare_poa|spouse|other`',
    `proxy_revocation_date` DATE COMMENT 'Date on which proxy access was explicitly revoked before its natural expiration. Null if access was not revoked early. Supports HIPAA audit trail requirements for access termination events.',
    `proxy_revocation_reason` STRING COMMENT 'Reason code for early revocation of proxy access. Supports compliance auditing and legal documentation requirements. age_of_majority applies when a minor patient reaches adulthood and proxy parental access is automatically terminated.. Valid values are `patient_request|guardian_change|legal_order|deceased|age_of_majority|administrative`',
    `rx_renewal_request_enabled` BOOLEAN COMMENT 'Indicates whether the patient is enabled to submit prescription renewal requests through the portal. Supports pharmacy engagement workflows and MIPS Promoting Interoperability measures for patient-generated health data.',
    `source_system_account_code` STRING COMMENT 'Native account identifier from the originating portal system (e.g., Epic MyChart internal account ID, Cerner HealtheLife user GUID). Enables bidirectional reconciliation between the lakehouse silver layer and the operational system of record.',
    `terms_accepted_date` DATE COMMENT 'Date on which the patient accepted the portal terms of use and privacy notice. Supports HIPAA Notice of Privacy Practices compliance documentation and legal audit trail.',
    `terms_accepted_flag` BOOLEAN COMMENT 'Indicates whether the patient has accepted the portal terms of use and privacy notice. Required for account activation. Supports HIPAA Notice of Privacy Practices acknowledgment tracking.',
    `terms_version` STRING COMMENT 'Version identifier of the portal terms of use and privacy notice that the patient accepted. Enables tracking of re-consent requirements when terms are updated, supporting HIPAA Notice of Privacy Practices compliance.',
    `test_result_notification_enabled` BOOLEAN COMMENT 'Indicates whether the patient has enabled portal notifications for new laboratory or radiology test results. Supports patient engagement, timely result delivery, and 21st Century Cures Act information blocking compliance.',
    `two_factor_auth_enrolled` BOOLEAN COMMENT 'Indicates whether the patient has enrolled in two-factor authentication (2FA) for portal access. Supports HIPAA security rule compliance, NIST identity assurance level requirements, and organizational security policy enforcement.',
    `two_factor_auth_method` STRING COMMENT 'The specific method used for two-factor authentication when enrolled. Supports security posture analysis and patient experience optimization for authentication workflows.. Valid values are `sms|email|authenticator_app|hardware_token|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Precise date and time when this portal account record was last modified in the lakehouse silver layer. Supports change data capture, incremental ETL processing, and audit trail requirements.',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient portal account record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient portal account record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient portal account record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient portal account record.',
    CONSTRAINT pk_portal_account PRIMARY KEY(`portal_account_id`)
) COMMENT 'Patient portal and digital engagement account record capturing portal platform, account creation date, activation status, last login date, two-factor authentication enrollment, proxy access grants (parent/guardian, adult caregiver, legal guardian, healthcare POA) with proxy identity, access levels (full, limited, view-only), authorization and expiration dates, revocation dates, supporting legal documentation references, messaging opt-in status, appointment self-scheduling enablement, and digital health app linkages. SSOT for patient digital engagement and proxy access management. Supports patient engagement, HIPAA-compliant proxy access, MIPS Promoting Interoperability measures, and digital front door strategy. Aligned with HL7 FHIR RelatedPerson resource for proxy relationships. Sourced from patient portal and proxy management systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` (
    `consent_reference_id` BIGINT COMMENT 'Unique identifier for the consent reference record. Primary key.',
    `demographics_id` BIGINT COMMENT 'Demographics FK',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: HIPAA and state consent regulations require audit trails identifying which facility obtained patient consent. Compliance reporting, consent management workflows, and legal/regulatory audits depend on ',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Informed consent for contrast administration, sedation, and invasive radiology procedures must be linked to the specific imaging order for regulatory compliance and pre-procedure verification. Radiolo',
    `mpi_record_id` BIGINT COMMENT 'Foreign key reference to the patient who has provided consent. Links to the patient domain SSOT.',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider who obtained or witnessed the consent from the patient.',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Consent records are frequently obtained during patient registration events (HIPAA notice delivery, advance directive collection, consent_obtained_flag on registration_event confirms this pattern). Lin',
    `superseded_consent_reference_id` BIGINT COMMENT 'Self-referencing FK on consent_reference (superseded_consent_reference_id)',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the encounter during which the consent was obtained. Null if consent was obtained outside of a specific encounter context.',
    `audit_trail_flag` BOOLEAN COMMENT 'Indicates whether a detailed audit trail exists for this consent reference in the consent domain SSOT. True if audit trail is available, False otherwise.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `consent_date` DATE COMMENT 'Timestamp capturing the consent date associated with the patient consent reference record.',
    `consent_effective_date` DATE COMMENT 'The date when the consent becomes effective and enforceable. Denormalized from consent master for quick filtering and reporting.',
    `consent_expiration_date` DATE COMMENT 'The date when the consent expires and is no longer valid. Null if the consent has no expiration. Denormalized from consent master for quick filtering.',
    `consent_method` STRING COMMENT 'The method by which the consent was obtained from the patient (e.g., written signature, verbal acknowledgment, electronic signature via patient portal, implied consent).. Valid values are `written|verbal|electronic|implied`',
    `consent_obtained_date` DATE COMMENT 'The date when the consent was originally obtained from the patient or their authorized representative.',
    `consent_revocation_date` DATE COMMENT 'The date when the patient revoked their consent. Null if the consent has not been revoked.',
    `consent_scope` STRING COMMENT 'Textual description of the scope or boundaries of the consent. Describes what specific activities, data types, or purposes are covered by this consent.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent reference. Indicates whether the consent is currently active, has been revoked by the patient, has expired, is pending approval, or has been superseded by a newer consent.. Valid values are `active|revoked|expired|pending|superseded`',
    `consent_type` STRING COMMENT 'The category of consent being referenced. Indicates the purpose or scope of the consent (e.g., treatment, research participation, marketing communications, PHI disclosure, HIE participation, telehealth services).. Valid values are `treatment|research|marketing|phi_disclosure|hie_participation|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent reference record was first created in the system. Used for audit trail and data lineage.',
    `digital_health_added_flag` BOOLEAN COMMENT 'Flag added by digital health batch',
    `digital_health_integration_marker` STRING COMMENT 'Flag indicating integration with digital health domain',
    `digital_health_note` STRING COMMENT 'Marker added for digital health integration',
    `document_reference_number` STRING COMMENT 'Reference identifier to the physical or electronic consent document stored in the document management system. Enables retrieval of the original signed consent form.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the patient consent reference record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the patient consent reference record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the patient consent reference record.',
    `enterprise_mrn` STRING COMMENT 'The enterprise-wide Medical Record Number for the patient across all facilities. Denormalized for quick reference.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the patient consent reference record.',
    `external_consent_code` STRING COMMENT 'External consent ID',
    `guardian_name` STRING COMMENT 'Full name of the legal guardian or authorized representative who provided consent on behalf of the patient. Null if patient provided consent directly.',
    `guardian_relationship` STRING COMMENT 'The relationship of the guardian or authorized representative to the patient (e.g., parent, spouse, healthcare proxy, power of attorney).',
    `hie_participation_flag` BOOLEAN COMMENT 'Indicates whether the patient has consented to participate in Health Information Exchange networks for sharing their medical records across organizations. True if HIE participation is authorized, False otherwise.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used during the consent process. True if an interpreter was present, False otherwise.',
    `language_of_consent` STRING COMMENT 'The language in which the consent was presented to and obtained from the patient. Important for compliance with language access requirements.',
    `legal_guardian_flag` BOOLEAN COMMENT 'Indicates whether the consent was provided by a legal guardian or authorized representative rather than the patient directly. True if guardian provided consent, False if patient provided consent.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the patient has opted in to receive marketing communications. True if patient opted in, False otherwise.',
    `mrn` STRING COMMENT 'The facility-specific Medical Record Number for the patient. Denormalized for quick reference and cross-system reconciliation.',
    `phi_disclosure_authorized_flag` BOOLEAN COMMENT 'Indicates whether this consent authorizes disclosure of Protected Health Information to third parties. True if PHI disclosure is authorized, False otherwise.',
    `record_reference` BIGINT COMMENT 'Foreign key reference to the consent master record in the consent domain SSOT. Enables cross-domain joins to full consent details.',
    `reference_priority` STRING COMMENT 'Priority order of this consent reference when multiple consents of the same type exist for a patient. Lower numbers indicate higher priority. Used for determining which consent applies in conflict scenarios.',
    `research_participation_flag` BOOLEAN COMMENT 'Indicates whether this consent includes authorization for the patient to participate in research studies. True if research participation is authorized, False otherwise.',
    `revocation_date` DATE COMMENT 'Timestamp capturing the revocation date associated with the patient consent reference record.',
    `scope` STRING COMMENT 'The scope of the patient consent reference record.',
    `source_system_reference_code` STRING COMMENT 'The unique identifier for this consent reference record in the source system. Used for data lineage and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent reference record was last updated. Used for audit trail and change tracking.',
    `verification_status` STRING COMMENT 'Indicates whether the consent reference has been verified for accuracy and completeness by authorized staff. Used for quality assurance and compliance auditing.. Valid values are `verified|unverified|pending_verification`',
    `verified_timestamp` TIMESTAMP COMMENT 'The date and time when this consent reference record was verified. Null if not yet verified.',
    `vibe_added_flag` BOOLEAN COMMENT 'Marker added by VIBE batch to ensure touch',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the patient consent reference record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE batch to indicate mutation applied.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the patient consent reference record.',
    `vibe_new_flag` BOOLEAN COMMENT 'The vibe new flag of the patient consent reference record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the patient consent reference record.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this consent based on regulatory or organizational policy. True if witness was required, False otherwise.',
    CONSTRAINT pk_consent_reference PRIMARY KEY(`consent_reference_id`)
) COMMENT 'Lightweight reference record linking a patient to their consent records in the consent domain SSOT. Captures patient_id and consent_master_id FK for cross-domain joins.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ADD CONSTRAINT `fk_patient_mpi_record_surviving_mpi_record_id` FOREIGN KEY (`surviving_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ADD CONSTRAINT `fk_patient_demographics_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ADD CONSTRAINT `fk_patient_address_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ADD CONSTRAINT `fk_patient_guarantor_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ADD CONSTRAINT `fk_patient_emergency_contact_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_registration_event_id` FOREIGN KEY (`registration_event_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`registration_event`(`registration_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ADD CONSTRAINT `fk_patient_portal_account_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ADD CONSTRAINT `fk_patient_portal_account_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_registration_event_id` FOREIGN KEY (`registration_event_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`registration_event`(`registration_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_superseded_consent_reference_id` FOREIGN KEY (`superseded_consent_reference_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`consent_reference`(`consent_reference_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`patient` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`patient` SET TAGS ('dbx_domain' = 'patient');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Patient Index (MPI) Record ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `surviving_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Surviving MPI Record ID (Post-Merge)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'MPI Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth (DOB)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_type' = 'date_of_birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Death');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_pii_type' = 'date_of_birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `date_of_death` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `deceased_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Deceased Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('dbx_value_regex' = '^EP-[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('dbx_pii_type' = 'national_id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `enterprise_patient_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Ethnicity Code (OMB)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_value_regex' = '2135-2|2186-5|UNK');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_type' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_sensitive' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `first_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Patient First Registration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender Identity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_type' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_sensitive' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `hie_patient_number` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `hie_patient_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `hie_patient_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `hie_patient_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `hie_patient_number` SET TAGS ('dbx_pii_type' = 'national_id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `hie_patient_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `identity_confidence_tier` SET TAGS ('dbx_business_glossary_term' = 'MPI Identity Confidence Tier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `identity_confidence_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|unverified');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `identity_confidence_tier` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `identity_confidence_tier` SET TAGS ('dbx_phi_type' = 'health_status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `identity_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'MPI Identity Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `identity_resolution_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `identity_resolution_status` SET TAGS ('dbx_phi_type' = 'health_status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `is_duplicate_flag` SET TAGS ('dbx_business_glossary_term' = 'MPI Duplicate Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `is_overlay_flag` SET TAGS ('dbx_business_glossary_term' = 'MPI Overlay Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'MPI Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Identity Last Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Legal First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Legal Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'MPI Identity Match Confidence Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_phi_type' = 'health_status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Recipient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_type' = 'national_id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_value_regex' = '^[1-9][AC-HJ-NP-RT-Y][AC-HJ-NP-RT-Y0-9][0-9][AC-HJ-NP-RT-Y][AC-HJ-NP-RT-Y0-9][0-9][AC-HJ-NP-RT-Y]{2}[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_pii_type' = 'national_id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `merge_algorithm` SET TAGS ('dbx_business_glossary_term' = 'MPI Merge Algorithm Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `merge_reason` SET TAGS ('dbx_business_glossary_term' = 'MPI Merge Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `merge_reason` SET TAGS ('dbx_value_regex' = 'algorithmic_match|manual_review|adt_event|hie_linkage|patient_request|clerical_correction');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `merge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'MPI Record Merge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `middle_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_status` SET TAGS ('dbx_business_glossary_term' = 'MPI Record Lifecycle Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|deceased|test|blocked');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mpi_record_status` SET TAGS ('dbx_phi_type' = 'health_status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_type' = 'national_id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_business_glossary_term' = 'Patient Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_value_regex' = 'Jr.|Sr.|II|III|IV|Esq.');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `name_suffix` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_business_glossary_term' = 'National Health Identifier Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_value_regex' = 'NHS_NUMBER|EHIC|MEDICAID_ID|MEDICARE_BENE_ID|OTHER');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_id_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_business_glossary_term' = 'National Health Identifier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_pii_type' = 'national_id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `national_health_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('dbx_business_glossary_term' = 'MRN Crosswalk Facility Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `npi_crosswalk_count` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Classification');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Preferred Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `preferred_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Primary Language Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Race Code (OMB)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('dbx_pii_type' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `race_code` SET TAGS ('dbx_pii_sensitive' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `restricted_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Access Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `restricted_access_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `restricted_access_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `restricted_access_flag` SET TAGS ('dbx_phi_type' = 'access_control');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_business_glossary_term' = 'Patient Sex at Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_value_regex' = 'M|F|X|U');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_pii_type' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'MPI Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN) Last 4 Digits');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_type' = 'national_id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `unmerge_reason` SET TAGS ('dbx_business_glossary_term' = 'MPI Record Unmerge Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `unmerge_reason` SET TAGS ('dbx_value_regex' = 'overlay_correction|erroneous_merge|patient_dispute|clerical_error|hie_discrepancy');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `unmerge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'MPI Record Unmerge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `vip_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `vip_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ALTER COLUMN `vip_flag` SET TAGS ('dbx_pii_type' = 'special_handling');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `advance_directive_on_file` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive on File Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_time` SET TAGS ('dbx_business_glossary_term' = 'Time of Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_time` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `birth_time` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `census_tract` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}(.[0-9]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `census_tract` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Cause of Death Code (ICD-10)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Death Certificate Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_certificate_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Death');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `death_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `deceased_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deceased Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `email_address` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Medical Record Number (Enterprise MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_value_regex' = '2135-2|2186-5|UNK');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_sensitive' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_sensitive' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Home Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Home Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_business_glossary_term' = 'Home City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_country_code` SET TAGS ('dbx_business_glossary_term' = 'Home Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Home Postal Code (ZIP Code)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_business_glossary_term' = 'Home State');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `home_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `interpreter_required` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name (Given Name)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name (Family Name)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Same as Home Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_address_same_as_home` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code (ZIP Code)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_business_glossary_term' = 'Mailing State');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mailing_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `middle_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('dbx_value_regex' = 'Jr.|Sr.|II|III|IV|Esq.');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `name_suffix` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `patient_portal_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Patient Portal Enrolled Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code (ISO 639)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `preferred_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-()s]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_value_regex' = 'home|mobile|work|other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `pronouns` SET TAGS ('dbx_business_glossary_term' = 'Preferred Pronouns');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `pronouns` SET TAGS ('dbx_value_regex' = 'he/him|she/her|they/them|ze/zir|other|unknown');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `pronouns` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `pronouns` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('dbx_business_glossary_term' = 'Race Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_code` SET TAGS ('dbx_pii_sensitive' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_description` SET TAGS ('dbx_business_glossary_term' = 'Race Description');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `race_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|deceased|test');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `religion_code` SET TAGS ('dbx_business_glossary_term' = 'Religion Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `religion_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `religion_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Food Insecurity Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sdoh_food_insecurity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sdoh_housing_status` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Housing Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sdoh_housing_status` SET TAGS ('dbx_value_regex' = 'stable|unstable|homeless|temporary|unknown');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sdoh_housing_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sdoh_housing_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_business_glossary_term' = 'Sex Assigned at Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_value_regex' = 'M|F|X|U');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number Last 4 Digits (SSN Last 4)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `ssn_last4` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `vip_indicator` SET TAGS ('dbx_business_glossary_term' = 'VIP Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ALTER COLUMN `vip_indicator` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|undeliverable|returned_mail');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|mailing|temporary|work|billing|guarantor');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `area_deprivation_index` SET TAGS ('dbx_business_glossary_term' = 'Area Deprivation Index (ADI)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_unity_catalog_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_classification' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_business_glossary_term' = 'County Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_value_regex' = '^d{5}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_timestamp` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_timestamp` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_timestamp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_integration_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_marker` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `district` SET TAGS ('dbx_business_glossary_term' = 'District');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `district` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `do_not_contact_reason` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `do_not_contact_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `do_not_contact_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `do_not_contact_reason` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('dbx_business_glossary_term' = 'Geocode Precision Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('dbx_value_regex' = 'rooftop|range_interpolated|geometric_center|approximate|ungeocoded');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `geocode_precision` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('dbx_business_glossary_term' = 'Health Service Area (HSA)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `health_service_area` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `housing_type` SET TAGS ('dbx_business_glossary_term' = 'Housing Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `housing_type` SET TAGS ('dbx_value_regex' = 'owned|rented|shelter|transitional|group_home|unhoused');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `housing_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `housing_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `housing_type` SET TAGS ('dbx_pii_classification' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Address Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `is_do_not_mail` SET TAGS ('dbx_business_glossary_term' = 'Do Not Mail Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Indicator');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_unity_catalog_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_classification' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_unity_catalog_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_classification' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_unity_catalog_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_classification' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_unity_catalog_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_classification' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `move_in_date` SET TAGS ('dbx_business_glossary_term' = 'Move-In Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `move_out_date` SET TAGS ('dbx_business_glossary_term' = 'Move-Out Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `mutator_added_flag` SET TAGS ('dbx_added_by_mutator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `ncoa_match_code` SET TAGS ('dbx_business_glossary_term' = 'National Change of Address (NCOA) Match Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `ncoa_update_date` SET TAGS ('dbx_business_glossary_term' = 'National Change of Address (NCOA) Update Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP Code)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('dbx_unity_catalog_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `preferred_language` SET TAGS ('dbx_pii_classification' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_housing_instability_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Housing Instability Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_housing_instability_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_housing_instability_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_housing_instability_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_housing_instability_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `sdoh_housing_instability_flag` SET TAGS ('dbx_pii_classification' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Address ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `urban_rural_classification` SET TAGS ('dbx_business_glossary_term' = 'Urban Rural Classification');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `urban_rural_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|frontier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|invalid|corrected|pending');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` SET TAGS ('dbx_subdomain' = 'financial_responsibility');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `benefit_year_end` SET TAGS ('dbx_business_glossary_term' = 'Benefit Year End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `benefit_year_start` SET TAGS ('dbx_business_glossary_term' = 'Benefit Year Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `cob_priority` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Priority');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Rate');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `copay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_response_code` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Response Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_value_regex' = 'EDI_270_271|portal|phone|manual|real_time_API');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|failed|not_eligible');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verified_by` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verified By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `eligibility_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `group_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_back_url` SET TAGS ('dbx_business_glossary_term' = 'Insurance Card Back Image URL');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_back_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_front_url` SET TAGS ('dbx_business_glossary_term' = 'Insurance Card Front Image URL');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `insurance_card_front_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('dbx_business_glossary_term' = 'Medicaid State Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicaid_state_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicare_part` SET TAGS ('dbx_business_glossary_term' = 'Medicare Part');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `medicare_part` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|unknown');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `payer_electronic_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Electronic ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `prior_auth_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_bin` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Identification (RxBIN) Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_group` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Group Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `rx_pcn` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Processor Control Number (PCN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_value_regex' = 'self|spouse|child|dependent|other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` SET TAGS ('dbx_subdomain' = 'financial_responsibility');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_balance` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Account Balance');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Account Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Account Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|collections|bad_debt|deceased|bankruptcy');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `address_line2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `annual_income` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Annual Income');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `annual_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `annual_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bad_debt_flag` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Bankruptcy Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Guarantor City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `collection_agency_flag` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Referral Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Country Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `deceased_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Deceased Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `email_address` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Employer Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Employer Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employer_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Employment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Statement (E-Statement) Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `estatement_consent_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `federal_poverty_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `federal_poverty_level_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_status` SET TAGS ('dbx_value_regex' = 'not_applied|pending|approved|denied|partial');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `financial_assistance_type` SET TAGS ('dbx_value_regex' = 'charity_care|sliding_scale|payment_plan|hardship|medicaid_pending');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `first_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `guarantor_type` SET TAGS ('dbx_value_regex' = 'self|parent|spouse|legal_guardian|estate|organization');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Home Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `home_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Household Size');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `middle_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Mobile Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `organization_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `payment_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Monthly Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `payment_plan_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `payment_plan_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `postal_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'home_phone|work_phone|mobile_phone|email|mail');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `relationship_to_patient` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `responsibility_pct` SET TAGS ('dbx_business_glossary_term' = 'Account Responsibility Percentage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `since_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Since Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `sms_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'SMS Text Message Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN) Masked');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_value_regex' = '^XXX-XX-[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Guarantor State');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Work Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`guarantor` ALTER COLUMN `work_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Contact City');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `city` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `consent_obtained_by` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deceased|unverified');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'emergency_contact|healthcare_proxy|legal_guardian|authorized_representative|next_of_kin|guarantor');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Country Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Proxy Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `healthcare_proxy_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Home Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `interpreter_required` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `legal_guardian_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Guardian Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `lives_with_patient` SET TAGS ('dbx_business_glossary_term' = 'Lives With Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `notification_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `phi_disclosure_authorized` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Disclosure Authorization');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'mobile|home_phone|work_phone|email|text_sms');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Preferred Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `priority_order` SET TAGS ('dbx_business_glossary_term' = 'Contact Priority Order');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Proxy Authorization Document Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Proxy Authorization Document Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_type` SET TAGS ('dbx_business_glossary_term' = 'Proxy Authorization Document Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `proxy_document_type` SET TAGS ('dbx_value_regex' = 'durable_power_of_attorney|healthcare_proxy_form|court_order|advance_directive|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `source_system_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Contact ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'Contact State Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `state_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Contact Information Verified By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Information Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Work Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('dbx_business_glossary_term' = 'Contact Work Phone Extension');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('dbx_value_regex' = '^d{1,6}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`emergency_contact` ALTER COLUMN `work_phone_extension` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `pcp_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Attribution ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Attributed Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Attributed Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attributed Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `aco_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `aco_contract_number` SET TAGS ('dbx_value_regex' = '^ACO[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Attributed Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Attribution Confidence Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_method` SET TAGS ('dbx_business_glossary_term' = 'Attribution Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_method` SET TAGS ('dbx_value_regex' = 'claims_based|enrollment_based|manual|algorithm_based|hybrid|empanelment');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Attribution Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_rank` SET TAGS ('dbx_business_glossary_term' = 'Attribution Rank');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_review_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Review Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_segment` SET TAGS ('dbx_business_glossary_term' = 'Attribution Segment');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_segment` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|dual_eligible|uninsured');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source System');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_source` SET TAGS ('dbx_value_regex' = 'epic_healthy_planet|cerner_millennium|payer_feed|manual_entry|hl7_fhir|population_health_platform');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|disputed|under_review');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `care_management_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Care Management Enrollment Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `consent_on_file` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent on File Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `data_sharing_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Opt-Out Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `disenrollment_reason` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution End Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `geographic_region` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `geographic_region` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `hcc_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `hedis_eligible` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `is_primary_attribution` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Attribution Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `last_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last PCP Visit Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `lookback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Attribution Lookback Period (Months)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Attribution Measurement Year');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `mips_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `override_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Override Authorized By');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `override_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Override Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `panel_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Panel Assignment Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `payer_attribution_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Attribution ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'ACO|HMO|PPO|POS|EPO|PCMH');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `risk_stratification_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Stratification Tier');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `risk_stratification_tier` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `source_feed_date` SET TAGS ('dbx_business_glossary_term' = 'Source Feed Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ALTER COLUMN `visit_count_lookback` SET TAGS ('dbx_business_glossary_term' = 'Visit Count Lookback');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` SET TAGS ('dbx_subdomain' = 'financial_responsibility');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `eligibility_check_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Radiology Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coinsurance_percent` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coinsurance_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coordination_of_benefits_flag` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `copay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `family_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Family Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `family_deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Group Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Individual Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_deductible_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Individual Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_deductible_met_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_out_of_pocket_max` SET TAGS ('dbx_business_glossary_term' = 'Individual Out-of-Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_out_of_pocket_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_out_of_pocket_met` SET TAGS ('dbx_business_glossary_term' = 'Individual Out-of-Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `individual_out_of_pocket_met` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `is_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|unknown');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `prior_auth_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `prior_auth_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `transaction_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Control Number (TCN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'edi_270_271|portal|phone|fax|real_time_api|batch');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|error|partial|not_found');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_type` SET TAGS ('dbx_business_glossary_term' = 'Verification Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verification_type` SET TAGS ('dbx_value_regex' = 'real_time|batch|manual|scheduled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `verified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Verified By User');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurance Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `tertiary_registration_pcp_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `admission_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `admission_type` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|newborn|trauma');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `admit_reason` SET TAGS ('dbx_business_glossary_term' = 'Admission Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `adt_message_type` SET TAGS ('dbx_business_glossary_term' = 'Admit Discharge Transfer (ADT) Message Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `advance_directive_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive on File Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Registration Completeness Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `duplicate_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `eligibility_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `eligibility_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Eligibility Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Medical Record Number (Enterprise MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'completed|pending|cancelled|failed|in_progress');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'new_registration|pre_registration|update|merge|unmerge');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `expected_los_days` SET TAGS ('dbx_business_glossary_term' = 'Expected Length of Stay (LOS) Days');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `financial_class` SET TAGS ('dbx_business_glossary_term' = 'Financial Class');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `hipaa_notice_delivered_flag` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Notice of Privacy Practices Delivered Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'photo_id|insurance_card|biometric|passport|none|self_reported');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Patient Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_match_score` SET TAGS ('dbx_business_glossary_term' = 'Master Patient Index (MPI) Match Score');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_match_status` SET TAGS ('dbx_business_glossary_term' = 'Master Patient Index (MPI) Match Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mpi_match_status` SET TAGS ('dbx_value_regex' = 'new_patient|auto_matched|manual_review|auto_merged|no_match');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|recurring|preadmit');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `point_of_care` SET TAGS ('dbx_business_glossary_term' = 'Point of Care');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `pre_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Pre-Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('dbx_business_glossary_term' = 'Prior Medical Record Number (Prior MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `prior_mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `registration_source` SET TAGS ('dbx_value_regex' = 'ed_walk_in|scheduled|transfer|online_pre_registration|referral|direct_admit');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `restricted_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `restricted_record_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ALTER COLUMN `vip_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_id` SET TAGS ('dbx_business_glossary_term' = 'Portal Account ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation|locked|deactivated');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'patient|proxy|shared');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Activation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `activation_method` SET TAGS ('dbx_business_glossary_term' = 'Account Activation Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `activation_method` SET TAGS ('dbx_value_regex' = 'staff_assisted|self_service|kiosk|mail|email_invite|sms_invite');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `app_link_date` SET TAGS ('dbx_business_glossary_term' = 'Digital Health Application Link Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `appointment_scheduling_enabled` SET TAGS ('dbx_business_glossary_term' = 'Appointment Self-Scheduling Enabled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Account Creation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Deactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('dbx_business_glossary_term' = 'Digital Health Application Linked');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_app_linked` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'in_person|online_proofing|government_id|knowledge_based|staff_verified|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `identity_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `identity_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Identity Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `last_login_date` SET TAGS ('dbx_business_glossary_term' = 'Last Login Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `login_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Login Failure Count');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `messaging_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Secure Messaging Opt-In Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('dbx_business_glossary_term' = 'Portal Notification Email Address');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_email` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Portal Notification Mobile Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_mobile_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|push|in_portal|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Number');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_account_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_platform` SET TAGS ('dbx_business_glossary_term' = 'Portal Platform');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `portal_platform` SET TAGS ('dbx_value_regex' = 'MyChart|HealtheLife|FollowMyHealth|Healow|PatientFusion|Other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_level` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Level');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_access_level` SET TAGS ('dbx_value_regex' = 'full|limited|view_only');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Proxy Authorization Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Proxy Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_date_of_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('dbx_business_glossary_term' = 'Proxy First Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_first_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('dbx_business_glossary_term' = 'Proxy Last Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_last_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Proxy Legal Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_type` SET TAGS ('dbx_business_glossary_term' = 'Proxy Legal Document Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_legal_document_type` SET TAGS ('dbx_value_regex' = 'court_order|power_of_attorney|guardianship_decree|parental_consent|advance_directive|other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Proxy Relationship Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_relationship_type` SET TAGS ('dbx_value_regex' = 'parent|legal_guardian|adult_caregiver|healthcare_poa|spouse|other');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Proxy Access Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `proxy_revocation_reason` SET TAGS ('dbx_value_regex' = 'patient_request|guardian_change|legal_order|deceased|age_of_majority|administrative');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `rx_renewal_request_enabled` SET TAGS ('dbx_business_glossary_term' = 'Prescription Renewal Request Enabled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `source_system_account_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Account ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `terms_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Terms of Use Acceptance Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `terms_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Terms of Use Accepted Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `terms_version` SET TAGS ('dbx_business_glossary_term' = 'Terms of Use Version');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Test Result Notification Enabled');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `test_result_notification_enabled` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `two_factor_auth_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Two-Factor Authentication (2FA) Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `two_factor_auth_method` SET TAGS ('dbx_business_glossary_term' = 'Two-Factor Authentication (2FA) Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `two_factor_auth_method` SET TAGS ('dbx_value_regex' = 'sms|email|authenticator_app|hardware_token|none');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Obtaining Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `superseded_consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Consent Reference Id');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `superseded_consent_reference_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `audit_trail_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written|verbal|electronic|implied');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending|superseded');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'treatment|research|marketing|phi_disclosure|hie_participation|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `digital_health_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Medical Record Number (EMRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `enterprise_mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('dbx_business_glossary_term' = 'Guardian Name');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `guardian_relationship` SET TAGS ('dbx_business_glossary_term' = 'Guardian Relationship');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `hie_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `interpreter_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `language_of_consent` SET TAGS ('dbx_business_glossary_term' = 'Language of Consent');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `legal_guardian_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Guardian Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `phi_disclosure_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Disclosure Authorized Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `record_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Master ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `reference_priority` SET TAGS ('dbx_business_glossary_term' = 'Reference Priority');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `research_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Research Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `source_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
