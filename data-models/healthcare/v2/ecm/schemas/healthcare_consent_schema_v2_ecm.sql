-- Schema for Domain: consent | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`consent` COMMENT 'Enterprise consent management for patient treatment consent, research consent, data sharing authorizations, HIPAA authorizations, HIE opt-in/opt-out, and telehealth consent. SSOT for all consent records across clinical, research, and administrative contexts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`form_template` (
    `form_template_id` BIGINT COMMENT 'Unique identifier for the consent form template record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent form template record.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Templates are governed by compliance policies defining required elements, approval workflows, and regulatory requirements. Essential for policy enforcement, version control, and demonstrating that con',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Consent form templates must conform to specific exchange standards (C-CDA Consent Directive template 2.16.840.1.113883.10.20.22.2.64, FHIR Consent resource profiles). Required for interoperability des',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the consent form template record.',
    `primary_superseded_by_form_template_id` BIGINT COMMENT 'Reference to the consent_form_template_id of the newer version that supersedes this template. Null if this is the current active version.',
    `applicable_facility_types` STRING COMMENT 'Comma-separated list or description of facility types where this consent form template is applicable (e.g., inpatient hospital, outpatient clinic, emergency department, ambulatory surgery center, telehealth platform).',
    `applicable_service_lines` STRING COMMENT 'Comma-separated list or description of clinical service lines or departments where this consent form template is used (e.g., cardiology, oncology, behavioral health, radiology, laboratory).',
    `approval_authority` STRING COMMENT 'Name or title of the individual, committee, or department that approved this consent form template for use (e.g., Chief Compliance Officer, Legal Department, Privacy Officer, IRB Chair).',
    `approval_date` DATE COMMENT 'Date when the consent form template was officially approved by the designated authority for deployment and use.',
    `consent_category` STRING COMMENT 'Primary category of consent this form template addresses: treatment (general medical treatment), surgical (procedure-specific), research (clinical trials and studies), hipaa_authorization (PHI disclosure), hie_opt_in_out (Health Information Exchange participation), telehealth (virtual care consent), data_sharing (third-party data use). [ENUM-REF-CANDIDATE: treatment|surgical|research|hipaa_authorization|hie_opt_in_out|telehealth|data_sharing — 7 candidates stripped; promote to reference product]',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent form template record.',
    `consent_subcategory` STRING COMMENT 'Optional subcategory or specialization within the primary consent category (e.g., anesthesia, blood transfusion, genetic testing, marketing communications).',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this consent form template record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent form template record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this consent form template version becomes valid and available for use in patient consent workflows.',
    `electronic_signature_enabled_flag` BOOLEAN COMMENT 'Indicates whether this consent form template supports electronic signature capture in compliance with ESIGN Act and state electronic signature laws. True if electronic signature is enabled, False if wet signature is required.',
    `expiration_date` DATE COMMENT 'Date when this consent form template version is no longer valid for new consent collection. Nullable for forms without predetermined expiration.',
    `form_checksum` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the form document file to ensure integrity and detect unauthorized modifications. Used for audit and compliance verification.',
    `form_code` STRING COMMENT 'Unique business identifier code for the consent form template used for reference across systems (e.g., HIPAA_AUTH_2024, SURG_CONSENT_V3).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `form_document_url` STRING COMMENT 'URL or file path to the digital master copy of the consent form template document (PDF, Word, or other format) stored in the document management system.',
    `form_name` STRING COMMENT 'Full descriptive name of the consent form template (e.g., General Surgical Consent Form, HIPAA Authorization for Release of Information).',
    `form_purpose` STRING COMMENT 'Detailed description of the business and clinical purpose of this consent form template, including what actions or disclosures it authorizes and what patient rights it addresses.',
    `form_status` STRING COMMENT 'Current lifecycle status of the consent form template: draft (under development), pending_approval (awaiting review), active (approved for use), superseded (replaced by newer version), retired (no longer in use), withdrawn (removed from circulation).. Valid values are `draft|pending_approval|active|superseded|retired|withdrawn`',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether an interpreter signature or attestation is required when the form is presented in a language different from the patients primary language. True if interpreter attestation is required, False otherwise.',
    `irb_approval_date` DATE COMMENT 'Date when the IRB approved this research consent form template. Applicable only to research consent forms.',
    `irb_approval_number` STRING COMMENT 'IRB protocol or approval reference number for research consent forms. Required for research studies involving human subjects under 45 CFR Part 46. Null for non-research consent forms.',
    `irb_expiration_date` DATE COMMENT 'Date when the IRB approval for this research consent form expires and requires renewal. Applicable only to research consent forms.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code (with optional ISO 3166-1 country code) indicating the language of the consent form template (e.g., en, es, zh-CN, fr-CA).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent form template record.',
    `legal_representative_allowed_flag` BOOLEAN COMMENT 'Indicates whether a legal representative (guardian, power of attorney, parent) may sign this consent form on behalf of the patient. True if representative signature is permitted, False if patient signature is strictly required.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age (in years) at which a patient may provide consent under this form template without parental or guardian involvement. Null if no age restriction applies or if form is not age-dependent.',
    `minor_assent_required_flag` BOOLEAN COMMENT 'Indicates whether assent from a minor patient (in addition to parental consent) is required for this consent form. Applicable primarily to research and certain treatment contexts. True if minor assent is required, False otherwise.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this consent form template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent form template record was last modified.',
    `reading_level` STRING COMMENT 'Assessed reading comprehension level required to understand the consent form content, typically expressed as grade level (e.g., 6th grade, 8th grade) or readability score (Flesch-Kincaid). Important for health literacy compliance.',
    `record_number` BIGINT COMMENT 'The record number of the consent form template record.',
    `regulatory_basis` STRING COMMENT 'Primary legal or regulatory framework that mandates or governs this consent form (e.g., HIPAA Privacy Rule 45 CFR 164.508, 45 CFR Part 46 Common Rule, California CMIA, State-specific informed consent statute).',
    `retention_period_years` STRING COMMENT 'Number of years that signed instances of this consent form must be retained per regulatory and legal requirements (e.g., 6 years per HIPAA, 7 years per state law, indefinitely for certain research consents).',
    `revocation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the patient has the right to revoke consent given under this form template. True if revocation is permitted, False if consent is irrevocable (rare, typically only in certain research contexts).',
    `revocation_instructions` STRING COMMENT 'Instructions provided to patients on how to revoke consent if revocation is allowed (e.g., written notice to Privacy Officer, submission of revocation form).',
    `scope_of_consent` STRING COMMENT 'Textual description of what the patient is consenting to, including specific procedures, data uses, disclosures, or participation activities covered by this form.',
    `template_name` STRING COMMENT 'The template name of the consent form template record.',
    `template_status` STRING COMMENT 'The template status value classifying the consent form template record.',
    `template_type` STRING COMMENT 'The template type value classifying the consent form template record.',
    `version_number` STRING COMMENT 'Version identifier for the consent form template following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Incremented when form content or structure changes.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature is required on this consent form in addition to the patient signature. True if witness is required, False otherwise.',
    CONSTRAINT pk_form_template PRIMARY KEY(`form_template_id`)
) COMMENT 'Master catalog of all approved consent form templates used across clinical, research, and administrative contexts. Captures form name, form code, consent category (treatment, surgical, research, HIPAA, HIE, telehealth, data sharing), version number, effective date, expiration date, regulatory basis (HIPAA, 45 CFR 46, state law), language, reading level, approval authority, and IRB approval reference where applicable. Serves as the authoritative reference for which form version was presented to a patient at time of consent.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` (
    `hipaa_authorization_id` BIGINT COMMENT 'Unique identifier for the HIPAA authorization record. Primary key for the authorization entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the authorization was obtained.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: HIPAA authorizations must comply with organizational policies implementing HIPAA Privacy Rule requirements. Links authorization instances to governing policy for audit trails, policy version tracking,',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who is granting the HIPAA authorization for use or disclosure of their Protected Health Information (PHI).',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who obtained and witnessed the patient signature on the authorization.',
    `form_template_id` BIGINT COMMENT 'Unique identifier for the form template within the consent hipaa authorization record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the consent hipaa authorization record.',
    `research_study_id` BIGINT COMMENT 'Identifier of the research study for which this authorization permits PHI disclosure, if the authorization purpose is research.',
    `superseded_hipaa_authorization_id` BIGINT COMMENT 'Self-referencing FK on hipaa_authorization (superseded_hipaa_authorization_id)',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the authorization was obtained, if applicable. Used for linking authorization to the clinical context.',
    `authorization_purpose` STRING COMMENT 'The specific purpose for which the patient is authorizing the use or disclosure of PHI beyond treatment, payment, and operations (TPO). Must be one of the purposes requiring explicit HIPAA authorization under 45 CFR 164.508.. Valid values are `marketing|research|psychotherapy_notes|sale_of_phi|legal_proceeding|other`',
    `authorization_purpose_description` STRING COMMENT 'Detailed free-text description of the specific purpose for the authorization, providing additional context beyond the categorical purpose code.',
    `authorization_status` STRING COMMENT 'The authorization status value classifying the consent hipaa authorization record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent hipaa authorization record.',
    `compensation_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the authorization includes disclosure that the covered entity will receive direct or indirect remuneration from a third party in exchange for using or disclosing PHI. Required for authorizations involving sale of PHI.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent hipaa authorization record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization record was first created in the system. Used for audit trail and compliance tracking.',
    `disclosing_party_name` STRING COMMENT 'Name of the covered entity or individual authorized to make the disclosure of PHI (typically the healthcare organization or provider).',
    `disclosing_party_npi` STRING COMMENT 'National Provider Identifier of the disclosing party, if applicable. Used for provider identification and compliance tracking.. Valid values are `^[0-9]{10}$`',
    `document_reference` STRING COMMENT 'Reference identifier or URI to the scanned or electronically stored copy of the signed authorization form in the document management system.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent hipaa authorization record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent hipaa authorization record.',
    `expiration_event` STRING COMMENT 'Description of the event that will cause the authorization to expire (e.g., end of research study, completion of legal proceeding). Used when expiration is event-based rather than date-based.',
    `form_version` STRING COMMENT 'Version identifier of the HIPAA authorization form template used. Used for tracking form updates and ensuring compliance with current regulatory requirements.',
    `irb_approval_number` STRING COMMENT 'IRB approval number for the research study, if applicable. Required for research authorizations to demonstrate ethical oversight.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the authorization form was presented to and signed by the patient.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent hipaa authorization record.',
    `last_updated_by` STRING COMMENT 'User identifier or name of the system user who last modified the authorization record. Used for audit trail and accountability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization record was last modified. Used for audit trail and version control.',
    `mrn` STRING COMMENT 'The patients medical record number associated with this authorization. Used for cross-referencing and audit purposes.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the authorization, including any special circumstances, clarifications, or administrative details.',
    `personal_representative_flag` BOOLEAN COMMENT 'Indicates whether the authorization was signed by a personal representative on behalf of the patient (e.g., parent, guardian, power of attorney).',
    `personal_representative_name` STRING COMMENT 'Name of the personal representative who signed the authorization on behalf of the patient, if applicable.',
    `personal_representative_relationship` STRING COMMENT 'Relationship of the personal representative to the patient (e.g., parent, legal guardian, power of attorney).. Valid values are `parent|legal_guardian|power_of_attorney|executor|healthcare_proxy|other`',
    `phi_category` STRING COMMENT 'High-level categorization of the type of PHI covered by this authorization. Used for reporting and compliance tracking. [ENUM-REF-CANDIDATE: complete_medical_record|specific_encounter|lab_results|radiology_images|psychotherapy_notes|substance_abuse_records|hiv_aids_records|mental_health_records|genetic_information|other — 10 candidates stripped; promote to reference product]',
    `phi_description` STRING COMMENT 'Detailed description of the specific PHI elements or categories authorized for disclosure (e.g., medical records from specific dates, lab results, psychotherapy notes, HIV status, substance abuse treatment records).',
    `recipient_address` STRING COMMENT 'Mailing address of the recipient authorized to receive the PHI disclosure.',
    `recipient_name` STRING COMMENT 'Name of the person or entity authorized to receive the disclosed PHI (e.g., research institution, attorney, insurance company, marketing firm).',
    `recipient_organization` STRING COMMENT 'Organization name of the recipient entity, if the recipient is an organization rather than an individual.',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: HIPAA authorizations are a type of consent record. Linking to the core record table enables unified consent management and reporting across all consent types. Core consent lifecycle attributes (status',
    `redisclosure_statement` STRING COMMENT 'Statement informing the patient that information disclosed pursuant to the authorization may be subject to redisclosure by the recipient and may no longer be protected by HIPAA.',
    `right_to_revoke_statement` STRING COMMENT 'Statement informing the patient of their right to revoke the authorization and any exceptions to that right (e.g., if action has already been taken in reliance on the authorization).',
    `signature_date` DATE COMMENT 'Date on which the patient signed the HIPAA authorization form.',
    `signature_method` STRING COMMENT 'Method by which the patient signature was captured (e.g., wet signature on paper, electronic signature pad, digital signature via patient portal).. Valid values are `wet_signature|electronic_signature|digital_signature|patient_portal`',
    `signature_obtained_flag` BOOLEAN COMMENT 'Indicates whether the required patient signature has been obtained on the authorization form. HIPAA requires a valid signature for the authorization to be effective.',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the consent hipaa authorization record.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'Name of the witness who observed the patient signing the authorization, if applicable. Some organizations require witness signatures for certain types of authorizations.',
    `witness_signature_date` DATE COMMENT 'Date on which the witness signed the authorization form, if applicable.',
    `created_by` STRING COMMENT 'User identifier or name of the system user who created the authorization record. Used for audit trail and accountability.',
    CONSTRAINT pk_hipaa_authorization PRIMARY KEY(`hipaa_authorization_id`)
) COMMENT 'Master record for HIPAA-specific authorizations permitting use or disclosure of PHI for purposes beyond treatment, payment, and operations (TPO). Captures authorization purpose (marketing, research, psychotherapy notes, sale of PHI), specific PHI elements authorized for disclosure, recipient of disclosure, expiration date or expiration event, right to revoke statement, and patient signature. Distinct from general treatment consent — governed specifically by 45 CFR 164.508 and requires stricter documentation standards.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` (
    `hie_directive_id` BIGINT COMMENT 'Unique identifier for the HIE directive record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where this HIE directive was captured.',
    `clinician_id` BIGINT COMMENT 'Identifier of the healthcare provider or staff member who captured this HIE directive.',
    `demographics_id` BIGINT COMMENT 'Identifier of the patient who issued this HIE directive.',
    `hie_participation_id` BIGINT COMMENT 'Foreign key linking to interoperability.hie_participation. Business justification: HIE directives are scoped to specific organizational HIE participation agreements. Business needs to enforce which HIE network participation governs each patient directive, especially when organizatio',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the consent hie directive record.',
    `superseded_hie_directive_id` BIGINT COMMENT 'Self-referencing FK on hie_directive (superseded_hie_directive_id)',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: HIE directives specify which trading partners (specific hospitals, health systems, HIEs) can access patient data. Required for operational enforcement of patient restrictions—when patient opts out of ',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which this HIE directive was captured, if applicable.',
    `audit_log_reference` STRING COMMENT 'Reference identifier linking this directive to detailed audit logs of HIE access events.',
    `break_glass_events_count` STRING COMMENT 'Number of times emergency break-glass access has been invoked to override this directive.',
    `consent_form_version` STRING COMMENT 'Version identifier of the consent form or template used to capture this directive.',
    `consent_method` STRING COMMENT 'Method by which the patient provided this HIE directive: written form, verbal communication, electronic signature, or implied consent.. Valid values are `written|verbal|electronic|implied`',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent hie directive record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HIE directive record was first created in the system.',
    `data_type_restrictions` STRING COMMENT 'Comma-separated list of specific data types or categories the patient has restricted from sharing (e.g., mental health, substance abuse, HIV status, genetic information).',
    `directive_status` STRING COMMENT 'The directive status value classifying the consent hie directive record.',
    `directive_type` STRING COMMENT 'Type of HIE directive: opt-in (patient consents to share), opt-out (patient declines to share), opt-out with exceptions (patient declines except for specified cases), or conditional (patient sets specific conditions).. Valid values are `opt_in|opt_out|opt_out_with_exceptions|conditional`',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent hie directive record.',
    `emergency_access_override` BOOLEAN COMMENT 'Indicates whether emergency access provisions allow providers to override this directive in life-threatening situations.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent hie directive record.',
    `federal_override_applicable` BOOLEAN COMMENT 'Indicates whether federal regulations (e.g., 42 CFR Part 2 for substance abuse) override state HIE consent laws for this directive.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used to explain the HIE directive to the patient.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the directive was presented to and understood by the patient.',
    `last_break_glass_date` TIMESTAMP COMMENT 'Timestamp of the most recent emergency break-glass access event.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent hie directive record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this HIE directive record was last modified.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp when the directive was last verified with the patient or confirmed as still valid.',
    `legal_representative_name` STRING COMMENT 'Name of the legal representative (guardian, power of attorney) who provided consent on behalf of the patient, if applicable.',
    `legal_representative_relationship` STRING COMMENT 'Relationship of the legal representative to the patient (e.g., parent, guardian, healthcare proxy, power of attorney).',
    `mrn` STRING COMMENT 'The patients medical record number associated with this directive.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or reconfirmation of this HIE directive with the patient.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this HIE directive, including any special circumstances or clarifications.',
    `patient_education_provided` BOOLEAN COMMENT 'Indicates whether educational materials about HIE participation were provided to the patient.',
    `patient_instructions` STRING COMMENT 'Free-text field capturing any additional instructions or conditions specified by the patient regarding HIE participation.',
    `provider_restrictions` STRING COMMENT 'Comma-separated list of specific provider organizations or individuals the patient has restricted from accessing their data via HIE.',
    `purpose_of_use_restrictions` STRING COMMENT 'Comma-separated list of purposes for which data sharing is restricted or permitted (e.g., treatment, payment, operations, research, public health).',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: HIE directives are a type of consent record governing health information exchange. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes ',
    `scope_of_sharing` STRING COMMENT 'Defines the breadth of data sharing permitted: all records, specific data types only, specific providers only, emergency situations only, or treatment purposes only.. Valid values are `all_records|specific_data_types|specific_providers|emergency_only|treatment_only`',
    `source_system_code` STRING COMMENT 'Unique identifier of this directive in the source system.',
    `state_jurisdiction` STRING COMMENT 'Two-letter state code indicating the jurisdiction whose HIE consent laws govern this directive.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'Name of the witness who observed the patient signing the HIE directive, if applicable.',
    `witness_signature_date` DATE COMMENT 'Date when the witness signed the HIE directive form.',
    CONSTRAINT pk_hie_directive PRIMARY KEY(`hie_directive_id`)
) COMMENT 'Master record for patient Health Information Exchange (HIE) opt-in and opt-out directives governing participation in regional and statewide HIE networks. Captures HIE network name, directive type (opt-in, opt-out, opt-out with exceptions), effective date, expiration date, scope of data sharing (all records, specific data types, specific providers), patient-specified restrictions, and directive status. Supports compliance with state HIE consent laws and CommonWell/Carequality participation rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` (
    `treatment_consent_id` BIGINT COMMENT 'Unique identifier for the treatment consent record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where this treatment consent was obtained.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Treatment consent forms are governed by policies defining informed consent requirements, documentation standards, and regulatory compliance. Essential for demonstrating that consent practices meet org',
    `cpt_code_id` BIGINT COMMENT 'The CPT or ICD-10-PCS code identifying the specific procedure or treatment being consented to. Applicable for procedure-specific consent types.',
    `form_template_id` BIGINT COMMENT 'Unique identifier for the form template within the consent treatment consent record.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of this treatment consent.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Treatment consents often require payer-specific authorization and documentation. Some procedures require payer pre-authorization before consent can be finalized. Links consent management to insurance ',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who performed the clinical assessment of the patients decision-making capacity.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created this treatment consent record.',
    `superseded_treatment_consent_id` BIGINT COMMENT 'Self-referencing FK on treatment_consent (superseded_treatment_consent_id)',
    `tertiary_treatment_performing_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who will perform the procedure or treatment for which consent was obtained.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this consent was obtained.',
    `alternatives_documented` STRING COMMENT 'Narrative documentation of alternative treatment options that were disclosed to and discussed with the patient or authorized representative.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent treatment consent record.',
    `benefits_documented` STRING COMMENT 'Narrative documentation of the expected benefits of the procedure or treatment that were disclosed to and discussed with the patient or authorized representative.',
    `capacity_determination` STRING COMMENT 'Clinical determination of whether the patient has decision-making capacity to provide informed consent for the treatment or procedure.. Valid values are `patient_has_capacity|patient_lacks_capacity|not_assessed`',
    `consent_document_location` STRING COMMENT 'Reference to the location or system where the signed consent document is stored (e.g., EMR document ID, scanned document repository path).',
    `consent_form_number` STRING COMMENT 'The externally-known unique identifier or form number for this treatment consent document.',
    `consent_method` STRING COMMENT 'The method by which consent was obtained and documented (written signature, verbal consent documented by provider, electronic signature, telephonic consent with witness).. Valid values are `written|verbal|electronic|telephonic`',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent treatment consent record.',
    `consent_version` STRING COMMENT 'Version identifier of the consent form template used, for tracking form revisions and ensuring compliance with current organizational policies.',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when this treatment consent record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the consent treatment consent record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent treatment consent record.',
    `emergency_exception_flag` BOOLEAN COMMENT 'Indicates whether treatment was provided under emergency exception provisions when informed consent could not be obtained due to the patients condition and no authorized representative was available.',
    `emergency_exception_justification` STRING COMMENT 'Clinical documentation justifying why treatment was provided without informed consent under emergency exception provisions.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent treatment consent record.',
    `interpreter_language` STRING COMMENT 'The language in which interpretation services were provided during the consent process.',
    `interpreter_name` STRING COMMENT 'Full name of the medical interpreter who facilitated the consent discussion.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter was required to facilitate the consent discussion due to language barriers or communication needs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent treatment consent record.',
    `last_updated_datetime` TIMESTAMP COMMENT 'The date and time when this treatment consent record was last modified in the system.',
    `legal_representative_name` STRING COMMENT 'Full name of the legal representative or authorized decision-maker who provided consent on behalf of the patient.',
    `legal_representative_phone` STRING COMMENT 'Contact phone number for the legal representative or authorized decision-maker.',
    `legal_representative_relationship` STRING COMMENT 'The legal or familial relationship of the representative to the patient (e.g., parent, legal guardian, healthcare proxy, durable power of attorney for healthcare, spouse, next of kin).. Valid values are `parent|guardian|healthcare_proxy|power_of_attorney|spouse|next_of_kin`',
    `legal_representative_required_flag` BOOLEAN COMMENT 'Indicates whether a legal representative or authorized decision-maker was required to provide consent on behalf of the patient due to lack of capacity.',
    `patient_questions_addressed_flag` BOOLEAN COMMENT 'Indicates whether the patient or authorized representative had the opportunity to ask questions and all questions were addressed prior to obtaining consent.',
    `patient_questions_notes` STRING COMMENT 'Free-text documentation of specific questions asked by the patient or authorized representative and the responses provided.',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Treatment consent is a specialized type of consent record for medical procedures. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes (',
    `revoked_by_name` STRING COMMENT 'Name of the individual (patient or authorized representative) who revoked the consent.',
    `risks_documented` STRING COMMENT 'Narrative documentation of the material risks of the procedure or treatment that were disclosed to and discussed with the patient or authorized representative.',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the consent treatment consent record.',
    `special_instructions` STRING COMMENT 'Any special instructions, limitations, or conditions specified by the patient or authorized representative as part of the consent (e.g., no blood products, specific anesthesia preferences).',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the consent process and signed the consent form.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required on the consent form per organizational policy or regulatory requirement.',
    `witness_role` STRING COMMENT 'The role or title of the witness (e.g., registered nurse, social worker, patient advocate).',
    CONSTRAINT pk_treatment_consent PRIMARY KEY(`treatment_consent_id`)
) COMMENT 'Master record for general and procedure-specific treatment consent obtained from patients or their authorized representatives prior to clinical care. Captures consent type (general treatment, surgical, anesthesia, blood transfusion, chemotherapy, ECT, restraint), procedure or treatment being consented to, risks and benefits documented, alternatives discussed, patient questions addressed, capacity determination, and legal representative details when patient lacks decision-making capacity. Distinct from HIPAA authorization — governs clinical care delivery.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`research_consent` (
    `research_consent_id` BIGINT COMMENT 'Unique identifier for the research consent record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent research consent record.',
    `clinician_id` BIGINT COMMENT 'Identifier of the healthcare provider or research coordinator who obtained informed consent from the subject.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Research consents must comply with IRB-approved policies and organizational research governance policies. Links consent instances to governing policies for audit trails, regulatory compliance verifica',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient or research subject who provided consent.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical trial or research study for which consent was obtained.',
    `superseded_research_consent_id` BIGINT COMMENT 'Self-referencing FK on research_consent (superseded_research_consent_id)',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Research consents are transmitted via CDA when sharing research participant data across institutions in multi-site trials. Required for IRB audits to prove consent was properly communicated to data-re',
    `biospecimen_collection_authorized` BOOLEAN COMMENT 'Indicates whether the subject authorized collection and storage of biospecimens (blood, tissue, DNA) for research purposes.',
    `comprehension_assessment_method` STRING COMMENT 'Method used to assess subject comprehension (e.g., teach-back, quiz, verbal confirmation).',
    `comprehension_assessment_result` STRING COMMENT 'Result of the comprehension assessment indicating whether the subject demonstrated adequate understanding of the study.. Valid values are `adequate|inadequate|not_assessed`',
    `consent_discussion_duration_minutes` STRING COMMENT 'Duration in minutes of the informed consent discussion between the consenting provider and the research subject.',
    `consent_document_url` STRING COMMENT 'URL or file path to the signed consent document stored in the document management system.',
    `consent_form_version` STRING COMMENT 'Version identifier of the IRB-approved informed consent form used for this consent event.',
    `consent_language` STRING COMMENT 'Language in which the informed consent form was presented and discussed with the subject (e.g., English, Spanish, Mandarin).',
    `consent_location` STRING COMMENT 'Physical location or facility where the consent process took place (e.g., clinic name, hospital unit, research center).',
    `consent_method` STRING COMMENT 'Method by which consent was obtained (e.g., in-person, telehealth, electronic signature, written signature).. Valid values are `in_person|telehealth|electronic|written`',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent research consent record.',
    `consenting_provider_npi` STRING COMMENT 'National Provider Identifier of the provider who obtained consent. 10-digit unique identifier.. Valid values are `^[0-9]{10}$`',
    `contact_for_future_studies_authorized` BOOLEAN COMMENT 'Indicates whether the subject authorized being contacted for participation in future research studies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this research consent record was first created in the system.',
    `data_sharing_authorized` BOOLEAN COMMENT 'Indicates whether the subject authorized sharing of their de-identified research data with external researchers or repositories.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent research consent record.',
    `electronic_signature_code` STRING COMMENT 'Unique identifier of the electronic signature captured during the consent process, if applicable.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent research consent record.',
    `future_research_authorized` BOOLEAN COMMENT 'Indicates whether the subject authorized use of their data and biospecimens for future unspecified research studies.',
    `genetic_testing_authorized` BOOLEAN COMMENT 'Indicates whether the subject authorized genetic testing and analysis of their biospecimens.',
    `hipaa_authorization_included` BOOLEAN COMMENT 'Indicates whether HIPAA authorization for use and disclosure of protected health information was included in the research consent.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used during the consent process to facilitate communication with the subject.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number under which this consent was obtained. Links consent to the approved research protocol.',
    `lar_contact_phone` STRING COMMENT 'Contact phone number of the legally authorized representative.',
    `lar_name` STRING COMMENT 'Full name of the legally authorized representative who provided consent on behalf of the subject.',
    `lar_relationship` STRING COMMENT 'Relationship of the LAR to the research subject (e.g., parent, guardian, healthcare proxy, power of attorney).',
    `lar_used` BOOLEAN COMMENT 'Indicates whether a legally authorized representative provided consent on behalf of an incapacitated or minor subject.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent research consent record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this research consent record was last modified in the system.',
    `minor_assent_date` DATE COMMENT 'Date on which assent was obtained from the minor subject.',
    `minor_assent_obtained` BOOLEAN COMMENT 'Indicates whether assent was obtained from a minor subject in addition to parental consent, as required by IRB protocol.',
    `mrn` STRING COMMENT 'Medical record number of the research subject. Unique patient identifier within the healthcare system.',
    `reconsent_date` DATE COMMENT 'Date on which reconsent was obtained following a protocol amendment or other triggering event.',
    `reconsent_reason` STRING COMMENT 'Reason for requiring reconsent (e.g., protocol amendment, new safety information, change in study procedures).',
    `reconsent_required` BOOLEAN COMMENT 'Indicates whether reconsent is required due to protocol amendment, new risks identified, or other changes to the study.',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Research consent is a specialized type of consent record for clinical research. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes (st',
    `return_of_results_requested` BOOLEAN COMMENT 'Indicates whether the subject requested to receive individual research results or incidental findings from the study.',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the consent research consent record.',
    `study_arm` STRING COMMENT 'The specific arm or cohort of the study to which the subject was assigned (e.g., treatment, control, placebo).',
    `subject_comprehension_assessed` BOOLEAN COMMENT 'Indicates whether the research subjects comprehension of the study risks, benefits, and procedures was formally assessed during the consent process.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the consent process and signed the consent form.',
    `witness_required` BOOLEAN COMMENT 'Indicates whether a witness signature was required for the consent process (e.g., for illiterate subjects or per IRB protocol).',
    CONSTRAINT pk_research_consent PRIMARY KEY(`research_consent_id`)
) COMMENT 'Master record for informed consent obtained from research subjects prior to enrollment in clinical trials and research studies. Captures IRB-approved consent form version, study arm, consent process details (who obtained consent, where, how long discussion lasted), subject comprehension assessment, legally authorized representative (LAR) details for incapacitated subjects, assent documentation for minors, re-consent events for protocol amendments, and withdrawal of consent. Governed by 45 CFR 46 (Common Rule) and 21 CFR 50 (FDA). Complements research.informed_consent with enterprise consent SSOT linkage.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` (
    `telehealth_consent_id` BIGINT COMMENT 'Unique identifier for the telehealth consent record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent telehealth consent record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the healthcare provider who will deliver telehealth services under this consent.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient providing telehealth consent. Links to the patient master record.',
    `superseded_telehealth_consent_id` BIGINT COMMENT 'Self-referencing FK on telehealth_consent (superseded_telehealth_consent_id)',
    `visit_id` BIGINT COMMENT 'Identifier for the clinical encounter or visit associated with this telehealth consent, if applicable.',
    `cms_condition_met` BOOLEAN COMMENT 'Indicates whether this telehealth consent satisfies CMS Conditions of Participation for telehealth service delivery and reimbursement.',
    `consent_document_code` STRING COMMENT 'Unique identifier or reference to the scanned or electronically signed consent document stored in the document management system.',
    `consent_form_version` STRING COMMENT 'Version identifier of the telehealth consent form template used. Enables tracking of consent language changes over time.',
    `consent_language` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the telehealth consent was presented to the patient.. Valid values are `^[a-z]{2}$`',
    `consent_method` STRING COMMENT 'The consent method of the consent telehealth consent record.',
    `consent_obtained_by` STRING COMMENT 'Name or identifier of the staff member, provider, or system that obtained and documented the telehealth consent.',
    `consent_obtained_method` STRING COMMENT 'The method by which the patients telehealth consent was captured (e.g., signed paper form, electronic signature, verbal consent documented in EHR).. Valid values are `written|verbal|electronic|implied`',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent telehealth consent record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this telehealth consent record was first created in the system. Audit trail for record creation.',
    `data_retention_period_days` STRING COMMENT 'Number of days that telehealth session recordings and data will be retained, as disclosed to and consented by the patient.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent telehealth consent record.',
    `emergency_override_applicable` BOOLEAN COMMENT 'Indicates whether this telehealth consent was obtained under emergency circumstances where standard consent procedures were modified per EMTALA or state emergency laws.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent telehealth consent record.',
    `hipaa_authorization_included` BOOLEAN COMMENT 'Indicates whether this telehealth consent includes a HIPAA authorization for use and disclosure of Protected Health Information (PHI) during virtual care.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used during the telehealth consent process to ensure patient understanding.',
    `interstate_compact_applicable` BOOLEAN COMMENT 'Indicates whether an interstate medical licensure compact (e.g., IMLC) applies to this telehealth consent, allowing cross-state practice.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent telehealth consent record.',
    `legal_guardian_name` STRING COMMENT 'Name of the legal guardian who provided consent on behalf of a minor or incapacitated patient.',
    `legal_guardian_relationship` STRING COMMENT 'The relationship of the legal guardian to the patient (e.g., parent, court-appointed guardian, healthcare proxy).. Valid values are `parent|legal_guardian|healthcare_proxy|power_of_attorney|other`',
    `minor_consent_applicable` BOOLEAN COMMENT 'Indicates whether this consent involves a minor patient and requires parental or guardian authorization.',
    `mrn` STRING COMMENT 'The patients medical record number as assigned by the healthcare organization. Used for clinical identification and consent tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to this telehealth consent.',
    `patient_location_state` STRING COMMENT 'Two-letter state code where the patient will be physically located during telehealth services. Determines applicable state telehealth laws.. Valid values are `^[A-Z]{2}$`',
    `provider_licensure_state` STRING COMMENT 'Two-letter state code where the provider holds active medical licensure. Critical for interstate telehealth compliance.. Valid values are `^[A-Z]{2}$`',
    `provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the provider delivering telehealth services. Required for billing and licensure verification.. Valid values are `^[0-9]{10}$`',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Telehealth consent is a specialized type of consent record for virtual care. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes (statu',
    `recording_consent_provided` BOOLEAN COMMENT 'Indicates whether the patient consented to audio or video recording of telehealth sessions for quality, training, or medical record purposes.',
    `right_to_refuse_disclosed` BOOLEAN COMMENT 'Indicates whether the patient was informed of their right to refuse telehealth services and receive in-person care instead.',
    `scope_of_services` STRING COMMENT 'Description of the types of clinical services covered under this telehealth consent (e.g., primary care visits, behavioral health, chronic disease management).',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the consent telehealth consent record.',
    `state_specific_requirements_met` BOOLEAN COMMENT 'Flag indicating whether all state-specific telehealth consent requirements have been satisfied (e.g., informed consent elements, parental consent for minors).',
    `technology_risks_disclosed` BOOLEAN COMMENT 'Indicates whether the patient was informed of technology risks including potential for technical failure, privacy breaches, and limitations of virtual examination.',
    `telehealth_modality` STRING COMMENT 'The type of telehealth technology and interaction method the patient consents to use. Determines the mode of virtual care delivery.. Valid values are `video|audio_only|asynchronous|remote_monitoring|hybrid`',
    `telehealth_platform` STRING COMMENT 'Name or identifier of the telehealth technology platform the patient will use for virtual visits (e.g., Epic MyChart Video, Zoom for Healthcare, Doxy.me).',
    `third_party_disclosure_authorized` BOOLEAN COMMENT 'Indicates whether the patient authorized disclosure of telehealth session information to third parties such as family members, caregivers, or other providers.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this telehealth consent record was last modified. Audit trail for record changes.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'Name of the witness present during consent signing, if required by state law or organizational policy.',
    CONSTRAINT pk_telehealth_consent PRIMARY KEY(`telehealth_consent_id`)
) COMMENT 'Master record for patient consent to receive care via telehealth and virtual care modalities. Captures telehealth platform, modality type (video, audio-only, asynchronous), state-specific consent requirements met, technology risks disclosed, patient right to refuse telehealth and receive in-person care, provider licensure state, and interstate compact applicability. Required by CMS and most state telehealth laws as a condition of telehealth service delivery.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` (
    `minor_consent_id` BIGINT COMMENT 'Unique identifier for the minor consent record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent minor consent record.',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider who obtained and documented the consent.',
    `delegation_id` BIGINT COMMENT 'Reference to the parent or legal guardian providing consent on behalf of the minor, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who last updated this consent record, for audit trail purposes.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the minor patient for whom this consent record applies.',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the consent minor consent record.',
    `superseded_minor_consent_id` BIGINT COMMENT 'Self-referencing FK on minor_consent (superseded_minor_consent_id)',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this consent was obtained, if applicable.',
    `basis` STRING COMMENT 'The legal basis under which consent is being obtained or documented: mature minor doctrine, emancipated minor status, state-specific minor consent laws (e.g., STI treatment, substance abuse, mental health, reproductive health), parental/guardian consent, or court-ordered consent.. Valid values are `mature_minor|emancipated_minor|state_specific_minor_consent|parental_consent|guardian_consent|court_order`',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent minor consent record.',
    `confidentiality_obligation_to_minor_flag` BOOLEAN COMMENT 'Indicates whether the healthcare provider has a legal or ethical obligation to maintain confidentiality of the minors health information from parents/guardians (e.g., when minor consents independently under state law for sensitive services).',
    `consent_document_reference` STRING COMMENT 'Reference identifier or storage location of the signed consent document in the document management system.',
    `consent_form_version` STRING COMMENT 'Version identifier of the consent form or template used to obtain consent, for audit and compliance tracking.',
    `consent_language` STRING COMMENT 'ISO 639-3 three-letter language code indicating the language in which consent was obtained and documented.. Valid values are `^[A-Z]{3}$`',
    `consent_method` STRING COMMENT 'The method by which consent was obtained: written signature, verbal consent (documented), electronic signature, or implied consent.. Valid values are `written|verbal|electronic|implied|not_applicable`',
    `consent_scope_description` STRING COMMENT 'Detailed description of what the consent covers, including specific treatments, procedures, data sharing purposes, or research protocols.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent minor consent record.',
    `court_order_reference_number` STRING COMMENT 'Reference number or case number of the court order governing consent authority or restrictions, if applicable.',
    `court_ordered_consent_restriction_flag` BOOLEAN COMMENT 'Indicates whether there are court-ordered restrictions on who may provide consent for the minor (e.g., one parent prohibited from consenting due to custody order).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was first created in the system.',
    `custodial_parent_verified_flag` BOOLEAN COMMENT 'Indicates whether the consenting parent has been verified as having legal custody and authority to consent on behalf of the minor, particularly important in cases of divorce or separation.',
    `custody_documentation_type` STRING COMMENT 'The type of documentation reviewed to verify custodial parent or guardian status.. Valid values are `court_order|divorce_decree|custody_agreement|birth_certificate|adoption_papers|not_applicable`',
    `data_sharing_scope` STRING COMMENT 'Description of the scope and purpose of data sharing authorized by this consent (e.g., specific recipients, purposes, data elements).',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent minor consent record.',
    `emancipated_minor_flag` BOOLEAN COMMENT 'Indicates whether the minor has been legally emancipated and therefore has full consent rights as an adult.',
    `emancipation_documentation_type` STRING COMMENT 'The type of documentation provided to verify emancipated minor status, if applicable.. Valid values are `court_order|marriage_certificate|military_service|self_supporting_declaration|not_applicable`',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent minor consent record.',
    `guardian_name` STRING COMMENT 'The guardian name of the consent minor consent record.',
    `hie_participation_status` STRING COMMENT 'Indicates whether the minor (or parent/guardian on their behalf) has opted in or out of Health Information Exchange participation.. Valid values are `opted_in|opted_out|not_applicable`',
    `hipaa_authorization_flag` BOOLEAN COMMENT 'Indicates whether this consent includes a HIPAA authorization for use and disclosure of Protected Health Information (PHI) beyond treatment, payment, and healthcare operations.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used during the consent process to ensure understanding.',
    `irb_protocol_number` STRING COMMENT 'The IRB protocol number associated with research consent, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent minor consent record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was last modified.',
    `minor_age_at_consent` STRING COMMENT 'The age of the minor patient at the time consent was obtained, used to determine applicability of age-based consent rules.',
    `minor_assent_obtained_flag` BOOLEAN COMMENT 'Indicates whether the minors assent (agreement) was obtained in addition to parental consent, particularly relevant for research participation and certain clinical procedures.',
    `minor_consenting_independently_flag` BOOLEAN COMMENT 'Indicates whether the minor is providing consent independently without parental/guardian involvement, based on mature minor doctrine, emancipation, or state-specific minor consent rights.',
    `parent_guardian_name` STRING COMMENT 'Full name of the parent or legal guardian providing consent, if applicable.',
    `parental_consent_required_flag` BOOLEAN COMMENT 'Indicates whether parental or guardian consent is required for the treatment or service being provided.',
    `parental_notification_permitted_flag` BOOLEAN COMMENT 'Indicates whether parental notification of the minors care is permitted under applicable law and the minors consent preferences.',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Minor consent is a specialized type of consent record with additional legal requirements for minors. Linking to the core record table enables unified consent management. Core consent lifecycle attribu',
    `research_consent_flag` BOOLEAN COMMENT 'Indicates whether this consent is for participation in research and is subject to Common Rule and IRB oversight.',
    `revocation_reason` STRING COMMENT 'Free-text explanation of why the consent was revoked, if provided.',
    `revoked_by` STRING COMMENT 'Identifies who revoked the consent: the minor themselves, parent, guardian, court order, or system (e.g., automatic expiration).. Valid values are `minor|parent|guardian|court|system|not_applicable`',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the consent minor consent record.',
    `state_specific_minor_consent_category` STRING COMMENT 'The specific category of care for which state law permits minors to consent independently without parental involvement (e.g., sexually transmitted infection treatment, reproductive health services, substance abuse treatment, mental health services). [ENUM-REF-CANDIDATE: sti_treatment|reproductive_health|substance_abuse|mental_health|prenatal_care|sexual_assault|not_applicable — 7 candidates stripped; promote to reference product]',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the consent process, if applicable.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this consent per organizational policy or legal requirement.',
    CONSTRAINT pk_minor_consent PRIMARY KEY(`minor_consent_id`)
) COMMENT 'Master record for consent situations involving minor patients, capturing the complex legal landscape of minor consent rights. Tracks whether the minor is consenting independently (mature minor doctrine, emancipated minor, state-specific minor consent for STI/reproductive health/substance use/mental health), parental/guardian consent details, custodial parent verification, court-ordered consent restrictions, and confidentiality obligations to the minor. Critical for compliance with state minor consent statutes and HIPAA minor exception rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`delegation` (
    `delegation_id` BIGINT COMMENT 'Unique identifier for the consent delegation record. Primary key for the consent delegation entity.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent delegation record.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the individual authorized to provide consent on behalf of the patient. May link to person or contact master record.',
    `delegation_mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom consent delegation authority is being granted. Links to the patient master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or staff member who created the consent delegation record.',
    `quaternary_delegation_revoked_by_user_employee_id` BIGINT COMMENT 'Identifier of the staff member or user who processed the revocation of the delegation authority.',
    `superseded_delegation_id` BIGINT COMMENT 'Self-referencing FK on delegation (superseded_delegation_id)',
    `tertiary_delegation_last_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or staff member who last modified the consent delegation record.',
    `applies_to_minor` BOOLEAN COMMENT 'Boolean flag indicating whether this delegation applies to a minor patient. True if the patient is a minor and the delegate has parental or guardian authority.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent delegation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent delegation record was first created in the system. Used for audit trail and data lineage.',
    `delegate_address_line1` STRING COMMENT 'First line of the delegates mailing address (street address, PO Box).',
    `delegate_address_line2` STRING COMMENT 'Second line of the delegates mailing address (apartment, suite, unit number). Nullable if not applicable.',
    `delegate_city` STRING COMMENT 'City of the delegates mailing address.',
    `delegate_contact_email` STRING COMMENT 'Primary email address for the delegate. Used for electronic communication regarding consent matters.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `delegate_contact_phone` STRING COMMENT 'Primary contact phone number for the delegate. Used to reach the authorized representative for consent decisions.',
    `delegate_country` STRING COMMENT 'Country of the delegates mailing address. Three-letter ISO 3166-1 alpha-3 country code.. Valid values are `USA|CAN|MEX|GBR|AUS|[A-Z]{3}`',
    `delegate_name` STRING COMMENT 'Full legal name of the authorized representative or surrogate decision-maker.',
    `delegate_postal_code` STRING COMMENT 'Postal code or ZIP code of the delegates mailing address.',
    `delegate_relationship` STRING COMMENT 'Relationship of the delegate to the patient (e.g., spouse, parent, legal guardian, healthcare proxy). [ENUM-REF-CANDIDATE: spouse|parent|adult_child|sibling|legal_guardian|healthcare_proxy|power_of_attorney|court_appointed_guardian|next_of_kin|other — 10 candidates stripped; promote to reference product]',
    `delegate_state` STRING COMMENT 'State or province of the delegates mailing address. Two-letter state code for US addresses.',
    `delegation_status` STRING COMMENT 'Current lifecycle status of the delegation authority. Indicates whether the delegation is currently in effect, has been revoked, has expired, or is pending verification.. Valid values are `active|inactive|suspended|revoked|expired|pending_verification`',
    `delegation_type` STRING COMMENT 'Type of legal authority granted to the delegate. Distinguishes between healthcare proxy, durable power of attorney for healthcare (DPOA-HC), legal guardianship, court-appointed guardianship, next-of-kin surrogate per state law, and parental authority for minors.. Valid values are `healthcare_proxy|durable_power_of_attorney|legal_guardian|court_appointed_guardian|next_of_kin_surrogate|parental_authority`',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent delegation record.',
    `effective_end_date` DATE COMMENT 'Date when the delegation authority expires or terminates. Nullable for open-ended delegations. The delegate is no longer authorized to provide consent after this date.',
    `effective_start_date` DATE COMMENT 'Date when the delegation authority becomes effective. The delegate is authorized to provide consent on or after this date.',
    `emergency_contact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the delegate should also be contacted in medical emergencies. True if the delegate is designated as an emergency contact.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent delegation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent delegation record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent delegation record was last modified. Used for audit trail and change tracking.',
    `legal_document_date` DATE COMMENT 'Date the legal document was executed, signed, or issued by the court. Establishes the legal validity timeline.',
    `legal_document_reference` STRING COMMENT 'Reference identifier or location of the supporting legal documentation (e.g., document ID in document management system, court case number, file path). Used to retrieve the original legal instrument.',
    `legal_document_type` STRING COMMENT 'Type of legal documentation supporting the delegation authority (e.g., advance directive, healthcare proxy form, durable power of attorney document, guardianship court order, birth certificate for parental authority). [ENUM-REF-CANDIDATE: advance_directive|healthcare_proxy_form|power_of_attorney_document|guardianship_order|court_order|birth_certificate|other — 7 candidates stripped; promote to reference product]',
    `limitations_description` STRING COMMENT 'Free-text description of any limitations or restrictions on the delegates authority (e.g., cannot consent to experimental treatments, cannot authorize organ donation, specific procedures excluded).',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the delegation authority, verification process, or special circumstances.',
    `priority_order` STRING COMMENT 'Priority ranking when multiple delegates exist for the same patient. Lower numbers indicate higher priority. Used to determine which delegate has primary authority when conflicts arise.',
    `record_number` BIGINT COMMENT 'The record number of the consent delegation record.',
    `revocation_date` DATE COMMENT 'Date when the delegation authority was revoked by the patient, delegate, or legal authority. Nullable if delegation has not been revoked.',
    `revocation_reason` STRING COMMENT 'Free-text explanation of why the delegation authority was revoked (e.g., patient request, delegate resignation, legal change, death of delegate).',
    `scope` STRING COMMENT 'Scope of authority granted to the delegate. Defines what types of consent decisions the delegate is authorized to make (e.g., full medical decisions, treatment consent only, research consent, data sharing, financial decisions, emergency-only). [ENUM-REF-CANDIDATE: full_medical_decisions|treatment_consent_only|research_consent_only|data_sharing_authorization|financial_decisions|limited_scope|emergency_only — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Unique identifier of the delegation record in the source system. Used for data lineage and reconciliation.',
    `verification_date` DATE COMMENT 'Date when the delegation authority was verified by authorized staff. Used for audit and compliance tracking.',
    `verification_status` STRING COMMENT 'Status of verification of the delegation authority and supporting documentation. Indicates whether the legal authority has been confirmed by appropriate staff or legal review.. Valid values are `verified|pending_verification|unverified|verification_failed|expired_verification`',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_delegation PRIMARY KEY(`delegation_id`)
) COMMENT 'Master record for authorized representatives, legal surrogates, and healthcare proxies who have legal authority to provide consent on behalf of a patient. Captures delegate type (healthcare proxy, durable power of attorney for healthcare, legal guardian, court-appointed guardian, next-of-kin surrogate per state law), delegation scope, effective period, supporting legal documentation reference, and priority order when multiple delegates exist. Distinct from patient.proxy_access which governs portal access — this governs clinical consent authority.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`revocation` (
    `revocation_id` BIGINT COMMENT 'Unique identifier for the consent revocation record. Primary key for the consent revocation entity.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent revocation record.',
    `delegation_id` BIGINT COMMENT 'Reference to the authorized representative who submitted the revocation on behalf of the patient, if applicable. Null if patient revoked directly.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is revoking consent or on whose behalf consent is being revoked.',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the consent revocation record.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or system user who received and recorded the consent revocation.',
    `prior_revocation_id` BIGINT COMMENT 'Self-referencing FK on revocation (prior_revocation_id)',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for all actions taken in response to this revocation, maintained for regulatory compliance.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent revocation record.',
    `compliance_notes` STRING COMMENT 'Internal notes regarding compliance considerations, special handling requirements, or regulatory reporting obligations related to this revocation.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent revocation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the consent revocation record.',
    `data_access_restricted_flag` BOOLEAN COMMENT 'Indicates whether data access controls have been updated to restrict access based on the revoked consent.',
    `data_access_restricted_timestamp` TIMESTAMP COMMENT 'The date and time when data access restrictions were implemented in response to the consent revocation.',
    `disclosures_halted_flag` BOOLEAN COMMENT 'Indicates whether ongoing or future disclosures of Protected Health Information (PHI) have been halted as a result of this revocation.',
    `disclosures_halted_timestamp` TIMESTAMP COMMENT 'The date and time when disclosure processes were halted in response to the consent revocation.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the scanned or electronic copy of the signed revocation document, if applicable.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent revocation record.',
    `effective_timestamp` TIMESTAMP COMMENT 'The date and time when the revocation became legally effective and operational systems began enforcing the withdrawal of consent. May differ from revocation_timestamp due to processing delays.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent revocation record.',
    `irrevocable_actions_description` STRING COMMENT 'Free-text description of any actions taken under the original consent that cannot be reversed or undone despite the revocation (e.g., data already shared with third parties, research already conducted).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent revocation record.',
    `legal_review_completed_flag` BOOLEAN COMMENT 'Indicates whether required legal review has been completed for this revocation.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether this revocation requires legal review before being processed (e.g., complex partial revocations, disputes, or high-risk scenarios).',
    `legal_review_timestamp` TIMESTAMP COMMENT 'The date and time when legal review of the revocation was completed.',
    `legal_reviewer_notes` STRING COMMENT 'Confidential notes from legal counsel regarding the revocation review, including any special handling instructions or risk assessments.',
    `method` STRING COMMENT 'The method or channel through which the patient submitted the consent revocation (e.g., written form, verbal communication, patient portal, email, fax, in-person). [ENUM-REF-CANDIDATE: written|verbal|electronic|portal|email|fax|in_person — 7 candidates stripped; promote to reference product]',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of the revocation was sent to relevant parties (providers, research teams, business associates, etc.).',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'The date and time when notifications regarding the consent revocation were sent to affected parties.',
    `partial_revocation_details` STRING COMMENT 'Free-text description of which specific portions of the consent are being revoked when revocation_scope is partial. Null when revocation is full.',
    `patient_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether confirmation notification was sent to the patient acknowledging receipt and processing of their revocation.',
    `patient_notification_timestamp` TIMESTAMP COMMENT 'The date and time when confirmation notification was sent to the patient regarding their consent revocation.',
    `prior_disclosures_count` STRING COMMENT 'The number of disclosures that occurred under the original consent prior to revocation and that cannot be undone or recalled.',
    `prior_disclosures_summary` STRING COMMENT 'Summary description of disclosures that occurred prior to revocation and cannot be undone, maintained for legal audit trail and patient notification.',
    `reason` STRING COMMENT 'Optional free-text explanation provided by the patient describing why they are revoking consent. May be blank if patient chose not to provide a reason.',
    `reason_code` STRING COMMENT 'Standardized categorical code representing the reason for consent revocation, used for reporting and analytics.. Valid values are `patient_request|privacy_concern|no_longer_needed|treatment_complete|other|not_provided`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent revocation record was first created in the data warehouse or lakehouse.',
    `record_number` BIGINT COMMENT 'Reference to the original consent record being revoked. Links to the parent consent that this revocation applies to.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent revocation record was last updated in the data warehouse or lakehouse.',
    `rejection_reason` STRING COMMENT 'Explanation of why the revocation was rejected, if applicable (e.g., invalid signature, unauthorized submitter, incomplete documentation).',
    `revocation_date` DATE COMMENT 'The calendar date on which the patient submitted the consent revocation. This is the effective date from which the consent is considered withdrawn.',
    `revocation_number` STRING COMMENT 'Business-facing unique identifier or tracking number assigned to this consent revocation for reference and audit purposes.',
    `revocation_reason` STRING COMMENT 'The revocation reason of the consent revocation record.',
    `revocation_status` STRING COMMENT 'Current processing status of the consent revocation within the organizations workflow (e.g., pending review, processed and effective, rejected due to invalid submission).. Valid values are `pending|processed|effective|rejected|cancelled`',
    `revocation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consent revocation was submitted or recorded in the system. Provides exact temporal audit trail for legal compliance.',
    `scope` STRING COMMENT 'Indicates whether the revocation applies to the entire consent (full) or only specific portions of the consent (partial).. Valid values are `full|partial`',
    `source_system_code` STRING COMMENT 'The unique identifier for this revocation record in the source operational system.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'Name of the witness who was present when the revocation was submitted, if applicable (e.g., for verbal revocations or in-person submissions).',
    `witness_signature_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was obtained on the revocation document.',
    CONSTRAINT pk_revocation PRIMARY KEY(`revocation_id`)
) COMMENT 'Transactional record of every consent revocation submitted by a patient or their authorized representative. Captures revocation date and time, revocation method (written, verbal, electronic), reason for revocation (if provided), scope of revocation (full or partial), actions taken in response (notifications sent, data access restricted, disclosures halted), and any disclosures that occurred prior to revocation that cannot be undone. Provides the legal audit trail required by HIPAA and state law for consent withdrawal.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` (
    `npp_acknowledgment_id` BIGINT COMMENT 'Unique identifier for the NPP acknowledgment transaction. Primary key.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where the NPP acknowledgment was obtained.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who acknowledged or was presented with the NPP.',
    `notice_of_privacy_practices_id` BIGINT COMMENT 'Foreign key linking to compliance.notice_of_privacy_practices. Business justification: Direct relationship - NPP acknowledgments in consent domain track patient acknowledgment of the NPP document managed in compliance domain. Essential for HIPAA compliance, demonstrating good faith effo',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department within the facility where the NPP acknowledgment was obtained (e.g., registration, emergency department, outpatient clinic).',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or system user who obtained or recorded the NPP acknowledgment.',
    `primary_previous_npp_acknowledgment_id` BIGINT COMMENT 'Identifier of the previous NPP acknowledgment record for this patient, if this is a re-acknowledgment following a material change.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the NPP acknowledgment was obtained, if applicable.',
    `accessibility_accommodation` STRING COMMENT 'Description of any accessibility accommodations provided (e.g., large print, Braille, audio recording, sign language interpreter).',
    `acknowledgment_date` DATE COMMENT 'Date on which the patient acknowledged receipt of the NPP.',
    `acknowledgment_location` STRING COMMENT 'Physical or virtual location where the acknowledgment was obtained. [ENUM-REF-CANDIDATE: registration_desk|patient_room|emergency_department|outpatient_clinic|patient_portal|home|other — 7 candidates stripped; promote to reference product]',
    `acknowledgment_method` STRING COMMENT 'Method by which the patient provided acknowledgment (paper signature, electronic signature, patient portal click-through, email confirmation, kiosk acceptance, verbal acknowledgment documented by staff).. Valid values are `signature_paper|signature_electronic|portal_click|email_confirmation|kiosk_acceptance|verbal_documented`',
    `acknowledgment_status` STRING COMMENT 'Current status of the NPP acknowledgment transaction. Acknowledged indicates patient signed or electronically accepted; unable_to_obtain indicates good-faith effort was made but acknowledgment could not be secured per regulatory allowance.. Valid values are `acknowledged|declined|unable_to_obtain|good_faith_effort_documented|pending|voided`',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the patient acknowledged receipt of the NPP, particularly important for electronic acknowledgments.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent npp acknowledgment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this acknowledgment record was first created in the system.',
    `delivery_method` STRING COMMENT 'Method by which the NPP was delivered to the patient (paper handout, electronic via patient portal, email, kiosk, verbal explanation).. Valid values are `paper|electronic|patient_portal|email|kiosk|verbal`',
    `device_type` STRING COMMENT 'Type of device used for electronic acknowledgment (desktop computer, mobile phone, tablet, kiosk).. Valid values are `desktop|mobile|tablet|kiosk|other`',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent npp acknowledgment record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent npp acknowledgment record.',
    `good_faith_effort_documentation` STRING COMMENT 'Free-text documentation of the good-faith effort made to obtain acknowledgment when it could not be secured.',
    `good_faith_effort_reason` STRING COMMENT 'Reason why acknowledgment could not be obtained despite good-faith effort, as permitted under 45 CFR 164.520(c)(2)(ii).. Valid values are `patient_refused|emergency_treatment|patient_unable_to_sign|language_barrier|patient_left_before_signing|other`',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether an interpreter was used to explain the NPP to the patient.',
    `ip_address` STRING COMMENT 'IP address from which the electronic acknowledgment was submitted, for audit trail purposes.',
    `is_first_service_acknowledgment` BOOLEAN COMMENT 'Indicates whether this acknowledgment was obtained at the first service delivery as required by 45 CFR 164.520(c)(1).',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language in which the NPP was provided to the patient.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent npp acknowledgment record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this acknowledgment record was last modified.',
    `material_change_acknowledgment` BOOLEAN COMMENT 'Indicates whether this acknowledgment was obtained following a material change to the NPP, requiring re-acknowledgment.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the NPP acknowledgment transaction.',
    `patient_portal_session_code` STRING COMMENT 'Session identifier from the patient portal if the acknowledgment was obtained electronically via the portal.',
    `record_number` BIGINT COMMENT 'The record number of the consent npp acknowledgment record.',
    `representative_authority_documented` BOOLEAN COMMENT 'Indicates whether the authority of a personal representative to act on behalf of the patient was documented and verified.',
    `retention_expiration_date` DATE COMMENT 'Date after which this acknowledgment record may be destroyed per retention policy.',
    `retention_period_years` STRING COMMENT 'Number of years this acknowledgment record must be retained per HIPAA record retention requirements (minimum 6 years from creation or last effective date).',
    `revocation_date` DATE COMMENT 'Date on which the acknowledgment was revoked or voided, if applicable.',
    `revocation_reason` STRING COMMENT 'Reason why the acknowledgment was revoked or voided (e.g., administrative error, duplicate entry, patient request).',
    `signature_captured` BOOLEAN COMMENT 'Indicates whether a patient or representative signature was captured as part of the acknowledgment.',
    `signature_type` STRING COMMENT 'Type of signature captured (wet ink on paper, electronic stylus, digital certificate-based, biometric, or none if acknowledgment was obtained without signature).. Valid values are `wet_signature|electronic_signature|digital_signature|biometric|none`',
    `signer_name` STRING COMMENT 'Full name of the individual who signed the acknowledgment (patient or authorized representative).',
    `signer_relationship` STRING COMMENT 'Relationship of the signer to the patient (self if patient signed, or representative role). [ENUM-REF-CANDIDATE: self|parent|legal_guardian|power_of_attorney|healthcare_proxy|personal_representative|other — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Unique identifier of this acknowledgment record in the source system.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_npp_acknowledgment PRIMARY KEY(`npp_acknowledgment_id`)
) COMMENT 'Transactional record of patient acknowledgment of receipt of the organizations HIPAA Notice of Privacy Practices (NPP). Captures acknowledgment date, delivery method (paper, electronic, patient portal), NPP version acknowledged, patient or representative signature, and documentation of good-faith efforts when acknowledgment could not be obtained. Distinct from compliance.notice_of_privacy_practices which tracks the NPP document itself — this tracks the patient-level acknowledgment transaction required by 45 CFR 164.520.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` (
    `restriction_request_id` BIGINT COMMENT 'Unique identifier for the patient consent restriction request record. Primary key.',
    `hie_query_id` BIGINT COMMENT 'Foreign key linking to interoperability.hie_query. Business justification: Patient restriction requests may block specific HIE queries in real-time. When patient restricts disclosure to certain recipients, system must log which HIE queries were denied due to restriction. Req',
    `care_site_id` BIGINT COMMENT 'The healthcare facility where the restriction request was received and processed. Links to the facility master record.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Restriction requests are evaluated against organizational policies defining when restrictions must be honored vs. can be denied. Links requests to governing policies for decision documentation, audit ',
    `employee_id` BIGINT COMMENT 'The identifier of the privacy officer or Health Information Management (HIM) professional responsible for processing and overseeing the restriction request. Links to the workforce/provider master record.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: HIPAA permits patients paying out-of-pocket to request disclosure restrictions to their health plan. Attribute out_of_pocket_payment_verified documents this business requirement. Link enables verifica',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who submitted the restriction request. Links to the patient master record.',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the consent restriction request record.',
    `superseded_restriction_request_id` BIGINT COMMENT 'Self-referencing FK on restriction_request (superseded_restriction_request_id)',
    `visit_id` BIGINT COMMENT 'The encounter during which the restriction request was submitted, if applicable. Links to the encounter master record.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the detailed audit trail of all actions taken on this restriction request, including reviews, decisions, notifications, and enforcement activities.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent restriction request record.',
    `compliance_review_date` DATE COMMENT 'The date of the most recent compliance review of this restriction request to ensure ongoing adherence to HIPAA and HITECH requirements.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent restriction request record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this restriction request record was first created in the system. Used for audit and data lineage purposes.',
    `decision_date` DATE COMMENT 'The date the covered entity made the decision to accept or deny the restriction request.',
    `decision_made_by` STRING COMMENT 'The name or role of the individual or committee who made the decision on the restriction request (e.g., Privacy Officer, HIM Director).',
    `decision_rationale` STRING COMMENT 'The business and regulatory rationale for the organizations decision to accept or deny the restriction request. Required for audit and patient communication.',
    `effective_date` DATE COMMENT 'The date from which the restriction becomes effective and must be honored by the covered entity.',
    `expiration_date` DATE COMMENT 'The date on which the restriction expires, if applicable. Null indicates an indefinite restriction until revoked by the patient or terminated by the organization per regulatory provisions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent restriction request record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this restriction request record was last modified. Used for audit and data lineage purposes.',
    `mrn` STRING COMMENT 'The patients medical record number as recorded at the time of the restriction request. Provides business-level traceability.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the restriction request, including patient concerns, special handling instructions, or escalation details.',
    `operational_instructions` STRING COMMENT 'Detailed operational instructions for clinical, billing, and administrative staff on how to honor the restriction across Electronic Health Record (EHR), Revenue Cycle Management (RCM), Health Information Exchange (HIE), and other systems.',
    `organization_decision` STRING COMMENT 'The covered entitys decision on whether to accept or deny the restriction request. HITECH out-of-pocket restrictions must be accepted; other restrictions are discretionary.. Valid values are `accepted|denied|pending_review|conditionally_accepted|withdrawn`',
    `out_of_pocket_payment_verified` BOOLEAN COMMENT 'Indicates whether the patients claim of out-of-pocket payment has been verified for HITECH mandatory restrictions. True if verified, False if not applicable or not verified.',
    `patient_notification_date` DATE COMMENT 'The date the patient was notified of the organizations decision on the restriction request or any subsequent changes to the restriction status.',
    `patient_notification_method` STRING COMMENT 'The method used to notify the patient of the decision or status change. [ENUM-REF-CANDIDATE: mail|email|patient_portal|phone|in_person|secure_message|other — 7 candidates stripped; promote to reference product]',
    `payment_verification_date` DATE COMMENT 'The date the out-of-pocket payment was verified for HITECH mandatory restrictions, if applicable.',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Consent restriction requests are patient requests to restrict PHI use beyond standard consent. While some restriction requests are general (not tied to specific consent), many relate to a specific con',
    `request_date` DATE COMMENT 'The date the patient submitted the restriction request to the covered entity.',
    `request_method` STRING COMMENT 'The method by which the patient submitted the restriction request. [ENUM-REF-CANDIDATE: written_form|verbal|patient_portal|email|fax|mail|in_person|other — 8 candidates stripped; promote to reference product]',
    `request_number` STRING COMMENT 'Business-assigned unique identifier for the restriction request, used for tracking and reference in correspondence and workflows.',
    `request_status` STRING COMMENT 'The request status value classifying the consent restriction request record.',
    `request_timestamp` TIMESTAMP COMMENT 'The precise date and time the restriction request was received and recorded in the system.',
    `request_type` STRING COMMENT 'The request type value classifying the consent restriction request record.',
    `requesting_party_relationship` STRING COMMENT 'The relationship of the individual submitting the restriction request to the patient, if not the patient themselves.. Valid values are `patient_self|legal_guardian|personal_representative|power_of_attorney|parent_of_minor|other`',
    `restricted_phi_category` STRING COMMENT 'The category of Protected Health Information (PHI) the patient is requesting to restrict. Used for operational filtering and enforcement. [ENUM-REF-CANDIDATE: all_phi|diagnosis_codes|procedure_codes|lab_results|radiology_reports|medication_records|mental_health_records|substance_abuse_records|genetic_information|other — 10 candidates stripped; promote to reference product]',
    `restricted_purpose` STRING COMMENT 'The purpose of use or disclosure that the patient is requesting to restrict (e.g., restrict disclosure for payment purposes to a specific payer). [ENUM-REF-CANDIDATE: treatment|payment|healthcare_operations|research|public_health|all_purposes|other — 7 candidates stripped; promote to reference product]',
    `restricted_recipient_name` STRING COMMENT 'The specific name of the individual, organization, or health plan to whom the restriction applies, if identified by the patient.',
    `restricted_recipient_type` STRING COMMENT 'The type of recipient or entity to whom the patient is requesting disclosure restrictions apply. [ENUM-REF-CANDIDATE: health_plan|family_member|employer|specific_provider|health_information_exchange|research_entity|public_health_authority|other — 8 candidates stripped; promote to reference product]',
    `restriction_scope` STRING COMMENT 'Detailed narrative describing the scope of the requested restriction, including specific Protected Health Information (PHI) data elements, recipients, purposes, or time periods the patient wishes to restrict.',
    `restriction_status` STRING COMMENT 'The current lifecycle status of the restriction. Active restrictions must be enforced across all clinical and administrative systems.. Valid values are `active|expired|revoked_by_patient|terminated_by_organization|superseded|pending_activation`',
    `restriction_type` STRING COMMENT 'The category of restriction requested by the patient. HITECH out-of-pocket payer restriction is mandatory per 45 CFR 164.522(a)(1)(vi); other types are discretionary.. Valid values are `hitech_out_of_pocket_payer_restriction|family_member_disclosure_restriction|specific_data_type_restriction|specific_recipient_restriction|treatment_purpose_restriction|other`',
    `revocation_date` DATE COMMENT 'The date the patient revoked the restriction request, if applicable. Patients may revoke restrictions at any time per HIPAA.',
    `revocation_method` STRING COMMENT 'The method by which the patient revoked the restriction, if applicable. [ENUM-REF-CANDIDATE: written_form|verbal|patient_portal|email|fax|mail|in_person|other — 8 candidates stripped; promote to reference product]',
    `supporting_documentation_reference` STRING COMMENT 'Reference identifier or location of supporting documentation submitted with the restriction request (e.g., signed forms, proof of out-of-pocket payment for HITECH restrictions).',
    `system_enforcement_flag` BOOLEAN COMMENT 'Indicates whether the restriction is actively enforced through automated system controls (True) or requires manual staff intervention (False).',
    `termination_date` DATE COMMENT 'The date the covered entity terminated the restriction, if applicable. Organizations may terminate restrictions under specific circumstances per HIPAA.',
    `termination_reason` STRING COMMENT 'The reason the covered entity terminated the restriction, including regulatory justification and patient notification details.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_restriction_request PRIMARY KEY(`restriction_request_id`)
) COMMENT 'Master record for patient requests to restrict uses and disclosures of their PHI beyond HIPAAs standard permissions. Captures restriction type (restrict disclosure to specific payer when patient paid out-of-pocket per HITECH, restrict sharing with family members, restrict specific data types), requested restriction scope, organizations decision to accept or deny the restriction, effective date, and operational instructions for honoring the restriction across clinical systems. Governed by HITECH Act amendment to HIPAA 45 CFR 164.522.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` (
    `disclosure_log_id` BIGINT COMMENT 'Unique identifier for the consent disclosure log entry. Primary key for the consent disclosure log product.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or location where the disclosure was made. Links to the facility product.',
    `hipaa_authorization_id` BIGINT COMMENT 'Foreign key linking to consent.hipaa_authorization. Business justification: PHI disclosures are frequently made under specific HIPAA authorizations. The disclosure_log currently has authorization_reference (STRING) which should be replaced with a proper FK to hipaa_authorizat',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: HIPAA accounting of disclosures requires linking each disclosure log entry to the actual message transmission event. When PHI is disclosed via HL7/FHIR/Direct, the message_log provides technical proof',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose Protected Health Information (PHI) was disclosed. Links to the patient master product.',
    `parent_disclosure_log_id` BIGINT COMMENT 'Self-referencing FK on disclosure_log (related_disclosure_log_id)',
    `phi_access_log_id` BIGINT COMMENT 'Foreign key linking to compliance.phi_access_log. Business justification: Disclosures based on consent should be traceable to access logs for complete audit trail of PHI movement. Essential for accounting of disclosures, breach investigation, and demonstrating that disclosu',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit associated with this disclosure, if applicable. Links to the encounter product.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent disclosure log record.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent disclosure log record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this disclosure log record was first created in the system. Supports audit trail and data lineage.',
    `department_code` STRING COMMENT 'The code or identifier of the department or unit within the facility that made the disclosure. Supports departmental accountability and reporting.',
    `disclosure_date` DATE COMMENT 'The date on which the Protected Health Information (PHI) disclosure occurred. Required for HIPAA Accounting of Disclosures per 45 CFR 164.528.',
    `disclosure_initiated_by` STRING COMMENT 'The name or identifier of the individual or system that initiated the disclosure. Supports audit trail and accountability.',
    `disclosure_initiated_by_role` STRING COMMENT 'The role or job title of the individual who initiated the disclosure, such as physician, nurse, HIM specialist, or system administrator. Supports role-based access auditing.',
    `disclosure_method` STRING COMMENT 'The method or channel by which the Protected Health Information (PHI) was disclosed. Supports security analysis and breach risk assessment. [ENUM-REF-CANDIDATE: electronic|paper|verbal|fax|secure_email|hie|api|other — 8 candidates stripped; promote to reference product]',
    `disclosure_notes` STRING COMMENT 'Additional notes, comments, or context regarding the disclosure. Provides supplementary information for audit and compliance review.',
    `disclosure_purpose` STRING COMMENT 'The stated purpose or reason for the Protected Health Information (PHI) disclosure. Required for HIPAA Accounting of Disclosures per 45 CFR 164.528.',
    `disclosure_purpose_category` STRING COMMENT 'The standardized category of the disclosure purpose. Enables aggregation and reporting of disclosures by purpose type for compliance and analytics. [ENUM-REF-CANDIDATE: treatment|payment|operations|research|public_health|legal|patient_request|court_order|law_enforcement|other — 10 candidates stripped; promote to reference product]',
    `disclosure_status` STRING COMMENT 'The current status of the disclosure transaction. Tracks the lifecycle state of the disclosure event.. Valid values are `completed|pending|failed|revoked|cancelled`',
    `disclosure_timestamp` TIMESTAMP COMMENT 'The precise date and time when the Protected Health Information (PHI) disclosure occurred. Provides granular audit trail for compliance and security investigations.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent disclosure log record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent disclosure log record.',
    `is_accounting_required` BOOLEAN COMMENT 'Indicates whether this disclosure must be included in the HIPAA Accounting of Disclosures report provided to patients upon request. Non-TPO disclosures are subject to accounting per 45 CFR 164.528.',
    `is_tpo_disclosure` BOOLEAN COMMENT 'Indicates whether the disclosure was made for Treatment, Payment, or Operations (TPO) purposes. TPO disclosures are exempt from HIPAA Accounting of Disclosures requirements per 45 CFR 164.528.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent disclosure log record.',
    `legal_basis` STRING COMMENT 'The legal or regulatory basis that permitted or required the disclosure, such as court order, subpoena, public health reporting requirement, or patient authorization.',
    `minimum_necessary_applied` BOOLEAN COMMENT 'Indicates whether the minimum necessary standard was applied to limit the Protected Health Information (PHI) disclosed to only what was reasonably necessary for the stated purpose, as required by 45 CFR 164.502(b).',
    `modified_by` STRING COMMENT 'The user ID or system identifier that last modified this disclosure log record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this disclosure log record was last modified. Supports audit trail and change tracking.',
    `patient_notification_date` DATE COMMENT 'The date on which the patient was notified of the disclosure, if notification was required. Supports compliance tracking.',
    `patient_notification_required` BOOLEAN COMMENT 'Indicates whether the patient must be notified of this disclosure under HIPAA or organizational policy. Certain disclosures require patient notification.',
    `phi_elements_disclosed` STRING COMMENT 'Description of the specific Protected Health Information (PHI) elements or data categories that were disclosed. Required for HIPAA Accounting of Disclosures.',
    `recipient_address` STRING COMMENT 'The mailing or physical address of the recipient to whom the Protected Health Information (PHI) was disclosed. Required for HIPAA Accounting of Disclosures.',
    `recipient_identifier` STRING COMMENT 'The unique identifier for the recipient, such as National Provider Identifier (NPI), Tax ID, or organizational identifier. Enables precise tracking of disclosure recipients.',
    `recipient_name` STRING COMMENT 'The name of the individual, organization, or entity to whom the Protected Health Information (PHI) was disclosed. Required for HIPAA Accounting of Disclosures.',
    `recipient_type` STRING COMMENT 'The category of recipient to whom the Protected Health Information (PHI) was disclosed. Supports classification and reporting of disclosure patterns. [ENUM-REF-CANDIDATE: individual|organization|government_agency|health_plan|clearinghouse|business_associate|research_institution|public_health_authority|law_enforcement|other — 10 candidates stripped; promote to reference product]',
    `record_number` BIGINT COMMENT 'Reference to the consent or authorization record under which this disclosure was made. Links to the consent product.',
    `system_source` STRING COMMENT 'The name or identifier of the source system or application that recorded the disclosure event, such as Epic EHR, Cerner Millennium, or HIE platform.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this disclosure log record. Supports audit trail and accountability.',
    CONSTRAINT pk_disclosure_log PRIMARY KEY(`disclosure_log_id`)
) COMMENT 'Transactional record of every PHI disclosure made under a patient consent or authorization, providing the accounting of disclosures required by HIPAA. Captures disclosure date, recipient identity and type, purpose of disclosure, PHI elements disclosed, consent or authorization reference, and whether the disclosure was for TPO (exempt from accounting) or non-TPO (subject to accounting). Enables generation of the HIPAA Accounting of Disclosures report provided to patients upon request per 45 CFR 164.528.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` (
    `capacity_assessment_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent capacity assessment record.',
    `clinician_id` BIGINT COMMENT 'Assessing clinician',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `visit_id` BIGINT COMMENT 'FK to encounter',
    `appreciation_score` STRING COMMENT 'Appreciation component score',
    `assessment_date` DATE COMMENT 'Date of assessment',
    `assessment_result` STRING COMMENT 'The assessment result of the consent capacity assessment record.',
    `assessment_tool_used` STRING COMMENT 'Assessment tool/instrument',
    `assessment_type` STRING COMMENT 'Type of capacity assessment',
    `assessor_name` STRING COMMENT 'The assessor name of the consent capacity assessment record.',
    `capacity_determination` STRING COMMENT 'Capacity determination result',
    `clinical_findings` STRING COMMENT 'Clinical findings summary',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent capacity assessment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent capacity assessment record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent capacity assessment record.',
    `expression_score` STRING COMMENT 'Expression component score',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent capacity assessment record.',
    `overall_score` STRING COMMENT 'Overall capacity score',
    `reasoning_score` STRING COMMENT 'Reasoning component score',
    `reassessment_date` DATE COMMENT 'Recommended reassessment date',
    `reassessment_recommended` BOOLEAN COMMENT 'The reassessment recommended of the consent capacity assessment record.',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `surrogate_required` BOOLEAN COMMENT 'Surrogate decision maker needed',
    `understanding_score` STRING COMMENT 'Understanding component score',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_capacity_assessment PRIMARY KEY(`capacity_assessment_id`)
) COMMENT 'Transactional record of formal clinical assessments of a patients decision-making capacity to provide informed consent. Captures assessment date, assessing clinician, assessment tool used (MacCAT-T, Aid to Capacity Evaluation), capacity determination (full capacity, diminished capacity, lacks capacity), specific deficits identified, clinical basis for determination, and whether a surrogate decision-maker was engaged. Required when capacity is in question and critical for legal defensibility of consent obtained from vulnerable populations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` (
    `consent_policy_id` BIGINT COMMENT 'Unique identifier for the consent policy record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent consent policy record.',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Consent policies define which exchange standards are used for consent transmission (HL7 v2.5.1 CON segment, C-CDA Consent Directive, FHIR Consent). Governance requirement to ensure organizational cons',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the consent consent policy record.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Consent-specific policies are often subordinate to or reference broader organizational compliance policies. Establishes policy hierarchy for governance, ensures consent policies align with enterprise ',
    `employee_id` BIGINT COMMENT 'Identifier of the user or role responsible for maintaining and updating this consent policy.',
    `primary_superseded_by_consent_policy_id` BIGINT COMMENT 'Reference to the consent policy that supersedes this policy. Populated when policy status is superseded. Null for active policies.',
    `tertiary_consent_last_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this consent policy record.',
    `applicable_facility_types` STRING COMMENT 'Comma-separated list of facility types where this consent policy applies (e.g., hospital, clinic, outpatient center, research facility, telehealth platform).',
    `applicable_service_lines` STRING COMMENT 'Comma-separated list of clinical service lines or departments where this consent policy applies (e.g., surgery, oncology, cardiology, behavioral health, radiology).',
    `approval_authority` STRING COMMENT 'Name of the organizational body, committee, or individual who approved this consent policy (e.g., Institutional Review Board, Legal Department, Chief Medical Officer, Compliance Committee).',
    `approval_date` DATE COMMENT 'Date when the consent policy was formally approved by the designated approval authority.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent consent policy record.',
    `capacity_assessment_required_flag` BOOLEAN COMMENT 'Indicates whether a formal capacity assessment is required before obtaining consent under this policy. True if capacity assessment is mandatory, False otherwise.',
    `capacity_assessment_triggers` STRING COMMENT 'Specific conditions or circumstances that trigger the requirement for a capacity assessment (e.g., cognitive impairment, altered mental status, high-risk procedure). Multiple triggers separated by semicolons.',
    `consent_category` STRING COMMENT 'Primary category of consent governed by this policy: treatment consent, research consent, data sharing authorization, HIPAA authorization, Health Information Exchange (HIE) opt-in/opt-out, or telehealth consent.. Valid values are `treatment|research|data_sharing|hipaa_authorization|hie|telehealth`',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent consent policy record.',
    `consent_subcategory` STRING COMMENT 'Specific subcategory or type within the primary consent category, providing additional classification granularity (e.g., surgical consent, clinical trial consent, genetic data sharing).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent policy record was first created in the system.',
    `documentation_requirements` STRING COMMENT 'Detailed description of documentation requirements for consent obtained under this policy, including required forms, signatures, attestations, and supporting materials.',
    `effective_date` DATE COMMENT 'Date when the consent policy becomes active and enforceable across the organization.',
    `electronic_signature_enabled_flag` BOOLEAN COMMENT 'Indicates whether electronic signatures are permitted for consent obtained under this policy. True if electronic signatures are allowed, False if only wet signatures are accepted.',
    `expiration_date` DATE COMMENT 'Date when the consent policy expires and is no longer valid. Null for policies without a defined end date.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a qualified interpreter must be provided when the patients primary language differs from the consent form language. True if interpreter is mandatory, False otherwise.',
    `irb_approval_date` DATE COMMENT 'Date when the IRB approved this research consent policy. Null for non-research consent policies.',
    `irb_approval_number` STRING COMMENT 'IRB approval number for research consent policies. Null for non-research consent policies.',
    `irb_expiration_date` DATE COMMENT 'Date when the IRB approval for this research consent policy expires and requires renewal. Null for non-research consent policies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent consent policy record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent policy record was last modified.',
    `legal_representative_allowed_flag` BOOLEAN COMMENT 'Indicates whether a legally authorized representative (LAR) may provide consent on behalf of the patient under this policy. True if LAR consent is permitted, False otherwise.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age (in years) at which an individual can provide independent consent under this policy without parental or guardian authorization. Null if no age restriction applies.',
    `minor_assent_required_flag` BOOLEAN COMMENT 'Indicates whether assent from a minor patient is required in addition to parental consent under this policy. True if minor assent is mandatory, False otherwise.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the consent consent policy record.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the consent policy, used for external reference and system integration.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `policy_description` STRING COMMENT 'Detailed description of the consent policy purpose, scope, and business context.',
    `policy_name` STRING COMMENT 'Human-readable name of the consent policy, used in user interfaces and documentation.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the consent policy: draft (under development), active (in use), suspended (temporarily inactive), retired (no longer used), or superseded (replaced by newer policy).. Valid values are `draft|active|suspended|retired|superseded`',
    `policy_type` STRING COMMENT 'The policy type value classifying the consent consent policy record.',
    `reconsent_interval_months` STRING COMMENT 'Number of months after which consent must be renewed if time-based re-consent is required. Null if time-based re-consent does not apply.',
    `reconsent_trigger_new_risk` BOOLEAN COMMENT 'Indicates whether the discovery of significant new risks triggers the requirement for re-consent under this policy. True if new risk requires re-consent, False otherwise.',
    `reconsent_trigger_protocol_amendment` BOOLEAN COMMENT 'Indicates whether a protocol amendment triggers the requirement for re-consent under this policy (primarily applicable to research consent). True if protocol amendment requires re-consent, False otherwise.',
    `reconsent_trigger_time_based` BOOLEAN COMMENT 'Indicates whether consent expires after a defined time period and requires renewal under this policy. True if time-based re-consent is required, False otherwise.',
    `record_number` BIGINT COMMENT 'The record number of the consent consent policy record.',
    `regulatory_basis` STRING COMMENT 'Primary regulatory framework or legal requirement that mandates or governs this consent policy (e.g., HIPAA Privacy Rule, FDA 21 CFR Part 50, state-specific consent laws).',
    `regulatory_citations` STRING COMMENT 'Specific regulatory citations, statutes, or code sections that apply to this consent policy (e.g., 45 CFR 164.508, 21 CFR 50.25). Multiple citations separated by semicolons.',
    `required_consent_elements` STRING COMMENT 'Comma-separated list of mandatory elements that must be included in consent documentation governed by this policy (e.g., purpose, risks, benefits, alternatives, right to refuse, right to revoke).',
    `retention_period_years` STRING COMMENT 'Number of years that consent documentation governed by this policy must be retained to meet regulatory and legal requirements.',
    `revocation_allowed_flag` BOOLEAN COMMENT 'Indicates whether patients have the right to revoke consent obtained under this policy. True if revocation is permitted, False otherwise.',
    `revocation_instructions` STRING COMMENT 'Instructions and procedures that patients must follow to revoke consent obtained under this policy, including contact information and required documentation.',
    `version_number` STRING COMMENT 'Version identifier for the consent policy, following semantic versioning convention (e.g., 1.0, 2.1, 3.0.1).. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Generic mutation marker',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature is required for consent obtained under this policy. True if witness is mandatory, False otherwise.',
    CONSTRAINT pk_consent_policy PRIMARY KEY(`consent_policy_id`)
) COMMENT 'Reference master defining the organizations enterprise consent policies, rules, and requirements governing each consent type. Captures policy name, consent category governed, required consent elements, minimum age for independent consent, capacity assessment triggers, re-consent triggers (protocol amendment, significant new risk, time-based expiration), documentation requirements, and applicable regulatory citations. Drives consent workflow configuration and ensures consistent consent practice across all care settings and facilities.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`deficiency` (
    `deficiency_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent deficiency record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `visit_id` BIGINT COMMENT 'FK to encounter',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent deficiency record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deficiency_status` STRING COMMENT 'The deficiency status value classifying the consent deficiency record.',
    `deficiency_type` STRING COMMENT 'Type of consent deficiency',
    `deficiency_description` STRING COMMENT 'Description of deficiency',
    `due_date` DATE COMMENT 'Resolution due date',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent deficiency record.',
    `escalation_flag` BOOLEAN COMMENT 'Escalation required',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent deficiency record.',
    `identified_by` STRING COMMENT 'Who identified deficiency',
    `identified_date` DATE COMMENT 'Date deficiency identified',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent deficiency record.',
    `priority_level` STRING COMMENT 'The priority level of the consent deficiency record.',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `resolution_date` DATE COMMENT 'Date resolved',
    `resolution_notes` STRING COMMENT 'The resolution notes of the consent deficiency record.',
    `resolution_status` STRING COMMENT 'Current resolution status',
    `resolved_by` STRING COMMENT 'Who resolved deficiency',
    `resolved_date` DATE COMMENT 'Timestamp capturing the resolved date associated with the consent deficiency record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_deficiency PRIMARY KEY(`deficiency_id`)
) COMMENT 'Transactional record of identified consent deficiencies — instances where required consent was not obtained, was improperly documented, expired, or is otherwise incomplete at the time of care delivery or audit. Captures deficiency type, discovery method (pre-procedure checklist, HIM audit, accreditation survey, patient complaint), responsible provider or department, deficiency status (open, remediated, waived), remediation action taken, and resolution date. Supports HIM, compliance, and quality improvement workflows for consent management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` (
    `substance_use_consent_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Treatment facility',
    `clinician_id` BIGINT COMMENT 'Treating clinician',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the consent substance use consent record.',
    `part2_consent_workflow_part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent workflow part2 consent within the consent substance use consent record.',
    `authorized_recipients` STRING COMMENT 'The authorized recipients of the consent substance use consent record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent substance use consent record.',
    `cfr_42_part2_consent` BOOLEAN COMMENT '42 CFR Part 2 consent',
    `consent_status` STRING COMMENT 'Current consent status',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `disclosure_purpose` STRING COMMENT 'Purpose of disclosure',
    `effective_date` DATE COMMENT 'Consent effective date',
    `expiration_condition` STRING COMMENT 'The expiration condition of the consent substance use consent record.',
    `expiration_date` DATE COMMENT 'Consent expiration date',
    `information_to_disclose` STRING COMMENT 'Information authorized',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent substance use consent record.',
    `part2_covered_flag` BOOLEAN COMMENT 'The part2 covered flag of the consent substance use consent record.',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `redisclosure_notice_provided` BOOLEAN COMMENT 'Redisclosure notice given',
    `revocation_date` DATE COMMENT 'Date revoked',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the consent substance use consent record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_substance_use_consent PRIMARY KEY(`substance_use_consent_id`)
) COMMENT 'Specialized master record for consent and authorization governing disclosure of substance use disorder (SUD) treatment records, which carry heightened federal confidentiality protections beyond standard HIPAA. Captures consent elements required by 42 CFR Part 2 including specific program name, patient name, specific information to be disclosed, purpose of disclosure, recipient, expiration, and right to revoke. Tracks re-disclosure prohibition notices and patient-permitted disclosures for treatment, payment, and operations under the 2020 CARES Act amendments.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` (
    `behavioral_health_consent_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Treatment facility',
    `clinician_id` BIGINT COMMENT 'Treating clinician',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the consent behavioral health consent record.',
    `part2_consent_workflow_part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent workflow part2 consent within the consent behavioral health consent record.',
    `authorized_recipients` STRING COMMENT 'The authorized recipients of the consent behavioral health consent record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent behavioral health consent record.',
    `cfr_42_part2_applicable` BOOLEAN COMMENT '42 CFR Part 2 applies',
    `consent_scope` STRING COMMENT 'The consent scope of the consent behavioral health consent record.',
    `consent_status` STRING COMMENT 'Current status',
    `consent_type` STRING COMMENT 'Type of BH consent',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `disclosure_purpose` STRING COMMENT 'Purpose of disclosure',
    `effective_date` DATE COMMENT 'Consent effective date',
    `expiration_date` DATE COMMENT 'Consent expiration date',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent behavioral health consent record.',
    `mental_health_disclosure_authorized` BOOLEAN COMMENT 'MH disclosure authorized',
    `part2_applicable_flag` BOOLEAN COMMENT 'The part2 applicable flag of the consent behavioral health consent record.',
    `psychotherapy_notes_included` BOOLEAN COMMENT 'The psychotherapy notes included of the consent behavioral health consent record.',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `revocation_date` DATE COMMENT 'Date revoked if applicable',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the consent behavioral health consent record.',
    `sud_disclosure_authorized` BOOLEAN COMMENT 'The sud disclosure authorized of the consent behavioral health consent record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'The witness name of the consent behavioral health consent record.',
    CONSTRAINT pk_behavioral_health_consent PRIMARY KEY(`behavioral_health_consent_id`)
) COMMENT 'Specialized master record for consent governing disclosure of behavioral health, mental health, and psychiatric treatment records, which are subject to state-specific heightened confidentiality protections beyond standard HIPAA. Captures state law basis, specific mental health data elements covered (psychotherapy notes, psychiatric hospitalization, medication for mental illness), authorized recipients, purpose, expiration, and patient-imposed restrictions. Manages the complex intersection of HIPAA psychotherapy note protections and state mental health confidentiality statutes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` (
    `expiration_alert_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent expiration alert record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `alert_date` DATE COMMENT 'Timestamp capturing the alert date associated with the consent expiration alert record.',
    `alert_status` STRING COMMENT 'The alert status value classifying the consent expiration alert record.',
    `alert_trigger_date` DATE COMMENT 'When alert was triggered',
    `alert_type` STRING COMMENT 'Type of expiration alert',
    `consent_expiration_date` DATE COMMENT 'Timestamp capturing the consent expiration date associated with the consent expiration alert record.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent expiration alert record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `days_until_expiration` STRING COMMENT 'The days until expiration of the consent expiration alert record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent expiration alert record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent expiration alert record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent expiration alert record.',
    `notification_method` STRING COMMENT 'Method of notification',
    `notification_sent_date` DATE COMMENT 'Date notification sent',
    `recipient_contact` STRING COMMENT 'Recipient contact info',
    `recipient_type` STRING COMMENT 'Type of recipient',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `renewal_date` DATE COMMENT 'Date renewed',
    `renewal_initiated` BOOLEAN COMMENT 'Renewal process started',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_expiration_alert PRIMARY KEY(`expiration_alert_id`)
) COMMENT 'Operational record tracking consent records approaching or past their expiration date that require patient re-consent or renewal action. Captures consent reference, expiration date, alert generation date, alert type (approaching expiration, expired, renewal required), notification channel used (patient portal, staff worklist, EHR alert), responsible staff member, and resolution status. Drives proactive consent renewal workflows to prevent care delays and compliance gaps from expired consents.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` (
    `genetic_testing_consent_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent genetic testing consent record.',
    `clinician_id` BIGINT COMMENT 'Ordering clinician',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `biobank_storage_authorized` BOOLEAN COMMENT 'The biobank storage authorized of the consent genetic testing consent record.',
    `consent_date` DATE COMMENT 'Date consent obtained',
    `consent_status` STRING COMMENT 'Current consent status',
    `counseling_date` DATE COMMENT 'Date of genetic counseling',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent genetic testing consent record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent genetic testing consent record.',
    `family_disclosure_authorized` BOOLEAN COMMENT 'The family disclosure authorized of the consent genetic testing consent record.',
    `genetic_counseling_completed` BOOLEAN COMMENT 'The genetic counseling completed of the consent genetic testing consent record.',
    `gina_disclosure_acknowledged` BOOLEAN COMMENT 'The gina disclosure acknowledged of the consent genetic testing consent record.',
    `incidental_findings_preference` STRING COMMENT 'The incidental findings preference of the consent genetic testing consent record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent genetic testing consent record.',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `research_use_authorized` BOOLEAN COMMENT 'The research use authorized of the consent genetic testing consent record.',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the consent genetic testing consent record.',
    `test_purpose` STRING COMMENT 'Purpose of testing',
    `test_type` STRING COMMENT 'Type of genetic test',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_genetic_testing_consent PRIMARY KEY(`genetic_testing_consent_id`)
) COMMENT 'Specialized master record for informed consent governing genetic testing, genomic sequencing, and biobanking. Captures test type (diagnostic, predictive, carrier, pharmacogenomic, whole genome sequencing), scope of consent (specific test only, future research use, biobank storage, return of incidental findings), family member implications disclosure, insurance discrimination risk disclosure per GINA, data sharing permissions for research registries, and consent for re-contact as new findings emerge. Governed by GINA, state genetic privacy laws, and ACMG guidelines.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` (
    `photography_media_consent_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent photography media consent record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the consent photography media consent record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `visit_id` BIGINT COMMENT 'FK to encounter',
    `capture_date` DATE COMMENT 'Timestamp capturing the capture date associated with the consent photography media consent record.',
    `clinical_use_authorized` BOOLEAN COMMENT 'The clinical use authorized of the consent photography media consent record.',
    `compensation_provided` BOOLEAN COMMENT 'The compensation provided of the consent photography media consent record.',
    `consent_date` DATE COMMENT 'Date consent obtained',
    `consent_status` STRING COMMENT 'Current consent status',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `education_use_authorized` BOOLEAN COMMENT 'The education use authorized of the consent photography media consent record.',
    `educational_use_authorized` BOOLEAN COMMENT 'The educational use authorized of the consent photography media consent record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent photography media consent record.',
    `expiration_date` DATE COMMENT 'Consent expiration date',
    `identifiable_flag` BOOLEAN COMMENT 'Patient identifiable in media',
    `identity_disclosure_authorized` BOOLEAN COMMENT 'The identity disclosure authorized of the consent photography media consent record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent photography media consent record.',
    `marketing_use_authorized` BOOLEAN COMMENT 'The marketing use authorized of the consent photography media consent record.',
    `media_type` STRING COMMENT 'Type of media',
    `photographer_name` STRING COMMENT 'The photographer name of the consent photography media consent record.',
    `publication_authorized` STRING COMMENT 'The publication authorized of the consent photography media consent record.',
    `publication_use_authorized` BOOLEAN COMMENT 'The publication use authorized of the consent photography media consent record.',
    `purpose` STRING COMMENT 'Purpose of media capture',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `research_use_authorized` BOOLEAN COMMENT 'The research use authorized of the consent photography media consent record.',
    `revocation_date` DATE COMMENT 'Timestamp capturing the revocation date associated with the consent photography media consent record.',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the consent photography media consent record.',
    `social_media_authorized` BOOLEAN COMMENT 'The social media authorized of the consent photography media consent record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `usage_purpose` STRING COMMENT 'The usage purpose of the consent photography media consent record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'The witness name of the consent photography media consent record.',
    CONSTRAINT pk_photography_media_consent PRIMARY KEY(`photography_media_consent_id`)
) COMMENT 'Master record for patient consent to photography, video recording, audio recording, and use of patient images or likeness for clinical, educational, marketing, or research purposes. Captures media type, intended use (clinical documentation, medical education, publication, marketing, social media), scope of consent (identifiable vs. de-identified), distribution channels authorized, expiration, and right to withdraw. Required by HIPAA for any use of patient images beyond direct treatment and by institutional policies governing patient privacy.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` (
    `amendment_request_id` BIGINT COMMENT 'Primary key for amendment request',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent amendment request record.',
    `clinician_id` BIGINT COMMENT 'Reviewing clinician',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the consent amendment request record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the consent amendment request record.',
    `accepted_flag` BOOLEAN COMMENT 'The accepted flag of the consent amendment request record.',
    `amendment_status` STRING COMMENT 'The amendment status value classifying the consent amendment request record.',
    `amendment_type` STRING COMMENT 'The amendment type value classifying the consent amendment request record.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent amendment request record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `decision` STRING COMMENT 'Approval decision',
    `decision_date` DATE COMMENT 'Timestamp capturing the decision date associated with the consent amendment request record.',
    `decision_made_by` STRING COMMENT 'The decision made by of the consent amendment request record.',
    `decision_rationale` STRING COMMENT 'The decision rationale of the consent amendment request record.',
    `decision_reason` STRING COMMENT 'Reason for decision',
    `effective_date` DATE COMMENT 'When amendment takes effect',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent amendment request record.',
    `hipaa_amendment_flag` BOOLEAN COMMENT 'HIPAA amendment indicator',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent amendment request record.',
    `original_content` STRING COMMENT 'Original consent content',
    `proposed_content` STRING COMMENT 'Proposed amended content',
    `record_element_to_amend` STRING COMMENT 'The record element to amend of the consent amendment request record.',
    `record_number` BIGINT COMMENT 'FK to consent record being amended',
    `request_date` DATE COMMENT 'Date amendment requested',
    `request_number` STRING COMMENT 'The request number of the consent amendment request record.',
    `request_reason` STRING COMMENT 'Reason for amendment',
    `request_status` STRING COMMENT 'The request status value classifying the consent amendment request record.',
    `request_type` STRING COMMENT 'Type of amendment requested',
    `requested_amendment_description` STRING COMMENT 'The requested amendment description of the consent amendment request record.',
    `requested_by` STRING COMMENT 'The requested by of the consent amendment request record.',
    `requested_change` STRING COMMENT 'The requested change of the consent amendment request record.',
    `requested_change_description` STRING COMMENT 'The requested change description of the consent amendment request record.',
    `review_date` DATE COMMENT 'Date reviewed',
    `review_status` STRING COMMENT 'Status of review',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_amendment_request PRIMARY KEY(`amendment_request_id`)
) COMMENT 'Transactional record of patient requests to amend their consent records or associated PHI documentation. Captures amendment request date, specific consent record targeted, nature of requested amendment, organizations decision (accepted, denied with reason), amendment effective date, and notification to third parties who received the original consent-based disclosure. Supports HIPAA right to amend under 45 CFR 164.526 and maintains the integrity of the consent audit trail.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`consent_session` (
    `consent_session_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the consent consent session record.',
    `clinician_id` BIGINT COMMENT 'Consenting clinician',
    `form_template_id` BIGINT COMMENT 'Unique identifier for the form template within the consent consent session record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the consent consent session record.',
    `visit_id` BIGINT COMMENT 'FK to encounter',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the consent consent session record.',
    `consent_status` STRING COMMENT 'The consent status value classifying the consent consent session record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `device_type` STRING COMMENT 'The device type value classifying the consent consent session record.',
    `education_provided` STRING COMMENT 'Education materials provided',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the consent consent session record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the consent consent session record.',
    `interpreter_language` STRING COMMENT 'The interpreter language of the consent consent session record.',
    `interpreter_used` BOOLEAN COMMENT 'Interpreter was used',
    `ip_address` STRING COMMENT 'The ip address of the consent consent session record.',
    `language_code` STRING COMMENT 'The language code value classifying the consent consent session record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consent consent session record.',
    `patient_understanding_confirmed` BOOLEAN COMMENT 'Understanding confirmed',
    `questions_asked` STRING COMMENT 'Patient questions documented',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `session_channel` STRING COMMENT 'The session channel of the consent consent session record.',
    `session_date` TIMESTAMP COMMENT 'Timestamp capturing the session date associated with the consent consent session record.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Session end time',
    `session_mode` STRING COMMENT 'In-person, telehealth, etc',
    `session_outcome` STRING COMMENT 'Outcome of session',
    `session_start_timestamp` TIMESTAMP COMMENT 'Session start time',
    `session_status` STRING COMMENT 'The session status value classifying the consent consent session record.',
    `session_type` STRING COMMENT 'Type of consent session',
    `signature_captured` BOOLEAN COMMENT 'The signature captured of the consent consent session record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'The witness name of the consent consent session record.',
    `witness_present` BOOLEAN COMMENT 'Witness was present',
    CONSTRAINT pk_consent_session PRIMARY KEY(`consent_session_id`)
) COMMENT 'Master reference table for consent_session. Referenced by session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_primary_superseded_by_form_template_id` FOREIGN KEY (`primary_superseded_by_form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_superseded_hipaa_authorization_id` FOREIGN KEY (`superseded_hipaa_authorization_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hipaa_authorization`(`hipaa_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_superseded_hie_directive_id` FOREIGN KEY (`superseded_hie_directive_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hie_directive`(`hie_directive_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_superseded_treatment_consent_id` FOREIGN KEY (`superseded_treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_superseded_research_consent_id` FOREIGN KEY (`superseded_research_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`research_consent`(`research_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_superseded_telehealth_consent_id` FOREIGN KEY (`superseded_telehealth_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`telehealth_consent`(`telehealth_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_delegation_id` FOREIGN KEY (`delegation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`delegation`(`delegation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_superseded_minor_consent_id` FOREIGN KEY (`superseded_minor_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`minor_consent`(`minor_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_superseded_delegation_id` FOREIGN KEY (`superseded_delegation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`delegation`(`delegation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_delegation_id` FOREIGN KEY (`delegation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`delegation`(`delegation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_prior_revocation_id` FOREIGN KEY (`prior_revocation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`revocation`(`revocation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_primary_previous_npp_acknowledgment_id` FOREIGN KEY (`primary_previous_npp_acknowledgment_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`npp_acknowledgment`(`npp_acknowledgment_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_superseded_restriction_request_id` FOREIGN KEY (`superseded_restriction_request_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`restriction_request`(`restriction_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_hipaa_authorization_id` FOREIGN KEY (`hipaa_authorization_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hipaa_authorization`(`hipaa_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_parent_disclosure_log_id` FOREIGN KEY (`parent_disclosure_log_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`disclosure_log`(`disclosure_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_primary_superseded_by_consent_policy_id` FOREIGN KEY (`primary_superseded_by_consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`consent` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`consent` SET TAGS ('pii_domain' = 'consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` SET TAGS ('pii_subdomain' = 'consent_governance');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_template_id` SET TAGS ('pii_business_glossary_term' = 'Consent Form Template Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `exchange_standard_id` SET TAGS ('pii_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `primary_superseded_by_form_template_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Template Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `applicable_facility_types` SET TAGS ('pii_business_glossary_term' = 'Applicable Facility Types');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `applicable_service_lines` SET TAGS ('pii_business_glossary_term' = 'Applicable Service Lines');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_category` SET TAGS ('pii_business_glossary_term' = 'Consent Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_subcategory` SET TAGS ('pii_business_glossary_term' = 'Consent Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `created_by_user` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `electronic_signature_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Electronic Signature Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_checksum` SET TAGS ('pii_business_glossary_term' = 'Form Checksum');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_code` SET TAGS ('pii_business_glossary_term' = 'Form Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_document_url` SET TAGS ('pii_business_glossary_term' = 'Form Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('pii_business_glossary_term' = 'Form Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_purpose` SET TAGS ('pii_business_glossary_term' = 'Form Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_status` SET TAGS ('pii_business_glossary_term' = 'Form Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|active|superseded|retired|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `interpreter_required_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_approval_date` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_approval_number` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `legal_representative_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Representative Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `minimum_age_requirement` SET TAGS ('pii_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `minor_assent_required_flag` SET TAGS ('pii_business_glossary_term' = 'Minor Assent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `reading_level` SET TAGS ('pii_business_glossary_term' = 'Reading Level');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `regulatory_basis` SET TAGS ('pii_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `revocation_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Revocation Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `revocation_instructions` SET TAGS ('pii_business_glossary_term' = 'Revocation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `scope_of_consent` SET TAGS ('pii_business_glossary_term' = 'Scope of Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `template_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `template_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `template_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `template_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `template_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `template_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `version_number` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `witness_required_flag` SET TAGS ('pii_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` SET TAGS ('pii_subdomain' = 'authorization_capture');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `hipaa_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Obtaining Staff Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `superseded_hipaa_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Hipaa Authorization Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `superseded_hipaa_authorization_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `authorization_purpose` SET TAGS ('pii_business_glossary_term' = 'Authorization Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `authorization_purpose` SET TAGS ('pii_value_regex' = 'marketing|research|psychotherapy_notes|sale_of_phi|legal_proceeding|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `authorization_purpose_description` SET TAGS ('pii_business_glossary_term' = 'Authorization Purpose Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('pii_business_glossary_term' = 'Compensation Disclosure Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_name` SET TAGS ('pii_business_glossary_term' = 'Disclosing Party Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('pii_business_glossary_term' = 'Disclosing Party National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `expiration_event` SET TAGS ('pii_business_glossary_term' = 'Expiration Event');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `form_version` SET TAGS ('pii_business_glossary_term' = 'Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `irb_approval_number` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_flag` SET TAGS ('pii_business_glossary_term' = 'Personal Representative Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('pii_business_glossary_term' = 'Personal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_relationship` SET TAGS ('pii_business_glossary_term' = 'Personal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_relationship` SET TAGS ('pii_value_regex' = 'parent|legal_guardian|power_of_attorney|executor|healthcare_proxy|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `phi_category` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `phi_description` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `phi_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('pii_business_glossary_term' = 'Recipient Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_organization` SET TAGS ('pii_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_organization` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('pii_business_glossary_term' = 'Redisclosure Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('pii_business_glossary_term' = 'Right to Revoke Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_date` SET TAGS ('pii_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_method` SET TAGS ('pii_business_glossary_term' = 'Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_method` SET TAGS ('pii_value_regex' = 'wet_signature|electronic_signature|digital_signature|patient_portal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Signature Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_signature_date` SET TAGS ('pii_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` SET TAGS ('pii_subdomain' = 'sensitive_directives');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `hie_directive_id` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Directive ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Capturing Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Capturing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `hie_participation_id` SET TAGS ('pii_business_glossary_term' = 'Hie Participation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `superseded_hie_directive_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Hie Directive Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `superseded_hie_directive_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Capturing Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `audit_log_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Log Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `break_glass_events_count` SET TAGS ('pii_business_glossary_term' = 'Break Glass Events Count');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `consent_form_version` SET TAGS ('pii_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `consent_method` SET TAGS ('pii_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `consent_method` SET TAGS ('pii_value_regex' = 'written|verbal|electronic|implied');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `data_type_restrictions` SET TAGS ('pii_business_glossary_term' = 'Data Type Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `directive_type` SET TAGS ('pii_business_glossary_term' = 'Directive Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `directive_type` SET TAGS ('pii_value_regex' = 'opt_in|opt_out|opt_out_with_exceptions|conditional');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `emergency_access_override` SET TAGS ('pii_business_glossary_term' = 'Emergency Access Override');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `federal_override_applicable` SET TAGS ('pii_business_glossary_term' = 'Federal Override Applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `interpreter_used` SET TAGS ('pii_business_glossary_term' = 'Interpreter Used');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `last_break_glass_date` SET TAGS ('pii_business_glossary_term' = 'Last Break Glass Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `last_verified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_business_glossary_term' = 'Legal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_relationship` SET TAGS ('pii_business_glossary_term' = 'Legal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `patient_education_provided` SET TAGS ('pii_business_glossary_term' = 'Patient Education Provided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `patient_instructions` SET TAGS ('pii_business_glossary_term' = 'Patient Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `provider_restrictions` SET TAGS ('pii_business_glossary_term' = 'Provider Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `purpose_of_use_restrictions` SET TAGS ('pii_business_glossary_term' = 'Purpose of Use Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `scope_of_sharing` SET TAGS ('pii_business_glossary_term' = 'Scope of Sharing');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `scope_of_sharing` SET TAGS ('pii_value_regex' = 'all_records|specific_data_types|specific_providers|emergency_only|treatment_only');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `state_jurisdiction` SET TAGS ('pii_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `state_jurisdiction` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `state_jurisdiction` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `state_jurisdiction` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `state_jurisdiction` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `state_jurisdiction` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `state_jurisdiction` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_signature_date` SET TAGS ('pii_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` SET TAGS ('pii_subdomain' = 'authorization_capture');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessed By Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Treatment Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Performing Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `alternatives_documented` SET TAGS ('pii_business_glossary_term' = 'Alternatives Documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `benefits_documented` SET TAGS ('pii_business_glossary_term' = 'Benefits Documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('pii_business_glossary_term' = 'Capacity Determination');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('pii_value_regex' = 'patient_has_capacity|patient_lacks_capacity|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_document_location` SET TAGS ('pii_business_glossary_term' = 'Consent Document Location');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_form_number` SET TAGS ('pii_business_glossary_term' = 'Consent Form Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_method` SET TAGS ('pii_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_method` SET TAGS ('pii_value_regex' = 'written|verbal|electronic|telephonic');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_version` SET TAGS ('pii_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `emergency_exception_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Exception Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `emergency_exception_justification` SET TAGS ('pii_business_glossary_term' = 'Emergency Exception Justification');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_language` SET TAGS ('pii_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_required_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `last_updated_datetime` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_business_glossary_term' = 'Legal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('pii_business_glossary_term' = 'Legal Representative Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_relationship` SET TAGS ('pii_business_glossary_term' = 'Legal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_relationship` SET TAGS ('pii_value_regex' = 'parent|guardian|healthcare_proxy|power_of_attorney|spouse|next_of_kin');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_required_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Representative Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Questions Addressed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_notes` SET TAGS ('pii_business_glossary_term' = 'Patient Questions Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('pii_business_glossary_term' = 'Revoked By Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `risks_documented` SET TAGS ('pii_business_glossary_term' = 'Risks Documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `special_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('pii_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_role` SET TAGS ('pii_business_glossary_term' = 'Witness Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` SET TAGS ('pii_subdomain' = 'authorization_capture');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `research_consent_id` SET TAGS ('pii_business_glossary_term' = 'Research Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Consenting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Study ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `superseded_research_consent_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Research Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `superseded_research_consent_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `cda_document_id` SET TAGS ('pii_business_glossary_term' = 'Transmitted Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `biospecimen_collection_authorized` SET TAGS ('pii_business_glossary_term' = 'Biospecimen Collection Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `biospecimen_collection_authorized` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `biospecimen_collection_authorized` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `biospecimen_collection_authorized` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `biospecimen_collection_authorized` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `biospecimen_collection_authorized` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `biospecimen_collection_authorized` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `biospecimen_collection_authorized` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `comprehension_assessment_method` SET TAGS ('pii_business_glossary_term' = 'Comprehension Assessment Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `comprehension_assessment_result` SET TAGS ('pii_business_glossary_term' = 'Comprehension Assessment Result');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `comprehension_assessment_result` SET TAGS ('pii_value_regex' = 'adequate|inadequate|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_discussion_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Consent Discussion Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_document_url` SET TAGS ('pii_business_glossary_term' = 'Consent Document URL');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_form_version` SET TAGS ('pii_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_language` SET TAGS ('pii_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_location` SET TAGS ('pii_business_glossary_term' = 'Consent Location');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_method` SET TAGS ('pii_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_method` SET TAGS ('pii_value_regex' = 'in_person|telehealth|electronic|written');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Consenting Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `contact_for_future_studies_authorized` SET TAGS ('pii_business_glossary_term' = 'Contact for Future Studies Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `data_sharing_authorized` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `electronic_signature_code` SET TAGS ('pii_business_glossary_term' = 'Electronic Signature ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `future_research_authorized` SET TAGS ('pii_business_glossary_term' = 'Future Research Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('pii_business_glossary_term' = 'Genetic Testing Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `hipaa_authorization_included` SET TAGS ('pii_business_glossary_term' = 'HIPAA Authorization Included');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `interpreter_used` SET TAGS ('pii_business_glossary_term' = 'Interpreter Used');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `irb_protocol_number` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Legally Authorized Representative (LAR) Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_business_glossary_term' = 'Legally Authorized Representative (LAR) Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_relationship` SET TAGS ('pii_business_glossary_term' = 'Legally Authorized Representative (LAR) Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_used` SET TAGS ('pii_business_glossary_term' = 'Legally Authorized Representative (LAR) Used');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `minor_assent_date` SET TAGS ('pii_business_glossary_term' = 'Minor Assent Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `minor_assent_obtained` SET TAGS ('pii_business_glossary_term' = 'Minor Assent Obtained');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `reconsent_date` SET TAGS ('pii_business_glossary_term' = 'Reconsent Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `reconsent_reason` SET TAGS ('pii_business_glossary_term' = 'Reconsent Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `reconsent_required` SET TAGS ('pii_business_glossary_term' = 'Reconsent Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `return_of_results_requested` SET TAGS ('pii_business_glossary_term' = 'Return of Results Requested');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `study_arm` SET TAGS ('pii_business_glossary_term' = 'Study Arm');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `subject_comprehension_assessed` SET TAGS ('pii_business_glossary_term' = 'Subject Comprehension Assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_required` SET TAGS ('pii_business_glossary_term' = 'Witness Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` SET TAGS ('pii_subdomain' = 'authorization_capture');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_business_glossary_term' = 'Telehealth Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Telehealth Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `cms_condition_met` SET TAGS ('pii_business_glossary_term' = 'CMS Condition Met');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `cms_condition_met` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `cms_condition_met` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `cms_condition_met` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `cms_condition_met` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `cms_condition_met` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `cms_condition_met` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `cms_condition_met` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_document_code` SET TAGS ('pii_business_glossary_term' = 'Consent Document ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_form_version` SET TAGS ('pii_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_language` SET TAGS ('pii_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_language` SET TAGS ('pii_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_obtained_by` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_obtained_method` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_obtained_method` SET TAGS ('pii_value_regex' = 'written|verbal|electronic|implied');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `data_retention_period_days` SET TAGS ('pii_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `emergency_override_applicable` SET TAGS ('pii_business_glossary_term' = 'Emergency Override Applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `hipaa_authorization_included` SET TAGS ('pii_business_glossary_term' = 'HIPAA Authorization Included');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interpreter_used` SET TAGS ('pii_business_glossary_term' = 'Interpreter Used');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interstate_compact_applicable` SET TAGS ('pii_business_glossary_term' = 'Interstate Compact Applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interstate_compact_applicable` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interstate_compact_applicable` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interstate_compact_applicable` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interstate_compact_applicable` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interstate_compact_applicable` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interstate_compact_applicable` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('pii_business_glossary_term' = 'Legal Guardian Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_relationship` SET TAGS ('pii_business_glossary_term' = 'Legal Guardian Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_relationship` SET TAGS ('pii_value_regex' = 'parent|legal_guardian|healthcare_proxy|power_of_attorney|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `minor_consent_applicable` SET TAGS ('pii_business_glossary_term' = 'Minor Consent Applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('pii_business_glossary_term' = 'Patient Location State');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('pii_business_glossary_term' = 'Provider Licensure State');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `recording_consent_provided` SET TAGS ('pii_business_glossary_term' = 'Recording Consent Provided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `right_to_refuse_disclosed` SET TAGS ('pii_business_glossary_term' = 'Right to Refuse Disclosed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `scope_of_services` SET TAGS ('pii_business_glossary_term' = 'Scope of Services');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `state_specific_requirements_met` SET TAGS ('pii_business_glossary_term' = 'State-Specific Requirements Met');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `state_specific_requirements_met` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `state_specific_requirements_met` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `state_specific_requirements_met` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `state_specific_requirements_met` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `state_specific_requirements_met` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `state_specific_requirements_met` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `technology_risks_disclosed` SET TAGS ('pii_business_glossary_term' = 'Technology Risks Disclosed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('pii_business_glossary_term' = 'Telehealth Modality');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('pii_value_regex' = 'video|audio_only|asynchronous|remote_monitoring|hybrid');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `third_party_disclosure_authorized` SET TAGS ('pii_business_glossary_term' = 'Third-Party Disclosure Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` SET TAGS ('pii_subdomain' = 'sensitive_directives');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consent_id` SET TAGS ('pii_business_glossary_term' = 'Minor Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Consenting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `delegation_id` SET TAGS ('pii_business_glossary_term' = 'Parent/Guardian ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `superseded_minor_consent_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Minor Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `superseded_minor_consent_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `basis` SET TAGS ('pii_business_glossary_term' = 'Minor Consent Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `basis` SET TAGS ('pii_value_regex' = 'mature_minor|emancipated_minor|state_specific_minor_consent|parental_consent|guardian_consent|court_order');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `confidentiality_obligation_to_minor_flag` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Obligation to Minor Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_document_reference` SET TAGS ('pii_business_glossary_term' = 'Consent Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_form_version` SET TAGS ('pii_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_language` SET TAGS ('pii_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_language` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_method` SET TAGS ('pii_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_method` SET TAGS ('pii_value_regex' = 'written|verbal|electronic|implied|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_scope_description` SET TAGS ('pii_business_glossary_term' = 'Consent Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `court_order_reference_number` SET TAGS ('pii_business_glossary_term' = 'Court Order Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `court_order_reference_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `court_ordered_consent_restriction_flag` SET TAGS ('pii_business_glossary_term' = 'Court-Ordered Consent Restriction Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `custodial_parent_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Custodial Parent Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `custody_documentation_type` SET TAGS ('pii_business_glossary_term' = 'Custody Documentation Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `custody_documentation_type` SET TAGS ('pii_value_regex' = 'court_order|divorce_decree|custody_agreement|birth_certificate|adoption_papers|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `data_sharing_scope` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `emancipated_minor_flag` SET TAGS ('pii_business_glossary_term' = 'Emancipated Minor Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `emancipation_documentation_type` SET TAGS ('pii_business_glossary_term' = 'Emancipation Documentation Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `emancipation_documentation_type` SET TAGS ('pii_value_regex' = 'court_order|marriage_certificate|military_service|self_supporting_declaration|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `hie_participation_status` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `hie_participation_status` SET TAGS ('pii_value_regex' = 'opted_in|opted_out|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `hipaa_authorization_flag` SET TAGS ('pii_business_glossary_term' = 'HIPAA Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `interpreter_used_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `irb_protocol_number` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_age_at_consent` SET TAGS ('pii_business_glossary_term' = 'Minor Age at Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_assent_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Minor Assent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('pii_business_glossary_term' = 'Minor Consenting Independently Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('pii_business_glossary_term' = 'Parent/Guardian Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parental_consent_required_flag` SET TAGS ('pii_business_glossary_term' = 'Parental Consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parental_notification_permitted_flag` SET TAGS ('pii_business_glossary_term' = 'Parental Notification Permitted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `research_consent_flag` SET TAGS ('pii_business_glossary_term' = 'Research Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `revocation_reason` SET TAGS ('pii_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `revoked_by` SET TAGS ('pii_business_glossary_term' = 'Revoked By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `revoked_by` SET TAGS ('pii_value_regex' = 'minor|parent|guardian|court|system|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `state_specific_minor_consent_category` SET TAGS ('pii_business_glossary_term' = 'State-Specific Minor Consent Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `state_specific_minor_consent_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `state_specific_minor_consent_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `state_specific_minor_consent_category` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `state_specific_minor_consent_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `state_specific_minor_consent_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `state_specific_minor_consent_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('pii_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` SET TAGS ('pii_subdomain' = 'patient_rights');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_id` SET TAGS ('pii_business_glossary_term' = 'Consent Delegation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Delegate Person Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `quaternary_delegation_revoked_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Revoked By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `quaternary_delegation_revoked_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `quaternary_delegation_revoked_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `superseded_delegation_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Delegation Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `superseded_delegation_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `tertiary_delegation_last_updated_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Updated By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `tertiary_delegation_last_updated_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `tertiary_delegation_last_updated_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `applies_to_minor` SET TAGS ('pii_business_glossary_term' = 'Applies to Minor Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('pii_business_glossary_term' = 'Delegate Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('pii_business_glossary_term' = 'Delegate Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('pii_business_glossary_term' = 'Delegate City');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('pii_business_glossary_term' = 'Delegate Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Delegate Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_country` SET TAGS ('pii_business_glossary_term' = 'Delegate Country');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_country` SET TAGS ('pii_value_regex' = 'USA|CAN|MEX|GBR|AUS|[A-Z]{3}');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('pii_business_glossary_term' = 'Delegate Full Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('pii_business_glossary_term' = 'Delegate Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_relationship` SET TAGS ('pii_business_glossary_term' = 'Delegate Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('pii_business_glossary_term' = 'Delegate State or Province');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_status` SET TAGS ('pii_business_glossary_term' = 'Delegation Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|revoked|expired|pending_verification');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_type` SET TAGS ('pii_business_glossary_term' = 'Delegation Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_type` SET TAGS ('pii_value_regex' = 'healthcare_proxy|durable_power_of_attorney|legal_guardian|court_appointed_guardian|next_of_kin_surrogate|parental_authority');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `emergency_contact_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `legal_document_date` SET TAGS ('pii_business_glossary_term' = 'Legal Document Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `legal_document_reference` SET TAGS ('pii_business_glossary_term' = 'Legal Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `legal_document_reference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `legal_document_type` SET TAGS ('pii_business_glossary_term' = 'Legal Document Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `limitations_description` SET TAGS ('pii_business_glossary_term' = 'Limitations Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `priority_order` SET TAGS ('pii_business_glossary_term' = 'Priority Order');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `revocation_date` SET TAGS ('pii_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `revocation_reason` SET TAGS ('pii_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Delegation Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|pending_verification|unverified|verification_failed|expired_verification');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` SET TAGS ('pii_subdomain' = 'patient_rights');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_id` SET TAGS ('pii_business_glossary_term' = 'Consent Revocation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `delegation_id` SET TAGS ('pii_business_glossary_term' = 'Authorized Representative Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Received By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_revocation_id` SET TAGS ('pii_business_glossary_term' = 'Prior Revocation Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_revocation_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `compliance_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `data_access_restricted_flag` SET TAGS ('pii_business_glossary_term' = 'Data Access Restricted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `data_access_restricted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Data Access Restricted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `disclosures_halted_flag` SET TAGS ('pii_business_glossary_term' = 'Disclosures Halted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `disclosures_halted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Disclosures Halted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Revocation Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `effective_timestamp` SET TAGS ('pii_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `irrevocable_actions_description` SET TAGS ('pii_business_glossary_term' = 'Irrevocable Actions Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_review_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_review_required_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Legal Review Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_reviewer_notes` SET TAGS ('pii_business_glossary_term' = 'Legal Reviewer Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_reviewer_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Revocation Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `notification_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `partial_revocation_details` SET TAGS ('pii_business_glossary_term' = 'Partial Revocation Details');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_disclosures_count` SET TAGS ('pii_business_glossary_term' = 'Prior Disclosures Count');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_disclosures_summary` SET TAGS ('pii_business_glossary_term' = 'Prior Disclosures Summary');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Revocation Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `reason_code` SET TAGS ('pii_value_regex' = 'patient_request|privacy_concern|no_longer_needed|treatment_complete|other|not_provided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_date` SET TAGS ('pii_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_number` SET TAGS ('pii_business_glossary_term' = 'Revocation Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_status` SET TAGS ('pii_business_glossary_term' = 'Revocation Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_status` SET TAGS ('pii_value_regex' = 'pending|processed|effective|rejected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Revocation Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `scope` SET TAGS ('pii_value_regex' = 'full|partial');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_signature_flag` SET TAGS ('pii_business_glossary_term' = 'Witness Signature Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` SET TAGS ('pii_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `npp_acknowledgment_id` SET TAGS ('pii_business_glossary_term' = 'Notice of Privacy Practices (NPP) Acknowledgment ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `notice_of_privacy_practices_id` SET TAGS ('pii_business_glossary_term' = 'Notice Of Privacy Practices Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Obtained By User ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `primary_previous_npp_acknowledgment_id` SET TAGS ('pii_business_glossary_term' = 'Previous Notice of Privacy Practices (NPP) Acknowledgment ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `accessibility_accommodation` SET TAGS ('pii_business_glossary_term' = 'Accessibility Accommodation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_location` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Location');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('pii_value_regex' = 'signature_paper|signature_electronic|portal_click|email_confirmation|kiosk_acceptance|verbal_documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_value_regex' = 'acknowledged|declined|unable_to_obtain|good_faith_effort_documented|pending|voided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'paper|electronic|patient_portal|email|kiosk|verbal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('pii_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('pii_value_regex' = 'desktop|mobile|tablet|kiosk|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `good_faith_effort_documentation` SET TAGS ('pii_business_glossary_term' = 'Good Faith Effort Documentation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `good_faith_effort_reason` SET TAGS ('pii_business_glossary_term' = 'Good Faith Effort Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `good_faith_effort_reason` SET TAGS ('pii_value_regex' = 'patient_refused|emergency_treatment|patient_unable_to_sign|language_barrier|patient_left_before_signing|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `interpreter_used` SET TAGS ('pii_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('pii_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `is_first_service_acknowledgment` SET TAGS ('pii_business_glossary_term' = 'Is First Service Acknowledgment Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `material_change_acknowledgment` SET TAGS ('pii_business_glossary_term' = 'Material Change Acknowledgment Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `patient_portal_session_code` SET TAGS ('pii_business_glossary_term' = 'Patient Portal Session ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `representative_authority_documented` SET TAGS ('pii_business_glossary_term' = 'Representative Authority Documented Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `retention_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `revocation_date` SET TAGS ('pii_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `revocation_reason` SET TAGS ('pii_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signature_captured` SET TAGS ('pii_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signature_type` SET TAGS ('pii_business_glossary_term' = 'Signature Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signature_type` SET TAGS ('pii_value_regex' = 'wet_signature|electronic_signature|digital_signature|biometric|none');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('pii_business_glossary_term' = 'Signer Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_relationship` SET TAGS ('pii_business_glossary_term' = 'Signer Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` SET TAGS ('pii_subdomain' = 'patient_rights');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_request_id` SET TAGS ('pii_business_glossary_term' = 'Consent Restriction Request ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `hie_query_id` SET TAGS ('pii_business_glossary_term' = 'Blocked Hie Query Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Privacy Officer ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `superseded_restriction_request_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Restriction Request Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `superseded_restriction_request_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `compliance_review_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_made_by` SET TAGS ('pii_business_glossary_term' = 'Decision Made By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_rationale` SET TAGS ('pii_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Restriction Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Restriction Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Restriction Request Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `operational_instructions` SET TAGS ('pii_business_glossary_term' = 'Operational Instructions for Restriction Enforcement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `organization_decision` SET TAGS ('pii_business_glossary_term' = 'Organization Decision on Restriction Request');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `organization_decision` SET TAGS ('pii_value_regex' = 'accepted|denied|pending_review|conditionally_accepted|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `out_of_pocket_payment_verified` SET TAGS ('pii_business_glossary_term' = 'Out-of-Pocket Payment Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_date` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_method` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `payment_verification_date` SET TAGS ('pii_business_glossary_term' = 'Payment Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Request Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_method` SET TAGS ('pii_business_glossary_term' = 'Request Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_number` SET TAGS ('pii_business_glossary_term' = 'Restriction Request Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Request Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('pii_business_glossary_term' = 'Requesting Party Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('pii_value_regex' = 'patient_self|legal_guardian|personal_representative|power_of_attorney|parent_of_minor|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_phi_category` SET TAGS ('pii_business_glossary_term' = 'Restricted Protected Health Information (PHI) Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_purpose` SET TAGS ('pii_business_glossary_term' = 'Restricted Purpose of Use or Disclosure');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('pii_business_glossary_term' = 'Restricted Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_type` SET TAGS ('pii_business_glossary_term' = 'Restricted Recipient Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_scope` SET TAGS ('pii_business_glossary_term' = 'Restriction Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_status` SET TAGS ('pii_business_glossary_term' = 'Restriction Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_status` SET TAGS ('pii_value_regex' = 'active|expired|revoked_by_patient|terminated_by_organization|superseded|pending_activation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_type` SET TAGS ('pii_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_type` SET TAGS ('pii_value_regex' = 'hitech_out_of_pocket_payer_restriction|family_member_disclosure_restriction|specific_data_type_restriction|specific_recipient_restriction|treatment_purpose_restriction|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `revocation_date` SET TAGS ('pii_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `revocation_method` SET TAGS ('pii_business_glossary_term' = 'Revocation Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `system_enforcement_flag` SET TAGS ('pii_business_glossary_term' = 'System Enforcement Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` SET TAGS ('pii_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_log_id` SET TAGS ('pii_business_glossary_term' = 'Consent Disclosure Log ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `hipaa_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Hipaa Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `parent_disclosure_log_id` SET TAGS ('pii_business_glossary_term' = 'Related Disclosure Log Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `parent_disclosure_log_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_access_log_id` SET TAGS ('pii_business_glossary_term' = 'Phi Access Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_date` SET TAGS ('pii_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_initiated_by` SET TAGS ('pii_business_glossary_term' = 'Disclosure Initiated By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_initiated_by_role` SET TAGS ('pii_business_glossary_term' = 'Disclosure Initiated By Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_method` SET TAGS ('pii_business_glossary_term' = 'Disclosure Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_notes` SET TAGS ('pii_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_purpose` SET TAGS ('pii_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_purpose_category` SET TAGS ('pii_business_glossary_term' = 'Disclosure Purpose Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_status` SET TAGS ('pii_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_status` SET TAGS ('pii_value_regex' = 'completed|pending|failed|revoked|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_timestamp` SET TAGS ('pii_business_glossary_term' = 'Disclosure Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('pii_business_glossary_term' = 'Is Accounting Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_tpo_disclosure` SET TAGS ('pii_business_glossary_term' = 'Is Treatment Payment Operations (TPO) Disclosure');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `legal_basis` SET TAGS ('pii_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `minimum_necessary_applied` SET TAGS ('pii_business_glossary_term' = 'Minimum Necessary Applied');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_date` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_required` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_elements_disclosed` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Elements Disclosed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_elements_disclosed` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_elements_disclosed` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_business_glossary_term' = 'Recipient Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('pii_business_glossary_term' = 'Recipient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_type` SET TAGS ('pii_business_glossary_term' = 'Recipient Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `system_source` SET TAGS ('pii_business_glossary_term' = 'System Source');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` SET TAGS ('pii_subdomain' = 'patient_rights');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_determination` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_determination` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_determination` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_determination` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_determination` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_determination` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `clinical_findings` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `clinical_findings` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `clinical_findings` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `clinical_findings` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `clinical_findings` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `clinical_findings` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `clinical_findings` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` SET TAGS ('pii_subdomain' = 'consent_governance');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `consent_policy_id` SET TAGS ('pii_business_glossary_term' = 'Consent Policy Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `exchange_standard_id` SET TAGS ('pii_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Parent Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Policy Owner User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `primary_superseded_by_consent_policy_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Policy Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `tertiary_consent_last_updated_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Updated By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `tertiary_consent_last_updated_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `tertiary_consent_last_updated_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `applicable_facility_types` SET TAGS ('pii_business_glossary_term' = 'Applicable Facility Types');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `applicable_service_lines` SET TAGS ('pii_business_glossary_term' = 'Applicable Service Lines');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_triggers` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Triggers');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_triggers` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_triggers` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_triggers` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_triggers` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_triggers` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_triggers` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `consent_category` SET TAGS ('pii_business_glossary_term' = 'Consent Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `consent_category` SET TAGS ('pii_value_regex' = 'treatment|research|data_sharing|hipaa_authorization|hie|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `consent_subcategory` SET TAGS ('pii_business_glossary_term' = 'Consent Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `documentation_requirements` SET TAGS ('pii_business_glossary_term' = 'Documentation Requirements');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `electronic_signature_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Electronic Signature Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `interpreter_required_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `irb_approval_date` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `irb_approval_number` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `irb_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `legal_representative_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Representative Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `minimum_age_requirement` SET TAGS ('pii_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `minor_assent_required_flag` SET TAGS ('pii_business_glossary_term' = 'Minor Assent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_code` SET TAGS ('pii_business_glossary_term' = 'Policy Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_description` SET TAGS ('pii_business_glossary_term' = 'Policy Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_business_glossary_term' = 'Policy Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_status` SET TAGS ('pii_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|retired|superseded');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `reconsent_interval_months` SET TAGS ('pii_business_glossary_term' = 'Reconsent Interval Months');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `reconsent_trigger_new_risk` SET TAGS ('pii_business_glossary_term' = 'Reconsent Trigger New Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `reconsent_trigger_protocol_amendment` SET TAGS ('pii_business_glossary_term' = 'Reconsent Trigger Protocol Amendment Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `reconsent_trigger_time_based` SET TAGS ('pii_business_glossary_term' = 'Reconsent Trigger Time-Based Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('pii_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `regulatory_citations` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citations');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `required_consent_elements` SET TAGS ('pii_business_glossary_term' = 'Required Consent Elements');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `revocation_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Revocation Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `revocation_instructions` SET TAGS ('pii_business_glossary_term' = 'Revocation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `version_number` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `witness_required_flag` SET TAGS ('pii_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` SET TAGS ('pii_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` SET TAGS ('pii_subdomain' = 'sensitive_directives');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `expiration_condition` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `expiration_condition` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `expiration_condition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `expiration_condition` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `expiration_condition` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `expiration_condition` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `expiration_condition` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` SET TAGS ('pii_subdomain' = 'sensitive_directives');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_disclosure_authorized` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_disclosure_authorized` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_disclosure_authorized` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_disclosure_authorized` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_disclosure_authorized` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_disclosure_authorized` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_disclosure_authorized` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_disclosure_authorized` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_disclosure_authorized` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `psychotherapy_notes_included` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `psychotherapy_notes_included` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `psychotherapy_notes_included` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `psychotherapy_notes_included` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `psychotherapy_notes_included` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `psychotherapy_notes_included` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `psychotherapy_notes_included` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` SET TAGS ('pii_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `recipient_contact` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` SET TAGS ('pii_subdomain' = 'sensitive_directives');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_authorized` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_authorized` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_authorized` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_authorized` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_authorized` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_authorized` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_authorized` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_counseling_completed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_counseling_completed` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_counseling_completed` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_counseling_completed` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_counseling_completed` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_counseling_completed` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_counseling_completed` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` SET TAGS ('pii_subdomain' = 'authorization_capture');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `clinical_use_authorized` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `clinical_use_authorized` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `clinical_use_authorized` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `clinical_use_authorized` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `clinical_use_authorized` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `clinical_use_authorized` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `clinical_use_authorized` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `compensation_provided` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `compensation_provided` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `marketing_use_authorized` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `marketing_use_authorized` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `marketing_use_authorized` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `marketing_use_authorized` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `marketing_use_authorized` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `marketing_use_authorized` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `marketing_use_authorized` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `photographer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `photographer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `photographer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `photographer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `photographer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `photographer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `photographer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` SET TAGS ('pii_subdomain' = 'patient_rights');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` SET TAGS ('pii_subdomain' = 'consent_governance');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
