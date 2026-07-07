-- Schema for Domain: behavioral_health | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`behavioral_health` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` (
    `psychiatric_assessment_id` BIGINT COMMENT 'Unique identifier for the psychiatric assessment within the behavioral health psychiatric assessment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the behavioral health psychiatric assessment record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the behavioral health psychiatric assessment record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the behavioral health psychiatric assessment record.',
    `observation_id` BIGINT COMMENT 'Unique identifier for the observation within the behavioral health psychiatric assessment record.',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the behavioral health psychiatric assessment record.',
    `part2_consent_workflow_part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent workflow part2 consent within the behavioral health psychiatric assessment record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the psychiatric attending clinician within the behavioral health psychiatric assessment record.',
    `psychiatric_clinician_id` BIGINT COMMENT 'Unique identifier for the psychiatric clinician within the behavioral health psychiatric assessment record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the behavioral health psychiatric assessment record.',
    `administered_by_role` STRING COMMENT 'The administered by role of the behavioral health psychiatric assessment record.',
    `administered_timestamp` TIMESTAMP COMMENT 'The administered timestamp of the behavioral health psychiatric assessment record.',
    `assessment_date` DATE COMMENT 'Timestamp capturing the assessment date associated with the behavioral health psychiatric assessment record.',
    `assessment_instrument` STRING COMMENT 'The assessment instrument of the behavioral health psychiatric assessment record.',
    `assessment_status` STRING COMMENT 'The assessment status value classifying the behavioral health psychiatric assessment record.',
    `assessment_timestamp` TIMESTAMP COMMENT 'The assessment timestamp of the behavioral health psychiatric assessment record.',
    `assessment_tool` STRING COMMENT 'The assessment tool of the behavioral health psychiatric assessment record.',
    `assessment_type` STRING COMMENT 'The assessment type value classifying the behavioral health psychiatric assessment record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the behavioral health psychiatric assessment record.',
    `clinician_notes` STRING COMMENT 'The clinician notes of the behavioral health psychiatric assessment record.',
    `columbia_suicide_severity_score` STRING COMMENT 'The columbia suicide severity score of the behavioral health psychiatric assessment record.',
    `confidentiality_level` STRING COMMENT 'The confidentiality level of the behavioral health psychiatric assessment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the behavioral health psychiatric assessment record.',
    `cssrs_behavior_score` STRING COMMENT 'The cssrs behavior score of the behavioral health psychiatric assessment record.',
    `cssrs_ideation_score` STRING COMMENT 'The cssrs ideation score of the behavioral health psychiatric assessment record.',
    `cssrs_risk_level` STRING COMMENT 'The cssrs risk level of the behavioral health psychiatric assessment record.',
    `cssrs_score` STRING COMMENT 'The cssrs score of the behavioral health psychiatric assessment record.',
    `diagnosis_code` STRING COMMENT 'The diagnosis code value classifying the behavioral health psychiatric assessment record.',
    `follow_up_required_flag` BOOLEAN COMMENT 'The follow up required flag of the behavioral health psychiatric assessment record.',
    `gad7_score` STRING COMMENT 'The gad7 score of the behavioral health psychiatric assessment record.',
    `gad7_severity` STRING COMMENT 'The gad7 severity of the behavioral health psychiatric assessment record.',
    `gad7_total_score` STRING COMMENT 'The gad7 total score of the behavioral health psychiatric assessment record.',
    `instrument` STRING COMMENT 'The instrument of the behavioral health psychiatric assessment record.',
    `instrument_name` STRING COMMENT 'The instrument name of the behavioral health psychiatric assessment record.',
    `interpretation` STRING COMMENT 'The interpretation of the behavioral health psychiatric assessment record.',
    `mental_status_exam_findings` STRING COMMENT 'The mental status exam findings of the behavioral health psychiatric assessment record.',
    `part2_protected_flag` BOOLEAN COMMENT 'The part2 protected flag of the behavioral health psychiatric assessment record.',
    `phq9_item9_score` STRING COMMENT 'The phq9 item9 score of the behavioral health psychiatric assessment record.',
    `phq9_score` STRING COMMENT 'The phq9 score of the behavioral health psychiatric assessment record.',
    `phq9_severity` STRING COMMENT 'The phq9 severity of the behavioral health psychiatric assessment record.',
    `phq9_total_score` STRING COMMENT 'The phq9 total score of the behavioral health psychiatric assessment record.',
    `safety_plan_documented` BOOLEAN COMMENT 'The safety plan documented of the behavioral health psychiatric assessment record.',
    `severity` STRING COMMENT 'The severity of the behavioral health psychiatric assessment record.',
    `severity_level` STRING COMMENT 'The severity level of the behavioral health psychiatric assessment record.',
    `suicidal_ideation_flag` BOOLEAN COMMENT 'The suicidal ideation flag of the behavioral health psychiatric assessment record.',
    `suicide_risk_flag` BOOLEAN COMMENT 'The suicide risk flag of the behavioral health psychiatric assessment record.',
    `suicide_risk_level` STRING COMMENT 'The suicide risk level of the behavioral health psychiatric assessment record.',
    `total_score` DECIMAL(18,2) COMMENT 'The total score of the behavioral health psychiatric assessment record.',
    `treatment_plan` STRING COMMENT 'The treatment plan of the behavioral health psychiatric assessment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the behavioral health psychiatric assessment record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the behavioral health psychiatric assessment record.',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the behavioral health psychiatric assessment record.',
    CONSTRAINT pk_psychiatric_assessment PRIMARY KEY(`psychiatric_assessment_id`)
) COMMENT 'PHQ-9, GAD-7, C-SSRS scoring';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` (
    `sud_episode_id` BIGINT COMMENT 'Unique identifier for the sud episode within the behavioral health sud episode record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the behavioral health sud episode record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the behavioral health sud episode record.',
    `diagnosis_id` BIGINT COMMENT 'Unique identifier for the diagnosis within the behavioral health sud episode record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the icd code within the behavioral health sud episode record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the behavioral health sud episode record.',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the behavioral health sud episode record.',
    `part2_consent_workflow_part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent workflow part2 consent within the behavioral health sud episode record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the sud attending clinician within the behavioral health sud episode record.',
    `sud_clinician_id` BIGINT COMMENT 'Unique identifier for the sud clinician within the behavioral health sud episode record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the behavioral health sud episode record.',
    `age_of_first_use` STRING COMMENT 'The age of first use of the behavioral health sud episode record.',
    `asam_level_of_care` STRING COMMENT 'The asam level of care of the behavioral health sud episode record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the behavioral health sud episode record.',
    `confidentiality_level` STRING COMMENT 'The confidentiality level of the behavioral health sud episode record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the behavioral health sud episode record.',
    `diagnosis_icd10_code` STRING COMMENT 'The diagnosis icd10 code value classifying the behavioral health sud episode record.',
    `discharge_disposition` STRING COMMENT 'The discharge disposition of the behavioral health sud episode record.',
    `dsm5_diagnosis_code` STRING COMMENT 'The dsm5 diagnosis code value classifying the behavioral health sud episode record.',
    `episode_end_date` DATE COMMENT 'Timestamp capturing the episode end date associated with the behavioral health sud episode record.',
    `episode_start_date` DATE COMMENT 'Timestamp capturing the episode start date associated with the behavioral health sud episode record.',
    `episode_status` STRING COMMENT 'The episode status value classifying the behavioral health sud episode record.',
    `frequency_of_use` STRING COMMENT 'The frequency of use of the behavioral health sud episode record.',
    `level_of_care` STRING COMMENT 'The level of care of the behavioral health sud episode record.',
    `part2_consent_on_file` BOOLEAN COMMENT 'The part2 consent on file of the behavioral health sud episode record.',
    `part2_protected_flag` BOOLEAN COMMENT 'The part2 protected flag of the behavioral health sud episode record.',
    `primary_substance` STRING COMMENT 'The primary substance of the behavioral health sud episode record.',
    `referral_source` STRING COMMENT 'The referral source of the behavioral health sud episode record.',
    `relapse_flag` BOOLEAN COMMENT 'The relapse flag of the behavioral health sud episode record.',
    `route_of_administration` STRING COMMENT 'The route of administration of the behavioral health sud episode record.',
    `secondary_substance` STRING COMMENT 'The secondary substance of the behavioral health sud episode record.',
    `severity` STRING COMMENT 'The severity of the behavioral health sud episode record.',
    `substance_type` STRING COMMENT 'The substance type value classifying the behavioral health sud episode record.',
    `treatment_level_of_care` STRING COMMENT 'The treatment level of care of the behavioral health sud episode record.',
    `treatment_setting` STRING COMMENT 'The treatment setting of the behavioral health sud episode record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the behavioral health sud episode record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the behavioral health sud episode record.',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the behavioral health sud episode record.',
    CONSTRAINT pk_sud_episode PRIMARY KEY(`sud_episode_id`)
) COMMENT 'Substance use disorder episode of care';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` (
    `mat_treatment_id` BIGINT COMMENT 'Unique identifier for the mat treatment within the behavioral health mat treatment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the behavioral health mat treatment record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the behavioral health mat treatment record.',
    `drug_master_id` BIGINT COMMENT 'Unique identifier for the drug master within the behavioral health mat treatment record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the mat attending clinician within the behavioral health mat treatment record.',
    `mat_clinician_id` BIGINT COMMENT 'Unique identifier for the mat clinician within the behavioral health mat treatment record.',
    `mat_prescribing_clinician_id` BIGINT COMMENT 'Unique identifier for the mat prescribing clinician within the behavioral health mat treatment record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the behavioral health mat treatment record.',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the behavioral health mat treatment record.',
    `part2_consent_workflow_part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent workflow part2 consent within the behavioral health mat treatment record.',
    `prescription_id` BIGINT COMMENT 'Unique identifier for the prescription within the behavioral health mat treatment record.',
    `sud_episode_id` BIGINT COMMENT 'Unique identifier for the sud episode within the behavioral health mat treatment record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the behavioral health mat treatment record.',
    `adherence_rate` DECIMAL(18,2) COMMENT 'The adherence rate of the behavioral health mat treatment record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the behavioral health mat treatment record.',
    `confidentiality_level` STRING COMMENT 'The confidentiality level of the behavioral health mat treatment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the behavioral health mat treatment record.',
    `dea_x_waiver_flag` BOOLEAN COMMENT 'The dea x waiver flag of the behavioral health mat treatment record.',
    `dea_x_waiver_number` STRING COMMENT 'The dea x waiver number of the behavioral health mat treatment record.',
    `discontinuation_date` DATE COMMENT 'Timestamp capturing the discontinuation date associated with the behavioral health mat treatment record.',
    `dispensing_frequency` STRING COMMENT 'The dispensing frequency of the behavioral health mat treatment record.',
    `dose` STRING COMMENT 'The dose of the behavioral health mat treatment record.',
    `dose_amount` DECIMAL(18,2) COMMENT 'The dose amount of the behavioral health mat treatment record.',
    `dose_frequency` STRING COMMENT 'The dose frequency of the behavioral health mat treatment record.',
    `dose_unit` STRING COMMENT 'The dose unit of the behavioral health mat treatment record.',
    `dosing_frequency` STRING COMMENT 'The dosing frequency of the behavioral health mat treatment record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the behavioral health mat treatment record.',
    `frequency` STRING COMMENT 'The frequency of the behavioral health mat treatment record.',
    `induction_date` DATE COMMENT 'Timestamp capturing the induction date associated with the behavioral health mat treatment record.',
    `maintenance_start_date` DATE COMMENT 'Timestamp capturing the maintenance start date associated with the behavioral health mat treatment record.',
    `medication_name` STRING COMMENT 'The medication name of the behavioral health mat treatment record.',
    `medication_ndc` STRING COMMENT 'The medication ndc of the behavioral health mat treatment record.',
    `part2_protected_flag` BOOLEAN COMMENT 'The part2 protected flag of the behavioral health mat treatment record.',
    `prescriber_dea_number` STRING COMMENT 'The prescriber dea number of the behavioral health mat treatment record.',
    `route` STRING COMMENT 'The route of the behavioral health mat treatment record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the behavioral health mat treatment record.',
    `take_home_dose_flag` BOOLEAN COMMENT 'The take home dose flag of the behavioral health mat treatment record.',
    `taper_flag` BOOLEAN COMMENT 'The taper flag of the behavioral health mat treatment record.',
    `treatment_end_date` DATE COMMENT 'Timestamp capturing the treatment end date associated with the behavioral health mat treatment record.',
    `treatment_phase` STRING COMMENT 'The treatment phase of the behavioral health mat treatment record.',
    `treatment_start_date` DATE COMMENT 'Timestamp capturing the treatment start date associated with the behavioral health mat treatment record.',
    `treatment_status` STRING COMMENT 'The treatment status value classifying the behavioral health mat treatment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the behavioral health mat treatment record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the behavioral health mat treatment record.',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the behavioral health mat treatment record.',
    CONSTRAINT pk_mat_treatment PRIMARY KEY(`mat_treatment_id`)
) COMMENT 'Medication-assisted treatment (buprenorphine/methadone/naltrexone)';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` (
    `otp_enrollment_id` BIGINT COMMENT 'Unique identifier for the otp enrollment within the behavioral health otp enrollment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the behavioral health otp enrollment record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the behavioral health otp enrollment record.',
    `mat_treatment_id` BIGINT COMMENT 'Unique identifier for the mat treatment within the behavioral health otp enrollment record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the behavioral health otp enrollment record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the otp attending clinician within the behavioral health otp enrollment record.',
    `otp_clinician_id` BIGINT COMMENT 'Unique identifier for the otp clinician within the behavioral health otp enrollment record.',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the behavioral health otp enrollment record.',
    `part2_consent_workflow_part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent workflow part2 consent within the behavioral health otp enrollment record.',
    `sud_episode_id` BIGINT COMMENT 'Unique identifier for the sud episode within the behavioral health otp enrollment record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the behavioral health otp enrollment record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the behavioral health otp enrollment record.',
    `central_registry_reported_flag` BOOLEAN COMMENT 'The central registry reported flag of the behavioral health otp enrollment record.',
    `confidentiality_level` STRING COMMENT 'The confidentiality level of the behavioral health otp enrollment record.',
    `counseling_frequency` STRING COMMENT 'The counseling frequency of the behavioral health otp enrollment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the behavioral health otp enrollment record.',
    `dea_registration_number` STRING COMMENT 'The dea registration number of the behavioral health otp enrollment record.',
    `discharge_date` DATE COMMENT 'Timestamp capturing the discharge date associated with the behavioral health otp enrollment record.',
    `dosing_schedule` STRING COMMENT 'The dosing schedule of the behavioral health otp enrollment record.',
    `drug_screen_frequency` STRING COMMENT 'The drug screen frequency of the behavioral health otp enrollment record.',
    `enrollment_date` DATE COMMENT 'Timestamp capturing the enrollment date associated with the behavioral health otp enrollment record.',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the behavioral health otp enrollment record.',
    `guest_dosing_flag` BOOLEAN COMMENT 'The guest dosing flag of the behavioral health otp enrollment record.',
    `otp_program_name` STRING COMMENT 'The otp program name of the behavioral health otp enrollment record.',
    `part2_consent_on_file` BOOLEAN COMMENT 'The part2 consent on file of the behavioral health otp enrollment record.',
    `part2_protected_flag` BOOLEAN COMMENT 'The part2 protected flag of the behavioral health otp enrollment record.',
    `phase_level` STRING COMMENT 'The phase level of the behavioral health otp enrollment record.',
    `program_name` STRING COMMENT 'The program name of the behavioral health otp enrollment record.',
    `program_type` STRING COMMENT 'The program type value classifying the behavioral health otp enrollment record.',
    `samhsa_certification_number` STRING COMMENT 'The samhsa certification number of the behavioral health otp enrollment record.',
    `take_home_authorization_flag` BOOLEAN COMMENT 'The take home authorization flag of the behavioral health otp enrollment record.',
    `take_home_dose_eligibility_flag` BOOLEAN COMMENT 'The take home dose eligibility flag of the behavioral health otp enrollment record.',
    `take_home_dose_level` STRING COMMENT 'The take home dose level of the behavioral health otp enrollment record.',
    `take_home_doses_allowed` STRING COMMENT 'The take home doses allowed of the behavioral health otp enrollment record.',
    `take_home_privilege_level` STRING COMMENT 'The take home privilege level of the behavioral health otp enrollment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the behavioral health otp enrollment record.',
    `urine_drug_screen_frequency` STRING COMMENT 'The urine drug screen frequency of the behavioral health otp enrollment record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the behavioral health otp enrollment record.',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the behavioral health otp enrollment record.',
    CONSTRAINT pk_otp_enrollment PRIMARY KEY(`otp_enrollment_id`)
) COMMENT 'Opioid treatment program enrollment';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` (
    `crisis_episode_id` BIGINT COMMENT 'Unique identifier for the crisis episode within the behavioral health crisis episode record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the behavioral health crisis episode record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the crisis attending clinician within the behavioral health crisis episode record.',
    `crisis_clinician_id` BIGINT COMMENT 'Unique identifier for the crisis clinician within the behavioral health crisis episode record.',
    `crisis_responding_clinician_id` BIGINT COMMENT 'Unique identifier for the crisis responding clinician within the behavioral health crisis episode record.',
    `crisis_visit_id` BIGINT COMMENT 'Unique identifier for the crisis visit within the behavioral health crisis episode record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the behavioral health crisis episode record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the behavioral health crisis episode record.',
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the behavioral health crisis episode record.',
    `part2_consent_workflow_part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent workflow part2 consent within the behavioral health crisis episode record.',
    `psychiatric_assessment_id` BIGINT COMMENT 'Unique identifier for the psychiatric assessment within the behavioral health crisis episode record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the behavioral health crisis episode record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the behavioral health crisis episode record.',
    `confidentiality_level` STRING COMMENT 'The confidentiality level of the behavioral health crisis episode record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the behavioral health crisis episode record.',
    `crisis_end_timestamp` TIMESTAMP COMMENT 'The crisis end timestamp of the behavioral health crisis episode record.',
    `crisis_resolution_timestamp` TIMESTAMP COMMENT 'The crisis resolution timestamp of the behavioral health crisis episode record.',
    `crisis_severity` STRING COMMENT 'The crisis severity of the behavioral health crisis episode record.',
    `crisis_source` STRING COMMENT 'The crisis source of the behavioral health crisis episode record.',
    `crisis_start_timestamp` TIMESTAMP COMMENT 'The crisis start timestamp of the behavioral health crisis episode record.',
    `crisis_status` STRING COMMENT 'The crisis status value classifying the behavioral health crisis episode record.',
    `crisis_type` STRING COMMENT 'The crisis type value classifying the behavioral health crisis episode record.',
    `disposition` STRING COMMENT 'The disposition of the behavioral health crisis episode record.',
    `hold_type` STRING COMMENT 'The hold type value classifying the behavioral health crisis episode record.',
    `homicidal_ideation_flag` BOOLEAN COMMENT 'The homicidal ideation flag of the behavioral health crisis episode record.',
    `homicide_risk_flag` BOOLEAN COMMENT 'The homicide risk flag of the behavioral health crisis episode record.',
    `intervention_type` STRING COMMENT 'The intervention type value classifying the behavioral health crisis episode record.',
    `involuntary_flag` BOOLEAN COMMENT 'The involuntary flag of the behavioral health crisis episode record.',
    `involuntary_hold_flag` BOOLEAN COMMENT 'The involuntary hold flag of the behavioral health crisis episode record.',
    `law_enforcement_involved` BOOLEAN COMMENT 'The law enforcement involved of the behavioral health crisis episode record.',
    `law_enforcement_involved_flag` BOOLEAN COMMENT 'The law enforcement involved flag of the behavioral health crisis episode record.',
    `mobile_crisis_team_flag` BOOLEAN COMMENT 'The mobile crisis team flag of the behavioral health crisis episode record.',
    `part2_protected_flag` BOOLEAN COMMENT 'The part2 protected flag of the behavioral health crisis episode record.',
    `presenting_problem` STRING COMMENT 'The presenting problem of the behavioral health crisis episode record.',
    `psychosis_flag` BOOLEAN COMMENT 'The psychosis flag of the behavioral health crisis episode record.',
    `risk_assessment_score` STRING COMMENT 'The risk assessment score of the behavioral health crisis episode record.',
    `safety_plan_created_flag` BOOLEAN COMMENT 'The safety plan created flag of the behavioral health crisis episode record.',
    `severity_level` STRING COMMENT 'The severity level of the behavioral health crisis episode record.',
    `suicide_attempt_flag` BOOLEAN COMMENT 'The suicide attempt flag of the behavioral health crisis episode record.',
    `suicide_risk_flag` BOOLEAN COMMENT 'The suicide risk flag of the behavioral health crisis episode record.',
    `suicide_risk_level` STRING COMMENT 'The suicide risk level of the behavioral health crisis episode record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the behavioral health crisis episode record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the behavioral health crisis episode record.',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the behavioral health crisis episode record.',
    CONSTRAINT pk_crisis_episode PRIMARY KEY(`crisis_episode_id`)
) COMMENT 'Behavioral health crisis encounter';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` (
    `part2_consent_id` BIGINT COMMENT 'Unique identifier for the part2 consent within the behavioral health part2 consent record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the behavioral health part2 consent record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the behavioral health part2 consent record.',
    `form_template_id` BIGINT COMMENT 'Unique identifier for the form template within the behavioral health part2 consent record.',
    `care_plan_id` BIGINT COMMENT 'Unique identifier for the linked care plan within the behavioral health part2 consent record.',
    `diagnosis_id` BIGINT COMMENT 'Unique identifier for the linked diagnosis within the behavioral health part2 consent record.',
    `problem_id` BIGINT COMMENT 'Unique identifier for the linked problem within the behavioral health part2 consent record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the behavioral health part2 consent record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the part2 clinician within the behavioral health part2 consent record.',
    `part2_consenting_clinician_id` BIGINT COMMENT 'Unique identifier for the part2 consenting clinician within the behavioral health part2 consent record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the behavioral health part2 consent record.',
    `consent_record_substance_use_consent_id` BIGINT COMMENT 'Unique identifier for the consent record substance use consent within the behavioral health part2 consent record.',
    `treatment_consent_id` BIGINT COMMENT 'Unique identifier for the linked treatment consent within the behavioral health part2 consent record.',
    `substance_use_consent_id` BIGINT COMMENT 'Unique identifier for the substance use consent within the behavioral health part2 consent record.',
    `amount_of_disclosure` STRING COMMENT 'The amount of disclosure of the behavioral health part2 consent record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the behavioral health part2 consent record.',
    `cfr_part2_applicable_flag` BOOLEAN COMMENT 'The cfr part2 applicable flag of the behavioral health part2 consent record.',
    `confidentiality_level` STRING COMMENT 'The confidentiality level of the behavioral health part2 consent record.',
    `consent_date` DATE COMMENT 'Timestamp capturing the consent date associated with the behavioral health part2 consent record.',
    `consent_expiration_date` DATE COMMENT 'Timestamp capturing the consent expiration date associated with the behavioral health part2 consent record.',
    `consent_scope` STRING COMMENT 'The consent scope of the behavioral health part2 consent record.',
    `consent_signed_date` DATE COMMENT 'Timestamp capturing the consent signed date associated with the behavioral health part2 consent record.',
    `consent_status` STRING COMMENT 'The consent status value classifying the behavioral health part2 consent record.',
    `consent_type` STRING COMMENT 'The consent type value classifying the behavioral health part2 consent record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the behavioral health part2 consent record.',
    `data_types_disclosed` STRING COMMENT 'The data types disclosed of the behavioral health part2 consent record.',
    `disclosure_amount_limit` STRING COMMENT 'The disclosure amount limit of the behavioral health part2 consent record.',
    `disclosure_purpose` STRING COMMENT 'The disclosure purpose of the behavioral health part2 consent record.',
    `disclosure_recipient_name` STRING COMMENT 'The disclosure recipient name of the behavioral health part2 consent record.',
    `disclosure_recipient_organization` STRING COMMENT 'The disclosure recipient organization of the behavioral health part2 consent record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the behavioral health part2 consent record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the behavioral health part2 consent record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the behavioral health part2 consent record.',
    `information_disclosed_description` STRING COMMENT 'The information disclosed description of the behavioral health part2 consent record.',
    `information_to_be_disclosed` STRING COMMENT 'The information to be disclosed of the behavioral health part2 consent record.',
    `obtained_by_role` STRING COMMENT 'The obtained by role of the behavioral health part2 consent record.',
    `part2_program_flag` BOOLEAN COMMENT 'The part2 program flag of the behavioral health part2 consent record.',
    `part2_protected_flag` BOOLEAN COMMENT 'The part2 protected flag of the behavioral health part2 consent record.',
    `patient_signature_present_flag` BOOLEAN COMMENT 'The patient signature present flag of the behavioral health part2 consent record.',
    `patient_signature_timestamp` TIMESTAMP COMMENT 'The patient signature timestamp of the behavioral health part2 consent record.',
    `purpose_of_disclosure` STRING COMMENT 'The purpose of disclosure of the behavioral health part2 consent record.',
    `recipient_name` STRING COMMENT 'The recipient name of the behavioral health part2 consent record.',
    `recipient_organization` STRING COMMENT 'The recipient organization of the behavioral health part2 consent record.',
    `redisclosure_prohibited_flag` BOOLEAN COMMENT 'The redisclosure prohibited flag of the behavioral health part2 consent record.',
    `redisclosure_prohibition_flag` BOOLEAN COMMENT 'The redisclosure prohibition flag of the behavioral health part2 consent record.',
    `regulation` STRING COMMENT 'The regulation of the behavioral health part2 consent record.',
    `regulation_reference` STRING COMMENT 'The regulation reference of the behavioral health part2 consent record.',
    `revocation_date` DATE COMMENT 'Timestamp capturing the revocation date associated with the behavioral health part2 consent record.',
    `revocation_method` STRING COMMENT 'The revocation method of the behavioral health part2 consent record.',
    `revocation_reason` STRING COMMENT 'The revocation reason of the behavioral health part2 consent record.',
    `revoked_flag` BOOLEAN COMMENT 'The revoked flag of the behavioral health part2 consent record.',
    `revoked_timestamp` TIMESTAMP COMMENT 'The revoked timestamp of the behavioral health part2 consent record.',
    `scope_of_disclosure` STRING COMMENT 'The scope of disclosure of the behavioral health part2 consent record.',
    `segmented_data_flag` BOOLEAN COMMENT 'The segmented data flag of the behavioral health part2 consent record.',
    `signature_method` STRING COMMENT 'The signature method of the behavioral health part2 consent record.',
    `signed_by_patient` BOOLEAN COMMENT 'The signed by patient of the behavioral health part2 consent record.',
    `signed_timestamp` TIMESTAMP COMMENT 'The signed timestamp of the behavioral health part2 consent record.',
    `signer_name` STRING COMMENT 'The signer name of the behavioral health part2 consent record.',
    `signer_relationship` STRING COMMENT 'The signer relationship of the behavioral health part2 consent record.',
    `source_record_reference` BIGINT COMMENT 'The source record reference of the behavioral health part2 consent record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the behavioral health part2 consent record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the behavioral health part2 consent record.',
    `vibe_batch_marker` STRING COMMENT 'The vibe batch marker of the behavioral health part2 consent record.',
    `witness_name` STRING COMMENT 'The witness name of the behavioral health part2 consent record.',
    `workflow_reference` BIGINT COMMENT 'The workflow reference of the behavioral health part2 consent record.',
    CONSTRAINT pk_part2_consent PRIMARY KEY(`part2_consent_id`)
) COMMENT '42 CFR Part 2 disclosure consent linking to clinical treatment';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_sud_episode_id` FOREIGN KEY (`sud_episode_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`sud_episode`(`sud_episode_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_mat_treatment_id` FOREIGN KEY (`mat_treatment_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment`(`mat_treatment_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_sud_episode_id` FOREIGN KEY (`sud_episode_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`sud_episode`(`sud_episode_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_psychiatric_assessment_id` FOREIGN KEY (`psychiatric_assessment_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment`(`psychiatric_assessment_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`behavioral_health` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`behavioral_health` SET TAGS ('pii_domain' = 'behavioral_health');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` SET TAGS ('pii_subdomain' = 'clinical_treatment');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `demographics_id` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `observation_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `clinician_notes` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_behavior_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_behavior_score` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_ideation_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_ideation_score` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_ideation_score` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_ideation_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_ideation_score` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_ideation_score` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_ideation_score` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_ideation_score` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_ideation_score` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_risk_level` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `gad7_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `instrument_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `instrument_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `instrument_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `instrument_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `instrument_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `instrument_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `phq9_item9_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `phq9_item9_score` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `phq9_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_plan` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_plan` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_plan` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_plan` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_plan` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_plan` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_plan` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` SET TAGS ('pii_subdomain' = 'clinical_treatment');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `demographics_id` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_icd10_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_icd10_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_icd10_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_icd10_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_icd10_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_icd10_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_icd10_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_icd10_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `diagnosis_icd10_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `substance_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_level_of_care` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_level_of_care` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_level_of_care` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_level_of_care` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_level_of_care` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_level_of_care` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_level_of_care` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_level_of_care` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_level_of_care` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` SET TAGS ('pii_subdomain' = 'clinical_treatment');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `demographics_id` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dea_x_waiver_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_amount` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_amount` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_amount` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_amount` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_amount` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_amount` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_frequency` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_unit` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_unit` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_unit` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_unit` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_unit` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_unit` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dose_unit` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_ndc` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_ndc` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_ndc` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_ndc` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_ndc` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_ndc` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_ndc` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_dea_number` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_dea_number` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_dea_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_dea_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_dea_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_dea_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_dea_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_dea_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_dea_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `take_home_dose_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `take_home_dose_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `take_home_dose_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `take_home_dose_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `take_home_dose_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `take_home_dose_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `take_home_dose_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_end_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_end_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_end_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_end_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_end_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_end_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_end_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_end_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_start_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_start_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` SET TAGS ('pii_subdomain' = 'program_consent');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mat_treatment_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `otp_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `otp_program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `otp_program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `otp_program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `otp_program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `otp_program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_eligibility_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_eligibility_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_eligibility_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_eligibility_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_eligibility_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_eligibility_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_eligibility_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_level` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_level` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_level` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_level` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_level` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_level` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_level` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_level` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_dose_level` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_doses_allowed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_doses_allowed` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_doses_allowed` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_doses_allowed` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_doses_allowed` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_doses_allowed` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `take_home_doses_allowed` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` SET TAGS ('pii_subdomain' = 'clinical_treatment');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `demographics_id` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `crisis_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `homicidal_ideation_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `homicidal_ideation_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `homicidal_ideation_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `homicidal_ideation_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `homicidal_ideation_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `homicidal_ideation_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `homicidal_ideation_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `mobile_crisis_team_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `mobile_crisis_team_flag` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `mobile_crisis_team_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `mobile_crisis_team_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `mobile_crisis_team_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `mobile_crisis_team_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `mobile_crisis_team_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_problem` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_problem` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_problem` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_problem` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_problem` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_problem` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_problem` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_problem` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `severity_level` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `suicide_risk_level` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` SET TAGS ('pii_subdomain' = 'program_consent');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `demographics_id` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `problem_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `problem_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `problem_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `problem_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `problem_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `problem_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `problem_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `part2_consenting_clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `part2_consenting_clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `part2_consenting_clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `part2_consenting_clinician_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `part2_consenting_clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `part2_consenting_clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `part2_consenting_clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `amount_of_disclosure` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `amount_of_disclosure` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `cfr_part2_applicable_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `consent_scope` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `consent_scope` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `disclosure_recipient_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `disclosure_recipient_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `disclosure_recipient_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `disclosure_recipient_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `disclosure_recipient_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `disclosure_recipient_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `disclosure_recipient_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `disclosure_recipient_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `part2_protected_flag` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `recipient_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `recipient_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `recipient_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `recipient_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `recipient_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `recipient_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `recipient_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `recipient_organization` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `recipient_organization` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `redisclosure_prohibition_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `redisclosure_prohibition_flag` SET TAGS ('pii_42cfr_part2' = 'protected');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `signer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `signer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `signer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `signer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `signer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `signer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `signer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `witness_name` SET TAGS ('pii_mask_non_prod' = 'true');
