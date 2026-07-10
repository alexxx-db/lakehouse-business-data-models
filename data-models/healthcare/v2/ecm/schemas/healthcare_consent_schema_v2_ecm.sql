-- Schema for Domain: consent | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`consent` COMMENT 'Enterprise consent management for patient treatment consent, research consent, data sharing authorizations, HIPAA authorizations, HIE opt-in/opt-out, and telehealth consent. SSOT for all consent records across clinical, research, and administrative contexts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`form_template` (
    `form_template_id` BIGINT COMMENT 'Unique identifier for the consent form template record. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Templates are governed by compliance policies defining required elements, approval workflows, and regulatory requirements. Essential for policy enforcement, version control, and demonstrating that con',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_policy. Business justification: Consent form templates implement and enforce consent policies. Each template should reference the policy it supports. Adding consent_policy_id FK links template design to governing policy, enabling po',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Consent form templates must conform to specific exchange standards (C-CDA Consent Directive template 2.16.840.1.113883.10.20.22.2.64, FHIR Consent resource profiles). Required for interoperability des',
    `primary_superseded_by_form_template_id` BIGINT COMMENT 'Reference to the consent_form_template_id of the newer version that supersedes this template. Null if this is the current active version.',
    `applicable_facility_types` STRING COMMENT 'Comma-separated list or description of facility types where this consent form template is applicable (e.g., inpatient hospital, outpatient clinic, emergency department, ambulatory surgery center, telehealth platform).',
    `applicable_service_lines` STRING COMMENT 'Comma-separated list or description of clinical service lines or departments where this consent form template is used (e.g., cardiology, oncology, behavioral health, radiology, laboratory).',
    `approval_authority` STRING COMMENT 'Name or title of the individual, committee, or department that approved this consent form template for use (e.g., Chief Compliance Officer, Legal Department, Privacy Officer, IRB Chair).',
    `approval_date` DATE COMMENT 'Date when the consent form template was officially approved by the designated authority for deployment and use.',
    `consent_category` STRING COMMENT 'Primary category of consent this form template addresses: treatment (general medical treatment), surgical (procedure-specific), research (clinical trials and studies), hipaa_authorization (PHI disclosure), hie_opt_in_out (Health Information Exchange participation), telehealth (virtual care consent), data_sharing (third-party data use). [ENUM-REF-CANDIDATE: treatment|surgical|research|hipaa_authorization|hie_opt_in_out|telehealth|data_sharing — 7 candidates stripped; promote to reference product]',
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
    `legal_representative_allowed_flag` BOOLEAN COMMENT 'Indicates whether a legal representative (guardian, power of attorney, parent) may sign this consent form on behalf of the patient. True if representative signature is permitted, False if patient signature is strictly required.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age (in years) at which a patient may provide consent under this form template without parental or guardian involvement. Null if no age restriction applies or if form is not age-dependent.',
    `minor_assent_required_flag` BOOLEAN COMMENT 'Indicates whether assent from a minor patient (in addition to parental consent) is required for this consent form. Applicable primarily to research and certain treatment contexts. True if minor assent is required, False otherwise.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this consent form template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent form template record was last modified.',
    `reading_level` STRING COMMENT 'Assessed reading comprehension level required to understand the consent form content, typically expressed as grade level (e.g., 6th grade, 8th grade) or readability score (Flesch-Kincaid). Important for health literacy compliance.',
    `regulatory_basis` STRING COMMENT 'Primary legal or regulatory framework that mandates or governs this consent form (e.g., HIPAA Privacy Rule 45 CFR 164.508, 45 CFR Part 46 Common Rule, California CMIA, State-specific informed consent statute).',
    `retention_period_years` STRING COMMENT 'Number of years that signed instances of this consent form must be retained per regulatory and legal requirements (e.g., 6 years per HIPAA, 7 years per state law, indefinitely for certain research consents).',
    `revocation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the patient has the right to revoke consent given under this form template. True if revocation is permitted, False if consent is irrevocable (rare, typically only in certain research contexts).',
    `revocation_instructions` STRING COMMENT 'Instructions provided to patients on how to revoke consent if revocation is allowed (e.g., written notice to Privacy Officer, submission of revocation form).',
    `scope_of_consent` STRING COMMENT 'Textual description of what the patient is consenting to, including specific procedures, data uses, disclosures, or participation activities covered by this form.',
    `version_number` STRING COMMENT 'Version identifier for the consent form template following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Incremented when form content or structure changes.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature is required on this consent form in addition to the patient signature. True if witness is required, False otherwise.',
    CONSTRAINT pk_form_template PRIMARY KEY(`form_template_id`)
) COMMENT 'Master catalog of all approved consent form templates used across clinical, research, and administrative contexts. Captures form name, form code, consent category (treatment, surgical, research, HIPAA, HIE, telehealth, data sharing), version number, effective date, expiration date, regulatory basis (HIPAA, 45 CFR 46, state law), language, reading level, approval authority, and IRB approval reference where applicable. Serves as the authoritative reference for which form version was presented to a patient at time of consent.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` (
    `hipaa_authorization_id` BIGINT COMMENT 'Unique identifier for the HIPAA authorization record. Primary key for the authorization entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the authorization was obtained.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: HIPAA authorizations must comply with organizational policies implementing HIPAA Privacy Rule requirements. Links authorization instances to governing policy for audit trails, policy version tracking,',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who is granting the HIPAA authorization for use or disclosure of their Protected Health Information (PHI).',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who obtained and witnessed the patient signature on the authorization.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: HIPAA authorizations are a type of consent record. Linking to the core record table enables unified consent management and reporting across all consent types. Core consent lifecycle attributes (status',
    `research_study_id` BIGINT COMMENT 'Identifier of the research study for which this authorization permits PHI disclosure, if the authorization purpose is research.',
    `superseded_hipaa_authorization_id` BIGINT COMMENT 'Self-referencing FK on hipaa_authorization (superseded_hipaa_authorization_id)',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: HIPAA authorizations are transmitted as CDA documents during care transitions, especially for specialty referrals and discharge summaries. Tracking which CDA document contained the authorization is re',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the authorization was obtained, if applicable. Used for linking authorization to the clinical context.',
    `authorization_purpose` STRING COMMENT 'The specific purpose for which the patient is authorizing the use or disclosure of PHI beyond treatment, payment, and operations (TPO). Must be one of the purposes requiring explicit HIPAA authorization under 45 CFR 164.508.. Valid values are `marketing|research|psychotherapy_notes|sale_of_phi|legal_proceeding|other`',
    `authorization_purpose_description` STRING COMMENT 'Detailed free-text description of the specific purpose for the authorization, providing additional context beyond the categorical purpose code.',
    `compensation_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the authorization includes disclosure that the covered entity will receive direct or indirect remuneration from a third party in exchange for using or disclosing PHI. Required for authorizations involving sale of PHI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization record was first created in the system. Used for audit trail and compliance tracking.',
    `disclosing_party_name` STRING COMMENT 'Name of the covered entity or individual authorized to make the disclosure of PHI (typically the healthcare organization or provider).',
    `disclosing_party_npi` STRING COMMENT 'National Provider Identifier of the disclosing party, if applicable. Used for provider identification and compliance tracking.. Valid values are `^[0-9]{10}$`',
    `document_reference` STRING COMMENT 'Reference identifier or URI to the scanned or electronically stored copy of the signed authorization form in the document management system.',
    `expiration_event` STRING COMMENT 'Description of the event that will cause the authorization to expire (e.g., end of research study, completion of legal proceeding). Used when expiration is event-based rather than date-based.',
    `form_version` STRING COMMENT 'Version identifier of the HIPAA authorization form template used. Used for tracking form updates and ensuring compliance with current regulatory requirements.',
    `irb_approval_number` STRING COMMENT 'IRB approval number for the research study, if applicable. Required for research authorizations to demonstrate ethical oversight.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the authorization form was presented to and signed by the patient.. Valid values are `^[a-z]{2}$`',
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
    `redisclosure_statement` STRING COMMENT 'Statement informing the patient that information disclosed pursuant to the authorization may be subject to redisclosure by the recipient and may no longer be protected by HIPAA.',
    `right_to_revoke_statement` STRING COMMENT 'Statement informing the patient of their right to revoke the authorization and any exceptions to that right (e.g., if action has already been taken in reliance on the authorization).',
    `signature_date` DATE COMMENT 'Date on which the patient signed the HIPAA authorization form.',
    `signature_method` STRING COMMENT 'Method by which the patient signature was captured (e.g., wet signature on paper, electronic signature pad, digital signature via patient portal).. Valid values are `wet_signature|electronic_signature|digital_signature|patient_portal`',
    `signature_obtained_flag` BOOLEAN COMMENT 'Indicates whether the required patient signature has been obtained on the authorization form. HIPAA requires a valid signature for the authorization to be effective.',
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
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: HIE directives are a type of consent record governing health information exchange. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes ',
    `superseded_hie_directive_id` BIGINT COMMENT 'Self-referencing FK on hie_directive (superseded_hie_directive_id)',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: HIE directives specify which trading partners (specific hospitals, health systems, HIEs) can access patient data. Required for operational enforcement of patient restrictions—when patient opts out of ',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which this HIE directive was captured, if applicable.',
    `audit_log_reference` STRING COMMENT 'Reference identifier linking this directive to detailed audit logs of HIE access events.',
    `break_glass_events_count` STRING COMMENT 'Number of times emergency break-glass access has been invoked to override this directive.',
    `consent_form_version` STRING COMMENT 'Version identifier of the consent form or template used to capture this directive.',
    `consent_method` STRING COMMENT 'Method by which the patient provided this HIE directive: written form, verbal communication, electronic signature, or implied consent.. Valid values are `written|verbal|electronic|implied`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HIE directive record was first created in the system.',
    `data_type_restrictions` STRING COMMENT 'Comma-separated list of specific data types or categories the patient has restricted from sharing (e.g., mental health, substance abuse, HIV status, genetic information).',
    `directive_type` STRING COMMENT 'Type of HIE directive: opt-in (patient consents to share), opt-out (patient declines to share), opt-out with exceptions (patient declines except for specified cases), or conditional (patient sets specific conditions).. Valid values are `opt_in|opt_out|opt_out_with_exceptions|conditional`',
    `emergency_access_override` BOOLEAN COMMENT 'Indicates whether emergency access provisions allow providers to override this directive in life-threatening situations.',
    `federal_override_applicable` BOOLEAN COMMENT 'Indicates whether federal regulations (e.g., 42 CFR Part 2 for substance abuse) override state HIE consent laws for this directive.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used to explain the HIE directive to the patient.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the directive was presented to and understood by the patient.',
    `last_break_glass_date` TIMESTAMP COMMENT 'Timestamp of the most recent emergency break-glass access event.',
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
    `scope_of_sharing` STRING COMMENT 'Defines the breadth of data sharing permitted: all records, specific data types only, specific providers only, emergency situations only, or treatment purposes only.. Valid values are `all_records|specific_data_types|specific_providers|emergency_only|treatment_only`',
    `source_system_code` STRING COMMENT 'Unique identifier of this directive in the source system.',
    `state_jurisdiction` STRING COMMENT 'Two-letter state code indicating the jurisdiction whose HIE consent laws govern this directive.',
    `witness_name` STRING COMMENT 'Name of the witness who observed the patient signing the HIE directive, if applicable.',
    `witness_signature_date` DATE COMMENT 'Date when the witness signed the HIE directive form.',
    CONSTRAINT pk_hie_directive PRIMARY KEY(`hie_directive_id`)
) COMMENT 'Master record for patient Health Information Exchange (HIE) opt-in and opt-out directives governing participation in regional and statewide HIE networks. Captures HIE network name, directive type (opt-in, opt-out, opt-out with exceptions), effective date, expiration date, scope of data sharing (all records, specific data types, specific providers), patient-specified restrictions, and directive status. Supports compliance with state HIE consent laws and CommonWell/Carequality participation rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` (
    `treatment_consent_id` BIGINT COMMENT 'Unique identifier for the treatment consent record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where this treatment consent was obtained.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Treatment consent forms are governed by policies defining informed consent requirements, documentation standards, and regulatory compliance. Essential for demonstrating that consent practices meet org',
    `cpt_code_id` BIGINT COMMENT 'The CPT or ICD-10-PCS code identifying the specific procedure or treatment being consented to. Applicable for procedure-specific consent types.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of this treatment consent.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Treatment consents often require payer-specific authorization and documentation. Some procedures require payer pre-authorization before consent can be finalized. Links consent management to insurance ',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who performed the clinical assessment of the patients decision-making capacity.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created this treatment consent record.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Treatment consent is a specialized type of consent record for medical procedures. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes (',
    `superseded_treatment_consent_id` BIGINT COMMENT 'Self-referencing FK on treatment_consent (superseded_treatment_consent_id)',
    `tertiary_treatment_performing_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who will perform the procedure or treatment for which consent was obtained.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this consent was obtained.',
    `alternatives_documented` STRING COMMENT 'Narrative documentation of alternative treatment options that were disclosed to and discussed with the patient or authorized representative.',
    `benefits_documented` STRING COMMENT 'Narrative documentation of the expected benefits of the procedure or treatment that were disclosed to and discussed with the patient or authorized representative.',
    `capacity_determination` STRING COMMENT 'Clinical determination of whether the patient has decision-making capacity to provide informed consent for the treatment or procedure.. Valid values are `patient_has_capacity|patient_lacks_capacity|not_assessed`',
    `consent_document_location` STRING COMMENT 'Reference to the location or system where the signed consent document is stored (e.g., EMR document ID, scanned document repository path).',
    `consent_form_number` STRING COMMENT 'The externally-known unique identifier or form number for this treatment consent document.',
    `consent_method` STRING COMMENT 'The method by which consent was obtained and documented (written signature, verbal consent documented by provider, electronic signature, telephonic consent with witness).. Valid values are `written|verbal|electronic|telephonic`',
    `consent_version` STRING COMMENT 'Version identifier of the consent form template used, for tracking form revisions and ensuring compliance with current organizational policies.',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when this treatment consent record was first created in the system.',
    `emergency_exception_flag` BOOLEAN COMMENT 'Indicates whether treatment was provided under emergency exception provisions when informed consent could not be obtained due to the patients condition and no authorized representative was available.',
    `emergency_exception_justification` STRING COMMENT 'Clinical documentation justifying why treatment was provided without informed consent under emergency exception provisions.',
    `interpreter_language` STRING COMMENT 'The language in which interpretation services were provided during the consent process.',
    `interpreter_name` STRING COMMENT 'Full name of the medical interpreter who facilitated the consent discussion.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter was required to facilitate the consent discussion due to language barriers or communication needs.',
    `last_updated_datetime` TIMESTAMP COMMENT 'The date and time when this treatment consent record was last modified in the system.',
    `legal_representative_name` STRING COMMENT 'Full name of the legal representative or authorized decision-maker who provided consent on behalf of the patient.',
    `legal_representative_phone` STRING COMMENT 'Contact phone number for the legal representative or authorized decision-maker.',
    `legal_representative_relationship` STRING COMMENT 'The legal or familial relationship of the representative to the patient (e.g., parent, legal guardian, healthcare proxy, durable power of attorney for healthcare, spouse, next of kin).. Valid values are `parent|guardian|healthcare_proxy|power_of_attorney|spouse|next_of_kin`',
    `legal_representative_required_flag` BOOLEAN COMMENT 'Indicates whether a legal representative or authorized decision-maker was required to provide consent on behalf of the patient due to lack of capacity.',
    `patient_questions_addressed_flag` BOOLEAN COMMENT 'Indicates whether the patient or authorized representative had the opportunity to ask questions and all questions were addressed prior to obtaining consent.',
    `patient_questions_notes` STRING COMMENT 'Free-text documentation of specific questions asked by the patient or authorized representative and the responses provided.',
    `revoked_by_name` STRING COMMENT 'Name of the individual (patient or authorized representative) who revoked the consent.',
    `risks_documented` STRING COMMENT 'Narrative documentation of the material risks of the procedure or treatment that were disclosed to and discussed with the patient or authorized representative.',
    `special_instructions` STRING COMMENT 'Any special instructions, limitations, or conditions specified by the patient or authorized representative as part of the consent (e.g., no blood products, specific anesthesia preferences).',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the consent process and signed the consent form.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required on the consent form per organizational policy or regulatory requirement.',
    `witness_role` STRING COMMENT 'The role or title of the witness (e.g., registered nurse, social worker, patient advocate).',
    CONSTRAINT pk_treatment_consent PRIMARY KEY(`treatment_consent_id`)
) COMMENT 'Master record for general and procedure-specific treatment consent obtained from patients or their authorized representatives prior to clinical care. Captures consent type (general treatment, surgical, anesthesia, blood transfusion, chemotherapy, ECT, restraint), procedure or treatment being consented to, risks and benefits documented, alternatives discussed, patient questions addressed, capacity determination, and legal representative details when patient lacks decision-making capacity. Distinct from HIPAA authorization — governs clinical care delivery.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`research_consent` (
    `research_consent_id` BIGINT COMMENT 'Unique identifier for the research consent record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Identifier of the healthcare provider or research coordinator who obtained informed consent from the subject.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Research consents must comply with IRB-approved policies and organizational research governance policies. Links consent instances to governing policies for audit trails, regulatory compliance verifica',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient or research subject who provided consent.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Research consent is a specialized type of consent record for clinical research. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes (st',
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
    `consenting_provider_npi` STRING COMMENT 'National Provider Identifier of the provider who obtained consent. 10-digit unique identifier.. Valid values are `^[0-9]{10}$`',
    `contact_for_future_studies_authorized` BOOLEAN COMMENT 'Indicates whether the subject authorized being contacted for participation in future research studies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this research consent record was first created in the system.',
    `data_sharing_authorized` BOOLEAN COMMENT 'Indicates whether the subject authorized sharing of their de-identified research data with external researchers or repositories.',
    `electronic_signature_code` STRING COMMENT 'Unique identifier of the electronic signature captured during the consent process, if applicable.',
    `future_research_authorized` BOOLEAN COMMENT 'Indicates whether the subject authorized use of their data and biospecimens for future unspecified research studies.',
    `genetic_testing_authorized` BOOLEAN COMMENT 'Indicates whether the subject authorized genetic testing and analysis of their biospecimens.',
    `hipaa_authorization_included` BOOLEAN COMMENT 'Indicates whether HIPAA authorization for use and disclosure of protected health information was included in the research consent.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used during the consent process to facilitate communication with the subject.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number under which this consent was obtained. Links consent to the approved research protocol.',
    `lar_contact_phone` STRING COMMENT 'Contact phone number of the legally authorized representative.',
    `lar_name` STRING COMMENT 'Full name of the legally authorized representative who provided consent on behalf of the subject.',
    `lar_relationship` STRING COMMENT 'Relationship of the LAR to the research subject (e.g., parent, guardian, healthcare proxy, power of attorney).',
    `lar_used` BOOLEAN COMMENT 'Indicates whether a legally authorized representative provided consent on behalf of an incapacitated or minor subject.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this research consent record was last modified in the system.',
    `minor_assent_date` DATE COMMENT 'Date on which assent was obtained from the minor subject.',
    `minor_assent_obtained` BOOLEAN COMMENT 'Indicates whether assent was obtained from a minor subject in addition to parental consent, as required by IRB protocol.',
    `mrn` STRING COMMENT 'Medical record number of the research subject. Unique patient identifier within the healthcare system.',
    `reconsent_date` DATE COMMENT 'Date on which reconsent was obtained following a protocol amendment or other triggering event.',
    `reconsent_reason` STRING COMMENT 'Reason for requiring reconsent (e.g., protocol amendment, new safety information, change in study procedures).',
    `reconsent_required` BOOLEAN COMMENT 'Indicates whether reconsent is required due to protocol amendment, new risks identified, or other changes to the study.',
    `return_of_results_requested` BOOLEAN COMMENT 'Indicates whether the subject requested to receive individual research results or incidental findings from the study.',
    `study_arm` STRING COMMENT 'The specific arm or cohort of the study to which the subject was assigned (e.g., treatment, control, placebo).',
    `subject_comprehension_assessed` BOOLEAN COMMENT 'Indicates whether the research subjects comprehension of the study risks, benefits, and procedures was formally assessed during the consent process.',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the consent process and signed the consent form.',
    `witness_required` BOOLEAN COMMENT 'Indicates whether a witness signature was required for the consent process (e.g., for illiterate subjects or per IRB protocol).',
    CONSTRAINT pk_research_consent PRIMARY KEY(`research_consent_id`)
) COMMENT 'Master record for informed consent obtained from research subjects prior to enrollment in clinical trials and research studies. Captures IRB-approved consent form version, study arm, consent process details (who obtained consent, where, how long discussion lasted), subject comprehension assessment, legally authorized representative (LAR) details for incapacitated subjects, assent documentation for minors, re-consent events for protocol amendments, and withdrawal of consent. Governed by 45 CFR 46 (Common Rule) and 21 CFR 50 (FDA). Complements research.informed_consent with enterprise consent SSOT linkage.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` (
    `telehealth_consent_id` BIGINT COMMENT 'Unique identifier for the telehealth consent record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the healthcare provider who will deliver telehealth services under this consent.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient providing telehealth consent. Links to the patient master record.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Telehealth consent is a specialized type of consent record for virtual care. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes (statu',
    `superseded_telehealth_consent_id` BIGINT COMMENT 'Self-referencing FK on telehealth_consent (superseded_telehealth_consent_id)',
    `visit_id` BIGINT COMMENT 'Identifier for the clinical encounter or visit associated with this telehealth consent, if applicable.',
    `cms_condition_met` BOOLEAN COMMENT 'Indicates whether this telehealth consent satisfies CMS Conditions of Participation for telehealth service delivery and reimbursement.',
    `consent_document_code` STRING COMMENT 'Unique identifier or reference to the scanned or electronically signed consent document stored in the document management system.',
    `consent_form_version` STRING COMMENT 'Version identifier of the telehealth consent form template used. Enables tracking of consent language changes over time.',
    `consent_language` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the telehealth consent was presented to the patient.. Valid values are `^[a-z]{2}$`',
    `consent_obtained_by` STRING COMMENT 'Name or identifier of the staff member, provider, or system that obtained and documented the telehealth consent.',
    `consent_obtained_method` STRING COMMENT 'The method by which the patients telehealth consent was captured (e.g., signed paper form, electronic signature, verbal consent documented in EHR).. Valid values are `written|verbal|electronic|implied`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this telehealth consent record was first created in the system. Audit trail for record creation.',
    `data_retention_period_days` STRING COMMENT 'Number of days that telehealth session recordings and data will be retained, as disclosed to and consented by the patient.',
    `emergency_override_applicable` BOOLEAN COMMENT 'Indicates whether this telehealth consent was obtained under emergency circumstances where standard consent procedures were modified per EMTALA or state emergency laws.',
    `hipaa_authorization_included` BOOLEAN COMMENT 'Indicates whether this telehealth consent includes a HIPAA authorization for use and disclosure of Protected Health Information (PHI) during virtual care.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used during the telehealth consent process to ensure patient understanding.',
    `interstate_compact_applicable` BOOLEAN COMMENT 'Indicates whether an interstate medical licensure compact (e.g., IMLC) applies to this telehealth consent, allowing cross-state practice.',
    `legal_guardian_name` STRING COMMENT 'Name of the legal guardian who provided consent on behalf of a minor or incapacitated patient.',
    `legal_guardian_relationship` STRING COMMENT 'The relationship of the legal guardian to the patient (e.g., parent, court-appointed guardian, healthcare proxy).. Valid values are `parent|legal_guardian|healthcare_proxy|power_of_attorney|other`',
    `minor_consent_applicable` BOOLEAN COMMENT 'Indicates whether this consent involves a minor patient and requires parental or guardian authorization.',
    `mrn` STRING COMMENT 'The patients medical record number as assigned by the healthcare organization. Used for clinical identification and consent tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to this telehealth consent.',
    `patient_location_state` STRING COMMENT 'Two-letter state code where the patient will be physically located during telehealth services. Determines applicable state telehealth laws.. Valid values are `^[A-Z]{2}$`',
    `provider_licensure_state` STRING COMMENT 'Two-letter state code where the provider holds active medical licensure. Critical for interstate telehealth compliance.. Valid values are `^[A-Z]{2}$`',
    `provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the provider delivering telehealth services. Required for billing and licensure verification.. Valid values are `^[0-9]{10}$`',
    `recording_consent_provided` BOOLEAN COMMENT 'Indicates whether the patient consented to audio or video recording of telehealth sessions for quality, training, or medical record purposes.',
    `right_to_refuse_disclosed` BOOLEAN COMMENT 'Indicates whether the patient was informed of their right to refuse telehealth services and receive in-person care instead.',
    `scope_of_services` STRING COMMENT 'Description of the types of clinical services covered under this telehealth consent (e.g., primary care visits, behavioral health, chronic disease management).',
    `state_specific_requirements_met` BOOLEAN COMMENT 'Flag indicating whether all state-specific telehealth consent requirements have been satisfied (e.g., informed consent elements, parental consent for minors).',
    `technology_risks_disclosed` BOOLEAN COMMENT 'Indicates whether the patient was informed of technology risks including potential for technical failure, privacy breaches, and limitations of virtual examination.',
    `telehealth_modality` STRING COMMENT 'The type of telehealth technology and interaction method the patient consents to use. Determines the mode of virtual care delivery.. Valid values are `video|audio_only|asynchronous|remote_monitoring|hybrid`',
    `telehealth_platform` STRING COMMENT 'Name or identifier of the telehealth technology platform the patient will use for virtual visits (e.g., Epic MyChart Video, Zoom for Healthcare, Doxy.me).',
    `third_party_disclosure_authorized` BOOLEAN COMMENT 'Indicates whether the patient authorized disclosure of telehealth session information to third parties such as family members, caregivers, or other providers.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this telehealth consent record was last modified. Audit trail for record changes.',
    `witness_name` STRING COMMENT 'Name of the witness present during consent signing, if required by state law or organizational policy.',
    CONSTRAINT pk_telehealth_consent PRIMARY KEY(`telehealth_consent_id`)
) COMMENT 'Master record for patient consent to receive care via telehealth and virtual care modalities. Captures telehealth platform, modality type (video, audio-only, asynchronous), state-specific consent requirements met, technology risks disclosed, patient right to refuse telehealth and receive in-person care, provider licensure state, and interstate compact applicability. Required by CMS and most state telehealth laws as a condition of telehealth service delivery.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` (
    `minor_consent_id` BIGINT COMMENT 'Unique identifier for the minor consent record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider who obtained and documented the consent.',
    `delegation_id` BIGINT COMMENT 'Reference to the parent or legal guardian providing consent on behalf of the minor, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who last updated this consent record, for audit trail purposes.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the minor patient for whom this consent record applies.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Minor consent is a specialized type of consent record with additional legal requirements for minors. Linking to the core record table enables unified consent management. Core consent lifecycle attribu',
    `superseded_minor_consent_id` BIGINT COMMENT 'Self-referencing FK on minor_consent (superseded_minor_consent_id)',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this consent was obtained, if applicable.',
    `basis` STRING COMMENT 'The legal basis under which consent is being obtained or documented: mature minor doctrine, emancipated minor status, state-specific minor consent laws (e.g., STI treatment, substance abuse, mental health, reproductive health), parental/guardian consent, or court-ordered consent.. Valid values are `mature_minor|emancipated_minor|state_specific_minor_consent|parental_consent|guardian_consent|court_order`',
    `confidentiality_obligation_to_minor_flag` BOOLEAN COMMENT 'Indicates whether the healthcare provider has a legal or ethical obligation to maintain confidentiality of the minors health information from parents/guardians (e.g., when minor consents independently under state law for sensitive services).',
    `consent_document_reference` STRING COMMENT 'Reference identifier or storage location of the signed consent document in the document management system.',
    `consent_form_version` STRING COMMENT 'Version identifier of the consent form or template used to obtain consent, for audit and compliance tracking.',
    `consent_language` STRING COMMENT 'ISO 639-3 three-letter language code indicating the language in which consent was obtained and documented.. Valid values are `^[A-Z]{3}$`',
    `consent_method` STRING COMMENT 'The method by which consent was obtained: written signature, verbal consent (documented), electronic signature, or implied consent.. Valid values are `written|verbal|electronic|implied|not_applicable`',
    `consent_scope_description` STRING COMMENT 'Detailed description of what the consent covers, including specific treatments, procedures, data sharing purposes, or research protocols.',
    `court_order_reference_number` STRING COMMENT 'Reference number or case number of the court order governing consent authority or restrictions, if applicable.',
    `court_ordered_consent_restriction_flag` BOOLEAN COMMENT 'Indicates whether there are court-ordered restrictions on who may provide consent for the minor (e.g., one parent prohibited from consenting due to custody order).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was first created in the system.',
    `custodial_parent_verified_flag` BOOLEAN COMMENT 'Indicates whether the consenting parent has been verified as having legal custody and authority to consent on behalf of the minor, particularly important in cases of divorce or separation.',
    `custody_documentation_type` STRING COMMENT 'The type of documentation reviewed to verify custodial parent or guardian status.. Valid values are `court_order|divorce_decree|custody_agreement|birth_certificate|adoption_papers|not_applicable`',
    `data_sharing_scope` STRING COMMENT 'Description of the scope and purpose of data sharing authorized by this consent (e.g., specific recipients, purposes, data elements).',
    `emancipated_minor_flag` BOOLEAN COMMENT 'Indicates whether the minor has been legally emancipated and therefore has full consent rights as an adult.',
    `emancipation_documentation_type` STRING COMMENT 'The type of documentation provided to verify emancipated minor status, if applicable.. Valid values are `court_order|marriage_certificate|military_service|self_supporting_declaration|not_applicable`',
    `hie_participation_status` STRING COMMENT 'Indicates whether the minor (or parent/guardian on their behalf) has opted in or out of Health Information Exchange participation.. Valid values are `opted_in|opted_out|not_applicable`',
    `hipaa_authorization_flag` BOOLEAN COMMENT 'Indicates whether this consent includes a HIPAA authorization for use and disclosure of Protected Health Information (PHI) beyond treatment, payment, and healthcare operations.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used during the consent process to ensure understanding.',
    `irb_protocol_number` STRING COMMENT 'The IRB protocol number associated with research consent, if applicable.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was last modified.',
    `minor_age_at_consent` STRING COMMENT 'The age of the minor patient at the time consent was obtained, used to determine applicability of age-based consent rules.',
    `minor_assent_obtained_flag` BOOLEAN COMMENT 'Indicates whether the minors assent (agreement) was obtained in addition to parental consent, particularly relevant for research participation and certain clinical procedures.',
    `minor_consenting_independently_flag` BOOLEAN COMMENT 'Indicates whether the minor is providing consent independently without parental/guardian involvement, based on mature minor doctrine, emancipation, or state-specific minor consent rights.',
    `parent_guardian_name` STRING COMMENT 'Full name of the parent or legal guardian providing consent, if applicable.',
    `parental_consent_required_flag` BOOLEAN COMMENT 'Indicates whether parental or guardian consent is required for the treatment or service being provided.',
    `parental_notification_permitted_flag` BOOLEAN COMMENT 'Indicates whether parental notification of the minors care is permitted under applicable law and the minors consent preferences.',
    `research_consent_flag` BOOLEAN COMMENT 'Indicates whether this consent is for participation in research and is subject to Common Rule and IRB oversight.',
    `revocation_reason` STRING COMMENT 'Free-text explanation of why the consent was revoked, if provided.',
    `revoked_by` STRING COMMENT 'Identifies who revoked the consent: the minor themselves, parent, guardian, court order, or system (e.g., automatic expiration).. Valid values are `minor|parent|guardian|court|system|not_applicable`',
    `state_specific_minor_consent_category` STRING COMMENT 'The specific category of care for which state law permits minors to consent independently without parental involvement (e.g., sexually transmitted infection treatment, reproductive health services, substance abuse treatment, mental health services). [ENUM-REF-CANDIDATE: sti_treatment|reproductive_health|substance_abuse|mental_health|prenatal_care|sexual_assault|not_applicable — 7 candidates stripped; promote to reference product]',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the consent process, if applicable.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this consent per organizational policy or legal requirement.',
    CONSTRAINT pk_minor_consent PRIMARY KEY(`minor_consent_id`)
) COMMENT 'Master record for consent situations involving minor patients, capturing the complex legal landscape of minor consent rights. Tracks whether the minor is consenting independently (mature minor doctrine, emancipated minor, state-specific minor consent for STI/reproductive health/substance use/mental health), parental/guardian consent details, custodial parent verification, court-ordered consent restrictions, and confidentiality obligations to the minor. Critical for compliance with state minor consent statutes and HIPAA minor exception rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`delegation` (
    `delegation_id` BIGINT COMMENT 'Unique identifier for the consent delegation record. Primary key for the consent delegation entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or staff member who created the consent delegation record.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the individual authorized to provide consent on behalf of the patient. May link to person or contact master record.',
    `delegation_employee_id` BIGINT COMMENT 'Identifier of the staff member or user who verified the delegation authority and supporting documentation.',
    `delegation_last_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or staff member who last modified the consent delegation record.',
    `delegation_patient_mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom consent delegation authority is being granted. Links to the patient master record.',
    `delegation_revoked_by_user_employee_id` BIGINT COMMENT 'Identifier of the staff member or user who processed the revocation of the delegation authority.',
    `superseded_delegation_id` BIGINT COMMENT 'Self-referencing FK on delegation (superseded_delegation_id)',
    `applies_to_minor` BOOLEAN COMMENT 'Boolean flag indicating whether this delegation applies to a minor patient. True if the patient is a minor and the delegate has parental or guardian authority.',
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
    `effective_end_date` DATE COMMENT 'Date when the delegation authority expires or terminates. Nullable for open-ended delegations. The delegate is no longer authorized to provide consent after this date.',
    `effective_start_date` DATE COMMENT 'Date when the delegation authority becomes effective. The delegate is authorized to provide consent on or after this date.',
    `emergency_contact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the delegate should also be contacted in medical emergencies. True if the delegate is designated as an emergency contact.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent delegation record was last modified. Used for audit trail and change tracking.',
    `legal_document_date` DATE COMMENT 'Date the legal document was executed, signed, or issued by the court. Establishes the legal validity timeline.',
    `legal_document_reference` STRING COMMENT 'Reference identifier or location of the supporting legal documentation (e.g., document ID in document management system, court case number, file path). Used to retrieve the original legal instrument.',
    `legal_document_type` STRING COMMENT 'Type of legal documentation supporting the delegation authority (e.g., advance directive, healthcare proxy form, durable power of attorney document, guardianship court order, birth certificate for parental authority). [ENUM-REF-CANDIDATE: advance_directive|healthcare_proxy_form|power_of_attorney_document|guardianship_order|court_order|birth_certificate|other — 7 candidates stripped; promote to reference product]',
    `limitations_description` STRING COMMENT 'Free-text description of any limitations or restrictions on the delegates authority (e.g., cannot consent to experimental treatments, cannot authorize organ donation, specific procedures excluded).',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the delegation authority, verification process, or special circumstances.',
    `priority_order` STRING COMMENT 'Priority ranking when multiple delegates exist for the same patient. Lower numbers indicate higher priority. Used to determine which delegate has primary authority when conflicts arise.',
    `revocation_date` DATE COMMENT 'Date when the delegation authority was revoked by the patient, delegate, or legal authority. Nullable if delegation has not been revoked.',
    `revocation_reason` STRING COMMENT 'Free-text explanation of why the delegation authority was revoked (e.g., patient request, delegate resignation, legal change, death of delegate).',
    `scope` STRING COMMENT 'Scope of authority granted to the delegate. Defines what types of consent decisions the delegate is authorized to make (e.g., full medical decisions, treatment consent only, research consent, data sharing, financial decisions, emergency-only). [ENUM-REF-CANDIDATE: full_medical_decisions|treatment_consent_only|research_consent_only|data_sharing_authorization|financial_decisions|limited_scope|emergency_only — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Unique identifier of the delegation record in the source system. Used for data lineage and reconciliation.',
    `delegation_status` STRING COMMENT 'Current lifecycle status of the delegation authority. Indicates whether the delegation is currently in effect, has been revoked, has expired, or is pending verification.. Valid values are `active|inactive|suspended|revoked|expired|pending_verification`',
    `delegation_type` STRING COMMENT 'Type of legal authority granted to the delegate. Distinguishes between healthcare proxy, durable power of attorney for healthcare (DPOA-HC), legal guardianship, court-appointed guardianship, next-of-kin surrogate per state law, and parental authority for minors.. Valid values are `healthcare_proxy|durable_power_of_attorney|legal_guardian|court_appointed_guardian|next_of_kin_surrogate|parental_authority`',
    `verification_date` DATE COMMENT 'Date when the delegation authority was verified by authorized staff. Used for audit and compliance tracking.',
    `verification_status` STRING COMMENT 'Status of verification of the delegation authority and supporting documentation. Indicates whether the legal authority has been confirmed by appropriate staff or legal review.. Valid values are `verified|pending_verification|unverified|verification_failed|expired_verification`',
    CONSTRAINT pk_delegation PRIMARY KEY(`delegation_id`)
) COMMENT 'Master record for authorized representatives, legal surrogates, and healthcare proxies who have legal authority to provide consent on behalf of a patient. Captures delegate type (healthcare proxy, durable power of attorney for healthcare, legal guardian, court-appointed guardian, next-of-kin surrogate per state law), delegation scope, effective period, supporting legal documentation reference, and priority order when multiple delegates exist. Distinct from patient.proxy_access which governs portal access — this governs clinical consent authority.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`revocation` (
    `revocation_id` BIGINT COMMENT 'Unique identifier for the consent revocation record. Primary key for the consent revocation entity.',
    `delegation_id` BIGINT COMMENT 'Reference to the authorized representative who submitted the revocation on behalf of the patient, if applicable. Null if patient revoked directly.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is revoking consent or on whose behalf consent is being revoked.',
    `prior_revocation_id` BIGINT COMMENT 'Self-referencing FK on revocation (prior_revocation_id)',
    `consent_record_id` BIGINT COMMENT 'Reference to the original consent record being revoked. Links to the parent consent that this revocation applies to.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or system user who received and recorded the consent revocation.',
    `revocation_processed_by_user_employee_id` BIGINT COMMENT 'Reference to the staff member or system user who processed and operationalized the consent revocation.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for all actions taken in response to this revocation, maintained for regulatory compliance.',
    `compliance_notes` STRING COMMENT 'Internal notes regarding compliance considerations, special handling requirements, or regulatory reporting obligations related to this revocation.',
    `data_access_restricted_flag` BOOLEAN COMMENT 'Indicates whether data access controls have been updated to restrict access based on the revoked consent.',
    `data_access_restricted_timestamp` TIMESTAMP COMMENT 'The date and time when data access restrictions were implemented in response to the consent revocation.',
    `revocation_date` DATE COMMENT 'The calendar date on which the patient submitted the consent revocation. This is the effective date from which the consent is considered withdrawn.',
    `disclosures_halted_flag` BOOLEAN COMMENT 'Indicates whether ongoing or future disclosures of Protected Health Information (PHI) have been halted as a result of this revocation.',
    `disclosures_halted_timestamp` TIMESTAMP COMMENT 'The date and time when disclosure processes were halted in response to the consent revocation.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the scanned or electronic copy of the signed revocation document, if applicable.',
    `effective_timestamp` TIMESTAMP COMMENT 'The date and time when the revocation became legally effective and operational systems began enforcing the withdrawal of consent. May differ from revocation_timestamp due to processing delays.',
    `irrevocable_actions_description` STRING COMMENT 'Free-text description of any actions taken under the original consent that cannot be reversed or undone despite the revocation (e.g., data already shared with third parties, research already conducted).',
    `legal_review_completed_flag` BOOLEAN COMMENT 'Indicates whether required legal review has been completed for this revocation.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether this revocation requires legal review before being processed (e.g., complex partial revocations, disputes, or high-risk scenarios).',
    `legal_review_timestamp` TIMESTAMP COMMENT 'The date and time when legal review of the revocation was completed.',
    `legal_reviewer_notes` STRING COMMENT 'Confidential notes from legal counsel regarding the revocation review, including any special handling instructions or risk assessments.',
    `method` STRING COMMENT 'The method or channel through which the patient submitted the consent revocation (e.g., written form, verbal communication, patient portal, email, fax, in-person). [ENUM-REF-CANDIDATE: written|verbal|electronic|portal|email|fax|in_person — 7 candidates stripped; promote to reference product]',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of the revocation was sent to relevant parties (providers, research teams, business associates, etc.).',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'The date and time when notifications regarding the consent revocation were sent to affected parties.',
    `number` STRING COMMENT 'Business-facing unique identifier or tracking number assigned to this consent revocation for reference and audit purposes.',
    `partial_revocation_details` STRING COMMENT 'Free-text description of which specific portions of the consent are being revoked when revocation_scope is partial. Null when revocation is full.',
    `patient_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether confirmation notification was sent to the patient acknowledging receipt and processing of their revocation.',
    `patient_notification_timestamp` TIMESTAMP COMMENT 'The date and time when confirmation notification was sent to the patient regarding their consent revocation.',
    `prior_disclosures_count` STRING COMMENT 'The number of disclosures that occurred under the original consent prior to revocation and that cannot be undone or recalled.',
    `prior_disclosures_summary` STRING COMMENT 'Summary description of disclosures that occurred prior to revocation and cannot be undone, maintained for legal audit trail and patient notification.',
    `reason` STRING COMMENT 'Optional free-text explanation provided by the patient describing why they are revoking consent. May be blank if patient chose not to provide a reason.',
    `reason_code` STRING COMMENT 'Standardized categorical code representing the reason for consent revocation, used for reporting and analytics.. Valid values are `patient_request|privacy_concern|no_longer_needed|treatment_complete|other|not_provided`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent revocation record was first created in the data warehouse or lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent revocation record was last updated in the data warehouse or lakehouse.',
    `rejection_reason` STRING COMMENT 'Explanation of why the revocation was rejected, if applicable (e.g., invalid signature, unauthorized submitter, incomplete documentation).',
    `scope` STRING COMMENT 'Indicates whether the revocation applies to the entire consent (full) or only specific portions of the consent (partial).. Valid values are `full|partial`',
    `source_system_code` STRING COMMENT 'The unique identifier for this revocation record in the source operational system.',
    `revocation_status` STRING COMMENT 'Current processing status of the consent revocation within the organizations workflow (e.g., pending review, processed and effective, rejected due to invalid submission).. Valid values are `pending|processed|effective|rejected|cancelled`',
    `timestamp` TIMESTAMP COMMENT 'The precise date and time when the consent revocation was submitted or recorded in the system. Provides exact temporal audit trail for legal compliance.',
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
    `prior_npp_acknowledgment_id` BIGINT COMMENT 'Self-referencing FK on npp_acknowledgment (prior_npp_acknowledgment_id)',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the NPP acknowledgment was obtained, if applicable.',
    `accessibility_accommodation` STRING COMMENT 'Description of any accessibility accommodations provided (e.g., large print, Braille, audio recording, sign language interpreter).',
    `acknowledgment_date` DATE COMMENT 'Date on which the patient acknowledged receipt of the NPP.',
    `acknowledgment_location` STRING COMMENT 'Physical or virtual location where the acknowledgment was obtained. [ENUM-REF-CANDIDATE: registration_desk|patient_room|emergency_department|outpatient_clinic|patient_portal|home|other — 7 candidates stripped; promote to reference product]',
    `acknowledgment_method` STRING COMMENT 'Method by which the patient provided acknowledgment (paper signature, electronic signature, patient portal click-through, email confirmation, kiosk acceptance, verbal acknowledgment documented by staff).. Valid values are `signature_paper|signature_electronic|portal_click|email_confirmation|kiosk_acceptance|verbal_documented`',
    `acknowledgment_status` STRING COMMENT 'Current status of the NPP acknowledgment transaction. Acknowledged indicates patient signed or electronically accepted; unable_to_obtain indicates good-faith effort was made but acknowledgment could not be secured per regulatory allowance.. Valid values are `acknowledged|declined|unable_to_obtain|good_faith_effort_documented|pending|voided`',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the patient acknowledged receipt of the NPP, particularly important for electronic acknowledgments.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this acknowledgment record was first created in the system.',
    `delivery_method` STRING COMMENT 'Method by which the NPP was delivered to the patient (paper handout, electronic via patient portal, email, kiosk, verbal explanation).. Valid values are `paper|electronic|patient_portal|email|kiosk|verbal`',
    `device_type` STRING COMMENT 'Type of device used for electronic acknowledgment (desktop computer, mobile phone, tablet, kiosk).. Valid values are `desktop|mobile|tablet|kiosk|other`',
    `good_faith_effort_documentation` STRING COMMENT 'Free-text documentation of the good-faith effort made to obtain acknowledgment when it could not be secured.',
    `good_faith_effort_reason` STRING COMMENT 'Reason why acknowledgment could not be obtained despite good-faith effort, as permitted under 45 CFR 164.520(c)(2)(ii).. Valid values are `patient_refused|emergency_treatment|patient_unable_to_sign|language_barrier|patient_left_before_signing|other`',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether an interpreter was used to explain the NPP to the patient.',
    `ip_address` STRING COMMENT 'IP address from which the electronic acknowledgment was submitted, for audit trail purposes.',
    `is_first_service_acknowledgment` BOOLEAN COMMENT 'Indicates whether this acknowledgment was obtained at the first service delivery as required by 45 CFR 164.520(c)(1).',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language in which the NPP was provided to the patient.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this acknowledgment record was last modified.',
    `material_change_acknowledgment` BOOLEAN COMMENT 'Indicates whether this acknowledgment was obtained following a material change to the NPP, requiring re-acknowledgment.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the NPP acknowledgment transaction.',
    `patient_portal_session_code` STRING COMMENT 'Session identifier from the patient portal if the acknowledgment was obtained electronically via the portal.',
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
    CONSTRAINT pk_npp_acknowledgment PRIMARY KEY(`npp_acknowledgment_id`)
) COMMENT 'Transactional record of patient acknowledgment of receipt of the organizations HIPAA Notice of Privacy Practices (NPP). Captures acknowledgment date, delivery method (paper, electronic, patient portal), NPP version acknowledged, patient or representative signature, and documentation of good-faith efforts when acknowledgment could not be obtained. Distinct from compliance.notice_of_privacy_practices which tracks the NPP document itself — this tracks the patient-level acknowledgment transaction required by 45 CFR 164.520.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` (
    `restriction_request_id` BIGINT COMMENT 'Unique identifier for the patient consent restriction request record. Primary key.',
    `care_site_id` BIGINT COMMENT 'The healthcare facility where the restriction request was received and processed. Links to the facility master record.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Restriction requests are evaluated against organizational policies defining when restrictions must be honored vs. can be denied. Links requests to governing policies for decision documentation, audit ',
    `employee_id` BIGINT COMMENT 'The identifier of the privacy officer or Health Information Management (HIM) professional responsible for processing and overseeing the restriction request. Links to the workforce/provider master record.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: HIPAA permits patients paying out-of-pocket to request disclosure restrictions to their health plan. Attribute out_of_pocket_payment_verified documents this business requirement. Link enables verifica',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who submitted the restriction request. Links to the patient master record.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Consent restriction requests are patient requests to restrict PHI use beyond standard consent. While some restriction requests are general (not tied to specific consent), many relate to a specific con',
    `superseded_restriction_request_id` BIGINT COMMENT 'Self-referencing FK on restriction_request (superseded_restriction_request_id)',
    `visit_id` BIGINT COMMENT 'The encounter during which the restriction request was submitted, if applicable. Links to the encounter master record.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the detailed audit trail of all actions taken on this restriction request, including reviews, decisions, notifications, and enforcement activities.',
    `compliance_review_date` DATE COMMENT 'The date of the most recent compliance review of this restriction request to ensure ongoing adherence to HIPAA and HITECH requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this restriction request record was first created in the system. Used for audit and data lineage purposes.',
    `decision_date` DATE COMMENT 'The date the covered entity made the decision to accept or deny the restriction request.',
    `decision_made_by` STRING COMMENT 'The name or role of the individual or committee who made the decision on the restriction request (e.g., Privacy Officer, HIM Director).',
    `decision_rationale` STRING COMMENT 'The business and regulatory rationale for the organizations decision to accept or deny the restriction request. Required for audit and patient communication.',
    `effective_date` DATE COMMENT 'The date from which the restriction becomes effective and must be honored by the covered entity.',
    `expiration_date` DATE COMMENT 'The date on which the restriction expires, if applicable. Null indicates an indefinite restriction until revoked by the patient or terminated by the organization per regulatory provisions.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this restriction request record was last modified. Used for audit and data lineage purposes.',
    `mrn` STRING COMMENT 'The patients medical record number as recorded at the time of the restriction request. Provides business-level traceability.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the restriction request, including patient concerns, special handling instructions, or escalation details.',
    `operational_instructions` STRING COMMENT 'Detailed operational instructions for clinical, billing, and administrative staff on how to honor the restriction across Electronic Health Record (EHR), Revenue Cycle Management (RCM), Health Information Exchange (HIE), and other systems.',
    `organization_decision` STRING COMMENT 'The covered entitys decision on whether to accept or deny the restriction request. HITECH out-of-pocket restrictions must be accepted; other restrictions are discretionary.. Valid values are `accepted|denied|pending_review|conditionally_accepted|withdrawn`',
    `out_of_pocket_payment_verified` BOOLEAN COMMENT 'Indicates whether the patients claim of out-of-pocket payment has been verified for HITECH mandatory restrictions. True if verified, False if not applicable or not verified.',
    `patient_notification_date` DATE COMMENT 'The date the patient was notified of the organizations decision on the restriction request or any subsequent changes to the restriction status.',
    `patient_notification_method` STRING COMMENT 'The method used to notify the patient of the decision or status change. [ENUM-REF-CANDIDATE: mail|email|patient_portal|phone|in_person|secure_message|other — 7 candidates stripped; promote to reference product]',
    `payment_verification_date` DATE COMMENT 'The date the out-of-pocket payment was verified for HITECH mandatory restrictions, if applicable.',
    `request_date` DATE COMMENT 'The date the patient submitted the restriction request to the covered entity.',
    `request_method` STRING COMMENT 'The method by which the patient submitted the restriction request. [ENUM-REF-CANDIDATE: written_form|verbal|patient_portal|email|fax|mail|in_person|other — 8 candidates stripped; promote to reference product]',
    `request_number` STRING COMMENT 'Business-assigned unique identifier for the restriction request, used for tracking and reference in correspondence and workflows.',
    `request_timestamp` TIMESTAMP COMMENT 'The precise date and time the restriction request was received and recorded in the system.',
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
    CONSTRAINT pk_restriction_request PRIMARY KEY(`restriction_request_id`)
) COMMENT 'Master record for patient requests to restrict uses and disclosures of their PHI beyond HIPAAs standard permissions. Captures restriction type (restrict disclosure to specific payer when patient paid out-of-pocket per HITECH, restrict sharing with family members, restrict specific data types), requested restriction scope, organizations decision to accept or deny the restriction, effective date, and operational instructions for honoring the restriction across clinical systems. Governed by HITECH Act amendment to HIPAA 45 CFR 164.522.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` (
    `disclosure_log_id` BIGINT COMMENT 'Unique identifier for the consent disclosure log entry. Primary key for the consent disclosure log product.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or location where the disclosure was made. Links to the facility product.',
    `hipaa_authorization_id` BIGINT COMMENT 'Foreign key linking to consent.hipaa_authorization. Business justification: PHI disclosures are frequently made under specific HIPAA authorizations. The disclosure_log currently has authorization_reference (STRING) which should be replaced with a proper FK to hipaa_authorizat',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: HIPAA accounting of disclosures requires linking each disclosure log entry to the actual message transmission event. When PHI is disclosed via HL7/FHIR/Direct, the message_log provides technical proof',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose Protected Health Information (PHI) was disclosed. Links to the patient master product.',
    `phi_access_log_id` BIGINT COMMENT 'Foreign key linking to compliance.phi_access_log. Business justification: Disclosures based on consent should be traceable to access logs for complete audit trail of PHI movement. Essential for accounting of disclosures, breach investigation, and demonstrating that disclosu',
    `consent_record_id` BIGINT COMMENT 'Reference to the consent or authorization record under which this disclosure was made. Links to the consent product.',
    `related_prior_disclosure_log_id` BIGINT COMMENT 'Self-referencing FK on disclosure_log (related_disclosure_log_id)',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit associated with this disclosure, if applicable. Links to the encounter product.',
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
    `is_accounting_required` BOOLEAN COMMENT 'Indicates whether this disclosure must be included in the HIPAA Accounting of Disclosures report provided to patients upon request. Non-TPO disclosures are subject to accounting per 45 CFR 164.528.',
    `is_tpo_disclosure` BOOLEAN COMMENT 'Indicates whether the disclosure was made for Treatment, Payment, or Operations (TPO) purposes. TPO disclosures are exempt from HIPAA Accounting of Disclosures requirements per 45 CFR 164.528.',
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
    `system_source` STRING COMMENT 'The name or identifier of the source system or application that recorded the disclosure event, such as Epic EHR, Cerner Millennium, or HIE platform.',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this disclosure log record. Supports audit trail and accountability.',
    CONSTRAINT pk_disclosure_log PRIMARY KEY(`disclosure_log_id`)
) COMMENT 'Transactional record of every PHI disclosure made under a patient consent or authorization, providing the accounting of disclosures required by HIPAA. Captures disclosure date, recipient identity and type, purpose of disclosure, PHI elements disclosed, consent or authorization reference, and whether the disclosure was for TPO (exempt from accounting) or non-TPO (subject to accounting). Enables generation of the HIPAA Accounting of Disclosures report provided to patients upon request per 45 CFR 164.528.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` (
    `capacity_assessment_id` BIGINT COMMENT 'Unique identifier for the consent capacity assessment record. Primary key for this entity.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician who performed the capacity assessment. Typically a physician, psychiatrist, or psychologist qualified to assess decision-making capacity.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Capacity assessments follow organizational policies defining when assessments are required, who can perform them, and documentation standards. Links assessments to governing policies for audit trails,',
    `delegation_id` BIGINT COMMENT 'Identifier of the surrogate decision-maker engaged for this patient, if applicable.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient whose decision-making capacity is being assessed.',
    `employee_id` BIGINT COMMENT 'Identifier of the witness present during the assessment, if applicable.',
    `prior_capacity_assessment_id` BIGINT COMMENT 'Self-referencing FK on capacity_assessment (prior_capacity_assessment_id)',
    `consent_record_id` BIGINT COMMENT 'Identifier of the consent record for which this capacity assessment was performed. Links the assessment to the specific consent being sought.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the capacity assessment was conducted.',
    `amendment_reason` STRING COMMENT 'Reason for amendment if the assessment record was modified after initial completion.',
    `appreciation_ability` STRING COMMENT 'Assessment of the patients ability to appreciate how the information applies to their own situation.. Valid values are `intact|impaired|severely_impaired|not_assessed`',
    `assessing_clinician_specialty` STRING COMMENT 'Medical specialty of the clinician who performed the assessment (e.g., Psychiatry, Neurology, Internal Medicine).',
    `assessment_date` DATE COMMENT 'Date on which the capacity assessment was performed.',
    `assessment_duration_minutes` STRING COMMENT 'Duration of the capacity assessment in minutes.',
    `assessment_location` STRING COMMENT 'Physical location where the capacity assessment was conducted (e.g., patient room, consultation room, emergency department).',
    `assessment_status` STRING COMMENT 'Current status of the capacity assessment record.. Valid values are `completed|in_progress|cancelled|amended|entered_in_error`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the capacity assessment was completed.',
    `assessment_tool_used` STRING COMMENT 'Name of the standardized assessment instrument or tool used to evaluate capacity (e.g., MacCAT-T, Aid to Capacity Evaluation, UBACC).',
    `assessment_tool_version` STRING COMMENT 'Version number or edition of the assessment tool used.',
    `capacity_determination` STRING COMMENT 'Overall determination of the patients decision-making capacity resulting from the assessment.. Valid values are `full_capacity|diminished_capacity|lacks_capacity|indeterminate|reassessment_required`',
    `capacity_score` DECIMAL(18,2) COMMENT 'Numerical score from the assessment tool, if applicable. Range and interpretation depend on the specific tool used.',
    `choice_expression_ability` STRING COMMENT 'Assessment of the patients ability to express a clear and consistent choice.. Valid values are `intact|impaired|severely_impaired|not_assessed`',
    `clinical_basis_for_determination` STRING COMMENT 'Clinical rationale and evidence supporting the capacity determination, including relevant medical history, mental status findings, and observed behaviors.',
    `contributing_conditions` STRING COMMENT 'Medical or psychiatric conditions that may be affecting the patients decision-making capacity (e.g., dementia, delirium, depression, psychosis).',
    `contributing_medications` STRING COMMENT 'Medications that may be affecting the patients cognitive function or decision-making capacity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity assessment record was first created in the system.',
    `documentation_reference_code` STRING COMMENT 'Reference identifier to the full clinical documentation of the capacity assessment in the Electronic Health Record (EHR).',
    `ethics_consultation_obtained_flag` BOOLEAN COMMENT 'Indicates whether an ethics committee consultation was obtained regarding this capacity assessment.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required for the capacity assessment.',
    `language_code` STRING COMMENT 'ISO 639 language code for the language in which the assessment was conducted.. Valid values are `^[a-z]{2,3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity assessment record was last modified in the system.',
    `legal_authority_type` STRING COMMENT 'Type of legal authority the surrogate decision-maker holds, if applicable.. Valid values are `healthcare_proxy|power_of_attorney|legal_guardian|next_of_kin|court_appointed|none`',
    `legal_consultation_obtained_flag` BOOLEAN COMMENT 'Indicates whether legal consultation was obtained regarding this capacity assessment.',
    `reasoning_ability` STRING COMMENT 'Assessment of the patients ability to reason about treatment options and their consequences.. Valid values are `intact|impaired|severely_impaired|not_assessed`',
    `reassessment_recommended_flag` BOOLEAN COMMENT 'Indicates whether a follow-up capacity reassessment is recommended.',
    `reassessment_timeframe` STRING COMMENT 'Recommended timeframe for reassessment if indicated (e.g., 24 hours, 72 hours, after treatment of delirium).',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this capacity assessment record in the source system.',
    `specific_deficits_identified` STRING COMMENT 'Detailed description of specific cognitive or decision-making deficits identified during the assessment.',
    `surrogate_decision_maker_engaged_flag` BOOLEAN COMMENT 'Indicates whether a surrogate decision-maker was identified and engaged as a result of this capacity assessment.',
    `surrogate_relationship` STRING COMMENT 'Relationship of the surrogate decision-maker to the patient (e.g., spouse, adult child, legal guardian, healthcare proxy).',
    `understanding_ability` STRING COMMENT 'Assessment of the patients ability to understand relevant information about the treatment or decision.. Valid values are `intact|impaired|severely_impaired|not_assessed`',
    `witness_present_flag` BOOLEAN COMMENT 'Indicates whether a witness was present during the capacity assessment.',
    CONSTRAINT pk_capacity_assessment PRIMARY KEY(`capacity_assessment_id`)
) COMMENT 'Transactional record of formal clinical assessments of a patients decision-making capacity to provide informed consent. Captures assessment date, assessing clinician, assessment tool used (MacCAT-T, Aid to Capacity Evaluation), capacity determination (full capacity, diminished capacity, lacks capacity), specific deficits identified, clinical basis for determination, and whether a surrogate decision-maker was engaged. Required when capacity is in question and critical for legal defensibility of consent obtained from vulnerable populations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` (
    `consent_policy_id` BIGINT COMMENT 'Unique identifier for the consent policy record. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Consent-specific policies are often subordinate to or reference broader organizational compliance policies. Establishes policy hierarchy for governance, ensures consent policies align with enterprise ',
    `employee_id` BIGINT COMMENT 'Identifier of the user or role responsible for maintaining and updating this consent policy.',
    `primary_superseded_by_consent_policy_id` BIGINT COMMENT 'Reference to the consent policy that supersedes this policy. Populated when policy status is superseded. Null for active policies.',
    `tertiary_consent_last_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this consent policy record.',
    `applicable_facility_types` STRING COMMENT 'Comma-separated list of facility types where this consent policy applies (e.g., hospital, clinic, outpatient center, research facility, telehealth platform).',
    `applicable_service_lines` STRING COMMENT 'Comma-separated list of clinical service lines or departments where this consent policy applies (e.g., surgery, oncology, cardiology, behavioral health, radiology).',
    `approval_authority` STRING COMMENT 'Name of the organizational body, committee, or individual who approved this consent policy (e.g., Institutional Review Board, Legal Department, Chief Medical Officer, Compliance Committee).',
    `approval_date` DATE COMMENT 'Date when the consent policy was formally approved by the designated approval authority.',
    `capacity_assessment_required_flag` BOOLEAN COMMENT 'Indicates whether a formal capacity assessment is required before obtaining consent under this policy. True if capacity assessment is mandatory, False otherwise.',
    `capacity_assessment_triggers` STRING COMMENT 'Specific conditions or circumstances that trigger the requirement for a capacity assessment (e.g., cognitive impairment, altered mental status, high-risk procedure). Multiple triggers separated by semicolons.',
    `consent_category` STRING COMMENT 'Primary category of consent governed by this policy: treatment consent, research consent, data sharing authorization, HIPAA authorization, Health Information Exchange (HIE) opt-in/opt-out, or telehealth consent.. Valid values are `treatment|research|data_sharing|hipaa_authorization|hie|telehealth`',
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
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent policy record was last modified.',
    `legal_representative_allowed_flag` BOOLEAN COMMENT 'Indicates whether a legally authorized representative (LAR) may provide consent on behalf of the patient under this policy. True if LAR consent is permitted, False otherwise.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age (in years) at which an individual can provide independent consent under this policy without parental or guardian authorization. Null if no age restriction applies.',
    `minor_assent_required_flag` BOOLEAN COMMENT 'Indicates whether assent from a minor patient is required in addition to parental consent under this policy. True if minor assent is mandatory, False otherwise.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the consent policy, used for external reference and system integration.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `policy_description` STRING COMMENT 'Detailed description of the consent policy purpose, scope, and business context.',
    `policy_name` STRING COMMENT 'Human-readable name of the consent policy, used in user interfaces and documentation.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the consent policy: draft (under development), active (in use), suspended (temporarily inactive), retired (no longer used), or superseded (replaced by newer policy).. Valid values are `draft|active|suspended|retired|superseded`',
    `reconsent_interval_months` STRING COMMENT 'Number of months after which consent must be renewed if time-based re-consent is required. Null if time-based re-consent does not apply.',
    `reconsent_trigger_new_risk` BOOLEAN COMMENT 'Indicates whether the discovery of significant new risks triggers the requirement for re-consent under this policy. True if new risk requires re-consent, False otherwise.',
    `reconsent_trigger_protocol_amendment` BOOLEAN COMMENT 'Indicates whether a protocol amendment triggers the requirement for re-consent under this policy (primarily applicable to research consent). True if protocol amendment requires re-consent, False otherwise.',
    `reconsent_trigger_time_based` BOOLEAN COMMENT 'Indicates whether consent expires after a defined time period and requires renewal under this policy. True if time-based re-consent is required, False otherwise.',
    `regulatory_basis` STRING COMMENT 'Primary regulatory framework or legal requirement that mandates or governs this consent policy (e.g., HIPAA Privacy Rule, FDA 21 CFR Part 50, state-specific consent laws).',
    `regulatory_citations` STRING COMMENT 'Specific regulatory citations, statutes, or code sections that apply to this consent policy (e.g., 45 CFR 164.508, 21 CFR 50.25). Multiple citations separated by semicolons.',
    `required_consent_elements` STRING COMMENT 'Comma-separated list of mandatory elements that must be included in consent documentation governed by this policy (e.g., purpose, risks, benefits, alternatives, right to refuse, right to revoke).',
    `retention_period_years` STRING COMMENT 'Number of years that consent documentation governed by this policy must be retained to meet regulatory and legal requirements.',
    `revocation_allowed_flag` BOOLEAN COMMENT 'Indicates whether patients have the right to revoke consent obtained under this policy. True if revocation is permitted, False otherwise.',
    `revocation_instructions` STRING COMMENT 'Instructions and procedures that patients must follow to revoke consent obtained under this policy, including contact information and required documentation.',
    `version_number` STRING COMMENT 'Version identifier for the consent policy, following semantic versioning convention (e.g., 1.0, 2.1, 3.0.1).. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature is required for consent obtained under this policy. True if witness is mandatory, False otherwise.',
    CONSTRAINT pk_consent_policy PRIMARY KEY(`consent_policy_id`)
) COMMENT 'Reference master defining the organizations enterprise consent policies, rules, and requirements governing each consent type. Captures policy name, consent category governed, required consent elements, minimum age for independent consent, capacity assessment triggers, re-consent triggers (protocol amendment, significant new risk, time-based expiration), documentation requirements, and applicable regulatory citations. Drives consent workflow configuration and ensures consistent consent practice across all care settings and facilities.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`workflow` (
    `workflow_id` BIGINT COMMENT 'Unique identifier for the consent workflow configuration. Primary key for the consent workflow master record.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Workflows implement policy requirements operationally. Links workflow definitions to governing compliance policies to demonstrate that operational processes enforce policy requirements, essential for ',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_policy. Business justification: Consent workflows are the operational implementation of consent policies. Each workflow should reference the policy it implements. Adding consent_policy_id FK links workflow configuration to governing',
    `form_template_id` BIGINT COMMENT 'Reference to the default consent form template used in this workflow. Links to the consent_form_template master data for form content and versioning.',
    `parent_workflow_id` BIGINT COMMENT 'Self-referencing FK on workflow (parent_workflow_id)',
    `primary_superseded_by_consent_workflow_id` BIGINT COMMENT 'Reference to the consent workflow that replaces this workflow configuration. Supports workflow version history and transition management.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this consent workflow configuration record. Supports accountability and audit trail requirements.',
    `workflow_last_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who most recently modified this consent workflow configuration record. Supports accountability and audit trail requirements.',
    `superseded_by_consent_workflow_id` BIGINT COMMENT '',
    `applicable_care_setting` STRING COMMENT 'Healthcare delivery setting where this consent workflow applies. Determines the operational context and location-specific requirements for consent execution. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|surgical|ambulatory|telehealth|research|all — 8 candidates stripped; promote to reference product]',
    `applicable_service_line` STRING COMMENT 'Clinical service line or specialty area where this consent workflow is used. Enables service-specific consent process customization.',
    `capacity_assessment_required_flag` BOOLEAN COMMENT 'Indicates whether patient decision-making capacity assessment is required before consent execution. Ensures informed consent validity and legal compliance.',
    `workflow_code` STRING COMMENT 'Unique business identifier code for the consent workflow. Used for system integration and workflow reference across Electronic Health Record (EHR) systems.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `consent_category` STRING COMMENT 'Subcategory or specific classification of the consent type. Provides additional granularity for consent workflow segmentation and reporting.',
    `consent_type` STRING COMMENT 'Category of consent managed by this workflow. Defines the primary purpose and regulatory context of the consent process.. Valid values are `treatment|research|data_sharing|hipaa_authorization|hie_participation|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consent workflow configuration record was first created in the system. Supports audit trail and data lineage requirements.',
    `workflow_description` STRING COMMENT 'Detailed description of the consent workflow process, including its purpose, scope, and business context. Provides comprehensive documentation for workflow configuration and usage.',
    `effective_date` DATE COMMENT 'Date when this consent workflow configuration becomes active and available for use. Supports version control and regulatory compliance tracking.',
    `ehr_event_mapping` STRING COMMENT 'Technical mapping or configuration that links Electronic Health Record (EHR) system events to this consent workflow. Defines the integration touchpoints and data exchange requirements.',
    `ehr_integration_enabled_flag` BOOLEAN COMMENT 'Indicates whether this consent workflow is integrated with Electronic Health Record (EHR) systems for automated triggering and documentation. Enables seamless consent management within clinical workflows.',
    `ehr_module_name` STRING COMMENT 'Specific module or component within the Electronic Health Record (EHR) system that triggers or consumes this consent workflow. Examples include Cadence (scheduling), ClinDoc (clinical documentation), or Healthy Planet (population health).',
    `ehr_system_name` STRING COMMENT 'Name of the Electronic Health Record (EHR) system integrated with this consent workflow. Identifies the source system for workflow triggering and consent documentation.',
    `electronic_signature_enabled_flag` BOOLEAN COMMENT 'Indicates whether electronic signature capture is enabled for this consent workflow. Supports digital consent execution and reduces paper-based processes.',
    `escalation_enabled_flag` BOOLEAN COMMENT 'Indicates whether workflow escalation rules are active for this consent workflow. Enables automated notification and intervention when consent is not obtained within required timeframes.',
    `escalation_recipient_role` STRING COMMENT 'Role or position that receives escalation notifications when consent workflow is not completed within required timeframes. Enables supervisory oversight and intervention.',
    `escalation_threshold_unit` STRING COMMENT 'Unit of measure for the escalation threshold value. Defines the temporal granularity for escalation timing.. Valid values are `minutes|hours|days`',
    `escalation_threshold_value` DECIMAL(18,2) COMMENT 'Numeric value representing when escalation should occur. Used with escalation_threshold_unit to define escalation timing.',
    `expiration_date` DATE COMMENT 'Date when this consent workflow configuration is no longer valid or available for use. Supports workflow lifecycle management and regulatory compliance.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether language interpretation services are required for consent execution in this workflow. Supports patient communication and informed consent requirements.',
    `irb_approval_required_flag` BOOLEAN COMMENT 'Indicates whether Institutional Review Board (IRB) approval is required for this consent workflow. Applies primarily to research consent workflows.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this consent workflow configuration record was most recently modified. Supports change tracking and audit trail requirements.',
    `legal_representative_allowed_flag` BOOLEAN COMMENT 'Indicates whether consent can be provided by a legal representative or authorized surrogate decision-maker. Supports consent for minors and incapacitated patients.',
    `workflow_name` STRING COMMENT 'Human-readable name of the consent workflow process. Describes the purpose and scope of the workflow for clinical and administrative users.',
    `regulatory_basis` STRING COMMENT 'Primary regulatory or legal requirement that mandates this consent workflow. Identifies the governing law, regulation, or standard that drives consent requirements.',
    `required_steps_sequence` STRING COMMENT 'Ordered list of workflow steps that must be completed for consent execution. Defines the procedural sequence and dependencies for consent collection and documentation.',
    `responsible_role` STRING COMMENT 'Primary clinical or administrative role responsible for executing this consent workflow. Defines accountability and access control requirements.',
    `revocation_allowed_flag` BOOLEAN COMMENT 'Indicates whether patients can revoke consent obtained through this workflow. Driven by regulatory requirements and consent type.',
    `revocation_workflow_code` STRING COMMENT 'Reference to the consent workflow used for processing consent revocations. Links to another consent_workflow record that defines the revocation process.',
    `secondary_role` STRING COMMENT 'Supporting or backup role that can execute this consent workflow. Provides operational flexibility and coverage for workflow execution.',
    `signature_method` STRING COMMENT 'Allowed method for capturing patient signature in this consent workflow. Defines the technical and legal approach to consent documentation.. Valid values are `wet_signature|electronic_signature|verbal|implied`',
    `workflow_status` STRING COMMENT 'Current lifecycle status of the consent workflow configuration. Determines whether the workflow is available for use in clinical and administrative systems.. Valid values are `active|inactive|draft|deprecated|suspended`',
    `step_count` STRING COMMENT 'Total number of discrete steps in the consent workflow process. Used for workflow complexity assessment and progress tracking.',
    `time_constraint_direction` STRING COMMENT 'Temporal relationship of the time constraint to the triggering event. Specifies whether consent must be obtained before, after, or within a time window of the event.. Valid values are `before|after|within`',
    `time_constraint_unit` STRING COMMENT 'Unit of measure for the time constraint value. Defines the temporal granularity for consent timing requirements.. Valid values are `minutes|hours|days|weeks`',
    `time_constraint_value` DECIMAL(18,2) COMMENT 'Numeric value representing the time constraint for consent completion. Used with time_constraint_unit to define when consent must be obtained relative to the triggering event.',
    `triggering_event_code` STRING COMMENT 'System-specific code or identifier for the triggering event. Used for integration with Electronic Health Record (EHR) scheduling, registration, and order management systems.',
    `triggering_event_type` STRING COMMENT 'Clinical or administrative event that initiates this consent workflow. Defines the business context in which consent must be obtained.. Valid values are `admission|surgical_scheduling|research_enrollment|telehealth_initiation|outpatient_registration|procedure_scheduling`',
    `version_number` STRING COMMENT 'Version identifier for this consent workflow configuration. Supports change management and audit trail requirements.. Valid values are `^[0-9]+.[0-9]+$`',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature is required for consent execution in this workflow. Driven by regulatory requirements and organizational policy.',
    `witness_role` STRING COMMENT 'Required role or qualification for the witness when witness signature is mandatory. Ensures compliance with regulatory and legal requirements.',
    CONSTRAINT pk_workflow PRIMARY KEY(`workflow_id`)
) COMMENT 'Master record defining the configured consent workflow processes for each consent type and care setting. Captures workflow name, consent type, triggering clinical event (admission, surgical scheduling, research enrollment, telehealth visit initiation), required steps and their sequence, responsible roles, time constraints (must be obtained X hours before procedure), escalation rules, and integration touchpoints with EHR scheduling and registration systems. Enables consistent, auditable consent process execution across the enterprise.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`deficiency` (
    `deficiency_id` BIGINT COMMENT 'Unique identifier for the consent deficiency record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Consent deficiencies discovered during operations often become formal audit findings requiring corrective action plans. Natural progression from operational issue to compliance finding. Essential for ',
    `care_site_id` BIGINT COMMENT 'Reference to the facility where the consent deficiency occurred or was identified.',
    `clinician_id` BIGINT COMMENT 'Reference to the provider responsible for obtaining the consent or addressing the deficiency.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_policy. Business justification: Consent deficiencies represent violations of consent policies. Adding consent_policy_id FK links each deficiency to the specific policy that was violated, enabling policy-based deficiency reporting an',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Deficiencies requiring remediation link to CAPs that document resolution actions, timelines, and verification. Essential for tracking remediation progress, demonstrating systematic issue resolution, a',
    `employee_id` BIGINT COMMENT 'Reference to the user who created the consent deficiency record.',
    `deficiency_employee_id` BIGINT COMMENT 'Reference to the user or staff member who identified the consent deficiency.',
    `deficiency_escalated_to_user_employee_id` BIGINT COMMENT 'Reference to the user or authority to whom the consent deficiency was escalated.',
    `deficiency_last_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last updated the consent deficiency record.',
    `deficiency_remediated_by_user_employee_id` BIGINT COMMENT 'Reference to the user or staff member who performed the remediation action.',
    `deficiency_waiver_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user or authority who approved the waiver of the consent deficiency.',
    `form_template_id` BIGINT COMMENT 'Reference to the consent form template that was required but deficient.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom the consent deficiency was identified.',
    `consent_record_id` BIGINT COMMENT 'Reference to the related consent record if one exists but is deficient.',
    `related_prior_deficiency_id` BIGINT COMMENT 'Self-referencing FK on deficiency (related_deficiency_id)',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the consent deficiency was identified or occurred.',
    `workflow_id` BIGINT COMMENT 'Foreign key linking to consent.workflow. Business justification: Consent deficiencies often occur when required workflow steps are not followed or completed. Linking deficiency to workflow enables tracking which workflow process was violated or incomplete, supporti',
    `audit_reference_number` STRING COMMENT 'Reference number linking the consent deficiency to a formal audit or accreditation survey.',
    `deficiency_category` STRING COMMENT 'High-level category of the consent deficiency aligned with consent management domains.. Valid values are `clinical|research|administrative|hipaa_authorization|hie_consent|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the consent deficiency record was first created in the system.',
    `deficiency_description` STRING COMMENT 'Detailed narrative description of the consent deficiency, including specific issues identified.',
    `discovered_by_role` STRING COMMENT 'Role or job function of the individual who discovered the deficiency (e.g., HIM Specialist, Nurse, Compliance Officer).',
    `discovery_date` DATE COMMENT 'Date on which the consent deficiency was identified.',
    `discovery_method` STRING COMMENT 'Method or process by which the consent deficiency was identified. [ENUM-REF-CANDIDATE: pre_procedure_checklist|him_audit|accreditation_survey|patient_complaint|peer_review|quality_audit|compliance_review|incident_report — promote to reference product]',
    `discovery_timestamp` TIMESTAMP COMMENT 'Precise date and time when the consent deficiency was identified.',
    `escalation_date` DATE COMMENT 'Date on which the consent deficiency was escalated for higher-level review.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the consent deficiency requires escalation to senior management or compliance leadership.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the consent deficiency record was last modified.',
    `mrn` STRING COMMENT 'The patients medical record number associated with this consent deficiency.',
    `number` STRING COMMENT 'Business identifier for the consent deficiency, used for tracking and reporting purposes.',
    `patient_safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the consent deficiency posed a risk to patient safety or care quality.',
    `procedure_code` STRING COMMENT 'CPT or HCPCS code for the procedure or service for which consent was required but deficient.',
    `procedure_description` STRING COMMENT 'Textual description of the procedure or service associated with the consent deficiency.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether the consent deficiency has potential regulatory or accreditation implications.',
    `remediation_action_taken` STRING COMMENT 'Description of the corrective action taken to remediate the consent deficiency.',
    `remediation_date` DATE COMMENT 'Date on which the consent deficiency was remediated or corrected.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether remediation action is required to address the consent deficiency.',
    `remediation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the consent deficiency was remediated.',
    `resolution_date` DATE COMMENT 'Date on which the consent deficiency was fully resolved (either remediated, waived, or closed).',
    `resolution_notes` STRING COMMENT 'Additional notes or comments regarding the resolution of the consent deficiency.',
    `responsible_department_code` STRING COMMENT 'Code identifying the department or service line responsible for the consent deficiency.',
    `scheduled_procedure_date` DATE COMMENT 'Date on which the procedure requiring consent was scheduled or performed.',
    `severity_level` STRING COMMENT 'Severity classification of the consent deficiency based on risk and regulatory impact.. Valid values are `critical|high|medium|low`',
    `source_system_deficiency_code` STRING COMMENT 'Unique identifier for the consent deficiency in the source system.',
    `deficiency_status` STRING COMMENT 'Current lifecycle status of the consent deficiency in the remediation workflow.. Valid values are `open|in_progress|remediated|waived|closed`',
    `deficiency_type` STRING COMMENT 'Classification of the type of consent deficiency identified. [ENUM-REF-CANDIDATE: not_obtained|improperly_documented|expired|incomplete|missing_signature|missing_witness|invalid_representative|capacity_not_assessed|language_barrier_not_addressed — promote to reference product]',
    `waiver_date` DATE COMMENT 'Date on which the consent deficiency waiver was approved.',
    `waiver_reason` STRING COMMENT 'Explanation or justification for waiving the consent deficiency without remediation.',
    CONSTRAINT pk_deficiency PRIMARY KEY(`deficiency_id`)
) COMMENT 'Transactional record of identified consent deficiencies — instances where required consent was not obtained, was improperly documented, expired, or is otherwise incomplete at the time of care delivery or audit. Captures deficiency type, discovery method (pre-procedure checklist, HIM audit, accreditation survey, patient complaint), responsible provider or department, deficiency status (open, remediated, waived), remediation action taken, and resolution date. Supports HIM, compliance, and quality improvement workflows for consent management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` (
    `substance_use_consent_id` BIGINT COMMENT 'Unique identifier for the substance use disorder consent record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the healthcare facility or substance use disorder treatment program where this consent authorization was obtained.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the healthcare provider or staff member who obtained this substance use disorder consent authorization from the patient.',
    `direct_message_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_message. Business justification: 42 CFR Part 2 consents for substance use disorder treatment are frequently transmitted via Direct messaging to coordinate care with external providers. Required to track which Direct message carried t',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who is the subject of this substance use disorder consent.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Substance use consent is a specialized type of consent record governed by 42 CFR Part 2. Linking to the core record table enables unified consent management. Core consent lifecycle attributes (status,',
    `superseded_substance_use_consent_id` BIGINT COMMENT 'Self-referencing FK on substance_use_consent (superseded_substance_use_consent_id)',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical encounter during which this substance use disorder consent authorization was obtained, if applicable.',
    `capacity_assessment_performed_flag` BOOLEAN COMMENT 'Indicates whether a formal assessment of the patient capacity to provide informed consent was performed prior to obtaining this substance use disorder consent authorization.',
    `capacity_assessment_result` STRING COMMENT 'The result of the capacity assessment, indicating whether the patient was deemed to have the capacity to provide informed consent for substance use disorder information disclosure.. Valid values are `has_capacity|lacks_capacity|partial_capacity`',
    `cares_act_compliant_flag` BOOLEAN COMMENT 'Indicates whether this substance use disorder consent authorization complies with the 2020 CARES Act amendments to 42 CFR Part 2, which permit disclosure for treatment, payment, and healthcare operations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this substance use disorder consent record was first created in the system.',
    `disclosure_purpose` STRING COMMENT 'The specific purpose for which substance use disorder treatment information may be disclosed, as required by 42 CFR Part 2 Section 2.31(a)(4).',
    `disclosure_purpose_category` STRING COMMENT 'High-level categorization of the disclosure purpose, aligned with CARES Act 2020 amendments allowing disclosure for treatment, payment, and healthcare operations.. Valid values are `treatment|payment|healthcare_operations|research|legal|other`',
    `document_reference` STRING COMMENT 'Reference identifier or URI to the scanned or electronically stored copy of the signed substance use disorder consent authorization document.',
    `expiration_event` STRING COMMENT 'Description of the event that will terminate this consent authorization if expiration is event-based rather than date-based, as permitted by 42 CFR Part 2 Section 2.31(a)(8).',
    `form_version` STRING COMMENT 'The version identifier of the substance use disorder consent form template used to capture this authorization.',
    `information_disclosed_description` STRING COMMENT 'Detailed description of the specific substance use disorder treatment information to be disclosed, as required by 42 CFR Part 2 Section 2.31(a)(3).',
    `interpreter_name` STRING COMMENT 'The name of the interpreter who assisted the patient in understanding this substance use disorder consent authorization, if applicable.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required to facilitate the patient understanding and signing of this substance use disorder consent authorization.',
    `language_code` STRING COMMENT 'The ISO 639-1 language code indicating the language in which this substance use disorder consent authorization was presented to and signed by the patient.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this substance use disorder consent record was most recently updated in the system.',
    `mrn` STRING COMMENT 'The medical record number of the patient as recorded in the substance use disorder treatment program.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding this substance use disorder consent authorization, including special circumstances or clarifications.',
    `personal_representative_flag` BOOLEAN COMMENT 'Indicates whether this consent authorization was signed by a personal representative on behalf of the patient rather than by the patient directly.',
    `personal_representative_name` STRING COMMENT 'The name of the personal representative who signed this substance use disorder consent authorization on behalf of the patient, if applicable.',
    `personal_representative_relationship` STRING COMMENT 'The relationship of the personal representative to the patient, such as parent, legal guardian, or healthcare power of attorney.',
    `recipient_address` STRING COMMENT 'The mailing or physical address of the recipient authorized to receive substance use disorder treatment information.',
    `recipient_name` STRING COMMENT 'The name of the person or organization to whom substance use disorder treatment information may be disclosed, as required by 42 CFR Part 2 Section 2.31(a)(5).',
    `recipient_npi` STRING COMMENT 'The National Provider Identifier of the recipient organization or provider authorized to receive substance use disorder treatment information.',
    `recipient_organization` STRING COMMENT 'The organization or entity name of the recipient authorized to receive substance use disorder treatment information.',
    `redisclosure_prohibition_included_flag` BOOLEAN COMMENT 'Indicates whether the required redisclosure prohibition notice was included with this consent authorization, as mandated by 42 CFR Part 2 Section 2.32.',
    `redisclosure_prohibition_notice` STRING COMMENT 'The required notice to recipients that substance use disorder treatment information is protected by federal law and cannot be redisclosed without patient consent, as mandated by 42 CFR Part 2 Section 2.32.',
    `right_to_revoke_statement` STRING COMMENT 'The statement informing the patient of their right to revoke this consent authorization and the procedure for doing so, as required by 42 CFR Part 2 Section 2.31(a)(9).',
    `signature_date` DATE COMMENT 'The date on which the patient signed this substance use disorder consent authorization, as required by 42 CFR Part 2 Section 2.31(a)(10).',
    `signature_method` STRING COMMENT 'The method by which the patient signature was captured for this substance use disorder consent authorization.. Valid values are `wet_signature|electronic|digital|biometric`',
    `signature_obtained_flag` BOOLEAN COMMENT 'Indicates whether the patient signature was obtained on this substance use disorder consent authorization, as required by 42 CFR Part 2 Section 2.31(a)(10).',
    `source_system_code` STRING COMMENT 'The unique identifier for this substance use disorder consent record in the source system from which it was extracted.',
    `sud_program_name` STRING COMMENT 'The specific name of the substance use disorder treatment program or facility making the disclosure, as required by 42 CFR Part 2.',
    `sud_program_npi` STRING COMMENT 'The National Provider Identifier of the substance use disorder treatment program or facility.',
    `witness_name` STRING COMMENT 'The name of the witness who observed the patient signing this substance use disorder consent authorization, if applicable.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this substance use disorder consent authorization based on program policy or patient capacity.',
    `witness_signature_date` DATE COMMENT 'The date on which the witness signed this substance use disorder consent authorization, if applicable.',
    CONSTRAINT pk_substance_use_consent PRIMARY KEY(`substance_use_consent_id`)
) COMMENT 'Specialized master record for consent and authorization governing disclosure of substance use disorder (SUD) treatment records, which carry heightened federal confidentiality protections beyond standard HIPAA. Captures consent elements required by 42 CFR Part 2 including specific program name, patient name, specific information to be disclosed, purpose of disclosure, recipient, expiration, and right to revoke. Tracks re-disclosure prohibition notices and patient-permitted disclosures for treatment, payment, and operations under the 2020 CARES Act amendments.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` (
    `behavioral_health_consent_id` BIGINT COMMENT 'Unique identifier for the behavioral health consent record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Unique identifier of the healthcare facility where this consent was obtained.',
    `clinician_id` BIGINT COMMENT 'Unique identifier of the healthcare provider or staff member who obtained this behavioral health consent from the patient.',
    `direct_message_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_message. Business justification: Behavioral health consents are transmitted via Direct messaging for care coordination while maintaining heightened privacy protections required by state mental health laws. Tracking which Direct messa',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who is the subject of this behavioral health consent.',
    `superseded_behavioral_health_consent_id` BIGINT COMMENT 'Self-referencing FK on behavioral_health_consent (superseded_behavioral_health_consent_id)',
    `visit_id` BIGINT COMMENT 'Unique identifier of the clinical encounter during which this behavioral health consent was obtained, if applicable.',
    `authorized_recipient_address` STRING COMMENT 'Mailing or physical address of the authorized recipient organization or individual.',
    `authorized_recipient_name` STRING COMMENT 'Name of the individual, organization, or entity authorized to receive the behavioral health information under this consent.',
    `authorized_recipient_npi` STRING COMMENT 'National Provider Identifier of the authorized recipient if the recipient is a healthcare provider or organization.',
    `authorized_recipient_type` STRING COMMENT 'Classification of the authorized recipient (individual provider, healthcare organization, insurance payer, legal entity, research institution).. Valid values are `individual|organization|provider|payer|legal_entity|research_institution`',
    `capacity_assessment_performed_flag` BOOLEAN COMMENT 'Indicates whether a formal assessment of the patients decision-making capacity was performed prior to obtaining this consent.',
    `capacity_determination` STRING COMMENT 'The clinical determination of the patients decision-making capacity at the time this consent was obtained.. Valid values are `has_capacity|lacks_capacity|partial_capacity|not_assessed`',
    `consent_number` STRING COMMENT 'Externally-known unique identifier or tracking number for this behavioral health consent authorization.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the behavioral health consent authorization.. Valid values are `active|revoked|expired|pending|superseded|voided`',
    `consent_type` STRING COMMENT 'The category of behavioral health consent being granted (disclosure authorization, treatment consent, research participation, data sharing, HIE participation).. Valid values are `disclosure|treatment|research|data_sharing|hie_participation`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this behavioral health consent record was first created in the system.',
    `disclosure_purpose` STRING COMMENT 'The specific purpose for which the behavioral health information may be disclosed (e.g., continuity of care, legal proceedings, disability determination, insurance underwriting).',
    `disclosure_purpose_category` STRING COMMENT 'High-level category of the disclosure purpose for reporting and analytics. [ENUM-REF-CANDIDATE: treatment|payment|legal|research|personal|disability|other — 7 candidates stripped; promote to reference product]',
    `document_reference_code` STRING COMMENT 'Reference identifier or URI to the scanned or electronically stored copy of the signed consent form document.',
    `effective_date` DATE COMMENT 'The date on which this behavioral health consent authorization becomes effective and enforceable.',
    `expiration_date` DATE COMMENT 'The date on which this behavioral health consent authorization expires. Null if no expiration date is specified.',
    `expiration_event` STRING COMMENT 'Description of the event or condition that will cause this consent to expire (e.g., end of treatment episode, completion of legal proceeding, patient request).',
    `form_version` STRING COMMENT 'Version identifier of the behavioral health consent form template used for this authorization.',
    `interpreter_name` STRING COMMENT 'Name of the language interpreter who assisted in obtaining this consent, if applicable.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required to obtain this consent due to patient language preference or limited English proficiency.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter code indicating the language in which this consent was presented and obtained.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this behavioral health consent record was most recently modified.',
    `legal_authority_type` STRING COMMENT 'The type of legal authority under which the representative is acting on behalf of the patient.. Valid values are `parental|guardianship|power_of_attorney|conservatorship|court_order`',
    `legal_representative_flag` BOOLEAN COMMENT 'Indicates whether this consent was signed by a legal representative or surrogate decision-maker on behalf of the patient.',
    `legal_representative_name` STRING COMMENT 'Name of the legal representative or surrogate decision-maker who signed this consent on behalf of the patient.',
    `legal_representative_relationship` STRING COMMENT 'The legal relationship of the representative to the patient (e.g., parent, legal guardian, healthcare power of attorney, conservator).',
    `mental_health_data_elements_covered` STRING COMMENT 'Specific categories of behavioral health information covered by this consent (e.g., psychotherapy notes, psychiatric hospitalization records, mental illness medications, substance abuse treatment records). Pipe-delimited list.',
    `mrn` STRING COMMENT 'The medical record number assigned to the patient by the healthcare organization.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding this behavioral health consent authorization.',
    `obtaining_provider_npi` STRING COMMENT 'National Provider Identifier of the provider who obtained this consent.',
    `patient_imposed_restrictions` STRING COMMENT 'Free-text description of any specific restrictions or limitations the patient has placed on the disclosure of their behavioral health information.',
    `psychotherapy_notes_included_flag` BOOLEAN COMMENT 'Indicates whether HIPAA-protected psychotherapy notes are explicitly included in the scope of this consent authorization.',
    `redisclosure_prohibition_statement` STRING COMMENT 'Statement informing the recipient that the disclosed behavioral health information is protected by state and federal law and may not be redisclosed without patient authorization.',
    `revocation_date` DATE COMMENT 'The date on which the patient revoked this behavioral health consent authorization. Null if not revoked.',
    `revocation_method` STRING COMMENT 'The method by which the patient communicated their revocation of this consent (written notice, verbal request, electronic submission, in-person notification).. Valid values are `written|verbal|electronic|in_person`',
    `revocation_reason` STRING COMMENT 'Free-text explanation of the reason the patient provided for revoking this consent, if documented.',
    `right_to_revoke_statement` STRING COMMENT 'Statement informing the patient of their right to revoke this consent authorization and the process for doing so.',
    `signature_date` DATE COMMENT 'The date on which the patient or authorized representative signed this behavioral health consent authorization.',
    `signature_method` STRING COMMENT 'The method used to capture the patient or representative signature (wet ink, electronic signature, digital signature, biometric, recorded verbal consent).. Valid values are `wet_signature|electronic|digital|biometric|verbal_recorded`',
    `signature_obtained_flag` BOOLEAN COMMENT 'Indicates whether a valid patient or authorized representative signature was obtained for this consent authorization.',
    `source_system_code` STRING COMMENT 'The unique identifier for this consent record in the source operational system.',
    `state_jurisdiction` STRING COMMENT 'The U.S. state whose mental health confidentiality laws apply to this consent (two-letter state code).',
    `state_law_basis` STRING COMMENT 'Citation of the specific state statute or regulation governing heightened confidentiality protections for behavioral health records in the applicable jurisdiction.',
    `substance_abuse_records_included_flag` BOOLEAN COMMENT 'Indicates whether substance abuse treatment records subject to 42 CFR Part 2 protections are included in this consent.',
    `witness_name` STRING COMMENT 'Name of the individual who witnessed the signing of this behavioral health consent authorization, if applicable.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this consent under applicable state law or organizational policy.',
    `witness_signature_date` DATE COMMENT 'The date on which the witness signed this consent authorization, if applicable.',
    CONSTRAINT pk_behavioral_health_consent PRIMARY KEY(`behavioral_health_consent_id`)
) COMMENT 'Specialized master record for consent governing disclosure of behavioral health, mental health, and psychiatric treatment records, which are subject to state-specific heightened confidentiality protections beyond standard HIPAA. Captures state law basis, specific mental health data elements covered (psychotherapy notes, psychiatric hospitalization, medication for mental illness), authorized recipients, purpose, expiration, and patient-imposed restrictions. Manages the complex intersection of HIPAA psychotherapy note protections and state mental health confidentiality statutes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` (
    `expiration_alert_id` BIGINT COMMENT 'Unique identifier for the consent expiration alert record. Primary key for the consent expiration alert operational tracking entity.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or provider assigned responsibility for resolving this consent expiration alert. May be consent coordinator, case manager, or clinical staff depending on consent type and organizational workflow.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose consent is expiring. Enables patient-centric alert routing and notification workflows.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or care team responsible for consent renewal action. Enables departmental worklist routing and accountability tracking.',
    `prior_expiration_alert_id` BIGINT COMMENT 'Self-referencing FK on expiration_alert (prior_expiration_alert_id)',
    `consent_record_id` BIGINT COMMENT 'Reference to the consent record that is approaching or past expiration. Links this alert to the specific consent requiring renewal action.',
    `visit_id` BIGINT COMMENT 'Reference to a scheduled patient encounter or appointment that requires the expiring consent. Links alert to specific care event at risk of delay or cancellation.',
    `workflow_id` BIGINT COMMENT 'Foreign key linking to consent.workflow. Business justification: Expiration alerts trigger consent renewal workflows. Linking expiration_alert to workflow enables tracking which renewal workflow should be initiated for each alert, supporting automated workflow trig',
    `alert_generation_date` DATE COMMENT 'The date on which this expiration alert was generated by the consent monitoring system. Establishes alert creation timeline for SLA tracking.',
    `alert_generation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the alert was created by the automated consent expiration monitoring process. Used for audit trail and alert latency analysis.',
    `alert_number` STRING COMMENT 'Human-readable business identifier for the consent expiration alert. Format: CEA-XXXXXXXXXX where X is a digit. Used for tracking and reference in workflows and communications.. Valid values are `^CEA-[0-9]{10}$`',
    `alert_priority` STRING COMMENT 'Business priority level assigned to the alert based on consent type, patient care impact, and time to expiration. Drives workflow routing and staff assignment.. Valid values are `low|medium|high|urgent`',
    `alert_status` STRING COMMENT 'Current lifecycle status of the consent expiration alert. Open indicates new alert requiring attention; acknowledged indicates staff awareness; in progress indicates renewal workflow initiated; resolved indicates consent renewed or issue addressed; escalated indicates elevated priority; cancelled indicates alert no longer applicable.. Valid values are `open|acknowledged|in_progress|resolved|escalated|cancelled`',
    `alert_type` STRING COMMENT 'Classification of the expiration alert based on urgency and timing. Approaching expiration indicates consent nearing end date; expired indicates consent has lapsed; renewal required indicates proactive action needed; grace period indicates post-expiration window; critical indicates immediate action required to prevent care disruption.. Valid values are `approaching_expiration|expired|renewal_required|grace_period|critical`',
    `auto_renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether the consent is eligible for automatic renewal without patient re-signature based on consent type and organizational policy. True if auto-renewal allowed; false if patient action required.',
    `care_impact_flag` BOOLEAN COMMENT 'Indicates whether the expiring consent has direct impact on patient care delivery. True if consent expiration would delay or prevent scheduled treatment, procedures, or services; false if administrative only.',
    `consent_expiration_date` DATE COMMENT 'The date on which the referenced consent record expires or expired. Denormalized from consent record for alert processing efficiency and historical tracking.',
    `consent_scope` STRING COMMENT 'The scope or coverage of the expiring consent. Denormalized from consent record to inform renewal urgency. Examples: General Treatment, Specific Procedure, Research Study Participation, Broad Data Sharing, Limited Disclosure.',
    `consent_type` STRING COMMENT 'The category of consent that is expiring. Denormalized from consent record for alert filtering and prioritization. Examples: Treatment Consent, Research Consent, HIPAA Authorization, HIE Opt-In, Telehealth Consent, Data Sharing Authorization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `days_until_expiration` STRING COMMENT 'Number of days remaining until consent expiration at the time of alert generation. Negative values indicate days since expiration. Used for alert prioritization and workflow routing.',
    `escalation_date` DATE COMMENT 'The date on which the alert was escalated. Null if no escalation occurred.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this alert has been escalated to higher authority or management due to unresolved status, patient unreachability, or care impact. True if escalated; false if standard workflow.',
    `escalation_reason` STRING COMMENT 'The reason or justification for escalating the alert. Examples: Patient unreachable after multiple attempts, consent critical for scheduled procedure, regulatory compliance risk, patient dispute.',
    `last_reminder_date` DATE COMMENT 'The date of the most recent reminder notification sent for this alert. Used to schedule follow-up reminders and assess communication frequency.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was most recently modified. Tracks alert lifecycle changes and status updates.',
    `next_action_due_date` DATE COMMENT 'The target date by which the next action (patient contact, escalation, resolution) should be completed. Drives workflow task scheduling and SLA monitoring.',
    `notification_channel` STRING COMMENT 'Primary communication channel used to deliver the expiration alert notification. Patient portal for patient-facing alerts; staff worklist for clinical team alerts; EHR alert for in-system notifications; email, SMS, phone, mail for direct outreach; none if alert is internal only. [ENUM-REF-CANDIDATE: patient_portal|staff_worklist|ehr_alert|email|sms|phone|mail|none — 8 candidates stripped; promote to reference product]',
    `notification_delivery_status` STRING COMMENT 'Detailed status of notification delivery attempt. Pending indicates queued; sent indicates transmitted; delivered indicates confirmed receipt; failed indicates delivery error; bounced indicates invalid recipient; read indicates recipient opened notification.. Valid values are `pending|sent|delivered|failed|bounced|read`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an alert notification has been successfully sent through the designated channel. True if notification delivered; false if pending or failed.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the alert notification was successfully delivered to the recipient. Null if notification not yet sent or failed.',
    `patient_contact_attempted_flag` BOOLEAN COMMENT 'Indicates whether staff have attempted to contact the patient regarding consent renewal. True if outreach initiated; false if no contact attempt made.',
    `patient_contact_date` DATE COMMENT 'The date on which staff successfully contacted the patient regarding the expiring consent. Null if contact not yet made or unsuccessful.',
    `patient_response` STRING COMMENT 'The patients response to the consent renewal request. Agreed to renew indicates patient consent to continue; declined renewal indicates patient wishes to revoke or not extend; requested modification indicates patient wants changes; no response indicates patient has not replied; unreachable indicates contact attempts failed.. Valid values are `agreed_to_renew|declined_renewal|requested_modification|no_response|unreachable`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the expiring consent is required for regulatory compliance (HIPAA, research IRB, state law). True if regulatory mandate; false if organizational policy only.',
    `reminder_count` STRING COMMENT 'The number of reminder notifications sent to patient or staff regarding this expiring consent. Used to track outreach intensity and prevent notification fatigue.',
    `renewal_method` STRING COMMENT 'The method or channel through which consent renewal should be obtained. In-person for clinic visit; patient portal for electronic signature; telehealth for virtual visit; mail for postal forms; phone for verbal consent; email for electronic forms; not applicable if renewal not required. [ENUM-REF-CANDIDATE: in_person|patient_portal|telehealth|mail|phone|email|not_applicable — 7 candidates stripped; promote to reference product]',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the expiring consent requires active patient re-consent or renewal action. True if patient signature or new authorization needed; false if consent can be administratively extended or is not renewable.',
    `resolution_date` DATE COMMENT 'The date on which the consent expiration alert was resolved or closed. Null if alert remains open.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the actions taken to resolve the alert, patient interactions, barriers encountered, and final outcome. Supports audit trail and quality improvement.',
    `resolution_status` STRING COMMENT 'The outcome or resolution of the consent expiration alert. Pending indicates unresolved; consent renewed indicates patient re-consented; consent revoked indicates patient declined continuation; consent expired indicates lapsed without renewal; administrative extension indicates organizational extension granted; patient unreachable indicates contact failure; no action required indicates alert cancelled or superseded. [ENUM-REF-CANDIDATE: pending|consent_renewed|consent_revoked|consent_expired|administrative_extension|patient_unreachable|no_action_required — 7 candidates stripped; promote to reference product]',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the alert was resolved or closed. Used for alert resolution time analysis and Service Level Agreement (SLA) compliance tracking.',
    `responsible_staff_role` STRING COMMENT 'The functional role or job title of the staff member assigned to this alert. Examples: Consent Coordinator, Case Manager, Primary Care Physician (PCP), Nurse Navigator, Health Information Management (HIM) Specialist.',
    `scheduled_procedure_date` DATE COMMENT 'The date of a scheduled procedure or service that requires the expiring consent. Used to assess urgency and care impact of unresolved alert.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the alert resolution exceeded the SLA target resolution time. True if SLA breached; false if resolved within target.',
    `sla_target_resolution_hours` STRING COMMENT 'The number of hours within which this alert should be resolved per organizational Service Level Agreement (SLA). Based on alert priority and consent type.',
    CONSTRAINT pk_expiration_alert PRIMARY KEY(`expiration_alert_id`)
) COMMENT 'Operational record tracking consent records approaching or past their expiration date that require patient re-consent or renewal action. Captures consent reference, expiration date, alert generation date, alert type (approaching expiration, expired, renewal required), notification channel used (patient portal, staff worklist, EHR alert), responsible staff member, and resolution status. Drives proactive consent renewal workflows to prevent care delays and compliance gaps from expired consents.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` (
    `genetic_testing_consent_id` BIGINT COMMENT 'Unique identifier for the genetic testing consent record. Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the genetic testing consent was obtained. Links to the facility master record.',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider who obtained the genetic testing consent from the patient. Links to the provider master record.',
    `employee_id` BIGINT COMMENT 'Reference to the genetic counselor who provided pre-test counseling and education to the patient. May be null if genetic counseling was not provided.',
    `form_template_id` BIGINT COMMENT 'Reference to the standardized consent form template used for this genetic testing consent. Links to the template that defines the structure and regulatory requirements.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is providing consent for genetic testing. Links to the patient master record.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Genetic testing consent is a specialized type of consent record. It should link to the core consent.record table to maintain referential integrity and enable unified consent reporting. The specialized',
    `research_study_id` BIGINT COMMENT 'Reference to the research study if the genetic testing is being performed as part of a research protocol. Null for clinical testing not associated with research.',
    `superseded_genetic_testing_consent_id` BIGINT COMMENT 'Self-referencing FK on genetic_testing_consent (superseded_genetic_testing_consent_id)',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the genetic testing consent was obtained. May be null for consents obtained outside of a specific encounter.',
    `authorized_representative_flag` BOOLEAN COMMENT 'Indicates whether the consent was obtained from an authorized representative rather than the patient directly. True if representative signed, false if patient signed.',
    `authorized_representative_name` STRING COMMENT 'The full name of the authorized representative who provided consent on behalf of the patient. Null if patient provided consent directly.',
    `authorized_representative_relationship` STRING COMMENT 'The relationship of the authorized representative to the patient. Examples include parent, legal guardian, healthcare proxy, power of attorney. Null if patient provided consent directly.',
    `biobank_storage_consent` STRING COMMENT 'The patients authorization for their biological samples to be stored in a biobank for future use. Defines duration and conditions of sample storage.. Valid values are `authorized|not_authorized|time_limited`',
    `capacity_assessment_performed_flag` BOOLEAN COMMENT 'Indicates whether a formal assessment of the patients decision-making capacity was performed prior to obtaining consent. True if assessment occurred, false otherwise.',
    `capacity_assessment_result` STRING COMMENT 'The outcome of the capacity assessment. Indicates whether the patient was determined to have full, partial, or no decision-making capacity. Null if assessment was not performed.. Valid values are `has_capacity|lacks_capacity|partial_capacity`',
    `commercial_use_consent` STRING COMMENT 'The patients authorization for their genetic data or samples to be used for commercial purposes such as drug development or diagnostic test development. Defines scope of commercial use.. Valid values are `authorized|not_authorized`',
    `consent_decision` STRING COMMENT 'The patients decision regarding the genetic testing consent. Indicates whether the patient agreed to, declined, or partially consented to the testing.. Valid values are `granted|declined|partial`',
    `consent_scope` STRING COMMENT 'The breadth of authorization provided by the patient. Defines whether consent covers only the immediate test or extends to future research, biobanking, or data sharing.. Valid values are `specific_test_only|future_research_use|biobank_storage|data_sharing|all`',
    `counseling_date` DATE COMMENT 'The date on which genetic counseling was provided to the patient. Null if counseling was not provided.',
    `counseling_provided_flag` BOOLEAN COMMENT 'Indicates whether genetic counseling was provided to the patient prior to obtaining consent. True if counseling occurred, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this genetic testing consent record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_retention_period_years` STRING COMMENT 'The number of years for which the genetic data and samples will be retained. May be null for indefinite retention or as specified by patient preference.',
    `document_reference_code` STRING COMMENT 'Reference to the stored consent document in the document management system. Used for retrieving the signed consent form for audit or legal purposes.',
    `family_implications_disclosed_flag` BOOLEAN COMMENT 'Indicates whether the patient was informed that genetic test results may have implications for biological family members. True if disclosure occurred, false otherwise.',
    `family_notification_consent` STRING COMMENT 'The patients authorization for the healthcare provider to contact biological family members if test results reveal hereditary conditions. Defines scope of family outreach.. Valid values are `authorized|not_authorized|conditional`',
    `form_version` STRING COMMENT 'The version identifier of the genetic testing consent form used. Used for tracking form revisions and ensuring regulatory compliance.',
    `gina_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the patient was informed about GINA protections and limitations regarding genetic discrimination by health insurers and employers. True if disclosure occurred, false otherwise.',
    `incidental_findings_consent` STRING COMMENT 'The patients preference regarding the return of incidental or secondary findings discovered during genetic testing. Defines what types of unexpected findings should be disclosed.. Valid values are `return_all|return_medically_actionable|do_not_return|patient_to_decide_later`',
    `insurance_discrimination_risk_disclosed_flag` BOOLEAN COMMENT 'Indicates whether the patient was informed about potential risks of genetic discrimination by life, disability, or long-term care insurers not covered by GINA. True if disclosure occurred, false otherwise.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required to facilitate the consent process. True if interpreter was used, false otherwise.',
    `irb_approval_number` STRING COMMENT 'The approval number assigned by the Institutional Review Board if the genetic testing is part of a research study. Null for clinical testing not subject to IRB oversight.',
    `language_code` STRING COMMENT 'The ISO 639-1 two-letter code representing the language in which the genetic testing consent was provided to the patient. Used for language access compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this genetic testing consent record was most recently modified. Used for audit trail and change tracking.',
    `mrn` STRING COMMENT 'The unique medical record number assigned to the patient by the healthcare organization. Used for patient identification and record linkage.',
    `notes` STRING COMMENT 'Free-text field for capturing additional information, special circumstances, or clarifications related to the genetic testing consent process.',
    `obtaining_provider_npi` STRING COMMENT 'The National Provider Identifier of the healthcare provider who obtained the genetic testing consent. Used for provider identification and credentialing.',
    `recontact_consent` STRING COMMENT 'The patients authorization for the healthcare provider or research team to recontact them in the future if new clinically significant findings emerge from their genetic data. Defines scope of future communication.. Valid values are `authorized|not_authorized|conditional`',
    `research_registry_sharing_consent` STRING COMMENT 'The patients authorization for their genetic data to be shared with external research registries or databases. Defines scope of data sharing permissions.. Valid values are `authorized|not_authorized|authorized_with_restrictions`',
    `research_use_consent` STRING COMMENT 'The patients authorization for their genetic data and samples to be used in future research studies. Defines scope and limitations of research use.. Valid values are `authorized|not_authorized|authorized_with_restrictions`',
    `signature_date` DATE COMMENT 'The date on which the patient signed the genetic testing consent form. May differ from obtained date if form was signed and processed on different dates.',
    `signature_method` STRING COMMENT 'The method by which the patients signature was obtained. Indicates whether signature was electronic, physical, verbal, or obtained through an authorized representative.. Valid values are `electronic|wet_signature|verbal|proxy`',
    `signature_obtained_flag` BOOLEAN COMMENT 'Indicates whether the patients signature was obtained on the genetic testing consent form. True if signature was captured, false otherwise.',
    `source_system_code` STRING COMMENT 'The unique identifier for this genetic testing consent record in the source system. Used for data reconciliation and troubleshooting.',
    `state_jurisdiction` STRING COMMENT 'The two-letter US state code or jurisdiction where the consent was obtained. Used for applying state-specific genetic privacy laws and regulations.',
    `test_name` STRING COMMENT 'The specific name or description of the genetic test to be performed. May include gene panel names, specific gene targets, or test methodology.',
    `test_purpose` STRING COMMENT 'The primary clinical or research purpose for performing the genetic test. Defines the intended use of the test results. [ENUM-REF-CANDIDATE: clinical_diagnosis|risk_assessment|treatment_selection|family_planning|research|ancestry|other — 7 candidates stripped; promote to reference product]',
    `test_type` STRING COMMENT 'The category of genetic testing for which consent is being obtained. Defines the scope and purpose of the genetic analysis to be performed. [ENUM-REF-CANDIDATE: diagnostic|predictive|carrier|pharmacogenomic|whole_genome_sequencing|whole_exome_sequencing|targeted_panel|prenatal|newborn_screening|other — 10 candidates stripped; promote to reference product]',
    `witness_name` STRING COMMENT 'The full name of the witness who observed the consent process and signed the form. Null if witness was not required or not present.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this genetic testing consent based on regulatory requirements or organizational policy. True if witness required, false otherwise.',
    `witness_signature_date` DATE COMMENT 'The date on which the witness signed the genetic testing consent form. Null if witness was not required or not present.',
    CONSTRAINT pk_genetic_testing_consent PRIMARY KEY(`genetic_testing_consent_id`)
) COMMENT 'Specialized master record for informed consent governing genetic testing, genomic sequencing, and biobanking. Captures test type (diagnostic, predictive, carrier, pharmacogenomic, whole genome sequencing), scope of consent (specific test only, future research use, biobank storage, return of incidental findings), family member implications disclosure, insurance discrimination risk disclosure per GINA, data sharing permissions for research registries, and consent for re-contact as new findings emerge. Governed by GINA, state genetic privacy laws, and ACMG guidelines.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` (
    `photography_media_consent_id` BIGINT COMMENT 'Unique identifier for the photography and media consent record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where the photography and media consent was obtained. Links to the facility master record.',
    `clinician_id` BIGINT COMMENT 'Identifier of the healthcare provider or staff member who obtained the photography and media consent from the patient. Links to the provider master record.',
    `form_template_id` BIGINT COMMENT 'Identifier of the consent form template used for this photography and media consent. Links to the consent form template master record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who is the subject of the photography or media consent. Links to the patient master record.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Photography/media consent is a specialized type of consent record. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes (status, dates, ',
    `research_study_id` BIGINT COMMENT 'Identifier of the research study for which the photography and media consent was obtained, if applicable. Links to the research study master record. Null if not research-related.',
    `superseded_photography_media_consent_id` BIGINT COMMENT 'Self-referencing FK on photography_media_consent (superseded_photography_media_consent_id)',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter or visit during which the photography and media consent was obtained. Links to the encounter master record.',
    `capacity_assessment_performed_flag` BOOLEAN COMMENT 'Indicates whether a formal capacity assessment was performed to determine the patients ability to provide informed consent for photography and media use. True if assessment performed; False otherwise.',
    `capacity_assessment_result` STRING COMMENT 'The outcome of the capacity assessment indicating whether the patient has capacity, lacks capacity, has partial capacity, or was not assessed.. Valid values are `has_capacity|lacks_capacity|partial_capacity|not_assessed`',
    `compensation_description` STRING COMMENT 'Description of any compensation, payment, or consideration provided to the patient in exchange for consent to use their images or media.',
    `compensation_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the patient was informed of any compensation, remuneration, or consideration related to the use of their images or media. True if compensation was disclosed; False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this photography and media consent record was first created in the system.',
    `distribution_channels` STRING COMMENT 'Comma-separated list or description of authorized distribution channels where the media may be shared, such as internal presentations, peer-reviewed journals, conferences, websites, social media platforms, or educational materials.',
    `document_reference` STRING COMMENT 'Reference identifier, URL, or file path to the scanned or electronic copy of the signed photography and media consent form stored in the document management system.',
    `form_version` STRING COMMENT 'Version number or identifier of the photography and media consent form used at the time consent was obtained.',
    `identifiable_flag` BOOLEAN COMMENT 'Indicates whether the patient will be identifiable in the media. True if patient identity is visible or disclosed; False if media will be de-identified or anonymized.',
    `intended_use` STRING COMMENT 'The primary intended purpose for which the patient images or media will be used, such as clinical documentation, medical education, research, publication, marketing, social media, quality improvement, or legal proceedings. [ENUM-REF-CANDIDATE: clinical_documentation|medical_education|research|publication|marketing|social_media|quality_improvement|legal_proceedings — 8 candidates stripped; promote to reference product]',
    `interpreter_name` STRING COMMENT 'Full name of the interpreter who assisted with the consent process.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required to facilitate the consent process. True if interpreter was used; False otherwise.',
    `irb_approval_number` STRING COMMENT 'The approval number assigned by the Institutional Review Board for research studies involving photography or media use. Applicable only for research-related consents.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code (optionally with ISO 3166-1 alpha-2 country code) indicating the language in which the consent form was presented to the patient.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this photography and media consent record was last modified or updated in the system.',
    `legal_representative_flag` BOOLEAN COMMENT 'Indicates whether consent was provided by a legal representative or authorized surrogate on behalf of the patient. True if representative signed; False if patient signed directly.',
    `legal_representative_name` STRING COMMENT 'Full name of the legal representative or authorized surrogate who provided consent on behalf of the patient.',
    `legal_representative_relationship` STRING COMMENT 'The relationship of the legal representative to the patient, such as parent, guardian, power of attorney, healthcare proxy, spouse, legal custodian, or other authorized relationship. [ENUM-REF-CANDIDATE: parent|guardian|power_of_attorney|healthcare_proxy|spouse|legal_custodian|other — 7 candidates stripped; promote to reference product]',
    `media_type` STRING COMMENT 'Type of media for which consent is granted, such as photography, video recording, audio recording, digital imaging, or mixed media formats.. Valid values are `photography|video|audio|digital_image|mixed_media`',
    `mrn` STRING COMMENT 'The medical record number assigned to the patient by the healthcare organization. Used for patient identification and record linkage.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the photography and media consent, including special instructions, restrictions, or contextual information.',
    `right_to_withdraw_statement` STRING COMMENT 'Text of the statement provided to the patient explaining their right to withdraw or revoke consent at any time and the process for doing so.',
    `scope_description` STRING COMMENT 'Detailed description of the scope of consent, including what body parts, procedures, or contexts are covered by the photography or media authorization.',
    `signature_date` DATE COMMENT 'The date on which the patient signed the photography and media consent form.',
    `signature_method` STRING COMMENT 'The method by which the patient signature was captured, such as electronic signature, wet signature on paper, verbal consent, biometric signature, or digital certificate.. Valid values are `electronic|wet_signature|verbal|biometric|digital_certificate`',
    `signature_obtained_flag` BOOLEAN COMMENT 'Indicates whether a patient signature was obtained on the photography and media consent form. True if signature was captured; False otherwise.',
    `source_system_code` STRING COMMENT 'Unique identifier of this photography and media consent record in the source system, used for data lineage and reconciliation.',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the patient signing the photography and media consent form.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this photography and media consent based on institutional policy or regulatory requirements. True if witness required; False otherwise.',
    `witness_signature_date` DATE COMMENT 'The date on which the witness signed the photography and media consent form.',
    CONSTRAINT pk_photography_media_consent PRIMARY KEY(`photography_media_consent_id`)
) COMMENT 'Master record for patient consent to photography, video recording, audio recording, and use of patient images or likeness for clinical, educational, marketing, or research purposes. Captures media type, intended use (clinical documentation, medical education, publication, marketing, social media), scope of consent (identifiable vs. de-identified), distribution channels authorized, expiration, and right to withdraw. Required by HIPAA for any use of patient images beyond direct treatment and by institutional policies governing patient privacy.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` (
    `amendment_request_id` BIGINT COMMENT 'Unique identifier for the consent amendment request. Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the healthcare facility where the amendment request was received or processed. Links to the facility master record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who submitted the amendment request. Links to the patient master record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the department responsible for processing the amendment request (e.g., Health Information Management, Privacy Office). Links to the department record.',
    `original_amendment_request_id` BIGINT COMMENT 'Self-referencing FK on amendment_request (original_amendment_request_id)',
    `employee_id` BIGINT COMMENT 'Unique identifier for the staff member or privacy officer who made the final decision on the amendment request. Links to the user or provider record.',
    `consent_record_id` BIGINT COMMENT 'Unique identifier for the consent record that is the subject of this amendment request. Links to the consent record being amended.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical encounter during which the amendment request was submitted, if applicable. Links to the encounter record.',
    `amendment_applied_timestamp` TIMESTAMP COMMENT 'The precise date and time when the amendment was actually applied to the consent record or PHI documentation in the system.',
    `amendment_scope` STRING COMMENT 'The scope of the amendment request: whether it applies to the consent record itself, associated PHI documentation, authorization details, consent restrictions, disclosure log, or all related records.. Valid values are `consent_record|phi_documentation|authorization_details|consent_restrictions|disclosure_log|all`',
    `amendment_type` STRING COMMENT 'The type of amendment being requested: correction of inaccurate information, addition of missing information, clarification, deletion, or general update.. Valid values are `correction|addition|clarification|deletion|update`',
    `audit_trail_reference` STRING COMMENT 'Reference to the detailed audit trail for this amendment request, capturing all review activities, decision points, and system changes. Supports compliance and integrity verification.',
    `compliance_review_date` DATE COMMENT 'The date on which the amendment request and decision were reviewed for HIPAA compliance by the privacy officer or compliance team.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this amendment request record was first created in the data system. Used for audit and data lineage purposes.',
    `decision_date` DATE COMMENT 'The date on which the organization made its decision regarding the amendment request. Must be within 60 days of receipt per HIPAA, or 90 days if extension granted.',
    `decision_rationale` STRING COMMENT 'Detailed explanation of the organizations decision, including the basis for acceptance or denial. For denials, must cite the specific reason per 45 CFR 164.526(a)(2).',
    `decision_timestamp` TIMESTAMP COMMENT 'The precise date and time when the organizations decision was finalized and recorded in the system.',
    `denial_reason_code` STRING COMMENT 'Standardized code representing the reason for denial if the amendment request was denied. Maps to permissible denial reasons under HIPAA (e.g., record not created by organization, record not part of designated record set, record accurate and complete).',
    `denial_reason_description` STRING COMMENT 'Detailed description of the reason for denial, providing context and explanation to the patient. Required for denied amendment requests.',
    `effective_date` DATE COMMENT 'The date on which the accepted amendment becomes effective and is applied to the consent record or associated PHI documentation.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether the organization granted itself a 30-day extension to respond to the amendment request, as permitted under HIPAA when unable to respond within the initial 60-day period.',
    `extension_notification_date` DATE COMMENT 'The date on which the patient was notified of the extension. Must occur within the initial 60-day period.',
    `extension_reason` STRING COMMENT 'The reason provided to the patient for granting an extension to the response timeframe. Required when an extension is granted.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this amendment request record was last modified in the data system. Tracks the most recent change to any field in the record.',
    `mrn` STRING COMMENT 'The patients medical record number as recorded in the healthcare system. Used for patient identification and cross-referencing.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the amendment request, decision process, or implementation. Used for internal documentation and case management.',
    `organization_decision` STRING COMMENT 'The organizations final decision on the amendment request: accepted (amendment will be made), denied (amendment will not be made), or partially accepted (some but not all requested changes will be made).. Valid values are `accepted|denied|partially_accepted`',
    `organization_rebuttal` STRING COMMENT 'The organizations rebuttal to the patients statement of disagreement, if applicable. Must be prepared and maintained with the patients statement.',
    `patient_notification_date` DATE COMMENT 'The date on which the patient was notified of the organizations decision regarding their amendment request. Required within 60 days of receipt per HIPAA.',
    `patient_notification_method` STRING COMMENT 'The method by which the patient was notified of the decision (e.g., mail, email, patient portal, phone call, in-person).. Valid values are `mail|email|portal|phone|in_person`',
    `patient_statement_of_disagreement` STRING COMMENT 'If the amendment request was denied, the patients statement of disagreement with the denial. Patient has the right to submit a statement of disagreement per HIPAA.',
    `reason_for_amendment` STRING COMMENT 'The patients stated reason or justification for requesting the amendment. Required to support the amendment request under HIPAA.',
    `request_channel` STRING COMMENT 'The specific channel or interface through which the amendment request was submitted (e.g., patient portal, mobile app, mail). [ENUM-REF-CANDIDATE: patient_portal|hie|mobile_app|web|phone|mail|fax|in_person|email — 9 candidates stripped; promote to reference product]',
    `request_date` DATE COMMENT 'The date on which the patient submitted the amendment request. Used to track timeliness of organizational response per HIPAA requirements.',
    `request_method` STRING COMMENT 'The method by which the patient submitted the amendment request (e.g., written form, patient portal, email, in-person). [ENUM-REF-CANDIDATE: written|electronic|portal|email|fax|in_person|mail — 7 candidates stripped; promote to reference product]',
    `request_number` STRING COMMENT 'Business-friendly unique identifier for the amendment request, used for tracking and reference in communications with the patient.',
    `request_status` STRING COMMENT 'Current status of the amendment request in the review and decision workflow. Tracks the lifecycle from submission through final disposition. [ENUM-REF-CANDIDATE: submitted|under_review|accepted|denied|partially_accepted|withdrawn|pending_information — 7 candidates stripped; promote to reference product]',
    `request_timestamp` TIMESTAMP COMMENT 'The precise date and time when the amendment request was received by the organization, including time zone information.',
    `requested_change_description` STRING COMMENT 'Detailed description of the specific change the patient is requesting to their consent record or associated PHI documentation. Captures the nature and rationale for the amendment.',
    `source_system_code` STRING COMMENT 'The unique identifier for this amendment request in the source system. Used for cross-system reconciliation and traceability.',
    `supporting_documentation_reference` STRING COMMENT 'Reference to any supporting documentation provided by the patient with the amendment request (e.g., medical records from another provider, test results, correspondence). Points to document storage location.',
    `third_party_notification_date` DATE COMMENT 'The date on which third parties who received the original consent-based disclosure were notified of the amendment to the consent record.',
    `third_party_notification_required_flag` BOOLEAN COMMENT 'Indicates whether notification to third parties who received the original consent-based disclosure is required as part of the amendment process.',
    `third_party_recipients_notified` STRING COMMENT 'List or description of third-party recipients who were notified of the amendment. Supports compliance with requirement to inform persons identified by the patient and those who may have relied on the original information.',
    `withdrawal_date` DATE COMMENT 'The date on which the patient withdrew their amendment request, if applicable. Captures voluntary withdrawal before a decision was made.',
    `withdrawal_reason` STRING COMMENT 'The reason provided by the patient for withdrawing their amendment request, if applicable.',
    CONSTRAINT pk_amendment_request PRIMARY KEY(`amendment_request_id`)
) COMMENT 'Transactional record of patient requests to amend their consent records or associated PHI documentation. Captures amendment request date, specific consent record targeted, nature of requested amendment, organizations decision (accepted, denied with reason), amendment effective date, and notification to third parties who received the original consent-based disclosure. Supports HIPAA right to amend under 45 CFR 164.526 and maintains the integrity of the consent audit trail.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`consent_session` (
    `consent_session_id` BIGINT COMMENT 'Primary key for consent_session',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the consent session took place. Null for remote or electronic sessions not tied to a physical location.',
    `employee_id` BIGINT COMMENT 'Reference to the healthcare staff member who facilitated or witnessed the consent session. Null for fully self-service electronic sessions.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of this consent session.',
    `resumed_consent_session_id` BIGINT COMMENT 'Self-referencing FK on consent_session (resumed_consent_session_id)',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter associated with this consent session. Null if consent was collected outside of an encounter context.',
    `all_consents_obtained_flag` BOOLEAN COMMENT 'Indicates whether all required consents were successfully obtained during this session. True if all required consents collected, False if any required consent was declined or not completed.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to detailed audit trail records for this consent session, including all user actions, timestamps, and system events.',
    `consent_collection_channel` STRING COMMENT 'Interface or location through which the consent session was conducted: patient portal, mobile application, self-service kiosk, clinic, hospital, call center, or mail.',
    `consent_collection_method` STRING COMMENT 'Method by which consent was collected during this session: in-person (face-to-face), electronic (patient portal or kiosk), telephonic (phone call), written (paper form), or verbal (oral consent documented by staff).',
    `consent_count` STRING COMMENT 'Total number of individual consent items collected during this session. A single session may capture multiple consent decisions.',
    `consent_document_url` STRING COMMENT 'Secure URL or document management system reference to the signed consent document(s) associated with this session.',
    `consent_form_version` STRING COMMENT 'Version identifier of the consent form template used during this session. Critical for audit trails and ensuring patients received current consent language.',
    `consent_language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which consent materials were presented and consent was obtained (e.g., ENG for English, SPA for Spanish).',
    `consenting_party_name` STRING COMMENT 'Full name of the individual who provided consent during this session. May differ from patient name if consent was provided by a legal representative.',
    `consenting_party_relationship` STRING COMMENT 'Relationship of the consenting party to the patient: self (patient consenting for themselves), spouse, parent, child, sibling, legal guardian, attorney, or other authorized relationship.',
    `consenting_party_type` STRING COMMENT 'Classification of the individual providing consent: patient (self-consent), legal guardian, power of attorney, parent (for minor), or authorized representative.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consent session record was first created in the system. System audit field.',
    `device_type` STRING COMMENT 'Type of device used to complete the electronic consent session: desktop computer, tablet, mobile phone, kiosk, or other. Null for non-electronic sessions.',
    `electronic_signature_method` STRING COMMENT 'Method used to capture electronic signature during the session: typed name, drawn signature (stylus or touch), biometric (fingerprint/facial), digital certificate, PIN, or none (paper signature).',
    `interpreter_language` STRING COMMENT 'Language for which interpretation services were provided during the consent session. Null if no interpreter was used.',
    `interpreter_name` STRING COMMENT 'Full name of the interpreter who provided language services during the consent session. Null if no interpreter was used.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether language interpretation services were required during the consent session. True if interpreter was used, False otherwise.',
    `ip_address` STRING COMMENT 'IP address from which the electronic consent session was initiated. Used for audit and security purposes. Null for non-electronic sessions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consent session record was last modified. System audit field.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this consent session met all applicable regulatory requirements at the time of collection. True if compliant, False if deficiencies identified.',
    `session_duration_minutes` STRING COMMENT 'Total duration of the consent session in minutes, calculated from start to end timestamp. Used for compliance tracking and session timeout management.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Date and time when the consent session was completed, cancelled, or expired. Null for active sessions.',
    `session_notes` STRING COMMENT 'Free-text notes documenting special circumstances, patient questions, clarifications provided, or other relevant details about the consent session.',
    `session_number` STRING COMMENT 'Human-readable business identifier for the consent session, formatted as CS- followed by 10 digits.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Date and time when the consent session was initiated. Represents the business event time when the patient or authorized representative began the consent process.',
    `session_status` STRING COMMENT 'Current lifecycle status of the consent session: initiated (session started), in_progress (consent being collected), completed (all consents finalized), cancelled (session terminated before completion), expired (session timed out), or withdrawn (patient withdrew from session).',
    `session_timeout_minutes` STRING COMMENT 'Configured timeout period in minutes for this consent session. Session automatically expires if not completed within this timeframe.',
    `session_type` STRING COMMENT 'Classification of the consent session indicating the primary purpose: treatment consent, research consent, data sharing authorization, HIPAA authorization, Health Information Exchange (HIE) participation, or telehealth consent.',
    `source_system_code` STRING COMMENT 'Unique identifier for this consent session in the source system. Used for data lineage and reconciliation.',
    `staff_role` STRING COMMENT 'Role of the staff member who facilitated the consent session: physician, nurse, research coordinator, consent specialist, administrative staff, or other.',
    `user_agent` STRING COMMENT 'Browser or application user agent string captured during electronic consent session. Used for technical audit and troubleshooting. Null for non-electronic sessions.',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the consent process. Required for certain research consents and high-risk procedures. Null if no witness was required or present.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this consent session based on consent type and regulatory requirements. True if witness required, False otherwise.',
    `witness_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the witness signed or acknowledged the consent. Null if no witness was required.',
    CONSTRAINT pk_consent_session PRIMARY KEY(`consent_session_id`)
) COMMENT 'Master reference table for consent_session. Referenced by session_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique identifier for the consent record. Primary key for the consent record entity.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Consent records must comply with organizational policies governing consent practices. Healthcare organizations track which policy version governs each consent instance for regulatory compliance, audit',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_policy. Business justification: Every consent record is governed by a specific consent policy that defines requirements, retention, revocation rules, etc. This is a fundamental relationship - the core consent record must link to the',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who performed the capacity assessment, if applicable.',
    `consent_record_clinician_id` BIGINT COMMENT 'Reference to the provider or clinician who obtained or witnessed the consent.',
    `employee_id` BIGINT COMMENT 'The unique identifier or credential number of the interpreter who assisted, if applicable.',
    `form_template_id` BIGINT COMMENT 'Reference to the standardized consent form template or version used for this consent instance.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Treatment and procedure consents require payer prior authorization verification and billing coordination. Consent validity often depends on active coverage. Links consent to specific insurance plan fo',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Consent records transmitted via HIE or EHR interfaces need tracking of which channel carried the consent directive. Required for audit trails showing how consent information was exchanged with trading',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who provided or is the subject of this consent. Links to the Master Patient Index (MPI).',
    `research_study_id` BIGINT COMMENT 'The unique identifier of the research study or clinical trial for which this consent was obtained, if applicable.',
    `superseded_record_id` BIGINT COMMENT 'Self-referencing FK on record (superseded_record_id)',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this consent was obtained, if applicable.',
    `authorized_representative_flag` BOOLEAN COMMENT 'Indicates whether the consent was signed by an authorized representative (legal guardian, power of attorney, healthcare proxy) rather than the patient directly.',
    `authorized_representative_name` STRING COMMENT 'The full name of the authorized representative who signed on behalf of the patient, if applicable.',
    `authorized_representative_relationship` STRING COMMENT 'The relationship of the authorized representative to the patient: parent, legal guardian, power of attorney, healthcare proxy, spouse, next of kin, or other. [ENUM-REF-CANDIDATE: parent|legal_guardian|power_of_attorney|healthcare_proxy|spouse|next_of_kin|other — 7 candidates stripped; promote to reference product]',
    `capacity_assessment_performed_flag` BOOLEAN COMMENT 'Indicates whether a formal assessment of the patients decision-making capacity was performed prior to obtaining consent.',
    `capacity_assessment_result` STRING COMMENT 'The outcome of the capacity assessment: patient has capacity, lacks capacity, has partial capacity, or assessment was not performed.. Valid values are `has_capacity|lacks_capacity|partial_capacity|not_assessed`',
    `consent_decision` STRING COMMENT 'The patients decision regarding the consent: permit (consent granted), deny (consent refused), opt-in (patient agrees to participate), or opt-out (patient declines participation).. Valid values are `permit|deny|opt_in|opt_out`',
    `consent_document_reference` STRING COMMENT 'Reference identifier or URI to the scanned or electronically stored consent document in the document management system or Electronic Health Record (EHR).',
    `consent_effective_end_date` DATE COMMENT 'The date on which this consent expires or is no longer valid. Null indicates open-ended consent.',
    `consent_effective_start_date` DATE COMMENT 'The date from which this consent becomes effective and enforceable.',
    `consent_expiration_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an expiration notification was sent to the patient or care team prior to consent expiration.',
    `consent_form_version` STRING COMMENT 'The version number or identifier of the consent form template used at the time of consent capture. Critical for regulatory compliance and audit trails.',
    `consent_language` STRING COMMENT 'The language in which the consent form was presented and explained to the patient (ISO 639-1 two-letter code or full language name).',
    `consent_method` STRING COMMENT 'The method by which consent was obtained: written (paper signature), verbal (documented oral consent), electronic (digital signature via patient portal or kiosk), or implied (emergency treatment).. Valid values are `written|verbal|electronic|implied`',
    `consent_notes` STRING COMMENT 'Free-text clinical or administrative notes related to the consent process, including any special circumstances, patient questions, or clarifications provided.',
    `consent_obtained_datetime` TIMESTAMP COMMENT 'The date and time when the consent was obtained from the patient or authorized representative. This is the principal business event timestamp for the consent record.',
    `consent_purpose` STRING COMMENT 'Free-text description of the specific purpose or procedure for which this consent was obtained (e.g., Total Knee Replacement Surgery, Participation in Clinical Trial XYZ, Release of Records to Insurance Provider).',
    `consent_renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this consent requires periodic renewal per institutional policy or regulatory requirements.',
    `consent_restrictions` STRING COMMENT 'Free-text description of any restrictions, limitations, or special conditions the patient placed on the consent (e.g., Do not share mental health records, Limit disclosure to dates of service only).',
    `consent_revocation_datetime` TIMESTAMP COMMENT 'The date and time when the patient revoked or withdrew this consent, if applicable.',
    `consent_revocation_reason` STRING COMMENT 'Free-text explanation or reason provided by the patient for revoking the consent.',
    `consent_scope` STRING COMMENT 'The scope or domain to which this consent applies: patient privacy (HIPAA), research participation, treatment decisions, or advanced directive registry (ADR).. Valid values are `patient_privacy|research|treatment|adr`',
    `consent_source_system` STRING COMMENT 'The name or identifier of the source system from which this consent record originated (e.g., Epic, Cerner, patient portal, research management system).',
    `consent_source_system_code` STRING COMMENT 'The unique identifier for this consent record in the source system, used for data lineage and reconciliation.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent: draft (being prepared), proposed (awaiting signature), active (in effect), rejected (patient declined), inactive (no longer applicable), revoked (patient withdrew), or expired (past validity period). [ENUM-REF-CANDIDATE: draft|proposed|active|rejected|inactive|revoked|expired — 7 candidates stripped; promote to reference product]',
    `consent_type` STRING COMMENT 'The category or type of consent being captured: treatment consent, surgical consent, research consent, HIPAA authorization, data sharing agreement, Health Information Exchange (HIE) opt-in/opt-out, telehealth consent, photography consent, or release of information. [ENUM-REF-CANDIDATE: treatment|surgical_procedure|anesthesia|research|hipaa_authorization|data_sharing|hie_opt_in|hie_opt_out|telehealth|photography|release_of_information — 11 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was first created in the system. Used for audit trail and data lineage.',
    `hipaa_authorization_flag` BOOLEAN COMMENT 'Indicates whether this consent record includes a formal HIPAA authorization for use and disclosure of Protected Health Information (PHI).',
    `interpreter_name` STRING COMMENT 'The name of the interpreter who assisted in the consent process, if applicable.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter was required and used during the consent process due to language barriers.',
    `irb_approval_number` STRING COMMENT 'The IRB approval number associated with the research study consent, if applicable.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was last modified in the system. Used for audit trail and change tracking.',
    `mrn` STRING COMMENT 'The patients Medical Record Number at the time consent was obtained. Used for cross-referencing and audit purposes.',
    `patient_signature_datetime` TIMESTAMP COMMENT 'The date and time when the patient (or authorized representative) signed the consent form.',
    `research_consent_flag` BOOLEAN COMMENT 'Indicates whether this consent is specifically for participation in a research study or clinical trial.',
    `witness_name` STRING COMMENT 'The name of the individual who witnessed the consent signing, if applicable.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness was required for this consent per institutional policy or regulatory requirements.',
    `witness_signature_datetime` TIMESTAMP COMMENT 'The date and time when the witness signed the consent form.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Core master record for every patient consent captured across the enterprise. SSOT for all consent instances including treatment consent, surgical consent, research consent, HIPAA authorizations, data sharing agreements, HIE opt-in/opt-out, and telehealth consent. Captures consent type, status, version of consent form used, method of consent (written, verbal, electronic), witness information, interpreter involvement, capacity assessment, and revocation details. Links to patient MPI, encounter, provider, and consent form template.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`consent_event` (
    `consent_event_id` BIGINT COMMENT 'Unique identifier for the consent event record. Primary key for the consent event transaction.',
    `care_site_id` BIGINT COMMENT 'Reference to the physical or virtual location where the consent event occurred (facility, clinic, department, or telehealth session).',
    `employee_id` BIGINT COMMENT 'Reference to the user (staff, clinician, or patient) who performed or initiated the consent event action.',
    `consent_event_interpreter_user_employee_id` BIGINT COMMENT 'Reference to the interpreter who assisted during the consent event, if applicable.',
    `consent_record_id` BIGINT COMMENT 'Reference to the parent consent record for which this event occurred. Links to the master consent entity.',
    `consent_event_witness_user_employee_id` BIGINT COMMENT 'Reference to the user who witnessed the consent event, if applicable. Required for certain consent types per organizational policy and regulatory requirements.',
    `consent_previous_event_id` BIGINT COMMENT 'Reference to the immediately preceding consent event in the lifecycle chain. Used to construct the complete audit trail and event sequence.',
    `consent_prior_event_id` BIGINT COMMENT 'Self-referencing FK on event (prior_event_id)',
    `consent_session_id` BIGINT COMMENT 'Unique identifier for the user session during which the consent event was captured. Used for audit trail correlation.',
    `delegation_id` BIGINT COMMENT 'Reference to the legal representative or guardian who executed the consent on behalf of the patient, if applicable.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.form_template. Business justification: Consent events are tied to specific form templates and versions. The event table currently has form_version (STRING) but no FK to form_template. Adding this FK enables proper tracking of which form te',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of the consent. Links to the master patient index (MPI).',
    `primary_event_superseded_consent_consent_record_id` BIGINT COMMENT 'Reference to a previous consent record that was superseded or replaced by this event, if applicable. Used for consent version tracking.',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Consent events (obtain, revoke, amend) often trigger ADT^A31 updates or consent directive messages to HIE/trading partners. Regulatory audit requirement to trace which interoperability message was gen',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the consent event occurred, if applicable. Links consent events to the broader episode of care.',
    `audit_trail_reference` STRING COMMENT 'Reference or URI to the detailed audit log entry or provenance record for this consent event in the audit system.',
    `channel` STRING COMMENT 'The channel or interface through which the consent event was captured or executed.. Valid values are `in_person|patient_portal|kiosk|telehealth|paper|phone`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent event record was first created in the data system. System audit timestamp distinct from business event time.',
    `device_identifier` STRING COMMENT 'Identifier of the device (tablet, kiosk, workstation) used to capture the consent event. Used for audit and security tracking.',
    `document_reference_code` BIGINT COMMENT 'Reference to the scanned or electronic consent document associated with this event, if applicable. Links to document management system.',
    `event_date` DATE COMMENT 'The calendar date when the consent event occurred. Used for day-level reporting and analytics.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consent event occurred in the real world. This is the business event time, distinct from audit timestamps.',
    `event_type` STRING COMMENT 'The type of consent lifecycle event that occurred. Captures the specific action or state transition in the consent workflow. [ENUM-REF-CANDIDATE: presented|signed|witnessed|revoked|expired|renewed|amended|declined|deferred|superseded|verified — promote to reference product]. Valid values are `presented|signed|witnessed|revoked|expired|renewed`',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether an interpreter was required or used during the consent event to ensure patient understanding.',
    `ip_address` STRING COMMENT 'The IP address from which the consent event was initiated, if captured electronically. Used for audit trail and fraud detection.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the consent was presented and captured.. Valid values are `^[a-z]{2}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent event record was last modified in the data system. Used for change tracking and audit.',
    `legal_representative_flag` BOOLEAN COMMENT 'Indicates whether the consent event was executed by a legal representative or guardian on behalf of the patient.',
    `notes` STRING COMMENT 'Free-text notes or comments associated with the consent event. May include context, clarifications, or special circumstances documented by the performing user.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an automated notification (email, SMS, portal message) was sent to the patient or relevant parties following this consent event.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when the notification was sent following the consent event, if applicable.',
    `performing_user_role` STRING COMMENT 'The role or capacity in which the performing user acted during the consent event. [ENUM-REF-CANDIDATE: patient|nurse|physician|registration_clerk|research_coordinator|legal_representative|guardian|witness|administrator|compliance_officer — promote to reference product]. Valid values are `patient|nurse|physician|registration_clerk|research_coordinator|legal_representative`',
    `reason_code` STRING COMMENT 'Coded reason for the consent event, particularly for revocations, amendments, or declines. May reference standard code systems.',
    `reason_description` STRING COMMENT 'Free-text description of the reason for the consent event, providing additional context beyond the coded reason.',
    `signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a signature was successfully captured during this consent event.',
    `signature_image_reference` STRING COMMENT 'Reference or URI to the stored signature image or digital signature artifact, if captured. Used for audit and legal verification.',
    `signature_method` STRING COMMENT 'The method by which the consent was signed or acknowledged during this event.. Valid values are `electronic|wet_signature|verbal|biometric|digital_certificate|proxy`',
    `source_system_event_code` STRING COMMENT 'The unique identifier for this consent event in the source operational system. Used for data lineage and reconciliation.',
    `verification_method` STRING COMMENT 'Method used to verify the identity of the person executing the consent event.. Valid values are `photo_id|two_factor_authentication|biometric|knowledge_based|in_person|none`',
    `verification_status` STRING COMMENT 'Status of identity verification or consent verification performed during this event. Critical for fraud prevention and compliance.. Valid values are `verified|unverified|pending_verification|verification_failed`',
    CONSTRAINT pk_consent_event PRIMARY KEY(`consent_event_id`)
) COMMENT 'Transactional record of every consent-related action or lifecycle event for a consent record. Captures event type (presented, signed, witnessed, revoked, expired, renewed, amended, declined, deferred), event timestamp, performing user, channel (in-person, patient portal, kiosk, telehealth, paper), location, and any associated notes. Provides a complete immutable audit trail of all consent lifecycle transitions required for HIPAA compliance and legal defensibility.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` (
    `consent_exception_id` BIGINT COMMENT 'Unique identifier for the consent exception record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the consent exception was invoked.',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider who invoked the consent exception and authorized the use or disclosure of PHI.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_policy. Business justification: Consent exceptions are granted based on specific consent policies that define when exceptions are permissible. Linking exception to consent_policy enables tracking which policy framework governed each',
    `employee_id` BIGINT COMMENT 'System user identifier of the individual who documented the consent exception in the system.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose Protected Health Information (PHI) was used or disclosed without explicit consent under a legal exception.',
    `parent_exception_id` BIGINT COMMENT 'Self-referencing FK on exception (related_exception_id)',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Consent exceptions document instances where care was provided without explicit consent. While many exceptions occur when NO consent exists, some exceptions may relate to a specific consent record (e.g',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the consent exception was invoked, if applicable.',
    `accounting_of_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this exception must be included in the patients Accounting of Disclosures report per HIPAA requirements.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the consent exception record is currently active and valid in the system.',
    `clinical_justification` STRING COMMENT 'Clinical rationale and circumstances that necessitated invoking the consent exception, including patient condition, urgency, and why obtaining consent was not feasible.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the consent exception record was first created in the system.',
    `department_code` STRING COMMENT 'Code identifying the clinical department or unit where the consent exception was invoked (e.g., ED for Emergency Department, ICU for Intensive Care Unit).. Valid values are `^[A-Z0-9]{2,10}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the patient has disputed the appropriateness or legality of the consent exception after being notified.',
    `dispute_notes` STRING COMMENT 'Details of the patients dispute regarding the consent exception, including their concerns and the organizations response.',
    `documented_timestamp` TIMESTAMP COMMENT 'Date and time when the consent exception was formally documented in the system.',
    `effective_date` DATE COMMENT 'Date on which the consent exception became effective and PHI use or disclosure was authorized.',
    `emergency_treatment_flag` BOOLEAN COMMENT 'Indicates whether the exception was invoked in the context of emergency medical treatment where delay to obtain consent would jeopardize patient health or safety.',
    `exception_number` STRING COMMENT 'Business identifier for the consent exception record, used for tracking and audit purposes across systems.. Valid values are `^CE-[0-9]{8,12}$`',
    `exception_status` STRING COMMENT 'Current lifecycle status of the consent exception record, tracking from invocation through documentation and patient notification.. Valid values are `invoked|documented|patient_notified|under_review|closed|disputed`',
    `exception_type` STRING COMMENT 'Category of legal exception under which PHI was used or disclosed without patient consent. Aligns with HIPAA Privacy Rule permitted uses and disclosures. [ENUM-REF-CANDIDATE: emergency_treatment|public_health_reporting|law_enforcement|judicial_order|patient_incapacity|imminent_danger|abuse_neglect_reporting|workers_compensation|coroner_medical_examiner|organ_donation|research_waiver|facility_directory — 12 candidates stripped; promote to reference product]',
    `expiration_date` DATE COMMENT 'Date on which the consent exception expires or is no longer applicable, if applicable. Null for one-time disclosures.',
    `imminent_danger_flag` BOOLEAN COMMENT 'Indicates whether the disclosure was made to prevent or lessen a serious and imminent threat to the health or safety of a person or the public.',
    `invoked_timestamp` TIMESTAMP COMMENT 'Date and time when the consent exception was invoked and the provider authorized the use or disclosure of PHI without explicit patient consent.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the consent exception record was most recently updated in the system.',
    `legal_basis_code` STRING COMMENT 'Specific legal citation or regulatory code that authorizes the use or disclosure of PHI without patient consent (e.g., 45 CFR 164.512(j) for law enforcement, state-specific statutes).. Valid values are `^(45CFR164.512([a-l])|STATE-[A-Z]{2}-[0-9]{3,6}|TJC-[A-Z]{2,4}-[0-9]{2,4})$`',
    `legal_basis_description` STRING COMMENT 'Detailed explanation of the legal or regulatory basis that permits the use or disclosure of PHI without patient consent in this specific circumstance.',
    `patient_incapacity_flag` BOOLEAN COMMENT 'Indicates whether the patient was incapacitated or unable to provide consent at the time the exception was invoked (e.g., unconscious, mentally incompetent).',
    `patient_notification_date` DATE COMMENT 'Date on which the patient was notified of the PHI use or disclosure under the consent exception.',
    `patient_notification_method` STRING COMMENT 'Method by which the patient was notified of the PHI use or disclosure (e.g., written letter, secure patient portal message, in-person conversation).. Valid values are `written_letter|secure_email|patient_portal|in_person|phone_call|certified_mail`',
    `patient_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the patient must be notified after the fact that their PHI was used or disclosed under an exception, per HIPAA and organizational policy.',
    `patient_notified_flag` BOOLEAN COMMENT 'Indicates whether the patient has been notified that their PHI was used or disclosed under a consent exception.',
    `phi_disclosed_description` STRING COMMENT 'Description of the specific Protected Health Information that was used or disclosed under the exception, including type and scope of information.',
    `privacy_officer_notes` STRING COMMENT 'Confidential notes and observations recorded by the Privacy Officer during review of the consent exception.',
    `privacy_officer_review_date` DATE COMMENT 'Date on which the Privacy Officer reviewed the consent exception for compliance and appropriateness.',
    `recipient_contact_name` STRING COMMENT 'Name of the individual at the recipient organization who received the PHI disclosure.',
    `recipient_contact_phone` STRING COMMENT 'Phone number of the recipient contact for follow-up and audit trail purposes.. Valid values are `^+?[1-9]d{1,14}$`',
    `recipient_organization` STRING COMMENT 'Name of the external organization or entity to which PHI was disclosed under the exception (e.g., public health authority, law enforcement agency, court).',
    `reviewed_by_privacy_officer_flag` BOOLEAN COMMENT 'Indicates whether the consent exception has been reviewed and approved by the organizational Privacy Officer or designee.',
    `source_system_code` STRING COMMENT 'Unique identifier of the consent exception record in the source operational system, used for data lineage and reconciliation.',
    `surrogate_unavailable_flag` BOOLEAN COMMENT 'Indicates whether a legally authorized surrogate decision-maker was unavailable to provide consent on behalf of an incapacitated patient.',
    CONSTRAINT pk_consent_exception PRIMARY KEY(`consent_exception_id`)
) COMMENT 'Transactional record of instances where care was provided or PHI was used/disclosed without explicit patient consent under a recognized legal exception. Captures exception type (emergency treatment, public health reporting, law enforcement, judicial order, incapacity with no surrogate available, imminent danger), clinical or legal basis cited, provider who invoked the exception, notification to patient after the fact (if required), and documentation of the circumstances. Required for HIPAA compliance and Joint Commission documentation standards.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` (
    `consent_translation_id` BIGINT COMMENT 'Unique identifier for the consent translation record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or staff member who provided interpreter services, if applicable.',
    `consent_translation_quality_reviewer_employee_id` BIGINT COMMENT 'Reference to the user who performed the quality review of the translation.',
    `form_template_id` BIGINT COMMENT 'Reference to the consent form template that was translated.',
    `vendor_id` BIGINT COMMENT 'Unique identifier assigned by the interpreter vendor for tracking and billing purposes.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received translation services during the consent process.',
    `consent_record_id` BIGINT COMMENT 'Reference to the parent consent record for which translation services were provided.',
    `superseded_translation_id` BIGINT COMMENT 'Self-referencing FK on translation (superseded_translation_id)',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the consent translation occurred.',
    `auxiliary_aid_description` STRING COMMENT 'Description of any auxiliary aids or services provided to facilitate communication during the consent process.',
    `auxiliary_aid_provided_flag` BOOLEAN COMMENT 'Indicates whether auxiliary aids or services were provided in addition to language translation (e.g., sign language interpreter, assistive listening devices) (True/False).',
    `communication_barrier_type` STRING COMMENT 'Type of communication barrier that necessitated translation services (e.g., limited English proficiency, hearing impairment, speech impairment, visual impairment, cognitive impairment, multiple barriers).. Valid values are `limited_english_proficiency|hearing_impairment|speech_impairment|visual_impairment|cognitive_impairment|multiple_barriers`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost incurred for the translation or interpretation services, used for financial tracking and vendor billing.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the translation cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consent translation record was first created in the system.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the interpretation session in minutes, used for billing and quality tracking.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the translation or interpretation session ended.',
    `interpreter_attestation_flag` BOOLEAN COMMENT 'Indicates whether the interpreter attested that they accurately conveyed the consent information in the target language (True/False).',
    `interpreter_attestation_timestamp` TIMESTAMP COMMENT 'Date and time when the interpreter provided their attestation of accurate translation.',
    `interpreter_certification_number` STRING COMMENT 'Certification or credential number of the interpreter, if applicable (e.g., Certified Medical Interpreter credential number).',
    `interpreter_name` STRING COMMENT 'Full name of the interpreter who provided translation services.',
    `interpreter_session_code` STRING COMMENT 'Unique session identifier provided by the interpreter service vendor for this specific interpretation session.',
    `interpreter_type` STRING COMMENT 'Classification of the interpreter used (e.g., certified medical interpreter, qualified interpreter, ad hoc bilingual staff, family member, not applicable for written translation only).. Valid values are `certified_medical_interpreter|qualified_interpreter|ad_hoc_bilingual_staff|family_member|not_applicable`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this consent translation record was last modified.',
    `lep_compliance_flag` BOOLEAN COMMENT 'Indicates whether this translation record meets CMS Limited English Proficiency compliance requirements (True/False).',
    `notes` STRING COMMENT 'Free-text notes documenting any special circumstances, challenges, or observations during the translation process.',
    `patient_preferred_language_code` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code representing the patients stated preferred language for healthcare communication.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `patient_preferred_language_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the patients preferred language was explicitly confirmed at the time of consent (True/False).',
    `patient_understanding_attestation_flag` BOOLEAN COMMENT 'Indicates whether the patient attested that they understood the consent information in their preferred language (True/False). Required by CMS LEP requirements.',
    `patient_understanding_attestation_method` STRING COMMENT 'Method by which the patient confirmed understanding of the translated consent (e.g., verbal confirmation, written signature, electronic signature, witnessed verbal, teach-back method).. Valid values are `verbal_confirmation|written_signature|electronic_signature|witnessed_verbal|teach_back_method`',
    `quality_review_flag` BOOLEAN COMMENT 'Indicates whether the translation underwent a quality review process (True/False).',
    `quality_review_timestamp` TIMESTAMP COMMENT 'Date and time when the translation quality review was completed.',
    `source_system_translation_code` STRING COMMENT 'Unique identifier for this translation record in the source system.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the translation or interpretation session began.',
    `target_language_code` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code representing the language into which the consent form was translated (e.g., es for Spanish, zh-CN for Simplified Chinese).. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `target_language_name` STRING COMMENT 'Full name of the target language (e.g., Spanish, Mandarin Chinese, Vietnamese).',
    `title_vi_compliance_flag` BOOLEAN COMMENT 'Indicates whether this translation record meets Title VI of the Civil Rights Act compliance requirements for language access (True/False).',
    `translated_document_reference` STRING COMMENT 'Reference identifier or URI to the translated consent document stored in the document management system.',
    `translated_document_version` STRING COMMENT 'Version number or identifier of the translated consent document used.',
    `translation_method` STRING COMMENT 'Method used to provide translation services during the consent process (e.g., certified written translation, qualified in-person interpreter, telephonic interpreter, video remote interpreting, bilingual staff, family member interpreter).. Valid values are `certified_written_translation|qualified_in_person_interpreter|telephonic_interpreter|video_remote_interpreting|bilingual_staff|family_member_interpreter`',
    CONSTRAINT pk_consent_translation PRIMARY KEY(`consent_translation_id`)
) COMMENT 'Master record tracking consent form translations and interpreter services used during the consent process for patients with limited English proficiency (LEP) or communication barriers. Captures target language, translation method (certified written translation, qualified interpreter, telephonic interpreter, video remote interpreting), interpreter identity or service vendor, patients preferred language confirmation, and attestation that the patient understood the consent in their preferred language. Required by Title VI of the Civil Rights Act and CMS LEP requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` (
    `consent_verification_id` BIGINT COMMENT 'Unique identifier for the consent verification event. Primary key for the consent verification record.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the consent verification occurred. Links to the facility master record.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_policy. Business justification: Consent verifications check compliance with specific consent policies. Linking verification to consent_policy enables tracking which policy requirements were verified in each verification event, suppo',
    `employee_id` BIGINT COMMENT 'Reference to the system user (clinician, staff member, or automated process) who initiated or performed the consent verification check.',
    `fhir_resource_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_resource_log. Business justification: Real-time consent verification via FHIR Consent resource queries (GET /Consent?patient=X) is standard for CDS Hooks and SMART on FHIR apps. Tracking which FHIR operation verified consent is required f',
    `monitoring_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_activity. Business justification: Consent verification processes are monitored as part of compliance monitoring programs to ensure systematic verification occurs. Links individual verification events to monitoring activities for sampl',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose consent was verified. Links to the patient master record.',
    `prior_verification_id` BIGINT COMMENT 'Self-referencing FK on verification (prior_verification_id)',
    `consent_record_id` BIGINT COMMENT 'Reference to the underlying consent record being verified. Links to the consent master record that was checked during this verification event.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the consent verification occurred. Null if verification was performed outside of an active encounter context.',
    `action_taken` STRING COMMENT 'Action taken by the verifying user or system following the verification result. Indicates whether the workflow proceeded, new consent was obtained, the issue was escalated to supervisor, access was blocked, or the action was deferred pending resolution.. Valid values are `proceeded|obtained_new_consent|escalated|blocked|deferred`',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this consent verification event to the broader system audit trail or access log. Used for HIPAA compliance reporting and security audits.',
    `clinical_context` STRING COMMENT 'Description of the clinical or operational context that triggered the consent verification check. Free-text field capturing the reason for verification (e.g., pre-surgical clearance, lab order entry, medical records release request, HIE query for ED visit).',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the consent verification event met all regulatory and organizational compliance requirements. True indicates full compliance; False indicates a compliance gap requiring review.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting any compliance considerations, exceptions, or special circumstances related to this consent verification event. Used for regulatory audit support and quality assurance review.',
    `consent_effective_date` DATE COMMENT 'Effective start date of the consent record that was verified. Captured at verification time for audit and historical analysis. Format: yyyy-MM-dd.',
    `consent_expiration_date` DATE COMMENT 'Expiration date of the consent record that was verified. Captured at verification time to support expiration detection and renewal workflows. Null if consent has no expiration. Format: yyyy-MM-dd.',
    `consent_scope` STRING COMMENT 'Specific scope or purpose of the consent being verified. Free-text description of what the consent covers (e.g., surgical procedure, clinical trial XYZ, release to insurance, HIE query).',
    `consent_type` STRING COMMENT 'Category of consent being verified. Indicates the specific consent domain checked during this verification event (treatment consent, research participation, data sharing authorization, HIPAA authorization, Health Information Exchange participation, or telehealth consent).. Valid values are `treatment|research|data_sharing|hipaa_authorization|hie_participation|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consent verification record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for data lineage and audit purposes.',
    `days_until_expiration` STRING COMMENT 'Number of days remaining until the consent expires, calculated at the time of verification. Negative values indicate expired consent. Null if consent has no expiration date. Used for proactive renewal alerts.',
    `department_code` STRING COMMENT 'Code identifying the clinical department or service area where the consent verification was performed. Used for operational reporting and workflow analysis.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Time elapsed in seconds to complete the consent verification check, from initiation to result return. Used for performance monitoring and system optimization.',
    `error_code` STRING COMMENT 'System error code if the consent verification process encountered a technical failure. Null if verification completed successfully. Used for troubleshooting and system reliability monitoring.',
    `error_message` STRING COMMENT 'Human-readable error message describing any technical failure encountered during consent verification. Null if verification completed successfully.',
    `integration_transaction_code` STRING COMMENT 'Unique transaction identifier from the source system or integration layer that initiated the consent verification. Used for end-to-end traceability across system boundaries and troubleshooting integration issues.',
    `notification_method` STRING COMMENT 'Method by which the patient or responsible party was notified following consent verification. Applicable when notification_sent_flag is True.. Valid values are `email|sms|patient_portal|mail|phone|in_person`',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether a notification was sent to the patient or responsible party following the consent verification. True indicates notification was sent; False indicates no notification was required or sent.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the notification was sent to the patient or responsible party. Null if no notification was sent. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `override_authorized_by` BIGINT COMMENT 'Reference to the supervisor or authorized user who approved the consent verification override. Required when override_flag is True. Links to the user master record.',
    `override_flag` BOOLEAN COMMENT 'Boolean indicator of whether the verification result was overridden by authorized personnel. True indicates an override occurred (e.g., emergency access, break-the-glass scenario); False indicates normal verification workflow.',
    `override_reason` STRING COMMENT 'Free-text justification for overriding the consent verification result. Required when override_flag is True. Captures the business or clinical reason for proceeding despite verification failure (e.g., emergency treatment, life-threatening situation, patient verbal authorization pending documentation).',
    `restriction_details` STRING COMMENT 'Free-text description of any restrictions or limitations on the consent. Captures specific constraints such as data categories excluded, time-bound limitations, or recipient restrictions. Null if no restrictions apply.',
    `restriction_flag` BOOLEAN COMMENT 'Boolean indicator of whether the verified consent has scope restrictions or limitations that constrain its use. True indicates restrictions are present; False indicates unrestricted consent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this consent verification record was last modified in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and audit purposes.',
    `verification_method` STRING COMMENT 'Method by which the consent verification was performed. Indicates whether the check was automated by system rules, manually performed by staff, executed via real-time query to consent registry, or part of a batch validation process.. Valid values are `automated|manual|real_time_query|batch_check`',
    `verification_result` STRING COMMENT 'Outcome of the consent verification check. Indicates whether the consent was found to be valid and active, expired, revoked by patient, missing entirely, restricted by scope limitations, or pending completion.. Valid values are `valid|expired|revoked|missing|restricted|pending`',
    `verification_source` STRING COMMENT 'System or source from which the consent status was retrieved during verification. Indicates the authoritative source consulted (Electronic Medical Record, consent management registry, Health Information Exchange, patient portal, paper records, or external system).. Valid values are `emr|consent_registry|hie|patient_portal|paper_record|external_system`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the consent verification check was performed. Recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Critical for audit trail and compliance reporting.',
    `verifying_user_npi` STRING COMMENT 'National Provider Identifier (NPI) of the healthcare provider who performed the consent verification, if applicable. Ten-digit unique identifier assigned by CMS.. Valid values are `^[0-9]{10}$`',
    CONSTRAINT pk_consent_verification PRIMARY KEY(`consent_verification_id`)
) COMMENT 'Transactional record of consent verification checks performed at the point of care or prior to data disclosure. Captures verification timestamp, verifying user, consent type checked, verification result (valid, expired, revoked, missing, restricted), action taken (proceeded, obtained new consent, escalated), and the clinical or operational context triggering the check. Supports real-time consent enforcement workflows integrated with EHR, HIE, and release of information systems.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_primary_superseded_by_form_template_id` FOREIGN KEY (`primary_superseded_by_form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_superseded_hipaa_authorization_id` FOREIGN KEY (`superseded_hipaa_authorization_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hipaa_authorization`(`hipaa_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_superseded_hie_directive_id` FOREIGN KEY (`superseded_hie_directive_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hie_directive`(`hie_directive_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_superseded_treatment_consent_id` FOREIGN KEY (`superseded_treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_superseded_research_consent_id` FOREIGN KEY (`superseded_research_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`research_consent`(`research_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_superseded_telehealth_consent_id` FOREIGN KEY (`superseded_telehealth_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`telehealth_consent`(`telehealth_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_delegation_id` FOREIGN KEY (`delegation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`delegation`(`delegation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_superseded_minor_consent_id` FOREIGN KEY (`superseded_minor_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`minor_consent`(`minor_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_superseded_delegation_id` FOREIGN KEY (`superseded_delegation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`delegation`(`delegation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_delegation_id` FOREIGN KEY (`delegation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`delegation`(`delegation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_prior_revocation_id` FOREIGN KEY (`prior_revocation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`revocation`(`revocation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_prior_npp_acknowledgment_id` FOREIGN KEY (`prior_npp_acknowledgment_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`npp_acknowledgment`(`npp_acknowledgment_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_superseded_restriction_request_id` FOREIGN KEY (`superseded_restriction_request_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`restriction_request`(`restriction_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_hipaa_authorization_id` FOREIGN KEY (`hipaa_authorization_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hipaa_authorization`(`hipaa_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_related_prior_disclosure_log_id` FOREIGN KEY (`related_prior_disclosure_log_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`disclosure_log`(`disclosure_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_delegation_id` FOREIGN KEY (`delegation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`delegation`(`delegation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_prior_capacity_assessment_id` FOREIGN KEY (`prior_capacity_assessment_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_primary_superseded_by_consent_policy_id` FOREIGN KEY (`primary_superseded_by_consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ADD CONSTRAINT `fk_consent_workflow_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ADD CONSTRAINT `fk_consent_workflow_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ADD CONSTRAINT `fk_consent_workflow_parent_workflow_id` FOREIGN KEY (`parent_workflow_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`workflow`(`workflow_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ADD CONSTRAINT `fk_consent_workflow_primary_superseded_by_consent_workflow_id` FOREIGN KEY (`primary_superseded_by_consent_workflow_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`workflow`(`workflow_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ADD CONSTRAINT `fk_consent_workflow_superseded_by_consent_workflow_id` FOREIGN KEY (`superseded_by_consent_workflow_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`workflow`(`workflow_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_related_prior_deficiency_id` FOREIGN KEY (`related_prior_deficiency_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`deficiency`(`deficiency_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`workflow`(`workflow_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_superseded_substance_use_consent_id` FOREIGN KEY (`superseded_substance_use_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`substance_use_consent`(`substance_use_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_superseded_behavioral_health_consent_id` FOREIGN KEY (`superseded_behavioral_health_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`behavioral_health_consent`(`behavioral_health_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_prior_expiration_alert_id` FOREIGN KEY (`prior_expiration_alert_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`expiration_alert`(`expiration_alert_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`workflow`(`workflow_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_superseded_genetic_testing_consent_id` FOREIGN KEY (`superseded_genetic_testing_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`genetic_testing_consent`(`genetic_testing_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_superseded_photography_media_consent_id` FOREIGN KEY (`superseded_photography_media_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`photography_media_consent`(`photography_media_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_original_amendment_request_id` FOREIGN KEY (`original_amendment_request_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`amendment_request`(`amendment_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_resumed_consent_session_id` FOREIGN KEY (`resumed_consent_session_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_session`(`consent_session_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ADD CONSTRAINT `fk_consent_consent_record_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ADD CONSTRAINT `fk_consent_consent_record_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ADD CONSTRAINT `fk_consent_consent_record_superseded_record_id` FOREIGN KEY (`superseded_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ADD CONSTRAINT `fk_consent_consent_event_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ADD CONSTRAINT `fk_consent_consent_event_consent_previous_event_id` FOREIGN KEY (`consent_previous_event_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_event`(`consent_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ADD CONSTRAINT `fk_consent_consent_event_consent_prior_event_id` FOREIGN KEY (`consent_prior_event_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_event`(`consent_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ADD CONSTRAINT `fk_consent_consent_event_consent_session_id` FOREIGN KEY (`consent_session_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_session`(`consent_session_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ADD CONSTRAINT `fk_consent_consent_event_delegation_id` FOREIGN KEY (`delegation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`delegation`(`delegation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ADD CONSTRAINT `fk_consent_consent_event_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ADD CONSTRAINT `fk_consent_consent_event_primary_event_superseded_consent_consent_record_id` FOREIGN KEY (`primary_event_superseded_consent_consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ADD CONSTRAINT `fk_consent_consent_exception_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ADD CONSTRAINT `fk_consent_consent_exception_parent_exception_id` FOREIGN KEY (`parent_exception_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_exception`(`consent_exception_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ADD CONSTRAINT `fk_consent_consent_exception_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ADD CONSTRAINT `fk_consent_consent_translation_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ADD CONSTRAINT `fk_consent_consent_translation_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ADD CONSTRAINT `fk_consent_consent_translation_superseded_translation_id` FOREIGN KEY (`superseded_translation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_translation`(`consent_translation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ADD CONSTRAINT `fk_consent_consent_verification_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ADD CONSTRAINT `fk_consent_consent_verification_prior_verification_id` FOREIGN KEY (`prior_verification_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_verification`(`consent_verification_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ADD CONSTRAINT `fk_consent_consent_verification_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_record`(`consent_record_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`consent` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`consent` SET TAGS ('dbx_domain' = 'consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` SET TAGS ('dbx_subdomain' = 'consent_authoring');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Template Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `primary_superseded_by_form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Template Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `applicable_facility_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Types');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `applicable_service_lines` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Lines');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Consent Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `electronic_signature_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_checksum` SET TAGS ('dbx_business_glossary_term' = 'Form Checksum');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_code` SET TAGS ('dbx_business_glossary_term' = 'Form Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_document_url` SET TAGS ('dbx_business_glossary_term' = 'Form Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('dbx_business_glossary_term' = 'Form Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_purpose` SET TAGS ('dbx_business_glossary_term' = 'Form Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_status` SET TAGS ('dbx_business_glossary_term' = 'Form Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|superseded|retired|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `legal_representative_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `minor_assent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Assent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `reading_level` SET TAGS ('dbx_business_glossary_term' = 'Reading Level');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `revocation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Revocation Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `revocation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Revocation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `scope_of_consent` SET TAGS ('dbx_business_glossary_term' = 'Scope of Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `hipaa_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Obtaining Staff Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `superseded_hipaa_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Hipaa Authorization Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `superseded_hipaa_authorization_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transmitted Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `authorization_purpose` SET TAGS ('dbx_business_glossary_term' = 'Authorization Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `authorization_purpose` SET TAGS ('dbx_value_regex' = 'marketing|research|psychotherapy_notes|sale_of_phi|legal_proceeding|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `authorization_purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Authorization Purpose Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Disclosure Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Disclosing Party Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('dbx_business_glossary_term' = 'Disclosing Party National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `disclosing_party_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `expiration_event` SET TAGS ('dbx_business_glossary_term' = 'Expiration Event');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `form_version` SET TAGS ('dbx_business_glossary_term' = 'Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Representative Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Personal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Personal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_relationship` SET TAGS ('dbx_value_regex' = 'parent|legal_guardian|power_of_attorney|executor|healthcare_proxy|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `phi_category` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `phi_description` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `phi_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('dbx_business_glossary_term' = 'Redisclosure Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('dbx_business_glossary_term' = 'Right to Revoke Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|digital_signature|patient_portal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `hie_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Directive ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Capturing Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Capturing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `hie_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Hie Participation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `superseded_hie_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Hie Directive Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `superseded_hie_directive_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Capturing Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `break_glass_events_count` SET TAGS ('dbx_business_glossary_term' = 'Break Glass Events Count');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written|verbal|electronic|implied');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `data_type_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Data Type Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `directive_type` SET TAGS ('dbx_business_glossary_term' = 'Directive Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `directive_type` SET TAGS ('dbx_value_regex' = 'opt_in|opt_out|opt_out_with_exceptions|conditional');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `emergency_access_override` SET TAGS ('dbx_business_glossary_term' = 'Emergency Access Override');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `federal_override_applicable` SET TAGS ('dbx_business_glossary_term' = 'Federal Override Applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `last_break_glass_date` SET TAGS ('dbx_business_glossary_term' = 'Last Break Glass Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `legal_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `patient_education_provided` SET TAGS ('dbx_business_glossary_term' = 'Patient Education Provided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `patient_instructions` SET TAGS ('dbx_business_glossary_term' = 'Patient Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `provider_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Provider Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `purpose_of_use_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Use Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `scope_of_sharing` SET TAGS ('dbx_business_glossary_term' = 'Scope of Sharing');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `scope_of_sharing` SET TAGS ('dbx_value_regex' = 'all_records|specific_data_types|specific_providers|emergency_only|treatment_only');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ALTER COLUMN `witness_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessed By Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Treatment Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `alternatives_documented` SET TAGS ('dbx_business_glossary_term' = 'Alternatives Documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `benefits_documented` SET TAGS ('dbx_business_glossary_term' = 'Benefits Documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_business_glossary_term' = 'Capacity Determination');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_value_regex' = 'patient_has_capacity|patient_lacks_capacity|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_document_location` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Location');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_form_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written|verbal|electronic|telephonic');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `emergency_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Exception Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `emergency_exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Emergency Exception Justification');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_language` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_language` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_relationship` SET TAGS ('dbx_value_regex' = 'parent|guardian|healthcare_proxy|power_of_attorney|spouse|next_of_kin');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Questions Addressed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_notes` SET TAGS ('dbx_business_glossary_term' = 'Patient Questions Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('dbx_business_glossary_term' = 'Revoked By Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `risks_documented` SET TAGS ('dbx_business_glossary_term' = 'Risks Documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_role` SET TAGS ('dbx_business_glossary_term' = 'Witness Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `research_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Research Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `superseded_research_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Research Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `superseded_research_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transmitted Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `biospecimen_collection_authorized` SET TAGS ('dbx_business_glossary_term' = 'Biospecimen Collection Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `comprehension_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Comprehension Assessment Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `comprehension_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Comprehension Assessment Result');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `comprehension_assessment_result` SET TAGS ('dbx_value_regex' = 'adequate|inadequate|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_discussion_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Consent Discussion Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Document URL');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_location` SET TAGS ('dbx_business_glossary_term' = 'Consent Location');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'in_person|telehealth|electronic|written');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Consenting Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `consenting_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `contact_for_future_studies_authorized` SET TAGS ('dbx_business_glossary_term' = 'Contact for Future Studies Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `data_sharing_authorized` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `electronic_signature_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `future_research_authorized` SET TAGS ('dbx_business_glossary_term' = 'Future Research Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `genetic_testing_authorized` SET TAGS ('dbx_business_glossary_term' = 'Genetic Testing Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `hipaa_authorization_included` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Authorization Included');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_relationship` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `lar_used` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Used');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `minor_assent_date` SET TAGS ('dbx_business_glossary_term' = 'Minor Assent Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `minor_assent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Minor Assent Obtained');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `reconsent_date` SET TAGS ('dbx_business_glossary_term' = 'Reconsent Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `reconsent_reason` SET TAGS ('dbx_business_glossary_term' = 'Reconsent Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `reconsent_required` SET TAGS ('dbx_business_glossary_term' = 'Reconsent Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `return_of_results_requested` SET TAGS ('dbx_business_glossary_term' = 'Return of Results Requested');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `study_arm` SET TAGS ('dbx_business_glossary_term' = 'Study Arm');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `subject_comprehension_assessed` SET TAGS ('dbx_business_glossary_term' = 'Subject Comprehension Assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ALTER COLUMN `witness_required` SET TAGS ('dbx_business_glossary_term' = 'Witness Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Telehealth Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `superseded_telehealth_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `cms_condition_met` SET TAGS ('dbx_business_glossary_term' = 'CMS Condition Met');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_document_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Document ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_obtained_by` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_obtained_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `consent_obtained_method` SET TAGS ('dbx_value_regex' = 'written|verbal|electronic|implied');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `emergency_override_applicable` SET TAGS ('dbx_business_glossary_term' = 'Emergency Override Applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `hipaa_authorization_included` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Authorization Included');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interstate_compact_applicable` SET TAGS ('dbx_business_glossary_term' = 'Interstate Compact Applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `interstate_compact_applicable` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Guardian Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_relationship` SET TAGS ('dbx_business_glossary_term' = 'Legal Guardian Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `legal_guardian_relationship` SET TAGS ('dbx_value_regex' = 'parent|legal_guardian|healthcare_proxy|power_of_attorney|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `minor_consent_applicable` SET TAGS ('dbx_business_glossary_term' = 'Minor Consent Applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('dbx_business_glossary_term' = 'Patient Location State');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `patient_location_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('dbx_business_glossary_term' = 'Provider Licensure State');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_licensure_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `recording_consent_provided` SET TAGS ('dbx_business_glossary_term' = 'Recording Consent Provided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `right_to_refuse_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Right to Refuse Disclosed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `state_specific_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Requirements Met');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `state_specific_requirements_met` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `technology_risks_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Technology Risks Disclosed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Modality');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_modality` SET TAGS ('dbx_value_regex' = 'video|audio_only|asynchronous|remote_monitoring|hybrid');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `third_party_disclosure_authorized` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Disclosure Authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Minor Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `delegation_id` SET TAGS ('dbx_business_glossary_term' = 'Parent/Guardian ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `superseded_minor_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Minor Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `superseded_minor_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Minor Consent Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'mature_minor|emancipated_minor|state_specific_minor_consent|parental_consent|guardian_consent|court_order');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `confidentiality_obligation_to_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Obligation to Minor Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written|verbal|electronic|implied|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `consent_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `court_order_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Court Order Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `court_order_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `court_ordered_consent_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Court-Ordered Consent Restriction Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `custodial_parent_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Custodial Parent Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `custody_documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Custody Documentation Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `custody_documentation_type` SET TAGS ('dbx_value_regex' = 'court_order|divorce_decree|custody_agreement|birth_certificate|adoption_papers|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `data_sharing_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `emancipated_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Emancipated Minor Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `emancipation_documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Emancipation Documentation Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `emancipation_documentation_type` SET TAGS ('dbx_value_regex' = 'court_order|marriage_certificate|military_service|self_supporting_declaration|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `hie_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `hie_participation_status` SET TAGS ('dbx_value_regex' = 'opted_in|opted_out|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `hipaa_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `interpreter_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_age_at_consent` SET TAGS ('dbx_business_glossary_term' = 'Minor Age at Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_age_at_consent` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_assent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Assent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Consenting Independently Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `minor_consenting_independently_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('dbx_business_glossary_term' = 'Parent/Guardian Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parent_guardian_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parental_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `parental_notification_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Notification Permitted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `research_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Research Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `revoked_by` SET TAGS ('dbx_business_glossary_term' = 'Revoked By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `revoked_by` SET TAGS ('dbx_value_regex' = 'minor|parent|guardian|court|system|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `state_specific_minor_consent_category` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Minor Consent Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `state_specific_minor_consent_category` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Delegation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Delegate Person Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_last_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_last_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_last_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_patient_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_revoked_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Revoked By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_revoked_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_revoked_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `superseded_delegation_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Delegation Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `superseded_delegation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `applies_to_minor` SET TAGS ('dbx_business_glossary_term' = 'Applies to Minor Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delegate Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delegate Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('dbx_business_glossary_term' = 'Delegate City');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Delegate Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Delegate Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_country` SET TAGS ('dbx_business_glossary_term' = 'Delegate Country');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|AUS|[A-Z]{3}');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_country` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('dbx_business_glossary_term' = 'Delegate Full Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delegate Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_relationship` SET TAGS ('dbx_business_glossary_term' = 'Delegate Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('dbx_business_glossary_term' = 'Delegate State or Province');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegate_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `emergency_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `emergency_contact_flag` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `legal_document_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `legal_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `legal_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `legal_document_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `limitations_description` SET TAGS ('dbx_business_glossary_term' = 'Limitations Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `priority_order` SET TAGS ('dbx_business_glossary_term' = 'Priority Order');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Delegation Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_status` SET TAGS ('dbx_business_glossary_term' = 'Delegation Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|revoked|expired|pending_verification');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_type` SET TAGS ('dbx_business_glossary_term' = 'Delegation Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `delegation_type` SET TAGS ('dbx_value_regex' = 'healthcare_proxy|durable_power_of_attorney|legal_guardian|court_appointed_guardian|next_of_kin_surrogate|parental_authority');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|unverified|verification_failed|expired_verification');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` SET TAGS ('dbx_subdomain' = 'lifecycle_tracking');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `delegation_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_revocation_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Revocation Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_revocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_processed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_processed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_processed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `data_access_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Access Restricted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `data_access_restricted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Access Restricted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `disclosures_halted_flag` SET TAGS ('dbx_business_glossary_term' = 'Disclosures Halted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `disclosures_halted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disclosures Halted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Revocation Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `irrevocable_actions_description` SET TAGS ('dbx_business_glossary_term' = 'Irrevocable Actions Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Revocation Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Revocation Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `partial_revocation_details` SET TAGS ('dbx_business_glossary_term' = 'Partial Revocation Details');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_disclosures_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Disclosures Count');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_disclosures_summary` SET TAGS ('dbx_business_glossary_term' = 'Prior Disclosures Summary');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'patient_request|privacy_concern|no_longer_needed|treatment_complete|other|not_provided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Revocation Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'full|partial');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_status` SET TAGS ('dbx_business_glossary_term' = 'Revocation Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_status` SET TAGS ('dbx_value_regex' = 'pending|processed|effective|rejected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` SET TAGS ('dbx_subdomain' = 'lifecycle_tracking');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `npp_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Notice of Privacy Practices (NPP) Acknowledgment ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `notice_of_privacy_practices_id` SET TAGS ('dbx_business_glossary_term' = 'Notice Of Privacy Practices Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Obtained By User ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `prior_npp_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Npp Acknowledgment Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `prior_npp_acknowledgment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `accessibility_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_location` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Location');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_value_regex' = 'signature_paper|signature_electronic|portal_click|email_confirmation|kiosk_acceptance|verbal_documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'acknowledged|declined|unable_to_obtain|good_faith_effort_documented|pending|voided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'paper|electronic|patient_portal|email|kiosk|verbal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `good_faith_effort_documentation` SET TAGS ('dbx_business_glossary_term' = 'Good Faith Effort Documentation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `good_faith_effort_reason` SET TAGS ('dbx_business_glossary_term' = 'Good Faith Effort Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `good_faith_effort_reason` SET TAGS ('dbx_value_regex' = 'patient_refused|emergency_treatment|patient_unable_to_sign|language_barrier|patient_left_before_signing|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `is_first_service_acknowledgment` SET TAGS ('dbx_business_glossary_term' = 'Is First Service Acknowledgment Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `material_change_acknowledgment` SET TAGS ('dbx_business_glossary_term' = 'Material Change Acknowledgment Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `patient_portal_session_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Portal Session ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `representative_authority_documented` SET TAGS ('dbx_business_glossary_term' = 'Representative Authority Documented Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signature_type` SET TAGS ('dbx_business_glossary_term' = 'Signature Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signature_type` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|digital_signature|biometric|none');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('dbx_business_glossary_term' = 'Signer Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_relationship` SET TAGS ('dbx_business_glossary_term' = 'Signer Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` SET TAGS ('dbx_subdomain' = 'lifecycle_tracking');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_request_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Restriction Request ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Officer ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `superseded_restriction_request_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Restriction Request Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `superseded_restriction_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_made_by` SET TAGS ('dbx_business_glossary_term' = 'Decision Made By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Restriction Request Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `operational_instructions` SET TAGS ('dbx_business_glossary_term' = 'Operational Instructions for Restriction Enforcement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `organization_decision` SET TAGS ('dbx_business_glossary_term' = 'Organization Decision on Restriction Request');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `organization_decision` SET TAGS ('dbx_value_regex' = 'accepted|denied|pending_review|conditionally_accepted|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `out_of_pocket_payment_verified` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Payment Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `payment_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_method` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Restriction Request Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('dbx_value_regex' = 'patient_self|legal_guardian|personal_representative|power_of_attorney|parent_of_minor|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_phi_category` SET TAGS ('dbx_business_glossary_term' = 'Restricted Protected Health Information (PHI) Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_purpose` SET TAGS ('dbx_business_glossary_term' = 'Restricted Purpose of Use or Disclosure');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Restricted Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Restricted Recipient Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_business_glossary_term' = 'Restriction Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked_by_patient|terminated_by_organization|superseded|pending_activation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'hitech_out_of_pocket_payer_restriction|family_member_disclosure_restriction|specific_data_type_restriction|specific_recipient_restriction|treatment_purpose_restriction|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `revocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revocation Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `system_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'System Enforcement Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` SET TAGS ('dbx_subdomain' = 'lifecycle_tracking');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_log_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Disclosure Log ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `hipaa_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_access_log_id` SET TAGS ('dbx_business_glossary_term' = 'Phi Access Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `related_prior_disclosure_log_id` SET TAGS ('dbx_business_glossary_term' = 'Related Disclosure Log Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `related_prior_disclosure_log_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Initiated By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_initiated_by_role` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Initiated By Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_method` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_purpose_category` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|revoked|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('dbx_business_glossary_term' = 'Is Accounting Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_tpo_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Is Treatment Payment Operations (TPO) Disclosure');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `minimum_necessary_applied` SET TAGS ('dbx_business_glossary_term' = 'Minimum Necessary Applied');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_elements_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Elements Disclosed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_elements_disclosed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_elements_disclosed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('dbx_business_glossary_term' = 'Recipient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Capacity Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Assessing Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `delegation_id` SET TAGS ('dbx_business_glossary_term' = 'Surrogate Decision Maker ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Witness ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `prior_capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Capacity Assessment Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `prior_capacity_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `prior_capacity_assessment_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `appreciation_ability` SET TAGS ('dbx_business_glossary_term' = 'Appreciation Ability');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `appreciation_ability` SET TAGS ('dbx_value_regex' = 'intact|impaired|severely_impaired|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessing_clinician_specialty` SET TAGS ('dbx_business_glossary_term' = 'Assessing Clinician Specialty');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessment_location` SET TAGS ('dbx_business_glossary_term' = 'Assessment Location');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled|amended|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessment_tool_used` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Used');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `assessment_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_business_glossary_term' = 'Capacity Determination');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_value_regex' = 'full_capacity|diminished_capacity|lacks_capacity|indeterminate|reassessment_required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_score` SET TAGS ('dbx_business_glossary_term' = 'Capacity Score');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `capacity_score` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `choice_expression_ability` SET TAGS ('dbx_business_glossary_term' = 'Choice Expression Ability');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `choice_expression_ability` SET TAGS ('dbx_value_regex' = 'intact|impaired|severely_impaired|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `clinical_basis_for_determination` SET TAGS ('dbx_business_glossary_term' = 'Clinical Basis for Determination');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `contributing_conditions` SET TAGS ('dbx_business_glossary_term' = 'Contributing Conditions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `contributing_medications` SET TAGS ('dbx_business_glossary_term' = 'Contributing Medications');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `documentation_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `ethics_consultation_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethics Consultation Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `legal_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Authority Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `legal_authority_type` SET TAGS ('dbx_value_regex' = 'healthcare_proxy|power_of_attorney|legal_guardian|next_of_kin|court_appointed|none');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `legal_consultation_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Consultation Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `reasoning_ability` SET TAGS ('dbx_business_glossary_term' = 'Reasoning Ability');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `reasoning_ability` SET TAGS ('dbx_value_regex' = 'intact|impaired|severely_impaired|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `reassessment_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Recommended Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `reassessment_timeframe` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Timeframe');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `specific_deficits_identified` SET TAGS ('dbx_business_glossary_term' = 'Specific Deficits Identified');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `surrogate_decision_maker_engaged_flag` SET TAGS ('dbx_business_glossary_term' = 'Surrogate Decision Maker Engaged Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `surrogate_decision_maker_engaged_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `surrogate_relationship` SET TAGS ('dbx_business_glossary_term' = 'Surrogate Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `understanding_ability` SET TAGS ('dbx_business_glossary_term' = 'Understanding Ability');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `understanding_ability` SET TAGS ('dbx_value_regex' = 'intact|impaired|severely_impaired|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ALTER COLUMN `witness_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Present Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` SET TAGS ('dbx_subdomain' = 'consent_authoring');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `primary_superseded_by_consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Policy Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `tertiary_consent_last_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `tertiary_consent_last_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `tertiary_consent_last_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `applicable_facility_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Types');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `applicable_service_lines` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Lines');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_triggers` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Triggers');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `capacity_assessment_triggers` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `consent_category` SET TAGS ('dbx_value_regex' = 'treatment|research|data_sharing|hipaa_authorization|hie|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `consent_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Consent Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `documentation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirements');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `electronic_signature_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `legal_representative_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `minor_assent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Assent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|superseded');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `reconsent_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Reconsent Interval Months');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `reconsent_trigger_new_risk` SET TAGS ('dbx_business_glossary_term' = 'Reconsent Trigger New Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `reconsent_trigger_protocol_amendment` SET TAGS ('dbx_business_glossary_term' = 'Reconsent Trigger Protocol Amendment Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `reconsent_trigger_time_based` SET TAGS ('dbx_business_glossary_term' = 'Reconsent Trigger Time-Based Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `regulatory_citations` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citations');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `required_consent_elements` SET TAGS ('dbx_business_glossary_term' = 'Required Consent Elements');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `revocation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Revocation Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `revocation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Revocation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` SET TAGS ('dbx_subdomain' = 'consent_authoring');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Workflow Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `parent_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Workflow Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `parent_workflow_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `primary_superseded_by_consent_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Workflow Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_last_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_last_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_last_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `applicable_care_setting` SET TAGS ('dbx_business_glossary_term' = 'Applicable Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `applicable_service_line` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Line');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `capacity_assessment_required_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Workflow Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'treatment|research|data_sharing|hipaa_authorization|hie_participation|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_description` SET TAGS ('dbx_business_glossary_term' = 'Workflow Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `ehr_event_mapping` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Event Mapping');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `ehr_integration_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Integration Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `ehr_module_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Module Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `ehr_system_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) System Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `electronic_signature_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `escalation_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `escalation_recipient_role` SET TAGS ('dbx_business_glossary_term' = 'Escalation Recipient Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `escalation_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Unit');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `escalation_threshold_unit` SET TAGS ('dbx_value_regex' = 'minutes|hours|days');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `escalation_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Value');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `irb_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `legal_representative_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_name` SET TAGS ('dbx_business_glossary_term' = 'Workflow Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `required_steps_sequence` SET TAGS ('dbx_business_glossary_term' = 'Required Steps Sequence');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `revocation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Revocation Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `revocation_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Revocation Workflow Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `secondary_role` SET TAGS ('dbx_business_glossary_term' = 'Secondary Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|verbal|implied');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|suspended');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `step_count` SET TAGS ('dbx_business_glossary_term' = 'Step Count');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `time_constraint_direction` SET TAGS ('dbx_business_glossary_term' = 'Time Constraint Direction');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `time_constraint_direction` SET TAGS ('dbx_value_regex' = 'before|after|within');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `time_constraint_unit` SET TAGS ('dbx_business_glossary_term' = 'Time Constraint Unit');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `time_constraint_unit` SET TAGS ('dbx_value_regex' = 'minutes|hours|days|weeks');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `time_constraint_value` SET TAGS ('dbx_business_glossary_term' = 'Time Constraint Value');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `triggering_event_code` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_value_regex' = 'admission|surgical_scheduling|research_enrollment|telehealth_initiation|outpatient_registration|procedure_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`workflow` ALTER COLUMN `witness_role` SET TAGS ('dbx_business_glossary_term' = 'Witness Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Deficiency Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Discovered By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_escalated_to_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_escalated_to_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_escalated_to_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_last_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_last_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_last_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_remediated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Remediated By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_remediated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_remediated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_waiver_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_waiver_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_waiver_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Template Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `related_prior_deficiency_id` SET TAGS ('dbx_business_glossary_term' = 'Related Deficiency Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `related_prior_deficiency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_category` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_category` SET TAGS ('dbx_value_regex' = 'clinical|research|administrative|hipaa_authorization|hie_consent|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `discovered_by_role` SET TAGS ('dbx_business_glossary_term' = 'Discovered By Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `remediation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `remediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remediation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `responsible_department_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Procedure Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `source_system_deficiency_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Deficiency Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_status` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|remediated|waived|closed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `deficiency_type` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `substance_use_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Obtaining Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Message Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `superseded_substance_use_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Substance Use Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `superseded_substance_use_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Result');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_value_regex' = 'has_capacity|lacks_capacity|partial_capacity');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `cares_act_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Coronavirus Aid, Relief, and Economic Security (CARES) Act Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `disclosure_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `disclosure_purpose_category` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `disclosure_purpose_category` SET TAGS ('dbx_value_regex' = 'treatment|payment|healthcare_operations|research|legal|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `expiration_event` SET TAGS ('dbx_business_glossary_term' = 'Expiration Event');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `form_version` SET TAGS ('dbx_business_glossary_term' = 'Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `information_disclosed_description` SET TAGS ('dbx_business_glossary_term' = 'Information Disclosed Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `personal_representative_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Representative Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `personal_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Personal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `personal_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `personal_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `personal_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Personal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `recipient_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `recipient_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `recipient_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_business_glossary_term' = 'Recipient National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `redisclosure_prohibition_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Redisclosure Prohibition Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `redisclosure_prohibition_notice` SET TAGS ('dbx_business_glossary_term' = 'Redisclosure Prohibition Notice');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('dbx_business_glossary_term' = 'Right to Revoke Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic|digital|biometric');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `signature_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `sud_program_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder (SUD) Program Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `sud_program_npi` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder (SUD) Program National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ALTER COLUMN `witness_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Health Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Obtaining Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Message Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `superseded_behavioral_health_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Behavioral Health Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `superseded_behavioral_health_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `superseded_behavioral_health_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `superseded_behavioral_health_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `authorized_recipient_address` SET TAGS ('dbx_business_glossary_term' = 'Authorized Recipient Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `authorized_recipient_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `authorized_recipient_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `authorized_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `authorized_recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `authorized_recipient_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `authorized_recipient_npi` SET TAGS ('dbx_business_glossary_term' = 'Authorized Recipient National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `authorized_recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Authorized Recipient Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `authorized_recipient_type` SET TAGS ('dbx_value_regex' = 'individual|organization|provider|payer|legal_entity|research_institution');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_business_glossary_term' = 'Capacity Determination');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_value_regex' = 'has_capacity|lacks_capacity|partial_capacity|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `consent_number` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Health Consent Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending|superseded|voided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'disclosure|treatment|research|data_sharing|hie_participation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `disclosure_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `disclosure_purpose_category` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `document_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `expiration_event` SET TAGS ('dbx_business_glossary_term' = 'Expiration Event');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `form_version` SET TAGS ('dbx_business_glossary_term' = 'Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `legal_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Authority Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `legal_authority_type` SET TAGS ('dbx_value_regex' = 'parental|guardianship|power_of_attorney|conservatorship|court_order');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `legal_representative_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `legal_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_data_elements_covered` SET TAGS ('dbx_business_glossary_term' = 'Mental Health Data Elements Covered');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_data_elements_covered` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mental_health_data_elements_covered` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `obtaining_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Obtaining Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `patient_imposed_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Patient-Imposed Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `psychotherapy_notes_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Psychotherapy Notes Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `redisclosure_prohibition_statement` SET TAGS ('dbx_business_glossary_term' = 'Redisclosure Prohibition Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `redisclosure_prohibition_statement` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `revocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revocation Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `revocation_method` SET TAGS ('dbx_value_regex' = 'written|verbal|electronic|in_person');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('dbx_business_glossary_term' = 'Right to Revoke Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic|digital|biometric|verbal_recorded');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `signature_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `state_law_basis` SET TAGS ('dbx_business_glossary_term' = 'State Law Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `state_law_basis` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `substance_abuse_records_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Records Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ALTER COLUMN `witness_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` SET TAGS ('dbx_subdomain' = 'lifecycle_tracking');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `expiration_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Alert Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `prior_expiration_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Expiration Alert Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `prior_expiration_alert_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_generation_date` SET TAGS ('dbx_business_glossary_term' = 'Alert Generation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Alert Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^CEA-[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_priority` SET TAGS ('dbx_business_glossary_term' = 'Alert Priority');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_value_regex' = 'open|acknowledged|in_progress|resolved|escalated|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'approaching_expiration|expired|renewal_required|grace_period|critical');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `auto_renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `care_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `days_until_expiration` SET TAGS ('dbx_business_glossary_term' = 'Days Until Expiration');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `last_reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `notification_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `notification_delivery_status` SET TAGS ('dbx_value_regex' = 'pending|sent|delivered|failed|bounced|read');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `patient_contact_attempted_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Contact Attempted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `patient_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Contact Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `patient_response` SET TAGS ('dbx_business_glossary_term' = 'Patient Response');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `patient_response` SET TAGS ('dbx_value_regex' = 'agreed_to_renew|declined_renewal|requested_modification|no_response|unreachable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `renewal_method` SET TAGS ('dbx_business_glossary_term' = 'Renewal Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `responsible_staff_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Procedure Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ALTER COLUMN `sla_target_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Hours');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Genetic Testing Consent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Obtaining Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Genetic Counselor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Template Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `superseded_genetic_testing_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Genetic Testing Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `superseded_genetic_testing_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `authorized_representative_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `authorized_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_consent` SET TAGS ('dbx_business_glossary_term' = 'Biobank Storage Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_consent` SET TAGS ('dbx_value_regex' = 'authorized|not_authorized|time_limited');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `biobank_storage_consent` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Result');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_value_regex' = 'has_capacity|lacks_capacity|partial_capacity');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `commercial_use_consent` SET TAGS ('dbx_business_glossary_term' = 'Commercial Use Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `commercial_use_consent` SET TAGS ('dbx_value_regex' = 'authorized|not_authorized');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `consent_decision` SET TAGS ('dbx_business_glossary_term' = 'Genetic Testing Consent Decision');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `consent_decision` SET TAGS ('dbx_value_regex' = 'granted|declined|partial');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Genetic Testing Consent Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'specific_test_only|future_research_use|biobank_storage|data_sharing|all');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `counseling_date` SET TAGS ('dbx_business_glossary_term' = 'Genetic Counseling Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `counseling_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Genetic Counseling Provided Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `data_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period in Years');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `document_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `family_implications_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Family Implications Disclosed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `family_notification_consent` SET TAGS ('dbx_business_glossary_term' = 'Family Notification Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `family_notification_consent` SET TAGS ('dbx_value_regex' = 'authorized|not_authorized|conditional');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `gina_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Genetic Information Nondiscrimination Act (GINA) Disclosure Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `incidental_findings_consent` SET TAGS ('dbx_business_glossary_term' = 'Incidental Findings Return Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `incidental_findings_consent` SET TAGS ('dbx_value_regex' = 'return_all|return_medically_actionable|do_not_return|patient_to_decide_later');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `insurance_discrimination_risk_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Discrimination Risk Disclosed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `obtaining_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Obtaining Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `recontact_consent` SET TAGS ('dbx_business_glossary_term' = 'Recontact Consent for New Findings');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `recontact_consent` SET TAGS ('dbx_value_regex' = 'authorized|not_authorized|conditional');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `research_registry_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Research Registry Data Sharing Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `research_registry_sharing_consent` SET TAGS ('dbx_value_regex' = 'authorized|not_authorized|authorized_with_restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `research_use_consent` SET TAGS ('dbx_business_glossary_term' = 'Research Use Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `research_use_consent` SET TAGS ('dbx_value_regex' = 'authorized|not_authorized|authorized_with_restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'electronic|wet_signature|verbal|proxy');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `signature_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Signature Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Genetic Test Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `test_purpose` SET TAGS ('dbx_business_glossary_term' = 'Genetic Test Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Genetic Test Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ALTER COLUMN `witness_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `photography_media_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Photography Media Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Obtaining Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Template ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `superseded_photography_media_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Photography Media Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `superseded_photography_media_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Result');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_value_regex' = 'has_capacity|lacks_capacity|partial_capacity|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `compensation_description` SET TAGS ('dbx_business_glossary_term' = 'Compensation Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `compensation_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `compensation_description` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Disclosure Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `distribution_channels` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channels');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `form_version` SET TAGS ('dbx_business_glossary_term' = 'Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `identifiable_flag` SET TAGS ('dbx_business_glossary_term' = 'Identifiable Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `legal_representative_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `legal_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `media_type` SET TAGS ('dbx_value_regex' = 'photography|video|audio|digital_image|mixed_media');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `right_to_withdraw_statement` SET TAGS ('dbx_business_glossary_term' = 'Right to Withdraw Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `right_to_withdraw_statement` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'electronic|wet_signature|verbal|biometric|digital_certificate');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `signature_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ALTER COLUMN `witness_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` SET TAGS ('dbx_subdomain' = 'lifecycle_tracking');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `amendment_request_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Amendment Request Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `original_amendment_request_id` SET TAGS ('dbx_business_glossary_term' = 'Original Amendment Request Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `original_amendment_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Made By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `amendment_applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Applied Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `amendment_scope` SET TAGS ('dbx_business_glossary_term' = 'Amendment Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `amendment_scope` SET TAGS ('dbx_value_regex' = 'consent_record|phi_documentation|authorization_details|consent_restrictions|disclosure_log|all');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'correction|addition|clarification|deletion|update');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `extension_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `organization_decision` SET TAGS ('dbx_business_glossary_term' = 'Organization Decision');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `organization_decision` SET TAGS ('dbx_value_regex' = 'accepted|denied|partially_accepted');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `organization_rebuttal` SET TAGS ('dbx_business_glossary_term' = 'Organization Rebuttal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `patient_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `patient_notification_method` SET TAGS ('dbx_value_regex' = 'mail|email|portal|phone|in_person');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `patient_statement_of_disagreement` SET TAGS ('dbx_business_glossary_term' = 'Patient Statement of Disagreement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `patient_statement_of_disagreement` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `reason_for_amendment` SET TAGS ('dbx_business_glossary_term' = 'Reason for Amendment');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Channel');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `request_method` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `requested_change_description` SET TAGS ('dbx_business_glossary_term' = 'Requested Change Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `third_party_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Third Party Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `third_party_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `third_party_recipients_notified` SET TAGS ('dbx_business_glossary_term' = 'Third Party Recipients Notified');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Withdrawal Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Withdrawal Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` SET TAGS ('dbx_subdomain' = 'consent_authoring');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_session_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Session Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `resumed_consent_session_id` SET TAGS ('dbx_business_glossary_term' = 'Resumed Consent Session Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `resumed_consent_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `all_consents_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'All Consents Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Channel');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_count` SET TAGS ('dbx_business_glossary_term' = 'Consent Count');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Url');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consent_language` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consenting_party_name` SET TAGS ('dbx_business_glossary_term' = 'Consenting Party Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consenting_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consenting_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consenting_party_relationship` SET TAGS ('dbx_business_glossary_term' = 'Consenting Party Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `consenting_party_type` SET TAGS ('dbx_business_glossary_term' = 'Consenting Party Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `electronic_signature_method` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `interpreter_language` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `interpreter_language` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Ip Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `session_notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `session_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Session Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `session_timeout_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Timeout Minutes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `staff_role` SET TAGS ('dbx_business_glossary_term' = 'Staff Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ALTER COLUMN `witness_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` SET TAGS ('dbx_subdomain' = 'patient_authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessor Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_record_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Template Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `superseded_record_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Record Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `superseded_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `authorized_representative_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `authorized_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `capacity_assessment_performed_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Result');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_value_regex' = 'has_capacity|lacks_capacity|partial_capacity|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_decision` SET TAGS ('dbx_business_glossary_term' = 'Consent Decision');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_decision` SET TAGS ('dbx_value_regex' = 'permit|deny|opt_in|opt_out');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_expiration_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written|verbal|electronic|implied');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_obtained_datetime` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Renewal Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Consent Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_revocation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'patient_privacy|research|treatment|adr');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_source_system` SET TAGS ('dbx_business_glossary_term' = 'Consent Source System');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `hipaa_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `patient_signature_datetime` SET TAGS ('dbx_business_glossary_term' = 'Patient Signature Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `research_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Research Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_record` ALTER COLUMN `witness_signature_datetime` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` SET TAGS ('dbx_subdomain' = 'lifecycle_tracking');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_event_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performing User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_event_interpreter_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interpreter User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_event_interpreter_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_event_interpreter_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_event_witness_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Witness User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_event_witness_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_event_witness_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_previous_event_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Event Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_previous_event_id` SET TAGS ('dbx_renamed_from' = 'consent_previous_event_id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_prior_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Event Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_prior_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `consent_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `delegation_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `primary_event_superseded_consent_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Consent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Channel');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_person|patient_portal|kiosk|telehealth|paper|phone');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `document_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'presented|signed|witnessed|revoked|expired|renewed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `legal_representative_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `performing_user_role` SET TAGS ('dbx_business_glossary_term' = 'Performing User Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `performing_user_role` SET TAGS ('dbx_value_regex' = 'patient|nurse|physician|registration_clerk|research_coordinator|legal_representative');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `signature_image_reference` SET TAGS ('dbx_business_glossary_term' = 'Signature Image Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `signature_image_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `signature_image_reference` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'electronic|wet_signature|verbal|biometric|digital_certificate|proxy');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'photo_id|two_factor_authentication|biometric|knowledge_based|in_person|none');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification|verification_failed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `consent_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Exception Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Documented By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `parent_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Related Exception Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `parent_exception_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `accounting_of_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Accounting of Disclosure Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `clinical_justification` SET TAGS ('dbx_business_glossary_term' = 'Clinical Justification');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `dispute_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `dispute_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `documented_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Documented Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `emergency_treatment_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Treatment Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `emergency_treatment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `emergency_treatment_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Exception Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^CE-[0-9]{8,12}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'invoked|documented|patient_notified|under_review|closed|disputed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `imminent_danger_flag` SET TAGS ('dbx_business_glossary_term' = 'Imminent Danger Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `invoked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Invoked Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `legal_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `legal_basis_code` SET TAGS ('dbx_value_regex' = '^(45CFR164.512([a-l])|STATE-[A-Z]{2}-[0-9]{3,6}|TJC-[A-Z]{2,4}-[0-9]{2,4})$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `legal_basis_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `patient_incapacity_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Incapacity Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `patient_incapacity_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `patient_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `patient_notification_method` SET TAGS ('dbx_value_regex' = 'written_letter|secure_email|patient_portal|in_person|phone_call|certified_mail');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `patient_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `patient_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Notified Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `phi_disclosed_description` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Disclosed Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `phi_disclosed_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `privacy_officer_notes` SET TAGS ('dbx_business_glossary_term' = 'Privacy Officer Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `privacy_officer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `privacy_officer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Privacy Officer Review Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `recipient_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `recipient_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `recipient_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `reviewed_by_privacy_officer_flag` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Privacy Officer Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_exception` ALTER COLUMN `surrogate_unavailable_flag` SET TAGS ('dbx_business_glossary_term' = 'Surrogate Unavailable Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` SET TAGS ('dbx_subdomain' = 'consent_authoring');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `consent_translation_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Translation ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interpreter User ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `consent_translation_quality_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Translation Quality Reviewer ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `consent_translation_quality_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `consent_translation_quality_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Template ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `superseded_translation_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Translation Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `superseded_translation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `auxiliary_aid_description` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Aid Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `auxiliary_aid_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Aid Provided Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `communication_barrier_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Barrier Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `communication_barrier_type` SET TAGS ('dbx_value_regex' = 'limited_english_proficiency|hearing_impairment|speech_impairment|visual_impairment|cognitive_impairment|multiple_barriers');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Translation Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Translation Cost Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Translation Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Translation End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `interpreter_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Attestation Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `interpreter_attestation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Attestation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `interpreter_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `interpreter_certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `interpreter_session_code` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Session ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `interpreter_type` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `interpreter_type` SET TAGS ('dbx_value_regex' = 'certified_medical_interpreter|qualified_interpreter|ad_hoc_bilingual_staff|family_member|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `lep_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Limited English Proficiency (LEP) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Translation Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `patient_preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Preferred Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `patient_preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `patient_preferred_language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `patient_preferred_language_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Preferred Language Confirmed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `patient_preferred_language_confirmed_flag` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `patient_understanding_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Understanding Attestation Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `patient_understanding_attestation_method` SET TAGS ('dbx_business_glossary_term' = 'Patient Understanding Attestation Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `patient_understanding_attestation_method` SET TAGS ('dbx_value_regex' = 'verbal_confirmation|written_signature|electronic_signature|witnessed_verbal|teach_back_method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `quality_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Translation Quality Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `quality_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Translation Quality Review Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `source_system_translation_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Translation ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Translation Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `target_language_code` SET TAGS ('dbx_business_glossary_term' = 'Target Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `target_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `target_language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `target_language_name` SET TAGS ('dbx_business_glossary_term' = 'Target Language Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `target_language_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `title_vi_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Title VI Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `translated_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Translated Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `translated_document_version` SET TAGS ('dbx_business_glossary_term' = 'Translated Document Version');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `translation_method` SET TAGS ('dbx_business_glossary_term' = 'Translation Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_translation` ALTER COLUMN `translation_method` SET TAGS ('dbx_value_regex' = 'certified_written_translation|qualified_in_person_interpreter|telephonic_interpreter|video_remote_interpreting|bilingual_staff|family_member_interpreter');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `consent_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Verification ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verifying User ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('dbx_business_glossary_term' = 'Fhir Resource Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `monitoring_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Activity Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `prior_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Verification Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `prior_verification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `action_taken` SET TAGS ('dbx_value_regex' = 'proceeded|obtained_new_consent|escalated|blocked|deferred');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `clinical_context` SET TAGS ('dbx_business_glossary_term' = 'Clinical Context');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `consent_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'treatment|research|data_sharing|hipaa_authorization|hie_participation|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `days_until_expiration` SET TAGS ('dbx_business_glossary_term' = 'Days Until Expiration');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Verification Duration in Seconds');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `error_message` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `integration_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Integration Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|patient_portal|mail|phone|in_person');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `override_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Override Authorized By User ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `restriction_details` SET TAGS ('dbx_business_glossary_term' = 'Restriction Details');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'automated|manual|real_time_query|batch_check');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'valid|expired|revoked|missing|restricted|pending');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `verification_source` SET TAGS ('dbx_value_regex' = 'emr|consent_registry|hie|patient_portal|paper_record|external_system');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `verifying_user_npi` SET TAGS ('dbx_business_glossary_term' = 'Verifying User National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_verification` ALTER COLUMN `verifying_user_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
